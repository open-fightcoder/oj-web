package models

import (
	"fmt"
	"testing"
)

func TestUserCreate(t *testing.T) {
	InitAllInTest()

	user := &User{AccountId: 3, NickName: "fffffffffff", UserName: "rrrrrrrrrrrr"}
	if _, err := Create(user); err != nil {
		t.Error("Create() failed. Error:", err)
	}
}
func TestUserUpdate(t *testing.T) {
	InitAllInTest()

	user := &User{Id: 1, UserName: "adaad"}
	if err := Update(user); err != nil {
		t.Error("Update() failed. Error:", err)
	}
}
func TestUserRemove(t *testing.T) {
	InitAllInTest()

	if err := Remove(1); err != nil {
		t.Error("Remove() failed. Error:", err)
	}
}
func TestUserGetById(t *testing.T) {
	InitAllInTest()

	user := &User{AccountId: 1, UserName: "abcdfg", NickName: "hahaha", Description: "1111",
		Sex: "男", Birthday: "2011-10-01", DailyAddress: "西安"}
	Create(user)

	getUser, err := GetById(user.Id)
	if err != nil {
		t.Error("GetById() failed:", err.Error())
	}

	if *getUser != *user {
		t.Error("GetById() failed:", "%v != %v", user, getUser)
	}
}
func TestUserQueryByName(t *testing.T) {
	InitAllInTest()

	user := &User{NickName: "ssd", UserName: "rrrrrr"}
	user1 := &User{NickName: "ssd", UserName: "tttttt"}
	Create(user)
	Create(user1)

	userList, err := QueryByName("ssd")
	if err != nil {
		t.Error("QueryByName() failed:", err)
	}
	if len(userList) != 2 {
		t.Error("QueryByName() failed:", "count is wrong!")
	}
}
func TestUserGetByAccountId(t *testing.T) {
	InitAllInTest()

	user := &User{AccountId: 20}
	Create(user)

	getUser, err := GetByAccountId(1)
	if err != nil {
		t.Error("GetByAccountId() failed:", err)
	}
	fmt.Println(getUser)
	//if getAccountId != 20 {
	//	t.Error("GetByAccountId() failed:", "%v != %v", user, getUser)
	//}
}