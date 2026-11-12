class_name sound_player extends Node

enum SOUNDS {
	HIT,
	DEATH
}

func play_sound(which : SOUNDS, pitch_variaton : bool = false) -> void:
	if pitch_variaton:
		match which:
			SOUNDS.HIT:
				%Hit.pitch_scale = randf_range(0.8, 1.2)
				%Hit.play()
			SOUNDS.DEATH:
				%Death.pitch_scale = randf_range(0.8, 1.2)
				%Death.play()
	
	
	else:
		match which:
			SOUNDS.HIT:
				%Hit.play()
			SOUNDS.DEATH:
				%Death.play()
