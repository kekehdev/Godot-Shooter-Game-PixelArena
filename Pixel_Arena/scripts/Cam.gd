extends Camera2D

var shake_intensity = 0
var shake = false


func _ready():
	Global.cam = self


func _process(delta):
	zoom = lerp(zoom, Vector2(1, 1), .3)
	
	if shake:
		global_position += Vector2(rand_range(-shake_intensity, shake_intensity), rand_range(-shake_intensity, shake_intensity)) * delta


func shake_screen(intensity, time):
	shake_intensity = intensity
	
	#zoom = Vector2(1, 1) - Vector2(intensity * .002, intensity * .002)
	
	$ShakeTimer.wait_time = time
	$ShakeTimer.start()
	
	shake = true


func _on_ShakeTimer_timeout():
	shake = false
	global_position = Vector2(160, 90)


func _exit_tree():
	Global.cam = null
