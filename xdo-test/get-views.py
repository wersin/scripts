import subprocess 
cmd = ['ps', 'aux |', 'pgrep', 'tor']
#cmd = ['ls', '-l']
p = subprocess.Popen(cmd)

print (p)
