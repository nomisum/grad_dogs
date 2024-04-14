/*

*/

params ["_dog", "_unit"];

_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

_dog setVariable ["grad_dogs_state", "following"];

// looping
[{
	params ["_args", "_handle"];
	_args params ["_dog", "_unit"];

	// ends itself if dog had received another command
	if (_dog getVariable ["grad_dogs_state", "following"] != "following") exitWith {
		diag_log "grad dogs: dogfollow exit";
	};

	// check if already near player
	private _isAroundPlayer = (getpos _dog) inArea [_unit, 3, 3, 0, false, 10];

	if (_isAroundPlayer) then {
		[_dog] call grad_dogs_fnc_idle;
	} else {
		// moves dog close to unit
		private _targetPos = _unit getPos [2, getDir _unit];
		private _speedmodeFast = speed _unit > _unit getSpeed "FAST";
		private _speedmodeSlow = speed _unit < _unit getSpeed "SLOW";
		private _distance = _unit distance _dog;

		if (_distance < 15) then {
			if (_speedmodeSlow) then {
				_dog setSpeedMode "LIMITED";
			} else {
				if (_speedmodeFast) then {
					_dog setSpeedMode "FULL";
				} else {
					_dog setSpeedMode "NORMAL";
				};
			};
		} else {
			_dog setSpeedMode "FULL";
		};
		
		_dog moveTo _targetPos;
	};

}, 1, [_dog, _unit]] call CBA_fnc_addPerFrameHandler;



///////



	
		if !(alive BURK_dog) exitWith 
		{
			player removeAction Dogfollow;
			player removeAction dogseek;
			player removeAction Dogpassive;
			player removeAction Dogstay;
			player removeAction Dogrun;
			player removeAction Dogsprint;
			player removeAction agressiveAction;
			player removeAction passiveAction;
			playerHasDog = false;
		};
		if ((alive BURK_dog) && !(Agressive)) then 
		{
			BURK_dog moveTo getPos player;				
		};
		if ((alive BURK_dog) && (Agressive)) then 
		{
			// Scan
			_dogPos = getPos BURK_dog;

			_target = _dogPos nearEntities ["Man",50];
		
			_distanceArray = [];
			{
				if ((_x in units group player) || (_x == player) || (_x isKindOf "animal")) then
				{
					
				}
				else
				{	
					_tar = player distance _x;
					_distanceArray = _distanceArray + [[_tar,_x]];
				};	
			} forEach _target;

			if ((alive BURK_dog) && !(_distanceArray isEqualTo []) && (Agressive)) then 
			{
				_distanceArray sort true;
				_actualTarget = (_distanceArray select 0) select 1;
				_targetPos = getPos _actualTarget;

				_damage = damage _actualTarget;
				//hint str _distanceArray;
				if (random 1 > 0.5) then
				{	
					[BURK_dog,_actualTarget] say3d "growls3";
				};	

				BURK_dog moveTo _targetPos;

				if (BURK_dog distance _actualTarget < 2) then
				{
					[BURK_dog,_actualTarget] say3d "growls3"; //only the dog owner can here this sound...
					_dir = getDir BURK_dog;
					BURK_dog attachTo [_actualTarget, [0, -0.5, 0.1] ];
					_actualTarget say3d "pain";
					BURK_dog setDir _dir;
					[BURK_dog,_actualTarget] say3d "barkmean1";
					uiSleep 0.5; 
					_actualTarget setDamage _damage + 0.2;
					_actualTarget playMove "AmovPpneMstpSrasWrflDnon";
					detach BURK_dog;
					uiSleep 0.15; 
				};		
			}
			else	
			{
				BURK_dog moveTo getPos player;	
			};	
		};
		uiSleep 1;
	};
	uiSleep 1;	
};