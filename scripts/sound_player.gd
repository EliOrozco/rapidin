class_name sound_player extends Node

enum SOUNDS {
	HIT,
	DEATH,
	PICKUP
}

func play_sound(which : SOUNDS, pitch_variaton : bool = false) -> void:
	if pitch_variaton:
		match which:
			SOUNDS.HIT:
				%Hit.play()
			SOUNDS.DEATH:
				%Death.play()
			SOUNDS.PICKUP:
				%Pickorb.play()
	
	
	else:
		match which:
			SOUNDS.HIT:
				%Hit.pitch_scale = 1.0
				%Hit.play()
			SOUNDS.DEATH:
				%Death.pitch_scale = 1.0
				%Death.play()
			SOUNDS.PICKUP:
				%Pickorb.pitch_scale = 1.0
				%Pickorb.play()
