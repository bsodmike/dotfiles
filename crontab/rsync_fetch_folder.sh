#!/bin/bash

set -e

SOURCE=/Users/mdesilva/fetch
BASE=/Users/mdesilva/dotfiles/crontab
DEVICE="macbook_pro_m1_max"
REMOTE="mdesilva@freenas-primary.intranet:/mnt/big-primary/cloud-backup/rsync_uploads"
TIMESTAMP="%d%m%Y_%H%M%S_%Z"
LOG_DIR="${BASE}/logs"
OUTPUT_LOG="${LOG_DIR}/rsync_${DEVICE}_output_`date +${TIMESTAMP}`.log"
RSYNC_LOG="${LOG_DIR}/rsync_${DEVICE}_`date +${TIMESTAMP}`.log"

HOST_NAME="M1MaxMacBookPro.intranet"
PROJECT="cloud-backups-rsync_uploads"

yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

# purpose: to pass msgs and print them to a log file and terminal
#  - with datetime
#  - the type of msg - INFO, ERROR, DEBUG, WARNING
# usage:
# do_log "INFO some info message"
# do_log "ERROR some error message"
# do_log "DEBUG some debug message"
# do_log "WARNING some warning message"
# depts:
#  - PRODUCT_DIR - the root dir of the sfw project
#  - PRODUCT - the name of the software project dir
#  - host_name - the short hostname of the host / container running on
#------------------------------------------------------------------------------

do_log(){
  print_ok() {
      GREEN_COLOR="\033[0;32m"
      DEFAULT="\033[0m"
      echo -e "${GREEN_COLOR} ✔ [OK] ${1:-} ${DEFAULT}"
  }

  print_warning() {
      YELLOW_COLOR="\033[33m"
      DEFAULT="\033[0m"
      echo -e "${YELLOW_COLOR} ⚠ ${1:-} ${DEFAULT}"
  }

   print_info() {
      BLUE_COLOR="\033[0;34m"
      DEFAULT="\033[0m"
      echo -e "${BLUE_COLOR} ℹ ${1:-} ${DEFAULT}"
  }

  print_fail() {
      RED_COLOR="\033[0;31m"
      DEFAULT="\033[0m"
      echo -e "${RED_COLOR} ❌ [NOK] ${1:-}${DEFAULT}"
  }

  type_of_msg=$(echo $*|cut -d" " -f1)
  msg="$(echo $*|cut -d" " -f2-)"
  log_dir="${LOG_DIR:-}" ; mkdir -p $log_dir
  log_file="$log_dir/${PROJECT:-}."$(date "+%d%m%Y")'.log'
  msg=" [$type_of_msg] `date "+%d-%b-%Y %H:%M:%S %Z"` [${PROJECT:-}][@${HOST_NAME:-}] [$$] $msg "
  case "$type_of_msg" in
    'FATAL') print_fail "$msg" | tee -a $log_file ;;
    'ERROR') print_fail "$msg" | tee -a $log_file ;;
    'WARNING') print_warning "$msg" | tee -a $log_file ;;
    'INFO') print_info "$msg" | tee -a $log_file ;;
    'OK') print_ok "$msg" | tee -a $log_file ;;
    *) echo "$msg" | tee -a $log_file ;;
  esac

}

do_log "INFO Backup script running..."
do_log "INFO Rsync log: ${RSYNC_LOG}"

# Use -n (--dry-run) for dry run
rsync --checksum --progress --stats -aPWi --no-p -h --log-file=${RSYNC_LOG} $SOURCE $REMOTE

do_log "INFO Backup script end."
