% main program: traffic.m

clc, clear, close all;

initialize

str='';
dim = [.16 .6 .3 .3];
anno = annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',24);

for clock = 1:clockmax
    setroad
    hold on
    t = clock * dt;
    
    str = ([' t = ',num2str(t,'%4.2f')]); % display time on the plot
    set(anno, 'String',str)
    
    setlights
    createcars
    movecars
    plotcars
    xlim([0, 13])
    ylim([0, 13])
    
    refreshdata
    drawnow
    hold off
end
avgtonroad = mean(tonroad);