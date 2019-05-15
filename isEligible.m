%Author: Minh-Thuyen Thi
%Email: thuyentm@oasis.inje.ac.kr
%
%
%This function takes in an MT and a coalition and check if the MT is close 
%enough to the coalition and is eligible to be a relay for the coalition
%
% 
%License: This code is licensed under the GPLv2 license. If you in any way 
%use this code for research that results in publications, please cite our 
%original article listed above. 
%
%
%INPUT
%i = coalition
%MT = mobile terminal
%
%
%OUTPUT
%eligible = true if eligible, false if ineligible


function [eligible] = isEligible(i,MT)
global distanceThreshold;
if sqrt((i.xPos - MT.xPos)^2 + (i.yPos - MT.yPos)^2) < (3*distanceThreshold) && sqrt((i.xPos - MT.xPosAp)^2 + (i.yPos - MT.yPosAp)^2) < (3*distanceThreshold)
    eligible = true;
else
    eligible = false;
end
