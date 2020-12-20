setting;

try
    %% connect ColorCAL2
    CAL = ColorCal2('DeviceInfo');
      
    %% read monitor information  
    Monitor = readMonitorInfo(Config.Monitor.screenNumber, Config);

    %% read stimulus file 
    [Config, Stimulus] = readStimulus(Config, Monitor)  ;   
      
    %% zero calibration 
    calibColorCAL2(Monitor); 
    
    %% display measurement   
    Output = measureMonitor(Monitor, Stimulu s, Config); 
  
    ColorCal2('Close'); 
catch 
    Screen('CloseAll');
    ColorCal2('Close'); 
end   
ListenChar(0);
%% save measurement file
save(Config.Filename.savename); 

%% Notice
message = ['ColorCAL2 FINISHED(', num2str(Output.measureNum),'/',num2str(Stimulus.stmlNum),')'];
disp(message);
if ~notDefined('Config.Notice.Webhook.url')
    webwrite(   Config.Notice.Webhook.url,...
                ['{"text": "', message,'"}']);
end