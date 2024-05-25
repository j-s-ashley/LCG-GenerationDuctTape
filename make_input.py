import numpy as np
import shutil

# Create input text file for HTCondor
f = open("input.txt", "w")

# --- Variable initialization --- #
mass_start = float(input("Enter the minimum particle mass in GeV: "))
mass_end = float(input("Enter the maximum particle mass in GeV: "))
mass_increment = float(input("Enter the mass step size in GeV: "))
num_masses = int( ( (mass_end - mass_start) / mass_increment ) + 1 )

lifetime_start = float(input("Enter the minimum particle lifetime in ns: "))
lifetime_end = float(input("Enter the maximum particle lifetime in ns: "))
lifetime_increment = float(input("Enter the lifetime step size in ns: "))
num_lifetimes = int( ( (lifetime_end - lifetime_start) / lifetime_increment ) + 1 )
# --- End variable initialization --- #

print("Creating input card...")

for mass in np.linspace(mass_start, mass_end, num_masses):
    for lifetime in np.linspace(lifetime_start, lifetime_end, num_lifetimes):
        f.write( str(mass) + " " + str(lifetime) + "\n")

f.close()
# Input card needs to be included in submission directory
shutil.move("input.txt","submission/input.txt")

print("Input card 'input.txt' created and moved to the submission directory.")
