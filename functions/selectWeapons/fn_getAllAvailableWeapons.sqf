#include "component.hpp"

private _allPlayerOwnedDlcs = missionNamespace getVariable [QGVAR(allPlayerOwnedDlcsIntersect),[]];

private _allCfgWeapons = "(getNumber (_x >> 'scope')) == 2" configClasses (configFile >> "cfgWeapons");

private _allAvailableRifles = [];
private _allAvailablePistols = [];

{
    if (
        [_x] call FUNC(weaponInOwnedDlcs)
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
