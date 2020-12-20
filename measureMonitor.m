function Output = measureMonitor(Monitor, Stimulus, Config)
    ListenChar(2);
    myKeyCheck;
    stimuli = Stimulus.input_stimulus;
    cMatrix = ColorCal2('ReadColorMatrix');
    %% open full screen
    initializeMonitor(Config);
    Monitor.winPtr = Screen('OpenWindow', Monitor.screenNumber, 0, [0 0 Monitor.Size.width Monitor.Size.height]);
    
    %% setting the position of ColorCAL2
    createCrossScreen(Monitor.winPtr, stimuli(1).stimulus_rect, Monitor.Size);   

    %% measuring stimulus set
    flipTime = 0;
    try
        for i = 1:Stimulus.stmlNum
            S = stimuli(i);
            blank_duration(i) = S.onset_time;
            stimulus_duration(i) = S.offset_time - S.onset_time;
            measure_time_from_onset(i) = S.start_measure_time - S.onset_time;

            % blank screen
            [BlankTimeStamp(i), BlankOnsetTime(i)] = createBlankScreen(Monitor.winPtr, S.blankRGB, flipTime);

            % stimulus screen
            flipTime = BlankOnsetTime(i) + blank_duration(i);
            [StimulusTimeStamp(i), StimulusOnsetTime(i)] = createStimulusScreen(Monitor.winPtr, S.stmlRGB, S.backRGB, S.stimulus_rect, flipTime);

            % measuring
            realWakeupTimeSecs(i) = WaitSecs(measure_time_from_onset(i));
            XYZ(i) = ColorCal2('MeasureXYZ');
            %
            flipTime = StimulusOnsetTime(i) + stimulus_duration(i);
        end
        [BlankTimeStamp(i+1), BlankOnsetTime(i+1)] = createBlankScreen(Monitor.winPtr, S.blankRGB, flipTime);
        Screen('CloseAll');
    catch
        Screen('CloseAll');
    end
    Output.measureNum = i;
    
    %% datas from the measuring
    output = stimuli;
    for i= 1:Output.measureNum
        output(i).SettingBlankDuration = blank_duration(i);
        output(i).SettingStimulusDuration = stimulus_duration(i);
        output(i).SettingMeasureStartTime = measure_time_from_onset(i);
        output(i).BlankOnsetTime = BlankOnsetTime(i);
        output(i).MeasureOnsetTime = realWakeupTimeSecs(i);
        output(i).StimulusOnsetTime = StimulusOnsetTime(i);
        output(i).BlankDuration = StimulusOnsetTime(i) - BlankOnsetTime(i);
        output(i).MeasureStartTime = realWakeupTimeSecs(i) - StimulusOnsetTime(i);
    end
    for i= 2:Output.measureNum
        output(i-1).StimulusDurations = BlankOnsetTime(i) - StimulusOnsetTime(i-1);
    end
    for i= 1:Output.measureNum
        output(i).XYZ = [XYZ(i).x XYZ(i).y XYZ(i).z];
        output(i).correctedXYZ = [cMatrix(1:3,:) * [XYZ(i).x XYZ(i).y XYZ(i).z]']'; 
        output(i).Lxy = XYZ2Lxy(output(i).correctedXYZ);
    end
    Output.Measures = output;
    
    ListenChar(0);
end

%% ----- functions -----
function [BlankTimeStamp, BlankOnsetTime] = createBlankScreen(winPtr, blankRGB, flipTime)
    Screen('FillRect', winPtr, blankRGB);
    [BlankTimeStamp, BlankOnsetTime] = Screen('Flip', winPtr, flipTime);
end

function [StimulusTimeStamp, StimulusOnsetTime] = createStimulusScreen(winPtr, stmlRGB, backRGB, stimulus_rect, flipTime)
    Screen('FillRect', winPtr, backRGB);
    Screen('FillRect', winPtr, stmlRGB, stimulus_rect);
    [StimulusTimeStamp, StimulusOnsetTime] = Screen('Flip', winPtr, flipTime);
end

function createCrossScreen(winPtr, stimulus_rect, monitor_size)
    crossRGB = [255 255 255];
    backRGB = [0 0 0];
    strRGB = [0 255 0];
    
    [line_center(1) line_center(2)] = RectCenter(stimulus_rect);
    
    Screen('FillRect', winPtr, backRGB);
    Screen('DrawLine', winPtr ,crossRGB, 0, line_center(2), monitor_size.width, line_center(2)); % vertival line
    Screen('DrawLine', winPtr ,crossRGB, line_center(1), 0, line_center(1), monitor_size.height); % horizontal line
    DrawFormattedText(winPtr, '1. Remove the cover\n2. Place ColorCAL2 in front of the cross\n\nPress any key to start the measuring', 'center', 'center', strRGB);
    [VBLTimeStamp, StimulusOnsetTime] = Screen('Flip', winPtr);
    KbWait;
    
    WaitSecs(0.2);
end