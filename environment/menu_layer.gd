extends CanvasLayer

signal start_game

onready var start_msg = $Start_menu/start_msg
onready var tween = $Tween
onready var score_label = $game_over_menu/VBoxContainer/score_label
onready var high_score_label = $game_over_menu/VBoxContainer/high_score_label
onready var game_over_menu = $game_over_menu

var game_started = false

func _input(event):
	if event.is_action_pressed("flap") and !game_started:
		emit_signal("start_game")
		game_started = true
		tween.interpolate_property(start_msg,"modulate:a",1,0,0.5)
		tween.start()

func init_game_over(score,high_score):
	score_label.text=str("SCORE : ",score)
	high_score_label.text=str("HIGH SCORE : ",high_score) 
	game_over_menu.visible=true
	
func _on_restart_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
