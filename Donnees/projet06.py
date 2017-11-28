import re
Dims = re.compile(r"^\s*Dims\s*=\s*(\d+)\s*x\s*(\d+)\s*$")
Haut = re.compile(r"^\s*Haut\s*=\s*(.+)$")
Bas  = re.compile(r"^\s*Bas\s*=\s*(.+)$")

text = open("projet06.txt").read().strip()
chunks = text.split("==================================================\n")
PROBLEMES = []
for chunk in chunks:
    d = {}
    PROBLEMES.append(d)
    for line in chunk.strip().split("\n"):
        m = Dims.match(line)
        if m:
            d["rows"] = int(m.group(1))
            d["cols"] = int(m.group(2))
            continue
        m = Haut.match(line)
        if m:
            d["haut"] = [int(x) for x in m.group(1).strip().split()]
            continue
        m = Bas.match(line)
        if m:
            d["bas"] = [int(x) for x in m.group(1).strip().split()]
            continue

import yaml, sys
yaml.dump(PROBLEMES, sys.stdout)
