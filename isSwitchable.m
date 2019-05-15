%Author: Minh-Thuyen Thi
%Email: thuyentm@oasis.inje.ac.kr
%
%
%This function check whether an MR can switch from a coaltion to another
%or not
%
% 
%License: This code is licensed under the GPLv2 license. If you in any way 
%use this code for research that results in publications, please cite our 
%original article listed above. 
%
%
%INPUT
%d = the MR to be checked
%dIndex = the index of the MR
%s1 = the source coalition
%s2 = the destiation coalition
%MTs = the set of MTs
%coalitions = the set of coalitions
%
%
%OUTPUT
%switchable = true if switchable, false otherwise




function [switchable] = isSwitchable(d, dIndex, s1, s2, MTs, coalitions)
global relayIncentive;
if s1 > length(MTs)
    mt2 = MTs(s2);
    newMt2 = mt2;
    newCoal2 = [coalitions{s2} d];
    newMt2.neediness = updateNeediness(newMt2, newCoal2);
    if relayIncentive < proporContrib(d,mt2) && relayIncentive < proporContrib(d,newMt2)
        switchable = true;
        return;
    else
        switchable = false;
        return
    end
else
    if s2 > length(MTs)
        mt1 = MTs(s1);
        newMt1 = mt1;
        newCoal1 = coalitions{s1};
        newCoal1(dIndex)=[];
        newMt1.neediness = updateNeediness(newMt1, newCoal1);
        if proporContrib(d,mt1) < relayIncentive && proporContrib(d,newMt1) < relayIncentive
            switchable = true;
            return;
        else
            switchable = false;
            return
        end
    else
        mt1 = MTs(s1);
        mt2 = MTs(s2);
        newMt1 = mt1;
        newMt2 = mt2;
        newCoal1 = coalitions{s1};
        newCoal1(dIndex)=[];
        newCoal2 = [coalitions{s2} d];
        newMt1.neediness = updateNeediness(newMt1, newCoal1);
        newMt2.neediness = updateNeediness(newMt2, newCoal2);
        if proporContrib(d,mt1) < proporContrib(d,mt2) && proporContrib(d,newMt1) < proporContrib(d,newMt2)
            switchable = true;
            return;
        else
            switchable = false;
            return
        end
    end
end

