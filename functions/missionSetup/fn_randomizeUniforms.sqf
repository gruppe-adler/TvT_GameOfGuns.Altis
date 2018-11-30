#include "component.hpp"


private _allPlayerGroups = allGroups select {isPlayer leader _x};
private _allUniforms = call compile preprocessFileLineNumbers "uniformConfig.sqf";

{
	//select uniform
	_uniformsLeft = count _allUniforms;
	_randomID = round (random (_uniformsLeft-1));
	_uniform = _allUniforms select _randomID;
	_allUniforms deleteAt _randomID;

	//refill uniform array if all used up
	if (count _allUniforms == 0) then {
		_allUniforms = call compile preprocessFileLineNumbers "uniformConfig.sqf";
	};

    //set variable
    _teamNamespace = (leader _x) getVariable [QGVAR(teamNamespace),objNull];
    _teamNamespace setVariable [QGVAR(teamUniform),_uniform,true];

} foreach _allPlayerGroups;
