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
  while {true} do {
    _oldRanking = str CURRENTRANKING;
    waitUntil {sleep 1; (str CURRENTRANKING) != _oldRanking};
    [] call mcd_fnc_scoreBoard;
  };
};
