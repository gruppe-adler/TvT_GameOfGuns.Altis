#include "component.hpp"

#include "..\..\dialog\upgradeWeaponTitle\defines.hpp"

params ["_dialog"];

private _teamNamespace = player getVariable [QEGVAR(missionSetup,teamNamespace),objNull];
private _score = _teamNamespace getVariable [QEGVAR(missionSetup,currentScore),0];

private _weapon = EGVAR(missionSetup,chosenWeapons) param [_score,""];

//weapon text
private _displayName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
private _text = format ["(%1/%2) %3",_score+1, EGVAR(missionSetup,killsForWin), _displayName];
(_dialog displayCtrl UPGRADEWEAPON_TEXT) ctrlSetText _text;

//weapon picture
private _picturePath = getText (configFile >> "CfgWeapons" >> _weapon >> "picture");
(_dialog displayCtrl UPGRADEWEAPON_PIC) ctrlSetText _picturePath;
