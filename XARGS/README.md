Run multiple tasks using the xargs utility program.

**What is *xargs*?**

`xargs` is a program, for *nix systems, that reads a list of parameters
from standard input, and fills a command line for an executable with
those parameters.

It is frequently used as a post-processor for `find`, and has many
options.

For example, the pipline

`find . -name "*.py" -mtime +30 | xargs rm`

finds all Python files more than 30 days old, and that list is piped
to `rm`, where command lines are built.  If the number of files to be
removed is very large, then there are multiple invocations of `rm`,
each with the maximum number of file names, to delete all the files.


**Our use case**

One of the options for *xargs* is `-n max-args`, or long form
`--max-args=max-args`.  If we set this to 1, a separate process will
be run for each parameter value.  This doesn't seem useful for
parallelism, but there is another parameter, `-P max-procs`, or long
form, `--max-procs=max-procs`.  This controls how many processes to
run in parallel.

Suppose, for example, you have many images, `.png` files, and want to
run your `image_fixer` program against each one.  You have 8 cores, so
you figure that you can run 8 processes in parallel.  Then you might
have a pipeline like

`find . -name ".png" | xargs --max-args 1 --max-procs=8 image_fixer`

and this will run up to 8 processes in parallel till all the `.png`
files have been processed.

**Client program**

For examples of `xargs` usage, this directory has a `countargs`
program that tells how many arguments it is called with, so see what
`xargs` is doing.

**Driver Scripts**

`single_args` - run 8 instances of `countargs` in parallel, with just
one parameter.

`many_args` - run 8 instances of `countargs` in parallel, with thirty
parameters.

You can see the difference in what is run.
