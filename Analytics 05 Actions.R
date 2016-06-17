# Analytics Data
# Actions!

# Number of actions per lesson

# Populating an "Actions" table that will be used throughout this file.
require(dplyr)
Actions <- Analytics
Actions <- subset(Analytics, select = -c(DateTest))


# The following objects/tables make groups of actions that will be useful in reporting actions by type and that will also help
# remove redundant actions:

AddedMoleculesOrProteins = c(
	"Added-ATP",
	"Added-ACh",
	"Added-AChE",
	"Added-AChRChannel",
	"Added-ClLeakChannel",
	"Added-GABA",
	"Added-GabaRChannel",
	"Added-GAT",
	"Added-KChannel",
	"Added-KvChannel",
	"Added-NaKATPase",
	"Added-NaLeakChannel",
	"Added-NaVChannel",
	"Added-Ouabain",
	"Added-TTX")
Actions$ActionLabel[Actions$ActionLabel %in% AddedMoleculesOrProteins] <- "Added Molecule or Protein"

AddedSchwannCell = c(
	"Added-SchwannCell1",
	"Added-SchwannCell2",
	"Added-SchwannCell3",
	"Added-SchwannCell4",
	"Added-SchwannCell5")
Actions$ActionLabel[Actions$ActionLabel %in% AddedSchwannCell] <- "Added Schwann Cell"

ChangedNernstEquation = c(
	"Nernst value changed from dropdown-Cl-",
	"Nernst value changed from dropdown-K+",
	"Nernst value changed from dropdown-Na+")
Actions$ActionLabel[Actions$ActionLabel %in% ChangedNernstEquation] <- "Changed Nernst Equation"

CheckpointDeployedDisabledEnabledOrReached = c(
	"Checkpoint deployed-Action Potential",
	"Checkpoint deployed-Excitatory PSP",
	"Checkpoint deployed-Inhibitory PSP",
	"Checkpoint deployed-Resting Potential",
	"Checkpoint disabled-action_potential",
	"Checkpoint disabled-excitatory_psp",
	"Checkpoint disabled-inhibitory_psp",
	"Checkpoint disabled-resting_potential",
	"Checkpoint enabled-action_potential",
	"Checkpoint enabled-excitatory_psp",
	"Checkpoint enabled-inhibitory_psp",
	"Checkpoint enabled-resting_potential",
	"Checkpoint reached-action_potential",
	"Checkpoint reached-excitatory_psp",
	"Checkpoint reached-inhibitory_psp",
	"Checkpoint reached-resting_potential",
	"Checkpoint disabled-Resting Potential",
	"Checkpoint enabled-Resting Potential",
	"Checkpoint reached-Resting Potential",
	"Enable checkpoint-action_potential",
	"Enable checkpoint-excitatory_psp",
	"Enable checkpoint-inhibitory_psp",
	"Disable checkpoint-action_potential",
	"Disable checkpoint-excitatory_psp",
	"Disable checkpoint-inhibitory_psp",
	"Disable checkpoint-resting_potential",
	"Enable checkpoint-resting_potential",
	"Disable checkpoint-Resting Potential")
Actions$ActionLabel[Actions$ActionLabel %in% CheckpointDeployedDisabledEnabledOrReached] <- "Checkpoint Deployed, Disabled, Enabled, or Reached"

ClickedButton = c(
	"Clicked-Button",
	"Clicked-CellsMenuButton",
	"Clicked-EquationsMenuButton",
	"Clicked-Goldman close button",
	"Clicked-Ion concentration close button",
	"Clicked-IonsMenuButton",
	"Clicked-MoleculesMenuButton",
	"Clicked-Nernst close button",
	"Clicked-ProteinsMenuButton",
	"Clicked-Remove all of this molecule",
	"Clicked-Voltage meter close button",
	"Clicked-VoltageMenuButton")
Actions$ActionLabel[Actions$ActionLabel %in% ClickedButton] <- "Clicked Button"

ClickedUnclickableThing = c(
	"Clicked-A;lecture-icon logo-icon",
	"Clicked-ACh",
	"Clicked-ACh receptor",
	"Clicked-AChE",
	"Clicked-ATP",
	"Clicked-BODY",
	"Clicked-Cl- leak channel",
	"Clicked-GABA Transporter",
	"Clicked-Goldman equation",
	"Clicked-Ion concentrations",
	"Clicked-K+ leak channel",
	"Clicked-K+ Slider",
	"Clicked-Kv channel",
	"Clicked-Message",
	"Clicked-GABA receptor",
	"Clicked-GABA",
	"Clicked-Na+ leak channel",
	"Clicked-Na+ Slider",
	"Clicked-Na+/K+ ATPase",
	"Clicked-NaV channel",
	"Clicked-Nernst equation",
	"Clicked-OtherLabel",
	"Clicked-Ouabain",
	"Clicked-PollOption",
	"Clicked-PollTitle",
	"Clicked-Schwann cell",
	"Clicked-TTX",
	"Clicked-Voltage graph",
	"Clicked-Voltage meter")
Actions$ActionLabel[Actions$ActionLabel %in% ClickedUnclickableThing] <- "Clicked Unclickable Thing"

ClosedMessageOrPoll = c(
	"Close-message",
	"Close-poll")
Actions$ActionLabel[Actions$ActionLabel %in% ClosedMessageOrPoll] <- "Closed Message or Poll"

DraggedEquationMeterConcentrationsOrGraph = c(
	"Dragged-Goldman equation",
	"Dragged-Ion concentrations",
	"Dragged-Nernst equation",
	"Dragged-Voltage graph",
	"Dragged-Voltage meter")
Actions$ActionLabel[Actions$ActionLabel %in% DraggedEquationMeterConcentrationsOrGraph] <- "Dragged Equation, Meter, Concentrations, or Graph"

DraggedMoleculeOrProtein = c(
	"Dragged-ACh",
	"Dragged-ACh receptor",
	"Dragged-AChE",
	"Dragged-ATP",
	"Dragged-Cl- leak channel",
	"Dragged-GABA",
	"Dragged-GABA receptor",
	"Dragged-GABA Transporter",
	"Dragged-K+ leak channel",
	"Dragged-Kv channel",
	"Dragged-Na+ leak channel",
	"Dragged-Na+/K+ ATPase",
	"Dragged-NaV channel",
	"Dragged-Ouabain",
	"Dragged-TTX")
Actions$ActionLabel[Actions$ActionLabel %in% DraggedMoleculeOrProtein] <- "Dragged Molecule or Protein"

Actions$ActionLabel <- ifelse(Actions$ActionLabel == "Dragged-Schwann cell", "Dragged Schwann Cell", Actions$ActionLabel)

DraggedUndraggableThing = c(
	"Dragged-EquationsMenuButton",
	"Dragged-CellsMenuButton",
	"Dragged-Goldman close button",
	"Dragged-Ion concentration close button",
	"Dragged-IonsMenuButton",
	"Dragged-MoleculesMenuButton",
	"Dragged-ProteinsMenuButton",
	"Dragged-Remove all of this molecule",
	"Dragged-Voltage meter close button",
	"Dragged-VoltageMenuButton",
	"Dragged-ZoomInButton",
	"Dragged-ZoomOutButton")
Actions$ActionLabel[Actions$ActionLabel %in% DraggedUndraggableThing] <- "Dragged Undraggable Thing"

MoveEquationMeterConcentrationsOrGraph = c(
	"Moved-Goldman equation",
	"Moved-Ion concentrations",
	"Moved-Nernst equation",
	"Moved-Voltage meter")
Actions$ActionLabel[Actions$ActionLabel %in% MoveEquationMeterConcentrationsOrGraph] <- "Moved Equation, Meter, Concentrations, or Graph"

OtherOrUnknown = c(
	"Clicked-g;[object SVGAnimatedString];",
	"Clicked-INPUT;;",
	"Clicked-rect;[object SVGAnimatedString];",
	"FromXToY-message",
	"FromXToY-Voltage graph",
	"FromXToY-poll responses",
	"message-Button",
	"message-FromXToY",
	"Open-message",
	"Open-poll",
	"poll responses-Button",
	"poll responses-FromXToY",
	"poll-Button",
	"Show-Poll responses",
	"Voltage graph-Button",
	"Voltage graph-FromXToY")
Actions$ActionLabel[Actions$ActionLabel %in% OtherOrUnknown] <- "Other or Unknown"

RemovedEquationMeterOrGraph = c(
	"Remove-Goldman equation",
	"Remove-Ion concentrations",
	"Remove-Nernst equation",
	"Remove-Voltage meter")
Actions$ActionLabel[Actions$ActionLabel %in% RemovedEquationMeterOrGraph] <- "Removed Equation, Meter, or Graph"

RemovedProteinOrMolecule = c(
	"Removed-ACh",
	"Removed-AChE",
	"Removed-AChRChannel",
	"Removed-ATP",
	"Removed-ClLeakChannel",
	"Removed-GABA",
	"Removed-GabaRChannel",
	"Removed-GAT",
	"Removed-KChannel",
	"Removed-KvChannel",
	"Removed-NaKATPase",
	"Removed-NaLeakChannel",
	"Removed-NaVChannel")
Actions$ActionLabel[Actions$ActionLabel %in% RemovedProteinOrMolecule] <- "Removed Protein or Molecule"

RemovedSchwannCell = c(
	"Removed-SchwannCell1",
	"Removed-SchwannCell2",
	"Removed-SchwannCell3",
	"Removed-SchwannCell4",
	"Removed-SchwannCell5")
Actions$ActionLabel[Actions$ActionLabel %in% RemovedSchwannCell] <- "Removed Schwann Cell"

SuccessfullyDroppedEquation = c(
	"Dropped - no zone needed-successfully dropped 1 Goldman equations",
	"Dropped - no zone needed-successfully dropped 1 Nernst equations")
Actions$ActionLabel[Actions$ActionLabel %in% SuccessfullyDroppedEquation] <- "Successfully Dropped Equation"

SuccessfullyDroppedProteinOrMolecule = c(
	"Dropped - correct zone-successfully dropped 1 ACh receptors in PostMembraneZone",
	"Dropped - correct zone-successfully dropped 1 AChEs in PostMembraneZone",
	"Dropped - correct zone-successfully dropped 1 Cl- leak channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 GABA receptors in PostMembraneZone",
	"Dropped - correct zone-successfully dropped 1 GABA Transporters in PreMembraneZone",
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in InsideZone",
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in OutsideZone",
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in PostCytoplasmZone",
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in PreCytoplasmZone",
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in SynapticCleftZone",
	"Dropped - correct zone-successfully dropped 1 K+ leak channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 Kv channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 Na+ leak channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 Na+/K+ ATPases in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 NaV channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 10 AChs in SynapticCleftZone",
	"Dropped - correct zone-successfully dropped 10 AChs in VesicleZone",
	"Dropped - correct zone-successfully dropped 10 ATPs in InsideZone",
	"Dropped - correct zone-successfully dropped 10 GABAs in SynapticCleftZone",
	"Dropped - correct zone-successfully dropped 10 GABAs in VesicleZone",
	"Dropped - correct zone-successfully dropped 10 Ouabains in OutsideZone",
	"Dropped - correct zone-successfully dropped 10 TTXs in OutsideZone")
Actions$ActionLabel[Actions$ActionLabel %in% SuccessfullyDroppedProteinOrMolecule] <- "Successfully Dropped Protein or Molecule"

SuccessfullyDroppedSchwann = c(
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell1Zone",
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell2Zone",
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell3Zone",
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell4Zone",
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell5Zone")
Actions$ActionLabel[Actions$ActionLabel %in% SuccessfullyDroppedSchwann] <- "Successfully Dropped Schwann"

SuccessfullyDroppedVoltageMeterOrGraph = c(
	"Dropped - correct zone-successfully dropped 1 Voltage meters in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 Voltage meters in PostMembraneZone",
	"Dropped - correct zone-successfully dropped 1 Voltage meters in PreMembraneZone",
	"Dropped - no zone needed-successfully dropped 1 Voltage graphs")
Actions$ActionLabel[Actions$ActionLabel %in% SuccessfullyDroppedVoltageMeterOrGraph] <- "Successfully Dropped Voltage Meter or Graph"

UnsuccessfullyDroppedConcentrationsOrMeter = c(
	"Not dropped - no zone-tried to drop Ion concentrations in no zone",
	"Not dropped - no zone-tried to drop Voltage meter in no zone",
	"Not dropped - wrong zone-tried to drop Voltage meter in InsideZone",
	"Not dropped - wrong zone-tried to drop Voltage meter in OutsideZone",
	"Not dropped - wrong zone-tried to drop Voltage meter in PreCytoplasmZone")
Actions$ActionLabel[Actions$ActionLabel %in% UnsuccessfullyDroppedConcentrationsOrMeter] <- "Unsuccessfully Dropped Concentrations or Meter"

UnsuccessfullyDroppedProteinOrMolecule = c(
	"Not dropped - no zone-tried to drop ACh in no zone",
	"Not dropped - no zone-tried to drop ACh receptor in no zone",
	"Not dropped - no zone-tried to drop AChE in no zone",
	"Not dropped - no zone-tried to drop ATP in no zone",
	"Not dropped - no zone-tried to drop Cl- leak channel in no zone",
	"Not dropped - no zone-tried to drop GABA in no zone",
	"Not dropped - no zone-tried to drop GABA receptor in no zone",
	"Not dropped - no zone-tried to drop GABA Transporter in no zone",
	"Not dropped - no zone-tried to drop K+ leak channel in no zone",
	"Not dropped - no zone-tried to drop Kv channel in no zone",
	"Not dropped - no zone-tried to drop Na+ leak channel in no zone",
	"Not dropped - no zone-tried to drop Na+/K+ ATPase in no zone",
	"Not dropped - no zone-tried to drop NaV channel in no zone",
	"Not dropped - no zone-tried to drop Ouabain in no zone",
	"Not dropped - no zone-tried to drop TTX in no zone",
	"Not dropped - wrong zone-tried to drop ACh in PostCytoplasmZone",
	"Not dropped - wrong zone-tried to drop ACh in PostMembraneZone",
	"Not dropped - wrong zone-tried to drop ACh in PreCytoplasmZone",
	"Not dropped - wrong zone-tried to drop ACh in PreMembraneZone",
	"Not dropped - wrong zone-tried to drop ACh receptor in PostCytoplasmZone",
	"Not dropped - wrong zone-tried to drop ACh receptor in PreCytoplasmZone",
	"Not dropped - wrong zone-tried to drop ACh receptor in PreMembraneZone",
	"Not dropped - wrong zone-tried to drop ACh receptor in SynapticCleftZone",
	"Not dropped - wrong zone-tried to drop ACh receptor in VesicleZone",
	"Not dropped - wrong zone-tried to drop AChE in PostCytoplasmZone",
	"Not dropped - wrong zone-tried to drop AChE in PreCytoplasmZone",
	"Not dropped - wrong zone-tried to drop AChE in PreMembraneZone",
	"Not dropped - wrong zone-tried to drop AChE in SynapticCleftZone",
	"Not dropped - wrong zone-tried to drop AChE in VesicleZone",
	"Not dropped - wrong zone-tried to drop ATP in MembraneZone",
	"Not dropped - wrong zone-tried to drop ATP in OutsideZone",
	"Not dropped - wrong zone-tried to drop Cl- leak channel in InsideZone",
	"Not dropped - wrong zone-tried to drop Cl- leak channel in OutsideZone",
	"Not dropped - wrong zone-tried to drop GABA in PostMembraneZone",
	"Not dropped - wrong zone-tried to drop GABA in PreCytoplasmZone",
	"Not dropped - wrong zone-tried to drop GABA in PreMembraneZone",
	"Not dropped - wrong zone-tried to drop GABA receptor in PostCytoplasmZone",
	"Not dropped - wrong zone-tried to drop GABA receptor in PreCytoplasmZone",
	"Not dropped - wrong zone-tried to drop GABA receptor in PreMembraneZone",
	"Not dropped - wrong zone-tried to drop GABA receptor in SynapticCleftZone",
	"Not dropped - wrong zone-tried to drop GABA Transporter in PostCytoplasmZone",
	"Not dropped - wrong zone-tried to drop GABA Transporter in PostMembraneZone",
	"Not dropped - wrong zone-tried to drop GABA Transporter in PreCytoplasmZone",
	"Not dropped - wrong zone-tried to drop GABA Transporter in SynapticCleftZone",
	"Not dropped - wrong zone-tried to drop Ion concentrations in MembraneZone",
	"Not dropped - wrong zone-tried to drop Ion concentrations in PreMembraneZone",
	"Not dropped - wrong zone-tried to drop K+ leak channel in InsideZone",
	"Not dropped - wrong zone-tried to drop K+ leak channel in OutsideZone",
	"Not dropped - wrong zone-tried to drop Kv channel in InsideZone",
	"Not dropped - wrong zone-tried to drop Kv channel in OutsideZone",
	"Not dropped - wrong zone-tried to drop Na+ leak channel in InsideZone",
	"Not dropped - wrong zone-tried to drop Na+ leak channel in OutsideZone",
	"Not dropped - wrong zone-tried to drop Na+/K+ ATPase in InsideZone",
	"Not dropped - wrong zone-tried to drop Na+/K+ ATPase in OutsideZone",
	"Not dropped - wrong zone-tried to drop NaV channel in InsideZone",
	"Not dropped - wrong zone-tried to drop NaV channel in OutsideZone",
	"Not dropped - wrong zone-tried to drop Ouabain in InsideZone",
	"Not dropped - wrong zone-tried to drop Ouabain in MembraneZone",
	"Not dropped - wrong zone-tried to drop TTX in InsideZone",
	"Not dropped - wrong zone-tried to drop TTX in MembraneZone")
Actions$ActionLabel[Actions$ActionLabel %in% UnsuccessfullyDroppedProteinOrMolecule] <- "Unsuccessfully Dropped Protein or Molecule"

Actions$ActionLabel <- ifelse(
	Actions$ActionLabel==
	"Not dropped - no zone-tried to drop Schwann cell in no zone",
	"Unsuccessfully Dropped Schwann Cell",
	Actions$ActionLabel)

remove(UsedConcentrationSlider)
UsedConcentrationSlider = c(
	"Dragged-K+ Slider",
	"Dragged-Na+ Slider")
Actions$ActionLabel[Actions$ActionLabel %in% UsedConcentrationSlider] <- "Used Concentration Slider"

ZoomedPannedOrResized = c(
	"Clicked-ZoomInButton",
	"Clicked-ZoomOutButton",
	"Panning-Hillock Camera",
	"Panning-NeuronCamera",
	"Panning-SynapticCleftCamera",
	"Resized-OtherLabel",
	"Screen(size)-window:undefinedxundefined",
	"Zooming in-NeuronCamera to Hillock Camera",
	"Zooming in-NeuronCamera to SynapticCleftCamera",
	"Zooming out-Hillock Camera to NeuronCamera",
	"Zooming out-SynapticCleftCamera to NeuronCamera")
Actions$ActionLabel[Actions$ActionLabel %in% ZoomedPannedOrResized] <- "Zoomed, Panned, or Resized"

# Simplifying all of these rolled-on, rolled-off fields.
Actions$ActionLabel[grep("Turning on-", Actions$ActionLabel)] <- "Turning on"
Actions$ActionLabel[grep("Turning off-", Actions$ActionLabel)] <- "Turning off"



# Filtering out redundant actions: “Added Molecule or Protein,” “Added Schwann Cell,” “Dragged Molecule or Protein,” “Dragged Schwann Cell.”
# (Redundant to following command if that’s used, but useful for reducing confusion)

Actions[
Actions$ActionLabel == "Added Molecule or Protein" |
Actions$ActionLabel == "Dragged Molecule or Protein" |
Actions$ActionLabel == "Added Schwann Cell" |
Actions$ActionLabel == "Dragged Schwann Cell" ,] <- NA

# This part excludes those rows that now have NA in ActionLabel (because the rows were redundant):
Actions <- Actions[!(is.na(Actions$ActionLabel)),]


table(Actions$ActionLabel)


require(plyr)
ActionsSummary <- ddply(Actions, c("UserIDMaybe", "Lesson"), summarise, N = length(Action))


# This part produces a start ratio (ratio of start actions to other actions) that can help identify problems with the app that result in more
# “start” actions than other actions.
require(plyr)
ActionsStartRatio <- ddply(Actions, c("Lesson"), summarise, N = length(ActionLabel), NStart = length(ActionFix[ActionFix == "Start"]))

ActionsStartRatio$StartRatio <- ifelse(ActionsStartRatio$NStart >= 1, ActionsStartRatio$N / ActionsStartRatio$NStart, "NA")


# This part produces a ActionsLessonSummary table that can be used to make graphics about what actions were done in what numbers by lesson.
require(plyr)
ActionsLessonSummary <- ddply(Actions, c("Lesson", "ActionLabel"), summarise, N = length(Action))


########## Cleaning up intermediate objects (tables):############
	remove(AddedMoleculesOrProteins)
	remove(AddedSchwannCell)
	remove(ChangedNernstEquation)
	remove(CheckpointDeployedDisabledEnabledOrReached)
	remove(ClickedButton)
	remove(ClickedUnclickableThing)
	remove(ClosedMessageOrPoll)
	remove(DraggedEquationMeterConcentrationsOrGraph)
	remove(DraggedMoleculeOrProtein)
	remove(DraggedUndraggableThing)
	remove(MoveEquationMeterConcentrationsOrGraph)
	remove(OtherOrUnknown)
	remove(RemovedEquationMeterOrGraph)
	remove(RemovedProteinOrMolecule)
	remove(RemovedSchwannCell)
	remove(SuccessfullyDroppedEquation)
	remove(SuccessfullyDroppedProteinOrMolecule)
	remove(SuccessfullyDroppedSchwann)
	remove(SuccessfullyDroppedVoltageMeterOrGraph)
	remove(UnsuccessfullyDroppedConcentrationsOrMeter)
	remove(UnsuccessfullyDroppedProteinOrMolecule)
	remove(UsedConcentrationSlider)
	remove(ZoomedPannedOrResized)


# Note that “Start” actions are counted as actions. The dashboarding should accommodate that?


# Scientific exploration requires having a meter present while something is changed. This first part is seeing if a meter is present by normal
# means. “Normal” refers to the addition of the meter being recorded explicitly in logs. Later, “secret” refers to meters that were detected
# despite their addition not explicitly being logged. Stuff special to voltage graphs is in orange. Voltage graphs are special: 1) they stay
# present when user navigates from environment, and 2) they are only added once when analytics show they’re added multiple times.

# This creates a unique “Instance” for every UserIDMaybe-Environment-Lesson combination. This is because when a component (not including voltage
# graphs) is added in one Instance, it’s not there in another.
Actions$Instance <- paste(Actions$UserIDMaybe, Actions$Lesson, Actions$Environment, sep = "-")

# This creates a unique “UserLessonInstance” for every UserIDMaybe-Lesson combination. This is because when a voltage graph is added in one
# UserLessonInstance, it’s not there in another.
Actions$UserLessonInstance <- paste(Actions$UserIDMaybe, Actions$Lesson, sep = "-")

# Sorting! (so that each Instance’s records are in a group with older records on the bottom)
Actions <- Actions[with(Actions, order(Instance, Date)), ]

# New RawActionLabel to help identify criteria for potential scientific exploration
Actions$RawActionLabel <- paste(Actions$ActionFix, Actions$LabelFix, sep = "-")
# unique(Actions$RawActionLabel)

# New UILabel (volt graphs are different from other meters in the way they are recorded as having been moved,
# hence using different raw variables and criteria) to help identify volt graph criterion for potential scientific exploration
Actions$RawUILabel <- 0
Actions$RawUILabel[
	Actions$UIThing == "UIClose" &
	Actions$ActionFix == "Voltage graph"
] <-
paste(Actions$UIThing[
	Actions$UIThing == "UIClose" &
	Actions$ActionFix == "Voltage graph"
],
Actions$ActionFix[
	Actions$UIThing == "UIClose" &
	Actions$ActionFix == "Voltage graph"
], sep = "-")

# table(Actions$RawUILabel)

Actions$NormalMeterAdded <- 0
Actions$NormalVoltGraphAdded <- 0

# Selecting those ActionLabel combinations that indicate addition of an approved meter.
# Note that the typo in “concentrationss” is correct.

remove(AddedMeters)
AddedMeters = c(
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in InsideZone",
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in OutsideZone",
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in PostCytoplasmZone",
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in PreCytoplasmZone",
	"Dropped - correct zone-successfully dropped 1 Ion concentrationss in SynapticCleftZone",
	"Dropped - correct zone-successfully dropped 1 Voltage meters in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 Voltage meters in PostMembraneZone",
	"Dropped - correct zone-successfully dropped 1 Voltage meters in PreMembraneZone",
	"Dropped - no zone needed-successfully dropped 1 Goldman equations",
	"Dropped - no zone needed-successfully dropped 1 Nernst equations")
Actions$NormalMeterAdded[Actions$RawActionLabel %in% AddedMeters] <- 1

# Above had previously included "Added-Goldman equation", "Added-Ion concentrations", "Added-Nernst equation", "Added-Voltage meter",
# but those are duplicates)

remove(AddedVoltGraph)
AddedVoltGraph = c(
	"Dropped - no zone needed-successfully dropped 1 Voltage graphs")
Actions$NormalVoltGraphAdded[Actions$RawActionLabel %in% AddedVoltGraph] <- 1


# Check these tables to verify that all of the patterns looked for are correct:
# table(Actions$RawActionLabel[Actions$NormalMeterAdded == 1])
# table(Actions$RawActionLabel[Actions$NormalVoltGraphAdded == 1])

remove(RemovedMeters)
RemovedMeters = c(
	"Remove-Goldman equation",
	"Remove-Ion concentrations",
	"Remove-Nernst equation",
	"Remove-Voltage meter")
Actions$NormalMeterAdded[Actions$RawActionLabel %in% RemovedMeters] <- -1

remove(RemovedVoltGraph)
RemovedVoltGraph = c(
	"UIClose-Voltage graph")
Actions$NormalVoltGraphAdded[Actions$RawUILabel %in% RemovedVoltGraph] <- -1

# Check this table to verify that all of the patterns looked for are correct:
	# table(Actions$RawActionLabel[Actions$NormalMeterAdded == -1])
	# table(Actions$RawUILabel[Actions$NormalVoltGraphAdded == -1])

# This table should show distinct categorization (no duplication between coding schemes)
	# table(Actions$RawUILabel[Actions$NormalVoltGraphAdded == -1 | Actions$NormalMeterAdded == -1],
	# Actions$RawActionLabel[Actions$NormalVoltGraphAdded == -1 | Actions$NormalMeterAdded == -1])


# This is where the NormalMeterPresent values are created. Uses previous row stuff.
Actions <- within(Actions, {NormalMeterPresent <- ave(NormalMeterAdded, Instance, FUN = cumsum) })
# Fixing instances where a negative number of meters were present:
Actions$NormalMeterPresent[Actions$NormalMeterPresent < 0] <- 0
Actions$NormalMeterPresent[is.na(Actions$NormalMeterPresent)] <- 0

# This is where the NormalVoltGraphPresent values are created. Uses previous row stuff.
Actions <- within(Actions, {NormalVoltGraphPresent <- ave(NormalVoltGraphAdded, UserLessonInstance, FUN = cumsum) })
# Fixing instances where a negative number of meters were present:
Actions$NormalVoltGraphPresent[Actions$NormalVoltGraphPresent < 0] <- 0
Actions$NormalVoltGraphPresent[is.na(Actions$NormalVoltGraphPresent)] <- 0


# Fixing instances where more than the 10 (UPDATE!) possible number of (non-volt graph) meters were present (I don’t know why, but one user had
# 12 meters present at one point - may have been because volt graph removal wasn’t picked up):
Actions$NormalMeterPresent[Actions$NormalMeterPresent > 10] <- 10

# summary(Actions$NormalMeterPresent)



# Now to reduce error in the scientific exploration work by identifying secret meters that were apparently added without notice by “normal” meter
#stuff above.

# Code to reduce error - something like “ifelse([Graph Clicked),max(MeterPresent, 1),MeterPresent”

# The values in EvidenceOfMeters were updated 1/2/16 by reviewing Action-Label combinations from the Y1RFS analytics data that had been pasted into
# “Picking Scientific Actions” XLSX file.

# Confirmed in June 2016 that the following do not belong in this list: "Dragged-Goldman equation", "Dragged-Ion concentrations",
# "Dragged-Nernst equation", "Dragged-Voltage graph", "Dragged-Voltage meter".


Actions$NewEvidenceOfMeter <- 0



# "Clicked-Ion concentrations" is not included because it can be clicked on and not dropped because the menu icon is over an area that doesn’t
# let the meter stay there. Code looks for successfully dropped or something instead.

# "Clicked-Voltage meter" is not included because it can be clicked on and not dropped because the menu icon is over an area that doesn’t let
# the meter stay there. Code looks for successfully dropped or something instead.

# "Clicked-Goldman equation" and "Clicked-Nernst equation" are both somewhat dubiously included because they can be dropped anywhere.

# “Raw” ActionLabel is used here because ActionLabel has simplified “turning on” and “turning off” values in Actions.

remove(EvidenceOfSecretMeters)
EvidenceOfSecretMeters = c(
	"Clicked-Goldman equation",
	"Clicked-Nernst equation",
	"Dragged-Goldman close button",
	"Dragged-Ion concentration close button",
	"Dragged-K+ Slider",
	"Dragged-Na+ Slider",
	"Dragged-Voltage meter close button",
	"Nernst value changed from dropdown-Cl-",
	"Nernst value changed from dropdown-K+",
	"Nernst value changed from dropdown-Na+",
	"Turning off-AbsoluteTemperature",
	"Turning off-ClNernst",
	"Turning off-ClPermeability",
	"Turning off-FaradayConstant",
	"Turning off-GasConstant",
	"Turning off-InnerConcentration",
	"Turning off-IonCharge",
	"Turning off-KNernst",
	"Turning off-KPermeability",
	"Turning off-NaNernst",
	"Turning off-NaPermeability",
	"Turning off-OuterConcentration",
	"Turning off-TotalPermeability",
	"Turning off-Voltage",
	"Turning on-AbsoluteTemperature",
	"Turning on-ClNernst",
	"Turning on-ClPermeability",
	"Turning on-FaradayConstant",
	"Turning on-GabaRChannel CloseMenu",
	"Turning on-GasConstant",
	"Turning on-InnerConcentration",
	"Turning on-IonCharge",
	"Turning on-KNernst",
	"Turning on-KPermeability",
	"Turning on-NaNernst",
	"Turning on-NaPermeability",
	"Turning on-OuterConcentration",
	"Turning on-TotalPermeability",
	"Turning on-Voltage")
Actions$NewEvidenceOfMeter[(Actions$RawActionLabel %in% EvidenceOfSecretMeters) & Actions$NormalMeterPresent == 0] <- 1

remove(EvidenceOfSecretVoltGraphs)
EvidenceOfSecretVoltGraphs = c(
	"Clicked-Voltage graph",
	"FromXToY-Voltage graph",
	"Clicked Voltage Line")
Actions$NewEvidenceOfVoltGraph[(Actions$RawActionLabel %in% EvidenceOfSecretVoltGraphs) & Actions$NormalVoltGraphPresent == 0] <- 1

Actions$NewEvidenceOfVoltGraph[(Actions$LabelFix %in% EvidenceOfSecretVoltGraphs) & Actions$NormalVoltGraphPresent == 0] <- 1



# Making sure that the new var doesn’t continue to be 1 even when a meter is removed.
Actions$NewEvidenceOfMeter[Actions$NormalMeterAdded == -1] <- -1
Actions$NewEvidenceOfVoltGraph[Actions$NormalVoltGraphAdded == -1] <- -1

# SecretMeterDetected will become 0 (where a meter has been removed), 1 (where a meter has been detected), or NA
Actions$SecretMeterDetected <- NA
Actions$SecretVoltGraphDetected <- NA

Actions$SecretMeterDetected[Actions$NormalMeterAdded == -1] <- 0
Actions$SecretMeterDetected[Actions$NewEvidenceOfMeter == 1] <- 1
Actions$SecretMeterDetected <- as.integer(Actions$SecretMeterDetected)
Actions$SecretVoltGraphDetected[Actions$NormalVoltGraphAdded == -1] <- 0
Actions$SecretVoltGraphDetected[Actions$NewEvidenceOfVoltGraph == 1] <- 1
Actions$SecretVoltGraphDetected <- as.integer(Actions$SecretVoltGraphDetected)


Actions$SumOfSecretMeterStillPresent <- 0
Actions$SumOfSecretVoltGraphStillPresent <- 0
# This fills down with values.
Actions$SumOfSecretMeterStillPresent <- unlist(lapply(split(Actions$SecretMeterDetected,Actions$Instance), function(x) na.locf(x, na.rm = FALSE)))
Actions$SumOfSecretMeterStillPresent[is.na(Actions$SumOfSecretMeterStillPresent)] <- 0

Actions$SumOfSecretVoltGraphStillPresent <-
unlist(lapply(split(Actions$SecretVoltGraphDetected,Actions$UserLessonInstance), function(x) na.locf(x, na.rm = FALSE)))
Actions$SumOfSecretVoltGraphStillPresent[is.na(Actions$SumOfSecretVoltGraphStillPresent)] <- 0


# Check at (Y1RFS) row 770

# This gets a running sum of filled down values:
Actions <- within(Actions, {SumOfSecretMeterStillPresent <- ave(SumOfSecretMeterStillPresent, Instance, FUN = cumsum) })
Actions <- within(Actions, {SumOfSecretVoltGraphStillPresent <- ave(SumOfSecretVoltGraphStillPresent, UserLessonInstance, FUN = cumsum) })

# This counts the first occurrence during an Instance where a meter was detected when it was not explicitly added.
Actions$MetersAdded2[Actions$NormalMeterPresent == 0 & Actions$SumOfSecretMeterStillPresent == 1] <- 1
Actions$VoltGraphsAdded2[Actions$NormalVoltGraphPresent == 0 & Actions$SumOfSecretVoltGraphStillPresent == 1] <- 1

# Now MetersAdded2 = 1 whenever we should be counting a secret meter or a secret volt graph.
# Now VoltGraphsAdded2 = 1 whenever we should be counting a secret volt graph.


Actions$MeterReallyPresent <- pmax(Actions$MetersAdded2, Actions$NormalMeterAdded, na.rm = TRUE)
Actions$VoltGraphReallyPresent <- pmax(Actions$VoltGraphsAdded2, Actions$NormalVoltGraphAdded, na.rm = TRUE)

# This is where the NormalMeterPresent values are created. Uses previous row stuff.
Actions <- within(Actions, {AnyMeterPresent <- ave(MeterReallyPresent, Instance, FUN = cumsum)})
Actions <- within(Actions, {AnyVoltGraphPresent <- ave(VoltGraphReallyPresent, UserLessonInstance, FUN = cumsum)})

Actions$AnyMeterPresent[Actions$AnyMeterPresent < 0] <- 0
Actions$AnyVoltGraphPresent[Actions$AnyVoltGraphPresent < 0] <- 0

# Fixing instances where more than the 10 (UPDATE!)  possible number of meters were present (I don’t know why, but one user had 14 meters present at
# one point):
Actions$AnyMeterPresent[Actions$AnyMeterPresent > 10] <- 10

# Fixing instances where more than the 1 (UPDATE!)  possible number of volt graphs were present (not a problem):
Actions$AnyVoltGraphPresent[Actions$AnyVoltGraphPresent > 1] <- 1
#Actions$NormalVoltGraphPresent[Actions$NormalVoltGraphPresent>1] <- 1

# So normal meters have been counted in their own way and volt graphs were counted in another way. This function simply adds the two together for
# each row (doesn’t need anything additional built in about where each are cleared).
# Conditionality ([square brackets]) is to avoid allowing a voltage graph to be added after it has been secret added (can’t have two at once):
Actions$AnyMeterPresent2[Actions$SumOfSecretVoltGraphStillPresent <= 1] <- Actions$NormalVoltGraphPresent[Actions$SumOfSecretVoltGraphStillPresent <= 1] + Actions$AnyMeterPresent[Actions$SumOfSecretVoltGraphStillPresent <= 1]


# Actions$AnyMeterPresent2 <- Actions$AnyMeterPresent + Actions$AnyVoltGraphPresent
Actions$AnyMeterPresent2 <- pmax(Actions$AnyMeterPresent2, Actions$SecretVoltGraphDetected, na.rm = TRUE)


# So Normal meters have been counted in their own way and volt graphs were counted in another way. This function simply adds the two together for
# each row (doesn’t need anything additional built in about where each are cleared).

# Actions$AnyMeterPresent2 <- Actions$NormalVoltGraphPresent + Actions$AnyMeterPresent

# 8987, 4087

# Does it work?
	#table(Actions$NormalMeterPresent,Actions$AnyMeterPresent)
	#table(Actions$AnyMeterPresent)
	#write.csv(Actions, file = "Foo2.csv")

# Maybe out-of-date test case areas from Y1R1F: 2780, 770



# Scientific exploration requires having a meter present while something is changed. This second part is seeing if anything was changed.


# Identifying Action-Label combinations that indicate changing the environment in a way that would potentially change what is seen
# on the accepted meters.
remove(ChangedVariables)
ChangedVariables = c(
	"Dropped - correct zone-successfully dropped 1 ACh receptors in PostMembraneZone",
	"Dropped - correct zone-successfully dropped 1 AChEs in PostMembraneZone",
	"Dropped - correct zone-successfully dropped 10 AChs in SynapticCleftZone",
	"Dropped - correct zone-successfully dropped 10 AChs in VesicleZone",
	"Dropped - correct zone-successfully dropped 10 ATPs in InsideZone",
	"Dropped - correct zone-successfully dropped 1 Cl- leak channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 GABA receptors in PostMembraneZone",
	"Dropped - correct zone-successfully dropped 1 GABA Transporters in PreMembraneZone",
	"Dropped - correct zone-successfully dropped 10 GABAs in SynapticCleftZone",
	"Dropped - correct zone-successfully dropped 10 GABAs in VesicleZone",
	"Dropped - correct zone-successfully dropped 1 K+ leak channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 Kv channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 Na+ leak channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 Na+/K+ ATPases in MembraneZone",
	"Dropped - correct zone-successfully dropped 1 NaV channels in MembraneZone",
	"Dropped - correct zone-successfully dropped 10 Ouabains in OutsideZone",
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell1Zone",
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell2Zone",
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell3Zone",
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell4Zone",
	"Dropped - correct zone-successfully dropped 1 Schwann cells in SchwannCell5Zone",
	"Dropped - correct zone-successfully dropped 10 TTXs in OutsideZone",
	"Clicked-K+ Slider",
	"Dragged-K+ Slider",
	"Clicked-Na+ Slider",
	"Dragged-Na+ Slider",
	"Clicked-Remove all of this molecule",
	"Removed-SchwannCell1",
	"Removed-SchwannCell2",
	"Removed-SchwannCell3",
	"Removed-SchwannCell4",
	"Removed-SchwannCell5")
Actions$ChangedVariables[Actions$RawActionLabel %in% ChangedVariables] <- 1

# Check this table to verify that all of the patterns looked for are correct (can compare to list of all RawActionLabels for complete inventory
# - is what was done after Y1RFS - see “Picking Scientific Actions” Excel file):
	#table(Actions$RawActionLabel[Actions$ChangedVariables == 1])



# This is the bit that determines whether potential experimentation was taking place:
Actions$PotentialExperimentation <- 0
Actions$PotentialExperimentation <- ifelse((Actions$ChangedVariables * Actions$AnyMeterPresent) > 0, 1, 0)

# For diagnostics:
#table(Actions$PotentialExperimentation, Actions$Lesson)

Note <- "Note that the error correction may be non-random, resulting in non-random bias in results."
Note


#Removing intermediate tables and objects:
	remove(Note)

	remove(AddedMeters)
	remove(RemovedMeters)
	remove(RemovedMeters)
	remove(EvidenceOfMeters)

	remove(ChangedVariables)


#Cleaning up variables that aren’t needed now:
Actions <-  subset(Actions, select = -c(
	RawUILabel,
	NormalMeterAdded,
	NormalVoltGraphAdded,
	NormalMeterPresent,
	NormalVoltGraphPresent,
	NewEvidenceOfMeter,
	NewEvidenceOfVoltGraph,
	SecretMeterDetected,
	SecretVoltGraphDetected,
	SumOfSecretMeterStillPresent,
	SumOfSecretVoltGraphStillPresent,
	MetersAdded2,
	VoltGraphsAdded2,
	MeterReallyPresent,
	VoltGraphReallyPresent,
	AnyMeterPresent,
	AnyVoltGraphPresent))


# Making tables of results:
require(plyr)
ScientificExperimentationByStudentLecture <- ddply(Actions, c("UserIDMaybe", "Lesson"), summarise, N = max(!is.na(PotentialExperimentation)))

require(plyr)
ScientificExperimentationByStudentEnvironment <- ddply(Actions, c("UserIDMaybe", "Environment"), summarise, N = max(!is.na(PotentialExperimentation)))

require(plyr)
ScientificExperimentationByEnvironment <- ddply(Actions, c("Environment"), summarise, N = sum(!is.na(PotentialExperimentation)))

require(plyr)
ScientificExperimentationByLecture <- ddply(Actions, c("Lesson"), summarise, N = sum(!is.na(PotentialExperimentation)))





# Producing info for filtering in other analyses...
ActionsFilters <- ddply(Actions, c("UserIDMaybe", "Lesson", "Environment"), summarise, Actions = length(UserIDMaybe))
ActionsFilters$UserLessonEnvironment <- paste(ActionsFilters$UserIDMaybe, ActionsFilters$Lesson, ActionsFilters$Environment, sep = "-")
# Actions$UserLessonEnvironment <- paste(Actions$UserIDMaybe, Actions$Lesson, Actions$Environment, sep = "-")


# Diagnostics/summary
# table(Actions$AnyMeterPresent2)
# table(Actions$ChangedVariables)
# table(Actions$AnyMeterPresent2, Actions$ChangedVariables)
# table(Actions$PotentialExperimentation)
# table(Actions$UserIDMaybe, Actions$PotentialExperimentation)



