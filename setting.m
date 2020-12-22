clear
addpath("function");

%%
Config.Directry.output = 'output\';
Config.Filename.date_format = 'yyyy-mm-dd-HH-MM-SS'; 
Config.Filename.savename = [Config.Directry.output, datestr(datetime('now'), Config.Filename.date_format),'.mat'];
Config.Monitor.screenNumber = 2;
Config.Monitor.skipSyncTests = 1;
Config.Monitor.skipTest = 0;

%% Slack noticification
% 
%   1. see how to get Webhook URL on Slack
%       https://qiita.com/vmmhypervisor/items/18c99624a84df8b31008
%   2. rewrite "Config.Notice.Webhook.url" for your url

% Config.Notice.Webhook.url = 'https://hooks.slack.com/services/EXAMPLEEEE';
