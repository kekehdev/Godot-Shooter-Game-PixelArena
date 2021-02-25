extends 'res://scripts/entity/EnemyEntity.gd'


func _process(delta):
	basic_movement(delta)
	dies()
