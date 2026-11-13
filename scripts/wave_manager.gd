class_name wave_manager extends Node

@export var spawnpoints : Array[enemy_spawner]
@export var waves : Array[wave]

var current_wave : int = 1
var enemies

func get_enemies(w : wave):
	w.enemy_type_amount
