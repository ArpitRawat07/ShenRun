extends Node

var saveData = {
	"level" : 1,
	"coins": 0,"players": 1,"tabaqui":0,"tau":0,
	"lily":0,"cyborg":0,"hinata":0,"shen":0,
	"level1":0,"level2":0,"level3":0,
	"level4":0,"level5":0
	}


#path string
var saveGameFileName: String = "user://playerData.txt"

func _ready() -> void :
	self.loadData()

	
func editData():
	saveData.level=Global.unlockedlevels
	saveData.coins=Global.Coins
	saveData.players=Global.maxplayer
	saveData["level1"]=Global.level_star["level1"]
	saveData["level2"]=Global.level_star["level2"]
	saveData["level3"]=Global.level_star["level3"]
	saveData["level4"]=Global.level_star["level4"]
	saveData["level5"]=Global.level_star["level5"]
	for c in Global.character_array:
		if c==2:
			saveData["tabaqui"]=2
		if c==3:
			saveData["tau"]=3
		if c==4:
			saveData["lily"]=4
		if c==5:
			saveData["cyborg"]=5
		if c==6:
			saveData["hinata"]=6
		if c==7:
			saveData["shen"]=7
	

# warning-ignore:function_conflicts_variable
func saveData() -> void:
	self.editData()
	
	var saveFile = File.new()
	saveFile.open(saveGameFileName,File.WRITE)
	
	saveFile.store_line(to_json(saveData))
	saveFile.close()
	


func loadData():
	var dataFile = File.new()
	
	#Make sure our file exists on the user system
	if not dataFile.file_exists(saveGameFileName):
		return #File doesn't exists
		
	#allow reading only for file
	dataFile.open(saveGameFileName, File.READ) 
	
	#loop through file line by line
	while dataFile.get_position() < dataFile.get_len():
		var nodeData = parse_json(dataFile.get_line())
		
		#grab saved data
		saveData.level=nodeData["level"]
		saveData.coins=nodeData["coins"]
		saveData.players=nodeData["players"]
		saveData.tabaqui=nodeData["tabaqui"]
		saveData.tau=nodeData["tau"]
		saveData.lily=nodeData["lily"]
		saveData.cyborg=nodeData["cyborg"]
		saveData.hinata=nodeData["hinata"]
		saveData.shen=nodeData["shen"]
		
		
		Global.unlockedlevels=nodeData["level"]
		Global.Coins=nodeData["coins"]
		Global.maxplayer=nodeData["players"]
		Global.level_star["level1"]=nodeData.level1
		Global.level_star["level2"]=nodeData.level2
		Global.level_star["level3"]=nodeData.level3
		Global.level_star["level4"]=nodeData.level4
		Global.level_star["level5"]=nodeData.level5
		if nodeData.tabaqui:
			Global.character_array.append(2)
		if nodeData.tau:
			Global.character_array.append(3)
		if nodeData.lily:
			Global.character_array.append(4)
		if nodeData.cyborg:
			Global.character_array.append(5)
		if nodeData.hinata:
			Global.character_array.append(6)
		if nodeData.shen:
			Global.character_array.append(7)
		
		dataFile.close()



func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		self.saveData()
		get_tree().quit()

