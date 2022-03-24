package database

import (
	"strconv"
	"strings"

	"go.mongodb.org/mongo-driver/bson"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
)

// not thread safe
type FlattenOptions struct {
	result bson.D
}

func (fo FlattenOptions) Flatten(message proto.Message) bson.D {
	fo.result = bson.D{}

	fo.handleMessage(message.ProtoReflect(), []string{})

	return fo.result
}

func (fo *FlattenOptions) handleValue(value protoreflect.Value, path []string, name string) {
	valueInterface := value.Interface()
	if message, ok := valueInterface.(protoreflect.Message); ok {
		fo.handleMessage(message, append(path, name))
		return
	}
	if list, ok := valueInterface.(protoreflect.List); ok {
		fo.handleList(list, append(path, name))
		return
	}
	if m, ok := valueInterface.(protoreflect.Map); ok {
		fo.handleMap(m, append(path, name))
		return
	}
	fo.result = append(fo.result, bson.E{
		Key:   fo.key(path, name),
		Value: value.Interface(),
	})
}

func (fo *FlattenOptions) key(path []string, name string) string {
	path = append(path, name)
	return strings.Join(path, ".")
}

func (fo *FlattenOptions) handleMessage(message protoreflect.Message, path []string) {
	messageDescriptor := message.Descriptor()
	fields := messageDescriptor.Fields()
	fieldLength := fields.Len()
	for i := 0; i < fieldLength; i++ {
		field := fields.Get(i)
		value := message.Get(field)
		name := field.JSONName()
		fo.handleValue(value, path, name)
	}
}

func (fo *FlattenOptions) handleList(list protoreflect.List, path []string) {
	listLength := list.Len()
	for i := 0; i < listLength; i++ {
		element := list.Get(i)
		fo.handleValue(element, path, strconv.FormatInt(int64(i), 10))
	}
}

func (fo *FlattenOptions) handleMap(m protoreflect.Map, path []string) {
	m.Range(func(key protoreflect.MapKey, value protoreflect.Value) bool {
		fo.handleValue(value, path, key.String())
		return true
	})
}
