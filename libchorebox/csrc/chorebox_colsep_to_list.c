
// libchorebox - A high-level C programming library for -chorebox-
// chorebox_colsep_to_list.c - Source-code for this function:
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


chorebox_str_list *chorebox_colsep_to_list ( char *rg_a )
{
  size_t lc_buf_size;
  char *lc_tmp_buf;
  chorebox_str_list *lc_bgn_list;
  chorebox_str_list **lc_ref_list;
  char *lc_cp_src;
  char *lc_cp_dst;
  char lc_cp_chr;
  
  // INITIALIZATIONS:
  lc_bgn_list = NULL;
  lc_ref_list = &lc_bgn_list;
  lc_cp_src = rg_a;
  
  // The only thing that can make this function return a
  // NULL (other than an empty string or something) is if
  // it is fed a NULL.
  if ( rg_a == NULL ) { return NULL; }
  
  // In allocating the temporary buffer, we are glad that
  // no element will be larger in length that the source
  // list-string.
  lc_buf_size = strlen(rg_a);
  lc_buf_size++;
  lc_buf_size *= sizeof(char);
  lc_tmp_buf = chorebox_mlc(lc_buf_size);
  
  // Now cometh the loop that we go through for each item
  // on the list:
  while ( *lc_cp_src != '\0' )
  {
    lc_cp_dst = lc_tmp_buf;
    lc_cp_chr = 'x';
    
    // First we copy the relevant sub-string:
    while ( lc_cp_chr != '\0' )
    {
      lc_cp_chr = *lc_cp_src;
      if ( lc_cp_chr == ':' ) { lc_cp_chr = '\0'; }
      *lc_cp_dst = lc_cp_chr;
      lc_cp_src++;
      lc_cp_dst++;
    }
    
    // And if it's non-empty, we add the element to
    // the new-format list.
    if ( *lc_tmp_buf != '\0' )
    {
      *lc_ref_list = chorebox_mlc(sizeof(chorebox_str_list));
      (*lc_ref_list)->str = chorebox_join_string(lc_tmp_buf,NULL);
      lc_ref_list = &((*lc_ref_list)->nex);
      *lc_ref_list = NULL;
    }
  }
  
  
  // Of course -- before returning, we must free the
  // temporary buffer.
  free(lc_tmp_buf);
  
  // Now we return the list, from it's beginning, to the
  // calling program.
  return lc_bgn_list;
}

