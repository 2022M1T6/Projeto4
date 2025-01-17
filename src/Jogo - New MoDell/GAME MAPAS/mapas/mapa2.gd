extends Node2D

onready var _pause_menu = $InterfaceLayer/PauseMenu
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Checkpoint.coinsCollected=Checkpoint.coinsSaved
	Checkpoint.dimension=2
	if !MusicGlobal.is_playing:
		MusicGlobal.play_music4()
	Checkpoint.packed_scene.pack(get_tree().get_current_scene()) # Checkpoint chamado para salvar a cena mapa1 assim que o player entra
	ResourceSaver.save("res://my_scene.tscn", Checkpoint.packed_scene)


func _on_key_body_entered(body):
	$keySound.play()



func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()
	# The GlobalControls node, in the Stage scene, is set to process even
	# when the game is paused, so this code keeps running.
	# To see that, select GlobalControls, and scroll down to the Pause category
	# in the inspector.
	elif event.is_action_pressed("toggle_pause"):
		print()
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()
		get_tree().set_input_as_handled()


func _on_Area2D1_body_entered(body):
	if body.name == "Player":
		Checkpoint.coinsSaved=Checkpoint.coinsCollected
		$Enemy/Area2D1/CollisionShape2D.disabled=true
		Checkpoint.packed_scene2.pack(get_tree().get_current_scene())
		ResourceSaver.save("res://my_scene2.tscn", Checkpoint.packed_scene2)
		get_tree().change_scene("res://src2/Battle.tscn")


func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		Checkpoint.coinsSaved=Checkpoint.coinsCollected
		$Enemy2/Area2D2/CollisionShape2D.disabled=true
		Checkpoint.packed_scene2.pack(get_tree().get_current_scene())
		ResourceSaver.save("res://my_scene2.tscn", Checkpoint.packed_scene2)
		get_tree().change_scene("res://src2/Battle.tscn")

func _on_Area2D3_body_entered(body):
	if body.name == "Player":
		Checkpoint.coinsSaved=Checkpoint.coinsCollected
		$Enemy3/Area2D3/CollisionShape2D.disabled=true
		Checkpoint.packed_scene2.pack(get_tree().get_current_scene())
		ResourceSaver.save("res://my_scene2.tscn", Checkpoint.packed_scene2)
		get_tree().change_scene("res://src2/Battle.tscn")


func _on_Area2D4_body_entered(body):
	if body.name == "Player":
		Checkpoint.coinsSaved=Checkpoint.coinsCollected
		$Enemy4/Area2D4/CollisionShape2D.disabled=true
		Checkpoint.packed_scene2.pack(get_tree().get_current_scene())
		ResourceSaver.save("res://my_scene2.tscn", Checkpoint.packed_scene2)
		get_tree().change_scene("res://src2/Battle.tscn")


func _on_Instrucao_body_entered(body):
	get_tree().paused = true # Pausa o jogo
	
	
	if Global.lang==1:
		var dialog = Dialogic.start("map2_eng") # A variável recebe a timeline Instrução1

		dialog.pause_mode = Node.PAUSE_MODE_PROCESS # Pausado ou não, este nó será processado.
		dialog.connect('timeline_end', self, 'continua4') # # Conecta o fim do diálogo com uma função que dará instruções sobre o que fazer quando esse diálogo acabar
		add_child(dialog) 

	if Global.lang==2:
		var dialog = Dialogic.start("map2_port") # A variável recebe a timeline Instrução1

		dialog.pause_mode = Node.PAUSE_MODE_PROCESS # Pausado ou não, este nó será processado.
		dialog.connect('timeline_end', self, 'continua4_port') # # Conecta o fim do diálogo com uma função que dará instruções sobre o que fazer quando esse diálogo acabar
		add_child(dialog) 


func continua4(timeline_map2_eng):
	get_tree().paused = false # Despausa o jogo
	$Instrucao/CollisionShape2D.disabled = true # Desativa a colisão da area2d (a que ativa a instrução)

func continua4_port(timeline_map2_port):
	get_tree().paused = false # Despausa o jogo
	$Instrucao/CollisionShape2D.disabled = true # Desativa a colisão da area2d (a que ativa a instrução)
