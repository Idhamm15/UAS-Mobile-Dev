package controllers

import (
	"net/http"
	"be/models"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type TaskHandler struct {
	DB *gorm.DB
}


// Create Task
func (t *TaskHandler) Create(c *gin.Context) {
    task := models.Task{}
    errBindJson := c.ShouldBindJSON(&task)
    if errBindJson != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": errBindJson.Error()})
        return
    }

    errDB := t.DB.Create(&task).Error
    if errDB != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": errDB.Error()})
        return
    }

    c.JSON(http.StatusCreated, task)
}

// Read All Tasks
func (t *TaskHandler) GetAll(c *gin.Context) {
    var tasks []models.Task
    errDB := t.DB.Find(&tasks).Error
    if errDB != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": errDB.Error()})
        return
    }

    c.JSON(http.StatusOK, tasks)
}

// Read Single Task
func (t *TaskHandler) GetOne(c *gin.Context) {
    id := c.Param("id")
    var task models.Task
    errDB := t.DB.First(&task, id).Error
    if errDB != nil {
        if errDB == gorm.ErrRecordNotFound {
            c.JSON(http.StatusNotFound, gin.H{"error": "Task not found"})
        } else {
            c.JSON(http.StatusInternalServerError, gin.H{"error": errDB.Error()})
        }
        return
    }

    c.JSON(http.StatusOK, task)
}

// Update Task
func (t *TaskHandler) Update(c *gin.Context) {
    id := c.Param("id")
    var task models.Task
    errDB := t.DB.First(&task, id).Error
    if errDB != nil {
        if errDB == gorm.ErrRecordNotFound {
            c.JSON(http.StatusNotFound, gin.H{"error": "Task not found"})
        } else {
            c.JSON(http.StatusInternalServerError, gin.H{"error": errDB.Error()})
        }
        return
    }

    errBindJson := c.ShouldBindJSON(&task)
    if errBindJson != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": errBindJson.Error()})
        return
    }

    errDB = t.DB.Save(&task).Error
    if errDB != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": errDB.Error()})
        return
    }

    c.JSON(http.StatusOK, task)
}

// Delete Task
func (t *TaskHandler) Delete(c *gin.Context) {
    id := c.Param("id")
    errDB := t.DB.Delete(&models.Task{}, id).Error
    if errDB != nil {
        if errDB == gorm.ErrRecordNotFound {
            c.JSON(http.StatusNotFound, gin.H{"error": "Task not found"})
        } else {
            c.JSON(http.StatusInternalServerError, gin.H{"error": errDB.Error()})
        }
        return
    }

    c.JSON(http.StatusOK, gin.H{"message": "delete succesfully"})
}
