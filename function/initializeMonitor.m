function initializeMonitor(Config)
    Screen('Preference', 'SkipSyncTests', Config.Monitor.skipSyncTests);
    Screen('Preference', 'VisualDebugLevel', 0);  %警告を表示しない
    KbName('UnifyKeyNames');
    myKeyCheck;
end

