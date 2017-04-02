/*
	"Hotel Invasion" v2.1 static mission for Tanoa.
	Created by [CiC]red_ned using templates by eraser1
	18 years of CiC
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_cash"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [12437.3,14207.5,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[									
								"easy",
								"easy",
								"easy",
								"easy",
								"moderate",
								"moderate",
								"moderate",
								"difficult",
								"difficult",
								"hardcore"
							];
//choose mission difficulty and set value and is also marker colour
_difficultyM = selectRandom _PossibleDifficulty;

switch (_difficultyM) do
{
	case "easy":
	{
		_difficulty = "easy";									//AI difficulty
		_AICount = (7 + (round (random 5)));					//AI starting numbers
		_AIMaxReinforcements = (5 + (round (random 10)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 5)));					//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (4 + (round (random 4)));						//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
		_cash = (500 + round (random (500)));					//this gives 250 to 750 cash			
		_crate_weapons0 	= (5 + (round (random 20)));		//Crate 0 weapons number
		_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
		_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
		_crate_weapons1 	= (4 + (round (random 2)));			//Crate 1 weapons number
		_crate_items1 		= (10 + (round (random 40)));		//Crate 1 items number
		_crate_backpacks1 	= (1 + (round (random 8)));			//Crate 1 back packs number
	};
	case "moderate":
	{
		_difficulty = "moderate";
		_AICount = (10 + (round (random 5))); 
		_AIMaxReinforcements = (7 + (round (random 10)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (5 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (500 + round (random (750)));					//this gives 500 to 1250 cash			
		_crate_weapons0 	= (10 + (round (random 15)));
		_crate_items0 		= (10 + (round (random 15)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (6 + (round (random 3)));
		_crate_items1 		= (20 + (round (random 30)));
		_crate_backpacks1 	= (5 + (round (random 4)));
	};
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (13 + (round (random 7)));
		_AIMaxReinforcements = (10 + (round (random 10)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (750 + round (random (1000)));					//this gives 750 to 1750 cash		
		_crate_weapons0 	= (30 + (round (random 20)));
		_crate_items0 		= (15 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (8 + (round (random 3)));
		_crate_items1 		= (30 + (round (random 20)));
		_crate_backpacks1 	= (6 + (round (random 4))); 
	};
	//case "hardcore":
	default
	{
		_difficulty = "hardcore"; 
		_AICount = (15 + (round (random 10)));
		_AIMaxReinforcements = (15 + (round (random 10)));
		_AItrigger = (15 + (round (random 5)));
		_AIwave = (6 + (round (random 2)));
		_AIdelay = (55 + (round (random 120)));
		_cash = (1000 + round (random (1500)));					//this gives 1000 to 2500 cash			
		_crate_weapons0 	= (20 + (round (random 5)));
		_crate_items0 		= (20 + (round (random 5)));
		_crate_backpacks0 	= (2 + (round (random 1)));
		_crate_weapons1 	= (10 + (round (random 2)));
		_crate_items1 		= (40 + (round (random 10)));
		_crate_backpacks1 	= (10 + (round (random 2)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
							[
									[12284.2,14233.4,0],
									[12285.6,14239.6,0],
									[12345.2,14207.3,0],
									[12373.2,14197.8,0],
									[12395.4,14184.6,0],
									[12410.2,14184.1,0],
									[12425.2,14183.8,0],
									[12447.8,14184.8,0],
									[12467.2,14188.4,0],
									[12489.2,14189.3,0], 
									[12482.3,14205.3,0],
									[12488.5,14213.7,0],
									[12472.1,14232,0],
									[12496.1,14236.3,0],
									[12517.4,14223.1,0],
									[12531.7,14265.6,0],
									[12585,14266.2,0],
									[12617.2,14166.9,0],
									[12516.1,14193.7,0],
									[12455.1,14228.5,0],
									[12436.7,14237.7,0],
									[12385.2,14225.1,0],
									[12444.7,14208.9,0],
									[12430.7,14206.2,0],
									[12417.6,14223.6,0],
									[12434.5,14223.8,0.232742],
									[12434.8,14213.3,0.250225],
									[12465.3,14149.3,0],
									[12459.4,14120.4,0],
									[12407.9,14265.3,0],
									[12452,14275.9,0],
									[12440.4,14228.9,0.0927734],
									[12514.8,14229.8,0.211414],
									[12422.1,14174.8,0],
									[12439,14172.9,0],
									[12464.6,14176.4,0]
							];

_group =
			[
				_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
				_AICount,											// Set in difficulty select
				_difficulty,										// Set in difficulty select
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;

//Reduce Static guns if mission is easy
if (_difficultyM isEqualTo "easy") then {
_staticGuns =
				[
					[
						[12343.4,14212.7,0.0848351],
						[12279.9,14227,0],
						[12448.1,14229.6,0.129326],
						[12438.8,14224.2,0.232151],
						[12518,14229.3,0.13847],
						[12496,14241.8,0],
						[12491.6,14214.1,0],
						[12526.2,14191.5,0],
						[12436.1,14174.8,0],
						[12410.8,14192.6,0],
						[12364.5,14207.5,0],
						[12415.3,14243,0]
					],
					_group,
					"assault",
					_difficulty,
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIStaticMG;
										} else
										{
_staticGuns =
				[
					[
						_pos vectorAdd [0,0,0],		// center pos
						[12343.4,14212.7,0.0848351],
						[12279.9,14227,0],
						[12448.1,14229.6,0.129326],
						[12438.8,14224.2,0.232151],
						[12518,14229.3,0.13847],
						[12496,14241.8,0],
						[12491.6,14214.1,0],
						[12526.2,14191.5,0],
						[12465.6,14191.5,0],
						[12436.1,14174.8,0],
						[12410.8,14192.6,0],
						[12395.5,14194.5,0],
						[12364.5,14207.5,0],
						[12415.3,14243,0]
					],
					_group,
					"assault",
					_difficulty,
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIStaticMG;
										};

// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =
								[
									[[12497.5,14210.5,0.139198],"I_CargoNet_01_ammo_F"],
									[[12523.2,14228.5,0.16119],"I_CargoNet_01_ammo_F"],
									[[12436.9,14216.2,0.228447],"I_CargoNet_01_ammo_F"],
									[[12404.2,14196,0.325665],"I_CargoNet_01_ammo_F"],
									[[12499.8,14191.3,0.167206],"I_CargoNet_01_ammo_F"],
									[[12453.8,14173.9,0.317108],"I_CargoNet_01_ammo_F"],
									[[12415.8,14173.4,0.32922],"I_CargoNet_01_ammo_F"],
									[[12428.7,14172.9,0.289165],"I_CargoNet_01_ammo_F"],
									[[12471.7,14195.7,0.413441],"I_CargoNet_01_ammo_F"]
								];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;

// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;
_crate1 = [_crateClasses_and_Positions select 1 select 1, _crateClasses_and_Positions select 1 select 0] call DMS_fnc_SpawnCrate;

// Enable smoke on the crates due to size of area
{
	_x setVariable ["DMS_AllowSmoke", true];
} forEach [_crate0,_crate1];

// Define mission-spawned AI Units
_missionAIUnits =
					[
						_group 		// We only spawned the single group for this mission
					];

// Define the group reinforcements
_groupReinforcementsInfo =
							[
								[
									_group,			// pass the group
									[
										[
											0,		// Let's limit number of units instead...
											0
										],
										[
											_AIMaxReinforcements,	// Maximum units that can be given as reinforcements (defined in difficulty selection).
											0
										]
									],
									[
										_AIdelay,		// The delay between reinforcements. >> you can change this in difficulty settings
										diag_tickTime
									],
									_AISoldierSpawnLocations,
									"random",
									_difficulty,
									_side,
									"reinforce",
									[
										_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
										_AIwave			// X reinforcement units per wave. >> you can change this in mission difficulty section
									]
								]
							];

// setup crates with items from choices
_crate_loot_values0 =
						[
							_crate_weapons0,		// Set in difficulty select - Weapons
							_crate_items0,			// Set in difficulty select - Items
							_crate_backpacks0 		// Set in difficulty select - Backpacks
						];
_crate_loot_values1 =
						[
							_crate_weapons1,		// Set in difficulty select - Weapons
							_crate_items1,			// Set in difficulty select - Items
							_crate_backpacks1 		// Set in difficulty select - Backpacks
						];

// add cash to _crate0
_crate0 setVariable ["ExileMoney", _cash,true];						
						
// Define mission-spawned objects and loot values with vehicle
_missionObjs =
				[
					_staticGuns,			// static gun(s). Note, we don't add the base itself because it already spawns on server start.
					[],						// no vehicle prize
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]
				];	
											
// Define Mission Start message
_msgStart = ['#FFFF00',format["A hotel is being invaded by %1 terrorists",_difficultyM]];

// Define Mission Win message defined in vehicle choice
_msgWIN = ['#0080ff',"Convicts have successfully cleared the hotel and stolen all the crates"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Invaders have stripped the hotel of loot and left."];

// Define mission name (for map marker and logging)
_missionName = "Hotel Invasion";

// Create Markers
_markers =
			[
				_pos,
				_missionName,
				_difficultyM
			] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [150,150];

_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
			[
				_pos,
				[
					[
						"kill",
						_group
					],
					[
						"playerNear",
						[_pos,100]
					]
				],
				_groupReinforcementsInfo,
				[
					_time,
					DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
				],
				_missionAIUnits,
				_missionObjs,
				[_missionName,_msgWIN,_msgLOSE],
				_markers,
				_side,
				_difficultyM,
				[[],[]]
			] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));
	
	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;

	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;

	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};

// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;

if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};
