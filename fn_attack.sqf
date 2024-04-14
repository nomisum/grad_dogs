/*

*/

params ["_dog", "_unit"];

_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

_dog setVariable ["grad_dogs_state", "attacking"];

// looping
[{
	params ["_args", "_handle"];
	_args params ["_dog", "_unit"];

	// ends itself if dog had received another command
	if (_dog getVariable ["grad_dogs_state", "attacking"] != "attacking") exitWith {
		diag_log "grad dogs: dogattack exit";
	};

	// check if already near player
	private _isAroundPlayer = (getpos _dog) inArea [_unit, 2, 2, 0, false, 2];

	if (_isAroundPlayer) then {
		if (random 2 > 1) then {
			[_dog] call grad_dogs_fnc_bite;
		} else {
			[_dog] call grad_dogs_fnc_threaten;
		};
	} else {
		// moves dog close to unit
		private _targetPos = _unit getPos [0.2, _dog getDir _unit];
		private _speedmodeFast = speed _unit > _unit getSpeed "FAST";
		private _speedmodeSlow = speed _unit < _unit getSpeed "SLOW";
		private _distance = _unit distance _dog;

		if (_distance < 5) then {
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
