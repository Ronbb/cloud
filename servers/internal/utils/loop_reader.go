package utils

import (
	"io"
)

type loopReader struct {
	raw    []byte
	index  int
	length int
}

func (lr *loopReader) Reset() {
	lr.index = 0
}

func (lr *loopReader) Read(p []byte) (n int, err error) {
	for i := 0; i < len(p); i++ {
		dataPos := (lr.index + i) % lr.length
		p[i] = lr.raw[dataPos]
	}
	lr.index = (lr.index + len(p)) % lr.length
	return len(p), nil
}

func NewLoopReader(data []byte) io.Reader {
	return &loopReader{data, 0, len(data)}
}
