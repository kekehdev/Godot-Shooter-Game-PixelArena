extends CPUParticles2D

var alpha = 1
var fade = false

func _process(_delta):
	
	if fade:
		alpha = lerp(alpha, 0, .050)
		modulate.a = alpha
	
	if alpha <= .005:
		queue_free()


func _on_ParticleTimer_timeout():
	set_process_internal(false)


func _on_FadeTimer_timeout():
	fade = true
