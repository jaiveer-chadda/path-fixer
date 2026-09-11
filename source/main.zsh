#!/usr/bin/env zsh

function fix-path-cap10n() {
  local -r pwd_="$PWD" adj_="${PWD:A}"

  # they're the same path - all is well
  if [[ "$pwd_" == "$adj_" ]] return

  # note: these two checks should be fixed at some point
  # lengths are different - we can't do anything about that atm
  if (( $#pwd_ != $#adj_ )) return
  # if they're different when lowercase, then there's nth we can do either
  if [[ "${(L)pwd_}" != "${(L)adj_}" ]] return

  cd -q "${PWD:A}"  # there was a cap10n issue in `$PWD` - fix it
  shift dirstack  # and remove the incorrect version from the dirstack
}

# ——————————————————————————————————————————————————————————————————————————— #

# remove the function from `$chpwd_functions` if it exists there
add-zsh-hook -d chpwd fix-path-cap10n
# then add it back, at the beginning of the array
chpwd_functions=( fix-path-cap10n "${(@)chpwd_functions}" )
