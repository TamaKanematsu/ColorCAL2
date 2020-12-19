function [Config, Stimulus] = readStimulus(Config, Monitor)
    
    [file, path] = uigetfile('*.mat');
    Config.Filename.stimulus = [path, file];
    Stimulus = load([path, file]);
%     Stimulus = load('stimulus.mat');
    fields = fieldnames(Stimulus);
    input_stimulus = getfield(Stimulus, fields{1});
    
    %%
    stmlRGB = reshape([input_stimulus.stmlRGB], 3, [])';
    backRGB = reshape([input_stimulus.backRGB], 3, [])';
    blankRGB = reshape([input_stimulus.blankRGB], 3, [])';
    for valname = {'stmlRGB', 'backRGB', 'blankRGB'}
        if checkValue(eval(valname{1}), 0, 255)
            disp('rgb-error');
        end
    end
    
    %%
    onset_time = [input_stimulus.onset_time]';
    offset_time = [input_stimulus.offset_time]';
    start_measure_time = [input_stimulus.start_measure_time]';
    
    if checkValue(onset_time, onset_time * 0, offset_time)
        disp('onset_time error');
    end
    
    if checkValue(offset_time, onset_time, offset_time * Inf)
        disp('offset_time error');
    end
    
    if checkValue(start_measure_time, onset_time, offset_time)
        disp('start_measure_time error');
    end
    %%
    stml_rect = reshape([input_stimulus.stimulus_rect], 4, [])';
    flags = [   checkValue(stml_rect(:,[1,3]), 0, Monitor.Size.width),...
                checkValue(stml_rect(:,[2, 4]), 0, Monitor.Size.height)];
    if sum(flags) > 0
        disp('rect error');
    end
    
    %%
    Stimulus.input_stimulus = input_stimulus;
    Stimulus.stmlNum = length(input_stimulus);
    
end

function flag = checkValue(data, minVal, maxVal)
    flag = false;
    minI = data < minVal;
    maxI = data > maxVal;
    
    I = minI + maxI;
    errorI = find(I>0);
    
    if ~isempty(errorI)
        flag = true;
    end
end

