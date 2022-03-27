package casing

import "strings"

func Camel(raw string) string {
	return splitAndJoin(
		raw,
		func(word string) string {
			return strings.ToUpper(word[0:1]) + strings.ToLower(word[1:])
		},
		"",
	)
}
