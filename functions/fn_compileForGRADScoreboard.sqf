params ["_stats"];

_compiledStats = [["NAME","K/D","GAMES","POINTS"]];
{
    _x params ["_points","_UID","_name","_playerStats"];
    _playerStats params ["_kills","_deaths","_games"];
    _compiledStats pushBack [_name,(round ((_kills/_deaths)*100))/100,_games,round _points];
} forEach _stats;

_compiledStats
