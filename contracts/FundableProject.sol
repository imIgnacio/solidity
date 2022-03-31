// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract FundableProject {

    enum State { Open, Closed }

    struct Contribution {
        address contributor;
        uint amount;
    }

    struct Project {
        string id;
        string name;
        string description;
        State state;
        address payable author;
        uint funds;
        uint fundrisingGoal;
    }

    Project[] public projects; // Array to store multiple projects

    // Function to create new projects
    function createProject(string memory _id, string memory _name, string memory _description, uint _fundrisingGoal) public {
        Project memory project = Project(_id, _name, _description, State.Open, payable(msg.sender), 0, _fundrisingGoal);
        projects.push(project);
    }

    // mapping to store constributions
    mapping(string => Contribution[]) public contributions;


    function fundProject(uint projectIndex) public payable {
        require(msg.sender != projects[projectIndex].author, "Author cannot contribute to his own project");

        Project memory project = projects[projectIndex];
        require(project.state != State.Closed, "Project is already closed, cannot receive funds");
        if(msg.value == 0){
            revert zeroFund(msg.value);
        }

        project.author.transfer(msg.value);
        projects[projectIndex].funds += msg.value;

        contributions[project.id].push(Contribution(msg.sender, msg.value));

        emit FundProject(msg.sender, msg.value);
    }

    event FundProject(address sender, uint funds);

    error zeroFund(uint amount);

    function changeProjectState(State newState, uint projectIndex) public {
        require(msg.sender == projects[projectIndex].author, "Only author can change the state");

        Project memory project = projects[projectIndex];
        require(project.state != newState, "New state must be different from current state");
        project.state = newState;
        emit ChangeProjectState(project.state);
    }

    event ChangeProjectState(State newState);

}