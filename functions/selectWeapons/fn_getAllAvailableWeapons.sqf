#include "component.hpp"

private _allPlayerOwnedDlcs = missionNamespace getVariable [QGVAR(allPlayerOwnedDlcsIntersect),[]];

private _allCfgWeapons = "(getNumber (_x >> 'scope')) == 2" configClasses (configFile >> "cfgWeapons");

private _allAvailableRifles = [];
private _allAvailablePistols = [];

private _weaponBlacklist = [missionConfigFile >> "cfgMission","weaponBlacklist",[]] call BIS_fnc_returnConfigEntry;

{
    if (
        [_x] call FUNC(weaponInOwnedDlcs) &&
        {!(_x in _weaponBlacklist)} &&
        {[_x] call FUNC(hasDamagingDefaultMag)}
    ) then {
        _baseWeapon = [configFile >> "cfgWeapons" >> _x,"baseWeapon",_x] call BIS_fnc_returnConfigEntry;
        if (_baseWeapon isKindOf ["Rifle",configFile >> "cfgWeapons"]) then {
            _allAvailableRifles pushBackUnique _x;
        };
        if (_baseWeapon isKindOf ["Pistol",configFile >> "cfgWeapons"]) then {
            _allAvailablePistols pushBackUnique _x;
        };
    };
} forEach (_allCfgWeapons apply {configName _x});

[_allAvailableRifles,_allAvailablePistols]
