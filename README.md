# Generation via MadGraph and Pythia using LCG

This process is currently under parallel development in the [secondary branch of the LLP_Sleptons_RPV_SUSY repo](https://github.com/A-A-Abdelhamid/LLP_Sleptons_RPV_SUSY/blob/secondary/) and is still in its alpha testing stage.

## Instantiation

1. Connect to LXPlus.

2. Run the setup script.

`bash repo_setup.sh`

## Customization

There are two primary customization files: 

- [proc_card.dat](https://github.com/j-s-ashley/LCG-GenerationDuctTape/blob/main/proc_card.dat)
- [main42.cmnd](https://github.com/j-s-ashley/LCG-GenerationDuctTape/blob/main/main42.cmnd)

### proc_card.dat

This is the MadGraph input file, in which you can customize the basic components of your your process.

Some potentially helpful tips:

- This file can be used to loop over a range of masses and lifetimes. (Instructions to be updated soon.)

- If you can't find the right `set` command for a parameter that can remain static through the entirety of your process, just alter [param_card_default.dat](https://github.com/j-s-ashley/LCG-GenerationDuctTape/blob/main/param_card_default.dat). The proc_card included in this repo replaces MadGraph's default card with this one.

### main42.cmnd

This is the Pythia command file, used for customizing how Pythia hadronizes the data from MadGraph.

**Important note**: If you change the number of events in [proc_card.dat](https://github.com/j-s-ashley/LCG-GenerationDuctTape/blob/main/proc_card.dat), you **must** change the value of `Main:numberOfEvents` in section 1) of [main42.cmnd](https://github.com/j-s-ashley/LCG-GenerationDuctTape/blob/main/main42.cmnd) to the same number if you want Pythia to shower all of your events.

If you want to use a particular PDF set, this should be specified in line 30 by changing the value of `PDF:pSet`. Please also note that this installation of Pythia is not compatible with LHAPDF5. Only LHAPDF6 is enabled.

(As of 2024-04-30, this file does not iterate over multiple .lhe files. An update will follow soon to fix this.)

## Generation

This part is generally tedious, so I threw it into the script [generate.sh](https://github.com/j-s-ashley/LCG-GenerationDuctTape/blob/main/generate.sh). 
