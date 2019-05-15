%Author: Minh-Thuyen Thi
%Email: thuyentm@oasis.inje.ac.kr
%
%
%This function finds an MR that can switch from its coalition to another 
%coalition, if the index of the returned MR is 0, the function can't find
%any MR, meaning that the coalitions are stable
%
% 
%License: This code is licensed under the GPLv2 license. If you in any way 
%use this code for research that results in publications, please cite our 
%original article listed above. 
%
%
%INPUT
%coalitions = set of all coalitions
%MTs = set of all MTs
%
%
%OUTPUT
%selectedCoal1 = source coalition
%selectedCoal2 = destination coalition
%selectedMr = the MR that is able to switch
%selectedMrIndex = the index of the MR



function [selectedCoal1, selectedCoal2, selectedMr, selectedMrIndex] = isStable(coalitions, MTs)
selectedCoal1 = 0;
selectedCoal2 = 0;
selectedMr = 0;
selectedMrIndex = 0;

n = length(coalitions);
for i = 1:n
    m = length(coalitions{i});
    for k = 1:m
        for j = 1:n
            if j ~= i
                d = coalitions{i}(k);
                if isSwitchable(d, k, i, j, MTs,coalitions) == true
                    selectedCoal1 = i;
                    selectedCoal2 = j;
                    selectedMr = d;
                    selectedMrIndex = k;
                    return;
                end
            end
        end
    end
end
