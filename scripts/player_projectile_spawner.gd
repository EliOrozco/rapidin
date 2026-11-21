class_name player_projectile_spawner extends Node3D

@export var proj : PackedScene
@export_range(0.1, 10.0, 0.1) var cooldown : float = 1.0
@export var extra_base_damage : int

func _ready() -> void:
	%Timer.wait_time = cooldown

func _on_timer_timeout() -> void:
	var projectile_instance : player_projectile = proj.instantiate()
	get_tree().root.add_child(projectile_instance)
	
	projectile_instance.global_position = global_position #has to be after adding to scene
	projectile_instance.add_extra_base_damage(extra_base_damage)

func increase_base_damage_to_all_projectiles(amount : int) -> void:
	extra_base_damage += amount
