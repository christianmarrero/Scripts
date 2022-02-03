import os,sys
folder = 'E:/.../1936342-G/test'
for filename in os.listdir(folder):
       infilename = os.path.join(folder,filename)
       if not os.path.isfile(infilename): continue
       oldbase = os.path.splitext(filename)
       newname = infilename.replace('.grf', '.las')
       output = os.rename(infilename, newname)