class_name wave_manager extends Node

@export_range(5.0, 30.0, 1.0, "suffix:s") var wave_cooldown : float = 5
@export var current_mode : MODE = MODE.RUNNING
@export var spawnpoints : Array[enemy_spawner]
@export var waves : Array[wave]

enum MODE {
	WAITING,
	RUNNING
}

var waves_completed : int = 0
var enemies_amount : int = 0
var current_wave : wave
@onready var max_wave : String = str(waves.size())

func _ready() -> void:
	start_wave()
	%waves_total_label.text = max_wave
	
	for es : enemy_spawner in spawnpoints:
		es.enemy_died.connect(reduce_enemy_count)

func _process(_delta: float) -> void:
	match current_mode:
		MODE.WAITING:
			%time_label.text = "%0.2f" % %wave_cooldown.time_left
		MODE.RUNNING:
			%time_label.text = "%0.2f" % %wave_dur_remaining.time_left

func start_wave() -> void:
	if waves.size() > 0:
		#advance wave
		current_wave = waves.pop_front()
		current_mode = MODE.RUNNING
		
		#assign enemies
		assign_enemies_to_points()
		update_ui()
		
		#start timer
		%wave_dur_remaining.wait_time = current_wave.time
		%wave_dur_remaining.start()
		%time_content_label.text = "OLEADA"
	else:
		current_mode = MODE.WAITING
		%time_content_label.text = "GANASTE"

func assign_enemies_to_points() -> void:
	#get all enemies in wave
	var enemies : Array[PackedScene] = current_wave.enemy_and_amount.keys()
	
	for e : PackedScene in enemies:
		#connect enemy to enemy count
		enemies_amount += current_wave.enemy_and_amount[e]
		#choose random spawnpoint
		for i : int in range(enemies_amount):
			var selected_point : enemy_spawner = spawnpoints.pick_random()
			
			selected_point.add_enemies_to_list(e, 1)

func reduce_enemy_count() -> void:
	enemies_amount -= 1
	
	if enemies_amount == 0:
		enter_wave_cooldown()
		waves_completed += 1
	
	update_ui()

func update_ui() -> void:
	%waves_completed_label.text = str(waves_completed)
	%enemies_remaining_label.text = str(enemies_amount)

func enter_wave_cooldown() -> void:
	current_mode = MODE.WAITING
	%time_content_label.text = "PREPARACIÓN"
	%wave_cooldown.start(wave_cooldown)
	%wave_dur_remaining.stop()

func _on_wave_cooldown_timeout() -> void:
	start_wave()

func _on_wave_dur_remaining_timeout() -> void:
	%timeout_label.show()
	Gm.set_pause_mode(true)
