extends CharacterBody2D

const speed = 100

var current_dir = "none"
var npc_in_range = false
var red_in_range = false
var blue_in_range = false
var green_in_range = false
var black_in_range = false
var yellow_in_range = false

@onready var label = $Label
@onready var timer = $Timer
@onready var chatter = $Chatter
@onready var music = $Music

func _ready():
	timer.start()
	chatter.play()
	music.play()
	$AnimatedSprite2D.play("front_idle")
	global.generateTarget()
	if global.target == 0:
		$BlackDesc.makeVisible()
	if global.target == 1:
		$GreenDesc.makeVisible()
	if global.target == 2:
		$YellowDesc.makeVisible()
	if global.target == 3:
		$RedDesc.makeVisible()
	if global.target == 4:
		$BlueDesc.makeVisible()
	

func _physics_process(delta):
	if (!chatter.playing):
		chatter.play()
	if (!music.playing):
		music.play()
	label.text = "%1d:%02d" % time_left_to_live()
	
	if global.target == 0 and Input.is_action_just_pressed("Note"):
		$BlackDesc.makeVisible()
	if global.target == 1 and Input.is_action_just_pressed("Note"):
		$GreenDesc.makeVisible()
	if global.target == 2 and Input.is_action_just_pressed("Note"):
		$YellowDesc.makeVisible()
	if global.target == 3 and Input.is_action_just_pressed("Note"):
		$RedDesc.makeVisible()
	if global.target == 4 and Input.is_action_just_pressed("Note"):
		$BlueDesc.makeVisible()
		
	if red_in_range  == true:
		if Input.is_action_just_pressed("chat"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/red_mask.dialogue"), "start")
			return
		if Input.is_action_just_pressed("eliminate"):
			global.redDead = true
	if blue_in_range == true:
		if Input.is_action_just_pressed("chat"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/blue_mask.dialogue"), "start")
			return
		if Input.is_action_just_pressed("eliminate"):
			global.blueDead = true
	if yellow_in_range == true:
		if Input.is_action_just_pressed("chat"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/yellow_mask.dialogue"), "start")
			return
		if Input.is_action_just_pressed("eliminate"):
			global.yellowDead = true
	if black_in_range == true:
		if Input.is_action_just_pressed("chat"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/black_mask.dialogue"), "start")
			return
		if Input.is_action_just_pressed("eliminate"):
			global.blackDead = true
	if green_in_range == true:
		if Input.is_action_just_pressed("chat"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/green_mask.dialogue"), "start")
			return
		if Input.is_action_just_pressed("eliminate"):
			global.greenDead = true
	player_movement(delta)

func player_movement(delta):
	
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("move_back"):
		current_dir = "back"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("move_foward"):
		current_dir = "foward"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D 
	
	if dir == "right":
		anim.flip_h = false
		if movement ==  1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement ==  1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "back":
		anim.flip_h = true
		if movement ==  1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if dir == "foward":
		anim.flip_h = true
		if movement ==  1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")

func _on_detection_area_body_entered(body):
	if body.has_method("npc"):
		npc_in_range = true
	if body.has_method("red_mask"):
		red_in_range = true
	if body.has_method("blue_mask"):
		blue_in_range = true
	if body.has_method("yellow_mask"):
		yellow_in_range = true
	if body.has_method("green_mask"):
		green_in_range = true
	if body.has_method("black_mask"):
		black_in_range = true
	
		


func _on_detection_area_body_exited(body):
	if body.has_method("npc"):
		npc_in_range = false
	if body.has_method("red_mask"):
		red_in_range = false
	if body.has_method("blue_mask"):
		blue_in_range = false
	if body.has_method("yellow_mask"):
		yellow_in_range = false
	if body.has_method("green_mask"):
		green_in_range = false
	if body.has_method("black_mask"):
		black_in_range = false
		

func time_left_to_live():
	var time_left = timer.time_left
	if (timer.is_stopped()):
		global.reset()
		get_tree().change_scene_to_file("res://scenes/gameLost.tscn")
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	if (minute == 0):
		label.add_theme_color_override("font_color", Color(1, 0, 0))
	return [minute, second]

func player():
	pass
	
