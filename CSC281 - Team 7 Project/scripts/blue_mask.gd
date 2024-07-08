extends CharacterBody2D

const speed = 30
var current_state = IDLE

var dir = Vector2.RIGHT
var start_pos

var roaming = true
var chatting = false
var targeted = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
	if global.target == 4:
		targeted = true
func _process(delta):
	var anim = $AnimatedSprite2D
	if current_state == 1 or current_state == 0:
		$AnimatedSprite2D.play("blue_idle")
	elif current_state == 2 and !chatting:
		if dir.x == -1:
			anim.flip_h = true
			$AnimatedSprite2D.play("blue_walk_e")
		if dir.x == 1: 
			anim.flip_h = false
			$AnimatedSprite2D.play("blue_walk_e")
		if dir.y == -1: 
			anim.flip_h = true
			$AnimatedSprite2D.play("blue_walk_n")
		if dir.y == 1: 
			anim.flip_h = false
			$AnimatedSprite2D.play("blue_walk_s")
	
	if roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
				
	if global.blueDead == true:
		roaming = false
		global.reset()
		if targeted == true:
			global.reset()
			get_tree().change_scene_to_file("res://scenes/gameWin.tscn")
		else:
			global.reset()
			get_tree().change_scene_to_file("res://scenes/gameLost.tscn")

		
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if !chatting:
		velocity = dir * speed
		move_and_slide()
		

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		chatting = true


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		chatting = false


func _on_timer_timeout():
	$Timer.wait_time = choose([0.5,1.0,1.5])
	current_state = choose([IDLE,NEW_DIR,MOVE])
	
func npc():
	pass
	
func blue_mask():
	pass
