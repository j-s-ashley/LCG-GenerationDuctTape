#!/bin/bash

# --- Header --- #
nevents=$1

mass_start=$2
mass_end=$3
mass_increment=$4
mass=$mass_start

# This section is mostly a placeholder. Decay range coming soon.
decay_start=$5
decay_end=$6
decay_increment=$7
decay=$decay_start

model_dir=$8
proc_card_name=$9

run_dir='smu'$mass'gev'$decay'ns'
# --- End of Header --- #

touch $proc_card_name
echo import model $model_dir > $proc_card_name
echo define q = g u c d s u~ c~ d~ s~ b t b~ t~ h01 h2 h3 h+ h- >> $proc_card_name
echo define p = g u c d s u~ c~ d~ s~ b b~ >> $proc_card_name
echo 'generate p p > mur- mur+ /q' >> $proc_card_name
echo output auto >> $proc_card_name
echo launch -n $dir_name >> $proc_card_name
echo ./param_card_default.dat >> $proc_card_name
echo set nevents $nevents >> $proc_card_name
echo set time_of_flight 0.0 >> $proc_card_name
echo set small_width_treatment 1e-30 >> $proc_card_name
echo set mass 1000013 $mass >> $proc_card_name
echo set mass 2000013 $mass >> $proc_card_name
echo set decay 2000013 6.500000e-15 >> $proc_card_name

#TODO Add decay range functionality
for ((mass=$mass_start+100;mass<=mass_end;mass=$mass+100)); do
	run_dir='smu'$mass'gev'$decay'ns'
	echo launch -n $dir_name >> $proc_card_name
	echo set mass 1000013 $mass >> $proc_card_name
	echo set mass 2000013 $mass >> $proc_card_name
	echo set decay 2000013 6.500000e-15 >> $proc_card_name
done

echo done >> $proc_card_name
