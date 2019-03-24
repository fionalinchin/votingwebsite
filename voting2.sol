pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;


contract Voting {
  mapping (bytes32 => uint8) private _votesReceived;

  
  string[] public candidateList;


  // 構造函數 初始化候選人名單
  constructor(string[] candidateNames) public {
    candidateList = candidateNames;
  }
  function votesReceived(string candidate) view returns(uint8){
      return _votesReceived[keccak256(candidate)];
  }

  // 查詢某個候選人的總票數
  function totalVotesFor(string candidate)  constant public returns (uint8) {
    require(validCandidate(candidate) == true);
    // 或者
    // assert(validCandidate(candidate) == true);
    return _votesReceived[keccak256(candidate)];
  }

  // 為某個候選人投票
  function voteForCandidate(string candidate) public {
    assert(validCandidate(candidate) == true);
    _votesReceived[keccak256(candidate)] += 1;
  }

  // 檢索投票的姓名是不是候選人的名字
  function validCandidate(string candidate) constant public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (keccak256(candidateList[i]) == keccak256(candidate)) {
        return true;
      }
    }
    return false;
  }
}