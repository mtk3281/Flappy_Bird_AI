extends Node2D

onready var hud = $HUD
onready var obstacle_spawner = $obstacle_spawner
onready var ground = $ground
onready var menu_layer = $menu_layer
onready var timer = $Timer

var score = 0  setget set_score

var high_score = 0

const save_file_path = "user://savedata.save"

func _ready():
	obstacle_spawner.connect("obstacle_created", self, "_on_obstacle_created")
	load_high_score()

func new_game():
	self.score = 0
	obstacle_spawner.start()

func player_score():
	self.score  += 1

func set_score(new_score):
	score = new_score
	hud.update_score(score)

func _on_obstacle_created(obs):
	obs.connect("score",self,"player_score")

func _on_death_zone_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()
			
	if body is Aiplayer:
		if body.has_method("die"):
			body.die()

func _on_player_died():
	game_over()

func game_over():
	obstacle_spawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles","set_physics_process",false)
	if score > high_score:
		high_score=score
		save_high_score()
		
	menu_layer.init_game_over(score,high_score)


func _on_menu_layer_start_game():
	new_game()

func save_high_score():
	var save_data = File.new()
	save_data.open(save_file_path, File.WRITE)
	save_data.store_var(high_score)
	save_data.close()
	
func load_high_score():
	var save_data = File.new()
	if save_data.file_exists(save_file_path):
		save_data.open(save_file_path, File.READ)
		high_score=save_data.get_var()
		save_data.close()


func _on_player2_died():
	game_over()
