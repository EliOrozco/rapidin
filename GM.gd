class_name GameManager extends Node

var player_can_move : bool = true
var game_is_paused : bool = false

func set_player_movement(can_move : bool) -> void:
	player_can_move = can_move

func set_pause_mode(mode : bool) -> void:
	get_tree().paused = mode
	game_is_paused = mode
