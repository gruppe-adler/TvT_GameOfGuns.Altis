#include "component.hpp"


private ["_players","_numberOfTeams", "_teammember", "_teamleadernames", "_teamleadID"];

private _randomTeams = ("RandomTeams" call BIS_fnc_getParamValue) == 1;

if (count playableUnits <= 2) then {
    missionNamespace setVariable [QGVAR(teamSize),1,true];
} else {
    _teamSize = "TeamSize" call BIS_fnc_getParamValue;
    missionNamespace setVariable [QGVAR(teamSize),_teamSize,true];
};


//Setup for each player ========================================================
GVAR(allPlayerUIDs) = [];
{
	_x setVariable [QGVAR(isTeamlead), false, true];
	_x setVariable [QGVAR(spawnpos), [0,0,0], true];
	_x setVariable [QGVAR(kills), 0, true];
	_x setVariable [QGVAR(deaths), 0, true];
	_x setVariable [QGVAR(longestKill), 0, true];
	_x setVariable [QGVAR(eloThisGame), 0, true];

	//save UID of everyone who is playing
	_playerUID = getPlayerUID _x;
	GVAR(allPlayerUIDs) pushBack _playerUID;

	//add new players to stats
	if ([GVAR(statsArray), _playerUID, 1] call EFUNC(common,findStringInArray) == -1) then {

        //elo, uid, name, [kills, deaths, games]
		GVAR(statsArray) pushBack [100, _playerUID, name _x, [0,0,0]];
	};

} forEach allPlayers;
saveProfileNamespace;


//Define GVAR(teamLeaders) if random groups are off ============================
if (!(_randomTeams) || ((count playableUnits) == 1)) then {
	GVAR(teamLeaders) = [];
	{
		if (count units _x > 0) then {
			_groupLeader = leader _x;
			_groupLeader setVariable [QGVAR(isTeamlead), true, true];
			GVAR(teamLeaders) pushBack _groupleader;
		};
	} forEach (allGroups select {isPlayer leader _x});
};


//Define Teams and GVAR(teamLeaders) if random groups are on ===================
if (_randomTeams) then {
    [] call FUNC(randomizeTeams);
};

private _allPlayerGroups = allGroups select {isPlayer leader _x};

publicVariable QGVAR(teamLeaders);

//create persistent global namespace for all player groups =====================
{
    _namespace = [true] call CBA_fnc_createNamespace;
    {
        _x setVariable [QGVAR(teamNamespace),_namespace,true];
    } forEach (units _x);

} forEach _allPlayerGroups;


//Save teammates ===============================================================
{
    _teamMateUIDs = (units group _x) apply {getPlayerUID _x};
    _teamNamespace = _x getVariable [QGVAR(teamNamespace),objNull];
    _teamNamespace setVariable [QGVAR(teamMateUIDs),_teamMateUIDs,true];
} forEach GVAR(teamLeaders);


//Set groupnames ===============================================================
GVAR(currentRanking) = [];
{
	_group = _x;
    _groupLeader = leader _group;
    _teamNamespace = _groupLeader getVariable [QGVAR(teamNamespace),objNull];
    _leaderName = [_groupLeader] call ACE_common_fnc_getName;

    _groupDisplayName = if (GVAR(teamSize) > 1) then {format ["Team %1", _leaderName]} else {_leaderName};
    _groupRankingID = GVAR(currentRanking) pushBack [0,_group,_groupDisplayName];

    _teamNamespace setVariable [QGVAR(displayName),_groupDisplayName,true];
    _teamNamespace setVariable [QGVAR(currentScore),0,true];
    _teamNamespace setVariable [QGVAR(groupRankingID),_groupRankingID,true];
} forEach _allPlayerGroups;
publicVariable QGVAR(currentRanking);


// uniforms ====================================================================
[] call FUNC(randomizeUniforms);

missionNamespace setVariable [QGVAR(teamSetupDone),true,true];
