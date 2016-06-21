/* Sets SW frequency to what the server generated for their team
*
* executed on clients by setup\generateSWfreq.sqf
*/

if (!hasInterface) exitWith {};
waitUntil {!isNil "GAMESTARTED"};
waitUntil {GAMESTARTED};

private ["_teamlead"];

_teamlead = leader player;
_freq = _teamlead getVariable "swfreq";

[(call TFAR_fnc_activeSwRadio), _freq] call TFAR_fnc_setSwFrequency;

diag_log format ["setRadioFreq.sqf - SW frequency set to %1.", _freq];


if (SAMEALTCHANNEL && TEAMSIZE != 1) then {
  [(call TFAR_fnc_activeSwRadio), 3, "30"] call TFAR_fnc_SetChannelFrequency;
  [(call TFAR_fnc_activeSwRadio), 2] call TFAR_fnc_setAdditionalSwChannel;
  [(call TFAR_fnc_ActiveSWRadio), 1] call TFAR_fnc_setAdditionalSwStereo;
  diag_log "setRadioFreq.sqf - Added additional channel";
};
