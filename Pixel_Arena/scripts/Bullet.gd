extends Sprite

export var speed = 150

var damage
var velocity = Vector2(1, 0)
var direction = true


func _process(delta):
	
	if direction:
		look_at(get_global_mouse_position())
		
		direction = false
	
	global_position += velocity.rotated(rotation) * speed * delta
	
	if global_position.x >= 325 or global_position.x <= -5 or global_position.y >= 185 or global_position.y <= -5:
		queue_free()
