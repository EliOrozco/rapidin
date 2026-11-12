class_name _3d_health_bar extends Sprite3D

func _ready() -> void:
	##BUG: Cannot be assigned on editor, error on exporting
	texture = $SubViewport.get_texture()

func setup_healtbar(max_value : int) -> void:
	%HealthBar.max_value = max_value

func update_healtbar(value : int) -> void:
	%HealthBar.value = value
