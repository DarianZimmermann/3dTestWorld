extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_pressed() -> void:
	Global.next_Scene = "res://World/world.tscn"
	get_tree().change_scene_to_file("res://Menus/Loading_Screen/loading_screen.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/Options/options.tscn")
