extends Control

@export var action_items: Array[StringName]

@onready var settings_grid_container = %GridContainer
@onready var main_menu_button = %MainMenuButton

		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_items = InputMap.get_actions()
	for action in action_items:
		if not action.contains("ui"):
			var label = Label.new()
			label.text = action
			settings_grid_container.add_child(label)
			var button = RemapButton.new()
			button.action = action
			settings_grid_container.add_child(button)


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/Main_Menu/main_menu.tscn")
