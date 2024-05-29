with open('fault.set', 'r') as file:
    lines = file.readlines()

with open('fault_updated.set', 'w') as file:
    for line in lines:
        updated_line = line.replace('mor1kx_cpu.cappuccino', 'mor1kx_cpu.lockstep.mor1kx_lockstep_ctrl')
        updated_line = updated_line.replace('mor1kxO', 'mor1kx0')
        file.write(updated_line)

