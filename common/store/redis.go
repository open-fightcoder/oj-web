package store

import (
	"sync"

	"github.com/go-redis/redis"
	"github.com/open-fightcoder/oj-web/common/g"
)

var RedisClient *redis.Client
var once sync.Once

func InitRedis() {
	once.Do(func() {
		cfg := g.Conf().Redis
		RedisClient = redis.NewClient(&redis.Options{
			Addr:     cfg.Address,
			Password: cfg.Password,
			DB:       cfg.Database,
			PoolSize: cfg.PoolSize,
		})
	})
	_, err := RedisClient.Ping().Result()
	if err != nil {
		//write log
	}
}

func CloseRedis() {
	RedisClient.Close()
}
