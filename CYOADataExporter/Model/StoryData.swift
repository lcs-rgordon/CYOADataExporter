//
//  StoryData.swift
//  CYOADataExporter
//
//  Created by Russell Gordon on 2024-06-02.
//

import Foundation

struct Node: Identifiable {
    let id: Int
    let paragraphs: [String]
    let image: String?
    let edges: [Edge]
    let ending: Ending?
}

struct Edge: Hashable {
    
    // MARK: Stored properties
    let destinationId: Int
    let prompt: String
    
    // MARK: Computed properties
    var promptForVideoGameStyleInterface: String {
        
        // Get rid of Markdown syntax
        let interimPrompt = prompt.replacingOccurrences(of: "*", with: "")
        
        // Now replace page references with "tap here..."
        let regex = "turn to page ([0-9]){1,}"
        let replacment = "tap here"
        return interimPrompt.replacingOccurrences(of: regex, with: replacment, options: [.regularExpression])
    }
    
}

enum EndingClassification: String {
    case great = "Great, you won!"
    case favorable = "Favorable"
    case mediocre = "Mediocre"
    case disappointing = "Disappointing"
    case catastrophic = "Catastrophic"
}

struct Ending {
    let classification: EndingClassification
    let description: String
    var color: String {
        switch self.classification {
        case .great:
            return "#90C8E0"  // Light blue
        case .favorable:
            return "#FFDE5F"  // Pale yellow
        case .mediocre:
            return "#D7883C"  // Orange
        case .disappointing:
            return "#C1531E"  // Deep orange
        case .catastrophic:
            return "#AB1800"  // Deep red
        }
    }
}


struct EndingType {
    var id: Int
    var type: String
    var color: String
}

// A single node
let testNode = Node(id: 1,
                    paragraphs: [
                        "You are a deep sea explorer searching for the famed lost city of Atlantis. This is your most challenging and dangerous mission. Fear and excitement are now your companions.",
                        
                        "It is morning and the sun pushes up on the horizon. The sea is calm. You climb into the narrow pilot's compartment of the underwater vessel *Seeker* with your special gear. The crew of the research vessel *Maray* screws down the hatch clamps. Now begins the plunge into the depths of the ocean. The *Seeker* crew begins lowering by a strong, but thin, cable. Within minutes, you are so deep in the ocean that little light filters down to you. The silence is eerie as the *Seeker* slips deeper and deeper. You peer out the thick glass porthole and see strange white fish drifting past, sometimes stopping to look at you–an intruder from another world.",
                        
                    ],
                    image: "node-1",
                    edges: [
                        Edge(destinationId: 2,
                             prompt: "*Turn to the next page*")
                        ,
                    ],
                    ending: nil)

let emptyNode = Node(id: 0, paragraphs: [""], image: nil, edges: [], ending: nil)

// An array of nodes that model the narrative's directed graph
let storyNodes: [Node] = [
    
    testNode
    
    ,
    
    Node(id: 2,
         paragraphs: [
            "The cable attaching you to the *Maray* is extended to its limit. You have come to rest on a ledge near the canyon in the ocean floor that ancient myth says leads to the lost city of Atlantis.",
            
            "You have an experimental diving suit designed to protect you from the intense pressure of the deep. You should be able to leave the *Seeker* and explore the sea bottom. The new suit contains a number of the latest microprocessors enabling a variety of useful functions. It even has a built-in waterproof smart tablet with laser communicator. You can cut loose from the cable; the *Seeker* is self-propelled. You are now in another world. Remember, this is a dangerous world, an unknown world.",
            
            "As agreed, you signal the *Maray*, \"All systems GO. It's awesome down here.\"",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 4,
                 prompt: "*If you decide to cut loose from the* Maray *and dive with the* Seeker *into the canyon in the ocean floor, turn to page 4.*")
            ,
            Edge(destinationId: 6, prompt: "*If you decide to explore the ledge where the* Seeker *has come to rest, turn to page 6.*")
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 3,
         paragraphs: [
            
            "Carefully maneuvering the *Seeker* between the walls of the canyon, you discover a large round hole. A stream of large bubbles flows steadily out of the hole. The *Seeker* is equipped with scientific equipment to analyze the bubbles. It also has sonar equipment that can measure depth. The ocean covers close to 90% of the earth and is mostly unknown. Who knows where this hole might lead?",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 9,
                 prompt: "*If you decide to analyze the bubbles, turn to page 9.*")
            ,
            Edge(destinationId: 14,
                 prompt: "*If you decide to take depth readings, turn to page 14.*")
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 4,
         paragraphs: [
            
            "The *Maray* asks you for a more detailed status report, and you comply, telling them that you are going to cast off from the line and descend under your own power.",
            
            "Approval is given, and the *Seeker* slips silently into the undersea canyon.",
            
            "As you drop into the canyon, you turn on the *Seeker*'s searchlight. Straight ahead is a dark wall covered with a strange type of barnacle growth. To the left (port) side, you see what appears to be a grotto. The entrance is perfectly round, as if it had been cut by human hands.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 5,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    ,
    
    Node(id: 5,
         paragraphs: [
            
            "White lantern fish give off a pale, greenish light. To the right (starboard) side of the *Seeker*, you see bubbles rising steadily from the floor of the canyon.",
            
         ],
         image: "node-4",
         edges: [
            
            Edge(destinationId: 3,
                 prompt: "*If you decide to investigate the bubbles, turn to page 3.*")
            
            ,
            
            Edge(destinationId: 8,
                 prompt: "*If you decide to investigate the grotto with the round entrance, turn to page 8.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 6,
         paragraphs: [
            
            "Your dive suit is a tight fit and takes you some time to put it on. Finally, you slip from the airlock of the *Seeker* and stand on the ocean floor. It is a strange and marvelous world where your every move is slowed down. You begin the exploration with your halogen searchlight. The ledge hanging over the deep canyon is your starting point.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 7,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 7,
         paragraphs: [
            
            "A strange feeling overcomes you, part warning, part terror. Then you see it. The *Seeker* is in the grips of a huge sea monster. It is similar to a squid, but it is enormous. The *Seeker* is just a toy in its long, powerful tentacles. You seek shelter behind a rock formation knowing the spear gun you carry will be useless against this monster. It looks as though it will destroy the *Seeker*. Fish of all sizes huddle with you in an attempt to escape the monster.",
            
         ],
         image: "node-6",
         edges: [
            
            Edge(destinationId: 10,
                 prompt: "*If you stay hidden close to the* Seeker, *turn to page 10.*")
            
            ,
            
            Edge(destinationId: 12,
                 prompt: "*If you try to escape in the hope that rescuers will see you, turn to page 12.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 8,
         paragraphs: [
            
            "You pilot the *Seeker* through the rounded entrance to the grotto. Once inside, your searchlight picks up what appear to be docks and piers along the grotto walls. The *Seeker*'s searchlight is not very powerful. However, you do have a special laser light which would light up the grotto like daylight. Unfortunately, the laser light can only be used twice for very short periods before it must be recharged aboard the *Maray*, now more than 2,000 feet above you on the surface.",
            
         ],
         image: "node-8",
         edges: [
            
            Edge(destinationId: 13,
                 prompt: "*If you decide to cruise further into the grotto, turn to page 13.*")
            
            ,
            
            Edge(destinationId: 18,
                 prompt: "*If you decide to use the laser light, turn to page 18.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 9,
         paragraphs: [
            
            "You squeeze into your dive suit. Now outside the *Seeker*, you use your miniaturized wrist computer to analyze the bubbles. As you work, you clumsily knock against the valve that dumps the compressed air necessary to make the *Seeker* rise to the surface. There is nothing to be done about it, so you continue to analyze the bubbles. They contain a high percentage of oxygen and no poisonous gases. Perhaps they are coming from some area below the sea where human–type beings can live and breathe? Perhaps they are coming from Atlantis?",
            
            "You could try to use the *Seeker*'s drilling arm to enlarge the source of the bubbles so you can explore further. But you are also worried about the *Seeker*'s loss of rising capability from bumping the valve. You might also be able to trap the bubbles and use them to raise the *Seeker*.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 21,
                 prompt: "*If you decide to drill, turn to page 21.*")
            
            ,
            Edge(destinationId: 25,
                 prompt: "*If you try to collect the bubbles coming from the hole to fill the tanks of the* Seeker, *turn to page 25.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 10,
         paragraphs: [
            
            "The giant squid tosses and turns the *Seeker*, but finally the creature grows tired of its new game and lets off with an enormous squirt of water. You now are free to leave your hiding place and examine the *Seeker* for damage.",
            
            "To your dismay, the airlock entrance has been jammed shut. You are locked out of the *Seeker*. The crew of the *Maray*, however, suspected trouble when you did not respond to a routine radio check. They are now lowering an escape platform. Once on the platform, you radio them to start the slow pull to the surface. To avoid the deadly bends – rapid expansion of nitrogen bubbles in your blood – they will have to bring you up very slowly.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 11,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 11,
         paragraphs: [
            
            "Just as the platform begins to move, the giant squid suddenly reappears. It is headed directly at you.",
            
         ],
         image: "node-10",
         edges: [
            
            Edge(destinationId: 16,
                 prompt: "*If you decide to fight the squid with your spear gun, hoping to scare it off, turn to page 16.*")
            
            ,
            
            Edge(destinationId: 19,
                 prompt: "*If you decide to signal Maray to pull you up at top speed, knowing you will get the bends, turn to page 19.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 12,
         paragraphs: [
            
            "Moving cautiously, you climb up the sides of the canyon hoping to reach the ocean floor. Leaving the *Seeker* in the grips of the giant squid, you plan to signal for help with a bright yellow dye marker that will float to the surface. The *Maray* crew members above have been instructed to watch for this emergency signal. They will send help.",
            
            "Once you reach the ledge above the canyon and feel slightly safer, you see the most feared of all sea creatures – a huge Great White shark. It begins to circle towards you and you know that you are its target. You wonder whether you should fire your emergency propulsion charge that will send you rapidly to the surface. The shark is fast; he might catch you anyway. You also know that you will get the bends from the rapid rise to the surface.",
            
         ],
         image: "node-12",
         edges: [
            
            Edge(destinationId: 20,
                 prompt: "*If you decide to fire the special propulsion charge to get to the surface, turn to page 20.*")
            
            ,
            
            Edge(destinationId: 22,
                 prompt: "*If you decide to wait quietly, hoping that the shark will go away, turn to page 22.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 13,
         paragraphs: [
            
            "You cruise silently into the grotto. Its roof slopes upward and you follow the slope. The depth finder shows that you are rising quite rapidly. Perhaps you will reach the surface and open air. The roof of the grotto stops sloping upward. Before you is a perfectly round metallic hatch made of a metal that you have never seen before. With the mechanical arm of the *Seeker* you try to open the hatch. No luck. Activating an electronic pulse generator, you bombard the hatch with electronic pulses – they are not meant to be hostile.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 24,
                 prompt: "*If you decide to blow the hatch open with an explosive charge, turn to page 24.*")
            
            ,
            
            Edge(destinationId: 27,
                 prompt: "*If you decide to continue transmitting radio communications through the hatch, turn to page 27.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 14,
         paragraphs: [
            
            "Maneuvering the *Seeker* next to the hole, you begin to take sonar readings to determine its depth. To your amazement, the sonar readings indicate that the hole is extraordinarily deep – it might reach the center of the earth!",
            
            "What lies down there? Where are the bubbles coming from? Is Atlantis beneath you?",
            
         ],
         image: "node-14",
         edges: [
            
            Edge(destinationId: 15,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 15,
         paragraphs: [
            
            "There is a sudden and disturbing digital reading on your instruments: a mid–ocean earthquake! The *Seeker* is not damaged, but the *Maray* might leave, and you will be abandoned. Maybe you should ascend right away and join the *Maray*. On the other hand, you are perhaps on the verge of one of the world's greatest discoveries.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 23,
                 prompt: "*If you decide to descend into the hole, turn to page 23.*")
            
            ,
            
            Edge(destinationId: 26,
                 prompt: "*If you decide to return to the surface, turn to page 26.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 16,
         paragraphs: [
            
            "With a rush of water, the giant squid attacks. Two 20–foot tentacles with their pulsing suction cups reach out to ensnare you. You dive off the platform and fire two of your spears. They strike the squid close to its two monstrous eyes. The squid keeps on coming.",
            
            "One of the tentacles wraps around your diving helmet and ruptures the seal to your suit. You fire your last spear hoping to hit the monster in a vulnerable spot. Water is beginning to trickle into your suit. You signal the *Maray* to haul you up fast \"Emergency Hoist.\" You must have hit the squid. It floats away writhing and thrashing. You think you're about to black out.",
            
         ],
         image: "node-17",
         edges: [
            
            Edge(destinationId: 17,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 17,
         paragraphs: [
            
            "You wake up on the deck of the *Maray* and are quickly rushed to the decompression chambers to ward off the effect of the bends. Several days later you are over the worst and starting to worry about diving into the abyss again. Can you do it? Do you have the nerve?",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 31,
                 prompt: "*If you decide to quit the expedition now, turn to page 31.*")
            
            ,
            
            Edge(destinationId: 32,
                 prompt: "*If you decide to return to the deep, turn to page 32.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 18,
         paragraphs: [
            
            "The beam from the laser light illuminates the entire grotto. Far back on the floor of the grotto is a submarine! Cautiously, you maneuver the *Seeker* closer. It's the submarine that mysteriously disappeared in the Bermuda Triangle almost a year before. The Bermuda Triangle is more than 2,000 miles away. How did the sub get here?",
            
            "It doesn't appear to be damaged, but it is covered with slimy algae. Beautiful fish swim around it as though it is their own special prize. Then you notice that the main hatch is free of algae!",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 28,
                 prompt: "*If you decide to enter the submarine, turn to page 28.*")
            
            ,
            
            Edge(destinationId: 30,
                 prompt: "*If you decide to cruise on through the grotto ignoring the sub for now, turn to page 30.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 19,
         paragraphs: [
            
            "As they begin the rapid hauling, you lose your ability to function in the deep. Dizziness overcomes you and your arms and legs feel weak. You lose your hold on the platform and drift in the water, exhausted. Surprisingly you see a dolphin heading right toward you. These marvelous mammals sometimes help people in trouble. Will it help you?",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 34,
                 prompt: "*If you try to get help from the dolphin, turn to page 34.*")
            
            ,
            
            Edge(destinationId: 36,
                 prompt: "*If you decide to carry on alone swimming to the surface, turn to page 36.*")
            
            ,
            
         ],
         
         ending: nil)
    
    ,
    
    Node(id: 20,
         paragraphs: [
            
            "You fire the special propulsion charge and zoom upward through the water, frightening schools of fish as you go. You become dizzy and lose track of where you are. The world seems upside down. The shark is nowhere around, you hope. Breaking through to the surface and floating about a half mile from the *Maray*, you unsuccessfully try to reach them with your digital communicator.",
            
            "The lookouts spot you in the water and they quickly rescue you. Unfortunately, the rapid ascent has given you a bad case of the bends. It takes a long time to decompress. And when you are finally all right, the ship's doctor informs you that your underwater days are over. Someone else will have to find Atlantis.",
            
         ],
         image: "node-20",
         edges: [],
         ending: Ending(classification: .disappointing,
                        description: "Severe case\\nof the bends"))
    
    ,
    
    Node(id: 21,
         paragraphs: [
            
            "As you begin to drill, the stream of bubbles increases.",
            
            "The stream of bubbles is strong enough to ruffle the surface of the sea. You could try to surface now and locate the exact position of the bubble area. Then you could make plans with the scientists aboard the *Maray* about what to do next. On the other hand, you could simply explore the hole with the *Seeker* to determine the source of the bubbles now! There is great risk in entering the hole, but it could lead to the source of the bubbles and maybe to Atlantis.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 33,
                 prompt: "*If you try to surface, turn to page 33.*")
            
            ,
            
            Edge(destinationId: 38,
                 prompt: "*If you explore, turn to page 38.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 22,
         paragraphs: [
            
            "You wait for the shark to go away. No luck! Other sharks are coming to join the hunt. They circle you, coming closer and faster each time. It is too late. There is no escape! The largest shark, jaws gaping, strikes!!!!",
            
         ],
         image: "node-22",
         edges: [],
         ending: Ending(classification: .catastrophic,
                        description: "Eaten by\\nlarge shark"))
    
    ,
    
    Node(id: 23,
         paragraphs: [
            
            "Now is the time for decision. You check all the controls of the *Seeker*, grit your teeth, and push the control column into the deep dive position. Down, down you go where no person has ever ventured. The *Seeker* is built for deep, deep dives, but you are descending rapidly mile after mile into the deep. The pressure is intense, the darkness is complete, and the depth gauge indicates an incredible fifteen miles. You quickly reverse the control column. Warning lights flare up on your control panel; they show that gravitational forces are now stronger than the *Seeker*'s propulsion motors. You have passed the point of no return and your journey downward will continue in utter darkness until the water pressure is too great for the *Seeker*. This is the final voyage.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .catastrophic,
                        description: "Crushed by\\nimplosion"))
    
    ,
    
    Node(id: 24,
         paragraphs: [
            
            "The only way to get beyond the door is to blast it away, or so you believe. The *Seeker*'s laser cannon is powerful and you position the *Seeker* to fire. Pushing the fire button, you send a powerful beam at the hatch. Nothing happens. Then you advance the cannon control to full emergency force. Again you push the button and the beam dissolves the hatch instantly. A flood of seawater rushes into the giant hole, carrying you with it into an air–filled cavern beyond. The water fills the cavern with speed and explosive force. You see several people scurrying towards escape hatches. IT IS TOO LATE! You did the wrong thing. There is no turning back.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .catastrophic,
                        description: "Drowned in\\ncavern"))
    
    ,
    
    Node(id: 25,
         paragraphs: [
            
            "You are able to capture the bubbling gases and fill the tanks of the *Seeker*, enough to allow it to rise. Slowly, the *Seeker* rises out of the canyon, scattering schools of brightly colored fish, and brushing past underwater plants that wave like palm trees in a wind. Just as you reach the ledge at the top of the canyon, you see what appears to be an old road! Rocks along its side look like old Roman distance markers. Could this be a path that leads to the lost city of Atlantis? You anchor the *Seeker* and prepare to investigate more closely.",
            
         ],
         image: "node-25",
         edges: [
            
            Edge(destinationId: 6,
                 prompt: "*Turn to page 6.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 26,
         paragraphs: [
            
            "Deciding to return to the surface, you direct the *Seeker* cautiously back along the side of the canyon in the ocean floor. Without warning, the *Seeker* is gripped in a powerful current that sweeps it toward a grotto. Once in the grotto, the current carries you to what appears to be a large metal door. It swings open and the *Seeker* is swept inside. The door closes, the water in the grotto drains away, and you step out into a chamber that must have been made by some type of life force: perhaps humanoid, perhaps not.",
            
            "A door opens in the wall and two people dressed in simple clothes come towards you. One of them says, \"Welcome to Atlantis. We have been expecting you.",
            
            "What a discovery! You have found the lost city!",
            
            "\"Yes, you have found us; but we do not trust those on the surface. We are not cruel, but you will never leave Atlantis.",
            
            "They want you to follow them and you agree. But you have another thought. Perhaps you could blast your way out of the chamber with the *Seeker*'s laser cannon.",
            
         ],
         image: "node-26",
         edges: [
            
            Edge(destinationId: 39,
                 prompt: "*If you decide to make a dash for the Seeker and try to blast through the closed door with the laser cannon, turn to page 39.*")
            
            ,
            
            Edge(destinationId: 40,
                 prompt: "*If you decide to follow the people and join the Atlantean society, turn to page 40.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 27,
         paragraphs: [
            
            "The radio transmissions seem to be failing, and you grow tired of sending signals through the closed door. You are just about to give up when the door suddenly swings open, revealing behind it a cavern with another door. You enter the cavern cautiously and receive a radio signal in English. It tells you that you are welcome here, but that once you enter this place, you may never return to the world above. It is up to you to decide.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 42,
                 prompt: "*If you decide to go on and investigate what might be Atlantis, turn to page 42.*")
            
            ,
            
            Edge(destinationId: 43,
                 prompt: "*If you decide to retreat, turn to page 43.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 28,
         paragraphs: [
            
            "The submarine is indeed mysterious. Opening the hatch on the conning tower you enter the sub. It is amazingly clean and orderly. There are no signs of life, but no signs of struggle or death.",
            
            "A voice softly speaks. \"Thousands of years ago, the leaders of Atlantis realized that their continent was slipping into the sea. They discovered a large underground cavern and built new forms of living quarters for their people. Later when Atlantis was deep beneath the ocean, some of our scientists discovered and perfected an operation enabling us to breathe under water.\"",
            
            "The voice, which sounds friendly, also tells you that there are two groups in Atlantis. One group is thought to be good while the other is seen as evil.",
            
            "\"Come join us,\" the voice says. \"You can use the secret passageway to Atlantis. It begins just over there.\"",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 29,
                 prompt: "*Turn to the next page*")
            
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 29,
         paragraphs: [
            
            "As you follow directions, you spy a remarkable underwater craft passing by. There are several people aboard, and they smile at you. Or do they?",
            
            "If this is an Atlantean ship, are the people good or evil? Do they know of the secret passageway?",
            
         ],
         image: "node-28",
         edges: [
            
            Edge(destinationId: 44,
                 prompt: "*If you hurry in, trying to reach the secret passageway without being seen, turn to page 44.*")
            
            ,
            
            Edge(destinationId: 45,
                 prompt: "*If you rush back to the Seeker trying to escape danger, turn to page 45.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 30,
         paragraphs: [
            
            "You cruise through the grotto past the wreck of the submarine. There is another shipwreck. And then another. They too, are covered with algae, and they also appear undamaged. Maybe people from Atlantis capture ships in the Bermuda Triangle and bring them here. There is a three–masted schooner of the type used in the early 1800s. Its rigging is festooned with algae, and fish swim lazily around its mast.",
            
            "Your curiosity captures you and you put on your diving suit, leaving the *Seeker*. You move towards the old sailing ship. Suddenly a thirteen-foot long deadly poisonous sea snake strikes from behind the forward cabin and bites you in the soft flesh between the fingers of your right hand. There is no antidote to the deadly poison. The neurotoxin spreads like a wave up your forearm on its way to your cerebral cortex. Your life has been short and sweet. Farewell brave one!",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .catastrophic,
                        description: "Killed by\\nsea snake"))
    ,
    
    Node(id: 31,
         paragraphs: [
            
            "With great sorrow, you decide that it is wisest to leave the expedition. You can't risk returning to the great depths. So, reluctantly you return to the United States.",
            
            "Several major television shows are desperate to get you. After all, you are one of the true survivors. While on one such show, a special news flash announces to the world the discovery of Atlantis by an Italian research team lead by Dr. Marcello, a world–famous explorer. You regret your decision, but you didn't really have a choice. Did you?",
            
         ],
         image: "node-31",
         edges: [],
         ending: Ending(classification: .disappointing,
                        description: "Someone else\\n discovers Atlantis"))
    
    ,
    
    Node(id: 32,
         paragraphs: [
            
            "You can't resist the adventure beneath the sea You Must go down again, and after several weeks of rest, you enter the *Seeker* and slip quickly into the deep. You bring the *Seeker* to rest by the great canyon in the ocean bottom. Wearing your special suit, you venture out into the depths. There are no signs of the giant squid and you feel safe.",
            
            "Rounding a rock formation, you come upon the wreck of an ancient Greek ship. How strange to find this ship intact so far below the surface. What brought it here? Was it visiting Atlantis before the lost continent slipped beneath the sea?",
            
            "You take pictures and make notes on your waterproof tablet. Maybe this ancient ship hides the secret to Atlantis.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 46,
                 prompt: "*If you go aboard the Greek ship, turn to page 46.*")
            
            ,
            
            Edge(destinationId: 48,
                 prompt: "*If you return to the surface to report your findings, turn to page 48.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 33,
         paragraphs: [
            
            "You suddenly realize the stream of bubbles is powerful enough to raise the *Seeker* Guiding the *Seeker* into the bubble stream, it heads towards the surface. As you swirl upward, you begin to notice increasing amounts of brown kelp. Near the surface, you become entangled in the seaweed. The instruments in the *Seeker* indicate that the propellers and the steering mechanisms will not work.",
            
            "You put on your diving suit and exit the *Seeker* to see what can be done. Once outside in the kelp, you realize that you can't free the *Seeker*. You swim for the surface but find that you are completely stuck in the clinging seaweed. You are trapped and unable to go forward or return to the *Seeker*.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 51,
                 prompt: "*If you decide to keep struggling towards the surface, turn to page 51.*")
            
            ,
            
            Edge(destinationId: 53,
                 prompt: "*If you decide to rest quietly, gain strength, and work out a plan, turn to page 53.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 34,
         paragraphs: [
            
            "The dolphin looks at you, and you even imagine that he is smiling at you. You grab one of his flippers, and with a powerful switch of his body, the dolphin swims upward. In a short time, you break through to the surface. You blink in the bright sun. The *Maray* is nowhere in sight. You are lost far at sea.",
            
         ],
         image: "node-34",
         edges: [
            
            Edge(destinationId: 35,
                 prompt: "*Turn to the next page*")
            
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 35,
         paragraphs: [
            
            "The dolphin dives beneath the surface with you still clinging to him. He speeds off and within twenty minutes you are next to the *Maray*. The dolphin must have heard the *Maray*'s engine noises underneath the water.",
            
            "Once aboard, everyone congratulates you on your escape. You will go down again, but the thought keeps haunting you: What if your luck has run out?",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 49,
                 prompt: "*If you decide to give up the expedition, turn to page 49.*")
            
            ,
            
            Edge(destinationId: 50,
                 prompt: "*If you decide to dive again the next day, turn to page 50*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 36,
         paragraphs: [
            
            "The dolphin might help and might not. You decide to chance it alone. So, up you go, swimming towards the surface. The dolphin follows for some time, and then swims off. You rest for a while about 300 feet below the surface before your final ascent.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 37,
                 prompt: "Turn to the next page")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 37,
         paragraphs: [
            
            "A huge ugly fish swims towards you. Its bulging eyes fasten on you. It is a Mola Mola, and spans more than sixteen feet in width. It's a fish that does not bother to bite its victims. It swallows them whole.",
            
            "It looks as though you are its next meal.",
            
         ],
         image: "node-36",
         edges: [],
         ending: Ending(classification: .catastrophic,
                        description: "Eaten by\\nhuge ugly fish"))
    
    ,
    
    Node(id: 38,
         paragraphs: [
            
            "You decide to guide the *Seeker* into the new passageway to the bubble source. Suddenly the *Seeker* is swept downward as if pulled by a giant magnet. You lose consciousness, and when you wake, you are in a well–lighted and comfortable loom. Three people stand close by. They look normal and appear to be friendly.",
            
            "The middle one speaks. You are in the visitors' reception room. If you wish to come into the city of Atlantis, then follow us; but you may never return to your world. If you wish to leave now, we will escort you safely to the surface. It is your choice. We do not wish to harm you.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 52,
                 prompt: "*If you decide to return to the surface, turn to page 52.*")
            
            ,
            
            Edge(destinationId: 54,
                 prompt: "*If you follow them into the city of Atlantis, turn to page 54.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 39,
         paragraphs: [
            
            "The Atlanteans have lived in peace for thousands of years. They have no love of warfare. Their civlization is technologically very advanced. A sensing mechanism tells them that you are about to use your laser cannon. They fire a special beam at the *Seeker*. All its functions stop. You are powerless to escape. They calmly approach the *Seeker*. \"You are now part of Atlantis. We understand your fear, but do not be frightened. No harm will come to you and your life will be full. Follow us.\"",
            
            "As you walk with them, into a new world, you wonder if you will ever see the sky again.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "You join\\nthe Atlanteans"))
    
    ,
    
    Node(id: 40,
         paragraphs: [
            
            "You are led to a room. The floors are a rich marble. The walls glow. The ceiling is like being inside a diamond looking through the many facets.",
            
            "\"A person who immediately commands respect beckons you with firmness and kindness to come to her.",
            
            "\"Welcome to Atlantis. Thousands of years ago we learned that we were about to slip into the sea. Our people prepared for the calamity by building a new city inside an extinct volcano. We have lived here in peace and harmony ever since. We have no sunlight, nor stars to gaze at, but we have other spaces to meditate upon.",
            
            "She tells you about a group of people called the Nodoors. If you wish, you can live with them, but you cannot leave Atlantis.",
            
         ],
         image: "node-40",
         edges: [
            
            Edge(destinationId: 41,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 41,
         paragraphs: [
            
            "A bearded man is to be your escort. Atlantis is a beautiful city. Buildings merge one into another, colors radiate light, and coral branches fill courtyards. There is a sense of well–being and peace.",
            
            "It would be pleasant here, but you don't want to be a prisoner. Maybe there would be a better chance to escape if you join the Nodoors. You ask your guide about them.",
            
            "\"Oh, we believe they are dangerous, but we don't really know. They live in the center of the old volcano. If you wish, I can take you there.\"",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 55,
                 prompt: "*If you decide to join the Nodoors, turn to page 55.*")
            
            ,
            
            Edge(destinationId: 56,
                 prompt: "*If you decide to remain with the Atlanteans and perhaps get a chance to escape, turn to page 56.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 42,
         paragraphs: [
            
            "You are greeted by a group of people who look like ordinary human beings except that there are gill–like slits on their necks. Their bare feet have skin between the toes forming a web. They order you to put on your dive suit, pull you quickly from the *Seeker* and lead you towards their city. On the way they show you the zoo where there are animals from the world above the sea. There is a glass–like cage surrounding them filled with air, allowing them to live below the sea.",
            
            "\"So, my young friend,\" the leader of the group says, \"you may have the gill slit operation and live like one of us, or you can refuse and join the other animals in the zoo.\"",
            
            "What a choice, but if you have the gill slit operation, you will never be able to escape and return to the surtace.",
            
         ],
         image: "node-42",
         edges: [
            
            Edge(destinationId: 57,
                 prompt: "*If you agree to the operation, turn to page 57.*")
            
            ,
            
            Edge(destinationId: 58,
                 prompt: "*If you go to the zoo, turn to page 58.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 43,
         paragraphs: [
            
            "Back aboard the *Seeker*, you radio the *Maray* that you are surfacing to make a plan. While rising out of the giant crevice–like canyon, you spot what appears to be a road running along the top of the ledge. What is this? The scientists aboard the *Maray* had mentioned the possibilities of finding signs of the ancient civilization, such as roads. You must investigate.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 6,
                 prompt: "*Turn to page 6.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 44,
         paragraphs: [
            
            "You escape being seen by the submarine craft. Following the instructions, you enter a passageway. At the end of the passageway is an airlock door and beyond it a large air–filled cavern. Perhaps it is the inside of an extinct volcano.",
            
            "The land is pleasant, although strange to your experience. A soft substance covers the ground. It seems to be alive. You can't tell. A gentle light comes from the sides of this huge cavern. It reminds you of early morning light just before the sun rises.",
            
            "A group of people approaches you making friendly gestures. They are wearing simple clothes much like the clothes people wore in ancient Greece. They seem kind and generous. You remove your diving suit to find that the air is good to breathe.",
            
            "These people speak a language that is unknown to you, but one of them acts as an interpreter. You find out that this is Atlantis. They tell you it is governed by a man who is greedy, selfish, and dangerous. The people are like slaves. Everyone is unhappy except a few who serve the ruler as his lieutenants. These new friends ask for your help. Perhaps you can help them escape.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 59,
                 prompt: "*If you decide to leave your new friends and search for the ruler, turn to page 59.*")
            
            ,
            
            Edge(destinationId: 60,
                 prompt: "*If you decide to help our new friends escape, turn to page 60.*")
            
            ,
            
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 45,
         paragraphs: [
            
            "Quickly you get into the *Seeker* in an attempt to escape the strange submarine. The sub is chasing you, so you put on full emergency ascent power. You could use your laser cannon to blast the sub, but you do not wish to hurt anyone.",
            
            "The ascent towards the surface is swift, but a few fathoms from the surface all systems on the *Seeker* fail. You are suspended in the water in a helpless position. An unknown force has disabled you. Your onboard computers are unable to pinpoint the origin or nature of the force.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 62,
                 prompt: "*If you try to escape from the* Seeker *and try for the surface on your own, turn to page 62.*")
            
            ,
            
            Edge(destinationId: 64,
                 prompt: "*If you decide to wait on board the* Seeker *for help from the Maray, turn to page 64.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 46,
         paragraphs: [
            
            "Cautiously you enter the ship's cabin. Clay jugs called amphorae, once filled with oils and wines are strewn about. There are no remains of the crew. You have a sense of being in ancient Greece. It is like being in a dream. A door leads to a smaller cabin. On a table near the rear of this cabin is a golden box. Opening it you find the remains of a map. It does not show Atlantis. It shows that the ship was searching for an access point that leads to the center of the earth!",
            
         ],
         image: "node-47",
         edges: [
            
            Edge(destinationId: 47,
                 prompt: "Turn to the next page")
            
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 47,
         paragraphs: [
            
            "You return to the *Seeker* and use the map to locate this shaft to the center of the earth. Using some guesswork to interpret the map, you discover the tunnel opening, which appears to be roughly 100 feet in diameter. The sonar readings indicate the shaft has no bottom.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 63,
                 prompt: "*If you decide to descend into the shaft, turn to page 63.*")
            
            ,
            
            Edge(destinationId: 66,
                 prompt: "*If you decide it is time to go back up to the surface, turn to page 66.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 48,
         paragraphs: [
            
            "The trip back to the surface is smooth, and finally the *Seeker* is hauled aboard the *Maray*. You climb out and are greeted by the scientists and crew. The *Seeker* is prepared for the second dive, but suddenly the wind rises and the sea kicks up into furious waves that crash over the deck of the *Maray*. All hands rush to prepare for hurricane force winds. There is no chance for the second dive to begin. All day and all night the *Maray* pitches on the stormy sea.",
            
            "The next morning the wind has died and the sky is clear. You are now ready to dive again.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 50,
                 prompt: "*Turn to page 50.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 49,
         paragraphs: [
            
            "A helicopter is sent to pick you up and return you to an air base for a flight back to the United States. Newspaper reports indicate that the search for Atlantis has been given up. Several months later, however, a group of scientists get in touch with you. They believe that Atlantis can be found. They put together another expedition and want you to join it. You are tempted. Adventure into the unknown is what you like.",
            
         ],
         image: "node-49",
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Saved by\\nhelicopter"))
    
    ,
    
    Node(id: 50,
         paragraphs: [
            
            "Again the *Seeker* is lowered over the side of the *Maray* and slips into the ocean. Fish swim by, peering cautiously at you in your titanium and ceramic shell. The sunlight fades as you descend into the abyss.",
            
            "You are headed for the giant canyon below that might lead to Atlantis. When you reach the canyon, you switch on the *Seeker*'s searchlight. Immediately you spot the round hole that appears to be made by intelligent beings. Perhaps it leads to Atlantis.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 8,
                 prompt: "*Turn to page 8.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 51,
         paragraphs: [
            
            "You are dizzy from lack of oxygen and fatigue. With your knife you slash away at the heavy brown kelp that surrounds you. Bit by bit, you seem to be getting free. Then suddenly you shoot up through the last clinging pieces of seaweed and reach the surface.",
            
            "You fire the special signal flare and the crew of the *Maray* quickly spots you. Within a few moments you are safely aboard, surrounded by your friends. What a relief to be out of that nightmare world!",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 67,
                 prompt: "*If you dive again the next day, turn to page 67.*")
            
            ,
            
            Edge(destinationId: 68,
                 prompt: "*If you want to rest a few days and make emergency plans, turn to page 68.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 52,
         paragraphs: [
            
            "The three people of Atlantis sense your wish to return to the surface. Instantly, they produce a bubble–shaped capsule and put you inside.",
            
            "\"Farewell, earth person. May you live a long and prosperous life.\"",
            
            "You shoot up swiftly through the sea and break out onto the surface near the *Maray*. The capsule that protected you disintegrates upon reaching the surface. Once aboard the *Maray*, you tell the crew and the scientists about your adventure. They are kind to you, but no one believes you. They think you have imagined the world of Atlantis as a result of being so deep for so long.",
            
            "Back it the United States, you begin a television tour telling about Atlantis. You write articles and a book. You are paid a great deal of money for this work. You are tempted to use this money for another expedition.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 74,
                 prompt: "*If you use your money for another expedition, turn to page 74.*")
            
            ,
            
            Edge(destinationId: 75,
                 prompt: "*If you decide to retire and lead a life of ease, turn to page 75.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 53,
         paragraphs: [
            
            "The worst thing you could do would be to panic. You relax and drift with the current which suddenly takes you upward. You cut through the kelp and are free. What a relief.",
            
            "No sooner do you get out of the kelp, than you are caught in the vortex of a giant whirlpool!",
            
         ],
         image: "node-53",
         edges: [
            
            Edge(destinationId: 69,
                 prompt: "*If you try to swim out of the whirlpool, turn to page 69. Kick like crazy!*")
            
            ,
            
            Edge(destinationId: 70,
                 prompt: "*If you dive into the vortex of the whirlpool hoping to reach the bottom and get out, turn to page 70.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 54,
         paragraphs: [
            
            "The three people lead you into an enormous cavern. In the center of the cavern is a huge, silver colored machine. It is shaped like a long tube with several round panels attached to one end.",
            
            "They lead you inside. It is the most advanced control room that you have ever seen. Computers, sensing devices, recording devices, monitors, and a series of digital screens fill the room. A strangely–shaped figure with a very large head and totally blank eyes faces you.",
            
            "\"So, now you are in the control room of Atlantis. You see our secret. We landed on this planet 3,000 years ago. We used our anti–matter device to sink this continent beneath the sea to escape from your people. You can have a most pleasant and useful life here with us if you wish. All you need to do is allow us to inject you with a special serum to enable you to live down here. It is up to you. On the other hand, if you do not wish to be one of us, you will be held prisoner.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 71,
                 prompt: "*If you submit to the injection, turn to page 71*")
            
            ,
            
            Edge(destinationId: 72,
                 prompt: "*If you decline, turn to page 72.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 55,
         paragraphs: [
            
            "\"I wish to join the Nodoors,\" you tell your guide. He leads you to the outskirts of the city.",
            
            "\"I must leave you now. Good luck.\" The Nodoors send a greeting party that is heavily armed. They are suspicious of you and believe that you are a spy sent by the Atlanteans. They look exactly like the Atlanteans, but they rarely smile.",
            
            "\"Come with us. You must be questioned. Perhaps you will work for us.",
            
            "For three days you are questioned and kept in a small room without windows. These people are not kind and you believe that you have made a mistake. They ask you to help them spy on the Atlanteans. They suggest that, as a spy, you could pass freely between both groups.",
            
         ],
         image: "node-55",
         edges: [
            
            Edge(destinationId: 76,
                 prompt: "*If you decide to escape, turn to page 76.*")
            
            ,
            
            Edge(destinationId: 77,
                 prompt: "*If you decide to accept their offer, turn to page 77.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 56,
         paragraphs: [
            
            "You decide to remain with the Atlanteans. Their approach to life seems ideal. Time is spent in creating things to help life and not to destroy it. You believe their leader is speaking the truth when she tells of avoiding war and of not hating.",
            
            "You are fascinated by this apparently ideal world. You would like to stay and research the history of how Atlantis became what it is and what caused the split between the Atlanteans and the Nodoors. Yet in your mind remains the hope of escape so that you can go back to your own world.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 78,
                 prompt: "*If you decide to stay and spend your life researching the history and secrets of Atlantis, turn to page 78.*")
            
            ,
            
            Edge(destinationId: 79,
                 prompt: "*If you decide to escape, turn to page 79*")
            
            ,
            
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 57,
         paragraphs: [
            
            "A large white light shines down on you as you lie on the operating table. You become unconscious. Pleasant thoughts, sounds, and pictures occupy your mind. When you awake, you feel no pain nor any real change. But now you can breathe underwater and join the Atlanteans in their world.",
            
            "For several weeks you explore the world under the sea as you never have seen it before. Without the heavy oxygen equipment on your back, you feel a marvelous sense of energy and you glide through a world of beauty. Your two guides have become very good friends and they take you on adventures in the deep, exploring the ocean bottom and getting to know the fish and other sea creatures. It is a very exciting life indeed. You like it, but you regret that you will never again know the world above the sea.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Can breath underwater;\\nyou join Atlanteans"))
    
    ,
    
    Node(id: 58,
         paragraphs: [
            
            "\"No, I refuse to have this insane operation. I don't want to become a fish!\"",
            
            "The Atlanteans try to convince you that life with them will be happy, useful, and long. Yet you still refuse. Sadly they give up their arguments and spray vou with a special mist that immediately knocks vou out. Several hours later you gain your senses only to find that you are in an underwater air tank where you breathe naturally. Your closest neighbor is a horse who looks at you with sorrow and understanding. The Atlanteans have built a small apartment very much like the ones in the world above the sea. People come by and look at you and talk with you.",
            
            "Maybe you have made a real mistake. They no longer want you to join them in their world and way of life. You refused their offer and now you are a prisoner in a zoo.",
            
         ],
         image: "node-58",
         edges: [],
         ending: Ending(classification: .disappointing,
                        description: "Survive, but\\nin Atlantean zoo"))
    
    ,
    
    Node(id: 59,
         paragraphs: [
            
            "It doesn't take you long to find the king. One of his countless agents leads you to him. He is in a small simple room with a strobe light glowing from the rounded ceiling.",
            
            "\"So, you have found your way here after all. Put your mind at rest. I won't hurt you.\" The king's booming voice startles you. He invites you to sit down.",
            
            "After several hours with the king, you find him to be bright, friendly, and interesting. Maybe the Atlanteans are wrong about this person.",
            
            "He offers you a chance to join his government. He tells you that most people are lazy and selfish and deserve to be ruled with power and command. He has been king for almost 1,000 years and he has survived because he is not afraid to be tough. He wants you to be an advisor on his staff.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 80,
                 prompt: "*If you decide to accept the king's offerand work for him, turn to page 80.*")
            
            ,
            
            Edge(destinationId: 82,
                 prompt: "*If you decide to refuse and go back to join the other people, turn to page 82.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 60,
         paragraphs: [
            
            "The problem is where do they escape to? The king is in charge. He rules the world below the sea and his spies are everywhere. The only answer is to devise a plan to capture the king and put him in prison.",
            
            "The people are frightened. Some citizens tried to revolt years before and are still in prison. The king is smart and suspicious of everyone.",
            
         ],
         image: "node-60",
         edges: [
            
            Edge(destinationId: 61,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 61,
         paragraphs: [
            
            "You suggest a plan to put on a festival with a play. On a given signal the actors and the people in the audience will rise up and seize the king. The actors will be carrying real weapons, but no one will suspect them because they are in the play.",
            
            "The people like the plan. They ask you to become their leader.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 81,
                 prompt: "*If you accept their wish to become their leader, turn to page 81.*")
            
            ,
            
            Edge(destinationId: 84,
                 prompt: "*If you decide to help them in the planning, but also to escape from this sad world, turn to page 84.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 62,
         paragraphs: [
            
            "There is one way out. You decide to leave the *Seeker* and try to reach the surface on your own You enter the airlock chamber which gives you access to the ocean. With a quick push off, you leave the *Seeker* and swim toward the surface. A small, yellow life raft is part of your escape equipment. The surface of the sea is calm, but the *Maray* is nowhere in sight.",
            
            "For two days and nights you drift in the life raft under hot sun and sharp starlight. At last a search helicopter spots you. Finally you are safe.",
            
            "The exploration of Atlantis will have to depend on a new diver. Your eyesight has been damaged by the strange force that immobilized the *Seeker*. Your career as an underwater adventurer is over.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .disappointing,
                        description: "Survive but\\neyesight damaged"))
    
    ,
    
    Node(id: 63,
         paragraphs: [
            
            "Why not go? Who would believe it? The center of the earth! You push the control column forward and dive deep. Soon there's no more water, just a heavy gas that acts like water. You look at a world of colors and drifting forms. You pass by layers of rock and sand. Suddenly you sail into a gooey mass which almost fouls the *Seeker*'s propellers. The *Seeker*'s engine stops and you are pulled along through the semi–liquid material by something like gravity or magnetism. You burst through a thick elastic membrane and enter an area of giant atoms. Electrons whirl around you at high speed, but there is plenty of room to maneuver between these fast–moving particles. The electrons are revolving around a small mass you know is called the nucleus. You are able to avoid collisions with the electrons. What a world!",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 87,
                 prompt: "*If you continue on this trip to the center of the earth, turn to page 87.*")
            
            ,
            
            Edge(destinationId: 88,
                 prompt: "*If you try to turn back, turn to page 88.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 64,
         paragraphs: [
            
            "The best plan is to wait until the *Maray* locates you with sonar equipment. You can't signal the ship because none of the *Seeker*'s electronic equipment is working. There is no sign of the mysterious submarine. Perhaps it has left, now that you have been chased away from the world of Atlantis.",
            
            "Looking out of the thick glass porthole, you see a giant blue whale heading for you. It looks as though the whale is going to ram you. Maybe the other submarine has angered the whale and it is seeking revenge on any craft near it.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 65,
                 prompt: "*Turn to the next page*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 65,
         paragraphs: [
            
            "Suddenly the whale hits you full force. The *Seeker* is badly damaged. Water begins to trickle in through the hatch cover. You must abandon the *Seeker*. The whale now remains close to the *Seeker*, watching and waiting.",
            
         ],
         image: "node-64",
         edges: [
            
            Edge(destinationId: 62,
                 prompt: "*If you decide to try and escape, turn to page 62.*")
            
            ,
            
            Edge(destinationId: 83,
                 prompt: "*If you try to hitch a ride on the whale, turn to page 83.*")
            
            ,
            
            Edge(destinationId: 86,
                 prompt: "*If you don't know what to do, turn to page 86.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 66,
         paragraphs: [
            
            "You face the fact that it is too dangerous to dive into a deep hole that might lead to the center or the earth. It's best to return to the surface and work out a plan of action.",
            
            "You give one last look at the opening, check the *Seeker*'s instruments and head up to the surface. Finally, the *Seeker* breaks through into fresh air and sunlight, and you wait to be picked up by the *Maray*.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 31,
                 prompt: "Turn to page 31.")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 67,
         paragraphs: [
            
            "You insist that you are all right and will dive again the next day. The scientists try to convince you that it is foolhardy to go down again so soon. The captain of the *Maray* reports that a large storm system is coming and the next day will probably be the last day of diving for some time.",
            
            "Against advice, you enter the *Seeker*, wave farewell to all your friends and descend into the deep. You feel tired but excited.",
            
            "When you reach the bottom, you decide to explore the ledge along the deep canyon.",
            
         ],
         image: "node-67",
         edges: [
            
            Edge(destinationId: 6,
                 prompt: "Turn to page 6.")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 68,
         paragraphs: [
            
            "A violent storm is reported heading your way. The captain decides to move the Mary to the sheller of a nearby island. It's too dangerous to remain where you are. Deckhands lash the *Seeker* securely to the deck of the *Maray* and you get underway.",
            
            "The storm breaks before you can reach the safety of the lee side of the island. The *Seeker* is torn loose and lost overboard. The computers aboard the *Maray* are damaged by a surge of electricity caused by a lightning strike. You are all alive, but there are no replacements for the damaged equipment. The money has run out. The expedition to Atlantis is over.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .mediocre,
                        description: "Survive, but all\\nequipment lost"))
    
    ,
    
    Node(id: 69,
         paragraphs: [
            
            "It's no use. The whirlpool has you in its grip. You feel your arms and legs being torn in every direction. There is no way out. Round and round you go.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 96,
                 prompt: "*If you use your laser pistol to blast a hole in the whirlpool wall, turn to page 96.*")
            
            ,
            
            Edge(destinationId: 97,
                 prompt: "*If you continue to struggle, turn to page 97.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 70,
         paragraphs: [
            
            "You can't swim out of the whirpool. There is only one thing to do: dive deep into the center.",
            
            "You kick several times and hurl yourself into the center of the whirlpool. Lights and colors dance before your eyes. You lose all track of where you are. Time has ceased to be a factor. You find yourself standing on the ocean floor. You can look up through the center of the whirlpool and see the skv more than 2,000 feet above you. It is a tiny patch of blue.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 98,
                 prompt: "*If you try to return to the surface, turn to page 98.*")
            
            ,
            
            Edge(destinationId: 99,
                 prompt: "*If you set out to explore this strange area, turn to page 99.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 71,
         paragraphs: [
            
            "Perhaps you are being foolish, but you decide to join them. The injection is painless and you feel no different than before. They lead you to a comfortable room where you all share a special tea in celebration of your decision.",
            
            "\"You see, all living beings are basically the same. Everything is connected in life. We have come from a different planet in search of other living beings. We have to be very careful about taking new people to our planet. Some of your people seek us out, just like you. We choose carefully.",
            
            "You are amazed at what they say. A choice is given to you. You can either journey with them through time and space to their planet, or you can remain in underwater Atlantis as a worker recording information about life on earth.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 89,
                 prompt: "*If you decide to stay in Atlantis as a worker, turn to page 89.*")
            
            ,
            
            Edge(destinationId: 90,
                 prompt: "*If you decide to travel with them in space and time, turn to page 90.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 72,
         paragraphs: [
            
            "The idea of being injected with a serum and joining them for the rest of your life is awful. You must plan an escape.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 73,
                 prompt: "*Turn to the next page")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 73,
         paragraphs: [
            
            "When your captors are not looking, you slip away and dash for the door of the spacecraft. You fall to notice a laser beam guarding the exit hatch, Stepping into the laser beam, you freeze in midstep, The Atlanteans gather round you sadly and tell you that you will have to remain this way for the earth equivalent of 23 years and 61 days until the effects wear off. Then you will be given a second chance.",
            
         ],
         image: "node-72",
         edges: [],
         ending: Ending(classification: .disappointing,
                        description: "Frozen for\\n23 years"))
    
    ,
    
    Node(id: 74,
         paragraphs: [
            
            "The only way to prove that you are not crazy is to lead another expedition back to Atlantis. You take all the money from the TV appearances and aricles and outfit a ship, hire a crew, rent the *Seeker* and set sail. Most people think that you are out of your mind. You'll show them.",
            
            "Poised over the spot you so carefully marked on the charts, you dive down in the *Seeker*. Again you find the hidden grotto. You move some algae on a wall of the grotto and notice a metal panel.",
            
            "The panel seems to seal off a passageway. It is locked. You try to open it with the *Seeker*'s drilling arm, but it will not budge. It is frustrating to be so close to the secret and yet so far from it.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 92,
                 prompt: "*Should you blast the panel with the laser beam? If so, turn to page 92.*")
            
            ,
            
            Edge(destinationId: 93,
                 prompt: "*If you wait patiently to be observed and invited in, turn to page 93.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 75,
         paragraphs: [
            
            "You argue with yourself for several weeks about getting out on a new expedition. Money is not the issue. You fear that finding Atlantis will ruin it for the Atlanteans. You believe that their civilization must be protected. You decide to use the money you have made to carry on research on space and life on planets in other galaxies. Someday perhaps, you will meet the Atlanteans in space.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 106,
                 prompt: "*If you don't like this ending, turn to page 106.*")
            
         ],
         ending: Ending(classification: .favorable,
                        description: "Give up search;\\nbecome astronomer"))
    
    ,
    
    Node(id: 76,
         paragraphs: [
            
            "Escape will be difcult, but you decide that you must get away from these people. The best plan is to tell them that you want to accept their offer to sou on the Atlanteans. They are of course happy when you tell them that you will work for them.",
            
            "\"You see, the Atlanteans are jealous of us. We must be on our guard or else they'll invade and destroy us.\"",
            
            "You don't believe the Atlanteans are jealous of the Nodoors, but you don't argue. They take you back to the outskirts of their area, and you leave to join the Atlanteans. Once back with the Atlanteans, you ask them to allow you to live with them. You know that you will never be allowed to leave their underwater world, but there is always the hope for escape. It could be a good life.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .mediocre,
                        description: "Survive but\\nwith Nodoors"))
    
    ,
    
    Node(id: 77,
         paragraphs: [
            
            "\"Okay, I'll do it,\" you say. \"I'll join you and spy on the Atlanteans. Who knows, maybe they aren't as bad as you think.\"",
            
            "The Nodoors are delighted. They give you a room in a large building where most of them live. It is gray and forbidding, more like a prison than anything else. That night when all are asleep, you sit sleepless and realize that you are caught in a trap of your own making. It comes to you that the Nodoors are from a different planet and are unhappy outcasts. The Atlanteans want nothing to do with them. You chose the wrong side.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 107,
                 prompt: "*If you don't like this ending, turn to page 107.*")
            
         ],
         ending: Ending(classification: .disappointing,
                        description: "Survive as\\nNodoor spy"))
    
    ,
    
    Node(id: 78,
         paragraphs: [
            
            "Maybe you can learn from the Atlanteans how they achieve such happiness in their lives. You seek out their history.",
            
            "Announcing your decision to stay, you are treated with kindness and friendship. You explain that you would like to help in their underwater food production.",
            
            "Atlantis was an advanced civilization thousands of years ago. The citizens nourished their peaceful thoughts and plucked out their hateful thoughts, as one would tend a garden. Their minds became a rich and dazzling universe, clear and unbounded.",
            
            "You have so much to do helping with sea plants and studying their history that you soon forget the *Seeker*.",
            
         ],
         image: "node-78",
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Find Atlantis;\\nstudy their history"))
    
    ,
    
    Node(id: 79,
         paragraphs: [
            
            "When you get a chance and everyone is occupied, you dash for the tunnel exit and make it out into the water. No alarms sound. No one chases you. It's strange; they said they wouldn't allow you to return to the world above the sea. Why are they letting you escape?",
            
            "You swim toward the surface. No one could survive the pressure and lack of oxygen, but you suddenly find yourself hackingaway at brown seaweed. You are just a short way from the surface.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 51,
                 prompt: "*Turn to page 51.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 80,
         paragraphs: [
            
            "An advisor to a king! What a chance. Maybe the king has ruled so long that he is out of touch with the people. Perhaps as his advisor you can help the people get what they want. You don't believe that people are lazy and selfish. The king just needs a new point of view.",
            
            "You are appointed the king's special advisor on problems of research on food and shelter. You immediately call general meetings of all the people to discuss the food program and the work schedules. The king is so glad to have someone else take over the problems that he leaves it in your hands entirely. He gives you land and a large salary. You set up new programs and schedule the people in the planning work. You listen to their complaints and their ideas. Life under the sea is rich and full. The people are hard–working and good. It was a wise decision to remain.",
            
         ],
         image: "node-80",
         edges: [],
         ending: Ending(classification: .great,
                        description: "Become advisor\\nto a king"))
    
    ,
    
    Node(id: 81,
         paragraphs: [
            
            "You don't want to lead a revolt but the people need you. You organize the play, and the king is pleased to have his people involved in a project that keeps them busy and happy. The people can't wait for the day when they can put the king in prison and make their own decisions.",
            
            "The night of the play the theater is filled, and everyone waits for the king to appear. There is a delay. The crowd grows nervous. A messenger from the king runs into the theater announcing that the king has had a serious attack of brain fever. He may not live.",
            
            "You wonder whether the king is really ill or whether he has found out about the plot against him. The people are confused and do not know what to do. They turn to you and you tell them to go on with the play. Just then, a squad of the king's soldiers enters the theater. They are headed for you.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 116,
                 prompt: "*If you allow them to capture you, turn to page 116.*")
            
            ,
            
            Edge(destinationId: 117,
                 prompt: "*If you try to escape, turn to page 117.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 82,
         paragraphs: [
            
            "Advisor to a mean king? Not a chance! You tell him that you want nothing to do with a tyrant who doesn't believe in people. You tell him to his face that the people are unhappy and angry. He laughs and tells you to go back to them if you wish. He warns you that the people are complainers, not workers.",
            
            "Once back with your new friends, you discuss how to overthrow the king and his henchmen. You hold secret meetings and work out a plan. But on the day of the revolt, someone discovers a leak in the volcano wall of the underwater world. The entire civilization is in danger. All thoughts of revolt are forgotten. The Atlanteans must stop the sea from crashing in on them. Everyone works for a common purpose. Survival is the goal.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 112,
                 prompt: "*If you decide to work with them in this time of disaster, turn to page 112.*")
            
            ,
            
            Edge(destinationId: 114,
                 prompt: "*If you decide to take advantage of this emergency to escape, turn to page 114.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 83,
         paragraphs: [
            
            "People ride dolphins, and you have met scuba divers who reported they held onto the flukes of whales for short rides. It sounds crazy, but this may be your only way of escape. You leave the *Seeker*, swim to the whale, and grab its fluke. With a smooth powerful movement, the giant mammal begins to swim to the surface. You have trouble holding on. The whale breaks the surface and lies there filling its lungs with air. You quietly swim away.",
            
            "You drift for two or three days, dozing and waking. You stay warm in your insulated dive suit; its special air packs keep you afloat. You are hungry and thirsty but unharmed by the time the search helicopter spots you bobbing in the waves.",
            
         ],
         image: "node-83",
         edges: [],
         ending: Ending(classification: .mediocre,
                        description: "Saved by\\nwhale"))
    
    ,
    
    Node(id: 84,
         paragraphs: [
            
            "It is their world, but you are willing to help them with the planning for the overthrow of the king. You want no real part in the revolt.",
            
            "The planning requires choosing new leaders and setting goals for the people. You almost decide to join them in the actual revolt but you really want to get back to your own world. Once the revolt is underway, you hope to slip away and return to the *Seeker* for a quick escape to the surface of the ocean.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 85,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 85,
         paragraphs: [
            
            "The day of the revolt, you can't resist the excitement of the Atlantans' bold enterprise, and you decide to stay with them and help in any way that you can. The endless planning and training pays off. The carefully selected band of men and women easily captures the king and his guards. The revolt has succeeded without shedding a drop of blood and the people celebrate for days.",
            
            "The Atlanteans treat you as if you are one of them, and, for the first time, you feel that you are.",
            
         ],
         image: "node-84",
         edges: [],
         ending: Ending(classification: .great,
                        description: "Assist with successful\\nAtlantean uprising"))
    
    ,
    
    Node(id: 86,
         paragraphs: [
            
            "You admit that you just don't know what to do. The whale is scary looking and you don't have any escape plans. So you wait and watch and listen.",
            
            "After what seems a long time, but is probably just a few minutes, the mysterious submarine returns, attaches a cable to the *Seeker*, and pulls you up to the surface. The submarine vanishes under the waves, leaving you to wait for the *Maray*.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Rescued by\\nmysterious sub"))
    
    ,
    
    Node(id: 87,
         paragraphs: [
            
            "The electrons whirl about at dizzying speeds and you continue until you get to a spot where your instruments indicate that there is no time. The digital clocks stop, the speed indicator stops, your heart stops, and yet you are alive. Every sense in your body seems more alive than ever before.",
            
            "You are aware of other beings close to you. No one has entered through the only hatch. Turning around, you see three Atlanteans. You feel that the *Seeker* has become just a thought and that the people from Atlantis have entered your mind and are aboard the *Seeker*. You try to enter their thoughts, but they tell you that you have not journeyed far enough to be able to become a thought traveler.",
            
         ],
         image: "node-87",
         edges: [
            
            Edge(destinationId: 94,
                 prompt: "*If you try to turn back from this strange world, turn to page 94.*")
            
            ,
            
            Edge(destinationId: 95,
                 prompt: "*If you decide to travel in thought-time-space, turn to page 95.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 88,
         paragraphs: [
            
            "No. you will not dive down toward the center of the earth. Once through the thin outer layer of the earth, you know that the regions beneath change from solid to molten and then to a hard core. At least that is the theory given by the geologists. You couldn't possibly survive such a journey. Anyway, you think that your sonar gear is probably not working correctly. The hole is deep, but you don't believe that it really goes all the way to the center of the earth. Caution is our approach. You go back to the surface to consult with the scientists aboard the *Maray*.",
            
            "The scientists tell you that their instruments have been damaged, perhaps by an approaching storm, and they too are cautious. They decide to move the *Maray* away from the site of the mysterious hole. The expedition retreats and you know your chance to discover Atlantis has slipped away.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .mediocre,
                        description: "Storm damage to\\n ship, abandoned search"))
    
    ,
    
    Node(id: 89,
         paragraphs: [
            
            "You've had enough adventure for now. Travel to another planet in a different galaxy sounds ilke more risk than you wish to take. Besides, you can always go later.",
            
            "You tell the people that you wish to stay and work in their society. Perhaps your knowledge of the sea can help them. They discuss your case very seriously for several days. When they are through talking, they offer you a choice of jobs in Atlantis. You may become a farmer or a musician.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 101,
                 prompt: "*If you decide to become an underwater farmer, turn to page 101.*")
            
            ,
            
            Edge(destinationId: 103,
                 prompt: "*If you decide to become a musician, turn to page 103.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 90,
         paragraphs: [
            
            "\"I will go with you. I want to see other parts of the universe.",
            
            "\"Congratulations. You will not regret this. We are ready to depart.",
            
            "They take you to a small room and three of them stand with you under a beam of intense light. You feel a rush of speed, and yet you are not moving. You feel as though you have traveled hundreds of thousands of miles in space. You rush past the sun, past and through the Milky Way, and on into other galaxies. Yet, you feel as though you are still standing in the same spot.",
            
            "Then you are on the planet Ager where the Atlanteans came from. It's a world of fantastic shapes and strange plants. The city gleams like a thousand searchlights. The shapes that must be their buildings are pure light pulsing with energy. Nothing is hard or sharp. Everything is light.",
         ],
         image: "node-90",
         edges: [
            
            Edge(destinationId: 91,
                 prompt: "*Turn to the next page*")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 91,
         paragraphs: [
            
            "You see no people, just forms of brighter light that move. Suddenly, some of the moving forms change into Atlanteans.",
            
            "\"Our bodies are not important. It is our energy that is important. You can see us in our body forms if you wish, but we only use them to communicate with people like you. You may choose to remain as you are or accept transformation.\"",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 100,
                 prompt: "*If you decide to stay in your body form, turn to page 100.*")
            
            ,
            
            Edge(destinationId: 102,
                 prompt: "*If you decide to be transformed into an energy shape, turn to page 102.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 92,
         paragraphs: [
            
            "You'll try to blast the hatch right off its hinges. You have the power. Your finger presses the red button that fires the laser cannon. A blinding flash erupts immediately. But the hatch remains firm. You fire again and again and again. Each time the *Seeker* is rocked by the force of the laser cannon. The reflected energy is damaging to your craft. You continue to fire the cannon, holding your finger on the button.",
            
            "Then there is a blinding flash inside the *Seeker* itself. The laser cannon explodes. You and the *Seeker* are destroyed.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .catastrophic,
                        description: "Killed by a\\nblinding flash"))
    
    ,
    
    Node(id: 93,
         paragraphs: [
            
            "It's never good to use force unless you are attacked and must defend yourself. You refuse ever to consider using the laser cannon; it might kill people and would certainly destroy any chance for friendship. You decide to wait patiently and hope that you will be noticed and invited in.",
            
            "For six hours you sit and wait for some sign. A green glow comes from the area ahead of you. It bathes the *Seeker* in a soft light. The hatch door opens. Three figures emerge and beckon to you to follow them.",
            
         ],
         image: "node-93",
         edges: [
            
            Edge(destinationId: 104,
                 prompt: "*If you follow, turn to page 104.*")
            
            ,
            
            Edge(destinationId: 105,
                 prompt: "*If you refuse to follow them, turn to page 105.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 94,
         paragraphs: [
            
            "This is too much for you. It's like a nightmare and you decide to turn back. But going back is much harder than you expected. The electrons whirl closer and closer to you as though they were guards keeping you from leaving. It is difficult to guide the *Seeker* in this maze of atoms. The instruments are useless now. The figures of the Atlanteans disappear. Suddenly, you are caught in the elastic membrane that almost stopped you before. It sticks to the *Seeker*, holding you back. You want to be free and return to the world you have known all your life.",
            
            "You lose consciousness and wake up several hours later in your dive suit floating above the hole in the ocean floor. The *Seeker* is gone. You're dazed. Did you dream the whole thing? Slowly you return to the surface, but the *Maray* has disappeared. You can't decide how much time has elapsed. You realize that your crew must think you are lost forever and you know they are right. The waves rock your unresisting body back and forth as you float alone in the vast sea. You feel your strength slowly draining away.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .catastrophic,
                        description: "Die floating\\nin vast sea"))
    
    ,
    
    Node(id: 95,
         paragraphs: [
            
            "A thought traveler! You realize that people do it all the time in daydreams. Of course, you want to be a thought traveler, but how?",
            
            "The Atlanteans speak softly and tell you that all things are the same–past, present, future. It simply requires you to concentrate and put your thoughts where you wish them to be.",
            
            "You try, and amazingly you are rapidly rushed through time to the day you were born, then to the day you made your first deep–sea dive. Your mind flies from one time in your life to another. But when it comes to the future, you meet a blank wall. You can't seem to travel into the future.",
            
            "\"Why can't I travel ahead in time?\" you ask the Atlantans.",
            
            "\"Be patient,\" they reply. \"All in good time.\"",
            
            "Suddenly you whirl through time into the outer reaches of the universe where you can actually feel the light going through you. You cast no shadow. A sense of peace fills you.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 110,
                 prompt: "*If you decide to drop out of thought travel and return to earth life, turn to page 110.*")
            
            ,
            
            Edge(destinationId: 111,
                 prompt: "*If not, turn to page 111.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 96,
         paragraphs: [
            
            "You have a laser pistol for emergencies. You blast a hole in the whirlpool wall and dive through it, Facing you is a school of fish who are puzzled by this strange intruder. Behind them is a shark. You swim toward the surface slowly and the shark disappears into the deep.",
            
            "The *Maray* is nowhere in sight. You are wondering how long you'll be waiting when a loud splashing, sighing sound startles you. A huge whale has surfaced and lies nearby spouting and sucking in great noisy draughts of air. It takes you a good half–hour to swim to the enormous creature. It pays no attention to you. You climb onto its tail and crawl on hands and knees toward the highest point of its back. It's like creeping up a gigantic gray rock.",
            
            "From your vantage point on top, sure enough, you can see the *Maray* and the tiny glint of binocular lenses reflecting in the sun. The *Maray* crew is watching the whale. You wave, feeling certain they have seen you. It won't be long before they come to collect you.",
            
         ],
         image: "node-96",
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Rescued by\\nMaray crew"))
    
    ,
    
    Node(id: 97,
         paragraphs: [
            
            "You faint, and when you come to, you are floating on the surface of the ocean. There is a heavy ocean swell and the sun beats down on you. The whirlpool must have stopped as quickly and mysteriously as it began. You feel dizzy and exhausted and you move gently to make sure you haven't broken any bones. As you move your head slowly inside your helmet you feel an intense pain shooting across your right temple. You have to lie very still then and gradually your ears pick up the thrum of the search helicopter. You don't dare move to look, but as the minutes go by, the thrum gets louder and slowly disappears. The helicopter has passed over you. It won't return this way. The pain in your temple increases. You begin to lose consciousness.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .catastrophic,
                        description: "Search\\nhelicopter\\nmisses you"))
    
    ,
    
    Node(id: 98,
         paragraphs: [
            
            "The walls of the whirlpool look like solid ridges sloping upwards to the surface. The water in the center looks absolutely calm. You wonder if you could swim up through that calm. It's worth a try, and you set off. Before you can tell if you're making any progress, the whirlpool reverses and instead of whirling down, it whirls up and catapults you out of the ocean and into the air. You fall back onto the surface of the ocean close to the *Maray*. Although you are stunned by the fall, you quickly gain your senses and are picked up by the ship. Of course no one believes your story, but then even you think it is almost too fantastic to have happened.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Whirlpool releases\\nyou near the Maray"))
    
    ,
    
    Node(id: 99,
         paragraphs: [
            
            "There is a small metal hatch on the ocean floor. You pull with all your strength, but it won't open. You rest for a moment and look through the wall of water surrounding you. Two fish stare back at you! It's as though you are in an aquarium for the fish to look at.",
            
            "The hatch opens and a voice commands you to enter. With fear and caution you walk down a corridor that leads to a small room. Three people meet you.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 54,
                 prompt: "*Turn to page 54.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 100,
         paragraphs: [
            
            "You just can't give up your body. It might be all right for the Atlanteans to move about as pure energy, but you have not reached a point where you are willing to risk what you are for what they are.",
            
            "It is strange wandering about with bright glowing blobs of energy. They ask you to give talks about life on earth as you know it, and you agree. For two years vou meet with the Atlanteans in their energy forms and talk about earth and how people live and what they do. The Atlanteans are interested in all aspects of earth life: the technology, politics, wars, and religion.",
            
            "You ask them why, but they never give you a direct answer. Then one day you look down at yourself and you only see bright, glowing energy. With horror you realize you have become one of them.",
            
         ],
         image: "node-100",
         edges: [],
         ending: Ending(classification: .disappointing,
                        description: "Reluctantly become a\\nbeing of pure energy"))
    
    ,
    
    Node(id: 101,
         paragraphs: [
            
            "Farming under the sea is a job that you enjoy. Outside Atlantis, there are fields of sea plants that are tended like gardens back on earth. Atlanteans go out each day and harvest the plants, take care of the fields, and chase away the fish that love to nibble on the growing plants. Then there are fish pens to work where you feed and tend the fish until they are needed for food. Farming under the sea is beautiful and it is much easier than you had imagined. Danger lurks, though, in the form of stingrays, slender sea snakes, and occasional sharks. You have to be on your guard at all times.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Become an\\n underwater\\nsea farmer"))
    
    ,
    
    Node(id: 102,
         paragraphs: [
            
            "You are in the Atlantean world; why not become like an Atlantean? Looking down at your hands you see them gradually begin to glow with a warm, yellow light. Little by little, the glow travels up your arms and legs until suddenly you have no body left. You are a glowing energy form. You feel a sense of freedom and happiness that you have never known before. You can float, or fly, or zoom anywhere you want to. No walls stop you; you melt through them. You don't need food or rest, you can travel through time, and you can travel instantly back to earth in your energy form.",
            
            "You feel that this is the way you want to be.",
            
         ],
         image: "node-102",
         edges: [],
         ending: Ending(classification: .great,
                        description: "Choose to become\\nbeing of pure energy"))
    
    ,
    
    Node(id: 103,
         paragraphs: [
            
            "A musician in the world of Atlantis? Who would believe it? You are asked to choose an instrument to play. You examine water lutes, sea drums, shark bone flutes, and a wide range of electronic instruments. You choose one of the electronic instruments, but it makes no sound at all. You are told that it plays music that people feel rather than hear. What a world you're living in! Who would believe in music that is not heard? Gradually you learn to feel the different notes with parts of your body: your thighs, chest, temples, and fingertips. Your interest in this new way of sensing music grows with each day. You master this new art form. You become their greatest musician.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .great,
                        description: "Study\\nAtlantean\\nmusic"))
    
    ,
    
    Node(id: 104,
         paragraphs: [
            
            "These people lead you to a control room. There you meet the commander of an underwater scientific center that is conducting secret research into life underneath the sea. They inform you that it was a good thing that you did not use your laser cannon, because they have anti–laser devices that would have blown you and the *Seeker* to pieces. After a pleasant meal and a tour of the deepwater lab, you are sent back to the *Seeker* for a return journey to the surface. You are told never to return again; if you do, you will be kept a prisoner for the rest of your life.",
            
         ],
         image: "node-104",
         edges: [],
         ending: Ending(classification: .mediocre,
                        description: "Find secret\\nmilitary base;\\nreleased"))
    
    ,
    
    Node(id: 105,
         paragraphs: [
            
            "When you refuse to follow them, they take out small hand–held hypnotizers that put you into a deep trance. You are led through a long tunnel into a large underwater lab. Three military technicians come up to you and break the trance.",
            
            "\"You have stumbled into a secret military base. We're developing too many secret plans to risk being discovered. You will remain our prisoner.\"",
            
            "There is no escape.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .disappointing,
                        description: "Imprisoned in\\nmilitary base"))
    
    ,
    
    Node(id: 106,
         paragraphs: [
            
            "You argue with yourself for weeks, finally deciding to go back to Atlantis. You are in such a hurry to return that you hire a small, fast hydrofoil to take you to the spot in the ocean where Atlantis is. Once reaching the spot, you intend to make a dive with scuba gear! You know a 2,000–foot dive is impossible, but you don't care. You must make the attempt.",
            
            "A storm rips the sea for six days and when it clears, you prepare to dive. Just as you slip into the water, you look up into the sky and high above the clouds you see the sparkling city of Atlantis. No dive is necessary.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .great,
                        description: "Find Atlantis\\nafter major storm"))
    
    ,
    
    Node(id: 107,
         paragraphs: [
            
            "During the night, you are awakened by the sound of voices whispering. Listening, you realize that a group of Nodoors is planning an escape. They want to join the Atlanteans. They believe that life in Atlantis can be better for them. You join them and listen to the stories of fear and darkness. They seek light and friendship. It sounds simple, but nothing is easy.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 108,
                 prompt: "*Turn to the next page.*")
            
            ,
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 108,
         paragraphs: [
            
            "Suddenly the door bursts open. Three guards armed with special weapons rush in.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 109,
                 prompt: "*Turn to the next page")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 109,
         paragraphs: [
            
            "They fire the weapons and in a flash of brilliant light you and your companions are vaporized.",
            
         ],
         image: "node-108",
         edges: [],
         ending: Ending(classification: .catastrophic,
                        description: "Vaporized\\nby guards"))
    
    ,
    
    Node(id: 110,
         paragraphs: [
            
            "1,000 years of thought travel later, you are called into the main thinking room. \"Well done, human. Now you can return to your world if you wish \"",
            
            "With great relief, you do return. What surprises greet you. The great cities of the world–New York, London, Paris, and Hong Kong–are overgrown with vegetation. The roads leading into the cities are barely visible. But you see signs of new settlements. There are clusters of buildings spread out in the countryside. You don't see any smokestacks. There are few roads and no cars. The people live a simple life providing themselves with food, shelter, and clothing. You wish to join them.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Survive 1,000\\nyears in future"))
    
    ,
    
    Node(id: 111,
         paragraphs: [
            
            "One day your friends tell you that you can return to earth if you wish. You consider it carefully and decide that because of your thought traveling ability, the life you now lead is what you want. You decide to stay where you are forever.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .great,
                        description: "Become thought\\ntraveller in future"))
    
    ,
    
    Node(id: 112,
         paragraphs: [
            
            "Years ago the Atlanteans had worked out emergency procedures, but most people had forgotten them. One old person remembers where the emergency instructions and equipment were kept.",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 113,
                 prompt: "Turn to the next page")
            
         ],
         ending: nil)
    
    ,
    
    Node(id: 113,
         paragraphs: [
            
            "You and the Atlanteans work without stop for 12 hours pumping out the flooding waters and building a special retaining wall around the volcanic crack. Finally the last pump is shut off. You are all exhausted, but you've won in your battle against the sea.",
            
         ],
         image: "node-112",
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Survive underwater\\nflood"))
    
    ,
    
    Node(id: 114,
         paragraphs: [
            
            "With everyone worried about the sea crashing in, no one will notice you if you try to escape. You run down a long, little–used corridor that leads to the sea. The exit door is heavy and rusty from lack of use. You push with all your might, and finally it swings open into an airlock to the open water. You push the emergency release button and shoot out into the water. ",
            
         ],
         image: nil,
         edges: [
            
            Edge(destinationId: 115,
                 prompt: "*Turn to the next page*")
         ],
         ending: nil)
    
    ,
    
    Node(id: 115,
         paragraphs: [
            
            "The *Seeker* is where you left it, and once inside, you head for the surface where the *Maray* waits for you.",
            
         ],
         image: "node-114",
         edges: [],
         ending: Ending(classification: .favorable,
                        description: "Escape to\\nsurface and rescued"))
    
    ,
    
    Node(id: 116,
         paragraphs: [
            
            "It is useless to try to escape the soldiers. You are surrounded. They take you to the king, and he sadly tells you that you are just like all the rest. He can't trust anvone. He will have to decide what to do with you and in the meantime he throws you into the dungeon. ",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .disappointing,
                        description: "Thrown in\\ndungeon"))
    
    ,
    
    Node(id: 117,
         paragraphs: [
            
            "How can you escape? The soldiers are coming after you. You scream as loud as you can: \"Help me!!!\" Everyone in the theater surrounds you, forming a barrier to the soldiers. The soldiers stare at the people, hesitate, and quickly leave. They know that the odds are too great to win such a fight.",
            
            "The people cry for the revolt to go on. The crowd leaves the theater and heads to the king's quarters. All along the route people join you and even the king's soldiers begin to join the crowd.",
            
            "You and the people are free; the king is put in prison. The revolt is a success.",
            
         ],
         image: nil,
         edges: [],
         ending: Ending(classification: .great,
                        description: "Leader of\\nsuccessful revolt"))
    
    ,
    
]
