class_name enemy extends RigidBody3D

signal is_dead

@export var proj : PackedScene
@export var xporb : PackedScene
@export_range(0.1, 10, 0.1) var cooldown : float = 3.0

func _ready() -> void:
	%Timer.wait_time = cooldown
	%_3d_healthbar.setup_healtbar(%Combat.max_hp)
	
	%Combat.killed.connect(health_depleted)

func _on_timer_timeout() -> void:
	var projectile_instance : Node3D = proj.instantiate()
	get_tree().root.add_child(projectile_instance)
	projectile_instance.global_position = global_position

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player_projectile"):
		var p_proj : player_projectile = body
		
		%Combat.take_damage(p_proj.damage)
		%_3d_healthbar.update_healtbar(%Combat.hp)
		%Click.play()
		
		p_proj.destroy()

func health_depleted() -> void:
	set_collision_enabled(false)
	var xp_instance : Node3D = xporb.instantiate()
	get_tree().root.add_child(xp_instance)
	xp_instance.global_position = global_position
	is_dead.emit()
	
	%EnemyDeath.play()

func set_collision_enabled(enabled: bool) -> void:
	%CollisionShape3D.set_deferred("disabled", not enabled)

func _on_enemy_death_finished() -> void:
	queue_free()
