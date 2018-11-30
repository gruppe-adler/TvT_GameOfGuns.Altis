#include "component.hpp"

private _players = playableUnits;
private _numberOfTeams = ceil ((count _players) / GVAR(teamSize));
GVAR(teamLeaders) = [];

//Delete existing groups
{
    [_x] joinSilent grpNull;
} forEach _players;

//Enough players?
if (_numberOfTeams < 2) then {
    INFO("Unable to randomize teams - not enough players.");
    INFO_1("Number of players: %1", (count _players));
    INFO_1("Teamsize selected: %1", GVAR(teamSize));

    _numberOfTeams = 2;
} else {
    INFO_2("Randomizing %1 players into %2 teams", (count _players), _numberOfTeams);
};

if (count playableUnits == 1) then {
    _numberOfTeams = 1;
};

//Select GVAR(teamLeaders)
for [{_i = 0},{_i < _numberOfTeams},{_i = _i + 1}] do {
    _teamlead = selectRandom _players;
    _teamlead setVariable [QGVAR(isTeamlead), true, true];
    _players = _players - [_teamlead];
    GVAR(teamLeaders) pushBack _teamlead;
};

//Teamleader names for log
private _teamLeaderNames = GVAR(teamLeaders) apply {name _x};
INFO_1("Teamleaders selected: %1", _teamleadernames);


//Add remaining players to GVAR(teamLeaders)
for [{_i = 0},{_i < (GVAR(teamSize) - 1)}, {_i = _i + 1}] do {
    _teamleadID = 0;
    {
        if ((count _players) == 0) then {
            INFO("No more players to add to GVAR(teamLeaders) - uneven teams");
        } else {
            _teammember = selectRandom _players;
            _players = _players - [_teammember];
            [_teammember] joinSilent _x;
            INFO_2("%1 added to %2's team.", (name _teammember), (_teamleadernames select _teamleadID));
        };

        _teamleadID = _teamleadID + 1;
    } forEach GVAR(teamLeaders);
};
