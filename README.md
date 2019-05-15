**Proportional Selection of Mobile Relays in Millimeter-Wave Heterogeneous Networks**

This code package is the simulation environment relating to the following article:

M. Thi, T. Huynh and W. Hwang, "Proportional Selection of Mobile Relays in Millimeter-Wave Heterogeneous Networks," in IEEE Access, vol. 6, pp. 16081-16091, 2018.


*Abstract of Article*

Millimeter-wave (mmWave) communications are capable of providing gigabit-per-second data rate for future wireless networks. However, mmWave links have the major issues of high propagation loss and shadowing. In access networks, due to the propagation loss and shadowing, a mobile node may fail to communicate directly with its base station. In that case, one of the practical solutions is to communicate via a relay. This paper considers a heterogeneous access network in which if the access link of a mobile node suffers from an outage, some other idle mobile nodes are selected to act as relays. The links from these relays to the mobile node are device-to-device connections. The relay selection problem is formulated as a coalitional game in which each outage link corresponds to a coalition, while each mobile relay is a player. We propose the proportional switching algorithm that allows the players to switch among the coalitions sequentially until stability is reached. Compared with the conventional approaches, the proposed algorithm can obtain the proportionally fair solution of the mobile nodes' performance. The mathematical analysis shows that the switching algorithm always converges to the stable solution. The simulation results verify that analysis; in the meantime, those results provide the evaluations for the proportionality and performance of the proposed algorithm. The algorithm is shown to achieve the proportionally fair results while producing significant improvements in system performance compared with the non-cooperative approach and non-proportional algorithms.


*Content of Code Package*

The package contains 5 Matlab functions: 
- main.m: main function of the code package
- isEligible.m: check if the MT is close enough to the coalition and is eligible to be a relay for the coalition
- isStable.m: finds an MR that can switch from its coalition to another coalition
- isSwitchable.m: check whether an MR can switch from a coaltion to another or not
- proporContrib.m: returns the proportional contribution of a MR to a coalition
- updateNeediness.m: returns the new needdiness of an MT

See each file for further documentation.


*Acknowledgements*

This work was supported under the framework of international cooperation program managed by National Research Foundation of Korea(2014K2A2A4001678).


*License and Referencing*

This code package is licensed under the GPLv2 license. If you in any way use this code for research that results in publications, please cite our original article listed above.
