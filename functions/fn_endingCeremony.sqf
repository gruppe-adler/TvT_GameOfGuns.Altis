/*  Plays game end procedure
*
*   remote executed by server via server\endGame.sqf
*/

if (!hasInterface) exitWith {};

params ["_winnerPos","_winner"];
GAMEENDED = true;

//respawn player instantly if dead
if (!alive player) then {
  iJustSpawned = true;
  setPlayerRespawnTime 0;
  forceRespawn player;
  waitUntil {alive player};
  cutText ["", "BLACK IN", 0.5];
};

player allowDamage false;

//remove weapons
{player removeWeapon _x} forEach weapons player;
{player removeMagazine _x} forEach magazines player;

//teleport to winner
player setPos _winnerPos;

//display winner text
_endText = if (TEAMSIZE > 1) then {format ["%1's team won!", name _winner]} else {format ["%1 won!", name _winner]};
_text = format ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\gruppe-adler.paa'/><br/><t size='.9' color='#FFFFFF'>%1</t>", _endText];
[_text,0,0,2,1] spawn BIS_fnc_dynamicText;
sleep 5;

_text = "<t size='.9' color='#FFFFFF'>Updating Leaderboard...</t>";
[_text,0,0,2,1] spawn BIS_fnc_dynamicText;
