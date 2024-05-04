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
card_name=$9

run_dir='smu'$mass'gev'$decay'ns'
# --- End of Header --- #

touch $card_name
echo import model $model_dir > $card_name
echo define q = g u c d s u~ c~ d~ s~ b t b~ t~ h01 h2 h3 h+ h- >> $card_name
echo define p = g u c d s u~ c~ d~ s~ b b~ >> $card_name
echo 'generate p p > mur- mur+ /q' >> $card_name
echo output auto >> $card_name
echo launch -n $dir_name >> $card_name
echo ./param_card_default.dat >> $card_name
echo set nevents $nevents >> $card_name
echo set time_of_flight 0.0 >> $card_name
echo set small_width_treatment 1e-30 >> $card_name
echo set mass 1000013 $mass >> $card_name
echo set mass 2000013 $mass >> $card_name
echo set decay 2000013 6.500000e-15 >> $card_name

#TODO Add decay range functionality
for ((mass=$mass_start+100;mass<=mass_end;mass=$mass+100)); do
	run_dir='smu'$mass'gev'$decay'ns'
	echo launch -n $dir_name >> $card_name
	echo set mass 1000013 $mass >> $card_name
	echo set mass 2000013 $mass >> $card_name
	echo set decay 2000013 6.500000e-15 >> $card_name
done

echo done >> $card_name
