# DailyTaskRewardSystem Smart Contract

## Overview

The DailyTaskRewardSystem smart contract is a decentralized system that allows users to register tasks, earn points for completing them within 24 hours, and redeem their points once they reach a threshold. This contract demonstrates the use of Solidity features such as task registration, task completion within a specified time window, and error handling with require(), assert(), and revert().

## Features

- **Task Registration**: Users can register new tasks by providing a task name and description.
- **Task Completion**: Users can complete a task and earn points if completed within 24 hours.
- **Point Redemption**: Users can redeem points once they have accumulated enough, as defined by the reward threshold.
- **Error Handling**: Implements error handling with:
  - **`require()`**: Used for validating user input and conditions (e.g., checking if a task exists or if the user has enough points).
  - **`assert()`**: Ensures that the points balance has been correctly updated after redemption.
  - **`revert()`**: Stops the transaction and reverts changes if the task is completed outside the allowed time window.
