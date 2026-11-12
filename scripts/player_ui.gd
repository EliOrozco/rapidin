class_name player_ui extends Control

func setup_healtbar(max_value : int) -> void:
	%HealthBar.max_value = max_value
	%max_hp_label.text = str(max_value)
	%HealthBar.custom_maximum_size = Vector2(max_value * 15, 50)

func update_healtbar(value : int) -> void:
	%HealthBar.value = value
	%hp_label.text = str(value)
