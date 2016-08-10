params ["_camperName"];

diag_log format ["fn_hideCamper executed with %1", _camperName];

if (!hasInterface) exitWith {};

//PLAYER IS CAMPER =============================================================
if (profileName == _camperName) exitWith {
  ["Alright, you stopped camping... I'll be watching you though.",0,0,2,0.3] spawn BIS_fnc_dynamicText;
};

//PLAYER IS SOMEONE ELSE =======================================================
_handleID = camperNames find _camperName;
if (_handleID < 0) exitWith {diag_log format ["fn_hideCamper - WARNING: Could not find %1 in camperNames.", _camperName]};
_handle = camperHandles select _handleID;
[_handle] call CBA_fnc_removePerFrameHandler;
