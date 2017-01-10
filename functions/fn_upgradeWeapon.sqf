/*  Gives player the correct weapon
*
*   Params:
*   0:  name of group (used for score)
*   1:  score of group
*/

params ["_score"];
private ["_weapon","_magazine"];

//player won ===================================================================
if (_score >= KILLSFORWIN) exitWith {
  {player removeWeapon _x} forEach weapons player;
  {player removeMagazine _x} forEach magazines player;
};


//player hasnt won yet =========================================================
//get weapon
_weapon = CHOSENWEAPONS select _score;
_muzzleItem = MUZZLEITEMS select _score;
_scope = SCOPES select _score;

//get magazine
_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
_isBlank = true;
while {_isBlank} do {
    _magazine = selectRandom _magazines;
    _isBlank = ([configFile >> "CfgMagazines" >> _magazine >> "initSpeed", "number", 900] call CBA_fnc_getConfigEntry) < 15;
};

//remove old weapon and magazines
{player removeWeapon _x} forEach weapons player;
{player removeMagazine _x} forEach magazines player;

//add weapon and attachments
player addMagazine _magazine;
player addWeapon _weapon;
player addMagazines [_magazine, 6];
if (primaryWeapon player == "") then {
  if (_muzzleItem != "EMPTY") then {
    player addHandgunItem _muzzleItem;
  };
  if (_scope != "EMPTY") then {
    player addHandgunItem _scope;
  };
} else {
  if (_muzzleItem != "EMPTY") then {
    player addPrimaryWeaponItem _muzzleItem;
  };
  if (_scope != "EMPTY") then {
    player addPrimaryWeaponItem _scope;
  };
};

//update current score
if (currentScore > _score) then {
  hint "TEAMKILLER!";
};
currentScore = _score;

//call dialog
_layer = (["wait1Layer"] call BIS_fnc_rscLayer);
_layer cutRsc ["upgradeWeaponTitle", "PLAIN", 0.0001, true];

diag_log format ["fnc_upgradeWeapon - Upgraded weapon to %1 with %2 muzzle attachment.", _weapon, _muzzleItem];
