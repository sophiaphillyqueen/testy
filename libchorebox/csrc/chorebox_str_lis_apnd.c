// libchorebox - A high-level C programming library for -chorebox-
// chorebox_str_lis_apnd.c - Source-code for this function:
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

bool chorebox_str_lis_apnd ( chorebox_str_list **rg_a, char *rg_b )
{
  chorebox_str_list **lc_ref;
  
  // Not much to do if the string argument provided is NULL.
  if ( rg_b == NULL ) { return false; }
  
  // Otherwise, before adding anything, we direct our reference
  // handle to the *end* of the linked-list.
  lc_ref = rg_a;
  while ( *lc_ref != NULL )
  {
    lc_ref = &((*lc_ref)->nex);
  }
  
  // And then we add a copy of the string - as a new element
  // to the linked list.
  *lc_ref = chorebox_mlc(sizeof(chorebox_str_list));
  (*lc_ref)->nex = NULL;
  (*lc_ref)->str = chorebox_join_string(rg_b,NULL);
  return true;
}

