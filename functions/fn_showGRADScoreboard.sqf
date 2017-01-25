params ["_serverStats"];

_kills = player getVariable ["kills", 0];
_deaths = player getVariable ["deaths", 0];
_kd = (_kills max 1) / (_deaths max 1);
_longestKill = (round ((player getVariable ["longestKill", 0])*10)) / 10;
_distanceMoved = round (player getVariable ["totalDistance", 0]);


_myStats = [
    ["KILLS","DEATHS","K/D","LONGEST KILL","DISTANCE MOVED"],
    [_kills,_deaths,(round (_kd*100))/100,format ["%1m",round _longestKill],format ["%1m",_distanceMoved]]
];

[20,_compiledStats,"GAME OF GUNS LEADERBOARD",false,_myStats,"MY STATS THIS GAME",false,false] call grad_scoreboard_fnc_loadScoreboard;
