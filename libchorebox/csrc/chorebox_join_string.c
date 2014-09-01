// chorebox - A high-level C programming library
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
#include <string.h>

char *chorebox_join_string ( char *rg_a, char *rg_b )
{
  size_t lc_neosiz;
  char *lc_neobuf;
  char *lc_neoptr;
  char *lc_oleptr;
  
  // Remember NULL is returned if and *only* if both source
  // strings are NULL.
  if ( ( rg_a == NULL ) && ( rg_b == NULL ) ) { return NULL; }
  
  // Find the size of the destiny buffer:
  lc_neosiz = 1; // Add 1 for terminal character:
  if ( rg_a != NULL ) { lc_neosiz += strlen(rg_a); }
  if ( rg_b != NULL ) { lc_neosiz += strlen(rg_b); }
  lc_neosiz *= (sizeof(char)); // No hasty assumptions on size of char
  
  // Let's create the buffer
  lc_neobuf = chorebox_mlc(lc_neosiz);
  lc_neoptr = lc_neobuf;
  
  // Copy first string:
  if ( rg_a != NULL )
  {
    lc_oleptr = rg_a;
    while ( *lc_oleptr != '\0' )
    {
      *lc_neoptr = *lc_oleptr;
      lc_neoptr++;
      lc_oleptr++;
    }
  }
  
  // Copy second string:
  if ( rg_b != NULL )
  {
    lc_oleptr = rg_b;
    while ( *lc_oleptr != '\0' )
    {
      *lc_neoptr = *lc_oleptr;
      lc_neoptr++;
      lc_oleptr++;
    }
  }
  
  // Terminate and return.
  *lc_neoptr = '\0';
  return(lc_neobuf);
}


