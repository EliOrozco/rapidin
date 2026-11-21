class_name upgrade_details extends Resource

enum TYPE {
	ATTACK,
	SPEED,
	HEALTH
}

@export var type : TYPE
@export var level : int = 1
