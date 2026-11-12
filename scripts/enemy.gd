class_name enemy extends RigidBody3D

@export var proj : PackedScene
@export var xporb : PackedScene
@export_range(0.1, 10, 0.1) var cooldown : float = 3.0

func _ready() -> void:
	%Timer.wait_time = cooldown
	%_3d_healthbar.setup_healtbar(%Combat.max_hp)
	
	%Combat.killed.connect(health_depleted)

func _on_timer_timeout() -> void:
	var projectile_instance = proj.instantiate() as Node3D
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
	var xp_instance = xporb.instantiate() as Node3D
	get_tree().root.add_child(xp_instance)
	xp_instance.global_position = global_position
	
	%EnemyDeath.play()

func _on_enemy_death_finished() -> void:
	queue_free()
