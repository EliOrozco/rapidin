class_name GameManager extends Node

var player_can_move : bool = true
var game_is_paused : bool = false

func set_player_movement(can_move : bool) -> void:
	player_can_move = can_move

func set_pause_mode(mode : bool) -> void:
	get_tree().paused = mode
	game_is_paused = mode

#Optimize with binary trees if neccesary
func choose_weighted(what : Array, weights : Array[int]) -> Variant:
	assert(what.size() == weights.size(), "Arrays should be the same size!")
	var total : int = 0
	
	for value : int in weights:
		total += value
	
	var random : int = randi_range(0, total-1)
	for i : int in what.size():
		if (random < weights[i]):
			return what[i]
		random -= weights[i]
	
	return null # should not be possible to reach here
