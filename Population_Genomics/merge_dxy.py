import os
import numpy as np

path = "/home/pierrot/Documents/data/output_dxy/hyp00_1"
os.chdir(path)

res = []

for file in os.listdir(path):

    print(file)
    i = 0

    for line in open(file, "r").readlines():

        if i == 0:
            i = 1
            pass
        else:
            line = line.split(",")
            line[-1] = line[-1].rstrip("\n")
            res.append(line[1:])

np.savetxt("/home/pierrot/Documents/data/output_dxy/hyp00_1_dxy.csv",
        res,
        delimiter =",",
        fmt ='% s')