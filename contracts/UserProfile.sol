// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserProfile {
    // 1. Define User struct
    struct User {
        string name;
        uint256 age;
        string email;
        uint256 registrationTimestamp;
    }

    // 2. State variables
    mapping(address => User) public users;
    mapping(address => bool) private registered;

    // 3. register(): allow new users to signup
    function register(
        string calldata _name,
        uint256 _age,
        string calldata _email
    ) external {
        require(!registered[msg.sender], "User already registered");

        users[msg.sender] = User({
            name: _name,
            age: _age,
            email: _email,
            registrationTimestamp: block.timestamp
        });

        registered[msg.sender] = true;
    }

    // 4. updateProfile(): modify name, age, email
    function updateProfile(
        string calldata _name,
        uint256 _age,
        string calldata _email
    ) external {
        require(registered[msg.sender], "User not registered");

        User storage user = users[msg.sender];
        user.name = _name;
        user.age = _age;
        user.email = _email;
        // registrationTimestamp stays the same
    }

    // 5. getProfile(): public view to fetch anyone’s profile
    function getProfile(address _user)
        external
        view
        returns (
            string memory name,
            uint256 age,
            string memory email,
            uint256 registrationTimestamp
        )
    {
        require(registered[_user], "User not registered");
        User storage user = users[_user];
        return (
            user.name,
            user.age,
            user.email,
            user.registrationTimestamp
        );
    }

    // 6. Convenience: check if an address is registered
    function isRegistered(address _user) external view returns (bool) {
        return registered[_user];
    }
}


