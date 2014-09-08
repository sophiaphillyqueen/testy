// chorebox-in - The 'chorebox' wrapper for -configure- scripts.
// if_not_specified.c - Source-code for this function:
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

bool if_not_specified ( char *rg_a, char *rg_b )
{
  char *lc_arg_represen;
  chorebox_str_list *lc_packet_list;
  // INITIALIZATIONS:
  lc_arg_represen = NULL;
  
  // Now obviously - no point in continuing if the var *is*
  // specified .... as in that event, the function fails,
  // yet returns to *report* the failure.
  if ( specified_var_option(rg_a) ) { return false; }
  
  // Now (if we are still in this function) our next
  // task is to assemble the argument representation of
  // the variable we seek to add.
  chorebox_apend_string(&lc_arg_represen,"--");
  chorebox_apend_string(&lc_arg_represen,rg_a);
  chorebox_apend_string(&lc_arg_represen,"=");
  chorebox_apend_string(&lc_arg_represen,rg_b);
  
  // And we now, with that representation, create a
  // one-element list of strings.
  lc_packet_list = chorebox_mlc(sizeof(chorebox_str_list));
  lc_packet_list->nex = NULL;
  lc_packet_list->str = lc_arg_represen;
  
  // Finally, we dump that newly created list of strings
  // (with just one item on it) to the <myown_options>
  // list.
  chorebox_str_lis_dump(&lc_packet_list,&myown_options);
  
  // Mission accomplished!!!
  return true;
}

