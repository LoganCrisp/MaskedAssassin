extends Node

var target
var redDead = false
var blueDead = false
var blackDead = false
var yellowDead = false
var greenDead = false

#0 == Black, 1 == Green, 2 == YELLOW, 3 == RED, 4 == BLUE
func generateTarget():
	target = choose([0,1,2,3,4])
	
func choose(array):
	array.shuffle()
	return array.front()
	
func reset():
	redDead = false
	blueDead = false
	blackDead = false
	yellowDead = false
	greenDead = false
	
