class_name combat extends Node

signal overhealed
signal killed
signal got_hit
signal invicibility_finished

@export var max_hp : int = 5
@export_range(0.0, 1, 0.1, "suffix:S") var invicibility : float

var hp : int

func _ready() -> void:
	hp = max_hp

func take_damage(amount : int) -> void:
	got_hit.emit()
	hp -= amount
	if hp <= 0:
		kill()
		
	if invicibility > 0:
		#var inv_timer : Timer = SceneTree.create_timer(invicibility)
		pass

func take_heal(amount : int) -> void:
	hp += amount
	if hp >= max_hp:
		overhealed.emit()

func kill() -> void:
	killed.emit()
	
