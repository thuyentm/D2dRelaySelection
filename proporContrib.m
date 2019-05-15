%Author: Minh-Thuyen Thi
%Email: thuyentm@oasis.inje.ac.kr
%
%
%This function returns the proportional contribution of a MR to a coalition
%
% 
%License: This code is licensed under the GPLv2 license. If you in any way 
%use this code for research that results in publications, please cite our 
%original article listed above. 
%
%
%INPUT
%d = the MR to be checked
%MT = the MT to be checked
%
%
%OUTPUT
%propCtrlb = the contribution value



function propCtrb = proporContrib(d, MT)
global n0 gamma_thr sgm D;

distanceToMT = sqrt((d.xPos - MT.xPos)^2 + (d.yPos - MT.yPos)^2);
if (MT.mmWave == 1)
    distanceToAp = sqrt((d.xPos - MT.xPosAp)^2 + (d.yPos - MT.yPosAp)^2);
    hat_p_1 = d.power - 10*2*log(distanceToAp/D);
    hat_p_2 = d.power - 10*2*log(distanceToMT/D);
    ePower1 = exp(-(n0*gamma_thr)/hat_p_1);
    ePower2 = exp(-(n0*gamma_thr)/hat_p_2);
    contribution = (d.rho*ePower1)*(d.rho*ePower2);
else
    distanceToBs = sqrt((d.xPos)^2 + (d.yPos)^2);
    hat_p_1 = d.power - 10*2*log(distanceToBs/D);
    hat_p_2 = d.power - 10*2*log(distanceToMT/D);
    errFunc = erf((n0*gamma_thr - hat_p_1)/(sqrt(2)*sgm));
    ePower3 = exp(-(n0*gamma_thr)/hat_p_2);
    contribution = (1/2 - (1/2)*errFunc)*(d.rho*ePower3);
end
propCtrb = contribution*MT.neediness;
end
