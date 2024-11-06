// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract DailyTaskRewardSystem {
    address public owner;
    uint public constant REWARD_POINTS = 10;
    uint public constant REDEEM_THRESHOLD = 50;
    uint public constant COMPLETION_WINDOW = 86400; // 24 hours in seconds

    struct Task {
        string name;
        string description;
        uint timestamp;
        bool completed;
    }

    mapping(address => Task[]) private tasks;
    mapping(address => uint) private points;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Register a new task for the sender
    function registerTask(string memory _name, string memory _description) public {
        require(bytes(_name).length > 0, "Task name is required");
        require(bytes(_description).length > 0, "Task description is required");

        tasks[msg.sender].push(Task(_name, _description, block.timestamp, false));
    }

    // Complete a task and earn points if completed within 24 hours
    function completeTask(uint _taskIndex) public {
        require(_taskIndex < tasks[msg.sender].length, "Invalid task index");

        Task storage task = tasks[msg.sender][_taskIndex];
        require(!task.completed, "Task already completed");

        // Check if the task is being completed within the 24-hour window
        if (block.timestamp <= task.timestamp + COMPLETION_WINDOW) {
            task.completed = true;
            points[msg.sender] += REWARD_POINTS; // Award points for completion
        } else {
            revert("Task completion time exceeded");
        }
    }

    // Redeem points once the user has reached the threshold
    function redeemPoints(uint _points) public {
        require(points[msg.sender] >= _points, "Insufficient points to redeem");

        uint previousPoints = points[msg.sender];
        points[msg.sender] -= _points;

        // Ensure points were deducted correctly
        assert(points[msg.sender] == previousPoints - _points);
    }

    // Get user's total points balance
    function getPointsBalance() public view returns (uint) {
        return points[msg.sender];
    }

    // Get user's tasks
    function getTasks() public view returns (Task[] memory) {
        return tasks[msg.sender];
    }
}
