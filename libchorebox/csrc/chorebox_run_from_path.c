// libchorebox - A high-level C programming library for -chorebox-
// chorebox_run_from_path.c - Source-code for this function:
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

char *chorebox_run_from_path ( char *rg_a, char *rg_b )
{
  char *lc_tracer;
  char *lc_candidate;
  chorebox_str_list *lc_search_path;
  chorebox_str_list *lc_search_place;
  bool lc_success;
  
  // INITIALIZATIONS:
  lc_candidate = NULL;
  
  // Fails by default if fed a NULL.
  if ( rg_a == NULL ) { return rg_a; }
  
  // Not much to it if there's a '/' in it.
  lc_tracer = rg_a;
  while ( *lc_tracer != '\0' )
  {
    if ( *lc_tracer == '/' )
    {
      return ( chorebox_join_string(rg_a,NULL) );
    }
    lc_tracer++;
  }
  
  // Of course, if things were not that easily resolved,
  // the first thing we need is a better format for the
  // search path.
  lc_search_path = chorebox_colsep_to_list(rg_b);
  
  // Now we keep checking each candidate -- until either
  // we reach the end of the list or we find what we are
  // looking for.
  lc_search_place = lc_search_path;
  while ( lc_search_place != NULL )
  {
    chorebox_apend_string(&lc_candidate,(lc_search_place->str));
    chorebox_apend_string(&lc_candidate,"/");
    chorebox_apend_string(&lc_candidate,rg_a);
    
    lc_success = chorebox_check_cmd_file(lc_candidate);
    if ( lc_success ) { lc_search_place = NULL; }
    else { chorebx_free_dyn_string(&lc_candidate); }
    
    if ( lc_search_place != NULL )
    {
      lc_search_place = lc_search_place->nex;
    }
  }
  
  // The last candidate standing wins.
  chorebox_free_str_list(lc_search_path);
  return(lc_candidate);
}
