package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
    // Create a Gin router instance
    r := gin.Default()

	r.GET("/", func(c *gin.Context) {
        c.String(200, "Ini Index")
    })

    r.GET("/hello", func(c *gin.Context) {
        c.String(200, "Hello, World!")
    })

    // Start the server on port 8080
    r.Run(":8080")
}
