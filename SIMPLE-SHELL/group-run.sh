#!/bin/sh


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

#
# Run multiple groups of clients.  Wait for each group to complete
# before running the next group.
#

PATH=$PATH:../CLIENT
export PATH

NUM_CLIENTS=5
NUM_GROUPS=5

for one_group in `seq $NUM_GROUPS`
do
    for one_client in `seq $NUM_CLIENTS`
    do
	delay_amount=$(($NUM_CLIENTS + 2 - $one_client))
	# do several at once, they won't always finish in A B C order
	for identifier in A B C
	do
	    sample_client -m "CLIENT GROUP $one_group CLIENT $one_client ID $identifier" -d $delay_amount &
	done
    done
    wait
done
