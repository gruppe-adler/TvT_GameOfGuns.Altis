#include "component.hpp"

params [["_respawnPos",[0,0,0]]];

if (alive player) exitWith {};

player setVariable [QGVAR(respawnPos),_respawnPos];
setPlayerRespawnTime 1;
forceRespawn player;
