# This is a sample config file, refer to ytfzf(5) for more information

# In the previous version of ytfzf this file had all the examples, with all defaults set,
# this has been changed because it made it impossible for us to change default values that were broken or causing bugs,
# as everyone used the default configuration file.
# we are now going to only have this sample config file, and the ytfzf(5) manual, which has explanation of every variable and function that can be set.

#a sample config below:

#Variables {{{
video_pref="22"
##scrape 1 video link per channel instead of the default 2
#sub_link_count=1
#show_thumbnails=1
##}}}
#
##Functions {{{
#external_menu () {
#    #use rofi instead of dmenu
#    rofi -dmenu -width 1500 -p "$1"
#}

#use vlc instead of mpv
#video_player () {
#    #this function does not take video_pref into account, as vlc has no option (that i know of) to change it
#    notify_info "Playing $# video(s)"
#    #check if detach is enabled
#    case "$is_detach" in
#	#disabled
#	0) vlc "$@" ;;
#	#enabled
#	1) setsid -f vlc "$@" > /dev/null 2>&1 ;;
#    esac
#}

mpv_config="-hwdec --autofit-larger=100% --geometry=1080-2-2"

video_player() {
	#this function should not be set as the url_handler as it is part of multimedia_player
	# dep_check "mpv" || die 3 "mpv is not installed\n"
	case "$is_detach" in
		0) mpv $mpv_config --ytdl-format="$video_pref" "$@" ;;
		1) setsid -f mpv --ytdl-format="$video_pref" "$@" > /dev/null 2>&1 ;;
	esac
}

#on_opt_parse () {
#    opt="$1"
#    arg="$2"
#    case "$opt" in
#	#-c
#	c)
#	    #when scraping subscriptions enable -l
#	    #-cSI or -cS
#	    case "$arg" in
#		S|SI) is_loop=1 ;;
#	    esac
#    esac
#}
#}}}
