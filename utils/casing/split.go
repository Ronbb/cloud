package casing

import (
	"strings"
	"unicode"
)

func split(raw string) []string {
	return strings.FieldsFunc(raw, func(r rune) bool {
		return !unicode.IsNumber(r) && !unicode.IsLetter(r)
	})
}

func splitAndJoin(raw string, f func(word string) string, seperator string) string {
	words := split(raw)
	for i := 0; i < len(words); i++ {
		word := words[i]
		if len(word) == 0 {
			continue
		}
		words[i] = f(word)
	}

	return strings.Join(words, seperator)
}
