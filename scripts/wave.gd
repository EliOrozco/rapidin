class_name wave extends Resource
#maybe change to another type

@export_range(0.0, 300.0, 10.0, "suffix:s") var time : float = 30.0
@export var enemy_and_amount : Dictionary[PackedScene, int]
@export_range(1.0, 10.0, 1.0, "suffix:x") var diff_multiplier : float
