This is the project for the Introduction to Agent-Based Modeling course, offered in Summer 2022 by Santa Fe Institute's https://www.complexityexplorer.org/.

## WHAT IS IT?

This model addresses the first stages of honeycomb formation, and is inspired by the following paper: https://iopscience.iop.org/article/10.1088/1742-6596/2207/1/012013/pdf.
The authors state that the first stage involves the formation of "tetrapod" structures which, projected onto a 2D surface, result in tripods; these tripods eventually connect and form the basis for the 3D familiar honeycomb structure.

The inputs of the model are:
- some parameters, as per the User Interface.

The outputs are:
- the efficiency of the formation of patterns;
- the fraction of excised wax to build clusters;
- a visualisation of the building process, where the surviving yellow patches should approximate the wanted 2D structure.

## HOW IT WORKS

The agents are:
- excavator bees;
- attacher bees.

Shortly, the order of events is the following: during a tick, each attacher releases wax if it's on the boundary of a wax cluster, while each excavator searches for a big and interesting enough cluster (or excavates, if it has found such a cluster).

Now, some more details. Excavator eradicate wax, because it is superfluous or it is needed elsewhere on the construction site. They move freely over the cells, and only start removing wax when some conditions are met:
1) if the bee is on the boundary of the cluster;
2) if it faces a thick enough wall of wax (if it digs a thin wall, structures may not form);
3) if the wax wall is indeed a wall, i.e. not simply a line of wax in front of the bee;
4) if there are no unavailable (i.e. black) patches in-vision (otherwise structures like tripods may not form).

Once they have removed the wax, they are teleported away to start again.
The area where wax has been removed becomes unavailable to any bee.

Attachers secrete and attach wax, and move freely over the cells; they can only attach wax where excavators have *not* previously removed wax.

The two agent types act independently of one another, and their competiting actions are what, theoretically, makes the structures appear.

## HOW TO USE IT

In the Interface tab, we find several sliders:
- num-bees: the global number of bees (attachers + excavators);
- attacher-excavator-ratio: the fraction of attachers to excavators;
- initial-wax: the starting quantity of wax;
- excavator-sensing-distance: how far away an excavator can sense the presence of wax;
- wax-quantity-to-be-excavatable: less than this much wax may attract the excavator but not trigger the excavation;
- excavation-radius: the 'radius' of the shape (circle, semicircle, ...) of the area that the excavator can remove the wax from.

There is one chooser, as well: excavation-shape. It allows to vary the angle of the 'cone' that represents the excavation area.

The "Competition" plot shows the fraction of patches where excavators have removed wax to patches with wax: this would somehow indicate the efficiency of the formations of patterns, because it is higher when the leftover wax is thinner or better structured. The efficiency is often low, which *may* indicate that the shapes are not quite right and that the code can be improved; it can be noticed, too, that the fraction grows quite quickly in the first phase, and eventually decreases.

By adjusting these objects, we can observe slightly different behaviors of the bees and speeds of formation of black areas (and consequently, yellow structures too).

The "show-excised-areas" option is probably the most visually rewarding, but please do not expect too much from this model! :) It turns off the black zones and only displays the remaining yellow wax, hopefully revealing some structure. Please be patient as it takes some time to fill the field!

## THINGS TO NOTICE

It can be noticed that attachers (red bees) fly around randomly and wait to be on the boundary of a wax cluster, before releasing wax. On the other hand, excavators (blue bees) follow a linear trajectory, until excavation happens and their job in that area is done.

## THINGS TO TRY

Try to alternate the excavation shapes, and to follow the execution with and without visualising the black excavated areas.
(Maybe alternating the excavating shapes could help form the structures, but this is something that should be tested more accurately, in the future.)

When the field is 'sufficiently filled' with wax and excavated zones, it is nice to switch off the show-excised-areas and see a sort of yellow structure, that could represent the 2D basis for the honeycomb.

## EXTENDING THE MODEL

Several things can be added to the model:
1) having the excavators face the sensed clusters;
2) controlling the excavation in more detail;
3) having the initial wax placed in a more realistic way;
4) having the bees enter the field more realistically;
5) having the wax taken from some place to another one, as seems to be the case in nature;
5) trying a 3D extension, where the familiar hobeycomb hexagons should appear downwards in the direction of gravity (according to the mentioned paper).
6) In general, trying combination of paramenters with the possible aid of ML (e.g. could alternating the excavating shapes help the structures? From how far should bee sense the wax?).

## NETLOGO FEATURES

There are no particular features or workarounds in this model. Rather, the code is quite simple, and could be surely made more efficient. Built-in functions would probably help.

## RELATED MODELS

BeeSmart Hive Finding, Honeycomb, BeeSmart HubNet (from Models Library).

## CREDITS AND REFERENCES

I have to credit the paper https://iopscience.iop.org/article/10.1088/1742-6596/2207/1/012013/pdf, as well as the afore-mentioned NetLogo models, for ideas and inspiration.

![1](https://user-images.githubusercontent.com/50493568/226100316-b5d1a558-9caa-4a49-b105-43efcb9f9ca7.png)
![2](https://user-images.githubusercontent.com/50493568/226100325-6b2df99b-78a4-4d98-b86c-b97e4c8977b1.png)
