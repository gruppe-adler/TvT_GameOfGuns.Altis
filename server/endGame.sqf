/*  Game ending procedure
*
*   executed on server via fn_setScore
*/

params ["_winner"];
private ["_gogStats", "_gogPoints", "_memberPoints"];

[getPos _winner, _winner] remoteExec ["mcd_fnc_endingCeremony", 0, false];

//GET STATS AND POINT FROM PROFILENAMESPACE ====================================
//get stats
_gogStats = profileNameSpace getVariable "mcd_gameofguns_stats";
if (isNil "_gogStats") then {
  profileNameSpace setVariable ["mcd_gameofguns_stats", []];
  _gogStats = profileNameSpace getVariable "mcd_gameofguns_stats";
  diag_log "endGame.sqf - STATS NOT FOUND ON SERVER. STATS ARRAY HAS BEEN CREATED IN PROFILENAMESPACE.";
};

//get points
_gogPoints = profileNamespace getVariable "mcd_gameofguns_points";
if (isNil "_gogPoints") then {
  profileNamespace setVariable ["mcd_gameofguns_points", []];
  _gogPoints = profileNamespace getVariable "mcd_gameofguns_points";
  diag_log "endGame.sqf - POINTS NOT FOUND ON SERVER. POINTS ARRAY HAS BEEN CREATED IN PROFILENAMESPACE.";
};

//ADD ANY NEW PLAYERS ==========================================================
{
  if (([_gogStats, name _x] call mcd_fnc_findPlayerStats) == -1) then {
    //name, kills, deaths, games
    _gogStats pushBack [name _x, 0, 0, 0];
    diag_log format ["endGame.sqf - Created stats entry for player %1.", name _x];
  };

  if (([_gogPoints, name _x] call mcd_fnc_findPlayerStats) == -1) then {
    //name, points
    _gogPoints pushBack [name _x, 100];
    diag_log format ["endGame.sqf - Created points entry for player %1", name _x];
  };
} forEach allPlayers;


//UPDATE STATS =================================================================
{
  _ID = [_gogStats, name _x] call mcd_fnc_findPlayerStats;
  if (_ID == -1) then {
    diag_log format ["endGame.sqf - ERROR: COULD NOT FIND PLAYER %1 DURING UPDATE.", name _x];
  } else {
    _playerStats = _gogStats select _ID;

    //kills
    _oldKills = _playerStats select 1;
    _playerStats set [1, _oldKills + (_x getVariable ["kills",0])];
    diag_log format ["endGame.sqf - Player %1 scored %2 kills this game.", name _x, _x getVariable ["kills",0]];

    //deaths
    _oldDeaths = _playerStats select 2;
    _playerStats set [2, _oldDeaths + (_x getVariable ["deaths", 0])];
    diag_log format ["endGame.sqf - Player %1 died %2 times this game.", name _x, _x getVariable ["deaths", 0]];

    //games
    _oldGames = _playerStats select 3;
    _playerStats set [3, _oldGames + 1];
    diag_log format ["endGame.sqf - Player %1 now has a total of %2 games.", name _x, _playerStats select 3];
  };
} forEach allPlayers;

diag_log "endGame.sqf - Stats have been updated. Here is the new array:";
diag_log "NAME, KILLS, DEATHS, GAMES ===========================================";
{
  diag_log str _x;
} forEach _gogStats;
diag_log "======================================================================";
//UPDATE POINTS ================================================================
//CURRENTRANKING: [score, group displayname, groupname, [groupmember, groupmember, ...]]

//get average elo of all teams
_eloArray = [];
{
  _groupArray = _x;
  _groupMembers = _groupArray select 3;
  _totalPoints = 0;
  {
    _memberName = _x;
    _pointsID = [_gogPoints, _memberName] call mcd_fnc_findPlayerStats;
    if (_pointsID == -1) then {
      diag_log format ["endGame.sqf - ERROR: COULD NOT FIND %1 POINTS.", _memberName];
      _memberPoints = 100;
    } else {
      _memberPoints = (_gogPoints select _pointsID) select 1;
      diag_log format ["endGame.sqf - Group %1: Player %2 currently has %3 points.", _groupArray select 0, _memberName, _memberPoints];
    };
    _totalPoints = _totalPoints + _memberPoints;
  } forEach _groupMembers;
  _averagePoints = _totalPoints / (count _groupMembers);
  _eloArray pushBack _averagePoints;

  diag_log format ["endGame.sqf - Team %1 has an average of %2 points.", _groupArray select 1, _averagePoints];
} forEach CURRENTRANKING;

//update elo for all players
{
  _player = _x;
  _playerEloGain = 0;
  _playerEloIndex = [_gogPoints, name _player] call mcd_fnc_findPlayerStats;
  if (_playerEloIndex == -1) exitWith {diag_log format ["endGame.sqf - ERROR: COULD NOT FIND %1 POINTS.", name _player]};
  _playerPointsArray = _gogPoints select _playerEloIndex;
  _playerElo = _playerPointsArray select 1;

  _rankIndex = [CURRENTRANKING, name _player, 3] call mcd_fnc_findPlayerStats; //funktion muss noch umgeschrieben werden, sodass sie in arrays sucht
  if (_rankIndex == -1) exitWith {diag_log format ["endGame.sqf - ERROR: COULD NOT FIND %1 IN CURRENTRANKING.", name _player]};

  //negative points
  for [{_i=0}, {_i<_rankIndex}, {_i=_i+1}] do {
    _otherPlayerElo = _eloArray select _i;
    _playerEloGain = _playerEloGain - (_playerElo/_otherPlayerElo);
  };

  //positive points
  for [{_i=_rankIndex+1}, {_i<(count _eloArray)}, {_i=_i+1}] do {
    _otherPlayerElo = _eloArray select _i;
    _playerEloGain = _playerEloGain + (_otherPlayerElo/_playerElo);
  };

  diag_log format ["endGame.sqf - Player %1 gained %2 points this game for a new total of %3.", name _player, _playerEloGain, _playerElo + _playerEloGain];
  _player setVariable ["eloThisGame", _playerEloGain, true];
  _playerPointsArray set [1, _playerElo + _playerEloGain];
} forEach allPlayers;

//sort and broadcast
_gogPoints sort false;
CURRENTLEADERBOARD = _gogPoints;
publicVariable "CURRENTLEADERBOARD";

/*[_winner] remoteExec ["mcd_fnc_endMission",0,false];*/
