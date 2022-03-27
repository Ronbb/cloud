package main

import (
	"flag"

	"google.golang.org/protobuf/compiler/protogen"
	"google.golang.org/protobuf/types/pluginpb"
)

const SupportedFeatures = uint64(pluginpb.CodeGeneratorResponse_FEATURE_PROTO3_OPTIONAL)

func main() {
	var flags flag.FlagSet
	protogen.Options{
		ParamFunc: flags.Set,
	}.Run(func(plugin *protogen.Plugin) error {
		plugin.SupportedFeatures = SupportedFeatures
		for _, f := range plugin.Files {
			if f.Generate {
				generateFile(plugin, f)
			}
		}
		return nil
	})
}

func generateFile(plugin *protogen.Plugin, file *protogen.File) *protogen.GeneratedFile {
	if len(file.Services) == 0 {
		return nil
	}
	filename := file.GeneratedFilenamePrefix + "_http.pb.go"
	generatedFile := plugin.NewGeneratedFile(filename, file.GoImportPath)
	err := fileTemplate.Execute(generatedFile, file)
	if err != nil {
		plugin.Error(err)
		return nil
	}

	file.Services[0].Methods[0].Desc.IsStreamingServer()

	return generatedFile
}
