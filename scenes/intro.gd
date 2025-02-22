extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$IntroAnimationPlayer.play("Intro/FadeIn")
	await get_tree().create_timer(3.0).timeout
	$IntroAnimationPlayer.play("Intro/FadeOut")
	await $IntroAnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/Start.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
