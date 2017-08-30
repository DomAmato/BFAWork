'''
Created on May 1, 2014

@author: Dominic
'''
import scipy.io.wavfile
import scipy.io
import numpy as np


b1 = np.zeros((256,), dtype=np.int)
b2 = np.zeros((256,), dtype=np.int)
b3 = np.zeros((256,), dtype=np.int)
a = np.zeros((35,), dtype=np.int)

def setBit(int_type, offset):
     mask = 1 << offset
     return(int_type | mask)

# clearBit() returns an integer with the bit at 'offset' cleared.

def clearBit(int_type, offset):
    mask = ~(1 << offset)
    return(int_type & mask)

for i in range(35):
    filename = 'output%i.wav' % (i)
    r, d = scipy.io.wavfile.read(filename)
    a[i] = np.average(d)

a1 = a[6]
a2 = a[10]
a3 = a[15]
a4 = a[25]
a5 = a[1]
a6 = a[9]
a7 = a[20]
a8 = a[24]
a9 = a[31]
a10 = a[28]
a11 = a[0]
a12 = a[5]
a13 = a[14]
a14 = a[32]
a15 = a[23]
a16 = a[30]
a17 = a[4]
a18 = a[13]
a19 = a[19]
a20 = a[29]

for i in range(35):
    
    filename='output%i.wav' %(i)
    r,d=scipy.io.wavfile.read(filename)
    
    for k in range(len(d)):
        if i==6 and d[k]>a1:
            b1[k] = setBit(b1[k],0)
        elif i==6:
           b1[k] =  clearBit(b1[k],0)
        if i==10 and d[k]>a2:
            b1[k] = setBit(b1[k],1)
        elif i==10:
           b1[k] =  clearBit(b1[k],1)
        if i==15 and d[k]>a3:
            b1[k] = setBit(b1[k],2)
        elif i==15:
           b1[k] =  clearBit(b1[k],2)
        if i==25 and d[k]>a4:
            b1[k] = setBit(b1[k],3)
        elif i==25:
           b1[k] =  clearBit(b1[k],3)
        if i==1 and d[k]>a5:
            b1[k] = setBit(b1[k],4)
        elif i==1:
           b1[k] =  clearBit(b1[k],4)
        if i==9 and d[k]>a6:
            b1[k] = setBit(b1[k],5)
        elif i==9:
           b1[k] =  clearBit(b1[k],5)
        if i==20 and d[k]>a7:
            b1[k] = setBit(b1[k],6)
        elif i==20:
           b1[k] =  clearBit(b1[k],6)
        if i==24 and d[k]>a8:
            b1[k] = setBit(b1[k],7)
        elif i==24:
           b1[k] =  clearBit(b1[k],7)
           ################################### BYTE 2 ########################
        if i==31 and d[k]>a9:
            b1[k] = setBit(b1[k],8)
        elif i==31:
           b1[k] =  clearBit(b1[k],8)
        if i==28 and d[k]>a10:
            b1[k] = setBit(b1[k],9)
        elif i==28:
           b1[k] =  clearBit(b1[k],9)
        if i==0 and d[k]>a11:
            b1[k] = setBit(b1[k],10)
        elif i==0:
            b1[k] =  clearBit(b1[k],10)
        if i==5 and d[k]>a12:
            b1[k] = setBit(b1[k],11)
        elif i==5:
           b1[k] =  clearBit(b1[k],11)
        if i==14 and d[k]>a13:
            b1[k] = setBit(b1[k],12)
        elif i==14:
           b1[k] =  clearBit(b1[k],12)
        if i==32 and d[k]>a14:
            b1[k] = setBit(b1[k],13)
        elif i==32:
           b1[k] =  clearBit(b1[k],13)
        if i==23 and d[k]>a15:
            b1[k] = setBit(b1[k],14)
        elif i==23:
           b1[k] =  clearBit(b1[k],14)
        if i==30 and d[k]>a16:
            b1[k] = setBit(b1[k],15)
        elif i==30:
           b1[k] =  clearBit(b1[k],15)
        if i==31 and d[k]>a9:
            b2[k] = setBit(b2[k],0)
        elif i==31:
           b2[k] =  clearBit(b2[k],0)
        if i==28 and d[k]>a10:
            b2[k] = setBit(b2[k],1)
        elif i==28:
           b2[k] =  clearBit(b2[k],1)
        if i==0 and d[k]>a11:
            b2[k] = setBit(b2[k],2)
        elif i==0:
           b2[k] =  clearBit(b2[k],2)
        if i==5 and d[k]>a12:
            b2[k] = setBit(b2[k],3)
        elif i==5:
           b2[k] =  clearBit(b2[k],3)
        if i==14 and d[k]>a13:
            b2[k] = setBit(b2[k],4)
        elif i==14:
           b2[k] =  clearBit(b2[k],4)
        if i==32 and d[k]>a14:
            b2[k] = setBit(b2[k],5)
        elif i==32:
           b2[k] =  clearBit(b2[k],5)
        if i==23 and d[k]>a15:
            b2[k] = setBit(b2[k],6)
        elif i==23:
           b2[k] =  clearBit(b2[k],6)
        if i==30 and d[k]>a16:
            b2[k] = setBit(b2[k],7)
        elif i==30:
           b2[k] =  clearBit(b2[k],7)
           ########################## BYTE 3 #############################
        if i==4 and d[k]>a17:
            b3[k] = setBit(b3[k],0)
        elif i==4:
           b3[k] =  clearBit(b3[k],0)
        if i==13 and d[k]>a18:
            b3[k] = setBit(b3[k],1)
        elif i==13:
           b3[k] =  clearBit(b3[k],1)
        if i==19 and d[k]>a19:
            b3[k] = setBit(b3[k],2)
        elif i==19:
           b3[k] =  clearBit(b3[k],2)
        if i==29 and d[k]>a20:
            b3[k] = setBit(b3[k],3)
        elif i==29:
           b3[k] =  clearBit(b3[k],3)
    
filename='byte1.csv'
np.savetxt(filename, np.atleast_2d(b1), fmt='%.0f', delimiter=",")
filename='byte2.csv'
np.savetxt(filename, np.atleast_2d(b2), fmt='%.0f', delimiter=",")
filename='byte3.csv'
np.savetxt(filename, np.atleast_2d(b3), fmt='%.0f', delimiter=",")
    