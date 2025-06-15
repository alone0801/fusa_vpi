mark = 0
def fast_equal(num, stra, strb):
    global mark
    if (len(stra) != len(strb)):
        mark = num + 1
        return False
    if stra[-10:] != strb[-10:]:
        return False
    return stra[:-10] == strb[:-10]

def fault_classification():
    global mark
    port = []
    fault_set = []
    fault_iso_set = []
    with open('port.log', 'r') as f:
        for num, line in enumerate(f):
            if(num == 0): 
                continue
            else:
                port.append(line.strip().split()[0])
    port.sort(key = len)
    with open('fault.set', 'r') as f:
        for num, line in enumerate(f):
            if(num == 0): 
                continue
            else:
                fault_set.append(line.strip().split())
    fault_set.sort(key = lambda x: len(x[0]))

    for signal_a in port:
        if(mark >= len(fault_set)): break
        cnt = 0
        tmp_mark = mark
        for i in range(len(fault_set) - tmp_mark):
            signal_b = fault_set[i + tmp_mark - cnt]
            if(len(signal_a) < len(signal_b[0])):
                break
            if(fast_equal(i + tmp_mark - cnt, signal_a, signal_b[0])):
                fault_iso_set.append(signal_b)
                fault_set.pop(i + tmp_mark - cnt)
                cnt += 1
    with open('fault_non_iso.set', 'w') as f:
        f.write('<LOCATION> <TYPE> <VALUE> <TIME> <SET_RETURN_TIME> <RESULT>\n')
        for num, line in enumerate(fault_set):
            for num_r, stmt in enumerate(line):
                f.write(stmt)
                if(num_r != len(line) - 1):
                    f.write('  ')
                elif(num != len(fault_set) - 1):
                    f.write('\n')
    with open('fault_iso.set', 'w') as f:
        f.write('<LOCATION> <TYPE> <VALUE> <TIME> <SET_RETURN_TIME> <RESULT>\n')
        for num, line in enumerate(fault_iso_set):
            for num_r, stmt in enumerate(line):
                f.write(stmt)
                if(num_r != len(line) - 1):
                    f.write('  ')
                elif(num != len(fault_iso_set) - 1):
                    f.write('\n')
    print("fault set is classified successfully\n")

def verify():
    port = set()
    fault_non_iso_set = set()
    fault_iso_set = set()
    with open('port.log', 'r') as f:
        for num, line in enumerate(f):
            if(num == 0): 
                continue
            else:
                port.add(line.strip().split()[0])
    with open('fault_iso.set', 'r') as f:
        for num, line in enumerate(f):
            if(num == 0): 
                continue
            else:
                fault_iso_set.add(line.strip().split()[0])
    with open('fault_non_iso.set', 'r') as f:
        for num, line in enumerate(f):
            if(num == 0): 
                continue
            else:
                fault_non_iso_set.add(line.strip().split()[0])
    print(fault_iso_set.issubset(port))
    print(fault_non_iso_set.isdisjoint(port))
    print(fault_iso_set.isdisjoint(fault_non_iso_set))

fault_classification()
