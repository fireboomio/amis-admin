package base

import "encoding/json"

type WunderGraphUser struct {
	Provider          string          `json:"provider,omitempty"`
	ProviderId        string          `json:"providerId,omitempty"`
	UserId            string          `json:"userId,omitempty"`
	Name              string          `json:"name,omitempty"`
	FirstName         string          `json:"firstName,omitempty"`
	LastName          string          `json:"lastName,omitempty"`
	MiddleName        string          `json:"middleName,omitempty"`
	NickName          string          `json:"nickName,omitempty"`
	PreferredUsername string          `json:"preferredUsername,omitempty"`
	Profile           string          `json:"profile,omitempty"`
	Picture           string          `json:"picture,omitempty"`
	Website           string          `json:"website,omitempty"`
	Email             string          `json:"email,omitempty"`
	EmailVerified     bool            `json:"emailVerified,omitempty"`
	Gender            string          `json:"gender,omitempty"`
	BirthDate         string          `json:"birthDate,omitempty"`
	ZoneInfo          string          `json:"zoneInfo,omitempty"`
	Locale            string          `json:"locale,omitempty"`
	Location          string          `json:"location,omitempty"`
	Roles             []string        `json:"roles,omitempty"`
	CustomAttributes  []string        `json:"customAttributes,omitempty"`
	CustomClaims      map[string]any  `json:"customClaims,omitempty"`
	AccessToken       json.RawMessage `json:"accessToken,omitempty"`
	RawAccessToken    string          `json:"rawAccessToken,omitempty"`
	IdToken           json.RawMessage `json:"idToken,omitempty"`
	RawIdToken        string          `json:"rawIdToken,omitempty"`
}
