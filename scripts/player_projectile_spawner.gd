class_name player_projectile_spawner extends Node3D

@export var proj : PackedScene
@export_range(0.1, 10.0, 0.1) var cooldown : float = 1.0

func _ready() -> void:
	%Timer.wait_time = cooldown

func _on_timer_timeout() -> void:
	var projectile_instance : Node3D = proj.instantiate()
	get_tree().root.add_child(projectile_instance)
	projectile_instance.global_position = global_position #has to be after adding to scene
