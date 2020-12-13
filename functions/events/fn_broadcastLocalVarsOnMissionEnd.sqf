#include "component.hpp"

if (!hasInterface) exitWith {};
if !(player getVariable [QEGVAR(missionSetup,isPlaying)]) exitWith {
    INFO("Player was only spectating.");
};

player setVariable [QEGVAR(missionSetup,totalDistance), player getVariable [QEGVAR(missionSetup,totalDistance),0], true];
player setVariable [QEGVAR(missionSetup,radioUsedCounter), player getVariable [QEGVAR(missionSetup,radioUsedCounter),0], true];
player setVariable [QEGVAR(missionSetup,shotsCounter), player getVariable [QEGVAR(missionSetup,shotsCounter),0], true];

/*  Vars on player, that server already knows:
*   QEGVAR(missionSetup,longestKill)
*   QEGVAR(missionSetup,campingCounter)
*   QEGVAR(missionSetup,currentKillstreak)
*   QEGVAR(missionSetup,highestKillstreak)
*/
