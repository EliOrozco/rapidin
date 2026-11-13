class_name player extends CharacterBody3D

@export var base_speed : float = 10

var mult_speed : float
var total_speed : float
var target_velocity : Vector3 = Vector3.ZERO

func _ready() -> void:
	#sync ui
	%PlayerUi.setup_healthbar(%Combat.max_hp)
	%PlayerUi.update_healthbar(%Combat.max_hp)
	leveled_up() #update for xp bar ui
	
	#conect signals
	%Combat.killed.connect(health_depleted)
	%LevelManager.level_up.connect(leveled_up)

func _process(_delta: float) -> void:
	pass

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
			%SoundPlayer.play_sound(sound_player.SOUNDS.HIT, true)
			
			collider.destroy()
		
		
		if collider.is_in_group("collectable"):
			if collider is xp_orb:
				%LevelManager.increase_xp((collider as xp_orb).experience_amount)
				%PlayerUi.update_xp_bar(%LevelManager.current_xp)
				%SoundPlayer.play_sound(sound_player.SOUNDS.PICKUP, true)
				collider.queue_free()

func health_depleted() -> void:
	%SoundPlayer.play_sound(sound_player.SOUNDS.DEATH)
	Gm.set_player_movement(false)

func leveled_up() -> void:
	%PlayerUi.setup_xpbar(%LevelManager.level_tresholds[%LevelManager.current_level], %LevelManager.current_level)
	%PlayerUi.update_xp_bar(%LevelManager.current_xp)
