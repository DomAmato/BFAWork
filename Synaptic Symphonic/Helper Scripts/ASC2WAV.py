'''
Created on Mar 17, 2013

@author: Dom Amato
'''
import scipy.io.wavfile
import scipy.io
import numpy as np
from numpy import *
from  matplotlib import pyplot as plt

results = np.loadtxt('input1.asc', skiprows=1)
results2 = np.loadtxt('input2.asc', skiprows=1)
results = np.vstack((results,results2)) #the files were too big to output to 1 file, join them here
for i in range(len(results[0])):
    row1 = np.hsplit(results,len(results[0]))
    row0 = np.array(row1[i])
    row2 = np.squeeze(row0)
    
    row3 = np.array_split(row2,7968) #split into smaller arrays
    row4 = np.hstack((row3[1],row3[2]))
    
    filename='output%i.wav' %(i)
    scipy.io.wavfile.write(filename, 256, row4.astype(int32))
    
    if i==0:
        plt.plot(row4)
        plt.show()
        print 'plotting'