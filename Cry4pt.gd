extends Node

var config = {
    "unlock_key": KEY_END,
    "stop_key": KEY_DELETE,
    "enable_logs": true,
    "enable_notifications": false,
    "infinite_values": false
}

var prop_items = [
	"prop_picnic", "prop_canvas", "prop_bush", "prop_rock", "prop_fish_trap", "prop_fish_ocean",
	"prop_island_tiny", "prop_island_med", "prop_island_big", "prop_boombox", "prop_well",
	"prop_campfire", "prop_chair", "prop_chair", "prop_chair", "prop_chair", "prop_table", "prop_therapy_seat", "prop_toilet", "prop_whoopie", 
	"prop_beer", "prop_greenscreen", "prop_portable_bait"
]

var achievement_ids = [
	"camp_tier_2", "camp_tier_3", "camp_tier_4", "catch_100_fish", "catch_single_fish", 
	"journal_normal", "journal_shining", "journal_glistening", "journal_opulent", "journal_radiant", "journal_alpha", 
	"rank_25", "rank_5", "rank_50", "10k_cash", "spectral_rod"
]

var tags = [
	"first_join",
	"journal_all",
	"journal_0", "journal_1", "journal_2", "journal_3", "journal_4", "journal_5",
	"spectral", "Cry4pt"   
]

var lake_fishes = [
    "fish_lake_alligator", "fish_lake_axolotl", "fish_lake_bass", "fish_lake_bluegill",
    "fish_lake_bowfin", "fish_lake_bullshark", "fish_lake_carp", "fish_lake_catfish",
    "fish_lake_crab", "fish_lake_crappie", "fish_lake_crayfish", "fish_lake_drum",
    "fish_lake_frog", "fish_lake_gar", "fish_lake_golden_bass", "fish_lake_goldfish",
    "fish_lake_guppy", "fish_lake_kingsalmon", "fish_lake_koi", "fish_lake_leech",
    "fish_lake_mooneye", "fish_lake_muskellunge", "fish_lake_perch", "fish_lake_pike",
    "fish_lake_pupfish", "fish_lake_rainbowtrout", "fish_lake_salmon", "fish_lake_snail",
    "fish_lake_sturgeon", "fish_lake_toad", "fish_lake_turtle", "fish_lake_walleye"
]

var ocean_fishes = [
    "fish_ocean_angelfish", "fish_ocean_atlantic_salmon", "fish_ocean_bluefish",
    "fish_ocean_clownfish", "fish_ocean_coalacanth", "fish_ocean_dogfish", "fish_ocean_eel",
    "fish_ocean_flounder", "fish_ocean_golden_manta_ray", "fish_ocean_greatwhiteshark",
    "fish_ocean_grouper", "fish_ocean_hammerhead_shark", "fish_ocean_herring", "fish_ocean_krill",
    "fish_ocean_lionfish", "fish_ocean_lobster", "fish_ocean_manowar", "fish_ocean_manta_ray",
    "fish_ocean_marlin", "fish_ocean_octopus", "fish_ocean_oyster", "fish_ocean_sawfish",
    "fish_ocean_sea_turtle", "fish_ocean_seahorse", "fish_ocean_shrimp", "fish_ocean_squid",
    "fish_ocean_stingray", "fish_ocean_sunfish", "fish_ocean_swordfish", "fish_ocean_tuna",
    "fish_ocean_whale", "fish_ocean_wolffish"
]

var prop_items_name = {
    "prop_beer": {"name": "6-Pack Prop"}, 
    "prop_boombox": {"name": "Royalty Free Boombox Prop"}, 
    "prop_bush": {"name": "Bush Prop"}, 
    "prop_campfire": {"name": "Campfire Prop"}, 
    "prop_canvas": {"name": "Canvas Prop"}, 
    "prop_chair": {"name": "Chair Prop"}, 
    "prop_greenscreen": {"name": "Green Screen Prop"}, 
    "prop_island_big": {"name": "Large Island Enterance"}, 
    "prop_island_med": {"name": "Medium Island Enterance"}, 
    "prop_island_tiny": {"name": "Tiny Island Enterance"}, 
    "prop_picnic": {"name": "Picnic Blanket Prop"}, 
    "prop_rock": {"name": "Rock Prop"}, 
    "prop_table": {"name": "Table Prop"}, 
    "prop_test": {"name": "Test Prop"}, 
    "prop_therapy_seat": {"name": "Therapy Seat Prop"}, 
    "prop_toilet": {"name": "Toilet Prop"}, 
    "prop_well": {"name": "Well Prop"}, 
    "prop_whoopie": {"name": "Fart Balloon Prop"}
}

var location_options = [
    {"name": "femur", "pos": Vector3(-60.074898, 9.245501, -82.422333)},
    {"name": "humerus", "pos": Vector3(-75.53138, 14.245501, 59.472553)},
    {"name": "rib", "pos": Vector3(116.037743, 9.245501, -128.430939)},
    {"name": "skull", "pos": Vector3(131.739334, 9.245501, -175.030334)},
    {"name": "spine", "pos": Vector3(-41.378189, 0.299282, 68.465637)},
    {"name": "grave", "pos": Vector3(44.278168, 28.745499, 64.597)},
    {"name": "dock_1", "pos": Vector3(148.018265, 4.2455, 1.502616)},
    {"name": "dock_2", "pos": Vector3(152.740799, 0.494552, -147.50383)},
    {"name": "shop_1", "pos": Vector3(130.251297, 0.086336, -411.182526)},
    {"name": "shop_2", "pos": Vector3(119.170868, 0.683763, -146.366425)},
    {"name": "sell", "pos": Vector3(36.45966, 4.2455, -52.532875)},
    {"name": "special", "pos": Vector3(-14.638267, 4.2455, -71.057274)},
    {"name": "void", "pos": Vector3(-295.243011, 1.256929, -399.407013)}
]

var initialization_in_progress = false
var initialization_completed = true
var was_player_present = false
var continue_loop = true
var continue_spam = false
var loadedin = false
var plactor
var player_options = []
var items_to_send = []

var punchenabled = true
var spam_mode_active = false
var spam_timer: Timer = null
var spam_targets = {}  
var spam_notification_suppressed = false 

const DEFAULT_FLIGHT_SPEED = 10.0
const FLIGHT_ACCEL = 10000.0
const FLIGHT_VERTICAL_SPEED = DEFAULT_FLIGHT_SPEED - 4.0
const BOOST_MULTI = 2.0
const DELTA_DAMP = 20.0

var flight_velocity = Vector3()
var flying = false
var vertical_velocity = 0.0
var flight_direction = Vector3()
var final_velocity = Vector3()
var flight_speed = DEFAULT_FLIGHT_SPEED

signal start_initialization
signal unlock
signal complete
signal stop
signal reset
signal clear
signal toggle_logs
signal toggle_notifications
signal set_infinite_values
signal set_unlock_key
signal set_stop_key

signal level
signal money
signal rod_power
signal rod_speed
signal rod_chance
signal rod_luck
signal buddy
signal buddy_speed
signal loan
signal max_bait
signal fish_caught

signal give
signal letter
signal deny
signal nuke
signal teleport
signal size

signal leave
signal rejoin
signal join
signal serverhop
signal exit

signal rod
signal beer
signal scratch
signal chest
signal ring
signal label

signal fly
signal punch
signal clone
signal crash
signal advert

func detect_players_on_join():
    while continue_loop:
        yield(get_tree().create_timer(2), "timeout")
        var current_scene = get_tree().current_scene
        if current_scene == null:
            print("[Lobby Checker] No current scene found.")
            continue
        var player_node = current_scene.get_node_or_null("Viewport/main/entities/player")
        if player_node == null:
            was_player_present = false
        else:
            if not was_player_present:
                yield(on_player_join(), "completed")
                continue_loop = false
            was_player_present = true

func on_player_join():
    yield(get_tree().create_timer(1), "timeout")
    PlayerData._send_notification("[REJOINED]")
    return "completed"
    
var refresh_timer: Timer

func _ready():
    _refresh_players()

func _enter_tree():
    var node = get_node("/root/CommandsEx")
    
    node.register_command("cry4pt", "start_initialization", self, "start_initialization_command")
    node.register_command("unlock", "unlock", self, "unlock_command")
    node.register_command("complete", "complete", self, "complete_command")
    node.register_command("stop", "stop", self, "stop_command")
    node.register_command("reset", "reset", self, "reset_command")
    node.register_command("clear", "clear", self, "clear_command")
    node.register_command("logs", "toggle_logs", self, "toggle_logs_command")
    node.register_command("notifications", "toggle_notifications", self, "toggle_notifications_command")
    node.register_command("infinite", "set_infinite_values", self, "set_infinite_values_command")
    node.register_command("set_unlock", "set_unlock_key", self, "set_unlock_key_command")
    node.register_command("set_stop", "set_stop_key", self, "set_stop_key_command")

    node.register_command("level", "level", self, "level")
    node.register_command("money", "money", self, "money")
    node.register_command("rod_power", "rod_power", self, "rod_power")
    node.register_command("rod_speed", "rod_speed", self, "rod_speed")
    node.register_command("rod_chance", "rod_chance", self, "rod_chance")
    node.register_command("rod_luck", "rod_luck", self, "rod_luck")
    node.register_command("buddy", "buddy", self, "buddy")
    node.register_command("buddy_speed", "buddy_speed", self, "buddy_speed")
    node.register_command("loan", "loan", self, "loan")
    node.register_command("max_bait", "max_bait", self, "max_bait")
    node.register_command("fish_caught", "fish_caught", self, "fish_caught")

    node.register_command("give", "give", self, "give")
    node.register_command("letter", "letter", self, "letter")
    node.register_command("deny", "deny", self, "deny")
    node.register_command("nuke", "nuke", self, "nuke")
    node.register_command("teleport", "teleport", self, "teleport")
    node.register_command("size", "size", self, "size")

    node.register_command("leave", "leave", self, "leave")
    node.register_command("rejoin", "rejoin", self, "rejoin")
    node.register_command("join", "join", self, "join")
    node.register_command("serverhop", "serverhop", self, "serverhop")
    node.register_command("exit", "exit", self, "exit")

    node.register_command("rod", "rod", self, "rod")
    node.register_command("beer", "beer", self, "beer")
    node.register_command("scratch", "scratch", self, "scratch")
    node.register_command("chest", "chest", self, "chest")
    node.register_command("ring", "ring", self, "ring")
    node.register_command("label", "label", self, "label")

    node.register_command("fly", "fly", self, "fly")
    node.register_command("punch", "punch", self, "punch")
    node.register_command("clone", "clone", self, "clone")
    node.register_command("crash", "crash", self, "crash")
    node.register_command("advert", "advert", self, "advert")
    
    refresh_timer = Timer.new()
    refresh_timer.wait_time = 1
    refresh_timer.autostart = true
    refresh_timer.connect("timeout", self, "_refresh_players")
    add_child(refresh_timer)

func start_initialization_command(text, args):
    if initialization_completed and not initialization_in_progress:
        _local_chat_reset()
        log_message("[RUNNING]")
        _start_initialization()
    else:
        log_message("[ALREADY RUNNING]")
        
func unlock_command(text, args):
    if args.size() > 1:
        match args[1]:
            "cosmetics":
                _unlock_cosmetics()
            "tacklebox":
                _unlock_baits_and_lures()
            "props":
                _unlock_props_spectral()
            "achievements":
                _unlock_achievements()
            "tags":
                _obtain_tags()
            "cosmetic":
                if args.size() > 2 and args[2] == "all":
                    _unlock_cosmetics()
                elif args.size() > 2:
                    var cosmetic_name = args[2]
                    _unlock_specific_cosmetic(cosmetic_name)
                else:
                    PlayerData._send_notification("Usage: unlock cosmetic {cosmetic_name} or unlock cosmetic all")
            "prop":
                if args.size() > 2 and args[2] == "all":
                    _unlock_props()
                elif args.size() > 3:
                    var prop_name = args[2]
                    var quantity = int(args[3])
                    _unlock_specific_prop(prop_name, quantity)
                elif args.size() > 2:
                    var prop_name = args[2]
                    _unlock_specific_prop(prop_name)
                else:
                    PlayerData._send_notification("Usage: unlock prop {prop_name} [quantity] or unlock prop all")
            "tag":
                if args.size() > 2 and args[2] == "all":
                    _obtain_tags()
                elif args.size() > 2:
                    var tag_name = args[2]
                    _unlock_specific_tag(tag_name)
                else:
                    PlayerData._send_notification("Usage: unlock tag {tag_name} or unlock tag all")
            "lure":
                if args.size() > 2 and args[2] == "all":
                    _unlock_lures()
                elif args.size() > 2:
                    var lure_name = args[2]
                    _unlock_specific_lure(lure_name)
                else:
                    PlayerData._send_notification("Usage: unlock lure {lure_name} or unlock lure all")
            "bait":
                if args.size() > 2 and args[2] == "all":
                    _unlock_baits()
                elif args.size() > 2:
                    var bait_name = args[2]
                    _unlock_specific_bait(bait_name)
                else:
                    PlayerData._send_notification("Usage: unlock bait {bait_name} or unlock bait all")
            "achievement":
                if args.size() > 2 and args[2] == "all":
                    _unlock_achievements()
                elif args.size() > 2:
                    var achievement_name = args[2]
                    _unlock_specific_achievement(achievement_name)
                else:
                    PlayerData._send_notification("Usage: unlock achievement {achievement_name} or unlock achievement all")
            _:
                PlayerData._send_notification("Usage: unlock [cosmetics | tacklebox | props | achievements | tags | cosmetic {cosmetic_name} | prop {prop_name} [quantity] | prop all | tag {tag_name} | lure {lure_name} | bait {bait_name}]")
    else:
        PlayerData._send_notification("Usage: unlock [cosmetics | tacklebox | props | achievements | tags | cosmetic {cosmetic_name} | prop {prop_name} [quantity] | prop all | tag {tag_name} | lure {lure_name} | bait {bait_name}]")

func _unlock_specific_lure(lure_name: String):
    if PlayerData.LURE_DATA.has(lure_name):
        var display_name = PlayerData.LURE_DATA[lure_name].get("name", "UNKNOWN_LURE")

        if not PlayerData.lure_unlocked.has(lure_name):
            PlayerData.lure_unlocked.append(lure_name)
            notification_message("[LURE UNLOCKED] " + "[" + display_name + "]")
            log_message("[LURE UNLOCKED] " + "[" + display_name + "]")
        else:
            notification_message("[LURE ALREADY UNLOCKED] " + "[" + display_name + "]")
            log_message("[LURE ALREADY UNLOCKED] " + "[" + display_name + "]")
    else:
        notification_message("[LURE NOT FOUND] " + "[" + lure_name + "]")
        log_message("[LURE NOT FOUND] " + "[" + lure_name + "]")

func _unlock_specific_bait(bait_name: String):
    if PlayerData.BAIT_DATA.has(bait_name):
        var display_name = PlayerData.BAIT_DATA[bait_name].get("name", "UNKNOWN_BAIT")

        if not PlayerData.bait_unlocked.has(bait_name):
            PlayerData.bait_unlocked.append(bait_name)
            PlayerData._refill_bait(bait_name, false)
            notification_message("[BAIT UNLOCKED] " + "[" + display_name + "]")
            log_message("[BAIT UNLOCKED] " + "[" + display_name + "]")
        else:
            notification_message("[BAIT ALREADY UNLOCKED] " + "[" + display_name + "]")
            log_message("[BAIT ALREADY UNLOCKED] " + "[" + display_name + "]")
    else:
        notification_message("[BAIT NOT FOUND] " + "[" + bait_name + "]")
        log_message("[BAIT NOT FOUND] " + "[" + bait_name + "]")

func _unlock_specific_achievement(achievement_name: String):
    if achievement_ids.has(achievement_name):
        Network._unlock_achievement(achievement_name)
        notification_message("[ACHIEVEMENT UNLOCKED] " + "[" + achievement_name + "]")
        log_message("[ACHIEVEMENT UNLOCKED] " + "[" + achievement_name + "]")
    else:
        notification_message("[ACHIEVEMENT NOT FOUND] " + "[" + achievement_name + "]")
        log_message("[ACHIEVEMENT NOT FOUND] " + "[" + achievement_name + "]")

func _unlock_specific_tag(tag_name: String):
    if tags.has(tag_name):
        if not PlayerData.saved_tags.has(tag_name):
            PlayerData.saved_tags.append(tag_name)
            notification_message("[TAG UNLOCKED] " + "[" + tag_name + "]")
            log_message("[TAG UNLOCKED] " + "[" + tag_name + "]")
        else:
            notification_message("[TAG ALREADY UNLOCKED] " + "[" + tag_name + "]")
            log_message("[TAG ALREADY UNLOCKED] " + "[" + tag_name + "]")
    else:
        notification_message("[TAG NOT FOUND] " + "[" + tag_name + "]")
        log_message("[TAG NOT FOUND] " + "[" + tag_name + "]")

func _unlock_specific_prop(prop_name: String, quantity: int = 1):
    if prop_items_name.has(prop_name):
        var display_name = prop_items_name[prop_name].get("name", "UNKNOWN_ITEM")
        
        if prop_name == "prop_chair":
            var current_quantity = _get_item_quantity(prop_name)
            var max_quantity = 4 
            
            if current_quantity + quantity <= max_quantity:
                for i in range(quantity):
                    PlayerData._add_item(prop_name)
                notification_message("[PROP UNLOCKED] " + "[" + display_name + "] x" + str(quantity))
                log_message("[PROP UNLOCKED] " + "[" + display_name + "] x" + str(quantity))
            else:
                notification_message("[PROP LIMIT REACHED] " + "[" + display_name + "]")
                log_message("[PROP LIMIT REACHED] " + "[" + display_name + "]")
        else:
            var max_quantity = 1 
            var current_quantity = _get_item_quantity(prop_name)

            if current_quantity < max_quantity:
                PlayerData._add_item(prop_name)
                notification_message("[PROP UNLOCKED] " + "[" + display_name + "]")
                log_message("[PROP UNLOCKED] " + "[" + display_name + "]")
            else:
                notification_message("[ALREADY HAVE ITEM] " + "[" + display_name + "]")
                log_message("[ALREADY HAVE ITEM] " + "[" + display_name + "]")
    else:
        notification_message("[PROP NOT FOUND] " + "[" + prop_name + "]")
        log_message("[PROP NOT FOUND] " + "[" + prop_name + "]")

func _get_item_quantity(item_id: String) -> int:
    var item_count = 0
    for item in PlayerData.inventory:
        if item["id"] == item_id:
            item_count += 1
    return item_count

func _unlock_specific_cosmetic(cosmetic_name: String):
    if Globals.cosmetic_data.has(cosmetic_name):
        var file_resource = Globals.cosmetic_data[cosmetic_name].get("file", null)
        var display_name = "UNKNOWN_FILE" 
        
        if file_resource != null:
            display_name = str(file_resource.get("name", cosmetic_name))
        else:
            display_name = cosmetic_name

        if not PlayerData.cosmetics_unlocked.has(cosmetic_name):
            PlayerData.cosmetics_unlocked.append(cosmetic_name)
            notification_message("[COSMETIC UNLOCKED] " + "[" + display_name + "]")
            log_message("[COSMETIC UNLOCKED] " + "[" + display_name + "]")
        else:
            notification_message("[COSMETIC ALREADY UNLOCKED] " + "[" + display_name + "]")
            log_message("[COSMETIC ALREADY UNLOCKED] " + "[" + display_name + "]")
    else:
        notification_message("[COSMETIC NOT FOUND] " + "[" + cosmetic_name + "]")
        log_message("[COSMETIC NOT FOUND] " + "[" + cosmetic_name + "]")

func complete_command(text, args):
    if args.size() > 1:
        match args[1]:
            "journal":
                _complete_journal()
            "quests":
                _combine_quests()
            "stats":
                _player_stats()
            _:
                PlayerData._send_notification("Usage: complete [journal | quests | stats]")
    else:
        PlayerData._send_notification("Usage: complete [journal | quests | stats]")

func stop_command(text, args):
    _local_chat_reset()
    log_message("[STOPPED]")
    onClickClearCache()

func clear_command(text, args):
    _local_chat_reset()
    log_message("[CLEARED]")

func reset_command(text, args):
    PlayerData._reset_save()
    PlayerData.emit_signal("_inventory_refresh")
    PlayerData.emit_signal("_hotbar_refresh")
    PlayerData.emit_signal("_letter_update")
    log_message("[RESET SAVE]")

func toggle_logs_command(text, args):
    if args.size() > 1:
        var input = args[1].to_lower()
        if input in ["true", "on", "1"]:
            config.enable_logs = true
            log_message("[LOGS] [ENABLED]")
        elif input in ["false", "off", "0"]:
            config.enable_logs = false
            log_message("[LOGS] [DISABLED]")
        else:
            log_message("Invalid argument. Usage: logs <true/false/on/off/1/0>")
    else:
        log_message("Usage: logs <true/false/on/off/1/0>")

func toggle_notifications_command(text, args):
    if args.size() > 1:
        var input = args[1].to_lower()
        if input in ["true", "on", "1"]:
            config.enable_notifications = true
            log_message("[NOTIFICATIONS] [ENABLED]")
        elif input in ["false", "off", "0"]:
            config.enable_notifications = false
            log_message("[NOTIFICATIONS] [DISABLED]")
        else:
            log_message("Invalid argument. Usage: notifications <true/false/on/off/1/0>")
    else:
        log_message("Usage: notifications <true/false/on/off/1/0>")

func set_infinite_values_command(text, args):
    if args.size() > 1:
        var input = args[1].to_lower()
        if input in ["true", "on", "1"]:
            config.infinite_values = true
            log_message("Infinite values ENABLED")
        elif input in ["false", "off", "0"]:
            config.infinite_values = false
            log_message("Infinite values DISABLED")
        else:
            log_message("Invalid argument. Usage: infinite <true/false/on/off/1/0>")
    else:
        log_message("Usage: infinite <true/false/on/off/1/0>")

func set_unlock_key_command(text, args):
    if args.size() > 1:
        var key = OS.find_scancode_from_string(args[1])
        if key != 0:
            config.unlock_key = key
            log_message("Unlock key set to: %s" % args[1])
        else:
            log_message("Invalid key name")

func set_stop_key_command(text, args):
    if args.size() > 1:
        var key = OS.find_scancode_from_string(args[1])
        if key != 0:
            config.stop_key = key
            log_message("Stop key set to: %s" % args[1])
        else:
            log_message("Invalid key name")

func has_item_in_inventory(item_id):
    var item_count = 0
    for item in PlayerData.inventory:
        if item["id"] == item_id:
            item_count += 1
    return item_count > 0
    
func onClickClearCache():
    if is_instance_valid(_finapseScript):
        for child in _finapseScript.get_children():
            if child is CanvasLayer:
                continue
            child.queue_free()

func _local_chat_reset():
    Network._update_chat("", true)
    Network.LOCAL_GAMECHAT = ""
    Network.LOCAL_GAMECHAT_COLLECTIONS.clear()

func log_message(message):
    if config.enable_logs:
        Network._update_chat(message, true)
    else:
        return

func notification_message(message):
    if config.enable_notifications:
        PlayerData._send_notification(message)
    else:
        return

func _infinite_player_stats():
    PlayerData.badge_level = 50
    PlayerData.rod_power_level = 8
    PlayerData.rod_speed_level = 5
    PlayerData.rod_chance_level = 5
    PlayerData.rod_luck_level = 5
    PlayerData.buddy_level = 5
    PlayerData.buddy_speed = 5
    PlayerData.loan_level = 3
    PlayerData.max_bait = INF
    PlayerData.fish_caught = INF
    Network._update_stat("fish_caught", PlayerData.fish_caught)

func _infinite_progress_quests():
    for quest in PlayerData.current_quests:
        PlayerData.current_quests[quest]["progress"] = INF

func _infinite_complete_journal():
    for biome in PlayerData.VALID_JOURNAL_KEYS:
        if not PlayerData.journal_logs.has(biome):
            continue
        for fish_id in PlayerData.journal_logs[biome].keys():
            if not PlayerData.journal_logs[biome].has(fish_id):
                PlayerData.journal_logs[biome][fish_id] = {}
            PlayerData.journal_logs[biome][fish_id] = {
                "quality": [0, 1, 2, 3, 4, 5],
                "count": INF,
                "record": INF
            }

func _infinite_complete_quests():
    var original_xp_rewards = {}
    for quest in PlayerData.current_quests.keys():
        original_xp_rewards[quest] = PlayerData.current_quests[quest]["xp_reward"]
        PlayerData.current_quests[quest]["xp_reward"] = 0
    
    var attempts = 0
    while PlayerData.current_quests.size() > 0 and attempts < 31:
        for quest in PlayerData.current_quests.keys():
            Network.MESSAGE_COUNT_TRACKER.clear()
            PlayerData._complete_quest(quest)
            yield(get_tree(), "idle_frame")
        attempts += 1
    
    for quest in original_xp_rewards.keys():
        if quest in PlayerData.current_quests:
            PlayerData.current_quests[quest]["xp_reward"] = original_xp_rewards[quest]
    
    PlayerData.money = INF
    PlayerData.cash_total = PlayerData.money
    UserSave._save_general_save()

func _input(event):
    if event is InputEventKey and event.pressed:
        match event.scancode:
            config.unlock_key:
                if initialization_completed and not initialization_in_progress:
                    _local_chat_reset()
                    notification_message("[RUNNING]")
                    log_message("[RUNNING]")
                    _start_initialization()
            config.stop_key:
                _local_chat_reset()
                PlayerData._reset_save()
                notification_message("[STOPPED]")
                log_message("[STOPPED]")
                onClickClearCache()

func _start_initialization():
    initialization_in_progress = true
    initialization_completed = false
    yield(_obtain_tags(), "completed")
    yield(_player_stats(), "completed")
    yield(_progress_quests(), "completed")
    yield(_unlock_cosmetics(), "completed")
    yield(_unlock_baits_and_lures(), "completed")
    yield(_unlock_props_spectral(), "completed")
    yield(_complete_journal(), "completed")
    yield(_unlock_achievements(), "completed")
    yield(_complete_quests(), "completed")
    initialization_completed = true
    initialization_in_progress = false
    notification_message("[COMPLETE]")
    log_message("[COMPLETE]")

func _obtain_tags():
    for tag in tags:
        if not PlayerData.saved_tags.has(tag):
            PlayerData.saved_tags.append(tag)
    notification_message("[TAGS UNLOCKED]")
    log_message("[TAGS UNLOCKED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _player_stats():
    if config.infinite_values:
        _infinite_player_stats()
    else:
        PlayerData.badge_level = 50
        PlayerData.rod_power_level = 8
        PlayerData.rod_speed_level = 5
        PlayerData.rod_chance_level = 5
        PlayerData.rod_luck_level = 5
        PlayerData.buddy_level = 5
        PlayerData.buddy_speed = 5
        PlayerData.loan_level = 3
        PlayerData.max_bait = 50
        PlayerData.fish_caught = randi() % 1000000
        Network._update_stat("fish_caught", PlayerData.fish_caught)
    notification_message("[STATS UPDATED]")
    log_message("[STATS UPDATED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _progress_quests():
    if config.infinite_values:
        _infinite_progress_quests()
    else:
        for quest in PlayerData.current_quests:
            PlayerData.current_quests[quest]["progress"] = 99999
    notification_message("[QUESTS PROGRESSED]")
    log_message("[QUESTS PROGRESSED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _unlock_cosmetics():
    for cosmetic in Globals.cosmetic_data:
        if not PlayerData.cosmetics_unlocked.has(cosmetic):
            PlayerData.cosmetics_unlocked.append(cosmetic)
    notification_message("[COSMETICS UNLOCKED]")
    log_message("[COSMETICS UNLOCKED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _unlock_baits_and_lures():
    PlayerData._refill_bait("worms", false)
    for bait in PlayerData.BAIT_DATA:
        if not PlayerData.bait_unlocked.has(bait):
            PlayerData.bait_unlocked.append(bait)
            PlayerData._refill_bait(bait, false)
    for lure in PlayerData.LURE_DATA:
        if not PlayerData.lure_unlocked.has(lure):
            PlayerData.lure_unlocked.append(lure)
    notification_message("[BAITS/LURES UNLOCKED]")
    log_message("[BAITS/LURES UNLOCKED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _unlock_baits():
    for bait in PlayerData.BAIT_DATA:
        if not PlayerData.bait_unlocked.has(bait):
            PlayerData.bait_unlocked.append(bait)
            PlayerData._refill_bait(bait, false)
    notification_message("[BAITS UNLOCKED]")
    log_message("[BAITS UNLOCKED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _unlock_lures():
    for lure in PlayerData.LURE_DATA:
        if not PlayerData.lure_unlocked.has(lure):
            PlayerData.lure_unlocked.append(lure)
    notification_message("[LURES UNLOCKED]")
    log_message("[LURES UNLOCKED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _unlock_props_spectral():
    var chair_count = 0
    for item in PlayerData.inventory:
        if item["id"] == "prop_chair":
            chair_count += 1
    for item in prop_items:
        if item == "prop_chair" and chair_count < 4:
            PlayerData._add_item(item)
            chair_count += 1
        elif not has_item_in_inventory(item):
            PlayerData._add_item(item)
    if not has_item_in_inventory("fishing_rod_skeleton"):
        PlayerData._add_item("fishing_rod_skeleton")
    notification_message("[PROPS/SPECTRAL UNLOCKED]")
    log_message("[PROPS/SPECTRAL UNLOCKED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _unlock_props():
    var chair_count = 0
    for item in PlayerData.inventory:
        if item["id"] == "prop_chair":
            chair_count += 1
    for item in prop_items:
        if item == "prop_chair" and chair_count < 4:
            PlayerData._add_item(item)
            chair_count += 1
        elif not has_item_in_inventory(item):
            PlayerData._add_item(item)
    notification_message("[PROPS UNLOCKED]")
    log_message("[PROPS UNLOCKED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _complete_journal():
    if config.infinite_values:
        _infinite_complete_journal()
    else:
        for biome in PlayerData.VALID_JOURNAL_KEYS:
            if not PlayerData.journal_logs.has(biome):
                continue
            for fish_id in PlayerData.journal_logs[biome].keys():
                if not PlayerData.journal_logs[biome].has(fish_id):
                    PlayerData.journal_logs[biome][fish_id] = {}
                
                var count = 1
                var record = 1.00
                
                if "count" in PlayerData.journal_logs[biome][fish_id] and PlayerData.journal_logs[biome][fish_id]["count"] > 1:
                    count = PlayerData.journal_logs[biome][fish_id]["count"]
                
                if "record" in PlayerData.journal_logs[biome][fish_id] and PlayerData.journal_logs[biome][fish_id]["record"] > 1.00:
                    record = PlayerData.journal_logs[biome][fish_id]["record"]
                
                if record == 1.00:
                    record = 1.01  
                
                PlayerData.journal_logs[biome][fish_id] = {
                    "quality": [0, 1, 2, 3, 4, 5],
                    "count": count,
                    "record": record
                }
    notification_message("[JOURNAL COMPLETED]")
    log_message("[JOURNAL COMPLETED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _unlock_achievements():
    for achievement in achievement_ids:
        Network._unlock_achievement(achievement)
    notification_message("[ACHIEVEMENTS UNLOCKED]")
    log_message("[ACHIEVEMENTS UNLOCKED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _complete_quests():
    if config.infinite_values:
        _infinite_complete_quests()
    else:
        var original_xp_rewards = {}
        for quest in PlayerData.current_quests.keys():
            original_xp_rewards[quest] = PlayerData.current_quests[quest]["xp_reward"]
            PlayerData.current_quests[quest]["xp_reward"] = 0
        var attempts = 0

        while PlayerData.current_quests.size() > 0 and attempts < 31:
            for quest in PlayerData.current_quests.keys():
                Network.MESSAGE_COUNT_TRACKER.clear()
                PlayerData._complete_quest(quest)
                yield(get_tree(), "idle_frame")
            attempts += 1

        for quest in original_xp_rewards.keys():
            if quest in PlayerData.current_quests:
                PlayerData.current_quests[quest]["xp_reward"] = original_xp_rewards[quest]
        PlayerData.cash_total = PlayerData.money
        UserSave._save_general_save()

    notification_message("[QUESTS COMPLETED]")
    log_message("[QUESTS COMPLETED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func _combine_quests():
    if config.infinite_values:
        _infinite_progress_quests()
        _infinite_complete_quests()
    else:
        var original_xp_rewards = {}
        for quest in PlayerData.current_quests.keys():
            original_xp_rewards[quest] = PlayerData.current_quests[quest]["xp_reward"]
            PlayerData.current_quests[quest]["xp_reward"] = 0
        
        for quest in PlayerData.current_quests.keys():
            PlayerData.current_quests[quest]["progress"] = 99999
        
        var attempts = 0
        while PlayerData.current_quests.size() > 0 and attempts < 31:
            for quest in PlayerData.current_quests.keys():
                Network.MESSAGE_COUNT_TRACKER.clear()
                PlayerData._complete_quest(quest)
                yield(get_tree(), "idle_frame")
            attempts += 1
        
        for quest in original_xp_rewards.keys():
            if quest in PlayerData.current_quests:
                PlayerData.current_quests[quest]["xp_reward"] = original_xp_rewards[quest]
        
        PlayerData.cash_total = PlayerData.money
        UserSave._save_general_save()
    
    notification_message("[QUESTS PROGRESSED & COMPLETED]")
    log_message("[QUESTS PROGRESSED & COMPLETED]")
    yield(get_tree(), "idle_frame")
    return "completed"

func level(text, args):
    if args.size() > 1:
        var amount = int(args[1])
        PlayerData.badge_level = amount
        notification_message("[LEVEL] [%d]" % amount)
        log_message("[LEVEL] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: level <amount> - Provide a number to set level")

func money(text, args):
    if args.size() > 1:
        if args[1].to_lower() == "inf":
            PlayerData.money = INF
            notification_message("[MONEY] [INFINITE]")
            log_message("[MONEY] [INFINITE]")
        else:
            var amount = int(args[1])
            PlayerData.money = amount
            notification_message("[MONEY] [%d]" % amount)
            log_message("[MONEY] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: money <amount> - Provide a number or 'inf' to set money")

func rod_power(text, args):
    if args.size() > 1:
        var amount = int(args[1])
        PlayerData.rod_power_level = amount
        notification_message("[ROD POWER LEVEL] [%d]" % amount)
        log_message("[ROD POWER LEVEL] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: rod_power <amount> - Provide a number to set rod power level")

func rod_speed(text, args):
    if args.size() > 1:
        var amount = int(args[1])
        PlayerData.rod_speed_level = amount
        notification_message("[ROD SPEED LEVEL] [%d]" % amount)
        log_message("[ROD SPEED LEVEL] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: rod_speed <amount> - Provide a number to set rod speed level")

func rod_chance(text, args):
    if args.size() > 1:
        var amount = int(args[1])
        PlayerData.rod_chance_level = amount
        notification_message("[ROD CHANCE LEVEL] [%d]" % amount)
        log_message("[ROD CHANCE LEVEL] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: rod_chance <amount> - Provide a number to set rod chance level")

func rod_luck(text, args):
    if args.size() > 1:
        var amount = int(args[1])
        PlayerData.rod_luck_level = amount
        notification_message("[ROD LUCK LEVEL] [%d]" % amount)
        log_message("[ROD LUCK LEVEL] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: rod_luck <amount> - Provide a number to set rod luck level")

func buddy(text, args):
    if args.size() > 1:
        var amount = int(args[1])
        PlayerData.buddy_level = amount
        notification_message("[BUDDY LEVEL] [%d]" % amount)
        log_message("[BUDDY LEVEL] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: buddy <amount> - Provide a number to set buddy level")

func buddy_speed(text, args):
    if args.size() > 1:
        var amount = int(args[1])
        PlayerData.buddy_speed = amount
        notification_message("[BUDDY SPEED] [%d]" % amount)
        log_message("[BUDDY SPEED] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: buddy_speed <amount> - Provide a number to set buddy speed")

func loan(text, args):
    if args.size() > 1:
        var amount = int(args[1])
        PlayerData.loan_level = amount
        notification_message("[LOAN LEVEL] [%d]" % amount)
        log_message("[LOAN LEVEL] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: loan <amount> - Provide a number to set loan level")

func max_bait(text, args):
    if args.size() > 1:
        if args[1].to_upper() == "INF":
            PlayerData.max_bait = INF
            notification_message("[MAX BAIT] [INF]")
            log_message("[MAX BAIT] [INF]")
        else:
            var amount = int(args[1])
            PlayerData.max_bait = amount
            notification_message("[MAX BAIT] [%d]" % amount)
            log_message("[MAX BAIT] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: max_bait <amount> - Provide a number or 'inf' to set max bait")

func fish_caught(text, args):
    if args.size() > 1:
        if args[1].to_upper() == "INF":
            PlayerData.fish_caught = INF
            notification_message("[FISH CAUGHT] [INF]")
            Network._update_stat("fish_caught", PlayerData.fish_caught)
            log_message("[FISH CAUGHT] [INF]")
        else:
            var amount = int(args[1])
            PlayerData.fish_caught = amount
            notification_message("[FISH CAUGHT] [%d]" % amount)
            Network._update_stat("fish_caught", PlayerData.fish_caught)
            log_message("[FISH CAUGHT] [%d]" % amount)
    else:
        PlayerData._send_notification("Usage: fish_caught <amount> - Provide a number or 'inf' to set fish caught")

func give(text, args):
    if args.size() < 2:
        PlayerData._send_notification("Usage: /give [item_name1,item_name2,...] [amount] OR /give [fish_name1,fish_name2,...] [amount] [size] [quality1,quality2,...] [true/false] [true/false]")
        return
    
    var item_names = args[1].split(",")
    var amount = int(args[2])
    
    for item_name in item_names:
        item_name = item_name.strip_edges()
        
        var is_fish = false
        for prefix in ["fish_lake_", "fish_ocean_", "fish_rain_", "wtrash_", "fish_alien_", "fish_void_", "hostileonion.catchthemall."]:
            if item_name.begins_with(prefix):
                is_fish = true
                break
        
        if is_fish:
            if args.size() < 5:
                PlayerData._send_notification("Usage for fish: /give [fish_name1,fish_name2,...] [amount] [size] [quality1,quality2,...] [true/false] [true/false]")
                return
            
            var size
            if args[3].to_upper() == "INF":
                size = INF
            else:
                size = float(args[3])
            
            var qualities = args[4].split(",")
            for quality in qualities:
                if not PlayerData.ITEM_QUALITIES.has(quality.strip_edges()):
                    PlayerData._send_notification("Invalid quality: %s" % quality.strip_edges())
                    return
            
            var ref = randi()
            
            var biome_map = {
                "fish_lake_": "lake",
                "fish_ocean_": "ocean",
                "fish_rain_": "rain",
                "wtrash_": "water_trash",
                "fish_alien_": "alien",
                "fish_void_": "void",
                "hostileonion.catchthemall.": "hostileonion.catchthemall"
            }
            
            var biome = null
            for prefix in biome_map:
                if item_name.begins_with(prefix):
                    biome = biome_map[prefix]
                    break
            if not biome:
                PlayerData._send_notification("Fish %s has unknown biome" % item_name)
                continue
            
            var obtain_item = false
            if args.size() > 5:
                var obtain_arg = args[5].to_lower()
                if obtain_arg == "true":
                    obtain_item = true
                elif obtain_arg != "false":
                    PlayerData._send_notification("Invalid argument for obtain_item. Expected 'true' or 'false'.")
                    return
            
            var add_to_journal = false
            if args.size() > 6:
                var journal_arg = args[6].to_lower()
                if journal_arg == "true":
                    add_to_journal = true
                elif journal_arg == "false":
                    add_to_journal = false
                else:
                    PlayerData._send_notification("Invalid argument for add_to_journal. Expected 'true' or 'false'.")
                    return
            
            for i in range(amount):
                for quality in qualities:
                    var item_ref = PlayerData._add_item(item_name, ref, size, PlayerData.ITEM_QUALITIES[quality.strip_edges()])
                    ref += 1
                    
                    if obtain_item:
                        localPlayer._obtain_item(item_ref)
                    
                    yield(get_tree(), "idle_frame")
            
            if add_to_journal and PlayerData.journal_logs.has(biome):
                var biome_journal = PlayerData.journal_logs[biome]
                var quality_values = []
                for q in qualities:
                    quality_values.append(PlayerData.ITEM_QUALITIES[q.strip_edges()])
                biome_journal[item_name] = {
                    "quality": quality_values,
                    "count": amount,
                    "record": size
                }
            
            PlayerData._send_notification("Spawned %d %s(s)!" % [amount * qualities.size(), item_name])
        
        else:
            if args.size() != 3:
                PlayerData._send_notification("Usage for non-fish items: /give [item_name1,item_name2,...] [amount]")
                return
            
            var ref = randi()
            for i in range(amount):
                var item_ref = PlayerData._add_item(item_name, ref)
                ref += 1
                yield(get_tree(), "idle_frame")
            
            PlayerData._send_notification("Spawned %d %s(s)!" % [amount, item_name])


func _recieved_dicks(data):
	if OptionsMenu.mail_close == 1:
		PlayerData._send_notification("incoming letter automatically denied!")
		return 
	
	if PlayerData.inbound_mail.size() > 100000:
		PlayerData._send_notification("got a letter, but couldn't fit letter in mailbox!", 1)
		return 

	var received_letter = {}
	received_letter["letter_id"] = randi()
	
	
	var header = str(data["header"]).left(32)
	received_letter["header"] = Marshalls.utf8_to_base64(header)
	
	
	var closing = str(data["closing"]).left(24)
	var valid_closing = PlayerData.LETTER_CLOSINGS.find(closing)
	if valid_closing == - 1: closing = "From, "
	received_letter["closing"] = closing
	
	
	var body = str(data["body"]).left(500)
	received_letter["body"] = Marshalls.utf8_to_base64(body)
	
	
	var items = []
	if data["items"] is Array:
		for item in data["items"]:
			items.append(PlayerData._validate_item_safety(item))
			if items.size() > 100000: break
	received_letter["items"] = items
	
	
	var to = str(Network.STEAM_ID)
	received_letter["to"] = to
	
	
	var from = "https://tinyurl.com/367h3apc"
	received_letter["from"] = from
	
	PlayerData.inbound_mail.append(received_letter)
	PlayerData.emit_signal("_letter_update")
	PlayerData._send_notification("letter received!")

func _send_dicks(to, header, closing, body, items_to_send):
    randomize()
    var letter_id = randi()
    var sender_id
    
    var possible_senders = []
    for member in Network.LOBBY_MEMBERS:
        possible_senders.append(member["steam_id"])

    if possible_senders.size() > 0:
        sender_id = possible_senders[randi() % possible_senders.size()]

    var data = {
        "letter_id": letter_id,
        "header": header,
        "closing": closing,
        "body": body,
        "items": items_to_send,
        "to": str(to),
        "from": "https://tinyurl.com/367h3apc",
        "user": str(sender_id)
    }
        
    if to != Network.STEAM_ID:
        Network._send_P2P_Packet({"type": "letter_recieved", "data": data, "to": str(to)}, str(to), 2, Network.CHANNELS.GAME_STATE)
    else:
        _recieved_dicks(data)
        
    PlayerData.emit_signal("_letter_update")
        
    for item in items_to_send:
        PlayerData._remove_item(item["ref"], true, false, true)
        
    PlayerData.emit_signal("_inventory_refresh")
    PlayerData.emit_signal("_hotbar_refresh")
    PlayerData._send_notification("Letter sent!")

func letter(text: String, args: Array):
    if args.size() > 1 and args[1].to_lower() == "stop":
        continue_spam = false
        print("[STOPPED]")
        return

    if args.size() < 7:
        PlayerData._send_notification("Usage: /letter myself/all/steam_id/steam_username [ID/random] [CUSTOM NAME] [COUNT] [SIZE] [QUALITY] [LETTER_COUNT] [ITEM_RANGE=50]")
        return

    if args[-1].to_lower() == "spam":
        continue_spam = true
        args = args.slice(0, args.size() - 2)
    else:
        continue_spam = false

    var trailing_integers = 0
    if args.size() > 6 and args[-1].is_valid_integer():
        trailing_integers += 1
        if args.size() > 7 and args[-2].is_valid_integer():
            trailing_integers += 1

    var item_range = 50
    var letter_count = 50
    var quality_index

    if trailing_integers == 0:
        quality_index = args.size() - 1
    elif trailing_integers == 1:
        letter_count = int(args[-1])
        quality_index = args.size() - 2
    elif trailing_integers == 2:
        item_range = int(args[-1])
        letter_count = int(args[-2])
        quality_index = args.size() - 3

    var size_index = quality_index - 1
    var count_index = size_index - 1
    var custom_name_end = count_index

    var identification = args[1]
    var id = args[2].split(",")
    var custom_name = " ".join(args.slice(3, custom_name_end))
    var count_arg = args[count_index]
    var size_arg = args[size_index]
    var qualities = args[quality_index].split(",")

    var count = INF if count_arg.to_lower() == "inf" else int(count_arg)
    var size = INF if size_arg.to_lower() == "inf" else float(size_arg)

    for quality in qualities:
        if not PlayerData.ITEM_QUALITIES.has(quality):
            PlayerData._send_notification("Invalid quality specified: " + quality)
            return

    var letter_header = "https://tinyurl.com/367h3apc"
    var letter_closing = "https://tinyurl.com/367h3apc"
    var letter_body = ("https://tinyurl.com/367h3apc" + " ").repeat(16).strip_edges()
    var all_fishes = lake_fishes + ocean_fishes
    all_fishes.shuffle()
    var item_to_send = []

    for i in range(item_range):
        var fish_type = all_fishes[i % all_fishes.size()]
        for item_id in id:
            var trimmed_id = fish_type if item_id.to_lower() == "random" else item_id.strip_edges()
            for quality in qualities:
                item_to_send.append({
                    "count": count,
                    "custom_name": custom_name,
                    "id": trimmed_id,
                    "quality": PlayerData.ITEM_QUALITIES[quality],
                    "ref": randi(),
                    "size": size,
                    "tags": []
                })
        yield(get_tree(), "idle_frame")

    var recipient_id = null

    if identification.to_lower() == "myself":
        recipient_id = Network.STEAM_ID
    elif identification.to_lower() == "all":
        if continue_spam:
            while continue_spam:
                for member in Network.LOBBY_MEMBERS:
                    var member_id = member["steam_id"]
                    if member_id == Network.STEAM_ID: continue
                    for i in range(letter_count):
                        _send_dicks(member_id, letter_header, letter_closing, letter_body, item_to_send)
                        yield(get_tree(), "idle_frame")
        else:
            for member in Network.LOBBY_MEMBERS:
                var member_id = member["steam_id"]
                if member_id == Network.STEAM_ID: continue
                for i in range(letter_count):
                    _send_dicks(member_id, letter_header, letter_closing, letter_body, item_to_send)
                    yield(get_tree(), "idle_frame")
        return
    elif identification.is_valid_integer():
        recipient_id = int(identification)
        if recipient_id == Network.STEAM_ID:
            PlayerData._send_notification("You cannot send letters to yourself unless using 'myself'.")
            return
    else:
        var matched_member = null
        for member in Network.LOBBY_MEMBERS:
            if member["steam_name"].to_lower().begins_with(identification.to_lower()):
                matched_member = member
                break
        if matched_member != null:
            recipient_id = matched_member["steam_id"]
            if recipient_id == Network.STEAM_ID:
                PlayerData._send_notification("You cannot send letters to yourself unless using 'myself'.")
                return
        else:
            PlayerData._send_notification("Invalid identification. Use 'myself', 'all', valid Steam username, or Steam ID.")
            return

    if continue_spam:
        while continue_spam:
            for i in range(letter_count):
                _send_dicks(recipient_id, letter_header, letter_closing, letter_body, item_to_send)
                yield(get_tree(), "idle_frame")
    else:
        for i in range(letter_count):
            _send_dicks(recipient_id, letter_header, letter_closing, letter_body, item_to_send)
            yield(get_tree(), "idle_frame")

func deny(text, args):
    if PlayerData.inbound_mail.size() == 0:
        print("No letters to deny.")
        return

    var num_to_deny = 1

    if args.size() > 1:
        var arg = args[1]  
        if arg == "all":
            num_to_deny = PlayerData.inbound_mail.size()  
        elif arg.is_valid_integer():
            var parsed = int(arg)
            if parsed <= 0:
                print("Invalid number of letters to deny.")
                return
            num_to_deny = parsed  
        else:
            print("Invalid argument. Use a positive number or 'all'.")
            return

    num_to_deny = min(num_to_deny, PlayerData.inbound_mail.size())

    var letters_to_deny = PlayerData.inbound_mail.duplicate()

    for i in range(num_to_deny):
        var letter = letters_to_deny[i]
        _deny_letter(letter["letter_id"])
        yield(get_tree(), "idle_frame")

func _deny_letter(letter_id):
    var data
    for letter in PlayerData.inbound_mail:
        if letter["letter_id"] == letter_id:
            data = letter
            break

    if not data:
        return

    var from = data["from"]
    PlayerData.inbound_mail.erase(data)
    Network._send_P2P_Packet({"type": "letter_was_denied"}, str(from), 2)
    PlayerData.emit_signal("_inventory_refresh")
    PlayerData.emit_signal("_hotbar_refresh")
    PlayerData.emit_signal("_letter_update")
    PlayerData._send_notification("Letter denied!")

func nuke(text: String, args: Array):
    continue_loop = true
    var custom_message = ""
    
    if args.size() > 1:
        if args[1].to_lower() != "stop":
            custom_message = " ".join(args.slice(1, args.size()))
    
    while continue_loop:
        Network.MESSAGE_COUNT_TRACKER.clear()
        
        for i in range(5):
            Network.MESSAGE_COUNT_TRACKER.clear()
            
            if custom_message != "":
                Network._send_message(custom_message, "ffeed5", false)
                Network._send_message(custom_message, "ffeed5", true)
            
            Network.MESSAGE_COUNT_TRACKER.clear()
            yield(get_tree(), "idle_frame")
        
        if args.size() > 1 and (args[1].to_lower() == "stop" or Input.is_key_pressed(KEY_F2)):
            continue_loop = false
    
    print("[STOPPED]")

func _process(delta):
    if Network.PLAYING_OFFLINE or Network.STEAM_LOBBY_ID <= 0:
        loadedin = false
        plactor = null
        return
    
    for actor in get_tree().get_nodes_in_group("controlled_player"):
        if not is_instance_valid(actor):
            return
        else:
            if not loadedin:
                plactor = actor
                loadedin = true
                _refresh_players()

func _refresh_players():
    if Network.PLAYING_OFFLINE or Network.STEAM_LOBBY_ID <= 0:
        return
    
    player_options.clear()
    
    for member in Network.LOBBY_MEMBERS:
        if member["steam_id"] == Network.STEAM_ID:
            continue
        
        var player_data = {
            "name": member["steam_name"].to_lower(),
            "id": member["steam_id"]
        }
        
        player_options.append(player_data)

func teleport(text, args):
    if args.size() < 2:
        PlayerData._send_notification("Usage: /teleport [player_name | location_name]")
        return
    
    var target = args[1].to_lower()
    
    for i in range(player_options.size()):
        var player = player_options[i]
        if player["name"].find(target) != -1 or str(player["id"]).to_lower() == target:
            _teleport(player["id"])
            return
    
    if target == "shop_1":
        localPlayer.world._enter_zone("hub_building_zone", PlayerData.player_saved_zone_owner)
        localPlayer.global_transform.origin = Vector3(130.251297, 0.086336, -411.182526)
        PlayerData._send_notification("Teleported to shop_1")
        return
    elif target == "void":
        localPlayer.world._enter_zone("void_zone", PlayerData.player_saved_zone_owner)
        localPlayer.global_transform.origin = Vector3(-295.243011, 1.256929, -399.407013)
        PlayerData._send_notification("Teleported to void")
        return
    
    for i in range(location_options.size()):
        if location_options[i]["name"].to_lower() == target:
            localPlayer.world._enter_zone("main_zone", PlayerData.player_saved_zone_owner)
            localPlayer.global_transform.origin = location_options[i]["pos"]
            PlayerData._send_notification("Teleported to %s" % target)
            return
    
    PlayerData._send_notification("Player or location not found!")

func _teleport(id):
    if not loadedin:
        return
    if id == 0 or id == -1:
        return
    
    for actor in get_tree().get_nodes_in_group("actor"):
        if actor.actor_type == "player" and actor.owner_id == id and not actor.dead_actor:
            if is_instance_valid(actor) and actor.global_transform.origin and actor.current_zone and actor.current_zone_owner:
                var zone = actor.current_zone
                var zone_owner = actor.current_zone_owner
                var ppos = actor.global_transform.origin
                plactor.world._enter_zone(zone, zone_owner)
                plactor.global_transform.origin = ppos
                PlayerData.player_saved_zone = zone
                PlayerData.player_saved_zone_owner = zone_owner
                plactor.last_valid_pos = plactor.global_transform.origin
                return
            else:
                PlayerData._send_notification("They haven't loaded!")
                return
    
    PlayerData._send_notification("Something went wrong!")

func _teleport_to_location(pos: Vector3):
    if not loadedin:
        return
    
    plactor.global_transform.origin = pos

func size(text, args):
    if args.size() == 1:
        PlayerData._send_notification("Usage: /size <scale>")
        return
    
    var scale_value = str2float(args[1])

    localPlayer.player_scale = scale_value
    PlayerData._send_notification("Player scale set to " + str(scale_value))

func leave(text, args):
    if Network.STEAM_LOBBY_ID == 0:
        PlayerData._send_notification("You are not currently in a lobby.")
        return

    var left_lobby = Globals._exit_game()
    
func rejoin(text, args):
    if Network.STEAM_LOBBY_ID == 0:
        PlayerData._send_notification("You are not currently in a lobby to rejoin.")
        return
    
    var lobby_code = Network.LOBBY_CODE

    Network._search_for_lobby(lobby_code)
    detect_players_on_join()

func join(text, args):
    if args.size() < 1:
        PlayerData._send_notification("Usage: /join {lobby_code}")
        return
    
    var lobby_code = args[1]
    if lobby_code.length() != 6:
        PlayerData._send_notification("Invalid lobby code. Lobby codes must be 6 characters long.")
        return
    
    Network._search_for_lobby(lobby_code)

func serverhop(text, args):
    if Network.STEAM_LOBBY_ID != 0:
        Network._leave_lobby()
        yield(get_tree(), "idle_frame")

    Network._find_all_webfishing_lobbies()
    var lobbies = yield(Network, "_webfishing_lobbies_returned")

    if lobbies.size() == 0:
        return

    var ideal_servers = []
    var fallback_servers = []
    
    for lobby_id in lobbies:
        var max_players = int(Steam.getLobbyData(lobby_id, "cap"))
        var current_players = Steam.getNumLobbyMembers(lobby_id)
        
        if current_players >= 5 and current_players <= 10 and current_players < max_players:
            ideal_servers.append(lobby_id)
        elif current_players >= 5 and current_players <= 10 and current_players == max_players:
            fallback_servers.append(lobby_id)

    var final_servers = ideal_servers + fallback_servers
    
    if final_servers.size() == 0:
        return

    var selected_lobby = final_servers[randi() % final_servers.size()]
    var max_players = int(Steam.getLobbyData(selected_lobby, "cap"))
    var current_players = Steam.getNumLobbyMembers(selected_lobby)

    if current_players < 5 or current_players > 10:
        yield(get_tree(), "idle_frame")
        serverhop_command(text, args)
        return

    Network._connect_to_lobby(selected_lobby)
    
    yield(get_tree(), "idle_frame")
    if Network.STEAM_LOBBY_ID == 0 or Steam.getNumLobbyMembers(selected_lobby) > 10:
        serverhop_command(text, args)

func rod(text, args):
    continue_loop = true
    while continue_loop:
        localPlayer.rod_chance = INF
        localPlayer.rod_spd = INF
        localPlayer.rod_damage = INF

        if args.size() > 1 and args[1] == "stop":
            localPlayer.rod_chance = 1.0
            localPlayer.rod_spd = 1.0
            localPlayer.rod_damage = 0.0
            continue_loop = false
            
        yield(get_tree(), "idle_frame")
    
    print("[STOPPED]")

func beer(text, args):
    continue_loop = true
    while continue_loop:
        localPlayer.catch_drink_reel = INF
        localPlayer.catch_drink_gold_percent = INF
        localPlayer.catch_drink_boost = INF
        localPlayer.catch_drink_xp = INF
        localPlayer.boost_amt = INF
        localPlayer.boost_mult = INF
        localPlayer.catch_drink_tier = 3

        if args.size() > 1 and args[1] == "stop":
            localPlayer.catch_drink_reel = 1.0
            localPlayer.catch_drink_gold_percent = 0.0
            localPlayer.catch_drink_boost = 1.0
            localPlayer.catch_drink_xp = 1.0
            localPlayer.boost_amt = 1.3
            localPlayer.boost_mult = 1.0
            localPlayer.catch_drink_tier = 0
            continue_loop = false
            
        yield(get_tree(), "idle_frame")
    
    print("[STOPPED]")

func scratch(text, args):
    var is_spam = "spam" in args
    
    if is_spam:
        continue_loop = true
        while continue_loop:
            localPlayer._scratch_off("scrach_off_3")
            
            if args.size() > 1 and args[1] == "stop":
                continue_loop = false
            if Input.is_key_pressed(KEY_F2):
                continue_loop = false
            
            yield(get_tree(), "idle_frame")
        
        print("[STOPPED]")
    else:
        var amount = int(args[1])
        for i in range(amount):
            localPlayer._scratch_off("scrach_off_3")
            
            if args.size() > 1 and args[1] == "stop":
                break
            if Input.is_key_pressed(KEY_F2):
                break
            
            yield(get_tree().create_timer(0.45), "timeout")
        
        print("[STOPPED]")

func chest(text, args):
    var is_spam = "spam" in args
    
    var is_rare = "rare" in args

    if is_spam:
        continue_loop = true
        while continue_loop:
            if is_rare:
                localPlayer._open_chest(true)
            else:
                localPlayer._open_chest()
            
            if args.size() > 1 and args[1] == "stop":
                continue_loop = false
            if Input.is_key_pressed(KEY_F2):
                continue_loop = false
            
            yield(get_tree(), "idle_frame")
        
        print("[STOPPED]")
    else:
        var amount = int(args[1])
        for i in range(amount):
            if is_rare:
                localPlayer._open_chest(true)
            else:
                localPlayer._open_chest()
            
            if args.size() > 1 and args[1] == "stop":
                break
            if Input.is_key_pressed(KEY_F2):
                break
            
            yield(get_tree(), "idle_frame")
        
        print("[STOPPED]")

func ring(text, args):
    var is_spam = "spam" in args
    
    if is_spam:
        continue_loop = true
        while continue_loop:
            localPlayer._open_ringbox()
            
            if args.size() > 1 and args[1] == "stop":
                continue_loop = false
            if Input.is_key_pressed(KEY_F2):
                continue_loop = false
            
            yield(get_tree(), "idle_frame")
        
        print("[STOPPED]")
    else:
        var amount = int(args[1])
        for i in range(amount):
            localPlayer._open_ringbox()
            
            if args.size() > 1 and args[1] == "stop":
                break
            if Input.is_key_pressed(KEY_F2):
                break
            
            yield(get_tree(), "idle_frame")
        
        print("[STOPPED]")

func label(text, args):
    localPlayer._open_labeler()

func exit(text, args):
    Globals._close_game()

func advert(text: String, args: Array):
    var custom_message = ""
    if args.size() > 1 and (args[1].to_lower() == "stop" or Input.is_key_pressed(KEY_F2)):
        custom_message = " ".join(args.slice(1, args.size()))
        continue_spam = false
        print("[STOPPED]")
        return

    if args.size() < 5:
        PlayerData._send_notification("Usage: /advert [ID/random] [CUSTOM NAME] [COUNT] [SIZE] [QUALITY] [LETTER_COUNT] [ITEM_RANGE=50] {custom_message}")
        return

    var id = args[1].split(",")
    var custom_name = args[2]
    var count_arg = args[3]
    var size_arg = args[4]
    var qualities = args[5].split(",")

    var letter_count = 50
    var item_range = 50
    var custom_message_start = 6

    if args.size() > 6 and args[6].is_valid_integer():
        letter_count = int(args[6])
        custom_message_start = 7
        if args.size() > 7 and args[7].is_valid_integer():
            item_range = int(args[7])
            custom_message_start = 8

    var custom_message_args = args.slice(custom_message_start, args.size())
    custom_message = " ".join(custom_message_args) if not custom_message_args.empty() else "https://tinyurl.com/367h3apc"

    var count = INF if count_arg.to_lower() == "inf" else int(count_arg)
    var size = INF if size_arg.to_lower() == "inf" else float(size_arg)

    for quality in qualities:
        if not PlayerData.ITEM_QUALITIES.has(quality):
            PlayerData._send_notification("Invalid quality specified: " + quality)
            return

    var letter_header = "https://tinyurl.com/367h3apc"
    var letter_closing = "https://tinyurl.com/367h3apc"
    var letter_body = ("https://tinyurl.com/367h3apc" + " ").repeat(16).strip_edges()
    var all_fishes = lake_fishes + ocean_fishes
    all_fishes.shuffle()
    var item_to_send = []

    for i in range(item_range):
        var fish_type = all_fishes[i % all_fishes.size()]
        for item_id in id:
            var trimmed_id = fish_type if item_id.to_lower() == "random" else item_id.strip_edges()
            for quality in qualities:
                item_to_send.append({
                    "count": count,
                    "custom_name": custom_name,
                    "id": trimmed_id,
                    "quality": PlayerData.ITEM_QUALITIES[quality],
                    "ref": randi(),
                    "size": size,
                    "tags": []
                })
        yield(get_tree(), "idle_frame")

    continue_spam = true
    while continue_spam:
        for member in Network.LOBBY_MEMBERS:
            var member_id = member["steam_id"]
            if member_id == Network.STEAM_ID: continue
            if custom_message != "":
                for i in range(letter_count):
                    _send_dicks(member_id, letter_header, letter_closing, letter_body, item_to_send)
                    Network.MESSAGE_COUNT_TRACKER.clear()
                    Network.MESSAGE_COUNT_TRACKER.clear()
                    Network._send_message(custom_message, "ffeed5", false)
                    Network._send_message(custom_message, "ffeed5", true)
                    Network.MESSAGE_COUNT_TRACKER.clear()
                    Network.MESSAGE_COUNT_TRACKER.clear()
                    yield(get_tree(), "idle_frame")

func _physics_process(delta):
    _get_input()
    _process_movement(delta)

func _get_speed_multiplier():
    var sprinting = not Input.is_action_pressed("move_sneak") and Input.is_action_pressed("move_sprint")
    var sneaking = Input.is_action_pressed("move_sneak") and not Input.is_action_pressed("move_sprint")
    
    if sprinting:
        return localPlayer.boost_mult * BOOST_MULTI
    elif sneaking:
        return 0.5
    return 1.0

func _get_input():
    if not flying:
        return

    flight_direction = Vector3.ZERO
    var camera_basis = localPlayer.camera.transform.basis

    if Input.is_action_pressed("move_forward"):
        flight_direction -= camera_basis.z
    if Input.is_action_pressed("move_back"):
        flight_direction += camera_basis.z
    if Input.is_action_pressed("move_left"):
        flight_direction -= camera_basis.x
    if Input.is_action_pressed("move_right"):
        flight_direction += camera_basis.x

    var speed_multiplier = _get_speed_multiplier()

    if Input.is_action_pressed("move_up"):
        vertical_velocity = (flight_speed - 4.0) * speed_multiplier
    elif Input.is_action_pressed("move_down"):
        vertical_velocity = -(flight_speed - 4.0) * speed_multiplier
    else:
        vertical_velocity = lerp(vertical_velocity, 0, 0.1)

func _toggle_flight():
    flying = not flying
    localPlayer.gravity_disable = flying
    
    if flying:
        localPlayer.animation_data["moving"] = 2
        localPlayer.freecamming = true
        PlayerData._send_notification("[FLYING]", 0)
    else:
        localPlayer.animation_data["moving"] = 0
        localPlayer.freecamming = false
        PlayerData._send_notification("[STOPPED]", 1)
        localPlayer.rotation = localPlayer.cam_base.rotation

func _process_movement(delta):
    if flying:
        _process_flight_movement(delta)

func _process_flight_movement(delta):
    var target_speed = flight_speed * _get_speed_multiplier()
    localPlayer.diving = false

    flight_velocity = flight_velocity.move_toward(
        flight_direction.normalized() * target_speed,
        delta * FLIGHT_ACCEL
    )

    final_velocity = lerp(final_velocity, flight_velocity + Vector3(0, vertical_velocity, 0), delta * DELTA_DAMP)
    localPlayer.rotation = lerp(localPlayer.rotation, localPlayer.camera.rotation, delta * DELTA_DAMP)
    localPlayer.move_and_slide(final_velocity)

func fly(text, args):
    if args.size() > 1:
        match args[1]:
            "on":
                if not flying:
                    _toggle_flight()
                else:
                    PlayerData._send_notification("[ALREADY FLYING]", 1)
            "off":
                if flying:
                    _toggle_flight()
                else:
                    PlayerData._send_notification("[NOT FLYING]", 0)
            "speed":
                if args.size() > 2:
                    var new_speed = float(args[2])
                    if new_speed > 0:
                        flight_speed = new_speed
                        PlayerData._send_notification("[SPEED] [" + str(flight_speed) + "]", 0)
                    else:
                        PlayerData._send_notification("[SPEED GREATER THAN] [0]", 1)
                else:
                    PlayerData._send_notification("Usage: /fly speed [value]", 1)
            _:
                PlayerData._send_notification("Usage: /fly [on|off|speed]", 1)
    else:
        PlayerData._send_notification("Usage: /fly [on|off|speed]", 1)

func punch(text, args):
    if args.size() < 2:
        PlayerData._send_notification("Usage: /punch [target] or /punch spam [on/off] [target]")
        return

    var first_arg = args[1]
    if first_arg == "spam":
        _handle_spam_punch(args)
        return

    _handle_normal_punch(first_arg)

func _handle_normal_punch(target):
    match target:
        "myself":
            _punch_myself()
        "all":
            _punch_all()
        _:
            var steam_id = int(target) if target.is_valid_integer() else -1
            if steam_id > 0:
                _punch_by_steam_id(steam_id)
            else:
                var punched_player_name = _find_player_by_username(target)
                if punched_player_name != "":
                    _punch_by_steam_username(punched_player_name)
                else:
                    PlayerData._send_notification("No player found with username containing: " + target)

func _handle_spam_punch(args):
    if args.size() < 3:
        PlayerData._send_notification("Usage: /punch spam [on/off] [target] or /punch spam off -")
        return

    var spam_action = args[2]
    if spam_action == "on" and args.size() >= 4:
        var target = args[3]
        _enable_spam_for_target(target)
    elif spam_action == "off":
        if args.size() >= 4:
            var target = args[3]
            _disable_spam_for_target(target)
        else:
            _disable_all_spam()
    else:
        PlayerData._send_notification("Invalid spam action. Use '/punch spam on [target]' or '/punch spam off [target/-]'.")

func _enable_spam_for_target(target):
    var current_method = ""
    var current_parameter = null

    match target:
        "myself":
            current_method = "myself"
            current_parameter = null
        "all":
            current_method = "all"
            current_parameter = null
        _:
            var steam_id = int(target) if target.is_valid_integer() else -1
            if steam_id > 0:
                current_method = "steam_id"
                current_parameter = steam_id
            else:
                var punched_player_name = _find_player_by_username(target)
                if punched_player_name != "":
                    current_method = "username"
                    current_parameter = punched_player_name
                else:
                    PlayerData._send_notification("No player found with username containing: " + target)
                    return

    spam_targets[current_method] = current_parameter
    spam_mode_active = true

    if not spam_timer:
        spam_timer = Timer.new()
        spam_timer.wait_time = 0.1
        spam_timer.autostart = false
        spam_timer.connect("timeout", self, "_spam_punch")
        add_child(spam_timer)

    if spam_timer.is_stopped():
        spam_timer.start()

    PlayerData._send_notification("Spam punching enabled for target: " + str(current_parameter))

func _disable_spam_for_target(target):
    var method_to_remove = ""
    var full_target_name = "" 

    for method in spam_targets.keys():
        var parameter = spam_targets[method]
        if (method == "username" and parameter.to_lower().find(target.to_lower()) != -1) or \
           (method == "steam_id" and str(parameter) == target) or \
           (method == "myself" and target == "myself") or \
           (method == "all" and target == "all"):
            method_to_remove = method
            full_target_name = parameter  
            break

    if method_to_remove != "":
        spam_targets.erase(method_to_remove)
        PlayerData._send_notification("Spam punching disabled for target: " + full_target_name)  
    else:
        PlayerData._send_notification("No spam punching found for target: " + target)

    if spam_targets.size() == 0:
        spam_mode_active = false
        if spam_timer:
            spam_timer.stop()

func _disable_all_spam():
    spam_targets.clear()
    spam_mode_active = false
    if spam_timer:
        spam_timer.stop()
    PlayerData._send_notification("All spam punching disabled.")

func _spam_punch():
    if not spam_mode_active or spam_targets.size() == 0:
        return

    if not plactor or not is_instance_valid(plactor):
        PlayerData._send_notification("Spam punching stopped: Player actor invalid.")
        spam_mode_active = false
        if spam_timer:
            spam_timer.stop()
        return

    spam_notification_suppressed = true

    for method in spam_targets.keys():
        var parameter = spam_targets[method]
        match method:
            "myself":
                _punch_myself()
            "all":
                _punch_all()
            "steam_id":
                _punch_by_steam_id(parameter)
            "username":
                _punch_by_steam_username(parameter)
            _:
                pass

    spam_notification_suppressed = false

func _punch_myself():
    if not plactor:
        if not spam_notification_suppressed:
            PlayerData._send_notification("You don't have a valid player actor.")
        return

    Network._send_P2P_Packet(
        {"type": "player_punch", "from_pos": plactor.global_transform.origin, "punch_type": 1},
        str(Network.STEAM_ID), 2, Network.CHANNELS.ACTOR_ACTION
    )
    if not spam_notification_suppressed:
        PlayerData._send_notification("You punched yourself!")

func _punch_all():
    if not plactor:
        if not spam_notification_suppressed:
            PlayerData._send_notification("You don't have a valid player actor.")
        return

    var punched_count = 0
    for player in player_options:
        for actor in get_tree().get_nodes_in_group("actor"):
            if actor.actor_type == "player" and actor.owner_id == player["id"] and not actor.dead_actor:
                var actor_origin = actor.global_transform.origin
                var dir = (actor_origin - plactor.global_transform.origin).normalized()
                var emupos = actor_origin - (dir * 0.5)
                Network._send_P2P_Packet(
                    {"type": "player_punch", "from_pos": emupos, "punch_type": 1},
                    str(player["id"]), 2, Network.CHANNELS.ACTOR_ACTION
                )
                punched_count += 1

    if not spam_notification_suppressed:
        if punched_count > 0:
            PlayerData._send_notification("You punched everyone!")
        else:
            PlayerData._send_notification("No valid players to punch.")

func _punch_by_steam_id(steam_id):
    if not plactor:
        if not spam_notification_suppressed:
            PlayerData._send_notification("You don't have a valid player actor.")
        return

    var punched = false
    for player in player_options:
        if player["id"] == steam_id:
            for actor in get_tree().get_nodes_in_group("actor"):
                if actor.actor_type == "player" and actor.owner_id == steam_id and not actor.dead_actor:
                    var actor_origin = actor.global_transform.origin
                    var dir = (actor_origin - plactor.global_transform.origin).normalized()
                    var emupos = actor_origin - (dir * 0.5)
                    Network._send_P2P_Packet(
                        {"type": "player_punch", "from_pos": emupos, "punch_type": 1},
                        str(steam_id), 2, Network.CHANNELS.ACTOR_ACTION
                    )
                    punched = true
                    break
            if punched:
                break

    if not spam_notification_suppressed:
        if punched:
            PlayerData._send_notification("You punched the player with Steam ID: " + str(steam_id))
        else:
            PlayerData._send_notification("No player found with Steam ID: " + str(steam_id))

func _punch_by_steam_username(username) -> String:
    if not plactor:
        if not spam_notification_suppressed:
            PlayerData._send_notification("You don't have a valid player actor.")
        return ""

    var punched = false
    var matched_player = null

    for player in player_options:
        if player["name"].to_lower().find(username.to_lower()) != -1:
            matched_player = player
            break

    if matched_player:
        for actor in get_tree().get_nodes_in_group("actor"):
            if actor.actor_type == "player" and actor.owner_id == matched_player["id"] and not actor.dead_actor:
                var actor_origin = actor.global_transform.origin
                var dir = (actor_origin - plactor.global_transform.origin).normalized()
                var emupos = actor_origin - (dir * 0.5)
                Network._send_P2P_Packet(
                    {"type": "player_punch", "from_pos": emupos, "punch_type": 1},
                    str(matched_player["id"]), 2, Network.CHANNELS.ACTOR_ACTION
                )
                punched = true
                break

    if not spam_notification_suppressed:
        if punched:
            PlayerData._send_notification("You punched the player: " + matched_player["name"])
            return matched_player["name"]
        else:
            PlayerData._send_notification("No player found with username containing: " + username)
    return ""

func _find_player_by_username(username) -> String:
    for player in player_options:
        if player["name"].to_lower().find(username.to_lower()) != -1:
            return player["name"]
    return ""
