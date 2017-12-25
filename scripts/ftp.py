from ftplib import FTP
import ftplib
import threading
import getopt
import sys

try:
    opList, args = getopt.getopt(sys.argv[1:], '', ['passwd-file=', 'host='])
except getopt.GetoptError as err:
    print str(err)
    sys.exit(2)

print opList
for k, v in opList:
    if k == '--host':
        host = v
    elif k == '--passwd-file':
        passwdFile = v

if not host or not passwdFile:
    print "Usage ",__file__, "-h host --paswd-file file"

def tryFtp (host, user, passwd):
    try:
        print 'try ', user, ' ', passwd
        ftp = FTP(host)
        ftp.login(user, passwd)
        print user, ' ', passwd, ' is ok'
    except ftplib.all_errors as e:
        print str(e)

with open(passwdFile) as f:
    lines = f.readlines()
    threads = []
    for line in lines:
        print line
        if len(threads) == 10:
            for t in threads:
                t.start()
            threads = []
        try:
            passwd = line.strip('\n')
        except ValueError as e:
            print str(e)
            continue
        threads.append(threading.Thread(target=tryFtp, args=(host, 'anonymous', passwd)))

[t.start() for t in threads]
