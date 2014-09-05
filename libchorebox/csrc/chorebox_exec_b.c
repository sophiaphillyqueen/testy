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
#include <unistd.h>

void chorebox_exec_b ( chorebox_str_list *rg_a )
{
  size_t lc_argbfsiz;
  chorebox_str_list *lc_trc;
  char **lc_neoarg;
  char **lc_putter;
  
  // First, we find out how much room is needed
  // in the buffer.
  lc_argbfsiz = 1;
  lc_trc = rg_a;
  while ( lc_trc != NULL )
  {
    lc_argbfsiz++;
    lc_trc = lc_trc->nex;
  }
  lc_argbfsiz *= sizeof(char *);
  
  // Now we mallocate it ...
  lc_neoarg = chorebox_mlc(lc_argbfsiz);
  
  // And we now load the new array;
  lc_putter = lc_neoarg;
  lc_trc = rg_a;
  while ( lc_trc != NULL )
  {
    *lc_putter = lc_trc->str;
    lc_putter++;
    lc_trc = lc_trc->nex;
  }
  *lc_putter = NULL;
  
  // And we now do the big exec ....
  execv(getenv("PATH"),lc_neoarg);
}


