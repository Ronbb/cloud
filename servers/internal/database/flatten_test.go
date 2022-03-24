package database_test

import (
	"testing"

	"github.com/ronbb/servers/internal/database"
	"github.com/ronbb/servers/models"
	"github.com/stretchr/testify/assert"
)

func TestFlatten(t *testing.T) {
	assert := assert.New(t)

	request := &models.TestAllType{
		Bool:            true,
		Bytes:           []byte{0, 0, 1},
		Double:          2.33,
		Fixed32:         2,
		Fixed64:         4,
		Float:           -6.66,
		Int32:           12,
		Int64:           -12,
		MapBoolString:   map[bool]string{true: "true"},
		Sint32:          -32,
		Sint64:          -64,
		Sfixed32:        -132,
		Sfixed64:        -164,
		String_:         "string",
		Uint32:          32,
		Uint64:          64,
		RepeatedDoubles: []float64{12.1, 22.4},
		Message:         &models.TestAllType_Message{String_: "string2", Uint32: 99},
		Enum:            models.TestAllType_ENUM_2,
	}

	filter := database.Filter(request).Map()
	assert.Equal(request.Bool, filter["bool"])
	assert.Equal(request.Bytes, filter["bytes"])
	assert.Equal(request.Double, filter["double"])
	assert.Equal(request.Fixed32, filter["fixed32"])
	assert.Equal(request.Fixed64, filter["fixed64"])
	assert.Equal(request.Float, filter["float"])
	assert.Equal(request.Int32, filter["int32"])
	assert.Equal(request.Int64, filter["int64"])
	assert.Equal(request.MapBoolString[true], filter["mapBoolString.true"])
	assert.Equal(request.Sint32, filter["sint32"])
	assert.Equal(request.Sint64, filter["sint64"])
	assert.Equal(request.Sfixed32, filter["sfixed32"])
	assert.Equal(request.Sfixed64, filter["sfixed64"])
	assert.Equal(request.String_, filter["string"])
	assert.Equal(request.Uint32, filter["uint32"])
	assert.Equal(request.Uint64, filter["uint64"])
	assert.Equal(request.RepeatedDoubles[0], filter["repeatedDoubles.0"])
	assert.Equal(request.RepeatedDoubles[1], filter["repeatedDoubles.1"])
	assert.Equal(request.Message.String_, filter["message.string"])
	assert.Equal(request.Message.Uint32, filter["message.uint32"])
	assert.Equal(request.Enum.Number(), filter["enum"])
}
