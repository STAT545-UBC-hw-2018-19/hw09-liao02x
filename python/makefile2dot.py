#!/usr/bin/env python
# -*- coding: utf-8 -*-
from sys import stdin, stdout
from os.path import splitext
import re

node_dict = dict()
node_id = 0
type_dict = {"": "red", 
             ".R": "purple",
             ".py": "yellow",
             ".png": "green",
             ".html": "blue"
             }

def _line_emitter(input):
    line_to_emit = ''
    
    for line in input:        
        if line.endswith('\\'):
            line_to_emit += line[:-1]
        else:
            line_to_emit += line
            yield line_to_emit
            line_to_emit = ''

_pat_colon = re.compile(':')
def _dependency_emitter(lines):
    for line in lines:
        if (len(line) == 0 or 
            line[0] in ['\t', '#'] or 
            line.find('=') > 0 or 
            line.find('?') > 0):
            continue
            
        parts = _pat_colon.split(line)
        if len(parts) == 1:
            continue
        elif len(parts) == 2:
            if len(parts[1]) == 0 or parts[1][0] != '=':
                yield tuple(parts)

_pat_whitespacing = re.compile('[ \t]+')
def _single_dot_dep_emitter(out_deps_pairs):
    global node_dict
    global node_id
    for outs_str, deps_str in out_deps_pairs:
        for out in _pat_whitespacing.split(outs_str.strip()): 
            if out not in node_dict:
                node_id +=1
                node_dict[out] = "n" + str(node_id)
            filetype = type_dict.get(splitext(out)[1], "black")
            yield '\t%s[label="%s", color="%s"];\n' % (
                    node_dict[out], 
                    out,
                    filetype)
            deps = _pat_whitespacing.split(deps_str.strip())
            for dep in deps:
                if dep:
                    if dep[0] == '#':
                        break
                    if dep not in node_dict:
                        node_id +=1
                        node_dict[dep] = "n" + str(node_id)
                    filetype = type_dict.get(splitext(dep)[1], "black")
                    yield '\t%s[label="%s", color="%s"];\n\t%s -> %s;\n' % (
                            node_dict[dep],
                            dep, 
                            filetype,
                            node_dict[dep],
                            node_dict[out])
                
def makefile2dot():
    '''
    Visalizer of Makefiles. 
    Don't even think we use a grammar parser. 
    '''
    stdout.write('digraph G {\n\trankdir="BT"\n')
    for line in _single_dot_dep_emitter(
            _dependency_emitter(
                    _line_emitter("".join(stdin).split('\n')))):
        stdout.write(line)
    stdout.write('}\n')


if __name__ == "__main__":
    makefile2dot()
    