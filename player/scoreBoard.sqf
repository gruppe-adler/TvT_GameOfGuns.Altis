_delay = 1;
_function = {
  params ["_layer"];
  if (!alive player) exitWith {};
  if (isNull (uiNamespace getVariable "ScoreBoard_Display")) then {
    cutRsc ["ScoreBoard", "PLAIN", 1];
  };


};
[_function, _delay] call CBA_fnc_addPerFrameHandler;
