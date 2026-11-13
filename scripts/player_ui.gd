class_name player_ui extends Control

func setup_healthbar(max_value : int) -> void:
	%HealthBar.max_value = max_value
	%max_hp_label.text = str(max_value)
	%HealthBar.custom_maximum_size = Vector2(max_value * 15, 50)

func update_healthbar(value : int) -> void:
	%HealthBar.value = value
	%hp_label.text = str(value)

func setup_xpbar(max_value : int, level : int) -> void:
	%XpBar.max_value = max_value
	%xplabel.text = str(level)

func update_xp_bar(value : int) -> void:
	%XpBar.value = value
