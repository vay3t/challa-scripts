package main

import (
	"fmt"
	"strings"

	"github.com/gocolly/colly"
)

var (
	target string = "https://"
)

func main() {
	domain := strings.Split(target, "/")[2]

	c := colly.NewCollector(
		colly.AllowedDomains(domain),
		colly.MaxDepth(2),
		colly.Async(true),
	)

	c.Limit(&colly.LimitRule{DomainGlob: "*", Parallelism: 2})

	// Find and visit all links
	c.OnHTML("a", func(e *colly.HTMLElement) {
		e.Request.Visit(e.Attr("href"))
	})

	c.OnRequest(func(r *colly.Request) {
		fmt.Println(r.URL)
	})

	c.Visit(target)
	c.Wait()
}
