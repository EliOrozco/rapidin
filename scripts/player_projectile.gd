class_name player_projectile extends projectile

const DAMAGE_NUMBER : PackedScene = preload("uid://de2lfmlhoopkw")

#killswitch
func _on_timer_timeout() -> void:
	queue_free()

#override
func destroy() -> void:
	var damage_number_instance : damage_number = DAMAGE_NUMBER.instantiate()
	get_tree().root.add_child(damage_number_instance)
	damage_number_instance.set_damage_number(str(get_total_damage()))
	damage_number_instance.global_position = Vector3(global_position.x, global_position.y+1, global_position.z)
	
	queue_free()
