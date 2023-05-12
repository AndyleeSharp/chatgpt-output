#!/bin/bash
#接收多个用空格分隔的进程名，然后top它们
if [ -z "$1"  ]; then
    echo "请提供要查找的进程名作为参数"
      exit 1
fi

# 获取当前脚本的PID，并将多个进程名参数用逗号连接起来
current_pid=$$
process_names=$(echo "$@" | sed 's/ /|/g')

# 查找所有匹配的进程，并过滤掉当前脚本的进程
pids=$(pgrep -f "$process_names" | grep -v "$current_pid" | tr '\n' ',' | sed 's/,$//')

if [ -z "$pids"  ]; then
    echo "未找到进程名匹配 $* 的进程"
      exit 1
fi

# 将多个PID用逗号分隔，并执行top命令
top -p "$pids"
