extends Node2D

signal score

var SPEED = 215


func _physics_process(delta):
	position.x +=  -SPEED * delta
	if global_position.x <= -200:
		queue_free()

func _on_wall_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()
	if body is Aiplayer:
		body.die()


func _on_score_area_body_exited(body):
	if body is Player:
		$point.play()
		emit_signal("score")

func _on_change_pos_ai_body_entered(body):
	if body is Aiplayer:
		body.change_pos()
