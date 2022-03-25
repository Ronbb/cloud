package database

import (
	"testing"

	"github.com/ronbb/cloud/servers/models"
	"github.com/stretchr/testify/assert"
	"go.mongodb.org/mongo-driver/bson"
)

func TestCodec(t *testing.T) {
	assert := assert.New(t)
	codec := &Codec{}
	registry := bson.NewRegistryBuilder().RegisterHookDecoder(protoType, codec).RegisterHookEncoder(protoType, codec).Build()
	message := &models.TestAllType{
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
		OneofValue:      &models.TestAllType_OneofString{OneofString: "OneofString"},
		Id:              "id",
	}
	bytes, err := bson.MarshalWithRegistry(registry, message)
	assert.Nil(err)
	assert.NotEmpty(bytes)

	jsonMap := map[string]interface{}{}
	err = bson.Unmarshal(bytes, &jsonMap)
	assert.Nil(err)
	assert.NotNil(jsonMap)
	assert.NotNil(jsonMap["_id"])

	clonedMessage := &models.TestAllType{}
	err = bson.UnmarshalWithRegistry(registry, bytes, clonedMessage)
	assert.Nil(err)
	assert.EqualValues(message, clonedMessage)
}
