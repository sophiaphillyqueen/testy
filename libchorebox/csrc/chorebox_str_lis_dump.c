// libchorebox - A high-level C programming library for -chorebox-
// chorebox_str_lis_dump.c - Source-code for this function:
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

void chorebox_str_lis_dump ( chorebox_str_list **rg_a, chorebox_str_list **rg_b )
{
  chorebox_str_list **lc_flw;
  
  lc_flw = rg_b;
  while ( (*lc_flw) != NULL )
  {
    lc_flw = &((*lc_flw)->nex);
  }
  *lc_flw = *rg_a;
  *rg_a = NULL;
}

