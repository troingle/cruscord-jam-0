extends Node

var dialogue = {
	"Test NPC": 
		{
			"start_dialogue": "Hello, I am a test NPC.",
			"choices": {
				" Rumours": ["I have heard nothing. Go away.", 0, 0, ""],
				" Rock Music": ["I hate it.", 0, 0, "Test NPC seems to hate rock music. This seems suspicious."]
			}
		},
	"Gunther": 
		{
			"start_dialogue": "What the hell man!? Eight hours 'til the trial, and only NOW you show up?? I've been in a prison cell for the whole week! I'm gonna get fuckin' HANGED!",
			"choices": {
				" Charges": ["Don't tell me you forgot, oh my god... Yeah, these guys, these guys, they want me arrested for bioterrorism. You know, all the radiation in the air? They're sayin' it was me. Bullshit! I was with my mom the whole time, she can testify! Where is she?", 0, 0, "Mother? I should ask about this person."],
				" Mother": ["Her name's Liz. Liz Gubblebumble. You get her, I'm saved. Where the fuck would she be at this time of night... I don't know. Come on man, you gotta help me here. If you lose this case, we're both fucked. You know that.", 0, 0, "My defendant told me to look for his mother, Liz Gubblebumble. I should ask the locals for her location, maybe the bar? I could use a drink..."]
			}
		},
	"Dowd": 
		{
			"start_dialogue": "Sure took your sweet ass time, huh? Hey, General Dowd, chief of the Police Death Squad Unit.",
			"choices": {
				" Death Squad Unit": ["Here's the deal. You testifying for ol' bioterrorist over here? Well, you better get a not-guilty verdict. If it turns out he did it, by law, you can be considered a 'terrorist sympathizer' for choosin' to defend him. Don't give me that look, 'sjust how it works in this town. And, if that happens, well, me and the squad's got grounds to kill you, see? Heh heh, man you're real fucked, huh.", 0, 0, "If I don't finish this case, the local Death Squad Unit's gonna kill me... This is real bad."],
				" Gunther": ["We picked him up last week, found some special chemicals in his room. Same stuff used in the toxic 'nades that infected this town in the first place. All evidence is pointing to him. You better have a miracle if you want to set this man free.", 0, 0, ""],
				" Liz Gubblebumble": ["Tsch, you gonna call his mom? That the best you can do? Give me a break. Woulda thought you suits would've preferred some field work, interviewing... Not tattling.", 0, 0, ""]
			}
		},
	"Police Doorman": 
		{
			"start_dialogue": "You must be the defence.",
			"choices": {
				" Bioterrorist": ["Yes, Gunther's in the stool next to me. He's been waiting for you.", 0, 0, ""],
			}
		},
	"City Council": 
		{
			"start_dialogue": "The city council will now listen.",
			"choices": {
				" Death Squad Unit": ["Yes, the Police Death Squad Unit is an official and legal branch of the local citizen's militia, but don't worry. Hits are only carried out after severe public safety concerns, such as the recent bioterrorist attack. They are upstanding citizens of the Law, and we would urge you to treat them with the upmost respect. It is a very dangerous line of work.", 0, 0, "Well, if the Law says it's okay... I suppose they have a right to remain. Still, I'm in a real bad spot."],
				" Trial": ["Yes, the trial will begin in roughly 8 hours. Changes in schedule are not permitted within a 48-hour timeframe, I'm afraid.", 0, 0, ""],
				" City Council": ["We are the watchful eyes of the Law keeping the walled city of Pochitla orderly and safe for all. Our cause dates back to the Neoliberal Revolution of 1982, where the formerly anarchist city was saved from barbarity with reason, and a government was established. You are a defence attorney, one of our many operators in the great machine.", 0, 0, ""],
			}
		},
	"Bartender": 
		{
			"start_dialogue": "Tap's out. Only bottles.",
			"choices": {
				" Rumours": ["All I can say is if you see a guy with a brown cap in an alleyway, stay far away from him. They're with the Dirtbags, and you don't want to tangle with them.", 0, 0, ""],
				" Dirtbags": ["The biggest band of thugs in this town. They say they're 'experimenting' with a new system where they send scouts out to kill people in alleys and loot their corpses for resources. You're the Law, right? You gotta do something about them.", 0, 0, ""],
				" Liz Gubblebumble": ["Don't bring that freak's name in here. She's a mook, and don't even get me started on her greasy-haired son... They're crazy, the lot of them. Take her name to the nightclub, not here.", 0, 0, "The bartender acted strangely hostile from the mention of old Lizzy. She told me to take her name to the Nightclub, but I'm already here, so I'll still ask the barflies."],
				" Bathrooms": ["Just go down. The men's toilets are caved in 'cos of the attack, so you'll have to use the ladies'.", 0, 0, "Use the ladies' restroom? This would deface my fragile masculinity. I can't do that."]
			}
		},
	"Fillip": 
		{
			"start_dialogue": "Hello?",
			"choices": {
				" Liz Gubblebumble": ["I don't know her, but I knew her son, Gunther. We were making a game together - I just wanted to make a silly adventure, but he was obsessed with 'player interactivity.' As in, he wanted the player do everything that could be possible in the game space. We spent six months on the starting area, and it fizzled out because every dialogue tree had fifty outcomes and he wasn't budging in toning down the scale. Not fun, but it was a learning experience for sure. He was never a chemist, though. I don't believe he did it one bit.", 0, 0, ""],
				" Bioterrorism": ["It's horrible, right? Dead of night, all these grenades go off one by one like lights goin' out. I was out for a walk when it happened, and my apartment got blown to smithereens. Apparently it was these toxic termite grenades or something. I'd ask a scientist about it.", 0, 0, "I should talk to a scientist about the weapons used in the bioterrorist attack."],
			}
		},
	"Bathroom Woman": 
		{
			"start_dialogue": "Uhm, a little privacy, please?",
			"choices": {
				" Rumours": ["I don't know nothing. Please go away.", 0, 0, ""],
				" Liz Gubblebumble": ["What kind of detective are you? Get out!", 0, 0, "This was a complete mistake. My masculinity forsaken having gone into the womens' restroom, and the suspect doesn't even want to talk to me."]
			}
		},
	"Cigarette Guy": 
		{
			"start_dialogue": "Uhh, dude, what are you doing out here?",
			"choices": {
				" Rumours": ["Nothing happens 'round these parts. You're best off going back to the big city while all this blows over.", 0, 0, ""],
				" Bioterrorist": ["Yeah, that ways would've been the way out of tihs cramped town, but thanks to the damn rads we're cut off from the outside world. The Council told all of us to sit around and wait for orders. Better find a solution fast, I say. How are we gonna trade like this?", 0, 0, ""],
				" Liz Gubblebumble": ["She's with the Dirtbags crowd, right? I dig them. Reminds me of the old days before the Council. I'd recommend you get a crowd with the gang, they'd probably know what happened to her. Good luck, though. They kill people on sight.", 0, 0, "Cigarette Guy wants me to get a crowd with the Dirtbags."],
				
			}
		},
}
