%Author: Minh-Thuyen Thi
%Email: thuyentm@oasis.inje.ac.kr
%
%
%This function returns the new needdiness of an MT
%
% 
%License: This code is licensed under the GPLv2 license. If you in any way 
%use this code for research that results in publications, please cite our 
%original article listed above. 
%
%
%INPUT
%MT = the MT to be checked
%S = the set of all MRs
%
%
%OUTPUT
%newNeediness = new neediness of the MT


function newNeediness = updateNeediness(MT, S)
global n0 gamma_thr sgm mmEta mEta D;

ndn = 1;
noMem = length(S);


for i = 1:noMem
    mr = S(i);
    if MT.mmWave == 1
        distanceToAp = sqrt((mr.xPos - MT.xPosAp)^2 + (mr.yPos - MT.yPosAp)^2);
        hat_p_1 = mr.power - 10*mmEta*log(distanceToAp/D);
        distanceToMT = sqrt((mr.xPos - MT.xPos)^2 + (mr.yPos - MT.yPos)^2);
        hat_p_2 = mr.power - 10*mmEta*log(distanceToMT/D);
        ePower1 = exp(-(n0*gamma_thr)/hat_p_1);
        ePower2 = exp(-(n0*gamma_thr)/hat_p_2);
        ndn = ndn * (1 - mr.rho*ePower1*mr.rho*ePower2);
    else
        distanceToBs = sqrt((mr.xPos)^2 + (mr.yPos)^2);
        hat_p_1 = mr.power - 10*mEta*log(distanceToBs/D);
        distanceToMT = sqrt((mr.xPos - MT.xPos)^2 + (mr.yPos - MT.yPos)^2);
        hat_p_2 = mr.power - 10*mEta*log(distanceToMT/D);
        errorFunc = erf((n0*gamma_thr - hat_p_1)/(sqrt(2)*sgm));
        ePower3 = exp(-(n0*gamma_thr)/hat_p_2);
        ndn = ndn * (1 - mr.rho*(1/2 - (1/2)*errorFunc)*mr.rho*ePower3);
    end
end
newNeediness = ndn;
end
