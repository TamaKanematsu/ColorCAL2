function initializeMonitor(Config)
    Screen('Preference', 'SkipSyncTests', Config.Monitor.skipSyncTests);
    Screen('Preference', 'VisualDebugLevel', 0);  %�x����\�����Ȃ�
    KbName('UnifyKeyNames');
    myKeyCheck;
end

