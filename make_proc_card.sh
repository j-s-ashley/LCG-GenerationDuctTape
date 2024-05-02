#!/bin/bash

mass_start=$1
mass_end=$2

touch auto_proc_card.dat
echo import model ../../DVMuReint/RPVMSSM_UFO/RPVMSSM_UFO/ > auto_proc_card.dat
echo define q = g u c d s u~ c~ d~ s~ b t b~ t~ h01 h2 h3 h+ h- >> auto_proc_card.dat
echo define p = g u c d s u~ c~ d~ s~ b b~ >> auto_proc_card.dat
echo 'generate p p > mur- mur+ /q' >> auto_proc_card.dat
echo output auto >> auto_proc_card.dat
echo launch >> auto_proc_card.dat
echo ./param_card_default.dat >> auto_proc_card.dat
echo set nevents 20000 >> auto_proc_card.dat
echo set time_of_flight 0.0 >> auto_proc_card.dat
echo set small_width_treatment 1e-30 >> auto_proc_card.dat
echo set mass 1000013 $mass >> auto_proc_card.dat
echo set mass 2000013 $mass >> auto_proc_card.dat
echo set decay 2000013 6.500000e-15 >> auto_proc_card.dat

for ((mass=$mass_start+100;mass<=mass_end;mass=$mass+100)); do
	echo launch >> auto_proc_card.dat
	echo set mass 1000013 $mass >> auto_proc_card.dat
	echo set mass 2000013 $mass >> auto_proc_card.dat
	echo set decay 2000013 6.500000e-15 >> auto_proc_card.dat
done
