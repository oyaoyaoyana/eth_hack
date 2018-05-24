pragma solidity ^0.4.11;

contract MeetMe {
    struct Appointment {
        uint id;
        address owner;
        uint meeting_time;
        uint etherAmount;
        uint pricing;
        bool finished;
        int lat;
        int lng;
    }

    Appointment[] appointments;
    uint appointmentsCount;
    mapping(address => mapping(uint => uint)) public userBetToAppointment;
    mapping(address => mapping(uint => bool)) public userAcheivedToAppointment;
    mapping(address => uint[]) public userToAppointmentId;
    mapping(address => uint) public userToAppointmentCount;

    function MeetMe() public {
        appointmentsCount = 0;
    }

    function checkTime() public returns(uint _now) {
        return(now);
    }

    function checkFutureTime() public returns(uint _tomorrow) {
        uint today = block.timestamp;
        uint tomorrow = today + 1 days;
        return(tomorrow);
    }

    function changeDeadLine(uint _id) public {
        require(appointments[_id].owner == msg.sender);
        appointments[_id].meeting_time = block.timestamp;
    }

    modifier requireAppropriateTime(uint _meeting_time) {
        require(_meeting_time > block.timestamp);
        _;
    }

    modifier requireEqualToPricing(uint _id) {
        require(appointments[_id].pricing == msg.value);
        _;
    }

    modifier requireUserNotBetYet(uint _id) {
        require(userBetToAppointment[msg.sender][_id] == 0);
        _;
    }

    modifier requireCorrectLocation(uint _id, int _lat, int _lng) {
        Appointment memory appointment = appointments[_id];
        require(appointment.lat == _lat);
        require(appointment.lng == _lng);
        _;
    }

    modifier requireBeforeDeadline(uint _id ) {
        Appointment memory appointment = appointments[_id];
        require(appointment.meeting_time >= block.timestamp);
        _;
    }

    modifier requireAlreadyFinised(uint _id) {
        Appointment memory appointment = appointments[_id];
        require(appointment.meeting_time <= block.timestamp);
        _;
    }

    function createAppointment(uint _meeting_time, int _lat, int _lng) public requireAppropriateTime(_meeting_time) payable{
        uint value = msg.value;
        Appointment memory appointment = Appointment({
            id: appointmentsCount,
            owner: msg.sender,
            meeting_time: _meeting_time,
            etherAmount: value,
            pricing: value,
            finished: false,
            lat: _lat,
            lng: _lng
        });
        appointments.push(appointment);
        setToAppointment(appointment.id, value);
        userToAppointmentId[msg.sender].push(appointmentsCount);
        userToAppointmentCount[msg.sender]++;
        appointmentsCount++;
        /* createdAppointment(appointment.owner, appointment.meeting_time); */
    }

    function getAppointment(uint _id) public returns(
      uint id,
      address owner,
      uint meeting_time,
      uint etherAmount,
      uint pricing,
      bool finished,
      int lat,
      int lng
     )
    {
      Appointment memory appointment = appointments[_id];
      return(
        appointment.id,
        appointment.owner,
        appointment.meeting_time,
        appointment.etherAmount,
        appointment.pricing,
        appointment.finished,
        appointment.lat,
        appointment.lng
      );
    }

    function setToAppointment(uint _id, uint _value) internal {
         userBetToAppointment[msg.sender][_id] = _value;
    }

    function getMyLastApointment(uint _count) public view returns(
      uint id
      ) {
        var last_id_array = userToAppointmentId[msg.sender];
        var last_id = last_id_array[_count];
        return(last_id);
      }

    function betToAppointment(uint _id) public requireEqualToPricing(_id) requireUserNotBetYet(_id) payable {
        Appointment storage appointment = appointments[_id];
        uint value = msg.value;
        appointment.etherAmount += value;
        userBetToAppointment[msg.sender][_id] = value;
    }

    function checkBetToAppointment(uint _id) public returns(uint){
        return(userBetToAppointment[msg.sender][_id]);
    }

    function setAchievedToAppointment(uint _id, int _lat, int _lng) public requireBeforeDeadline(_id) requireCorrectLocation(_id, _lat, _lng){
        userAcheivedToAppointment[msg.sender][_id] = true;
    }

    function checkAppointmentAlreadyFinised(uint _id) public view returns(bool) {
        Appointment memory appointment = appointments[_id];
        if (appointment.meeting_time <= block.timestamp) {
            // もう終わった
            return true;
        } else {
            // まだ終わっていない
            return false;
        }
    }

    function witdrawBet(uint _id) requireAlreadyFinised(_id) {
        require(userBetToAppointment[msg.sender][_id] > 0);
        require(userAcheivedToAppointment[msg.sender][_id] == true);
        uint betAmount = userBetToAppointment[msg.sender][_id];
        userBetToAppointment[msg.sender][_id] = 0;
        if(!msg.sender.send(betAmount)) {
            throw;
        }
    }

    function checkMyAddress() view returns(address) {
        var ma = msg.sender;
        return ma;
    }

}
