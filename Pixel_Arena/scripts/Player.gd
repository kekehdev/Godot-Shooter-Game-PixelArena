extends Sprite

signal change_lives(value)

var Bullet = preload('res://scenes/Bullet.tscn')

export var speed = 100

var max_lives = 3
var lives = max_lives
var damage = 1
var damage_default = damage
var velocity = Vector2.ZERO
var reload_time_default = .2
var reload_time_reset = reload_time_default
var is_reloaded = true
var reset_power = []


func _ready():
	Global.player = self
	
	connect("change_lives", get_parent().get_node('HUD'), '_on_change_lives')
	emit_signal("change_lives", max_lives)


func _process(delta):
	velocity.x = int(Input.is_action_pressed('move_right')) - int(Input.is_action_pressed('move_left'))
	velocity.y = int(Input.is_action_pressed('move_down')) - int(Input.is_action_pressed('move_up'))
	velocity = velocity.normalized()
	
	global_position += velocity * speed * delta
	
	global_position.x = clamp(global_position.x, 7, 313)
	global_position.y = clamp(global_position.y, 7, 173)
	
	if Input.is_action_pressed('shoot') and Global.parenting != null and is_reloaded:
		var bullet = Global.instance_node(Bullet, global_position, Global.parenting)
		bullet.damage = damage
		is_reloaded = false
		
		$ReloadTimer.start()


func _on_ReloadTimer_timeout():
	is_reloaded = true
	
	$ReloadTimer.wait_time = reload_time_default


func _on_HitArea_area_entered(area):
	
	if area.is_in_group('enemy'):
		lives -= 1
		
		emit_signal("change_lives", lives)
		
	if lives <= 0:
		Global.save_game()
		get_tree().change_scene('res://scenes/stages/Menu.tscn')


func _on_PowerTimer_timeout():
	
	if reset_power.find('reload_time_default') != null:
		reload_time_default = reload_time_reset
		
		reset_power.erase('reload_time_default')
	
	if reset_power.find('damage') != null:
		damage = damage_default
		
		reset_power.erase('damage')


func _exit_tree():
	Global.player = null
