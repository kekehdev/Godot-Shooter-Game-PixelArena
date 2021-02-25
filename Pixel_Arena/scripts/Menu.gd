extends Control


func _on_btnStart_pressed():
	get_tree().change_scene('res://scenes/stages/Arena.tscn')


func _on_btnCredits_pressed():
	get_tree().change_scene('res://scenes/stages/Credits.tscn')
