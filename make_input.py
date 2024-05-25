import numpy as np
import shutil

# Create input text file for HTCondor
f = open("input.txt", "w")

# --- Variable initialization --- #
mass_start = float(input("Enter the minimum particle mass in GeV: "))
mass_end = float(input("Enter the maximum particle mass in GeV: "))
mass_increment = float(input("Enter the mass step size in GeV: "))
num_masses = int( ( (mass_end - mass_start) / mass_increment ) + 1 )

tau_start = float(input("Enter the minimum particle lifetime in ns: "))
tau_end = float(input("Enter the maximum particle lifetime in ns: "))
tau_increment = float(input("Enter the lifetime step size in ns: "))
num_taus = int( ( (tau_end - tau_start) / tau_increment ) + 1 )
# --- End variable initialization --- #

print("Creating input card...")

for mass in np.linspace(mass_start, mass_end, num_masses):
    for tau in np.linspace(tau_start, tau_end, num_taus):
        f.write( str(mass) + " " + str(tau) + "\n")

f.close()
# Input card needs to be included in submission directory
shutil.move("input.txt","submission/input.txt")

print("Input card 'input.txt' created and moved to the submission directory.")
