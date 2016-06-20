import sys
import os
import math
import csv
import numbers
from math import *
#from importlib.machinery import SourceFileLoader

# Net adresatsii iacheek. Vse ostalinoe norm

if (len(sys.argv) < 3):
	print('Not enough arguments. Please try again')
	exit()
	
inFile = sys.argv[1]
outFile = sys.argv[2] 

# check for modules
if (len(sys.argv) == 4):
    #gettingModule = SourceFileLoader(os.path.realpath(sys.argv[3]), os.path.realpath(sys.argv[3])).load_module()
	exec("from "+sys.argv[3][:sys.argv[3].find('.')]+" import *")
	
workTable = []
cell = {}

#Getting data 
with open(inFile, 'r') as fileO:
    reader = csv.reader(fileO)
    workTable.append([])
    rowIndex = 0
    for row in reader:
        for col in row:
            workTable[rowIndex].append(col)
        workTable.append([])
        rowIndex += 1
#cl = len(exelTable[0])

with open(outFile, 'w') as file1:

	for i in range(0,rowIndex):
		for j in range(0,len(workTable[1])):
			elem  = workTable[i][j]
			if elem == '':
				file1.write('')
				if ( j != len(workTable[1])):
					file1.write(',')
				else:
					if ( i != rowIndex-1):
						file1.write('\n')
				continue
					
			if (isinstance(elem,numbers.Number)):
				file1.write(str(elem))
				print('Hello')
			else:
				try:
					if (elem[0] == '='):
						elem = elem[1:]
						file1.write(str(eval(elem)))
					else:
						file1.write(elem)
				except SyntaxError:
					file1.write('Error, error, error')
				
			if ( j != len(workTable[1])-1):
				file1.write(',')
			else:
				if ( i != rowIndex):
					file1.write('\n')	
									