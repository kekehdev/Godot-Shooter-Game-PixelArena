extends CanvasLayer

var size = 16


func _ready():
	Global.load_game()
	
	$HighScoreLabel.text = 'High Score: ' + str(Global.high_score)


func _process(_delta):
	$ScoreLabel.text = 'Score: ' + str(Global.score)
	
	if Global.score >= Global.high_score:
		Global.high_score = Global.score


func _on_change_lives(value):
	$LiveRect.rect_size.x = value * size
