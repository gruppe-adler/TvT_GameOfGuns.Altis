#include "component.hpp"


[{!isNull player || isDedicated},{

    if (hasInterface) then {
        [] call FUNC(moveToMapStartPos);

        player addEventHandler ["Killed", EFUNC(events,onPlayerKilled)];
        player addEventHandler ["Respawn", EFUNC(events,onPlayerRespawn)];

        // localhost
        if (isServer) then {
            [FUNC(scoreBoard),1,[]] call CBA_fnc_addPerFrameHandler;
        } else {
            QGVAR(currentRanking) addPublicVariableEventHandler FUNC(scoreBoard);
        };

        [{!isNull (findDisplay 46)},{
            [] call EFUNC(votePlayzone,initPlayer);
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
            ["gungame_notification1",["GUNGAME","Setup done. Waiting 10s for synchronization."]] remoteExec ["bis_fnc_showNotification",0,false];

            // wait for synchronization
            [{
                ["gungame_notification1",["GUNGAME","Game starting in 10s."]] remoteExec ["bis_fnc_showNotification",0,false];
                [] remoteExec [QFUNC(applyUniform),0,false];

                // wait 10s
                [{
                    [] call FUNC(moveTeamsToStartPositions);
                    [] remoteExec [QFUNC(initPlayerInPlayzone),0,false];
                    [] remoteExec [QFUNC(scoreBoard),0,false];

                    {[_x,0] remoteExecCall [QFUNC(applyWeapon),_x,false]} forEach playableUnits;
                    missionNamespace setVariable [QGVAR(gameStarted),true,true];

                },[],10] call CBA_fnc_waitAndExecute;
            },[],10] call CBA_fnc_waitAndExecute;
        },[]] call CBA_fnc_waitUntilAndExecute;
    };

},[]] call CBA_fnc_waitUntilAndExecute;
