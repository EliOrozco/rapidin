class_name level_manager extends Node

signal level_up

@export var current_xp : int
@export var current_level : int = 1

#nota para el futuro
#la función para calcular los niveles actualmente es:
#f(x) = ab^x
#donde a = 9; b = 1.35
#En desmos crea una lista: L = [1, ..., 10]
#Evalua la lista y redondea hacia abajo con: floor(f(L))
#TODO: Si se encuentra una mejor manera de hacer eso implementar después
#Mejor no tocar el export y se quedará por testing
@export var level_tresholds : Dictionary[int, int] = {
	1: 12,
	2: 16,
	3: 22,
	4: 29,
	5: 40,
	6: 54,
	7: 73,
	8: 99,
	9: 134,
	10: 180
}

func increase_xp(amount : int) -> void:
	current_xp += amount
	
	if current_xp >= level_tresholds[current_level]: #TODO: Maybe we can do better math here
		var remainder_xp = level_tresholds[current_level] - current_xp
		current_level += 1
		
		if current_level >= 10: #TODO: Hack for levels above cap, maybe not necessary if i can make it infinite
			current_level = 10
		
		level_up.emit()
		
		current_xp = remainder_xp
	
	
