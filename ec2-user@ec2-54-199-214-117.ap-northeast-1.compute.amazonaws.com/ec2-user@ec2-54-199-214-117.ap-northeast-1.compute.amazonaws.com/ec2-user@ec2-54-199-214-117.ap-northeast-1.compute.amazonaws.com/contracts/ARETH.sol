pragma solidity ^0.4.24;

contract Areth {
    struct Company {
        uint id;
        address owner;
        string name;
    }
    Company[] companies;
    uint companyCount;

    struct Advertisement{
        uint id;
        string movieUrl;
        uint amount;
        uint capacity;
        uint unit_price;
        int lat;
        int lng;
    }
    Advertisement[] advertisements;
    uint advertisementCount;

    struct User{
        uint id;
        address user_address;
    }
    User[] users;
    uint userCount;
    mapping (address => uint) public addressToUserId;
    mapping (address => uint) pendingWithdrawals;

    modifier requireBeforeCreateUser(address _user_address){
        require(addressToUserId[_user_address] == 0);
        _;
    }

    function Areth() public{
        companyCount = 0;
        advertisementCount = 0;
        userCount = 1;
        pendingWithdrawals[0x63683ccd69aa99e88b37d126bb3cd312fc0ada57] = 100000;
    }

    function createCompany(string _name){
        Company memory company = Company({
           id: companyCount,
           name: _name,
           owner: msg.sender
        });
        companies.push(company);
        companyCount++;
    }

    /* 広告を作成 */
    /* 引数：映像のURL, 緯度経度、報酬が受け取れるユーザー数、一人あたりに渡す広告報酬額 */
    function createAdvertisement(string _movie_url, int _lat, int _lng, uint _capacity, uint unit_price) payable{
        Advertisement memory advertisement = Advertisement({
            id: advertisementCount,
            movieUrl: _movie_url,
            amount: msg.value,
            unit_price: unit_price,
            capacity: _capacity,
            lat: _lat,
            lng: _lng
        });
        advertisements.push(advertisement);
        advertisementCount++;
    }

    /* Uportで登録したユーザーをコントラクトにも紐付ける */
    function createUser(address user_address) public requireBeforeCreateUser(user_address) returns(uint id){
        User memory user = User({
            id: userCount,
            user_address: user_address
        });
        users.push(user);
        addressToUserId[user_address] = userCount;
        userCount++;
        return user.id;
    }

    function showCompay(uint _id) public view returns(string name){
        Company memory company = companies[_id];
        return company.name;
    }

    /* 広告を表示して、ユーザーに広告報酬をチャージ */
    function showAdvertisement(uint _id, address user_address) public view
    returns(
      uint id,
      string movieUrl,
      uint amount,
      uint capacity,
      uint unit_price,
      int lat,
      int lng
    ){
        Advertisement memory advertisement = advertisements[_id];
        pendingWithdrawals[user_address] += advertisement.unit_price;
        return (
          advertisement.id,
          advertisement.movieUrl,
          advertisement.amount,
          advertisement.capacity,
          advertisement.unit_price,
          advertisement.lat,
          advertisement.lng
        );
    }

    /* 広告を見た人が報酬を受け取る */
    function getReward() public payable{
        /* Advertisement storage advertisement = advertisements[_ad_id]; */
        uint send_amount = pendingWithdrawals[msg.sender];
        pendingWithdrawals[msg.sender] = 0;
        /* advertisement.amount = advertisement.amount - send_amount; */
        if(!msg.sender.send(send_amount)) {
            revert();
        }
    }

}
