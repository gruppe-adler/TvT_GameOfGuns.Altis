params ["_respawnUnit","_teammateUIDs"];

_aliveTeammates = [];
{
  _unit = [_x] call BIS_fnc_getUnitByUid;
  if (alive _unit) then {
    _aliveTeammates pushBack _unit;
  };
} forEach _teammateUIDs;

_currentLeader = leader (group (_aliveTeammates select 0));
_leaderPos = getPos _currentLeader;
_spawnpos = [_currentLeader, SPAWNDISTTOLEADER, [0,360], 1] call SHK_pos;

_respawnUnit setVariable ["spawnpos", _spawnpos, true];
