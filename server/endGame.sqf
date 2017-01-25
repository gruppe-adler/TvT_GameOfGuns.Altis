/*  Game ending procedure
*
*   executed on server via fn_setScore
*/

params ["_winner"];

//start game end procedure on clients
[getPos _winner, _winner] remoteExec ["mcd_fnc_endingCeremony", 0, false];

//update stats
_startTime = serverTime;
_stats = [] call mcd_fnc_updateLeaderboard;
_compiledStats = [_stats] call mcd_fnc_compileForGRADScoreboard;

//show on clients
[_compiledStats] remoteExec ["mcd_fnc_showGRADScoreboard",0,false];

//end mission
sleep 24;
[_winner] remoteExec ["mcd_fnc_endMission",0,false];
