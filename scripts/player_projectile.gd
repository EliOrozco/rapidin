class_name player_projectile extends projectile

#killswitch
func _on_timer_timeout() -> void:
	queue_free()
