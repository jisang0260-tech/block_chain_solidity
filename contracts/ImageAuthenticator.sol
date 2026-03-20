// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PHashRegistry {
    
    // 1. 데이터 저장소 (상태 변수)
    // pHash 값(문자열)을 입력하면, 주인의 지갑 주소를 알려주는 장부입니다.
    mapping(string => address) public imageOwners;
    
    // 해당 pHash가 이미 등록되었는지 확인하는 장부입니다.
    mapping(string => bool) public isRegistered;

    // 2. 이벤트 (로그 기록)
    // 블록체인에 영구적으로 "누가, 언제, 어떤 사진을 등록했다"는 기록을 남깁니다.
    // 플러터 앱에서 이 기록을 나중에 검색할 수 있습니다.
    event ImageRegistered(address indexed owner, string pHash, uint256 timestamp);

    // 3. 사진 등록 함수 (Write)
    // 플러터 앱에서 pHash 값을 던져주면, 이 함수가 실행되어 블록체인에 기록합니다.
    function registerImage(string memory _pHash) public {
        // 이미 등록된 해시인지 검사 (중복 등록 방지)
        // require() 안의 조건이 참(true)이어야만 아래 코드가 실행됩니다.
        require(!isRegistered[_pHash], "This image (pHash) is already registered!");

        // 장부에 기록 (이 함수를 호출한 사람 = msg.sender 가 주인이 됩니다)
        imageOwners[_pHash] = msg.sender;
        isRegistered[_pHash] = true;

        // 이벤트 발생 (블록체인 네트워크에 "등록 완료!" 라고 소문내기)
        emit ImageRegistered(msg.sender, _pHash, block.timestamp);
    }

    // 4. 소유자 확인 함수 (Read - 가스비 무료)
    // pHash 값을 넣으면, 진짜 주인의 지갑 주소를 반환해 줍니다.
    function getOwner(string memory _pHash) public view returns (address) {
        require(isRegistered[_pHash], "This image is not registered yet.");
        return imageOwners[_pHash];
    }
}