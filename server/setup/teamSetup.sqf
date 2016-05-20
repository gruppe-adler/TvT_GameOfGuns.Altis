/* Randomizes teams as per mission parameters
*
* Executed via init.sqf on server
*/

sleep 5;

{
	_x setVariable ["isTeamlead", false, true];
	_x setVariable ["spawnpos", [0,0,0], true];
} forEach playableUnits;


//Define TEAMLEADERS if random groups are off ==================================
if (!(RANDOMTEAMS) || ((count playableUnits) == 1)) then {
		TEAMLEADERS = [];
		{
			_groupLeader = leader _x;
			_groupLeader setVariable ["isTeamlead", true, true];
			TEAMLEADERS = TEAMLEADERS + [_groupleader];
		} forEach allGroups;
	};

//Define Teams and TEAMLEADERS if random groups are on =========================
if (RANDOMTEAMS) then {
	["Randomizing teams...",0,0,2,0.3] remoteExec ["BIS_fnc_dynamicText",0,false];
	sleep 5;

	private ["_players","_numberOfTeams", "_teammember", "_teamleadernames", "_teamleadID"];
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

//Set groupnames ===============================================================
{
	//replace spaces in names
	_leaderName = [name leader _x] call mcd_fnc_strToLoadout;

	//save groupname in players
	_groupname = format ["group%1",_leaderName];
	_x setVariable ["groupname", _groupname, true];

	//create score variables
	if (isNil _groupname) then {
		call compile (format ["%1 = 0", _groupname]);
		diag_log format ["teamSetup.sqf - score variable %1 created.", _groupname];
	};
} forEach playableUnits;

//Add killed EHs ===============================================================
{
	[_x] call mcd_fnc_addKilledEH;
} forEach playableUnits;

//Done =========================================================================
TEAMSETUPDONE = true;
publicVariable "TEAMSETUPDONE";
