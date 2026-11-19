class_name enemy_spawner extends Marker3D

@export var enemies_details : Array[PackedScene]
@export_range(0.5, 30.0, 0.5, "suffix:s") var cooldown : float = 7.0
@export var can_spawn : bool = true

signal enemy_died

func spawn_next() -> void:
	if enemies_details.size() > 0:
		var next : PackedScene = enemies_details.pop_front()
		var instance : enemy = next.instantiate()
		instance.is_dead.connect(enemy_has_died)
		
		get_tree().root.add_child(instance)
		instance.global_position = global_position
		%Cooldown.start(cooldown)

func enemy_has_died() -> void:
	enemy_died.emit()

func add_enemies_to_list(who : PackedScene, how_many : int) -> void:
	for i : int in range(how_many):
		enemies_details.append(who)

func _on_cooldown_timeout() -> void:
	if can_spawn:
		spawn_next()
