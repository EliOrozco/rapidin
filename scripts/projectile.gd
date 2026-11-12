class_name projectile extends RigidBody3D

@export var damage : int = 1

func destroy() -> void:
	#play some sound effect
	queue_free()
