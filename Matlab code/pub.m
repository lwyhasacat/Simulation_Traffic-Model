set(0,'DefaultFigureVisible','off')
echo off;
warning off
options_publish.format = 'pdf';
options_publish.evalCode = logical(0);
% Select the script you want published:
publish('cartonextblock.m', options_publish)
publish('createcars.m', options_publish)
publish('floyd.m', options_publish)
publish('plotcars.m', options_publish)
publish('findbestpath.m', options_publish)
publish('setroad.m', options_publish)
publish('traffic.m', options_publish)
publish('removecar.m', options_publish)
publish('setlights.m', options_publish)
publish('insertnewcar.m', options_publish)
publish('findbestroute.m', options_publish)
publish('decidenextblock.m', options_publish)
publish('choosedestination.m', options_publish)
publish('movecars.m', options_publish)
publish('initialize.m', options_publish)
pause(5)
set(0,'DefaultFigureVisible','on')
echo on;
warning on;
disp('Done');