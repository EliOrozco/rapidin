class_name enemy_projectile extends projectile

#killswitch
func _on_timer_timeout() -> void:
	queue_free()
