/* Randomizes teams as per mission parameters
*
* Executed via init.sqf on server
*/

private ["_players","_numberOfTeams", "_teammember", "_teamleadernames", "_teamleadID"];

waitUntil {!isNil "VOTINGDONE"};
waitUntil {VOTINGDONE};

if (count playableUnits <= 2) then {
	TEAMSIZE = 1;
	publicVariable "TEAMSIZE";
};

//Setup for each player ========================================================
{
	_x setVariable ["isTeamlead", false, true];
	_x setVariable ["spawnpos", [0,0,0], true];
	_x setVariable ["kills", 0, true];
	_x setVariable ["deaths", 0, true];
	_x setVariable ["longestKill", 0, true];
	/*[_x] call mcd_fnc_addKilledEH;*/
} forEach playableUnits;

//Define TEAMLEADERS if random groups are off ==================================
if (!(RANDOMTEAMS) || ((count playableUnits) == 1)) then {
	TEAMLEADERS = [];
	{
		if (count units _x > 0) then {
			_groupLeader = leader _x;
			_groupLeader setVariable ["isTeamlead", true, true];
			TEAMLEADERS = TEAMLEADERS + [_groupleader];
		};
	} forEach allGroups;
};

//Define Teams and TEAMLEADERS if random groups are on =========================
if (RANDOMTEAMS) then {
	["Randomizing teams...",0,0,2,0.3] remoteExec ["BIS_fnc_dynamicText",0,false];
	sleep 5;

	diag_log "Team randomizer starting...";

	_players = playableUnits;
	_numberOfTeams = ceil ((count _players) / TEAMSIZE);
	TEAMLEADERS = [];
	_teamleadernames = [];

	//Delete existing groups
	{
		[_x] joinSilent grpNull;
	} forEach _players;

	//Enough players?
	if (_numberOfTeams < 2) then {
		diag_log "Unable to randomize teams - not enough players.";
		diag_log format ["Number of players: %1", (count _players)];
		diag_log format ["Teamsize selected: %1", TEAMSIZE];
		_numberOfTeams = 2;
	}
	else
	{
		diag_log format ["Randomizing %1 players into %2 teams", (count _players), _numberOfTeams];
	};

	if (count playableUnits == 1) then {
		_numberOfTeams = 1;
	};

	//Select teamleaders
	for [{_i = 0},{_i < _numberOfTeams},{_i = _i + 1}] do {
		_teamlead = selectRandom _players;
		_teamlead setVariable ["isTeamlead", true, true];
		_players = _players - [_teamlead];
		TEAMLEADERS = TEAMLEADERS + [_teamlead];
	};

	//Teamleader names for log
	{
		_teamleadernames = _teamleadernames + [name _x];
	} forEach TEAMLEADERS;

	diag_log format ["Teamleaders selected: %1", _teamleadernames];

	//Add remaining players to teamleaders
	for [{_i = 0},{_i < (TEAMSIZE - 1)}, {_i = _i + 1}] do {
		_teamleadID = 0;
		{
			if ((count _players) == 0) then {
				diag_log "No more players to add to teamleaders - uneven teams";
			}
			else
			{
				_teammember = selectRandom _players;
				_players = _players - [_teammember];
				[_teammember] joinSilent _x;
				diag_log format ["%1 added to %2's team.", (name _teammember), (_teamleadernames select _teamleadID)];
			};

			_teamleadID = _teamleadID +1;

		} forEach TEAMLEADERS;
	};
};

//Save teammates ===============================================================
{
	_teamleader = _x;
	{
		_unit = _x;
		_teammates = [];
		{
			_teammate = getPlayerUID _x;
			_teammates pushBack _teammate;
		} forEach (units group _unit);
		_unit setVariable ["teammates", _teammates, true];
		diag_log format ["Teammates for %1 are: %2.",(name _unit), _teammates];
	} forEach (units group _teamleader);
} forEach TEAMLEADERS;

//Set groupnames ===============================================================
CURRENTRANKING = [];
{
	_group = _x;
	if (isPlayer (leader _group)) then {
		_leaderName = [name leader _group] call mcd_fnc_strToVar;
		_groupName = format ["group_%1", _leaderName];
		_groupDisplayName = if (TEAMSIZE > 1) then {format ["Team %1", _leaderName]} else {_leaderName};

		//create score variable
		call compile (format ["%1 = 0; publicVariable '%1'", _groupname, _groupDisplayName]);
		diag_log format ["teamSetup.sqf - score variable %1 created.", _groupname];

		//save groupname in players
		_groupPlayers = [];
		{
			_unit = _x;
			_groupPlayers pushBack (name _unit);
			_unit setVariable ["groupname", _groupname, true];
			_unit setVariable ["groupdisplayname", _groupDisplayName, true];
		} forEach (units _group);

		//add to ranking array
		call compile (format ["
			CURRENTRANKING pushBack [0, '%1', '%2', %3];
		", _groupDisplayName, _groupName, _groupPlayers])
	};
} forEach allGroups;
publicVariable "CURRENTRANKING";

//Set uniforms =================================================================
call compile preprocessFileLineNumbers "uniformConfig.sqf";

["Randomizing team uniforms...",0,0,2,0.3] remoteExec ["BIS_fnc_dynamicText",0,false];
sleep 3;
{
	_teamleader = _x;

	//select uniform
	_uniformsLeft = count randomUniforms;
	_randomID = round (random (_uniformsLeft-1));
	_uniform = randomUniforms select _randomID;
	randomUniforms deleteAt _randomID;

	//refill uniform array if all used up
	if (count randomUniforms == 0) then {
		call compile preprocessFileLineNumbers "uniformConfig.sqf";
	};

	//set variable
	{
		_x setVariable ["myUniform", _uniform, true];
	} forEach (units group _teamleader);

	diag_log format ["teamSetup.sqf - %1's team will wear uniform: %2", _teamleader, _uniform];
} foreach TEAMLEADERS;
[] remoteExec ["mcd_fnc_addGear", 0, false];
sleep 2;

//Done =========================================================================
TEAMSETUPDONE = true;
publicVariable "TEAMSETUPDONE";
