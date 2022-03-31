// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Test {

    string public name = "Nacho"; // State variable
    int num = 5; // State variable
    address private wallet;

    constructor(){
        wallet = msg.sender;
    }

// MODIFIER
    // Requirement that we state so a function can be executed
    modifier onlyOwner() {
        require(msg.sender == wallet, "Only owner can change project name"); //Params 1.- Condition to be validated, 2.- Message if it fails.

        _; //Function is appended where underscore is. In this case, after the require
    }

    function changeName(string memory newName) public onlyOwner {
        name = newName;
        emit ChangeName(msg.sender, newName); // emit to call the event. params must match to what event requests
    }

    function getName() public view returns (string memory){ 
        //VIEW does not allow us to change the 'name' value
        return name;
    }

    function sum(int x, int y) public pure returns (int result){ 
        //PURE does not allow us to read and use the 'num' value as its state variable
        return =  x + y + num;
    }


    function sendETH(address payable receiver) public payable {
        receiver.transfer(msg.value);
    }

// EVENT
    // Event registers changes and feedback. It connects what's inside blockchain to what's outside so that external apps can see what
    // is happening on the smart contract
    event ChangeName(address editor, string newName); // Logs what it passed as parameters

// STRUCT
    // Struct is similar to an object, we defines its params
    struct Mobile {
        uint number;
        string brand;
        uint capacity;
        string model;
    }

    Mobile iphone = Mobile(123456, "Apple", 128, "Iphone 12 Pro"); //To instance a new struct we do this way
    iphone.number // Access its param => 123456

// ENUM
    // Enum forces us to use only what had been defined in it. Indexes can be used [0,1,2]
    enum Brand { Apple, Samsung, LG }; 

    // To init a new brand, we can use only brands available.
    Brand public brand = Brand.Apple;

    function changeBrand(Brand newBrand) public { // newBrand must be Apple, Samsung or LG
        // If newBrand is different from Apple, Samsung or LG, this will throw an error
        brand = newBrand; 
    }

// ARRAYS
    // type[length] name info
    uint[] array = [1,2,3,4]; // This array has variable length
    uint[3] numbers = [5,6,7]; // This array has fixed length

    // push and pop ONLY used with variable lengths.
    array.push(5); // [1,2,3,4,5]
    array.pop(); // [1,2,3,4]

    array[2]; // returns 3

// MAPPING
    // Type of variable to store key and its value
        // type of key => type of value | name of variable
    mapping(string => uint) ages;

    ages["Ignacio"] = 23; // Key = Ignacio, value = 23
    ages["Josefa"] = 20;

    // To access key's value
    ages["Ignacio"]; // 23
    ages["Josefa"]; // 20
}

// DATA LOCATION

// Storage: gets stored in the blockchain, can be used at any time. State variables here
// Memory: Only exists while functions is being used. Functions params here
// Calldata: Similar to memory, however, it cannot be modified. Similar to 'const'

// ERROR
// to define an error we use error errFunction(params)
// to call the error we use revert errFunction(params)