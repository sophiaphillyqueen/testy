// chorebox-in - The 'chorebox' wrapper for -configure- scripts.
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

bool autodetect_home_bin_dir ( char **rg_a )
{
  char *lc_path_string;
  chorebox_str_list *lc_path_list;
  chorebox_str_list *lc_path_point;
  char *lc_tryout;
  char *lc_winner;
  
  // Let us do some local-variable initializations
  lc_path_string = NULL;
  lc_path_list = NULL;
  lc_path_point = NULL;
  lc_tryout = NULL;
  lc_winner = NULL;
  
  // First it gets the list of path directories:
  lc_path_string = getenv("PATH");
  lc_path_list = chorebox_colsep_to_list(lc_path_string);
  
  
  // Now beginneth the loop where we check one item at
  // a time for what we seek:
  lc_path_point = lc_path_list;
  while ( lc_winner == NULL )
  {
    
    // If we reach the end without finding it, let us
    // concede defeat without wasting memory.
    if ( lc_path_point == NULL )
    {
      chorebox_free_str_list(lc_path_list);
      return false;
    }
    
    // But let us see if the current item is the right one ...
    lc_tryout = lc_path_point->str;
    if ( own_this_dir(lc_tryout) ) { lc_winner = lc_tryout; }
    
    // ... before moving on to the next item.
    lc_path_point = lc_path_point->nex;
  }
  
  
  // If we got this far -- then the search was a success.
  // But before exiting, we need to register the value
  // of the result.
  if ( (*rg_a) != NULL ) { free(*rg_a); }
  *rg_a = chorebox_join_string(lc_winner,NULL);
  
  
  // Let us not waste memory.
  chorebox_free_str_list(lc_path_list);
  return true;
}


