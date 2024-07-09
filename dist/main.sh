#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)

function file_exist__5_v0 {
    local path=$1
    [ -f "${path}" ]
__AS=$?;
if [ $__AS != 0 ]; then
        __AF_file_exist5_v0=0;
        return 0
fi
    __AF_file_exist5_v0=1;
    return 0
}
function file_read__6_v0 {
    local path=$1
    __AMBER_VAL_0=$(cat "${path}");
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_file_read6_v0=''
return $__AS
fi;
    __AF_file_read6_v0="${__AMBER_VAL_0}";
    return 0
}
function file_write__7_v0 {
    local path=$1
    local content=$2
    __AMBER_VAL_1=$(echo "${content}" > "${path}");
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_file_write7_v0=''
return $__AS
fi;
    __AF_file_write7_v0="${__AMBER_VAL_1}";
    return 0
}
function trim_left__13_v0 {
    local text=$1
    __AMBER_VAL_2=$(echo "${text}" | sed -e 's/^[[:space:]]*//');
    __AS=$?;
    __AF_trim_left13_v0="${__AMBER_VAL_2}";
    return 0
}
function trim_right__14_v0 {
    local text=$1
    __AMBER_VAL_3=$(echo "${text}" | sed -e 's/[[:space:]]*$//');
    __AS=$?;
    __AF_trim_right14_v0="${__AMBER_VAL_3}";
    return 0
}
function trim__15_v0 {
    local text=$1
    trim_right__14_v0 "${text}";
    __AF_trim_right14_v0__74="${__AF_trim_right14_v0}";
    trim_left__13_v0 "${__AF_trim_right14_v0__74}";
    __AF_trim_left13_v0__74="${__AF_trim_left13_v0}";
    __AF_trim15_v0="${__AF_trim_left13_v0__74}";
    return 0
}
function upper__17_v0 {
    local text=$1
    __AMBER_VAL_4=$(echo "${text}" | tr '[:lower:]' '[:upper:]');
    __AS=$?;
    __AF_upper17_v0="${__AMBER_VAL_4}";
    return 0
}
function len__18_v0 {
    local value=$1
            if [ 1 != 0 ]; then
            __AMBER_VAL_5=$(echo "${#value}");
            __AS=$?;
            __AF_len18_v0="${__AMBER_VAL_5}";
            return 0
else
            __AMBER_VAL_6=$(echo "${#value[@]}");
            __AS=$?;
            __AF_len18_v0="${__AMBER_VAL_6}";
            return 0
fi
}
function len__18_v1 {
    local value=("${!1}")
            if [ 0 != 0 ]; then
            __AMBER_VAL_7=$(echo "${#value}");
            __AS=$?;
            __AF_len18_v1="${__AMBER_VAL_7}";
            return 0
else
            __AMBER_VAL_8=$(echo "${#value[@]}");
            __AS=$?;
            __AF_len18_v1="${__AMBER_VAL_8}";
            return 0
fi
}
__0_log_level=""
__AMBER_ARRAY_0=("DEBUG" "INFO" "WARN" "ERROR");
__1_levels=("${__AMBER_ARRAY_0[@]}")
__2_log_file="/dev/stderr"
__3_max_module_name_len=4
__AMBER_ARRAY_1=("log");
__4_md=("${__AMBER_ARRAY_1[@]}")
function echo_log__32_v0 {
    local level=$1
    local module_name=$2
    local text=$3
    __AMBER_VAL_9=$(date);
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "Failed to get date"
fi;
    local date="${__AMBER_VAL_9}"
    local level_name="${level}"
    while :
do
        len__18_v0 "${level_name}";
        __AF_len18_v0__17=$__AF_len18_v0;
        if [ $(echo $__AF_len18_v0__17 '<' 5 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            level_name+=" "
else
            break
fi
done
    local module_name_extended="${module_name}"
    len__18_v0 "${module_name_extended}";
    __AF_len18_v0__24=$__AF_len18_v0;
    if [ $(echo $__AF_len18_v0__24 '>' ${__3_max_module_name_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        len__18_v0 "${module_name_extended}";
        __AF_len18_v0__25=$__AF_len18_v0;
        __3_max_module_name_len=$__AF_len18_v0__25
fi
    while :
do
        len__18_v0 "${module_name_extended}";
        __AF_len18_v0__28=$__AF_len18_v0;
        if [ $(echo $__AF_len18_v0__28 '<' ${__3_max_module_name_len} | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            module_name_extended+=" "
else
            break
fi
done
            echo "[${level_name}] [${module_name_extended}] [${date}] ${text}" > ${__2_log_file}
__AS=$?
}
function log__33_v0 {
    local level=$1
    local module_name=$2
    local text=$3
    if [ $([ "_${level}" != "_${__0_log_level}" ]; echo $?) != 0 ]; then
        echo_log__32_v0 "${level}" "${module_name}" "${text}";
        __AF_echo_log32_v0__39=$__AF_echo_log32_v0;
        echo $__AF_echo_log32_v0__39 > /dev/null 2>&1
else
        local print=0
        local log_level_reached=0
        index=0;
for array_level in "${__1_levels[@]}"
do
            if [ $([ "_${array_level}" != "_${__0_log_level}" ]; echo $?) != 0 ]; then
                log_level_reached=1
fi
            if [ $([ "_${array_level}" != "_${level}" ]; echo $?) != 0 ]; then
                if [ $(echo ${log_level_reached} '==' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    print=1
fi
                break
fi
            (( index++ )) || true
done
        if [ $(echo ${print} '==' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
            echo_log__32_v0 "${level}" "${module_name}" "${text}";
            __AF_echo_log32_v0__55=$__AF_echo_log32_v0;
            echo $__AF_echo_log32_v0__55 > /dev/null 2>&1
fi
fi
}
function l__34_v0 {
    local module_data=("${!1}")
    local level=$2
    local text=$3
    log__33_v0 "${level}" "${module_data[0]}" "${text}";
    __AF_log33_v0__60=$__AF_log33_v0;
    echo $__AF_log33_v0__60 > /dev/null 2>&1
}
function lf__35_v0 {
    local module_data=("${!1}")
    local s=$2
    local level=$3
    local text=$4
    log__33_v0 "${level}" "${module_data[0]}" "${text}";
    __AF_log33_v0__64=$__AF_log33_v0;
    echo $__AF_log33_v0__64 > /dev/null 2>&1
            __AF_lf35_v0='';
        return ${s}
}
function init_log_module_data__36_v0 {
    local module_name=$1
    __AMBER_ARRAY_2=("${module_name}");
    __AF_init_log_module_data36_v0=("${__AMBER_ARRAY_2[@]}");
    return 0
}
function init_log__38_v0 {
    if [ $([ "_${__0_log_level}" != "_" ]; echo $?) != 0 ]; then
        __AMBER_VAL_10=$(printenv LOG_LEVEL);
        __AS=$?;
if [ $__AS != 0 ]; then
            __0_log_level="INFO"
fi;
        __0_log_level="${__AMBER_VAL_10}"
        if [ $([ "_${__0_log_level}" != "_" ]; echo $?) != 0 ]; then
            __0_log_level="INFO"
fi
fi
    trim__15_v0 "${__0_log_level}";
    __AF_trim15_v0__85="${__AF_trim15_v0}";
    upper__17_v0 "${__AF_trim15_v0__85}";
    __AF_upper17_v0__85="${__AF_upper17_v0}";
    __0_log_level="${__AF_upper17_v0__85}"
    __AMBER_VAL_11=$(printenv LOG_FILE);
    __AS=$?;
    local log_file_path="${__AMBER_VAL_11}"
    if [ $([ "_${log_file_path}" == "_" ]; echo $?) != 0 ]; then
        __2_log_file="${log_file_path}"
fi
    local matched=0
    index=0;
for array_level in "${__1_levels[@]}"
do
        if [ $([ "_${__0_log_level}" != "_${array_level}" ]; echo $?) != 0 ]; then
            matched=1
fi
        (( index++ )) || true
done
    if [ $(echo ${matched} '!=' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        __0_log_level="INFO"
        l__34_v0 __4_md[@] "WARN" "Unknown log level '${__0_log_level}', using INFO";
        __AF_l34_v0__100=$__AF_l34_v0;
        echo $__AF_l34_v0__100 > /dev/null 2>&1
fi
    l__34_v0 __4_md[@] "DEBUG" "LOG_LEVEL: ${__0_log_level}, LOG_FILE: ${__2_log_file}";
    __AF_l34_v0__103=$__AF_l34_v0;
    echo $__AF_l34_v0__103 > /dev/null 2>&1
}
init_log_module_data__36_v0 "utils";
__AF_init_log_module_data36_v0__3=("${__AF_init_log_module_data36_v0[@]}");
__5_md=("${__AF_init_log_module_data36_v0__3[@]}")
function load_env_file__42_v0 {
            export "$(xargs < .env)" > /dev/null
__AS=$?
}
function fail_if_command_not_found__43_v0 {
    local bin_name=$1
            command -v ${bin_name} > /dev/null 2>&1
__AS=$?
    if [ $(echo $__AS '!=' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        l__34_v0 __5_md[@] "ERROR" "Required package ${bin_name} not found, cannot continue. Please install it before running again.";
        __AF_l34_v0__12=$__AF_l34_v0;
        echo $__AF_l34_v0__12 > /dev/null 2>&1
        __AF_fail_if_command_not_found43_v0='';
        return $__AS
fi
}
function fail_if_commands_not_found__44_v0 {
    local bin_names=("${!1}")
    index=0;
for name in "${bin_names[@]}"
do
        fail_if_command_not_found__43_v0 "${name}";
        __AS=$?;
if [ $__AS != 0 ]; then
__AF_fail_if_commands_not_found44_v0=''
return $__AS
fi;
        __AF_fail_if_command_not_found43_v0__19=$__AF_fail_if_command_not_found43_v0;
        echo $__AF_fail_if_command_not_found43_v0__19 > /dev/null 2>&1
        (( index++ )) || true
done
}
function get_required_env__45_v0 {
    local env_name=$1
    __AMBER_VAL_12=$(printenv ${env_name});
    __AS=$?;
if [ $__AS != 0 ]; then
                    lf__35_v0 __5_md[@] $__AS "ERROR" "Environment variable ${env_name} is not set, but required.";
            __AS=$?;
            __AF_lf35_v0__25=$__AF_lf35_v0;
            echo $__AF_lf35_v0__25 > /dev/null 2>&1
        __AF_get_required_env45_v0='';
        return $__AS
fi;
    local val="${__AMBER_VAL_12}"
    if [ $([ "_${val}" != "_" ]; echo $?) != 0 ]; then
                    lf__35_v0 __5_md[@] 1 "ERROR" "Environment variable ${env_name} is set, but it is empty.";
            __AS=$?;
            __AF_lf35_v0__29=$__AF_lf35_v0;
            echo $__AF_lf35_v0__29 > /dev/null 2>&1
        __AF_get_required_env45_v0='';
        return 1
fi
    __AF_get_required_env45_v0="${val}";
    return 0
}
function get_default_env__46_v0 {
    local env_name=$1
    local default=$2
    get_required_env__45_v0 "${env_name}";
    __AS=$?;
if [ $__AS != 0 ]; then
        local val="${default}"
fi;
    __AF_get_required_env45_v0__36="${__AF_get_required_env45_v0}";
    local val="${__AF_get_required_env45_v0__36}"
    __AF_get_default_env46_v0="${val}";
    return 0
}
init_log_module_data__36_v0 "requests";
__AF_init_log_module_data36_v0__3=("${__AF_init_log_module_data36_v0[@]}");
__6_md=("${__AF_init_log_module_data36_v0__3[@]}")
function request_get__54_v0 {
    local url=$1
    l__34_v0 __6_md[@] "INFO" "GET to ${url}";
    __AF_l34_v0__6=$__AF_l34_v0;
    echo $__AF_l34_v0__6 > /dev/null 2>&1
    __AMBER_VAL_13=$(curl -m 2 ${url} 2>/dev/null);
    __AS=$?;
if [ $__AS != 0 ]; then
                    lf__35_v0 __6_md[@] $__AS "ERROR" "GET to ${url} failed";
            __AS=$?;
            __AF_lf35_v0__8=$__AF_lf35_v0;
            echo $__AF_lf35_v0__8 > /dev/null 2>&1
        __AF_request_get54_v0='';
        return $__AS
fi;
    local answer="${__AMBER_VAL_13}"
    __AF_request_get54_v0="${answer}";
    return 0
}
init_log_module_data__36_v0 "main";
__AF_init_log_module_data36_v0__7=("${__AF_init_log_module_data36_v0[@]}");
__7_md=("${__AF_init_log_module_data36_v0__7[@]}")
function print_user_keys__60_v0 {
    local json=$1
    local username=$2
            echo ${json} | jq -r ".${username}.[]" | xargs -I {} echo {}
__AS=$?
}
args=("$@")
    file_exist__5_v0 ".env";
    __AF_file_exist5_v0__14=$__AF_file_exist5_v0;
    if [ $__AF_file_exist5_v0__14 != 0 ]; then
        load_env_file__42_v0 ;
        __AF_load_env_file42_v0__15=$__AF_load_env_file42_v0;
        echo $__AF_load_env_file42_v0__15 > /dev/null 2>&1
fi
    init_log__38_v0 ;
    __AF_init_log38_v0__16=$__AF_init_log38_v0;
    echo $__AF_init_log38_v0__16 > /dev/null 2>&1
    len__18_v1 args[@];
    __AF_len18_v1__18=$__AF_len18_v1;
    if [ $(echo $__AF_len18_v1__18 '!=' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        l__34_v0 __7_md[@] "ERROR" "Invalid argument count passed. Expected 1 argument - username.";
        __AF_l34_v0__19=$__AF_l34_v0;
        echo $__AF_l34_v0__19 > /dev/null 2>&1
        exit 1
fi
    __AMBER_ARRAY_3=("curl" "jq" "bc" "sed" "date");
    fail_if_commands_not_found__44_v0 __AMBER_ARRAY_3[@];
    __AS=$?;
if [ $__AS != 0 ]; then

exit $__AS
fi;
    __AF_fail_if_commands_not_found44_v0__23=$__AF_fail_if_commands_not_found44_v0;
    echo $__AF_fail_if_commands_not_found44_v0__23 > /dev/null 2>&1
    get_required_env__45_v0 "SERVER_URL";
    __AS=$?;
if [ $__AS != 0 ]; then

exit $__AS
fi;
    __AF_get_required_env45_v0__25="${__AF_get_required_env45_v0}";
    server_url="${__AF_get_required_env45_v0__25}"
    get_default_env__46_v0 "USERS_PATH" "/var/authorize_me/users.json";
    __AF_get_default_env46_v0__26="${__AF_get_default_env46_v0}";
    users_path="${__AF_get_default_env46_v0__26}"
    is_local=0
    request_get__54_v0 "${server_url}";
    __AS=$?;
if [ $__AS != 0 ]; then
        users_json=""
        l__34_v0 __7_md[@] "INFO" "Request failed, falling back to local cache";
        __AF_l34_v0__31=$__AF_l34_v0;
        echo $__AF_l34_v0__31 > /dev/null 2>&1
fi;
    __AF_request_get54_v0__29="${__AF_request_get54_v0}";
    users_json="${__AF_request_get54_v0__29}"
    if [ $([ "_${users_json}" != "_" ]; echo $?) != 0 ]; then
        file_exist__5_v0 "${users_path}";
        __AF_file_exist5_v0__34=$__AF_file_exist5_v0;
        if [ $__AF_file_exist5_v0__34 != 0 ]; then
            file_read__6_v0 "${users_path}";
            __AS=$?;
if [ $__AS != 0 ]; then
                                    lf__35_v0 __7_md[@] $__AS "ERROR" "Failed to read USERS_PATH with status $__AS";
                    __AS=$?;
                    __AF_lf35_v0__36=$__AF_lf35_v0;
                    echo $__AF_lf35_v0__36 > /dev/null 2>&1
                exit $__AS
fi;
            __AF_file_read6_v0__35="${__AF_file_read6_v0}";
            users_json="${__AF_file_read6_v0__35}"
            is_local=1
else
                            lf__35_v0 __7_md[@] $__AS "ERROR" "USERS_PATH doesn't exist and server is not available, exiting";
                __AS=$?;
                __AF_lf35_v0__41=$__AF_lf35_v0;
                echo $__AF_lf35_v0__41 > /dev/null 2>&1
            exit 1
fi
fi
    print_user_keys__60_v0 "${users_json}" "${args[0]}";
    __AF_print_user_keys60_v0__46=$__AF_print_user_keys60_v0;
    echo $__AF_print_user_keys60_v0__46 > /dev/null 2>&1
    if [ $(echo ${is_local} '==' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        l__34_v0 __7_md[@] "INFO" "Saved USERS_PATH";
        __AF_l34_v0__49=$__AF_l34_v0;
        echo $__AF_l34_v0__49 > /dev/null 2>&1
        file_write__7_v0 "${users_path}" "${users_json}";
        __AS=$?;
if [ $__AS != 0 ]; then
                            lf__35_v0 __7_md[@] $__AS "ERROR" "Failed to save USERS_PATH with status $__AS";
                __AS=$?;
                __AF_lf35_v0__51=$__AF_lf35_v0;
                echo $__AF_lf35_v0__51 > /dev/null 2>&1
            exit $__AS
fi;
        __AF_file_write7_v0__50="${__AF_file_write7_v0}";
        echo "${__AF_file_write7_v0__50}" > /dev/null 2>&1
else
        l__34_v0 __7_md[@] "INFO" "Not writing USERS_PATH because server is not available";
        __AF_l34_v0__55=$__AF_l34_v0;
        echo $__AF_l34_v0__55 > /dev/null 2>&1
fi