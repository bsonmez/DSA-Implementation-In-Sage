#!/usr/bin/env sage

import hashlib #This module implements a common interface to many different secure hash and message digest algorithms.
import random #This module contains a number of random number generators.
from sys import argv # is an alternative way to import a module that allows you to access the given names without naming the module.

#In this function we are randomly generating a number which calls 'q' 
def generate_q(power_low, power_high):
    result = 1
    while (result < 2^power_low):
        result = random_prime(2^power_high)
    return result
#In function we are creating a number that calls 'p' until it makes it prime
def generate_p(q):
    result = 1 
    while (not is_prime(result)):
        result = (randint(1, 2^46) * 2 * q) + 1
    return result

#in below two function we read and write file's name 
def open_file_for_read(filename):
    file_read = open(filename, "r")
    return file_read

def open_file_for_write(filename):
    file_write = open(filename, "w")
    return file_write

#Here we ask the file's name from user which file wanted to sign
if len(argv) >= 2:
    file_name = argv[1]
else:
    print 'File is Required'
    file_name = raw_input('Enter filename: ')
    
q = generate_q(15, 16)
p = generate_p(q)

#assign a number to h between 2 and p-2 ,computing F by using abstract Galois field operator.Then finding g's value.
h = randint(2,p-2)
F = GF(p)
g = F(h) ^ ((p-1) / q)

#as we did above , assigned x with a number between 0 and q 
x = randint(0,q)

y = (g ^ x) % p

#Reading the file which entered by user.
#Generate the message digest h, using a hash algorithm like SHA1. 
message_file = open(file_name, 'r')
M = message_file.read()
H = hashlib.sha1()
H.update(M)

#HEX convers to ASCII
ASCII=''.join(str(ord(c)) for c in H.hexdigest())

#Random value between 0 - q
k=randint(0,q)

#power_mod does k power of g then mod p . At Last, the result of mod taken mod by q.It equals to the first value of signature
r=Mod(power_mod(int(g), int(k), int(p)),int(q))
i=(int(k)^-1)%int(q)

#After mathematical process the result equals to signature's second value which is 's'
s=Mod((int(i)*(int(ASCII)+int(r)*int(x))),int(q))

#Package r,s,m(the message in the user's text,doc) in a file with .dsa extension
DSA = open_file_for_write(file_name + '.dsa')
DSA.write(str(r))
DSA.write(str('\n'))
DSA.write(str(s))
DSA.write(str('\n'))
DSA.write(M)
DSA.close

#Package q,p,g,y are as like a public key.
KEY = open_file_for_write(file_name + '.key')
KEY.write(str(q))
KEY.write(str('\n'))
KEY.write(str(p))
KEY.write(str('\n'))
KEY.write(str(g))
KEY.write(str('\n'))
KEY.write(str(y))
KEY.close
