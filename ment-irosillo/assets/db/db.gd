extends Node

@export_file_path() var data_base_file:String

var db:SQLite
var id_user:int = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	db = SQLite.new()
	db.path = data_base_file
	db.open_db()
	create_tables()
	test_sql()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func test_sql() -> void:
	var query = "SELECT * FROM users;"
	db.query(query)
	for users in db.query_result:
		printt(users["id_user"], users["username"], users["creation_date"])

func insert_user (username:String) -> int:
	var query = "INSERT INTO users (username) VALUES ('%s')" % username
	db.query(query)
	id_user = db.last_insert_rowid
	return db.last_insert_rowid

func insert_score(user_id: int, coins: int) -> void:
	var query = "INSERT INTO scores (id_user, coins) VALUES (%d, %d)" % [user_id, coins]
	db.query(query)
	print("Score guardado para usuario ", user_id, ": ", coins, " coins")

func get_top_scores(limit: int = 10) -> Array:
	var query = " 
	SELECT u.username, s.coins, s.game_date 
	FROM scores s
	JOIN users u ON s.id_user = u.id_user
	ORDER BY s.coins DESC
	LIMIT %d
	" % limit
	db.query(query)
	return db.query_result

func create_tables() -> void:
	# Crear tabla de scores
	var query = "
	CREATE TABLE IF NOT EXISTS scores (
		id_score INTEGER PRIMARY KEY AUTOINCREMENT,
		id_user INTEGER NOT NULL,
		coins INTEGER NOT NULL,
		game_date DATETIME DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (id_user) REFERENCES users(id_user)
	);"
	db.query(query)
