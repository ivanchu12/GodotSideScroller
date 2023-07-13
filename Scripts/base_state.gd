class_name base_state
extends Node

var animation_cond = "parameters/conditions/idle"
var animation_speed = 1


enum states {
	Null,
	idle,
	run,
	jump,
	fall,
	crouch,
	landing
}

var player: CharacterBody2D

func enter():
	player.sprite.offset = Vector2(0,0) 
	player.animation_player = animation_speed
	player.animation_tree[animation_cond] = true
	
func exit():
	player.animation_tree[animation_cond] = false

func input(event: InputEvent):
	return states.Null
	
func process(delta: float):
	return states.Null
	
func physics_process(delta: float):
	return states.Null
