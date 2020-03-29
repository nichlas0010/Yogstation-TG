// List is formatted as follows:
// Every key is the name of the impediment, and every value is a list of 4 values:
// 1st is the "nominal" catch; for lisps, it'd be 's'
// 2nd is the "nominal" change; for lisps, it'd be 'th'
// 3rd is the actual regex catch that's implemented. For lisps this would also be 's', but can be more advanced as needed for the regex.
// 4th is the actual replacement that's implemented. For lisps this would also be 'th', but can be more advanced and take advantage of capture groups.area
// The 1st and 2nd is what is shown to the user, 3rd and 4th are what's actually implemented in the code, but that might get ugly regex-wise
GLOBAL_LIST_INIT(impediments, list(
	"lisp" = list("s", "th", "s+", "th"),
	"hiss" = list("s", "sss", "s+", "sss"),
))
