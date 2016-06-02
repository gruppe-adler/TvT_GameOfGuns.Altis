/*  Chooses weapons and weapon attachments
*
*   executed via init.sqf on server
*/

waitUntil {!isNil "KILLSFORWIN"};
call compile preprocessFileLineNumbers "weaponConfig.sqf";

private ["_allMuzzleItems","_scope"];

CHOSENWEAPONS = [];
MUZZLEITEMS = [];
SCOPES = [];

// CALCULATE NUMBER OF WEAPONS =================================================
_weaponsNeeded = KILLSFORWIN + 1;
_weaponsPerTier = ceil (_weaponsNeeded / numberOfTiers);
diag_log format ["chooseWeapons.sqf - %1 weapons total needed. %2 per tier.", _weaponsNeeded, _weaponsPerTier];

// CHOOSE WEAPONS ==============================================================
_currentTier = 1;
_tierWeaponsNeeded = _weaponsPerTier;
while {_currentTier <= numberOfTiers} do {

  _selectWeapon = compile (format ["selectrandom weaponstier_%1",_currentTier]);
  while {_tierWeaponsNeeded > 0} do {
    _weapon = call _selectWeapon;
    CHOSENWEAPONS pushBack _weapon;
    _tierWeaponsNeeded = _tierWeaponsNeeded - 1;
  };

  _currentTier = _currentTier + 1;
  _tierWeaponsNeeded = _weaponsPerTier;
};

// CHOOSE MUZZLE ATTACHMENTS ===================================================
{
  if (random 100 <= MUZZLEATTACHMENTPROB) then {
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
      diag_log format ["chooseWeapons.sqf - No muzzle items found for weapon %1.",_x];
      MUZZLEITEMS pushBack "EMPTY";
    } else {
      _muzzleItem = selectRandom _allMuzzleItems;
      MUZZLEITEMS pushBack _muzzleItem;
    };
  } else {
    MUZZLEITEMS pushBack "EMPTY";
  };
} forEach CHOSENWEAPONS;


// CHOOSE SCOPES ===============================================================
_currentTier = 1;
_tierScopesNeeded = _weaponsPerTier;
{
  if (random 100 <= SCOPESPROP) then {
    _weapon = _x;
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
      diag_log format ["chooseWeapons.sqf - No compatible scopes found for weapon %1.", _x];
      SCOPES pushBack "EMPTY";
    } else {
      _scopeFound = false;
      for [{_i=0}, {_i<10}, {_i=_i+1}] do {
        _scope = selectRandom _compatibleScopes;
        _scopeFound = [_scope] call compile format ["params ['_scope']; if (_scope in scopestier_%1) then {true} else {false};", _currentTier];
        if (_scopeFound) exitWith {};
      };
      if (_scopeFound) then {
        SCOPES pushBack _scope;
      } else {
        SCOPES pushBack "EMPTY";
      };
    };
  } else {
    SCOPES pushBack "EMPTY";
  };
  _tierScopesNeeded = _tierScopesNeeded - 1;

  if (_tierScopesNeeded <= 0) then {
    _currentTier = _currentTier + 1;
    _tierScopesNeeded = _weaponsPerTier;
  };
} forEach CHOSENWEAPONS;


publicVariable "CHOSENWEAPONS";
publicVariable "MUZZLEITEMS";
publicVariable "SCOPES";
diag_log format ["chooseWeapons.sqf - %1 weapons selected.", (count CHOSENWEAPONS)];
