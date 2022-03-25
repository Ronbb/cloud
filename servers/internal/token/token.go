package token

import (
	"crypto/ed25519"
	"crypto/rand"
	"os"

	"github.com/golang-jwt/jwt"
	"github.com/ronbb/cloud/servers/internal/utils"
)

var (
	jwtPublicKey  ed25519.PublicKey
	jwtPrivateKey ed25519.PrivateKey
)

const (
	jwtEnvironmentKey = "CLOUD_TOKEN_SEED"
)

type Claims = jwt.StandardClaims

func init() {
	key, ok := os.LookupEnv(jwtEnvironmentKey)
	reader := rand.Reader
	if ok && key != "" {
		reader = utils.NewLoopReader([]byte(key))
	}

	publicKey, privateKey, err := ed25519.GenerateKey(reader)
	if err != nil {
		panic(err.Error())
	}

	jwtPublicKey = publicKey
	jwtPrivateKey = privateKey
}

func Create(claims Claims) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodEdDSA, claims)

	return token.SignedString(jwtPrivateKey)
}

func Parse(tokenString string) (Claims, error) {
	token, err := jwt.Parse(tokenString, func(t *jwt.Token) (interface{}, error) {
		return jwtPublicKey, nil
	})
	if err != nil {
		return Claims{}, err
	}

	return token.Claims.(Claims), nil
}
