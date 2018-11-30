#include "component.hpp"

private ["_freq", "_alreadyIn", "_freqString", "_teamlead"];
private _swFrequencies = [];


//Frequencies for PRC-152
private _radioMin = 31;
private _radioMax = 512;

//Set x10 for random number generator
private _radioMin = _radioMin * 10;
private _radioMax = _radioMax * 10;


//Generate frequencies if more than one player per team
if (GVAR(teamSize) > 1) then {
	{
		_alreadyIn = 1000;
		while {_alreadyIn != -1} do {
			_freq = (floor ((random (_radioMax - _radioMin)) + _radioMin)) / 10;
			_alreadyIn = _swFrequencies find _freq;

			if (_alreadyIn == -1) then {
				_swFrequencies = _swFrequencies + [_freq];
			};
		};
	} forEach GVAR(teamLeaders);
};

//Put everyone on the same frequency if one player per team
if (GVAR(teamSize) == 1) then {
	{
		_swFrequencies pushBack 100;
	} forEach GVAR(teamLeaders);
};


//Save frequencies as public variable in teamleaders
{
    _teamNamespace = _x getVariable [QGVAR(teamNamespace),objNull];

    _freqString = str (_swFrequencies select _forEachIndex);
    _teamNamespace setVariable [QGVAR(swFrequency),_freqString,true];

} forEach GVAR(teamLeaders);
