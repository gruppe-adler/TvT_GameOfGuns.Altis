#include "component.hpp"


[{!isNull player || isDedicated},{

    if (hasInterface) then {
        [] call FUNC(moveToMapStartPos);

        player addEventHandler ["Killed", EFUNC(events,onPlayerKilled)];

        [{!isNull (findDisplay 46)},{
            [] call EFUNC(votePlayzone,initPlayer);
        },[]] call CBA_fnc_waitUntilAndExecute;

        [{missionNamespace getVariable [QGVAR(setupDone),false]},{

            ["gungame_notification1",["GUNGAME","Waiting 10s for synchronization."]] spawn bis_fnc_showNotification;
            ["gungame_notification1",["GUNGAME","Server side setup done."]] spawn bis_fnc_showNotification;

            [{

                [] call FUNC(applyUniform);
                /* [] call FUNC(setRadioFrequencies); */
                ["gungame_notification1",["GUNGAME","Game starting in 10s."]] spawn bis_fnc_showNotification;

            },[],10] call CBA_fnc_waitAndExecute;

        },[]] call CBA_fnc_waitUntilAndExecute;
    };

    if (isServer) then {
        missionNamespace setVariable [QGVAR(soloRespawnTime),"SoloRespawnTime" call BIS_fnc_getParamValue,true];
        missionNamespace setVariable [QGVAR(teamRespawnTime),"TeamRespawnTime" call BIS_fnc_getParamValue,true];

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

            [{

                [] call FUNC(moveTeamsToStartPositions);
                {[_x,0] remoteExecCall [QEFUNC(events,onIncreasedScore),_x,false]} forEach playableUnits;
                missionNamespace setVariable [QGVAR(gameStarted),true,true];

            },[],20] call CBA_fnc_waitAndExecute;

        },[]] call CBA_fnc_waitUntilAndExecute;

    };

},[]] call CBA_fnc_waitUntilAndExecute;
