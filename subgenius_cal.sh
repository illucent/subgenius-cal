#!/usr/bin/env bash
# -*- coding: utf-8 -*-
# Author: illucent <soho@illucent.info>
# Note :
# Last updated on : 11-Sept-2016
# -----------------------------------------------
# -----------------------------------------------
# ref: http://dawoodfall.net/files/scripts/bash/sub
# ref: http://nikgrozev.com/2016/05/22/shell-cheatsheet-part-1-common-bash-scripting-tmux/#working-with-json-jq
# ref: http://blog.librato.com/posts/jq-json
# -----------------------------------------------

# Fails if an undefined variable is used
set -u

# Fails if a command returns an error code
set -e

# for parameters: month,day date format
declare -A daymonth
daymonth=$(date +'%m,%d')

# human-readable
declare -A TODAY
TODAY=$(date +'%d/ %b /%Y')

# terminal width
COLS=$(tput cols)
# echo "The number of columns are $COLUMNS"
# echo "The number of lines are $LINES"

# test entry
# {"date":"'${daymonth}'", "feast":"eternal holiday eternal holiday eternal holiday eternal holiday eternal holiday"},

# Subgenius dates JSON data
declare -A SUBGENIUS_DATES
SUBGENIUS_DATES='{"subgeniusdates":[
    {"date":"01,16", "feast":"The Night of the Lemur"},
    {"date":"01,24", "feast":"The Feast of St Monty Python"},
	{"date":"02,29", "feast":"Quatenary Prolapse begins"},
    {"date":"03,08", "feast":"The Feast of Weird Al Yankovic"},
	{"date":"03,17", "feast":"The Feast of the Blessed Leprechaun"},
    {"date":"03,28", "feast":"Palmistry Sunday"},
	{"date":"04,01", "feast":"The Feast of Saint Eris"},
    {"date":"04,13", "feast":"St Bill Hicks Day"},
    {"date":"04,15", "feast":"The Feast of Saint Dracula"},
	{"date":"05,06", "feast":"The Feast of St Guinness the Stout"},
    {"date":"05,31", "feast":"Desecration Day"},
	{"date":"06,01", "feast":"Yell 'Fudge' at North American Cobras Day"},
    {"date":"06,22", "feast":"The Feast of St Kali"},
	{"date":"07,16", "feast":"The Display of the Embarrassing Swimsuits"},
    {"date":"07,17", "feast":"The Feast of St Caligula"},
    {"date":"08,01", "feast":"Drug Side-Effects Day"},
	{"date":"08,06", "feast":"The Dance of the Insensitive Bastards"},
    {"date":"09,01", "feast":"Start of the Holy Month of 'Ramalamadingdong'"},
	{"date":"09,06", "feast":"Caesarean Section Day"},
    {"date":"09,11", "feast":"Rock Star Day"},
	{"date":"09,20", "feast":"Yummy Kippers Day"},
	{"date":"10,02", "feast":"All Asquires` Day"},
    {"date":"10,09", "feast":"The Feast of St Attila"},
	{"date":"10,20", "feast":"The Feast of St Oliver the Humanzee"},
    {"date":"11,10", "feast":"The Feast of St Cthulhu"},
    {"date":"11,19", "feast":"Hate for the Sake of Hating Day"},
	{"date":"12,09", "feast":"The Martyrdom of St Kenny"},
    {"date":"12,14", "feast":"Whiny Victimization/Co-Dependency Day"},
	{"date":"12,25", "feast":"Xistlessnessmess"},
    {"date":"12,31", "feast":"The Feast of St Lucifer"}
]}'

# Filter an array by value
# echo ${SUBGENIUS_DATES} | jq '.subgenius_dates[] | select((.date|index("'${TODAY}'")>=0))'
FEAST=$(echo ${SUBGENIUS_DATES} | jq -c -r '.subgeniusdates[] | select(.date=="'${daymonth}'") | .feast')

subgenius_date()
{
	for i in $(seq $(tput cols));do echo -n -e "\u2587";done
	echo -e "today [ ${TODAY} ] is ${FEAST}"
	for i in $(seq $(tput cols));do echo -n -e "\u2587";done
}

case ${FEAST} in
  (*[![:blank:]]*)
	subgenius_date
	;;
  (*)
	echo -e ''; exit 0
	;;
esac


