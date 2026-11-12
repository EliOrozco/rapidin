class_name killzone extends Area3D

func _on_body_entered(_body: Node3D) -> void:
	_body.queue_free()
