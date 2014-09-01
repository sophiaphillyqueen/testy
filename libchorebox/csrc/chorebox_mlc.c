// libchorebox - A high-level C programming library for -chorebox-
// chorebox_mlc.c - Source-code for this function:
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

#include <chorebox.h>
#include <stdio.h>


void *chorebox_mlc (size_t size)
{
  void *lc_ret;
  
  lc_ret = malloc(size);
  if ( lc_ret != NULL ) { return lc_ret; }
  
  fprintf(stderr,"\n%s: FATAL ERROR:\n  Memory Allocation Failure:\n\n",chorebox_argv[0]);
  fflush(stderr);
  exit(2);
}


