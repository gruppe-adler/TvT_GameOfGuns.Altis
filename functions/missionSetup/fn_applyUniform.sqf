#include "component.hpp"

if (!hasInterface) exitWith {};

private _teamNamespace = player getVariable [QGVAR(teamNamespace),objNull];
private _uniform = _teamNamespace getVariable [QGVAR(teamUniform),""];
private _isWoodLand = toLower ([missionConfigFile >> "CfgIslands" >> worldName,"isWoodland",1] call BIS_fnc_returnConfigEntry) == "true";
private _vest = ["V_TacVest_khk","V_TacVest_oli"] select _isWoodland;
private _radio = player getVariable [QGVAR(radioInstance),"TFAR_anprc152"];

player setUnitLoadout [[],[],[],[_uniform,[["ACE_fieldDressing",6],["ACE_morphine",4]]],[_vest,[]],[],"","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS",_radio,"ItemCompass","ItemWatch",""]];
