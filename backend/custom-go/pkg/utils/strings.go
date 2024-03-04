package utils

func GetStringValueWithDefault(val, defaultV string) string {
	if val == "" {
		return defaultV
	}
	return val
}
