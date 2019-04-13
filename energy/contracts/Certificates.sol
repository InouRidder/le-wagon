pragma solidity ^0.5.7;

contract Certificates {
    enum CertType { Transferable, NonTransferable }

    mapping(uint => Certificate[]) public idToCertificates;

    struct Certificate {
        uint amount;
        uint timestamp;
        CertType certType;
    }

    function pushCertificate(
        uint _id, uint _amount, uint _timestamp, CertType _type
    ) external {
        idToCertificates[_id].push(Certificate(_amount, _timestamp, _type));
    }

    function certificates(uint _id) public view returns(uint[] memory, uint[] memory, CertType[] memory) {
        uint[] memory amounts = new uint[](idToCertificates[_id].length);
        uint[] memory timestamps = new uint[](idToCertificates[_id].length);
        CertType[] memory certTypes = new CertType[](idToCertificates[_id].length);

        for(uint i; i < idToCertificates[_id].length; i++) {
            amounts[i] = idToCertificates[_id][i].amount;
            timestamps[i] = idToCertificates[_id][i].timestamp;
            certTypes[i] = idToCertificates[_id][i].certType;
        }

        return (amounts, timestamps, certTypes);
    }
}
