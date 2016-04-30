#!/usr/bin/env python

import os
import sys

def find_tag_file():
    dirname = "."
    while os.path.exists(dirname):
        for candidate in "tags", "TAGS", ".tags":
            tagfile = os.path.join(dirname, candidate)
            if os.path.exists(tagfile):
                return tagfile
        dirname = os.path.join(dirname, "..")

def main():
    if len(sys.argv) > 1:
        tagfile = sys.argv[1]
    else:
        tagfile = find_tag_file()
    if not tagfile:
        sys.exit(1)

    for line in open(tagfile):
        fields = line.split('\t')
        if len(fields) > 3:
            if fields[3] == 's':
                print fields[0]
        if len(fields) > 4:
            if fields[4] == 't' and fields[4].startswith('typeref:'):
                print fields[0]

if __name__ == '__main__':
    main()
