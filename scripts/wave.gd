class_name wave extends Resource
#maybe change to another type

@export_range(0.0, 300.0, 10.0, "suffix:s") var time : float = 30.0
@export var enemy_type_amount : Dictionary[PackedScene, int]
@export_range(1.0, 10.0, 1.0, "suffix:x") var diff_multiplier : float

func _init(p_time : float, p_list : Dictionary[PackedScene, int], p_diff : float) -> void:
	time = p_time
	enemy_type_amount = p_list
	diff_multiplier = p_diff
