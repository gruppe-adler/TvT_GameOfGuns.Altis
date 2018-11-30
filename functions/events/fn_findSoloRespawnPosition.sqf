params [["_respawnUnit",objNull]];

private _teamNamespace = _respawnUnit getVariable [QEGVAR(missionSetup,teamNamespace),objNull];
private _teamMateUIDs = _teamNamespace getVariable [QEGVAR(missionSetup,teamMateUIDs),[]];
private _teamMates = _teamMateUIDs apply {[_x] call BIS_fnc_getUnitByUid};
private _aliveTeamMates = _teamMates select {alive _x};

private _searchPos = if (count _aliveTeamMates > 0) then {
    getPos selectRandom _aliveTeamMates
} else {
    [EGVAR(missionSetup,playAreaCenter),[0,EGVAR(missionSetup,playAreaSize) - 25],[0,360]] call EFUNC(common,randomPos);
};
private _respawnPos = [];

for [{_i=0},{_i<10},{_i=_i+1}] do {
    _respawnPos = ([_searchPos,[0,50]] call EFUNC(common,randomPos)) findEmptyPosition [0,30,"B_Soldier_F"];
    if (count _respawnPos > 0) exitWith {};
};

if (count _respawnPos == 0) then {
    _respawnPos = _searchPos;
};

_respawnPos
