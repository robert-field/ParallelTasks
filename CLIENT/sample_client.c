/*
MIT License

Copyright (c) 2020 Robert Field

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>

char *help_text[] = {
  "This is the command line interface for a client program",
  "",
  "Without options, exit immediately with exit code 0.",
  "",
  "Options:",
  "",
  "  -f       Fail, exit code 1",
  "  -x N     Fail, exit code N",
  "  -d N     Delay N seconds before exit",
  "  -k       Exit by kill signal -9",
  "  -s N     Exit by signal N",
  "  -m MSG   Print MSG at exit",
  "",
  "Precedence",
  "",
  "  -x overrides -f",
  "  -k overrides -x or -f",
};

int
main (int argc, char *argv[])
{
  int delay_time = -1;
  int exit_code = 0;
  int fail_flag = 0;
  int kill_signal = 0;
  int signal_required = 0;
  int signal_to_use;
  char *user_message = 0;
  int opt;
  int i;

  while ((opt = getopt (argc, argv, "hfkx:d:m:s:")) != -1)
    {
      switch (opt)
	{
	case 'k':
	  kill_signal = 1;
	  break;
	case 'f':
	  fail_flag = 1;
	  break;
	case 'x':
	  exit_code = atoi (optarg);
	  break;
	case 'd':
	  delay_time = atoi (optarg);
	  break;
	case 'm':
	  user_message = strdup (optarg);
	  break;
	case 's':
	  signal_required = 1;
	  signal_to_use = atoi (optarg);
	  break;
	case 'h':
	default:
	  for (i = 0; i < sizeof (help_text) / sizeof (help_text[0]); ++i)
	    {
	      fprintf (stderr, "%s\n", help_text[i]);
	    }
	  return 0;
	}
    }

  if (delay_time != -1)
    {
      sleep (delay_time);
    }

  // program to end right after this
  if (user_message)
    {
      puts (user_message);
    }
  if (signal_required)
    {
      kill (getpid (), signal_to_use);
    }
  if (kill_signal)
    {
      kill (getpid (), SIGKILL);
    }
  if (exit_code != 0)
    {
      return exit_code;
    }
  if (fail_flag)
    {
      return 1;
    }
  return 0;
}
