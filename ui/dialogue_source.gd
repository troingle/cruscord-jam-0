extends Node

var quotes = [
	["I'm going to go through this clip in what some might consider excruciating detail", "Legal Eagle"], 
	["The parties are advised to chill. ", "Judge Alex Kozinski"], 
	["Deciphering motions like the one presented here wastes valuable chamber staff time, and invites this sort of footnote. ", "Bankr. W.D"], 
	["When I call out to my wife, There isn't any butter, I do not mean, There isn't any butter in town.' The context makes clear to her that I am talking about the contents of our refrigerator", "Breyer, J., dissenting"],
	["The sheer applesauce of this statutory interpretation should be obvious", "Scalia, J., dissenting"], 
	["We do not subscribe to the obscurantist notion that justice, like wild mushrooms, thrives on manure in the dark", "Unknown"], 
	["This is an uncommonly silly law. . . . But we are not asked in this case to say whether we think this law is unwise, or even asinine. We are asked to hold that it violates the United States Constitution.", "Stewart, J., dissenting."], [" The issue is, what is chicken?", "Unknown"], 
	["Robots again", "Judge Kozinski"], 
	[" Practitioners dealing with situations such as this sometimes refer to the Three Pony Rule. That is, no child, no matter how wealthy the parents, needs to be provided more than three ponies", " Patterson"], 
	[" Some people believe with great fervor preposterous things that just happen to coincide with their self-interest", " Judge Frank Easterbrook"], 
	[" Judges are not like pigs, hunting for truffles buried in briefs", "Unknown"], 
	[" Few men are interested in lesbians", " Posner, J"], 
	[" This decision might as well be written on the dissolving paper sold in magic shops.", " Alito, J"], 
	[" Admittedly, some high school students (including those that use drugs) are dumb", " Justice John Paul Steven"]
]

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
