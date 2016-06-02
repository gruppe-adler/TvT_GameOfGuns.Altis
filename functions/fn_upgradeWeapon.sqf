/*  Gives player the correct weapon
*
*   Params:
*   0:  name of group (used for score)
*   1:  score of group
*/

params ["_groupname", "_score"];
private ["_weapon"];


//make sure score is not more than available weapons
if (_score > (count CHOSENWEAPONS) - 1) then {
  _score = (count CHOSENWEAPONS) - 1;
};

//get weapon
_weapon = CHOSENWEAPONS select _score;
_muzzleItem = MUZZLEITEMS select _score;
_scope = SCOPES select _score;

//get magazine
_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
_magazine = selectRandom _magazines;

//add weapon and attachments
removeAllWeapons player;
player addMagazines [_magazine, 6];
player addWeapon _weapon;
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

diag_log format ["fnc_upgradeWeapon - Upgraded weapon to %1 with %2 muzzle attachment.", _weapon, _muzzleItem];
