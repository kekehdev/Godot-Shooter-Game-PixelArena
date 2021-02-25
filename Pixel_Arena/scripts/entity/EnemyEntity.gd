extends Sprite

export var hp = 3
export var speed = 50
export var retreat = 400
export var point_kill = 1

var velocity = Vector2.ZERO
var is_hited = false
var Blood_Particle = preload('res://scenes/BloodParticle.tscn')


func basic_movement(delta):
	
	if Global.player != null and !is_hited:
		velocity = global_position.direction_to(Global.player.global_position)
		global_position += velocity * speed * delta
	else:
		velocity = lerp(velocity, Vector2.ZERO, .3)
		global_position += velocity * delta


func _on_HitArea_area_entered(area):
	
	if area.is_in_group('bullet') and !is_hited:
		hp -= area.get_parent().damage
		is_hited = true
		velocity = -velocity * retreat
		
		$RetreatTimer.start()
		area.get_parent().queue_free()
	
	if area.is_in_group('player'):
		hp -= area.get_parent().damage
		
		is_hited = true
		velocity = -velocity * retreat
		
		$RetreatTimer.start()


func _on_RetreatTimer_timeout():
	is_hited = false


func dies():
	
	if hp <= 0 and Global.parenting != null:
		var blood_particle = Global.instance_node(Blood_Particle, global_position, Global.parenting)
		
		Global.score += point_kill
		blood_particle.rotation = velocity.angle()
		
		if Global.cam != null:
			Global.cam.shake_screen(60, .1)
		
		queue_free()
