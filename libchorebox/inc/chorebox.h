
// chorebox.h - Header file by which -chorebox- will not need PERL
// Copyright (C) 2014  Sophia Elizabeth Shapira

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// ########################

#ifndef L__CHOREBOX__H
#define L__CHOREBOX__H

#include <stdlib.h>
#include <stdbool.h>

typedef struct chorebox_str_list {
  char *str;
  struct chorebox_str_list *nex;
} chorebox_str_list;

size_t chompify ( char **rg_a, size_t rg_b );
// This function acts like PERL's &chomp function on the <rg_a>
// string. Only instead of acting like &chomp is called just
// once, it acts like &chomp was called whatever number of times
// the <rg_b> argument specifies. The return value of this
// function is the number of characters that actually got
// removed from the end of the string.
//   This function will not return, but will terminate the program,
// should there be a memory-allocation error.

void chorebox_command_line ( int rg_a, char **rg_b, char **rg_c );
// This function should be called very early on in the game from
// the main() function so that the libchorebox library (as well as
// any functions outside that library that use it) can see the
// contents of the command-line and environment.
// <rg_a> should be main()'s <argc> --> save to <chorebox_argc>
// <rg_b> should be main()'s <argv> --> save to <chorebox_argv>
// <rg_c> should be main()'s <env> ---> save to <chorebox_env>
// The return value is "void" because, if used properly, there should
// be nothing at all for this function to report back.

bool chorebox_str_lis_apnd ( chorebox_str_list **rg_a, char *rg_b );
// Apends a -copy- of the string specified in <rg_b> onto the end
// of the string-list specified in <rg_a>. If it fails because
// of memory allocation, the function will not return, but end
// the program with failure. On the other hand, if it fails because
// <rg_b> is NULL, it will simply do nothing, and return -false-.
// (If <rg_b> is an empty-string though, unlike with NULL, that is
// *not* a cause for failure.) If the function succeeds, it will
// return -true-.

bool pipe_grab(char *rg_a, char **rg_b);
// This function executes the shell command specified by the <rg_a>
// argument, and pipe-captures it's output, saving it to the string
// specified by <rg_b>. It returns -true- if successful and -false-
// if anything goes detectibly awry - except for a failure in memory
// allocation. If that happens, it is treated as a terminal error
// for the program.

#endif

