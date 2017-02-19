package main

/*
  #include <stdlib.h>
*/
import "C"


import (
  "encoding/json"
  "fmt"
  "github.com/paulmach/go.geo"
)

//export DecodePolyline
func DecodePolyline(polyline *C.char, precision C.int) *C.char {

  go_polyline := C.GoString(polyline)
  go_precision := int(precision)

  path := geo.NewPathFromEncoding(go_polyline, go_precision)

  // Path is returned as lng / lat
  // reverse it as standard lat/lng
  natural_path := [][2]float64{}
  for _, elem := range path.Points(){
    natural_path = append(natural_path, [2]float64{elem[1],elem[0]})
  }

  b, err := json.Marshal(natural_path)
  if err != nil {
    return C.CString("[]")
  }

  return C.CString(string(b))
}

func main(){
  arr := DecodePolyline(C.CString("eibiH{f}Ld_O~jf@"), C.int(1.0e5))
  fmt.Println(C.GoString(arr))
}
