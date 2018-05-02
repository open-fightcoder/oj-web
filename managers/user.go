package managers

import (
	"encoding/json"
	"io"

	"strings"

	"github.com/open-fightcoder/oj-web/models"
	"github.com/open-fightcoder/oj-web/redis"
	"github.com/pkg/errors"
)

type SubmitCount struct {
	Accepted            int64 `json:"accepted"`
	FailNum             int64 `json:"fail_num"`
	WrongAnswer         int64 `json:"wrong_answer"`
	CompilationError    int64 `json:"compilation_error"`
	TimeLimitExceeded   int64 `json:"time_limit_exceeded"`
	MemoryLimitExceeded int64 `json:"memory_limit_exceeded"`
	OutputLimitExceeded int64 `json:"output_limit_exceeded"`
	RuntimeError        int64 `json:"runtime_error"`
	SystemError         int64 `json:"system_error"`
}

func UpdateUserMess(userId int64, userName string, NickName string, Sex string, Blog string, Git string, Description string, Birthday string, DailyAddress string, StatSchool string, SchoolName string) error {
	user, err := models.GetByUserName(userName)
	if err != nil {
		return errors.New("获取失败")
	}
	if user == nil {
		return errors.New("用户名不存在")
	}
	if user.Id != userId {
		return errors.New("无权修改该用户信息")
	}
	userMess := &models.User{user.Id, user.AccountId, user.UserName, NickName, Sex, user.Avator, Blog, Git, Description, Birthday, DailyAddress, StatSchool, SchoolName}
	err = models.Update(userMess)
	if err != nil {
		return errors.New("更新失败")
	}
	return nil
}

func UploadImage(reader io.Reader, userId int64, picType string) error {
	path, err := SaveImg(reader, userId, picType)
	if err != nil {
		return errors.New("上传失败")
	}
	user, err := models.GetById(userId)
	if err != nil || user == nil {
		return errors.New("上传失败")
	}
	user.Avator = path
	err = models.Update(user)
	if err != nil {
		return errors.New("上传失败")
	}
	return nil
}

func GetUserRecentSubmit(userName string) ([]map[string]interface{}, error) {
	user, err := models.GetByUserName(userName)
	if err != nil {
		return nil, errors.New("获取失败")
	}
	if user == nil {
		return nil, errors.New("用户名不存在")
	}
	mess, err := models.UserCountGetRecentMess(user.Id)
	if err != nil {
		return nil, errors.New("查询失败")
	}
	var messLists []map[string]interface{}
	for _, v := range mess {
		projects := make(map[string]interface{})
		projects["submit_num"] = v.SubmitNum
		projects["date"] = v.DateTime
		messLists = append(messLists, projects)
	}
	return messLists, nil
}

func GetUserRecentRank(userName string) ([]map[string]interface{}, error) {
	user, err := models.GetByUserName(userName)
	if err != nil {
		return nil, errors.New("获取失败")
	}
	if user == nil {
		return nil, errors.New("用户名不存在")
	}

	mess, err := models.UserCountGetRecentMess(user.Id)
	if err != nil {
		return nil, errors.New("查询失败")
	}
	var messLists []map[string]interface{}
	for _, v := range mess {
		projects := make(map[string]interface{})
		projects["rank_num"] = v.RankNum
		projects["date"] = v.DateTime
		messLists = append(messLists, projects)
	}
	return messLists, nil
}

func GetUserMess(userName string) (map[string]interface{}, error) {
	user, err := models.GetByUserName(userName)
	if err != nil {
		return nil, errors.New("获取失败")
	}
	if user == nil {
		return nil, errors.New("用户名不存在")
	}
	problemMess := map[string]interface{}{
		"account_id":    user.AccountId,
		"user_name":     user.UserName,
		"nick_name":     user.NickName,
		"sex":           user.Sex,
		"avator":        user.Avator,
		"blog":          user.Blog,
		"git":           user.Git,
		"description":   user.Description,
		"birthday":      user.Birthday,
		"daily_address": strings.Split(user.DailyAddress, ","),
		"stat_school":   user.StatSchool,
		"school_name":   user.SchoolName,
	}
	return problemMess, nil
}

func GetUserProgress(userName string) (map[string]interface{}, error) {
	user, err := models.GetByUserName(userName)
	if err != nil {
		return nil, errors.New("获取失败")
	}
	if user == nil {
		return nil, errors.New("用户名不存在")
	}
	jsonStr, err := redis.SubmitCountGet(user.Id)
	if err != nil {
		return nil, errors.New("获取失败")
	}
	problemTotal, err := redis.ProblemNumGet()
	if err != nil {
		return nil, errors.New("获取失败")
	}
	var submitCount SubmitCount
	err = json.Unmarshal([]byte(jsonStr), &submitCount)
	if err != nil {
		return nil, errors.New("获取失败")
	}
	problemMess := map[string]interface{}{
		"pre_num":  problemTotal,
		"ac_num":   submitCount.Accepted,
		"fail_num": submitCount.FailNum,
	}
	return problemMess, nil
}

func GetUserCount(userName string) (map[string]interface{}, error) {
	user, err := models.GetByUserName(userName)
	if err != nil {
		return nil, errors.New("获取失败")
	}
	if user == nil {
		return nil, errors.New("用户名不存在")
	}
	jsonStr, err := redis.SubmitCountGet(user.Id)
	if err != nil {
		return nil, errors.New("获取失败")
	}
	var submitCount SubmitCount
	err = json.Unmarshal([]byte(jsonStr), &submitCount)
	if err != nil {
		return nil, errors.New("获取失败")
	}
	problemMess := map[string]interface{}{
		"wa_num": submitCount.WrongAnswer,
		"ce_num": submitCount.CompilationError,
		"te_num": submitCount.TimeLimitExceeded,
		"me_num": submitCount.MemoryLimitExceeded,
		"oe_num": submitCount.OutputLimitExceeded,
		"re_num": submitCount.RuntimeError,
		"se_num": submitCount.SystemError,
		"ac_num": submitCount.Accepted,
	}
	return problemMess, nil
}
