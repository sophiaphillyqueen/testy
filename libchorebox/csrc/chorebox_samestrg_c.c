// libchorebox - A high-level C programming library for -chorebox-
// chorebox_samestrg_c.c - Source-code for this function:
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

bool chorebox_samestrg_c ( char *rg_a, char *rg_b )
{
  char *lc_trca;
  char *lc_trcb;
  if ( rg_a == rg_b ) { return true; }
  if ( rg_a == NULL ) { return false; }
  if ( rg_b == NULL ) { return false; }
  
  lc_trca = rg_a;
  lc_trcb = rg_b;
  while ( (*lc_trca) != '\0' )
  {
    if ( (*lc_trca) != (*lc_trcb) ) { return false; }
    lc_trca++;
    lc_trcb++;
  }
  return ( (*lc_trca) == (*lc_trcb) );
}

