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
# Run the client a few times and wait for it to end
#

PATH=$PATH:../CLIENT
export PATH

NUM_CLIENTS=5

for one_client in `seq $NUM_CLIENTS`
do
  sample_client -m "CLIENT $one_client A" -d `expr $NUM_CLIENTS + 2  - $one_client` &
  sample_client -m "CLIENT $one_client B" -d `expr $NUM_CLIENTS + 2  - $one_client` &
  sample_client -m "CLIENT $one_client C" -d `expr $NUM_CLIENTS + 2  - $one_client` &
done

wait
