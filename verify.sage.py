# This file was *autogenerated* from the file ./verify.sage
from sage.all_cmdline import *   # import sage library
_sage_const_3 = Integer(3); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1)#!/usr/bin/env sage

import hashlib #This module implements a common interface to many different secure hash and message digest algorithms.
import random	#This module contains a number of random number generators.
from sys import argv # is an alternative way to import a module that allows you to access the given names without naming the module.

#in below two function we read and write file's name 
def open_file_for_read(filename):
    file_read = open(filename, 'r')
    return file_read

def open_file_for_write(filename):
    file_write = open(filename, 'w')
    return file_write

#in these two function we expect to get files'name in order
if len(argv) >= _sage_const_2 :
    file_name = argv[_sage_const_1 ]
else:
    print 'Please enter DSA file'
    file_name = raw_input('Enter filename: ')

if len(argv) >= _sage_const_3 :
    file_name2 = argv[_sage_const_2 ]
else:
    print 'Please enter KEY file'
    file_name2 = raw_input('Enter filename: ')

#after got the file reads in here,and reads all values line by line until 3rd line. After 3rd line , reads rest of the file and using the same #hash algorithm. 
 
dsa_file = open(file_name, 'r')
r = dsa_file.readline()
s = dsa_file.readline()
M = dsa_file.read()
H = hashlib.sha1()
H.update(M)

ASCII = ''.join(str(ord(c)) for c in H.hexdigest())

#read the KEY file in here line by line .
key_file = open(file_name2,'r')
q = key_file.readline()
p = key_file.readline()
g = key_file.readline()
y = key_file.readline()

#assigns the string values to integer values in here.Compute w, such that s*w mod q = 1. w is called the modular multiplicative inverse of s #modulo q.Computes pw1,pw2 and checks if the values are same or not. If they are , It prints Valid otherwise not valid.
ASCII=int(str(ASCII))
r=int(str(r))
s=int(str(s))
q=int(str(q))
p=int(str(p))
g=int(str(g))
y=int(str(y))
w = (s**-_sage_const_1 )%q
pw1 = Mod((ASCII*w),q)
pw2 = Mod((r*w),q)
v = Mod(Mod((g**int(pw1))*(y**int(pw2)),p),q)

if(v==r):
    print ('VALID!!!!')
else:
    print ('NOT VALID')

