//get stats
GOGSTATS = profileNameSpace getVariable "mcd_gameofguns_stats";
if (isNil "GOGSTATS") exitWith {diag_log "updateLeaderboard.sqf - ERROR: STATS NOT FOUND IN SERVER PROFILENAMESPACE."};

//UPDATE STATS =================================================================
{
  _playerUID = _x;
  _ID = [GOGSTATS, _playerUID, 1] call mcd_fnc_findStringInArray;
  if (_ID == -1) then {
    diag_log format ["updateLeaderboard.sqf - ERROR: COULD NOT FIND PLAYER %1 DURING UPDATE.", name _x];
  } else {
    _playerArray = GOGSTATS select _ID;
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
    _playerStats set [0, _oldKills + (_playerUnit getVariable ["kills",0])];
    diag_log format ["updateLeaderboard.sqf - Player %1 scored %2 kills this game.", name _playerUnit, _playerUnit getVariable ["kills",0]];

    //deaths
    _oldDeaths = _playerStats select 1;
    _playerStats set [1, _oldDeaths + (_playerUnit getVariable ["deaths", 0])];
    diag_log format ["updateLeaderboard.sqf - Player %1 died %2 times this game.", name _playerUnit, _playerUnit getVariable ["deaths", 0]];

    //games
    _oldGames = _playerStats select 2;
    _playerStats set [2, _oldGames + 1];
    diag_log format ["updateLeaderboard.sqf - Player %1 now has a total of %2 games.", name _playerUnit, _playerStats select 3];
  };
} forEach ALLPLAYERUIDS;

diag_log "updateLeaderboard.sqf - Stats have been updated. Here is the new array:";
diag_log "NAME, KILLS, DEATHS, GAMES ===========================================";
{
  diag_log str _x;
} forEach GOGSTATS;
diag_log "======================================================================";


//UPDATE POINTS ================================================================
//CURRENTRANKING: [score, group displayname, groupname, [groupmemberUID, groupmemberUID, ...]]

//get average elo of all teams
_eloArray = [];
_memberPoints = 100;
{
  _groupArray = _x;
  _groupMemberUIDs = _groupArray select 3;
  _totalPoints = 0;
  {
    _memberUID = _x;
    _pointsID = [GOGSTATS, _memberUID, 1] call mcd_fnc_findStringInArray;
    if (_pointsID == -1) then {
      diag_log format ["updateLeaderboard.sqf - ERROR: COULD NOT FIND %1 POINTS.", _memberUID];
      _memberPoints = 100;
    } else {
      _memberPoints = (GOGSTATS select _pointsID) select 0;
      diag_log format ["updateLeaderboard.sqf - Group %1: Player %2 currently has %3 points.", _groupArray select 0, _memberUID, _memberPoints];
    };
    _totalPoints = _totalPoints + _memberPoints;
  } forEach _groupMemberUIDs;

  _averagePoints = _totalPoints / (count _groupMemberUIDs);
  _eloArray pushBack _averagePoints;

  diag_log format ["updateLeaderboard.sqf - Team %1 has an average of %2 points.", _groupArray select 1, _averagePoints];
} forEach CURRENTRANKING;

//update elo for all players
{
  _playerUID = _x;
  _playerUnit = [_playerUID] call BIS_fnc_getUnitByUID;
  _playerEloGain = 0;
  _playerEloIndex = [GOGSTATS, _playerUID, 1] call mcd_fnc_findStringInArray;
  if (_playerEloIndex == -1) exitWith {diag_log format ["updateLeaderboard.sqf - ERROR: COULD NOT FIND %1 POINTS.", name _playerUnit]};
  _playerStats = GOGSTATS select _playerEloIndex;
  _playerElo = _playerStats select 0;

  _rankIndex = [CURRENTRANKING, _playerUID, 3] call mcd_fnc_findStringInArray;
  if (_rankIndex == -1) exitWith {diag_log format ["updateLeaderboard.sqf - ERROR: COULD NOT FIND %1 IN CURRENTRANKING.", name _playerUnit]};

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

  //elo gain factor
  _playerEloGain = _playerEloGain * 2;

  diag_log format ["updateLeaderboard.sqf - Player %1 gained %2 points this game for a new total of %3.", name _playerUnit, _playerEloGain, _playerElo + _playerEloGain];
  _playerUnit setVariable ["eloThisGame", _playerEloGain, true];
  _playerStats set [0, (_playerElo + _playerEloGain) max 0];
} forEach ALLPLAYERUIDS;


diag_log "updateLeaderboard.sqf - Points have been updated. Here is the new array:";
diag_log "NAME, POINTS =========================================================";
{
  diag_log str _x;
} forEach GOGSTATS;
diag_log "======================================================================";

GOGSTATS sort false;
saveProfileNamespace;
