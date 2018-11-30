#include "component.hpp"

if (!hasInterface) exitWith {};

private _teamNamespace = player getVariable [QGVAR(teamNamespace),objNull];
private _freq = _teamNamespace getVariable [QGVAR(swFrequency),"32"];

[(call TFAR_fnc_activeSwRadio), _freq] call TFAR_fnc_setSwFrequency;
