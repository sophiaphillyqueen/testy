// process_version_query.c - Processes the --version option
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

void process_version_query ( void );

void process_version_query ( void )
{
  int lc_counto;
  lc_counto = 1;
  while ( lc_counto < chorebox_argc )
  {
    if ( chorebox_samestrg_c(chorebox_argv[lc_counto],"--version") )
    {
      printf("%s, version %s\n",THIS_PROGRAMS_SUITENAME,THIS_PROGRAMS_VERSION);
      printf("Copyright (C) %s %s\n",THIS_PROGRAMS_YEAR,THIS_PROGRAMS_HOLDER);
      fflush(stdout);
      exit(0);
    }
    
    if ( chorebox_samestrg_c(chorebox_argv[lc_counto],"--version-id") )
    {
      printf("%s\n",THIS_PROGRAMS_VERSION);
      fflush(stdout);
      exit(0);
    }
    lc_counto++;
  }
  return;
}

