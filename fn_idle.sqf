params ["_dog"];

_dog setVariable ["grad_dogs_state", "idling"];

// looping
[{
	params ["_args", "_handle"];
	_args params ["_dog"];

	// ends itself if dog had received another command
	if (_dog getVariable ["grad_dogs_state", "idling"] != "idling") exitWith {
		diag_log "grad dogs: dogidling exit";
	};

	private _currentAnimation = animationState _dog;

	switch (_currentAnimation) do {
		case "SitIdle": {
				// lie down with random chance and keep lying
				if (random 3 > 2.5) then {
					_dog playMoveNow "SitIdle";
				} else {
					_dog playMoveNow "LyingIdle";
				};
			};
			case "LyingIdle": {
				// search for nothing randomly or keep lying
				if (random 3 > 2.5) then {
					[_dog, objNull] call grad_dogs_fnc_search;
				} else {
					_dog playMoveNow "LyingIdle";
				};
			};
		// sit down when reaching position
		default { _dog playMoveNow "SitIdle"; };
	};

}, 1, [_dog]] call CBA_fnc_addPerFrameHandler;
