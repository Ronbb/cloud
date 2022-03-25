package database

import (
	"fmt"
	"reflect"
	"strconv"

	"go.mongodb.org/mongo-driver/bson/bsoncodec"
	"go.mongodb.org/mongo-driver/bson/bsonrw"
	"go.mongodb.org/mongo-driver/bson/bsontype"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"google.golang.org/protobuf/encoding/prototext"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
)

const (
	fieldIdProtoName = "id"
	fieldIdBsonName  = "_id"
	fieldIdKind      = protoreflect.StringKind
)

type Codec struct{}

func (c *Codec) DecodeValue(context bsoncodec.DecodeContext, reader bsonrw.ValueReader, value reflect.Value) error {
	messageValue := value.Addr().Interface().(proto.Message).ProtoReflect()
	documentReader, err := reader.ReadDocument()
	if err != nil {
		return err
	}

	return c.decodeMessage(context, documentReader, messageValue)
}

func (c *Codec) decodeMessage(
	context bsoncodec.DecodeContext,
	documentReader bsonrw.DocumentReader,
	messageValue protoreflect.Message,
) error {
	message := messageValue.Descriptor()
	fields := message.Fields()
	for {
		key, valueReader, err := documentReader.ReadElement()
		if err != nil {
			break
		}

		if c.isBsonFieldId(key, fields) {
			c.decodeId(context, valueReader, messageValue)
			continue
		}

		field := fields.ByJSONName(key)
		if field == nil {
			continue
		}

		kind := field.Kind()

		if field.IsList() {
			arrayReader, err := valueReader.ReadArray()
			if err != nil {
				continue
			}

			err = c.decodeArray(context, arrayReader, kind, messageValue.Mutable(field).List())
			if err != nil {
				continue
			}

			continue
		}

		if field.IsMap() {
			// TODO
			documentReader, err := valueReader.ReadDocument()
			if err != nil {
				continue
			}

			// Key in map fields cannot be float/double, bytes or message types.
			c.decodeMap(
				context,
				documentReader,
				field.MapKey().Kind(),
				field.MapValue().Kind(),
				messageValue.Mutable(field).Map(),
			)

			continue
		}

		if kind == protoreflect.MessageKind {
			documentReader, err := valueReader.ReadDocument()
			if err != nil {
				continue
			}
			c.decodeMessage(context, documentReader, messageValue.Mutable(field).Message())
			continue
		}

		baseValue, err := c.decodeBase(context, valueReader, kind)
		if err != nil {
			continue
		}

		messageValue.Set(field, baseValue)
	}

	return nil
}

func (c *Codec) isBsonFieldId(key string, fields protoreflect.FieldDescriptors) bool {
	// check name
	if key != fieldIdBsonName {
		return false
	}

	// check if field exists
	field := fields.ByName(fieldIdProtoName)
	if field == nil {
		return false
	}

	// check if type matches
	if field.Kind() != fieldIdKind {
		return false
	}

	return true
}

func (c *Codec) decodeId(
	context bsoncodec.DecodeContext,
	valueReader bsonrw.ValueReader,
	messageValue protoreflect.Message,
) error {
	var value string
	switch valueReader.Type() {
	case bsontype.ObjectID:
		id, err := valueReader.ReadObjectID()
		if err != nil {
			return err
		}
		value = id.Hex()
	case bsontype.String:
		id, err := valueReader.ReadString()
		if err != nil {
			return err
		}
		value = id
	}

	messageValue.Set(
		messageValue.Descriptor().Fields().ByName(fieldIdProtoName),
		protoreflect.ValueOfString(value),
	)

	return nil
}

func (c *Codec) decodeMap(
	context bsoncodec.DecodeContext,
	documentReader bsonrw.DocumentReader,
	keyKind protoreflect.Kind,
	valueKind protoreflect.Kind,
	mapValue protoreflect.Map,
) error {
	for {
		key, valueReader, err := documentReader.ReadElement()
		if err != nil {
			break
		}

		mapKeyValue, err := c.decodeBaseFromString(context, key, keyKind)
		if err != nil {
			continue
		}
		mapKey := protoreflect.MapKey(mapKeyValue)

		if valueKind == protoreflect.MessageKind {
			documentReader, err := valueReader.ReadDocument()
			if err != nil {
				continue
			}
			c.decodeMessage(context, documentReader, mapValue.Mutable(mapKey).Message())
			continue
		}

		baseValue, err := c.decodeBase(context, valueReader, valueKind)
		if err != nil {
			continue
		}

		mapValue.Set(mapKey, baseValue)
	}

	return nil
}

func (c *Codec) decodeArray(
	context bsoncodec.DecodeContext,
	reader bsonrw.ArrayReader,
	kind protoreflect.Kind,
	listValue protoreflect.List,
) error {
	for {
		valueReader, err := reader.ReadValue()
		if err != nil {
			break
		}

		if kind == protoreflect.MessageKind {
			documentReader, err := valueReader.ReadDocument()
			if err != nil {
				continue
			}

			c.decodeMessage(context, documentReader, listValue.AppendMutable().Message())
		} else {
			baseValue, err := c.decodeBase(context, valueReader, kind)
			if err != nil {
				continue
			}

			listValue.Append(baseValue)
		}

	}

	return nil
}

func (c *Codec) decodeBase(
	context bsoncodec.DecodeContext,
	reader bsonrw.ValueReader,
	kind protoreflect.Kind,
) (value protoreflect.Value, err error) {
	switch kind {
	case protoreflect.BoolKind:
		var boolValue bool
		boolValue, err = reader.ReadBoolean()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfBool(boolValue)
	case protoreflect.EnumKind:
		var int32Value int32
		int32Value, err = reader.ReadInt32()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfEnum(protoreflect.EnumNumber(int32Value))
	case protoreflect.Int32Kind:
		fallthrough
	case protoreflect.Sint32Kind:
		fallthrough
	case protoreflect.Sfixed32Kind:
		var int32Value int32
		int32Value, err = reader.ReadInt32()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfInt32(int32Value)
	case protoreflect.Fixed32Kind:
		fallthrough
	case protoreflect.Uint32Kind:
		var uint32Value int32
		uint32Value, err = reader.ReadInt32()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfUint32(uint32(uint32Value))
	case protoreflect.Int64Kind:
		fallthrough
	case protoreflect.Sint64Kind:
		fallthrough
	case protoreflect.Sfixed64Kind:
		var int64Value int64
		int64Value, err = reader.ReadInt64()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfInt64(int64Value)
	case protoreflect.Fixed64Kind:
		fallthrough
	case protoreflect.Uint64Kind:
		var int64Value int64
		int64Value, err = reader.ReadInt64()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfUint64(uint64(int64Value))
	case protoreflect.FloatKind:
		var doubleValue float64
		doubleValue, err = reader.ReadDouble()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfFloat32(float32(doubleValue))
	case protoreflect.DoubleKind:
		var doubleValue float64
		doubleValue, err = reader.ReadDouble()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfFloat64(doubleValue)
	case protoreflect.StringKind:
		var stringValue string
		stringValue, err = reader.ReadString()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfString(stringValue)
	case protoreflect.BytesKind:
		var bytesValue []byte
		bytesValue, _, err = reader.ReadBinary()
		if err != nil {
			break
		}
		value = protoreflect.ValueOfBytes(bytesValue)
	default:
		err = fmt.Errorf("unknown value kind: %v", kind)
	}

	return
}

func (c *Codec) decodeBaseFromString(
	context bsoncodec.DecodeContext,
	stringValue string,
	kind protoreflect.Kind,
) (value protoreflect.Value, err error) {
	switch kind {
	case protoreflect.BoolKind:
		var boolValue bool
		boolValue, err = strconv.ParseBool(stringValue)
		if err != nil {
			break
		}
		value = protoreflect.ValueOfBool(boolValue)
	case protoreflect.EnumKind:
		var int64Value int64
		int64Value, err = strconv.ParseInt(stringValue, 10, 32)
		if err != nil {
			break
		}
		value = protoreflect.ValueOfEnum(protoreflect.EnumNumber(int32(int64Value)))
	case protoreflect.Int32Kind:
		fallthrough
	case protoreflect.Sint32Kind:
		fallthrough
	case protoreflect.Sfixed32Kind:
		var int64Value int64
		int64Value, err = strconv.ParseInt(stringValue, 10, 32)
		if err != nil {
			break
		}
		value = protoreflect.ValueOfInt32(int32(int64Value))
	case protoreflect.Fixed32Kind:
		fallthrough
	case protoreflect.Uint32Kind:
		var uint64Value uint64
		uint64Value, err = strconv.ParseUint(stringValue, 10, 32)
		if err != nil {
			break
		}
		value = protoreflect.ValueOfUint32(uint32(uint64Value))
	case protoreflect.Int64Kind:
		fallthrough
	case protoreflect.Sint64Kind:
		fallthrough
	case protoreflect.Sfixed64Kind:
		var int64Value int64
		int64Value, err = strconv.ParseInt(stringValue, 10, 64)
		if err != nil {
			break
		}
		value = protoreflect.ValueOfInt64(int64Value)
	case protoreflect.Fixed64Kind:
		fallthrough
	case protoreflect.Uint64Kind:
		var uint64Value uint64
		uint64Value, err = strconv.ParseUint(stringValue, 10, 64)
		if err != nil {
			break
		}
		value = protoreflect.ValueOfUint64(uint64Value)
	case protoreflect.FloatKind:
		var doubleValue float64
		doubleValue, err = strconv.ParseFloat(stringValue, 32)
		if err != nil {
			break
		}
		value = protoreflect.ValueOfFloat32(float32(doubleValue))
	case protoreflect.DoubleKind:
		var doubleValue float64
		doubleValue, err = strconv.ParseFloat(stringValue, 64)
		if err != nil {
			break
		}
		value = protoreflect.ValueOfFloat64(doubleValue)
	case protoreflect.StringKind:
		value = protoreflect.ValueOfString(stringValue)
	case protoreflect.BytesKind:
		value = protoreflect.ValueOfBytes([]byte(stringValue))
	default:
		err = fmt.Errorf("unknown value kind: %v", kind)
	}

	return
}

func (c *Codec) EncodeValue(context bsoncodec.EncodeContext, writer bsonrw.ValueWriter, value reflect.Value) error {
	messageValue := value.Interface().(proto.Message).ProtoReflect()
	documentWriter, err := writer.WriteDocument()
	if err != nil {
		return err
	}

	err = c.encodeMessage(context, documentWriter, messageValue)
	if err != nil {
		return err
	}

	return documentWriter.WriteDocumentEnd()
}

func (c *Codec) encodeMessage(
	context bsoncodec.EncodeContext,
	documentWriter bsonrw.DocumentWriter,
	messageValue protoreflect.Message,
) error {
	message := messageValue.Descriptor()
	fields := message.Fields()
	fieldLength := fields.Len()

	for fieldIndex := 0; fieldIndex < fieldLength; fieldIndex++ {
		field := fields.Get(fieldIndex)
		if !messageValue.Has(field) {
			continue
		}
		kind := field.Kind()
		fieldValue := messageValue.Get(field)

		if c.isProtoFieldId(field) {
			valueWriter, err := documentWriter.WriteDocumentElement(fieldIdBsonName)
			if err != nil {
				continue
			}
			c.encodeId(context, valueWriter, fieldValue)
			continue
		}

		valueWriter, err := documentWriter.WriteDocumentElement(field.JSONName())
		if err != nil {
			continue
		}

		if field.IsList() {
			list := fieldValue.List()
			length := list.Len()
			arrayWriter, err := valueWriter.WriteArray()
			if err != nil {
				continue
			}

			for i := 0; i < length; i++ {
				valueWriter, err := arrayWriter.WriteArrayElement()
				if err != nil {
					continue
				}
				c.encodeValue(context, valueWriter, kind, list.Get(i))
			}

			arrayWriter.WriteArrayEnd()

			continue
		}

		if field.IsMap() {
			m := fieldValue.Map()
			mapKeyKind := field.MapKey().Kind()
			mapValueKind := field.MapValue().Kind()

			documentWriter, err := valueWriter.WriteDocument()
			if err != nil {
				continue
			}
			m.Range(func(key protoreflect.MapKey, value protoreflect.Value) bool {
				keyString, err := c.encodeValueToString(context, mapKeyKind, key.Value())
				if err != nil {
					return true
				}
				valueWriter, err := documentWriter.WriteDocumentElement(keyString)
				if err != nil {
					return true
				}
				c.encodeValue(context, valueWriter, mapValueKind, value)
				return true
			})

			documentWriter.WriteDocumentEnd()

			continue
		}

		c.encodeValue(context, valueWriter, field.Kind(), fieldValue)
	}

	return nil
}

func (c *Codec) isProtoFieldId(field protoreflect.FieldDescriptor) bool {
	// check name
	if field.Name() != fieldIdProtoName {
		return false
	}

	// check if type matches
	if field.Kind() != fieldIdKind {
		return false
	}

	return true
}

func (c *Codec) encodeId(
	context bsoncodec.EncodeContext,
	valueWriter bsonrw.ValueWriter,
	value protoreflect.Value,
) error {
	id, err := primitive.ObjectIDFromHex(value.String())
	if err != nil {
		return valueWriter.WriteString(value.String())
	}

	return valueWriter.WriteObjectID(id)
}

func (c *Codec) encodeValueToString(
	context bsoncodec.EncodeContext,
	kind protoreflect.Kind,
	value protoreflect.Value,
) (string, error) {
	switch kind {
	case protoreflect.BoolKind:
		fallthrough
	case protoreflect.EnumKind:
		fallthrough
	case protoreflect.Int32Kind:
		fallthrough
	case protoreflect.Sint32Kind:
		fallthrough
	case protoreflect.Sfixed32Kind:
		fallthrough
	case protoreflect.Fixed32Kind:
		fallthrough
	case protoreflect.Uint32Kind:
		fallthrough
	case protoreflect.Int64Kind:
		fallthrough
	case protoreflect.Sint64Kind:
		fallthrough
	case protoreflect.Sfixed64Kind:
		fallthrough
	case protoreflect.Fixed64Kind:
		fallthrough
	case protoreflect.Uint64Kind:
		fallthrough
	case protoreflect.FloatKind:
		fallthrough
	case protoreflect.DoubleKind:
		fallthrough
	case protoreflect.StringKind:
		return value.String(), nil
	case protoreflect.BytesKind:
		return string(value.Bytes()), nil
	case protoreflect.MessageKind:
		bytes, err := prototext.Marshal(value.Message().Interface())
		if err != nil {
			return "", err
		}
		return string(bytes), nil
	default:
		return "", fmt.Errorf("unknown value kind: %v", kind)
	}
}

func (c *Codec) encodeValue(
	context bsoncodec.EncodeContext,
	valueWriter bsonrw.ValueWriter,
	kind protoreflect.Kind,
	fieldValue protoreflect.Value,
) error {
	switch kind {
	case protoreflect.BoolKind:
		return valueWriter.WriteBoolean(fieldValue.Bool())
	case protoreflect.EnumKind:
		return valueWriter.WriteInt32(int32(fieldValue.Enum()))
	case protoreflect.Int32Kind:
		fallthrough
	case protoreflect.Sint32Kind:
		fallthrough
	case protoreflect.Sfixed32Kind:
		return valueWriter.WriteInt32(int32(fieldValue.Int()))
	case protoreflect.Fixed32Kind:
		fallthrough
	case protoreflect.Uint32Kind:
		return valueWriter.WriteInt32(int32(fieldValue.Uint()))
	case protoreflect.Int64Kind:
		fallthrough
	case protoreflect.Sint64Kind:
		fallthrough
	case protoreflect.Sfixed64Kind:
		return valueWriter.WriteInt64(int64(fieldValue.Int()))
	case protoreflect.Fixed64Kind:
		fallthrough
	case protoreflect.Uint64Kind:
		return valueWriter.WriteInt64(int64(fieldValue.Uint()))
	case protoreflect.FloatKind:
		fallthrough
	case protoreflect.DoubleKind:
		return valueWriter.WriteDouble(fieldValue.Float())
	case protoreflect.StringKind:
		return valueWriter.WriteString(fieldValue.String())
	case protoreflect.BytesKind:
		return valueWriter.WriteBinary(fieldValue.Bytes())
	case protoreflect.MessageKind:
		documentWriter, err := valueWriter.WriteDocument()
		if err != nil {
			return err
		}
		err = c.encodeMessage(context, documentWriter, fieldValue.Message())
		if err != nil {
			return err
		}
		return documentWriter.WriteDocumentEnd()
	default:
		return fmt.Errorf("unknown value kind: %v", kind)
	}
}
