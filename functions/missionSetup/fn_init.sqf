#include "component.hpp"


[{!isNull player || isDedicated},{

    if (hasInterface) then {
        [] call FUNC(moveToMapStartPos);

        [{!isNull (findDisplay 46)},{
            [] call EFUNC(votePlayzone,initPlayer);
        },[]] call CBA_fnc_waitUntilAndExecute;

        [{missionNamespace getVariable [QGVAR(setupDone),false]},{
            ["gungame_notification1",["GUNGAME","Server side setup done."]] spawn bis_fnc_showNotification;
            ["gungame_notification1",["GUNGAME","Waiting 10s for synchronization."]] spawn bis_fnc_showNotification;

            [{
                [] call FUNC(applyUniform);
                /* [] call FUNC(setRadioFrequencies); */
            },[],10] call CBA_fnc_waitAndExecute;
        },[]] call CBA_fnc_waitUntilAndExecute;
    };

    if (isServer) then {
        _timeOfDay = [] call FUNC(setTime);
        [_timeOfDay] call FUNC(setWeather);

        [] call EFUNC(votePlayzone,initServer);

        // wait until voting complete
        [{missionNamespace getVariable [QEGVAR(votePlayzone,votingComplete),false]},{
            [] call FUNC(playAreaSetup);
            [] call FUNC(teamSetup);
            [] call FUNC(selectWeapons);
            [] call FUNC(randomizeRadioFrequencies);

            missionNamespace setVariable [QGVAR(setupDone),true,true];
        },[]] call CBA_fnc_waitUntilAndExecute;

    };

},[]] call CBA_fnc_waitUntilAndExecute;
