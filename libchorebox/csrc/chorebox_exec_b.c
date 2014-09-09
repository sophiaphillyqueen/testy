// libchorebox - A high-level C programming library for -chorebox-
// chorebox_exec_b.c - Source-code for this function:
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
#include <unistd.h>

void chorebox_exec_b ( chorebox_str_list *rg_a )
{
  char *lc_fildes;
  char *lc_filsorc;
  char *lc_epath;
  
  // Can't do much if we are given an empty command line.
  if ( rg_a == NULL )
  {
    fprintf(stderr,"\n%s: FATAL ERROR: chorebox_exec_b confusion:\n",chorebox_argv[0]);
    fprintf(stderr,"    It appears as though it was given an empty command line.\n\n");
    fflush(stderr);
    exit(6);
  }
  
  // And we also can't proceed if we can't find where the
  // executable is located.
  lc_filsorc = (rg_a->str);
  lc_epath = getenv("PATH");
  lc_fildes = chorebox_run_from_path(lc_filsorc,lc_epath);
  if ( lc_fildes == NULL )
  {
    fprintf(stderr,"\n%s: FATAL ERROR: Could not find \"%s\":\n",chorebox_argv[0],lc_filsorc);
    fprintf(stderr,"\n SEARCHED: %s:\n\n",lc_epath);
    fflush(stderr);
    exit(7);
  }
  
  // But if none of these obstacles present themselves, then let us proceed.
  chorebox_exec_a(lc_fildes,rg_a);
}

