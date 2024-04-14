/*

*/

params ["_dog", ["_object", objNull]];

_dog setVariable ["grad_dogs_state", "searching"];

// looping
[{
	params ["_args", "_handle"];
	_args params ["_dog", "_object"];

	// ends itself if dog had received another command
	if (_dog getVariable ["grad_dogs_state", "searching"] != "searching") exitWith {
		diag_log "grad dogs: dogsearch exit";
	};

	// randomly sniffing if no actual search is done
	private _fakeSearch = isNull _object;

	if (_fakeSearch) then {
		// random target pos
		private _target = _dog getvariable ["grad_dogs_sniffTarget", _dog getPos [5 + random 5, random 360]];
		_dog setVariable ["grad_dogs_sniffTarget", _target];
		private _tryingToReachCount = _dog getvariable ["grad_dogs_sniffTargetCount", 0];

		if (_dog distance _target < 2 || _tryingToReachCount > 6) then {
			_target setVariable ["grad_dogs_sniffTarget", _dog getPos [5 + random 5, random 360]];
		} else {
			_dog moveTo _target;
			_tryingToReachCount = _tryingToReachCount + 1;
			_dog setvariable ["grad_dogs_sniffTargetCount", _tryingToReachCount];
		};
	
	} else {
		// moves dog close to unit
		private _targetPos = _object getPos [2, getDir _object];
		private _speedmodeUnit = speedmode _object;
		private _distance = _object distance _dog;
		_dog moveTo _targetPos;

		if (_distance < 15) then {
			_dog setSpeedMode _speedmodeUnit;
		} else {
			_dog setSpeedMode "FULL";
		};
	};

}, 1, [_dog, _object]] call CBA_fnc_addPerFrameHandler;
