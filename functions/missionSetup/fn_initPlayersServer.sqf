#include "component.hpp"

GVAR(allPlayerUIDs) = [];
{
    _x setVariable [QGVAR(isPlaying),true,true];
	_x setVariable [QGVAR(kills),0,true];
	_x setVariable [QGVAR(deaths),0,true];
	_x setVariable [QGVAR(longestKill),0,true];
    _x setVariable [QGVAR(eloThisGame),0,true];
    _x setVariable [QGVAR(currentScore),0,true];
    _x setVariable [QGVAR(radioInstance),format ["TFAR_anprc152_%1",_forEachIndex + 1],true];

	//save UID of everyone who is playing
	_playerUID = getPlayerUID _x;
	GVAR(allPlayerUIDs) pushBack _playerUID;

	//add new players to stats
	if ([GVAR(statsArray), _playerUID, 1] call EFUNC(common,findStringInArray) == -1) then {
        //elo, uid, name, [kills, deaths, games]
		GVAR(statsArray) pushBack [100, _playerUID, name _x, [0,0,0]];
	};
} forEach (playableUnits + switchableUnits);
saveProfileNamespace;

INFO("fn_initPlayersServer done");
