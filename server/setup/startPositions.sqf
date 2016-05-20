waitUntil {!isNil "TEAMSETUPDONE"};
waitUntil {TEAMSETUPDONE};

diag_log "startPositions.sqf starting...";

private ["_teamleadpos", "_memberpos"];

STARTPOSITIONS = [];
{
  diag_log format ["startPositions.sqf - Finding start positions for %1's team.", name _x];

	//Position for teamleader
	_repetitions = 0;
	_tooCloseFound = true;
	while {_tooCloseFound} do {

		//find position that is not over water
		_isWater = true;
		while {_isWater} do {
			_teamleadpos = [PLAYAREACENTER, [0, PLAYAREASIZE], [0,360], 1] call SHK_pos;
			_isWater = surfaceIsWater _teamleadpos;
		};

		//make sure position is at least SPAWNGROUPMINDIST away from other positions
		_tooCloseFound = false;
		{
			if ((_x distance2D _teamleadpos) < SPAWNGROUPMINDIST) exitWith {_tooCloseFound = true; diag_log format ["startPositions.sqf - Start position for %1 to close to other position. Repeating.", name _x]};
		} forEach STARTPOSITIONS;

		//unless this has been repeated too often -> use position anyway
		if (_repetitions >= 10) then {
			_tooCloseFound = false;
		};

		_repetitions = _repetitions +1;
	};
  _x setVariable ["spawnpos", _teamleadpos, true];

	for [{_i = 0},{_i < (count (units group _x))},{_i = _i + 1}] do {
    _isWater = true;
    while {_isWater} do {
      _memberpos = [_teamleadpos, [0, STARTDISTTOLEADER], [0,360], 1] call SHK_pos;
      _isWater = surfaceIsWater _memberpos;
    };

		_unit = (units group _x) select _i;
		_unit setVariable ["spawnpos", _memberpos, true];
		sleep 0.1;
	};
} forEach TEAMLEADERS;

sleep 2;
STARTPOSDONE = true;
publicVariable "STARTPOSDONE";
