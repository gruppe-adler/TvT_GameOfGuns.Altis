params ["_respawnUnit","_teammateUIDs"];

_aliveTeammates = [];
{
  _unit = [_x] call BIS_fnc_getUnitByUid;
  if (alive _unit) then {
    _aliveTeammates pushBack _unit;
  };
} forEach _teammateUIDs;

_randomUnit = selectRandom _aliveTeammates;
_spawnpos = [];
while {str _spawnpos == "[]"} do {
  _randomUnitPos = getPos _randomUnit;
  _spawnpos = _randomUnitPos findEmptyPosition [SPAWNDISTTOLEADER select 0, (random 1) * (SPAWNDISTTOLEADER select 1)];
  /*_spawnpos = [_randomUnitPos, SPAWNDISTTOLEADER, [0,360], 0] call SHK_pos;*/
};

_respawnUnit setVariable ["spawnpos", _spawnpos, true];
