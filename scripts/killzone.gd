class_name killzone extends Area3D

@export var p : player

func _on_body_entered(body: Node3D) -> void:
	if body is enemy:
		(body as enemy).health_depleted()
		p.enemy_reached_killzone()
	else:
		body.queue_free()
