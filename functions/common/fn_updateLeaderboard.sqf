#include "component.hpp"

private _stats = EGVAR(missionSetup,statsArray);
private _allPlayerUIDs = (allPlayers apply {getPlayerUID _x});

//UPDATE STATS =================================================================
{
    _playerUID = _x;
    _ID = [_stats, _playerUID, 1] call FUNC(findStringInArray);
    if (_ID == -1) then {
        diag_log format ["updateLeaderboard.sqf - ERROR: COULD NOT FIND PLAYER WITH UID %1 DURING UPDATE.", _x];
    } else {
        _playerArray = _stats select _ID;
        _playerStats = _playerArray select 3;

        //name
        _playerUnit = [_playerUID] call BIS_fnc_getUnitByUID;
        if (!isNull _playerUnit) then {
            _newName = name _playerUnit;
            if (_newName != "Error: No vehicle" && _newName != "Error: No unit") then {
                _playerArray set [2, _newName];
            };
        };

        //kills
        _oldKills = _playerStats select 0;
        _playerStats set [0, _oldKills + (_playerUnit getVariable [QEGVAR(missionSetup,kills),0])];
        diag_log format ["updateLeaderboard.sqf - Player %1 scored %2 kills this game.", name _playerUnit, _playerUnit getVariable ["kills",0]];

        //deaths
        _oldDeaths = _playerStats select 1;
        _playerStats set [1, _oldDeaths + (_playerUnit getVariable [QEGVAR(missionSetup,deaths), 0])];
        diag_log format ["updateLeaderboard.sqf - Player %1 died %2 times this game.", name _playerUnit, _playerUnit getVariable ["deaths", 0]];

        //games
        _oldGames = _playerStats select 2;
        _playerStats set [2, _oldGames + 1];
        diag_log format ["updateLeaderboard.sqf - Player %1 now has a total of %2 games.", name _playerUnit, _playerStats select 3];
    };
} forEach _allPlayerUIDs;

diag_log "updateLeaderboard.sqf - Stats have been updated. Here is the new array:";
diag_log "NAME, KILLS, DEATHS, GAMES ===========================================";
{
    diag_log str _x;
} forEach _stats;
diag_log "======================================================================";


//UPDATE POINTS ================================================================
//EGVAR(missionSetup,currentRanking): [points,group,groupDisplayName]

//get average elo of all teams
private _eloArray = [];
private _memberElo = 100;
{
    _x params ["_groupScore","_group","_groupDisplayName"];

    _groupTeamNamespace = (leader _group) getVariable [QEGVAR(missionSetup,teamNamespace),objNull];
    _groupMemberUIDs = _groupTeamNamespace getVariable [QEGVAR(missionSetup,teamMateUIDs),[]];

    _totalElo = 0;
    {
        _memberUID = _x;
        _pointsID = [_stats, _memberUID, 1] call FUNC(findStringInArray);
        if (_pointsID == -1) then {
            diag_log format ["updateLeaderboard.sqf - ERROR: COULD NOT FIND %1 ELO.", _memberUID];
            _memberElo = 100;
        } else {
            _memberElo = (_stats select _pointsID) select 0;
            diag_log format ["updateLeaderboard.sqf - Group %1: Player %2 currently has %3 elo.", _groupDisplayName, _memberUID, _memberElo];
        };
        _totalElo = _totalElo + _memberElo;
    } forEach _groupMemberUIDs;

    _averagePoints = _totalElo / (count _groupMemberUIDs);
    _eloArray pushBack _averagePoints;

    diag_log format ["updateLeaderboard.sqf - Team %1 has an average of %2 points.", _groupDisplayName, _averagePoints];
} forEach EGVAR(missionSetup,currentRanking);

//update elo for all players
{
    _playerUID = _x;
    _playerUnit = [_playerUID] call BIS_fnc_getUnitByUID;
    _playerEloGain = 0;
    _playerEloIndex = [_stats, _playerUID, 1] call FUNC(findStringInArray);
    if (_playerEloIndex == -1) exitWith {diag_log format ["updateLeaderboard.sqf - ERROR: COULD NOT FIND %1 POINTS.", name _playerUnit]};
    _playerStats = _stats select _playerEloIndex;
    _playerElo = _playerStats select 0;


    _rankIndex = -1;
    {
        _x params ["_groupScore","_group","_groupDisplayName"];
        _groupTeamNamespace = (leader _group) getVariable [QEGVAR(missionSetup,teamNamespace),objNull];
        _groupMemberUIDs = _groupTeamNamespace getVariable [QEGVAR(missionSetup,teamMateUIDs),[]];

        if (_playerUID in _groupMemberUIDs) exitWith {
            _rankIndex = _forEachIndex;
        };
    } forEach EGVAR(missionSetup,currentRanking);
    if (_rankIndex == -1) exitWith {diag_log format ["updateLeaderboard.sqf - ERROR: COULD NOT FIND %1 IN CURRENTRANKING.", name _playerUnit]};

    //negative points
    for [{_i=0}, {_i<_rankIndex}, {_i=_i+1}] do {
        _otherPlayerElo = _eloArray select _i;
        _playerEloGain = _playerEloGain - ((_playerElo/_otherPlayerElo)*1.25);
    };

    //positive points
    for [{_i=_rankIndex+1}, {_i<(count _eloArray)}, {_i=_i+1}] do {
        _otherPlayerElo = _eloArray select _i;
        _playerEloGain = _playerEloGain + (_otherPlayerElo/_playerElo);
    };

    //elo gain factor
    _playerEloGain = _playerEloGain * 2;

    diag_log format ["updateLeaderboard.sqf - Player %1 gained %2 points this game for a new total of %3.", name _playerUnit, _playerEloGain, _playerElo + _playerEloGain];
    _playerUnit setVariable ["eloThisGame", _playerEloGain, true];
    _playerStats set [0, (_playerElo + _playerEloGain) max 0];
} forEach _allPlayerUIDs;


//SORT =========================================================================
private _allAbove = [];
private _allBelow = [];
{
    if ((_x select 3) select 2 < 5) then {
        _allBelow pushBack _x;
    } else {
        _allAbove pushBack _x;
    };
} forEach _stats;
_allAbove sort false;
_allBelow sort false;
private _stats = _allAbove + _allBelow;

//SAVE AND RETURN ==============================================================
diag_log "updateLeaderboard.sqf - Points have been updated. Here is the new array:";
diag_log "NAME, POINTS =========================================================";
{
    diag_log str _x;
} forEach _stats;
diag_log "======================================================================";

profileNamespace setVariable ["mcd_gameofguns_stats",_stats];
saveProfileNamespace;

_stats
