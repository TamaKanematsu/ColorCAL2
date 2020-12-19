function [Config, Stimulus] = readStimulus(Config)
    [file, path] = uigetfile('*.mat');
    Config.Filename.stimulus = [path, file];
    Stimulus = load([path, file]);
end

