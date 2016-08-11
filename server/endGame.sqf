/*  Game ending procedure
*
*   executed on server via fn_setScore
*/

params ["_winner"];

[getPos _winner, _winner] remoteExec ["mcd_fnc_endingCeremony", 0, false];
sleep 6;


sleep 20;
[_winner] remoteExec ["mcd_fnc_endMission",0,false];
