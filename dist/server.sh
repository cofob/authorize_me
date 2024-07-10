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
function lines__10_v0 {
    local text=$1
    __AMBER_ARRAY_0=();
    local result=("${__AMBER_ARRAY_0[@]}")
            IFS=$'
' read -rd '' -a result <<<"$text"
__AS=$?
    __AF_lines10_v0=("${result[@]}");
    return 0
}
function trim_left__13_v0 {
    local text=$1
    __AMBER_VAL_1=$(echo "${text}" | sed -e 's/^[[:space:]]*//');
    __AS=$?;
    __AF_trim_left13_v0="${__AMBER_VAL_1}";
    return 0
}
function trim_right__14_v0 {
    local text=$1
    __AMBER_VAL_2=$(echo "${text}" | sed -e 's/[[:space:]]*$//');
    __AS=$?;
    __AF_trim_right14_v0="${__AMBER_VAL_2}";
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
    __AMBER_VAL_3=$(echo "${text}" | tr '[:lower:]' '[:upper:]');
    __AS=$?;
    __AF_upper17_v0="${__AMBER_VAL_3}";
    return 0
}
function len__18_v0 {
    local value=$1
            if [ 1 != 0 ]; then
            __AMBER_VAL_4=$(echo "${#value}");
            __AS=$?;
            __AF_len18_v0="${__AMBER_VAL_4}";
            return 0
else
            __AMBER_VAL_5=$(echo "${#value[@]}");
            __AS=$?;
            __AF_len18_v0="${__AMBER_VAL_5}";
            return 0
fi
}
function len__18_v1 {
    local value=("${!1}")
            if [ 0 != 0 ]; then
            __AMBER_VAL_6=$(echo "${#value}");
            __AS=$?;
            __AF_len18_v1="${__AMBER_VAL_6}";
            return 0
else
            __AMBER_VAL_7=$(echo "${#value[@]}");
            __AS=$?;
            __AF_len18_v1="${__AMBER_VAL_7}";
            return 0
fi
}
__0_log_level=""
__AMBER_ARRAY_1=("DEBUG" "INFO" "WARN" "ERROR");
__1_levels=("${__AMBER_ARRAY_1[@]}")
__2_log_file="/dev/stderr"
__3_max_module_name_len=4
__AMBER_ARRAY_2=("log");
__4_md=("${__AMBER_ARRAY_2[@]}")
function echo_log__32_v0 {
    local level=$1
    local module_name=$2
    local text=$3
    __AMBER_VAL_8=$(date);
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "Failed to get date"
fi;
    local date="${__AMBER_VAL_8}"
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
    __AMBER_ARRAY_3=("${module_name}");
    __AF_init_log_module_data36_v0=("${__AMBER_ARRAY_3[@]}");
    return 0
}
function init_log__38_v0 {
    if [ $([ "_${__0_log_level}" != "_" ]; echo $?) != 0 ]; then
        __AMBER_VAL_9=$(printenv LOG_LEVEL);
        __AS=$?;
if [ $__AS != 0 ]; then
            __0_log_level="INFO"
fi;
        __0_log_level="${__AMBER_VAL_9}"
        if [ $([ "_${__0_log_level}" != "_" ]; echo $?) != 0 ]; then
            __0_log_level="INFO"
fi
fi
    trim__15_v0 "${__0_log_level}";
    __AF_trim15_v0__85="${__AF_trim15_v0}";
    upper__17_v0 "${__AF_trim15_v0__85}";
    __AF_upper17_v0__85="${__AF_upper17_v0}";
    __0_log_level="${__AF_upper17_v0__85}"
    __AMBER_VAL_10=$(printenv LOG_FILE);
    __AS=$?;
    local log_file_path="${__AMBER_VAL_10}"
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
    __AMBER_VAL_11=$(printenv ${env_name});
    __AS=$?;
if [ $__AS != 0 ]; then
                    lf__35_v0 __5_md[@] $__AS "ERROR" "Environment variable ${env_name} is not set, but required.";
            __AS=$?;
            __AF_lf35_v0__25=$__AF_lf35_v0;
            echo $__AF_lf35_v0__25 > /dev/null 2>&1
        __AF_get_required_env45_v0='';
        return $__AS
fi;
    local val="${__AMBER_VAL_11}"
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
    __AMBER_VAL_12=$(printenv ${env_name});
    __AS=$?;
if [ $__AS != 0 ]; then
        __AF_get_default_env46_v0="${default}";
        return 0
fi;
    local val="${__AMBER_VAL_12}"
    if [ $([ "_${val}" != "_" ]; echo $?) != 0 ]; then
        __AF_get_default_env46_v0="${default}";
        return 0
fi
    __AF_get_default_env46_v0="${val}";
    return 0
}
function send__56_v0 {
    local text=$1
            printf "${text}
"
__AS=$?
}
__AMBER_ARRAY_4=("Server: Bash Server");
__6_response_headers=("${__AMBER_ARRAY_4[@]}")
function append_header__57_v0 {
    local header_name=$1
    local header_value=$2
    __AMBER_ARRAY_5=("${header_name}: ${header_value}");
    __6_response_headers+=("${__AMBER_ARRAY_5[@]}")
}
function set_json__58_v0 {
    append_header__57_v0 "Content-Type" "application/json";
    __AF_append_header57_v0__14=$__AF_append_header57_v0;
    echo $__AF_append_header57_v0__14 > /dev/null 2>&1
}
function init_response_headers__59_v0 {
    __AMBER_VAL_13=$(date +"%a, %d %b %Y %H:%M:%S %Z");
    __AS=$?;
    local date="${__AMBER_VAL_13}"
    append_header__57_v0 "Date" "${date}";
    __AF_append_header57_v0__19=$__AF_append_header57_v0;
    echo $__AF_append_header57_v0__19 > /dev/null 2>&1
    append_header__57_v0 "Expires" "${date}";
    __AF_append_header57_v0__20=$__AF_append_header57_v0;
    echo $__AF_append_header57_v0__20 > /dev/null 2>&1
}
function init_http__60_v0 {
    init_response_headers__59_v0 ;
    __AF_init_response_headers59_v0__24=$__AF_init_response_headers59_v0;
    echo $__AF_init_response_headers59_v0__24 > /dev/null 2>&1
}
function send_response__61_v0 {
    local response_code=$1
    local response_code_name=$2
    local body=$3
    send__56_v0 "HTTP/1.0 ${response_code} ${response_code_name}";
    __AF_send56_v0__28=$__AF_send56_v0;
    echo $__AF_send56_v0__28 > /dev/null 2>&1
    index=0;
for header in "${__6_response_headers[@]}"
do
        send__56_v0 "${header}";
        __AF_send56_v0__30=$__AF_send56_v0;
        echo $__AF_send56_v0__30 > /dev/null 2>&1
        (( index++ )) || true
done
    send__56_v0 "";
    __AF_send56_v0__32=$__AF_send56_v0;
    echo $__AF_send56_v0__32 > /dev/null 2>&1
    lines__10_v0 "${body}";
    __AF_lines10_v0__33=("${__AF_lines10_v0[@]}");
    index=0;
for line in "${__AF_lines10_v0__33[@]}"
do
        send__56_v0 "${line}";
        __AF_send56_v0__34=$__AF_send56_v0;
        echo $__AF_send56_v0__34 > /dev/null 2>&1
        (( index++ )) || true
done
            exit 0
__AS=$?
}
function send_200__62_v0 {
    local body=$1
    send_response__61_v0 200 "OK" "${body}";
    __AF_send_response61_v0__40=$__AF_send_response61_v0;
    echo $__AF_send_response61_v0__40 > /dev/null 2>&1
}
function send_500__64_v0 {
    local body=$1
    send_response__61_v0 500 "Internal Server Error" "${body}";
    __AF_send_response61_v0__48=$__AF_send_response61_v0;
    echo $__AF_send_response61_v0__48 > /dev/null 2>&1
}
init_log_module_data__36_v0 "server";
__AF_init_log_module_data36_v0__7=("${__AF_init_log_module_data36_v0[@]}");
__7_md=("${__AF_init_log_module_data36_v0__7[@]}")
function process_request__69_v0 {
    get_default_env__46_v0 "HOSTS_DIR" "/var/authorize_me";
    __AF_get_default_env46_v0__10="${__AF_get_default_env46_v0}";
    local hosts_dir="${__AF_get_default_env46_v0__10}"
    get_required_env__45_v0 "SOCAT_PEERADDR";
    __AS=$?;
if [ $__AS != 0 ]; then
__AF_process_request69_v0=''
return $__AS
fi;
    __AF_get_required_env45_v0__12="${__AF_get_required_env45_v0}";
    local request_ip="${__AF_get_required_env45_v0__12}"
    l__34_v0 __7_md[@] "DEBUG" "Request from ${request_ip}'";
    __AF_l34_v0__13=$__AF_l34_v0;
    echo $__AF_l34_v0__13 > /dev/null 2>&1
    init_http__60_v0 ;
    __AF_init_http60_v0__15=$__AF_init_http60_v0;
    echo $__AF_init_http60_v0__15 > /dev/null 2>&1
    local path="${hosts_dir}/${request_ip}.json"
    file_exist__5_v0 "${path}";
    __AF_file_exist5_v0__18=$__AF_file_exist5_v0;
    if [ $(echo $__AF_file_exist5_v0__18 '!=' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        l__34_v0 __7_md[@] "WARN" "Host ${request_ip} not found";
        __AF_l34_v0__19=$__AF_l34_v0;
        echo $__AF_l34_v0__19 > /dev/null 2>&1
        send_500__64_v0 "Host not found";
        __AF_send_50064_v0__20=$__AF_send_50064_v0;
        echo $__AF_send_50064_v0__20 > /dev/null 2>&1
fi
    file_read__6_v0 "${path}";
    __AS=$?;
if [ $__AS != 0 ]; then
        l__34_v0 __7_md[@] "ERROR" "Failed to read host data (${request_ip})";
        __AF_l34_v0__24=$__AF_l34_v0;
        echo $__AF_l34_v0__24 > /dev/null 2>&1
        send_500__64_v0 "Failed to read host data";
        __AF_send_50064_v0__25=$__AF_send_50064_v0;
        echo $__AF_send_50064_v0__25 > /dev/null 2>&1
fi;
    __AF_file_read6_v0__23="${__AF_file_read6_v0}";
    local content="${__AF_file_read6_v0__23}"
    set_json__58_v0 ;
    __AF_set_json58_v0__28=$__AF_set_json58_v0;
    echo $__AF_set_json58_v0__28 > /dev/null 2>&1
    send_200__62_v0 "${content}";
    __AF_send_20062_v0__29=$__AF_send_20062_v0;
    echo $__AF_send_20062_v0__29 > /dev/null 2>&1
}
args=("$@")
    file_exist__5_v0 ".env";
    __AF_file_exist5_v0__33=$__AF_file_exist5_v0;
    if [ $__AF_file_exist5_v0__33 != 0 ]; then
        load_env_file__42_v0 ;
        __AF_load_env_file42_v0__34=$__AF_load_env_file42_v0;
        echo $__AF_load_env_file42_v0__34 > /dev/null 2>&1
fi
    init_log__38_v0 ;
    __AF_init_log38_v0__35=$__AF_init_log38_v0;
    echo $__AF_init_log38_v0__35 > /dev/null 2>&1
    len__18_v1 args[@];
    __AF_len18_v1__37=$__AF_len18_v1;
    args_len=$__AF_len18_v1__37
    if [ $(echo ${args_len} '>' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
                    lf__35_v0 __7_md[@] 1 "ERROR" "Invalid argument count was passed";
            __AS=$?;
            __AF_lf35_v0__39=$__AF_lf35_v0;
            echo $__AF_lf35_v0__39 > /dev/null 2>&1
        exit 1
fi
    if [ $(echo ${args_len} '==' 1 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        if [ $([ "_${args[0]}" != "_process_request" ]; echo $?) != 0 ]; then
            process_request__69_v0 ;
            __AS=$?;
if [ $__AS != 0 ]; then

exit $__AS
fi;
            __AF_process_request69_v0__44=$__AF_process_request69_v0;
            echo $__AF_process_request69_v0__44 > /dev/null 2>&1
                            exit 0
__AS=$?
else
                            lf__35_v0 __7_md[@] 1 "ERROR" "Unknown argument was passed";
                __AS=$?;
                __AF_lf35_v0__47=$__AF_lf35_v0;
                echo $__AF_lf35_v0__47 > /dev/null 2>&1
            exit 1
fi
fi
    __AMBER_ARRAY_6=("socat" "bc" "sed" "date");
    fail_if_commands_not_found__44_v0 __AMBER_ARRAY_6[@];
    __AS=$?;
if [ $__AS != 0 ]; then

exit $__AS
fi;
    __AF_fail_if_commands_not_found44_v0__52=$__AF_fail_if_commands_not_found44_v0;
    echo $__AF_fail_if_commands_not_found44_v0__52 > /dev/null 2>&1
    get_default_env__46_v0 "PORT" "8080";
    __AF_get_default_env46_v0__54="${__AF_get_default_env46_v0}";
    port="${__AF_get_default_env46_v0__54}"
    get_default_env__46_v0 "HOST" "127.0.0.1";
    __AF_get_default_env46_v0__55="${__AF_get_default_env46_v0}";
    host="${__AF_get_default_env46_v0__55}"
    l__34_v0 __7_md[@] "INFO" "Starting server on ${host}:${port}";
    __AF_l34_v0__57=$__AF_l34_v0;
    echo $__AF_l34_v0__57 > /dev/null 2>&1
    socat TCP4-LISTEN:${port},bind=${host},pktinfo,fork "EXEC:/usr/bin/env bash ${BASH_SOURCE[0]} process_request"
__AS=$?;
if [ $__AS != 0 ]; then
                    lf__35_v0 __7_md[@] 1 "ERROR" "Failed to start API server";
            __AS=$?;
            __AF_lf35_v0__59=$__AF_lf35_v0;
            echo $__AF_lf35_v0__59 > /dev/null 2>&1
        exit 1
fi