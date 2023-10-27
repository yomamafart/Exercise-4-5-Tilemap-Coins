# Exercise 4.5-Tilemap-Coins

Exercise for MSCH-C220

This exercise is designed to continue our investigation of a 2D Platformer by demonstrating some of the complications in using Tilemaps for consumable items.

The expectations for this exercise are that you will

 - [ ] Fork and clone this repository
 - [ ] Import the project into Godot
 - [ ] Create a new Tilemap for the coins
 - [ ] Add coins to the the map
 - [ ] Write a script so the player can pick up the coins
 - [ ] Edit the LICENSE and README.md
 - [ ] Commit and push your changes back to GitHub. Turn in the URL of your repository on Canvas.

---

A demonstration of this exercise is available at [https://youtu.be/JwRejlfLKmw](https://youtu.be/JwRejlfLKmw).

---

## Instructions

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Exercise-4-5-Tilemap-Coins. Edit the LICENSE and replace BL-MSCH-C220 with your full name. Commit your changes.

Clone the repository to a Local Path on your computer.

Open Godot. Navigate to this folder. Import the project.godot file and open the "Tilemap Coins" project.

Open `res://Game.tscn`. As a child of the Game node, add a Tilemap node and rename it "Coins". Select the Coins node and create a new tileset for it. There should be a single tile in the tileset, using `res://Assets/coin.png` with a physics layer and Collision shape that is the same size as the tile. The Cell Size for Coins should be 128,128, and _the Collision Layer and Mask should both be set as layer 4._

Add a handful of Coins to the level. If they seem misaligned, you have probably incorrectly set the cell size.

Then open `res://Player/Player.tscn`. As a child of the Player node, add an Area2D node and rename it "Coin_Collector". Add a CollisionShape2D node as a child of Coin_Collector, make it a Capsule shape, and center and resize it so the curved edges of the capsule intersect with the corners of the Player's collision shape (but is at all points outside it). _The Coin_Collector node's Collision Layer and Mask should both be set to 4._

Add a body_entered signal to the Coin_Collector node and attach it to the Player script. The resulting callback should look like this:
```
func _on_Coin_Collector_body_entered(body):
	if body.name == "Coins":
		body.get_coin(global_position)
```

Back in the Game scene, attach a script to the Coins node. That script should look like this:
```
extends TileMap

const BIG_NUMBER = 1000000
var coins = []

func _ready():
	for x in range(1000):
		for y in range(1000):
			if get_cell_source_id(0, Vector2i(x, y)) != -1:
				coins.append(Vector2(x,y))


func get_coin(p):
	var coords = local_to_map(to_local(p))
	var min_dist = BIG_NUMBER
	var which_coin = Vector2.ZERO
	for c in coins:
		var d = Vector2(coords).distance_to(c)
		if d < min_dist:
			min_dist = d
			which_coin = c
	if which_coin != Vector2.ZERO:
		call_deferred("set_cell", 0, which_coin, -1)
```

Test the game and try picking up the coins.

Now, add a HUD to the game, describing how many coins the player has picked up. Track the number coins in res://Global.gd. Is there anything you could do (with Particles or Tween objects) to make that display juicier?

Quit Godot. In GitHub desktop, add a summary message, commit your changes and push them back to GitHub. If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Exercise-4-5-Tilemap-Coins) on Canvas.

The final state of the file should be as follows (replacing the "Created by" information with your name):

```
# Exercise 4.5-Tilemap-Coins

Exercise for MSCH-C220

The fifth exercise for the 2D Platformer project, exploring using tilemaps for consumables (like coins or powerups).

## Implementation

Built using Godot 4.1.1

The player sprite is an adaptation of [MV Platformer Male](https://opengameart.org/content/mv-platformer-male-32x64) by MoikMellah. CC0 Licensed.

The [tilemap](https://kenney.nl/assets/abstract-platformer) and the [coin sprite](https://kenney.nl/assets/puzzle-pack-2](https://kenney.nl/assets/puzzle-pack-2) are provided by Kenney.nl.


## References

None


## Future Development

None

## Created by 

Jason Francis
```
