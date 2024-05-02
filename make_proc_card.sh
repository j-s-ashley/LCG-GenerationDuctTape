#!/bin/bash

card_name='auto_proc_card.dat'

mass_start=$1
mass_end=$2

mass=$mass_start

decay=1

dir_name='smu'$mass'gev'$decay'ns'

nevents=3

touch $card_name
echo import model ../../DVMuReint/RPVMSSM_UFO/RPVMSSM_UFO/ > $card_name
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

for ((mass=$mass_start+100;mass<=mass_end;mass=$mass+100)); do
	dir_name='smu'$mass'gev'$decay'ns'
	echo launch -n $dir_name >> $card_name
	echo set mass 1000013 $mass >> $card_name
	echo set mass 2000013 $mass >> $card_name
	echo set decay 2000013 6.500000e-15 >> $card_name
done

echo done >> $card_name
