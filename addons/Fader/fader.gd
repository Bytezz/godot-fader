## Coded by Bytez
## https://github.com/bytezz/godot-fader
## ----
## Hide/Show any node with a fade animation
## (for Godot Game Engine).

extends Node
class_name Fader

const _fadeAnimatorScene = preload("fadeAnimator.tscn")

static func fade_in(node:Node, seconds:float=1.0) -> void:
	fade(node, seconds, true)

static func fade_out(node:Node, seconds:float=1.0) -> void:
	fade(node, seconds, false)

static func fade(node:Node, seconds:float=1.0, fadeIn:bool=true) -> void:
	var fadeAnimator = _fadeAnimatorScene.instance()
	yield(Engine.get_main_loop(),"idle_frame")
	Engine.get_main_loop().root.add_child(fadeAnimator)
	fadeAnimator.root_node = Engine.get_main_loop().root.get_path()
	fadeAnimator.get_animation("Fade").track_set_path(0, str(node.get_path()) + ":modulate:a")
	fadeAnimator.get_animation("Fade").track_set_path(1, str(node.get_path()) + ":visible")
	
	fadeAnimator.playback_speed = 1/seconds
	
	if fadeIn:
		fadeAnimator.play("Fade")
	else:
		fadeAnimator.play_backwards("Fade")
	
	yield(fadeAnimator, "animation_finished")
	fadeAnimator.queue_free()

