class_name projectile extends RigidBody3D

@export var damage : int = 1
@export var extra_base_damage : int = 0

func destroy() -> void:
	#play some sound effect
	queue_free()

func add_extra_base_damage(amount : int) -> void:
	extra_base_damage += amount

func get_total_damage() -> int:
	return damage + extra_base_damage
