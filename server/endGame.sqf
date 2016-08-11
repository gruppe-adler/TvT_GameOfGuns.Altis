/*  Game ending procedure
*
*   executed on server via fn_setScore
*/

params ["_winner"];
private ["_gogStats", "_gogPoints"];

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
  };

  if (([_gogPoints, name _x] call mcd_fnc_findPlayerStats) == -1) then {
    //name, points
    _gogPoints pushBack [name _x, 0];
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

    //deaths
    _oldDeaths = _playerStats select 2;
    _playerStats set [2, _oldDeaths + (_x getVariable ["deaths", 0])];

    //games
    _oldGames = _playerStats select 3;
    _playerStats set [3, _oldGames + 1];
  };
} forEach allPlayers;

//COMPILE RANKING FOR THIS GAME ================================================
//CURRENTRANKING: [score, group displayname, groupname, [groupmember, groupmember, ...]]





sleep 20;
[_winner] remoteExec ["mcd_fnc_endMission",0,false];
