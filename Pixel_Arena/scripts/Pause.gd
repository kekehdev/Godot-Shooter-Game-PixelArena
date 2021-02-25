extends CanvasLayer


func _ready():
	pause_visible(false)


func _input(event):
	
	if event.is_action_pressed('ui_cancel'):
		pause_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused
		offset = Vector2(0, 0)


func pause_visible(is_visible):
	
	for node in get_children():
		node.visible = is_visible


func _on_btnResume_pressed():
	get_tree().paused = false
	pause_visible(false)


func _on_btnPause_pressed():
	pause_visible(!get_tree().paused)
	get_tree().paused = !get_tree().paused
	offset = Vector2(0, 0)
