class_name player extends CharacterBody3D

@export var base_speed : float = 10

var mult_speed : float
var total_speed : float
var target_velocity : Vector3 = Vector3.ZERO

func _ready() -> void:
	#sync ui
	%PlayerUi.setup_healthbar(%Combat.max_hp)
	%PlayerUi.update_healthbar(%Combat.max_hp)
	update_xp_ui()
	
	#conect signals
	%Combat.killed.connect(health_depleted)
	%LevelManager.level_up.connect(leveled_up)

func _physics_process(_delta: float) -> void:
	total_speed = base_speed * ( 1 + mult_speed)
	
	var input_direction : Vector3 = Vector3.ZERO
	
	if Gm.player_can_move:
		if Input.is_action_pressed("up"):
			input_direction.x += 1
		if Input.is_action_pressed("down"):
			input_direction.x -= 1
		if Input.is_action_pressed("left"):
			input_direction.z -= 1
		if Input.is_action_pressed("right"):
			input_direction.z += 1
	
	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized()
		#print(input_direction)
	
	target_velocity.x = input_direction.x * total_speed
	target_velocity.z = input_direction.z * total_speed
	
	#print(target_velocity)
	velocity = target_velocity
	
	move_and_slide()
	
	for i : int in get_slide_collision_count():
		var collision : KinematicCollision3D = get_slide_collision(i)
		var collider : Node = collision.get_collider()
		
		if collider.is_in_group("enemy_projectile"):
			%Combat.take_damage((collider as enemy_projectile).damage)
			%PlayerUi.update_healthbar(%Combat.hp)
			%SoundPlayer.play_sound(sound_player.SOUNDS.HIT)
			
			collider.destroy()
		
		
		if collider.is_in_group("collectable"):
			if collider is xp_orb:
				%LevelManager.increase_xp((collider as xp_orb).experience_amount)
				%PlayerUi.update_xp_bar(%LevelManager.current_xp)
				%SoundPlayer.play_sound(sound_player.SOUNDS.PICKUP)
				collider.queue_free()
		
		if collider.is_in_group("enemy"):
			%Combat.take_damage(1)
			%PlayerUi.update_healthbar(%Combat.hp)
			%SoundPlayer.play_sound(sound_player.SOUNDS.HIT)
			
			(collider as enemy).health_depleted()

func health_depleted() -> void:
	%SoundPlayer.play_sound(sound_player.SOUNDS.DEATH)
	Gm.set_pause_mode(true)
	$gameover_label.show()

func enemy_reached_killzone() -> void:
	%Combat.take_damage(2)
	%PlayerUi.update_healthbar(%Combat.hp)
	%SoundPlayer.play_sound(sound_player.SOUNDS.HIT)

#TODO: add tiered upgrades when they get added
func leveled_up(u : upgrade_details) -> void:
	update_xp_ui()
	%SoundPlayer.play_sound(sound_player.SOUNDS.POWERUP)
	match u.type:
		upgrade_details.TYPE.ATTACK:
			%PlayerProjectileSpawner.increase_base_damage_to_all_projectiles(1)
		upgrade_details.TYPE.SPEED:
			%PlayerProjectileSpawner.increase_cooldown_reduction(0.2)
		upgrade_details.TYPE.HEALTH:
			%Combat.take_heal(1)
			%PlayerUi.update_healthbar(%Combat.hp)


func update_xp_ui() -> void:
	%PlayerUi.setup_xpbar(%LevelManager.level_tresholds[%LevelManager.current_level], %LevelManager.current_level)
	%PlayerUi.update_xp_bar(%LevelManager.current_xp)

func _on_combat_got_hit() -> void:
	pass # Replace with function body.
