/*  Chooses weapons and weapon attachments
*
*   executed via init.sqf on server
*/

waitUntil {!isNil "KILLSFORWIN"};
call compile preprocessFileLineNumbers "weaponConfig.sqf";

private ["_allMuzzleItems"];

CHOSENWEAPONS = [];
MUZZLEITEMS = [];

// CALCULATE NUMBER OF WEAPONS =================================================
_weaponsNeeded = KILLSFORWIN + 1;
_weaponsPerTier = ceil (_weaponsNeeded / numberOfTiers);
diag_log format ["chooseWeapons.sqf - %1 weapons total needed. %2 per tier.", _weaponsNeeded, _weaponsPerTier];

// CHOOSE WEAPONS ==============================================================
_currentTier = 1;
_tierWeaponsNeeded = _weaponsPerTier;
_done = false;
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
    _cfg = (configFile >> "CfgWeapons" >> _x >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
    _allMuzzleItems = getArray _cfg;

    //RHS is stupid
    if (count _allMuzzleItems == 0) then {
      _weapon = _x;
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


publicVariable "CHOSENWEAPONS";
publicVariable "MUZZLEITEMS";
diag_log format ["chooseWeapons.sqf - %1 weapons selected.", (count CHOSENWEAPONS)];
