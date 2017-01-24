/*  Game ending procedure
*
*   executed on server via fn_setScore
*/

params ["_winner"];

//start game end procedure on clients
[getPos _winner, _winner] remoteExec ["mcd_fnc_endingCeremony", 0, false];

//update stats
_startTime = serverTime;
/*_updateStats = [] execVM "server\updateLeaderboard.sqf";*/
waitUntil {scriptDone _updateStats};
sleep ((10 - (serverTime - _startTime)) max 0);

//show leaderboard on clients
/*[GOGSTATS] remoteExec ["mcd_fnc_showLeaderboard", 0, false];*/

sleep 27;
[_winner] remoteExec ["mcd_fnc_endMission",0,false];
