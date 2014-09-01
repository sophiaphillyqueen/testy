// chorebox-in - The 'chorebox' wrapper for -configure- scripts.
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

#ifndef LOCAL_INC__CHOREBOX_IN__H
#define LOCAL_INC__CHOREBOX_IN__H

#include <chorebox.h>
#include <stdio.h>

bool autodetect_home_bin_dir ( char **rg_a );
// This function searches PATH to find the first directory it
// can find that meets the requirement of being of the user's
// where this user can install stuff.
//   Currently, the only test it knows for this purpose is if
// the directory is within the hierarchy of the home directory.
//   If it finds no such directory, then this function returns
// -false- and does nothing else.
//   If it finds such a directory, it copies it's name to
// <rg_a> and returns -true-.
//   If it fails due to memory allocation error, it does not
// return at all, but terminates the program with error.

bool if_not_specified ( char *rg_a, char *rg_b );
// If the dir-variable named <rg_a> is specified among the legacy
// options, do nothing and return -false-. Otherwise, add that
// variable with the value of <rg_b> to the newly-added options
// and return -true-.
//   Once again - the program ends with failure if there is a
// memory allocation failure.

void show_usage_error ( char *rg_a );
// Shows an error-message related to this program's usage -- and
// then terminates the program with failure.

bool specified_var_option ( char *rg_a );
// Returns -true- if the directory-variable named by <rg_a> is
// given value among the legacy options.

#endif
