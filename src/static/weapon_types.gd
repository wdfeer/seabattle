class_name WeaponTypes

static var types: Array[Array] = [
	["Recurve Bow", 0.4, 1, 200],
	["Longbow", 1, 0.6, 300],
	["Musket", 2, 1, 500],
	["Hand Rifle", 2, 2, 600],
	["SMG", 1, 6, 300],
	["Bolt Rifle", 5, 0.5, 800],
]

static func set_weapon(boat: Boat, index: int):
	var gun = types[index]
	boat.weapon_name = gun[0]
	boat.proj_damage = gun[1]
	boat.fire_rate = gun[2]
	boat.proj_velocity = gun[3]
