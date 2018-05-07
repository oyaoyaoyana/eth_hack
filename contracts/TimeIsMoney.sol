pragma solidity ^0.4.11;

contract TimeIsMoney {
    struct Promise {
        uint id;
        address owner;
        uint deadline;
        uint etherMount;
        uint pricing;
        bool finished;
        int lat;
        int lng;
    }

    Promise[] promises;
    uint promisesCount;
    mapping(address => mapping(uint => uint)) public userBetToPromise;
    mapping(address => mapping(uint => bool)) public userAcheivedToPromise;
    mapping(address => uint[]) public userToPromiseId;
    /* event createdPromise(address indexed owner, uint indexed deadline); */

    function TimeIsMoney() public {
        promisesCount = 0;
    }

    function checkTime() public returns(uint _now) {
        return(now);
    }

    function checkFutureTime() public returns(uint _tomorrow) {
        uint today = block.timestamp;
        uint tomorrow = today + 1 days;
        return(tomorrow);
    }

    function cangeDeadLine(uint _id) public {
        require(promises[_id].owner == msg.sender);
        promises[_id].deadline = block.timestamp;
    }

    modifier requireAppropriateTime(uint _deadline) {
        require(_deadline > block.timestamp);
        _;
    }

    modifier requireEqualToPricing(uint _id) {
        require(promises[_id].pricing == msg.value);
        _;
    }

    modifier requireUserNotBetYet(uint _id) {
        require(userBetToPromise[msg.sender][_id] == 0);
        _;
    }

    modifier requireCorrectLocation(uint _id, int _lat, int _lng) {
        Promise memory promise = promises[_id];
        require(promise.lat == _lat);
        require(promise.lng == _lng);
        _;
    }

    modifier requireBeforeDeadline(uint _id ) {
        Promise memory promise = promises[_id];
        require(promise.deadline >= block.timestamp);
        _;
    }

    modifier requireAlreadyFinised(uint _id) {
        Promise memory promise = promises[_id];
        require(promise.deadline <= block.timestamp);
        _;
    }

    function setToPromise(uint _id, uint _value) internal {
         userBetToPromise[msg.sender][_id] = _value;
    }

    function createPromise(uint _deadline, int _lat, int _lng) public requireAppropriateTime(_deadline) payable{
        uint value = msg.value;
        Promise memory promise = Promise({
            id: promisesCount,
            owner: msg.sender,
            deadline: _deadline,
            etherMount: value,
            pricing: value,
            finished: false,
            lat: _lat,
            lng: _lng
        });
        promises.push(promise);
        setToPromise(promise.id, value);
        promisesCount++;
        /* createdPromise(promise.owner, promise.deadline); */
    }

    function getPromise(uint _id) public returns(uint id, address owner, uint etherMount, bool finished, uint pricing) {
        Promise memory promise = promises[_id];
        return(promise.id, promise.owner, promise.etherMount, promise.finished, promise.pricing);
    }

    function betToPromise(uint _id) public requireEqualToPricing(_id) requireUserNotBetYet(_id) payable {
        Promise storage promise = promises[_id];
        uint value = msg.value;
        promise.etherMount += value;
        userBetToPromise[msg.sender][_id] = value;
    }

    function checkBetToPromise(uint _id) public returns(uint){
        return(userBetToPromise[msg.sender][_id]);
    }

    function setAchievedToPromise(uint _id, int _lat, int _lng) public requireBeforeDeadline(_id) requireCorrectLocation(_id, _lat, _lng){
        userAcheivedToPromise[msg.sender][_id] = true;
    }



    function witdrawBet(uint _id) requireAlreadyFinised(_id) {
        require(userBetToPromise[msg.sender][_id] > 0);
        require(userAcheivedToPromise[msg.sender][_id] == true);
        uint betAmount = userBetToPromise[msg.sender][_id];
        userBetToPromise[msg.sender][_id] = 0;
        if(!msg.sender.send(betAmount)) {
            throw;
        }
    }


}
