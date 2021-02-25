extends Node

export (Array, PackedScene) var Enemies
export (Array, PackedScene) var Powers


func _ready():
	randomize()
	
	Global.parenting = self
	Global.score = 0


func _on_EnemySpawnTimer_timeout():
	var enemy_position = Vector2(rand_range(-20, 340), rand_range(-40, 220))
	var enemy_number = randi() % Enemies.size()
	
	while enemy_position.x < 320 and enemy_position.x > -10 and enemy_position.y < 180 and enemy_position.y > -20:
		enemy_position = Vector2(rand_range(-20, 340), rand_range(-40, 220))
	
	Global.instance_node(Enemies[enemy_number], enemy_position, self)


func _on_DifficultySpawnTimer_timeout():
	
	if $EnemySpawnTimer.wait_time >= .50:
		$EnemySpawnTimer.wait_time -= .025


func _on_PowerSpawnTimer_timeout():
	var power_position = Vector2(rand_range(5, 315), rand_range(5, 175))
	var power_number = randi() % Powers.size()
	
	Global.instance_node(Powers[power_number], power_position, self)


func _exit_tree():
	Global.parenting = null
