class_name level_manager extends Node

@onready var chooser: Control = $chooser
@onready var center: HBoxContainer = $chooser/MarginContainer/center

signal level_up(u : upgrade_details)

@export var current_xp : int
@export var current_level : int = 1
var pending_upgrades : int = 0

#nota para el futuro
#la función para calcular los niveles actualmente es:
#f(x) = ab^x
#donde a = 5; b = 1.35
#En desmos crea una lista: L = [1, ..., 10]
#Evalua la lista y redondea hacia abajo con: floor(f(L))
#TODO: Si se encuentra una mejor manera de hacer eso implementar después
#Mejor no tocar el export y se quedará por testing
@export var level_tresholds : Dictionary[int, int] = {
	1: 6,
	2: 9,
	3: 12,
	4: 16,
	5: 22,
	6: 30,
	7: 40,
	8: 55,
	9: 74,
	10: 100
}

func _ready() -> void:
	chooser.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		increase_level()

func increase_xp(amount : int) -> void:
	#print("XP recibida: ", amount, " | XP previa: ", current_xp)
	current_xp += amount
	
	while current_level < 10 and current_xp >= level_tresholds[current_level]:
		current_xp -= level_tresholds[current_level]
		increase_level()
	
	#print("Nivel final: ", current_level, " | XP sobrante tras bucle: ", current_xp)

func increase_level() -> void:
	if current_level >= level_tresholds.values()[-1]:
		return
	
	current_level += 1
	pending_upgrades += 1
	
	if not chooser.visible:
		choose_upgrade()

func choose_upgrade() -> void:
	Gm.set_pause_mode(true)
	chooser.show()

func any_upgrade_selected() -> void:
	pending_upgrades -= 1
	
	if pending_upgrades > 0:
		choose_upgrade()
	else:
		pending_upgrades = 0
		Gm.set_pause_mode(false)
		chooser.hide()

func _on_upgrade_card_got_selected(u: upgrade_details) -> void:
	level_up.emit(u)
	any_upgrade_selected()

func _on_upgrade_card_speed_got_selected(u: upgrade_details) -> void:
	level_up.emit(u)
	any_upgrade_selected()

func _on_upgrade_card_health_got_selected(u: upgrade_details) -> void:
	level_up.emit(u)
	any_upgrade_selected()
