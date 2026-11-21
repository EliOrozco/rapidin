class_name upgrade_card extends Control

@export var upgrade : upgrade_details
@onready var blip_select: AudioStreamPlayer = $blipSelect

signal got_selected(u : upgrade_details)

func _on_button_pressed() -> void:
	got_selected.emit(upgrade)
	blip_select.play()
