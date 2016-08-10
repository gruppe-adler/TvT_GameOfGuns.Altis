#include "killCamDefines.hpp"

params ["_totalTime"];
disableSerialization;

_unit = player;
_shooter = _unit getVariable ["ACE_medical_lastDamageSource",objNull];
_shooterName = toUpper (if (!isNull _shooter && alive _shooter) then {name _shooter} else {"someone"});
_killMessage = format ["YOU GOT KILLED BY %1", _shooterName];

_layer = (["kcTitleLayer"] call BIS_fnc_rscLayer);
_layer cutRsc ["KillCamTitle", "PLAIN", 1];
_display = uiNamespace getVariable ["KillCamTitle_Display",displayNull];
_title = _display displayCtrl KILLCAMTITLE_TITLE;
_title ctrlSetText _killMessage;

_camera = "camera" camCreate ((getPos _unit) vectorAdd [0,0,2]);
_camera cameraEffect ["internal","back"];

showCinemaBorder true;
_filmgrain = ppEffectCreate ["FilmGrain",2000];
_filmgrain ppEffectEnable true;
_filmgrain ppEffectAdjust [0.3,0.3,0.12,0.12,0.12,true];
_filmgrain ppEffectCommit 0;

_camera camSetTarget _unit;
_camera camSetFov 0.4;
_camera camCommit (_totalTime * 0.1);
sleep (_totalTime * 0.1);

_camera camSetTarget _shooter;
_camera camSetFov 0.2;
_camera camCommit ((_totalTime * 0.4) min 4);
sleep (_totalTime * 0.7);


cutRsc ["RscStatic", "PLAIN" , 3];
sleep (_totalTime * 0.1);
cutText ["", "BLACK OUT", 1];
sleep (_totalTime * 0.1);

_filmgrain ppEffectEnable false;
ppEffectDestroy _filmgrain;
_camera cameraEffect ["terminate","back"];
camDestroy _camera;
showCinemaBorder false;
