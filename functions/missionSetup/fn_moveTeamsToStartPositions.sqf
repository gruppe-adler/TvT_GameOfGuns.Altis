#include "component.hpp"

private _spawnGroupsMinDist = [missionConfigFile >> "cfgMission","spawnGroupMinDist",50] call BIS_fnc_returnConfigEntry;
private _startPositions = [];

{
	//Position for teamleader
	_repetitions = 0;
	_tooCloseFound = true;
    _teamLeadPos = GVAR(playAreaCenter);

	while {_tooCloseFound} do {

		//find position that is not over water
		_isWater = true;
		for [{_i=0}, {_i<100}, {_i = _i + 1}] do {
			_teamleadpos = [GVAR(playAreaCenter),[0,GVAR(playAreaSize) - 25],[0,360]] call EFUNC(common,randomPos);
			_isWater = surfaceIsWater _teamleadpos;
            if (!_isWater) exitWith {};
		};

        if (_isWater) then {INFO_2("Server found only water positions in 100 cycles around %1 with a searchradius of %2.",GVAR(playAreaCenter),GVAR(playAreaSize) - 25)};

		//make sure position is at least SPAWNGROUPMINDIST away from other positions
		_tooCloseFound = false;
		{
			if ((_x distance2D _teamleadpos) < _spawnGroupsMinDist) exitWith {_tooCloseFound = true; INFO_1("Start position for %1 to close to other position. Repeating.", name _x)};
		} forEach _startPositions;

		//unless this has been repeated too often -> use position anyway
		if (_repetitions >= 10) then {
			_tooCloseFound = false;
		};

		_repetitions = _repetitions + 1;
	};

    {
        _isWater = true;
        _memberpos = GVAR(playAreaCenter);

        while {_isWater} do {
            _memberpos = [_teamLeadPos,[0,30],[0,360]] call EFUNC(common,randomPos);
            _isWater = surfaceIsWater _memberpos;
        };

        [_x,_memberPos] remoteExec [QEFUNC(common,teleport),_x,false];
	} forEach (units group _x);

    [_x,_teamLeadPos] remoteExec [QEFUNC(common,teleport),_x,false];
} forEach GVAR(teamLeaders);
