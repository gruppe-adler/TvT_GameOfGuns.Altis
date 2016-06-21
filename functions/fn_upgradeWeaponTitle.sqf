params ["_dialog"];

_groupname = player getVariable "groupname";
_score = call compile _groupname;
_weapon = CHOSENWEAPONS select _score;

//weapon text
_displayName = getText (configFile >> "CfgWeapons" >> _weapon >> "displayName");
_text = format ["(%1/%2) %3",_score+1, KILLSFORWIN, _displayName];
(_dialog displayCtrl 1503) ctrlSetText _text;

//weapon picture
_picturePath = getText (configFile >> "CfgWeapons" >> _weapon >> "picture");
(_dialog displayCtrl 1502) ctrlSetText _picturePath;
