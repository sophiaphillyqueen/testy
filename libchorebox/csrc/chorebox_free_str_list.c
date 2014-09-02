// libchorebox - A high-level C programming library for -chorebox-
// chorebox_free_str_list.c - Source-code for this function:
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

void chorebox_free_str_list ( chorebox_str_list *rg_a )
{
  chorebox_str_list *lc_ths;
  chorebox_str_list *lc_nex;
  char *lc_str;
  
  lc_ths = rg_a;
  while ( lc_ths != NULL )
  {
    lc_nex = lc_ths->nex;
    lc_str = lc_ths->str;
    if ( lc_str != NULL ) { free(lc_str); }
    free(lc_ths);
    lc_ths = lc_nex;
  }
}


