extends Node3D


@onready var timer = $Timer
@onready var hud = $hud

func _ready():
	Globals.coins = 0
	Globals.countdown = 60
	
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	hud.update_ui()

func _on_timer_timeout():
	Globals.countdown -= 1
	hud.update_ui()
	
	if Globals.countdown <= 0:
		timer.stop()
		game_over()

func game_over():
	hud.show_game_over()
	
	save_score_to_database()

func save_score_to_database():
	if DataBase.id_user <= 0:
		push_error("ERROR: No hay usuario activo")
		return
	
	var create_table = "
	CREATE TABLE IF NOT EXISTS scores (
		id_score INTEGER PRIMARY KEY AUTOINCREMENT,
		id_user INTEGER NOT NULL,
		coins INTEGER NOT NULL,
		game_date DATETIME DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (id_user) REFERENCES users(id_user)
	);
	"
	DataBase.db.query(create_table)
	
	var insert_query = "
	INSERT INTO scores (id_user, coins) 
	VALUES (%d, %d)
	" % [DataBase.id_user, Globals.coins]
	
	DataBase.db.query(insert_query)
	
	if DataBase.db.query_result.size() > 0:
		print("Score guardado: ", Globals.coins, " coins")
	else:
		print("Error al guardar score")
