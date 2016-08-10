/*  Ends the mission
*
*   Params:
*   0:  Player who scored the last kill
*/

params ["_winner"];
if (!hasInterface) exitWith {};

_isVictory = _winner in (units group player);

_endText = if (TEAMSIZE > 1) then {format ["%1's team won!", name _winner]} else {format ["%1 won!", name _winner]};
_text = format ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\gruppe-adler.paa'/><br/><t size='.9' color='#FFFFFF'>%1</t>", _endText];
[_text,0,0,2,2] spawn BIS_fnc_dynamicText;

sleep 5;

["end1", _isVictory, true, true, true] spawn BIS_fnc_endMission;
