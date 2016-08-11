/*  Ends the mission
*
*   Params:
*   0:  Player who scored the last kill
*/

params ["_winner"];
if (!hasInterface) exitWith {};

_isVictory = _winner in (units group player);
["end1", _isVictory, true, true, true] spawn BIS_fnc_endMission;
