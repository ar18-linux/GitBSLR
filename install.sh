. "${script_dir}/zsh_ar18_lib/ar18.sh"

vars_needed=(\
  module_name\
  working_dir_path\
  git_backup_path\
)
  
ar18__script__check_vars_needed "${vars_needed[@]}"

ar18__log__info "Installing" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 

"${script_dir}/uninstall.sh"

ar18__log__dbg "foo" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 

pushd

cd "${working_dir_path}"
rm -rf "${module_name}" || ar18__log__warn "folder did not exist" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 
git clone https://github.com/Alcaro/GitBSLR.git
cd "${module_name}"
#ar18__file__replace "./install.sh" 'TARGET="\$HOME/bin"' "TARGET=\"${install_parent_dir}/${module_name}\""
#ar18__file__replace "./install.sh" 'TARGET' "FARGET"
#TARGET="$HOME/bin"
"./install.sh"
cd ..
rm -rf "${module_name}" || ar18__log__warn "folder did not exist" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}"
popd
mv '/usr/bin/git' "${git_backup_path}" || rm "/usr/bin/git"
ln -s "/usr/local/bin/git" "/usr/bin/git"
ar18__file__replace '/usr/local/bin/git' "exec /usr/bin/git" "exec ${git_backup_path}"

chmod +x '/usr/local/bin/git'

ar18__log__info "Finished installing" "$((${funcsourcetrace[-1]#*:} + LINENO))" "${"$(readlink -f "${(%):-%x}" | awk -F/ '{print $(NF-1) "/" $NF}')"}" 
