# MIT License
# 
# Copyright (c) 2020 Robert Field
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# Requires Python 3

#
# Generate a GNU Makefile, to demonstrate parallel execution
#

EXECUTABLE_PROGRAM='../CLIENT/sample_client'

# integer, number of seconds sample_client should wait
EXCUTION_TIME=2

# number of instances, how many sample_clients are to be run
NUMBER_OF_INSTANCES=250

MAKEFILE_NAME='TestMakefile'

def generate_one_target(n):
    return f'exec_{n}'

def generate_target_list_names():
    return ' '.join([generate_one_target(n) for n in range(NUMBER_OF_INSTANCES)])

def create_preamble(out_file):
    print('.PHONY: all', file=out_file)
    print('all: %s' % (generate_target_list_names(),), file=out_file)

def run_makefile():
    with open(MAKEFILE_NAME, 'w') as out_file:
        create_preamble(out_file)
        create_main_execution(out_file)

if __name__ == '__main__':
    run_makefile()
