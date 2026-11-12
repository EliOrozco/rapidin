class_name player extends CharacterBody3D

@export var base_speed : float = 10

var mult_speed : float
var total_speed : float
var target_velocity : Vector3 = Vector3.ZERO

func _ready() -> void:
	#sync ui
	%PlayerUi.setup_healtbar(%Combat.max_hp)
	%PlayerUi.update_healtbar(%Combat.max_hp)
	
	#conect signals
	%Combat.killed.connect(health_depleted)

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
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider : Node = collision.get_collider()
		
		if collider.is_in_group("enemy_projectile"):
			var e_proj : enemy_projectile = collider
			
			%Combat.take_damage(e_proj.damage)
			%PlayerUi.update_healtbar(%Combat.hp)
			%SoundPlayer.play_sound(sound_player.SOUNDS.HIT, true)
			
			e_proj.destroy()

func health_depleted() -> void:
	%SoundPlayer.play_sound(sound_player.SOUNDS.DEATH)
	Gm.set_player_movement(false)
