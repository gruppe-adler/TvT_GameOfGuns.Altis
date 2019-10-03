#include "component.hpp"


[{!isNull player || isDedicated},{

    // PLAYER ==================================================================
    if (hasInterface) then {
        [] call FUNC(moveToMapStartPos);

        if (didJIP && missionNamespace getVariable [QGVAR(setupDone),false]) exitWith {
            player setVariable [QGVAR(isSpectator),true,true];
            player setDamage 1;
            ["Terminate"] call BIS_fnc_EGSpectator;
            ["Initialize", [player, [WEST,EAST,INDEPENDENT], true]] call BIS_fnc_EGSpectator;
        };

        [] call FUNC(removeInitialWeapon);

        player addEventHandler ["Killed", EFUNC(events,onPlayerKilled)];
        player addEventHandler ["Respawn", EFUNC(events,onPlayerRespawn)];

        [{[] call FUNC(scoreBoard)},1,[]] call CBA_fnc_addPerFrameHandler;

        [{!isNull (findDisplay 46)},{
            [] call EFUNC(votePlayzone,initPlayer);
        },[]] call CBA_fnc_waitUntilAndExecute;
    };

    // SERVER ==================================================================
    if (isServer) then {
        missionNamespace setVariable [QGVAR(respawnTime),"RespawnTime" call BIS_fnc_getParamValue,true];
        missionNamespace setVariable [QGVAR(rankedMode),("RankedMode" call BIS_fnc_getParamValue) == 1,true];
        missionNamespace setVariable [QGVAR(killsForWin),"KillsForWin" call BIS_fnc_getParamValue,true];

        _timeOfDay = [] call FUNC(setTime);
        [_timeOfDay] call FUNC(setWeather);

        [{missionNamespace getVariable ["CBA_missionTime",0] > 0},{
            [] call EFUNC(votePlayzone,initServer);
        },[]] call CBA_fnc_waitUntilAndExecute;

        // wait until voting complete
        [{missionNamespace getVariable [QEGVAR(votePlayzone,votingComplete),false]},{

            [] call FUNC(initPlayersServer);
            [] call FUNC(playAreaSetup);
            [] call FUNC(selectWeapons);

            missionNamespace setVariable [QGVAR(setupDone),true,true];

            // wait for synchronization
            ["gungame_notification1",["GUNGAME","Setup done. Waiting 10s for synchronization."]] remoteExec ["bis_fnc_showNotification",0,false];
            [{
                ["gungame_notification1",["GUNGAME","Game starting in 10s."]] remoteExec ["bis_fnc_showNotification",0,false];
                [] remoteExec [QFUNC(applyUniform),0,false];

                // wait 10s
                [{
                    [] call FUNC(movePlayerToStartPos);
                    [] remoteExec [QFUNC(setRadioFrequencies),0,false];
                    [] remoteExec [QFUNC(initPlayerInPlayzone),0,false];
                    [] remoteExec [QFUNC(initCampingProtection),0,false];
                    [] remoteExec [QFUNC(scoreBoard),0,false];

                    {[_x,0] remoteExecCall [QFUNC(applyWeapon),_x,false]} forEach (allPlayers select {_x getVariable [QGVAR(isPlaying),false]});
                    missionNamespace setVariable [QGVAR(gameStarted),true,true];

                },[],10] call CBA_fnc_waitAndExecute;
            },[],10] call CBA_fnc_waitAndExecute;
        },[]] call CBA_fnc_waitUntilAndExecute;
    };

},[]] call CBA_fnc_waitUntilAndExecute;
