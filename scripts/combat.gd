class_name combat extends Node

signal overhealed
signal killed

@export var max_hp : int = 5
var hp : int

func _ready() -> void:
	hp = max_hp

func take_damage(amount : int) -> void:
	hp -= amount
	if hp <= 0:
		kill()

func take_heal(amount : int) -> void:
	hp += amount
	if hp >= max_hp:
		overhealed.emit()

func kill() -> void:
	killed.emit()
	
