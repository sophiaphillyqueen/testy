
// libchorebox - A high-level C programming library for -chorebox-
// chorebox.h - Header-file of the library
// Copyright (C) 2014  Sophia Elizabeth Shapira
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// ########################

#ifndef L__CHOREBOX__H
#define L__CHOREBOX__H

#include <stdlib.h>
#include <stdbool.h>

typedef struct chorebox_str_list {
  char *str;
  struct chorebox_str_list *nex;
} chorebox_str_list;

// Here is where -libchorebox- stores the command-line
extern int chorebox_argc;
extern char **chorebox_argv;
extern char **chorebox_env;

//size_t chompify ( char **rg_a, size_t rg_b );
// This function acts like PERL's &chomp function on the <rg_a>
// string. Only instead of acting like &chomp is called just
// once, it acts like &chomp was called whatever number of times
// the <rg_b> argument specifies. The return value of this
// function is the number of characters that actually got
// removed from the end of the string.
//   This function will not return, but will terminate the program,
// should there be a memory-allocation error.

char *chorebox_apend_string ( char **rg_a, char *rg_b );
// This function appends (by copy )the contents of the string <rg_b>
// onto the end of the string <rg_a>.
//   The program fails with error in the event of a memory allocation
// failure - or if <rg_a> is null. Otherwise, what can go wrong?
//   The return value is the new value of <*rg_a>.
//   And the only way this will be NULL is if both <rg_b> and the
// going-in value of <*rg_a> are NULL.

chorebox_str_list *chorebox_colsep_to_list ( char *rg_a );
// The argument is a list (generally one of directories) stored as
// a C string formatted in the manner of the PATH environment variable.
// This function generates a <chorebox_str_list> linked-list rendition
// of that same list, and returns a pointer to that linked-list.

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

void chorebox_exec_b ( chorebox_str_list *rg_a );
// As with all the chorebox_exec_*() functions, this one does an
// exec based on a string-list - in this case in argument <rg_a>.
// If the first item on the list is free of any forward-slash
// characters, it will attempt to resolve the location of the
// command along the PATH environment variable.

void chorebox_free_str_list ( chorebox_str_list *rg_a );
// This function frees an entire <chorebox_str_list> linked-list
// of strings -- freeing up the memory for some other use.

void chorebox_getcwd ( char **rg_a );
// This function stores in the dyn-alloc string <rg_a> the full
// location of the Present Working Directory. The only things
// that could cause this function to fail are weird things such
// as memory-allocation failures upon which this function would
// rather terminate the program with error than return in disgrace.
//   The return-value is the char-pointer-type reference to the
// exiting-value of <rg_a> - and is provided just in case that is
// found as a more convenient way of using this function in some
// contexts.
// SEE FOR IMPLEMENTATION:
//   http://www.lehman.cuny.edu/cgi-bin/man-cgi?getcwd+3
// as well as:
//   http://www.gnu.org/software/libc/manual/html_node/Pathconf.html
//   http://www.delorie.com/djgpp/doc/libc/libc_612.html

char *chorebox_join_string ( char *rg_a, char *rg_b );
// This function takes two strings and returns their concatenated
// value. The return value will be NULL if and *only* if *both*
// of the *arguments* are NULL.
//   In the event of a memory-allocation failure, this function
// will not return, but will terminate the program with error.

void *chorebox_mlc (size_t size);
// This function behaves just like malloc() with one exception.
// If it fails, instead of returning NULL, it terminates the
// whole program with error -- using the <libchorebox> info
// regarding the command-line to format the error.
//   This function does *not* implement memory-allocation on
// it's own -- but rather, it does it's job as a *wrapper*
// function for malloc() - so that the memory block that it
// returns is of the same kind that malloc() would returned,
// and (if and when the time comes) can be released in the
// same manner (with free()).
//   This function is to be used in situations where there is
// not much point in the program continuing if the memory
// allocation fails and returning to the calling function at
// all in such an event would only put on the calling function
// the burden of having to check for success-or-failure of
// the memory-allocation.
//   Granted - there are some times when the value of the
// programming continuing is well-worth the burden of checking
// whether or not the memory-allocation operation succeeded -
// but the possibility of calling malloc() *directly* in those
// situations is not hindered by the fact that there is now
// this wrapper-function for *other* situations.

bool chorebox_str_lis_apnd ( chorebox_str_list **rg_a, char *rg_b );
// Apends a -copy- of the string specified in <rg_b> onto the end
// of the string-list specified in <rg_a>. If it fails because
// of memory allocation, the function will not return, but end
// the program with failure. On the other hand, if it fails because
// <rg_b> is NULL, it will simply do nothing, and return -false-.
// (If <rg_b> is an empty-string though, unlike with NULL, that is
// *not* a cause for failure.) If the function succeeds, it will
// return -true-.

void chorebox_str_lis_dump ( chorebox_str_list **rg_a, chorebox_str_list **rg_b );
// Transfers everything in list <rg_a> onto the *end* of the list
// <rg_b>. The result will be that the new <rg_b> list will in
// effect be the old <rg_b> list followed by the old <rg_a> list
// while the new <rg_a> list will be empty.
//   Nothing to report back since I can't see anything going wrong
// if this is used properly --- and if used improperly, I can't
// see any problem that I'd be able to error-handle.

//bool pipe_grab(char *rg_a, char **rg_b);
// This function executes the shell command specified by the <rg_a>
// argument, and pipe-captures it's output, saving it to the string
// specified by <rg_b>. It returns -true- if successful and -false-
// if anything goes detectibly awry - except for a failure in memory
// allocation. If that happens, it is treated as a terminal error
// for the program.

#endif

