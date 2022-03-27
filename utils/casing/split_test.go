package casing

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestSplit(t *testing.T) {
	assert := assert.New(t)
	cases := []struct {
		Raw      string
		Splitted []string
		Camel    string
		Snake    string
	}{
		{
			"aa_bb",
			[]string{"aa", "bb"},
			"AaBb",
			"aa_bb",
		},
		{
			"aa_bb_12",
			[]string{"aa", "bb", "12"},
			"AaBb12",
			"aa_bb_12",
		},
		{
			"aa_bb12",
			[]string{"aa", "bb12"},
			"AaBb12",
			"aa_bb12",
		},
		{
			"aA_bb",
			[]string{"aA", "bb"},
			"AaBb",
			"aa_bb",
		},
		{
			"aa__Bb",
			[]string{"aa", "Bb"},
			"AaBb",
			"aa_bb",
		},
	}

	for _, c := range cases {
		assert.Equal(c.Splitted, split(c.Raw))
		assert.Equal(c.Camel, Camel(c.Raw))
		assert.Equal(c.Snake, Snake(c.Raw))
	}
}
