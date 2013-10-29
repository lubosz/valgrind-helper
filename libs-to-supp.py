#!/usr/bin/python

import sys

def p(l):
    sys.stdout.write(l)

if __name__ == "__main__":
    for line in sys.stdin:
        libline = line.split(".so")[0]
        name = libline.split("/")[-1]
        memchecks = ["Leak", "Value8", "Cond"]
        for check in memchecks:
          p("{\n")
          p("   %s %s\n" % (name, check))
          p("   Memcheck:%s\n" % check)
          p("   ...\n")
          p("%s" % libline + "*\n")
          p("   ...\n")
          p("}\n")
