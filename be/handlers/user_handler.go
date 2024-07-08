package controllers

import (
	"net/http"
	"be/models"

	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
	"gorm.io/gorm"
)

type UserHandler struct {
	DB *gorm.DB
}

func (u *UserHandler) Login(c *gin.Context) {
	user := models.User{}
	errBindJson := c.ShouldBindJSON(&user)
	if errBindJson != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": errBindJson.Error()})
		return
	}

	password := user.Password

	errDB := u.DB.Where("email=?", user.Email).Take(&user).Error
	if errDB != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Email or Password is Wrong"})
		return
	}

	errHash := bcrypt.CompareHashAndPassword(
		[]byte(user.Password),
		[]byte(password),
	)
	if errHash != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Email or Password is Wrong"})
		return
	}

	c.JSON(http.StatusOK, user)
}

func (u *UserHandler) CreateAccount(c *gin.Context) {
	user := models.User{}
	errBindJson := c.ShouldBindJSON(&user)
	if errBindJson != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": errBindJson.Error()})
		return
	}

	emailExist := u.DB.Where("email=?", user.Email).First(&user).RowsAffected != 0
	if emailExist {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Email already exist"})
		return
	}

	hashedPasswordBytes, _ := bcrypt.GenerateFromPassword([]byte("123456"), bcrypt.DefaultCost)

	user.Password = string(hashedPasswordBytes)
	user.Role = "Employee"

	errDB := u.DB.Create(&user).Error
	if errDB != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": errDB.Error()})
		return
	}

	c.JSON(http.StatusCreated, user)
}

func (u *UserHandler) Delete(c *gin.Context) {
	id := c.Param("id")

	errDB := u.DB.Delete(&models.User{}, id).Error
	if errDB != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": errDB.Error()})
		return
	}

	c.JSON(http.StatusOK, "Deleted")
}

func (u *UserHandler) GetEmployee(c *gin.Context) {
	users := []models.User{}

	errDB := u.DB.Select("id,name").Where("role=?", "Employee").Find(&users).Error
	if errDB != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": errDB.Error()})
		return
	}

	c.JSON(http.StatusOK, users)
}
