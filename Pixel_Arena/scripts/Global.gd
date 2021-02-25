extends Node

var parenting = null
var player = null
var cam = null

var score = 0
var high_score = 0


func instance_node(node, pos, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	
	node_instance.global_position = pos
	
	return node_instance


func save_score():
	var save = {
		'high_score': high_score
	}
	
	return save


func save_game():
	var game_saved = File.new()
	
	game_saved.open_encrypted_with_pass('user://gamesaved.save', File.WRITE, 'crypt')
	game_saved.store_line(to_json(save_score()))
	game_saved.close()


func load_game():
	var game_saved = File.new()
	
	if not game_saved.file_exists('user://gamesaved.save'):
		print('File not found!')
		
		return
	
	game_saved.open_encrypted_with_pass('user://gamesaved.save', File.READ, "crypt")
	
	var line = parse_json(game_saved.get_line())
	
	high_score = line['high_score']
	
	game_saved.close()
	
