from subprocess import Popen, PIPE

names = ["torin", "tree", "kepler","susan","wingless", "chickenmitten", "marthos", "nuck"]
names = ["wingless", "nuck"]
for name in names:
    process = Popen( F"DotaFantasyTeam.exe --name={name}")                             