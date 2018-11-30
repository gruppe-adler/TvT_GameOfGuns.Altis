#include "component.hpp"

if (!hasInterface) exitWith {};

private _teamNamespace = player getVariable [QGVAR(teamNamespace),objNull];
private _uniform = _teamNamespace getVariable [QGVAR(teamUniform),""];
private _isWoodLand = toLower ([missionConfigFile >> "CfgIslands" >> worldName,"isWoodland",1] call BIS_fnc_returnConfigEntry) == "true";
private _vest = ["V_TacVest_khk","V_TacVest_oli"] select _isWoodland;

removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

player forceAddUniform _uniform;
[{uniform player != ""},{
    for "_i" from 1 to 6 do {player addItemToUniform "ACE_fieldDressing";};
    for "_i" from 1 to 4 do {player addItemToUniform "ACE_morphine";};
},[],3,{}] call CBA_fnc_waitUntilAndExecute;

player addVest _vest;

player addWeapon "Binocular";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "tf_anprc152";
player linkItem "ItemGPS";
