#include "component.hpp"

params [["_weaponClass",""]];

private _defaultMag = ([configFile >> "cfgWeapons" >> _weaponClass,"magazines",[]] call BIS_fnc_returnConfigEntry) param [0,""];
if (_defaultMag == "") exitWith {false};

private _ammo = [configFile >> "cfgMagazines" >> _defaultMag,"ammo",""] call BIS_fnc_returnConfigEntry;
if (_ammo == "") exitWith {false};

if (_ammo isKindOf ["FlareCore",configFile >> "cfgAmmo"]) exitWith {false};

if (_ammo isKindOf ["GrenadeCore",configFile >> "cfgAmmo"]) exitWith {
    ([configFile >> "cfgAmmo" >> _ammo,"dangerRadiusHit",-1] call BIS_fnc_returnConfigEntry) <= 0
};

private _fnc_checkBullet = {
    (_ammo isKindOf ["BulletCore",configFile >> "cfgAmmo"]) &&
    (([configfile >> "CfgAmmo" >> _ammo,"hit",0] call BIS_fnc_returnConfigEntry) > 0)
};

private _isDamaging = ([configFile >> "CfgMagazines" >> _defaultMag >> "initSpeed", "number", 900] call CBA_fnc_getConfigEntry) > 15;
if (_isDamaging) then {
    _isDamaging = [] call _fnc_checkBullet;
};

if (!_isDamaging) then {
    private _subMunition = ([configfile >> "CfgAmmo" >> _ammo,"submunitionAmmo",[]] call BIS_fnc_returnConfigEntry) param [0,""];
    if (_subMunition != "") then {
        _ammo = _subMunition;
    };
    _isDamaging = [] call _fnc_checkBullet;
};

_isDamaging
