/*  Handles JIP player
*
*   executed via initPlayerLocal.sqf on players
*/

if (!didJIP) exitWith {isSpectator = false};
if (isNil "VOTINGDONE") exitWith {isSpectator = false};
if (!VOTINGDONE) exitWith {isSpectator = false};

isSpectator = true;

setPlayerRespawnTime 99999;
player setDamage 1;
["Initialize", [player, [], true]] call BIS_fnc_EGSpectator;

_rule = parseText "<t align='center'><t color='#708090'>-----------------------------------------------------<br /></t></t>";
_lineBreak = parseText "<br />";
_message = parseText format ["<t align='center' size='1.4'>Game has already started.</t>"];
hint composeText [_rule, _message, _lineBreak, _rule];

diag_log "handleJIP.sqf - Player joined after voting had already finished. Moving to spectator.";

sleep 4;
hint "";
