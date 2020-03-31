assert __name__=='__main__'

import os
import datetime
import shutil
import argparse
import re
import os

def rename( fname ):
    ts = os.path.getmtime(fname)
    dt = datetime.datetime.fromtimestamp(ts)
    timestamp = dt.strftime('%Y%m%dT%H%M%S')
    newname = '%s.ws852.mp3' % timestamp
    print( 'renaming %s -> %s' % (fname, newname) )
    shutil.move( fname, newname )

if __name__=='__main__':

    parser = argparse.ArgumentParser(description='Fix filenames in a target folder to reflect creation time')
    parser.add_argument('target', metavar='TARGET', type=str, nargs=1, help='path to target folder')

    try:
        TARGET  = parser.parse_args().target[0]
        os.chdir( TARGET )
    except OSError:
        print( 'Cannot find directory %s' % TARGET )
        exit()

    for name in os.listdir( '.' ):
        # The native fiolenanes of the WS-852 match the following:
        MATCH = "^[0-9]{6}_[0-9]{4}\\.MP3"
        if re.match( MATCH, name):
            rename( name )
        else:
            print( 'skipping %s' % name )

