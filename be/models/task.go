package models

import "time"

type Task struct {
	Id           int       `gorm:"type:int; primaryKey; autoIncrement" json:"id"`
	UserId       int       `gorm:"int" json:"userId"`
	Title        string    `gorm:"type:varchar(255)" json:"title"`
	Description  string    `gorm:"type:text" json:"description"`
	CreatedAt    time.Time `json:"createdAt"`
	UpdatedAt    time.Time `json:"updatedAt"`
	User         User      `gorm:"foreignKey:UserId" json:"user,omitempty"` // belongs to
}
