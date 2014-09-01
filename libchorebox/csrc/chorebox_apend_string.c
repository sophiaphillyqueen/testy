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


char *chorebox_apend_string ( char **rg_a, char *rg_b )
{
  char *lc_temporar;
  
  lc_temporar = chorebox_join_string(*rg_a,rg_b);
  if ( (*rg_a) != NULL ) { free(*rg_a); }
  *rg_a = lc_temporar;
  
  return lc_temporar;
}


