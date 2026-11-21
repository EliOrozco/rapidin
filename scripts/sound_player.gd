class_name sound_player extends Node

enum SOUNDS {
	HIT,
	DEATH,
	PICKUP,
	POWERUP
}

func play_sound(which : SOUNDS) -> void:
	match which:
		SOUNDS.HIT:
			%Hit.play()
		SOUNDS.DEATH:
			%Death.play()
		SOUNDS.PICKUP:
			%Pickorb.play()
		SOUNDS.POWERUP:
			%powerUp.play()
