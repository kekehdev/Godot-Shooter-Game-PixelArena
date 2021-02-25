extends Sprite

export(String) var variable_name
export(float) var variable_value
export(float) var power_time


func _process(_delta):
	yield($Anim, "animation_finished")
	$Anim.play("idle")


func _on_HitArea_area_entered(area):
	
	if area.is_in_group('player'):
		area.get_parent().set(variable_name, variable_value)
		area.get_parent().get_node('PowerTimer').wait_time = power_time
		area.get_parent().get_node('PowerTimer').start()
		area.get_parent().reset_power.append(name)
		
		queue_free()
