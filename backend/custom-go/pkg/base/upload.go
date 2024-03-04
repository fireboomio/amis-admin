package base

type WunderGraphFile struct {
	Name     string `json:"name"`
	Size     int    `json:"size"`
	Type     string `json:"type"`
	Provider string `json:"provider"`
}

type UploadHookResponse struct {
	FileKey string `json:"fileKey"`
	Error   string `json:"error"`
}
