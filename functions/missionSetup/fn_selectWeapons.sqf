#include "component.hpp"

if (!isServer) exitWith {};

private ["_allMuzzleItems","_scope"];

GVAR(killsForWin) = "KillsForWin" call BIS_fnc_getParamValue;
call compile preprocessFileLineNumbers "weaponConfig.sqf";

GVAR(chosenWeapons) = [];
GVAR(muzzleItems) = [];
GVAR(scopes) = [];

// CALCULATE NUMBER OF WEAPONS =================================================
private _weaponsNeeded = GVAR(killsForWin);
private _weaponsPerTier = ceil (_weaponsNeeded / numberOfTiers);


// CHOOSE WEAPONS ==============================================================
private _currentTier = 1;
private _tierWeaponsNeeded = _weaponsPerTier;
while {_currentTier <= numberOfTiers} do {

    while {_tierWeaponsNeeded > 0} do {
        _countWeapons = {call compile format ["count weaponstier_%1", _currentTier]};
        _weaponsLeft = [] call _countWeapons;
        _randomID = round (random (_weaponsLeft-1));
        _weapon = call compile format ["_selected = weaponstier_%1 select %2; weaponstier_%1 deleteAt %2; _selected", _currentTier, _randomID];
        if ([] call _countWeapons == 0) then {
            call compile preprocessFileLineNumbers "weaponConfig.sqf";
        };

        GVAR(chosenWeapons) pushBack _weapon;
        _tierWeaponsNeeded = _tierWeaponsNeeded - 1;
    };

    _currentTier = _currentTier + 1;
    _tierWeaponsNeeded = _weaponsPerTier;
};

// CHOOSE MUZZLE ATTACHMENTS ===================================================
private _muzzleAttachmentProb = [missionConfigFile >> "cfgMission","muzzleAttachmentProbability",40] call BIS_fnc_returnConfigEntry;
{
    if (random 100 <= _muzzleAttachmentProb) then {
        _weapon = _x;
        _cfg = (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
        _allMuzzleItems = getArray _cfg;

        //RHS is stupid
        if (count _allMuzzleItems == 0) then {
            _attributes = configProperties [_cfg, "true", true];
            {
                _str = str (_x);
                _strArray = _str splitString "/";
                _attachmentName = _strArray select ((count _strArray) - 1);
                if ((getNumber (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems" >> _attachmentName)) == 1) then {
                    _allMuzzleItems pushBack _attachmentName;
                };
            } forEach _attributes;
        };

        if (count _allMuzzleItems == 0) then {
            GVAR(muzzleItems) pushBack "EMPTY";
        } else {
            _muzzleItem = selectRandom _allMuzzleItems;
            GVAR(muzzleItems) pushBack _muzzleItem;
        };

    } else {
        GVAR(muzzleItems) pushBack "EMPTY";
    };
} forEach GVAR(chosenWeapons);


// CHOOSE GVAR(scopes) ===============================================================
private _currentTier = 1;
private _tierScopesNeeded = _weaponsPerTier;
private _scopesProb = [missionConfigFile >> "cfgMission","scopesProbability",60] call BIS_fnc_returnConfigEntry;
{
    _weapon = _x;
    _probability = _scopesProb;

    //check if sniper
    _isSniper = true;
    _fireModes = getArray (configFile >> "CfgWeapons" >> _weapon >> "modes");
    if (_fireModes find "FullAuto" != -1) then {_isSniper = false};
    if (_fireModes find "Burst" != -1) then {_isSniper = false};
    if (_fireModes find "Single" == -1) then {_isSniper = false};
    if (count _fireModes <= 1) then {_isSniper = false};
    if (_isSniper) then {
        _probability = 100;
    };



    if (random 100 <= _probability) then {

        _cfg = (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
        _attributes = configProperties [_cfg, "true", true];
        _compatibleScopes = [];

        {
            _str = str (_x);
            _strArray = _str splitString "/";
            _scopeName = _strArray select ((count _strArray) -1);
            _compatibleScopes pushBack _scopeName;
        } forEach _attributes;

        if (count _compatibleScopes == 0) then {
            _compatibleScopes = getArray (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
        };

        if (count _compatibleScopes > 0) then {
            _scopeFound = false;

            for [{_i=0}, {_i<50}, {_i=_i+1}] do {
                _randomID = round (random ((count _compatibleScopes) - 1));
                _scope = _compatibleScopes select _randomID;
                if (_isSniper) then {
                    _scopeFound = [_scope] call compile format ["params ['_scope']; if (_scope in sniperscopes_0) then {true} else {false};"];
                } else {
                    _scopeFound = [_scope] call compile format ["params ['_scope']; if (_scope in scopestier_%1) then {true} else {false};", _currentTier];
                };

                if (_scopeFound) exitWith {};

                _compatibleScopes deleteAt _randomID;
            };

            if (_scopeFound) then {GVAR(scopes) pushBack _scope} else {GVAR(scopes) pushBack "EMPTY"};
        } else {
            GVAR(scopes) pushBack "EMPTY";
        };

    } else {
        GVAR(scopes) pushBack "EMPTY";
    };

    _tierScopesNeeded = _tierScopesNeeded - 1;

    if (_tierScopesNeeded <= 0) then {
        _currentTier = _currentTier + 1;
        _tierScopesNeeded = _weaponsPerTier;
    };
} forEach GVAR(chosenWeapons);

//GAME MODE ====================================================================
switch ("GameMode" call BIS_fnc_getParamValue) do {
    case 0: {};
    case 1: {
        reverse GVAR(chosenWeapons);
        reverse GVAR(muzzleItems);
        reverse GVAR(scopes);
    };
    case 2: {
        [GVAR(chosenWeapons), GVAR(muzzleItems), GVAR(scopes)] call mcd_fnc_randomizeArrays;
    };
};

//BROADCAST ====================================================================
publicVariable QGVAR(chosenWeapons);
publicVariable QGVAR(muzzleItems);
publicVariable QGVAR(scopes);

//LOG ==========================================================================
INFO("Weapons selected:");
{
    _muzzle = GVAR(muzzleItems) param [_forEachIndex,""];
    _scope = GVAR(scopes) param [_forEachIndex,""];
    INFO_3("%1, %2, %3",_x,_muzzle,_scope);
} forEach GVAR(chosenWeapons);
