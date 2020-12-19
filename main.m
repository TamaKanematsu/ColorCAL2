setting;

%% read stimulus file
% [Config, Stimulus] = readStimulus(Config);
    eeadfadfdf  tetstd
try
    %% connect ColorCAL2
    CAL = openColorCAL2();
    
    %% read monitor information
    Monitor = readMonitorInfo(Config.Monitor.screenNumber, Config);

    %% zero calibration 
    calibColorCAL2(Monitor); 
    
    %% display measurement

catch
    Screen('CloseAll');
    ColorCal2('Close'); 
    ListenChar(0);
end
Screen('CloseAll');
ColorCal2('Close'); 
ListenChar(0);
%% save measurement file