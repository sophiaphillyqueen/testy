
say_yes=yes
say_no=no
say_on=on
say_off=off
say_irp=irp
# "irp" is short for "If Resources Permit"

cur_status=off

# First, let us see if we adjust the cur_status from the --devel_main option:
cur_prize="--devel_main"
leng_var_p1=12

# Copy-paste the following block for every option we search.
leng_var_p2="$(expr "${leng_var_p1}" + 1)"
leng_var_p3="$(expr "${leng_var_p2}" + 1)"
leng_var_x1="$(expr "${leng_var_p3}" + 10)"
cur_priz_e="${cur_prize}="
for an_opt in "${@}"; do
  if [ $an_opt = $cur_prize ]; then
    cur_status=irp
  else
    an_equa="$(echo "${an_opt}" | cut -b 1-"${leng_var_p2}")"
    if [ $an_equa = $cur_priz_e ]; then
      cur_status="$(echo "${an_opt}" | cut -b "${leng_var_p3}"-"${leng_var_x1}")"
    fi
  fi
done


# And now we do the same check for the --devel_e
cur_prize="--devel_e"
leng_var_p1=9

# Copy-paste the following block for every option we search.
leng_var_p2="$(expr "${leng_var_p1}" + 1)"
leng_var_p3="$(expr "${leng_var_p2}" + 1)"
leng_var_x1="$(expr "${leng_var_p3}" + 10)"
cur_priz_e="${cur_prize}="
for an_opt in "${@}"; do
  if [ $an_opt = $cur_prize ]; then
    cur_status=irp
  else
    an_equa="$(echo "${an_opt}" | cut -b 1-"${leng_var_p2}")"
    if [ $an_equa = $cur_priz_e ]; then
      cur_status="$(echo "${an_opt}" | cut -b "${leng_var_p3}"-"${leng_var_x1}")"
    fi
  fi
done


# And now we do the same check for the --devel_e_c
cur_prize="--devel_e_c"
leng_var_p1=11

# Copy-paste the following block for every option we search.
leng_var_p2="$(expr "${leng_var_p1}" + 1)"
leng_var_p3="$(expr "${leng_var_p2}" + 1)"
leng_var_x1="$(expr "${leng_var_p3}" + 10)"
cur_priz_e="${cur_prize}="
for an_opt in "${@}"; do
  if [ $an_opt = $cur_prize ]; then
    cur_status=irp
  else
    an_equa="$(echo "${an_opt}" | cut -b 1-"${leng_var_p2}")"
    if [ $an_equa = $cur_priz_e ]; then
      cur_status="$(echo "${an_opt}" | cut -b "${leng_var_p3}"-"${leng_var_x1}")"
    fi
  fi
done


# Now we determine behavior based on $cur_status
cur_survive=yes
cur_known=no
if [ $cur_status = $say_on ]; then
  cur_survive=no
  cur_known=yes
fi
if [ $cur_status = $say_off ]; then
  cur_survive=yes
  cur_known=yes
fi
if [ $cur_status = $say_irp ]; then
  cur_survive=no
  cur_known=yes
fi




# Now we determine the contents of the extra-options-field:
rm -rf temporary--extra-options-compile.txt
touch temporary--extra-options-compile.txt
if [ $cur_survive = $say_no ]; then
  echo "-Wall" >> temporary--extra-options-compile.txt
  echo "-Werror" >> temporary--extra-options-compile.txt
fi

