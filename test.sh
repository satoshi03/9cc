#!/bin/bash

try () {
  expected="$1"
  input="$2"

  ./9cc "$input" > tmp.s
  gcc -static -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" == "$expected" ]; then
      echo "$input => $actual"
  else
      echo "$input: $expected expected, but got $actual"
      exit 1
  fi
}

try_unit () {
  ./9cc -test
  if [ $? != 0 ]; then
      echo "Unit test failed"
      exit 1
    fi
}

try 0 'return 0;'
try 42 'return 42;'
try 21 '1+2; return 5+20-4;'
try 41 'return 12 + 34 - 5;'
try 36 'return 1+2+3+4+5+6+7+8;'
try 45 'return (2+3)*(4+5);'
try 190 'return 1+2+3+4+5+6+7+8+9+10+11+12+13+14+15+16+17+18+19;'

try 10 'return 2*3+4;'
try 14 'return 2+3*4;'
try 26 'return 2*3+4*5;'
try 2 'if (1) return 2; return 3;'
try 3 'if (0) return 2; return 3;'

try 5 'return 50/10;'
try 9 'return 6*3/2;'

try 2 'a=2; return a;'
try 10 'a=2; b=3+2; return a*b;'

try_unit

echo OK
