. "${script_dir}/zsh_ar18lib/ar18.sh"

vars_needed=(\
  module_name\
  working_dir_path\
  git_backup_path\
)
  
ar18__script__check_vars_needed "${vars_needed[@]}"

ar18__log__info "Uninstalling" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 

if [[ -f "${git_backup_path}" ]]; then
  rm '/usr/bin/git'
  mv "${git_backup_path}" '/usr/bin/git'
fi

rm '/usr/local/bin/git' || ar18__log__warn "file did not exist" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 
rm '/usr/local/bin/gitbslr.so' || ar18__log__warn "file did not exist" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 

ar18__log__info "Finished uninstalling" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 
