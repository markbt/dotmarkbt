#!/usr/bin/env python

import os
import re
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

    filename_re = re.compile('.*\.[ch](pp)?$')
    subtypes = set()
    preprocs = set()

    for line in open(tagfile):
        fields = line[:-1].split('\t')
        if len(fields) > 3:
            if filename_re.match(fields[1]):
                if fields[3] in ['c', 'n', 't']:
                    subtypes.add(fields[0])
                if fields[3] in ['d']:
                    preprocs.add(fields[0])

    if subtypes:
        print "syn keyword cSubType", ' '.join(subtypes)
    if preprocs:
        print "syn keyword cPreProc", ' '.join(preprocs)

if __name__ == '__main__':
    main()
