function createStimulusFiles( filename, digits, winSize, stmlSize)
    
    if notDefined('digits')
        digits = [1:15:256]'-1;
    end
    
    if notDefined('winSize')
        winSize = [2560, 1440]; % [1920 1080]
    end
    
    if notDefined('stmlSize')
        stmlSize = [200, 200];
    end
    %%
    [center(1) center(2)] = RectCenter([0 0 winSize]);
    blankRGB = [125 125 125];
    backRGB = [125 125 125];
    onsetTime = 0.3;
    startMeasureTime = onsetTime;
    offsetTime = 3;
    stmlRect = round( [center center] + [-stmlSize stmlSize]/2);
    %%
    idxs = { 1, 2, 3, [1 2 3]};
    digitNum = length(digits);
    digit_set = [];
    for cols = idxs
        digit = zeros(digitNum, 3);
        digit(:, cols{1}) = repmat(digits, 1, length(cols{1}));  
        digit_set = [digit_set; digit];
    end
    
    %% Mat file
    dataNum = digitNum * length(idxs);
    orderI = randperm(dataNum);
    for i = 1:dataNum
        S(i).stmlNo = i;
        S(i).orderNo = orderI(i);
        S(i).stmlRGB = digit_set(i,:);
        S(i).backRGB = backRGB;
        S(i).blankRGB = blankRGB;
        S(i).onset_time = onsetTime;
        S(i).offset_time = offsetTime;
        S(i).start_measure_time = startMeasureTime;
        S(i).stimulus_rect = stmlRect;
    end
    [~,I] = sort(orderI);
    S = S(I);
    
    %% CSV file
    csv_set = [[S.orderNo]', reshape([S(:).stmlRGB], 3, [])'];
    
    %% save files
    fn = [filename, '-', getDateTimeString('yyyy-mm-dd-HH-MM-SS')];
    save(fn, 'S');
    csvwrite([fn, '.csv'], csv_set);
    
end

