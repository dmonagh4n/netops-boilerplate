# netops
Personal Repo for Network Operations and Automation

#### ACI

##### Tenant 
+ Use 'Common' to share resources between between the entire ACI fabric (DNS, Authentication, Security, etc)
##### Tenant Networking
+ VRF, Bridge Domains, Subnets, External Networks
    - VRF (Context/Private Network) - Isolated Routing Table, can be associated with many BDs
    - Bridge Domain - L2 Forwarding Domain, define unique MAC address space, each Bridge Domain is associated with only one VRF
    - Subnet - L3 Networks, associated with BD
    - External Network
        - External Bridged - L2/STP to ACI
        - External Routed - L3 to ACI, using OSPF/BGP/EIGRP, L3 connections also have networks defined, which can provide/consume contracts
##### Tenant Policy
+ Tenant Policies focus on policies and services that endpoints receive
    - Tenant Policy consists of Application Profiles, End Point Groups, Contracts, Filters
        - Application Profiles - Container for EPGs
        - EPGs - Collection of Endpoints that have the same service and policies applied. Can be related to one Bridge Domain
        - Contracts - Define services and policies to the end points in the EPG. Contracts can be used for service redirection for L4-L7 device, assigning QoS values, applying ACL rules
        - Filters - Objects that Define protocols (tcp/udp/icmp etc). Filter objects can contain multiple protocols and ports and Contracts can consume multiple filters  