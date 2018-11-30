#include "component.hpp"

params [["_unit",objNull],["_newScore",0]];

if (_unit isEqualTo ACE_player) then {
    playSound "gungame_upgradeWeaponSound";
};

if (!alive _unit) exitWith {};

[] call EFUNC(missionSetup,applyWeapon);
