function Monitor = readMonitorInfo(screenNumber, Config)
    [width, height] = Screen('WindowSize', screenNumber);
    [Center.x, Center.y] = RectCenter([0 0 width height]);
    rect = [Center.x Center.y Center.x Center.y] + round([-width -height width height]/3);
    
    initializeMonitor(Config);
    
    winPtr = Screen('OpenWindow', screenNumber, 0);
    ifi = Screen('GetFlipInterval', winPtr);
    Screen('CloseAll');
    
    Monitor.screenNumber = screenNumber;
    Monitor.winPtr = winPtr;
    Monitor.Size.width = width;
    Monitor.Size.height= height;
    Monitor.flip_interval = ifi;
end

