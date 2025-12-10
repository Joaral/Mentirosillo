extends Node3D



@onready var timer = $Timer
@onready var hud = $hud

var frases = [
	"Sigue tus sueños",
	"Tienes 2 neuronas luchando por el tercer lugar",
	"No eres GAY",
	"Te pareces a Sam, eres votasnte de VOX",
	"No eres adoptado, eres su mascota",
	"Te quiero"
]

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	hud.update_ui()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	for power_up in $Powerups.get_children():
		power_up.suelta_frase.connect(_on_suelta_frase())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_timer_timeout():
	Globals.countdown -= 1
	hud.update_ui()
	
	if Globals.countdown <= 0:
		timer.stop()
		game_over()


func game_over():
	hud.show_game_over()
	
	DataBase.save_score ()

func _on_suelta_frase():
	var frase = frases.pick_random()
	$hud/Verdades.text = "[rainbow][tornado]"+ frase +"[rainbow][tornado]"

func _on_power_ups_you_win() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$You_win.visible = true
