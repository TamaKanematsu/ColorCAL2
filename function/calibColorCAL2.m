function calibColorCAL2(Monitor, Config)
    
    backColor = [0 0 0];
    strColor = [255 255 255];
    [center(1) center(2)] = RectCenter([0 0 Monitor.Size.width Monitor.Size.height]);

    space_key = KbName('Space');
    return_key = KbName('escape');
    flag_key = [0 0];
    
    % open screen
    initializeMonitor(Config);
    try
        ListenChar(2);
        Monitor.winPtr = Screen('OpenWindow', Monitor.screenNumber, 0);
    catch
        ListenChar(0);
    end

    % calibration
    cc=0;
    while(1)
        if flag_key(2)
            break;
        elseif flag_key(1)
            targetKey = [space_key];
            
            % calibration
            DrawFormattedText(Monitor.winPtr, 'Put the cover for Zero calibration.\n\nPress ''Space'' to continue....', 'center', 'center', strColor);
            Screen('Flip', Monitor.winPtr);
            waitKeys(targetKey);

            DrawFormattedText(Monitor.winPtr, 'Zero calibration...', 'center', 'center', strColor);
            Screen('Flip', Monitor.winPtr);

            try
                flag = ColorCal2('ZeroCalibration');
                disp(flag);
                WaitSecs(1);
            catch
                Screen('CloseAll')
                ListenChar(0);
            end
            DrawFormattedText(Monitor.winPtr, 'Completed !!', 'center', center(2)-50, strColor);
            Screen('Flip', Monitor.winPtr);
            WaitSecs(1);
            
            % next screen
            DrawFormattedText(Monitor.winPtr, 'Completed !!', 'center', center(2)-50, strColor);
        end
        
        targetKey = [space_key, return_key];
        message = '''Escape'' to end Zero calibration\n\n''Space'' to start Zero calibration';
        DrawFormattedText(Monitor.winPtr, '''Escape'' to end Zero calibration\n\n''Space'' to start Zero calibration', 'center', center(2)+50, strColor);
        Screen('Flip', Monitor.winPtr);
        disp(message);
        flag_key = waitKeys(targetKey);
        cc=cc+1;
        disp(cc);
        
    end
    Screen('CloseAll')
    ListenChar(0);
end

