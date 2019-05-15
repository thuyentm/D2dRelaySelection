%Author: Minh-Thuyen Thi
%Email: thuyentm@oasis.inje.ac.kr
%
%
%This function is the main function to be run
%
% 
%License: This code is licensed under the GPLv2 license. If you in any way 
%use this code for research that results in publications, please cite our 
%original article listed above. 
%
%
%INPUT
%
%
%OUTPUT
%the message indicating how many iteration the algorithm takes to reach
%stable point


clear all;
clc;

global n0; % noise
n0 = -5; 
global distanceThreshold; % relay-able distance
distanceThreshold = 80;
global gamma_thr; % SNR threshold of MT
gamma_thr = 5; 
global sgm; % noise deviation
sgm = 1;
global relayIncentive; % incentive for MRs to relay
relayIncentive = 0.11; 
global mmEta; % path loss exponent of mmWave link
mmEta = 2.17; 
global mEta; % path loss exponent of traditional link
mEta = 2; 
global D; % reference distance
D = 10; 

noMRs = 60; % number of MRs
noMTs = 15; % number of MTs
maxIter = 200; % maximum iter
mmwaveRatio = 0.8; % ratio of the number of mmWave links
mmPower = 30; % power of mmWave link
mPower = 46; % power of traditional link





MRs = struct('xPos', 0, 'yPos', 0, 'power', 0, 'gain', 0.25, 'rho', 0.5, 'eligibleCoalitions', []);
MTs = struct('xPos', 0, 'yPos', 0, 'xPosAp', 0, 'yPosAp', 0, 'power', 0, 'gain', 0.15, 'mmWave', 1, 'neediness', 0);

% initialize MRs
for i = 1:noMRs
    % set position
    MRs(i).xPos = rand*1000 - 500;
    MRs(i).yPos = rand*1000 - 500;
    
    % set power
    MRs(i).power = mPower; % FIXME powers of mmWave connection and traditional connection should be different
    MRs(i).rho = 0.1 + rand(1,1)*0.8; % range (0.1, 0.9)
end

% initialize MTs
for i = 1:noMTs
    % set position
    MTs(i).xPos = rand*1000 - 500;
    MTs(i).yPos = rand*1000 - 500;
    
    % set AP
    if i > (noMTs * mmwaveRatio)
        MTs(i).mmWave = 0; % not an mmWave MT
        MTs(i).xPosAp = 0;
        MTs(i).yPosAp = 0;
        MTs(i).power = mPower;
    else
        MTs(i).xPosAp = MTs(i).xPos + (distanceThreshold*2) * rand(1,1) - distanceThreshold;
        MTs(i).yPosAp = MTs(i).yPos + (distanceThreshold*2) * rand(1,1) - distanceThreshold;
        MTs(i).power = mmPower;
    end
end    

% set eligible coalitions for each MR
for i = 1:noMRs
    MRs(i).eligibleCoalitions = [];
    for u = 1:noMTs
        if isEligible(MRs(i), MTs(u)) == true
            MRs(i).eligibleCoalitions = [MRs(i).eligibleCoalitions u];
        end
    end
end

% set: each MT i corresponds to coalition i
noCoalition = noMTs + 1;

% initialize all coalitions
coalitions = cell(noCoalition, 1);

% add all MRs to the non-sharing coalition
for i = 1:noMRs
    coalitions{noCoalition} = [coalitions{noCoalition} MRs(i)];
end

% initialize neediness
for i = 1:noMTs
    MTs(i).neediness = updateNeediness(MTs(i), coalitions{i});
end

iter = 1;
switched = 1;






% main loop
[selectedCoal1, selectedCoal2, d, dIndex] = isStable(coalitions, MTs);
while (selectedCoal1 ~= 0) && iter < maxIter 
    noEligibleCoals = length(d.eligibleCoalitions);

    if selectedCoal2 ~= 0 && selectedCoal2 ~= selectedCoal1
        % switch
        coalitions{selectedCoal1}(dIndex) = [];
        coalitions{selectedCoal2} = [coalitions{selectedCoal2} d];        
        switched = 1;
        fprintf('At iteration %d,', iter);
        coalitions
        % update neediness
        if selectedCoal1 < noCoalition
            MTs(selectedCoal1).neediness = updateNeediness(MTs(selectedCoal1), coalitions{selectedCoal1});
        end
        if selectedCoal2 < noCoalition
            MTs(selectedCoal2).neediness = updateNeediness(MTs(selectedCoal2), coalitions{selectedCoal2});
        end
        iter = iter + 1;
        [selectedCoal1, selectedCoal2, d, dIndex] = isStable(coalitions, MTs);
    else
        switched = 0;
        prev_d = d;
        continue;
    end
end
fprintf('Coalitions stablized after %i iter(s)\n', iter - 1);






