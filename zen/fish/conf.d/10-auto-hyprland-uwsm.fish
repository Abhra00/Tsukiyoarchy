#  ┓┏┓  ┏┓┳┳┏┳┓┏┓  ┓┏┓┏┏┓┳┓┓ ┏┓┳┓┳┓  ┳┳┓ ┏┏┓┳┳┓
#  ┃┃┫━━┣┫┃┃ ┃ ┃┃━━┣┫┗┫┃┃┣┫┃ ┣┫┃┃┃┃━━┃┃┃┃┃┗┓┃┃┃
#  ┻┗┛  ┛┗┗┛ ┻ ┗┛  ┛┗┗┛┣┛┛┗┗┛┛┗┛┗┻┛  ┗┛┗┻┛┗┛┛ ┗
#                                              



if test (tty) = "/dev/tty1"
    and uwsm check may-start
    exec uwsm start hyprland-uwsm.desktop
end

