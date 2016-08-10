#include "defines.hpp"

waitUntil {!isNil "isSpectator"};
if (isSpectator) exitWith {};

waitUntil {!isNil "CURRENTRANKING"};
waitUntil {!isNil "GAMESTARTED"};
waitUntil {GAMESTARTED};

//ADD PVEH =====================================================================
"CURRENTRANKING" addPublicVariableEventHandler {[] call mcd_fnc_scoreBoard};

//RUN MANUALLY ONCE ============================================================
[] call mcd_fnc_scoreBoard;

//PLAYER HOST ==================================================================
if (isServer && hasInterface) then {
  _oldRanking = str CURRENTRANKING;
  while {true} do {
    waitUntil {sleep 1; (str CURRENTRANKING) != _oldRanking};
    _oldRanking = str CURRENTRANKING;
    [] call mcd_fnc_scoreBoard;
  };
};
