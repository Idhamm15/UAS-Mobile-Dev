package main

import (
	"net/http"
	"be/databases"
	"be/handlers"
	"be/models"

	"github.com/gin-gonic/gin"
)

func main() {
	// Database
	db := config.DatabaseConnection()
	db.AutoMigrate(&models.User{}, &models.Task{})
	config.CreateOwnerAccount(db)



	// Controller
	userHandler := controllers.UserHandler{DB: db}
	taskHandler := controllers.TaskHandler{DB: db}

	// Router
	router := gin.Default()

	// Middleware untuk menambahkan header CORS
	router.Use(func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type")
		c.Writer.Header().Set("Access-Control-Max-Age", "86400")
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(http.StatusOK)
			return
		}
		c.Next()
	})
	
	router.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, "Welcome to Task API")
	})

	router.POST("/users/login", userHandler.Login)
	router.POST("/users", userHandler.CreateAccount)
	router.DELETE("/users/:id", userHandler.Delete)
	router.GET("/users/Employee", userHandler.GetEmployee)

	router.POST("/tasks", taskHandler.Create)
	router.GET("/tasks", taskHandler.GetAll)
	router.GET("/tasks/:id", taskHandler.GetOne)
	router.PUT("/tasks/:id", taskHandler.Update)
	router.DELETE("/tasks/:id", taskHandler.Delete)

	// Menjalankan server pada localhost
	router.Run("localhost:8080")
	// Alternatif: router.Run(":8080") // untuk mendengarkan pada semua antarmuka jaringan
}
