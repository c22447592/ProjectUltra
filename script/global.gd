extends Node

<<<<<<< HEAD
var player_current_attack = false

var current_scene = 'beach' #initialise variable to spawn beach
var transition_scene = false #initialise transition state
=======
var transition_state = false #initialise transition state
var scene_destination = 'beach'
>>>>>>> 9add64083822397e6a9b93048c9866a2af75d24c

#initialise player position
var player_exit_position_x = 0
var player_exit_position_y = 0
var player_start_position_x = 0
var player_start_position_y = 0

func finish_transition():
	if transition_state == true:
		transition_state == false
