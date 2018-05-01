package managers

import (
	"encoding/json"
	"io"

	"github.com/open-fightcoder/oj-web/models"
	"github.com/open-fightcoder/oj-web/redis"
	"github.com/pkg/errors"
)

type SubmitCount struct {
	Accepted            int64 `json:"accepted"`
	WrongAnswer         int64 `json:"wrong_answer"`
	CompilationError    int64 `json:"compilation_error"`
	TimeLimitExceeded   int64 `json:"time_limit_exceeded"`
	MemoryLimitExceeded int64 `json:"memory_limit_exceeded"`
	OutputLimitExceeded int64 `json:"output_limit_exceeded"`
	RuntimeError        int64 `json:"runtime_error"`
	SystemError         int64 `json:"system_error"`
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
		"daily_address": user.DailyAddress,
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
	acNum, _ := redis.GetAcNumByUserId(user.Id)
	problemMess := map[string]interface{}{
		"pre_num":  500,
		"ac_num":   acNum,
		"fail_num": 10,
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
