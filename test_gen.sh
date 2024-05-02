#!/bin/bash

mass_start=$1
mass_end=$2
mass=$mass_start

decay=1

run_dir='smu'$mass'gev'$decay'ns'

mg_dir_name='PROC_RPVMSSM_UFO_'
mg_dir_i=0
mg_dir=$mg_dir_name$mg_dir_i

source /cvmfs/sft.cern.ch/lcg/views/LCG_102b_ATLAS_6/x86_64-centos9-gcc11-opt/setup.sh
bash make_proc_card.sh $mass_start $mass_end
mg5_aMC auto_proc_card.dat > mg5.log

while [ -d $mg_dir ]; do
        mg_dir_i=$((mg_dir_i + 1))
        mg_dir=$mg_dir_name$mg_dir_i
        echo File name exists. Iterating to $mg_dir.
	for ((mass=$mass;mass<=mass_end;mass=$mass+100)); do
        	run_dir='smu'$mass'gev'$decay'ns'
        	gunzip $PWD/$mg_dir/Events/$run_dir/unweighted_events.lhe.gz
		echo LHEF unzipped.
		sed -i "s/Beams:LHEF = /path/to/LHEF/f.lhe   ! the LHEF to read from/Beams:LHEF = $PWD/$mg_dir/Events/$run_dir/unweighted_events.lhe/" main42.cmnd
		./main42 main42.cmnd out.hepmc > $PWD/$mg_dir/Events/$run_dir/out_$run_dir.log
		echo Hadronization complete for $run_dir.
	done
done

echo Full generation process done.
