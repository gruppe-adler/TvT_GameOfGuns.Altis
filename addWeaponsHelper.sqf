/*  Manually executed to help with adding weapons to the config
*
*/

doit = false;
sleep 1.5;

player sideChat "addWeaponsHelper now running.";
doit = true;

newWeapons = [];
newHandguns = [];
newScopes = [];
newHGScopes = [];

while {doit} do {
  _primaryWeapon = primaryWeapon player;
  _handgun = handgunWeapon player;
  _scope = (primaryWeaponItems player) select 2;
  _hgScope = (handgunItems player) select 2;

  if (_primaryWeapon != "" && newWeapons find _primaryWeapon == -1) then {
    newWeapons pushBack _primaryWeapon;
  };

  if (_handgun != "" && newHandguns find _handgun == -1) then {
    newHandguns pushBack _handgun;
  };

  if (_scope != "" && newScopes find _scope == -1) then {
    newScopes pushBack _scope;
  };

  if (_hgScope != "" && newHGScopes find _hgScope == -1) then {
    newHGScopes pushBack _hgScope;
  };

  sleep 0.5;
};
