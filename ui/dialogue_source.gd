extends Node

var dialogue = {
	"Test NPC": 
		{
			"start_dialogue": "",
			"choices": {
				" A": ["", 0, 0, ""],
			}
		},
	"Cigarette Guy": 
		{
			"start_dialogue": "Uhh, dude, what are you doing out here?",
			"choices": {
				" Rumours": ["Go to the big city, man. Nothing happens out here.", 0, 0, ""],
				" Bioterrorist": ["Man, I just want to finish this cigarette.", 0, 0, ""],
				" Directions": ["City is that way. (He points east.) And, (he waves south) that way there's a bunch of ruins. Be careful, brigands hang out there. West is radiation, be careful there too. Actually, just head back to the city. It's dangerous out here. Only reason people don't hurt me is they know I'm a loser.", 0, 0, "Brigands? Like that game Brigand: Oaxaca?"]
			}
		}

}
