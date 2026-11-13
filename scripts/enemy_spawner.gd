class_name enemy_spawner extends Marker3D

@export var enemies_details : Array[PackedScene]
@export_range(0.5, 30.0, 0.5, "suffix:s") var cooldown : float = 15.0
@export_range(0.0, 10.0, 0.5, "suffix:s") var delay : float = 0
@export var can_spawn : bool = true

func _ready() -> void:
	%Cooldown.wait_time = cooldown

func stop() -> void:
	%Cooldown.autostart = false
	%Cooldown.start() #to reset time IT DOES NOT PAUSE
	can_spawn = false

func start() -> void:
	%Cooldown.autostart = true
	can_spawn = true

func spawn_next() -> void:
	if enemies_details.size() > 0:
		var next : PackedScene = enemies_details.pop_front()
		var instance : Node3D = next.instantiate()
		
		get_tree().root.add_child(instance)
		instance.global_position = global_position
	else:
		stop()

func _on_cooldown_timeout() -> void:
	if can_spawn:
		spawn_next()

func _on_delay_timeout() -> void:
	%Cooldown.autostart = true
	%Cooldown.start()
	spawn_next()
