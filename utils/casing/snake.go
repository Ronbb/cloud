package casing

import "strings"

func Snake(raw string) string {
	return splitAndJoin(
		raw,
		strings.ToLower,
		"_",
	)
}
