#include "component.hpp"

if (!hasInterface) exitWith {};

private _teamNamespace = player getVariable [QGVAR(teamNamespace),objNull];
private _freq = _teamNamespace getVariable [QGVAR(swFrequency),"32"];

[(call TFAR_fnc_activeSwRadio), _freq] call TFAR_fnc_setSwFrequency;

if (isNil "TFAR_defaultFrequencies_sr_west") then {
    TFAR_defaultFrequencies_sr_west = [_freq,"60","70","80","90","100","110","120"];
} else {
    TFAR_defaultFrequencies_sr_west set [0,_freq];
};
