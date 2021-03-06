function calibColorCAL2(Monitor)
    ListenChar(2);
    
    backColor = [0 0 0];
    strColor = [255 255 255];

    myKeyCheck;
    
    Monitor.winPtr = Screen('OpenWindow', Monitor.screenNumber, 0);
    Screen('FillRect', Monitor.winPtr, backColor);
    DrawFormattedText(Monitor.winPtr, 'Put the cover for the zero calibration.\n\n''Space'' to continue....', 'center', 'center', strColor);
    Screen('Flip', Monitor.winPtr);
    KbWait;
    
    Screen('FillRect', Monitor.winPtr, backColor);
    DrawFormattedText(Monitor.winPtr, 'zero calibration...', 'center', 'center', strColor);
    Screen('Flip', Monitor.winPtr);
    
    ColorCal2('ZeroCalibration');
    
    Screen('FillRect', Monitor.winPtr, backColor);
    DrawFormattedText(Monitor.winPtr, 'Completed !!\n''Space'' to continue....', 'center', 'center', strColor);
    Screen('Flip', Monitor.winPtr);
    KbWait;
    
    Screen('CloseAll')
    ListenChar(0);
end
