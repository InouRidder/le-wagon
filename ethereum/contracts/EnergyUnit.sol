pragma solidity ^0.4.25;

contract EnergyUnit {
  string public message;
  address public manager;

  function EnergyUnit(string InitialMessage) public {
      message = InitialMessage;
      manager = msg.sender;
  }

  function setMessage(string newMessage) public {
      message = newMessage;
  }
}
