class_name damage_number extends Sprite3D

@onready var damage_label: Label = $SubViewport/damage_label

func set_damage_number(element : String) -> void:
	damage_label.text = element

func _on_death_time_timeout() -> void:
	queue_free()
