% Final Project BMEG 601
% Daniel Liss, Trevor Moon, Ariel Thomas 
clear
clc


%% Part 1 
% Behavior: what is the rate for hit, miss, correct rejection, false alarm? Check for each session 
% and then compute group average. What is the reaction time associated with each category?

% %Loading in the stimuli 
% Stimloc = '/Users/DanLiss/Documents/Graduate Studies/Matlab/stimuli';
% Stimuli = dir(Stimloc);
% Stimuli = Stimuli(4:end);
% 
% 
% 
% %Loading in the data and variables to be analyzed 
% load('/Users/DanLiss/Documents/Graduate Studies/Matlab/DataFinal.mat','-mat');

% load('/Users/DanLiss/Documents/Graduate Studies/Matlab/DataFinal.mat','-mat');

%imgDir = '/Users/DanLiss/Documents/Graduate Studies/Matlab/stimuli';

load('E:/BMEG 601/DataFinal.mat', '-mat');
imgDir = 'E:/BMEG 601/Stimuli';

%% test

imgW = 1024; imgH = 768;

% iSess needs to go from 1:9
%iSess = 1:9;
% iTrial needs to go from 1:length(code(iSess))
iTrial = 75;

Hit = zeros(1,9);
Miss = zeros(1,9);
correctRejection = zeros(1,9);
falseAlarm = zeros(1,9);

for iSess = 1:9
    %Boolean variable to determine if it is a repeated image
    repeatImg = beh(iSess).vRepeat ~= 1;
    %Finds the position of where the variable is a repeated image in beh
    repeatImgPos = find(repeatImg);

    % Boolean variable to determine if it is an image only shown once
    newImg = beh(iSess).vRepeat == 1;
    %Finds the position of where it is a new image 
    newImgPos = find(newImg);

    %Boolean variable to determine if the response is correct
    corRes = beh(iSess).vCorr == 1;
    %Finds the position of where the variables are correct
    corResPos = find(corRes);

    %Boolean variable to determine if the response is incorrect
    misRes = beh(iSess).vCorr ~=1;
    %Finds the position of where the variables are incorrect
    misResPos = find(misRes); 

    %Hit - Determine the amount of images that are correctly reported as "seen
    %before"
    Hits = double(repeatImg == 1 & corRes == 1);
    Hits = sum(Hits(Hits == 1));
    Hit(iSess) = Hits;
    
    %Miss: forgotten image — a repeated image that subjects incorrectly reported “not seen before”
    Missed = double(repeatImg == 1 & misRes == 1);
    Missed = sum(Missed(Missed == 1));
    Miss(iSess) = Missed;
    
    %Correct rejection: a new image that subjects correctly reported “not seen before”
    correctRejections = double(newImg == 1 & corRes == 1);
    correctRejections = sum(correctRejections(correctRejections == 1));
    correctRejection(iSess) = correctRejections;
    
    %False alarm: a new image that subjects incorrectly reported “seen before”
    falseAlarms = double(newImg == 1 & misRes == 1);
    falseAlarms = sum(falseAlarms(falseAlarms == 1));
    falseAlarm(iSess) = falseAlarms;
end



% %Gives the position of the Hit responses
% sessionHit = find(EM{iSess}(:,9) == 1);
% % Gives you the position of the missed responses
% trialMiss =find(EM{iSess}(:,9) ~= 1);
% %Gives the positions of the images that were misidentified 
% imgMiss = unique(EM{iSess}(trialMiss,7));
% imgHit = unique(EM{iSess}(sessionHit,7));
% %Displays the image numbers that were in the missed response
% Miss = beh(iSess).code(imgMiss);
% Hit = beh(iSess).code(imgHit);

%Create a file to be read to load in the stimuli images
% img = double(imread([imgDir filesep num2str(beh(iSess).code(iTrial)+1000) '.jpg']));

vTrial = EM{iSess}(:,7);

%Creating X and Y positions for the focus to be plotted
X = EM{iSess}(:,2);
Y = EM{iSess}(:,3);

ind = find(vTrial==iTrial);

% figure(100),clf; hold on;
% imagesc([0 imgW],[0 imgH],img/255);
% plot(X(ind),Y(ind),'yo-','linewidth',2);
% axis ij; axis tight;


%Steps that you need to do for the first problem 
%The variable is in repeatpos = find(beh(iSess).vRepeat ~= 1) to see the repeat images
% This will give you the position in the session to find which images are
% repeated 
% beh(iSess).code(repeatpos) this gives you which stimuli images were
% repeated for each session
%trialwrong =find(EM{1,1}(:,9) ~= 1) This will show you where they got they remembered
%the image wrong. This only gives you if the trial is wrong you need to
%bring the number of the trial together imgnum = EM{1,1}(trialwrong,7)
% Use imgnum = unique(imgnum) this will return which trial number they got
% the image wrong
%  THis is going to correspond to miss This gives you the incorrect beh for the session and img number beh(iSess).code(imgnum)
% miss = 
% - Hit: remembered image ? a repeated image that subjects correctly reported ?seen before?
% - Miss: forgotten image ? a repeated image that subjects incorrectly reported ?not seen before?
% - Correct rejection: a new image that subjects correctly reported ?not seen before?
% - False alarm: a new image that subjects incorrectly reported ?seen before?

