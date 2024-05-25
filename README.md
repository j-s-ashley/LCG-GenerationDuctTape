# Generation via MadGraph and Pythia using LCG

This repo currently contains an exact replica of the files located in the [data generation directory of the LLP_Sleptons_RPV_SUSY repository](https://github.com/A-A-Abdelhamid/LLP_Sleptons_RPV_SUSY/blob/secondary/generate_events/). Eventually, it will be updated to be more suitable to generic applications. For now, this works, which is better than the twiki can give you.

(Also, all the links below go to that repo. Those will be changed in the pull request, promise.)

## Instantiation

1. Connect to LXPlus.

2. Run the input card generation script.

`python3 make_input.py`

3. Set the EOS destination for your generated data by changing the output_dir variable at the bottom of the header in [generate.sh](submission/generate.sh) (located in the submission subdirectory).

4. Copy the contents of the submission subdirectory to somewhere in your AFS directory.

5. *Optionally*, you can uncomment lines 10 and 11 of [submit.sub](submission/submit.sub) (located in the submission subdirectory) and change the value of notify_user to your email address to get an email when HTCondor updates the status of your job(s). Note that you will receive 1 email per *job*, so if you are generating samples for 5 lifetimes and 5 masses, you will receive 25 emails.

6. Submit to Condor. (See [Batch Generation](https://github.com/j-s-ashley/LCG-GenerationDuctTape?tab=readme-ov-file#batch-generation) below.)
## Customization

This repo is set up to process basic generation parameters in the header of the [generate.sh](submission/generate.sh) file (located in the submission subdirectory). There, you will find variables for:

- the number of events per run
- a BSM model repository and the path to the model itself
- mass and lifetime range parameters (set by the .txt file generated by make_input.py)
- naming patterns for generated directories

There are two secondary customization files:

- [param_card_default.dat](submission/param_card_default.dat)
- [main42.cmnd](submission/main42.cmnd)

### param_card_default.dat

This is the MadGraph input template file, in which you can customize the basic components of your your process.

Parameters that can **remain static** through the entirety of your process can be altered here. The proc_card generated by [generate.sh](submission/generate.sh) replaces MadGraph's default card with this one, then sets individual parameters as described in lines 50-66 of [generate.sh](submission/generate.sh#L50).

### main42.cmnd

This is the Pythia command file, used for customizing how Pythia hadronizes the data from MadGraph.

**Important note**:
If you want to use a particular PDF set, this should be specified in line 30 by changing the value of `PDF:pSet`. Please also note that this installation of Pythia is not compatible with LHAPDF5. Only LHAPDF6 is enabled.

## Batch Generation

To generate data, navigate to the directory in AFS where you copied the contents of the submission subdirectory and submit the job description file [submit.sub](submission/submit.sub) to HTCondor.

`condor_submit submit.sub`

You can check the status of your job(s) with

`condor_q` or `condor_q -nobatch`

See the [HTCondor Manual](https://htcondor.readthedocs.io/en/latest/users-manual/managing-a-job.html) for more information.
