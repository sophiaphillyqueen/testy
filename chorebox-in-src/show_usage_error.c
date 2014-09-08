// chorebox-in - The 'chorebox' wrapper for -configure- scripts.
// show_usage_error.c - Source-code for this function:
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

#include "chorebox-in.h"

void show_usage_error ( char *rg_a )
{
  fprintf(stderr,"\n%s: FATAL USAGE ERROR:\n",chorebox_argv[0]);
  fprintf(stderr,"    %s\n",rg_a);
  fprintf(stderr,"\nUSAGE:\n  %s [config-script-file]",chorebox_argv[0]);
  fprintf(stderr," ([options-to-config-script] ...)\n\n");
  fflush(stderr);
  exit(5);
}

