#!/bin/zsh


function "run_${$(basename "$(readlink -f "${(%):-%x}")")%%.*}"(){

  local script_dir_func="script_dir_${${(%):-%N}%%.*}"
  local declare "${script_dir_func}"="$(cd "$(dirname "$(readlink -f "${(%):-%x}")")" >/dev/null 2>&1 && pwd)"
  . "${(P)script_dir_func}/zsh_ar18_lib/ar18.sh"
  
  local vars_needed=(\
    module_name\
    working_dir_path\
    git_backup_path\
  )
    
  ar18__script__check_vars_needed "${vars_needed[@]}"
  
  ar18__log__info "Installing" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 
  
  . "${(P)script_dir_func}/uninstall.sh"
  
  pushd
   
  rm -rf "${working_dir_path}/${module_name}" || ar18__log__warn "folder did not exist" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}"
  cd "${working_dir_path}"
  git clone https://github.com/Alcaro/GitBSLR.git
  cd "${working_dir_path}/${module_name}"
  #ar18__file__replace "./install.sh" 'TARGET="\$HOME/bin"' "TARGET=\"${install_parent_dir}/${module_name}\""
  #ar18__file__replace "./install.sh" 'TARGET' "FARGET"
  #TARGET="$HOME/bin"
  
  "./install.sh"
  cd "${working_dir_path}"
  rm -rf "${working_dir_path}/${module_name}" || ar18__log__warn "folder did not exist" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}"
  popd
  mv '/usr/bin/git' "${git_backup_path}" || rm "/usr/bin/git"
  ln -s "/usr/local/bin/git" "/usr/bin/git"
  ar18__file__replace '/usr/local/bin/git' "exec /usr/bin/git" "exec ${git_backup_path}"
  
  chmod +x '/usr/local/bin/git'
  
  ar18__log__info "Finished installing" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}"
  
  GITBSLR_DEBUG=1 git version

}


"run_${$(basename "$(readlink -f "${(%):-%x}")")%%.*}"