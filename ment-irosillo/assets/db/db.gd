extends Node

@export_file_path() var data_base_file:String

var db:SQLite
var id_user:int = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	db = SQLite.new()
	db.path = data_base_file
	db.open_db()
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
