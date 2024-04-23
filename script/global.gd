extends Node

var player_current_attack = false
var sword_damage = 30
var spear_damage = 20

var current_scene = 'beach' #initialise variable to spawn beach
var transition_state = false #initialise transition state
var scene_destination = 'beach'

#initialise player position
var player_exit_position_x = 0
var player_exit_position_y = 0
var player_start_position_x = 0
var player_start_position_y = 0

func finish_transition():
	if transition_state == true:
		transition_state == false
