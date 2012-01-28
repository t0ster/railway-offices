#= require "jquery"
#= require "underscore"
#= require "data"


#
# Places mark on map
#
placemark = (address, desc) ->
  geocoder = new YMaps.Geocoder(address, {results: 1})
  YMaps.Events.observe geocoder, geocoder.Events.Load, ->
    style = new YMaps.Style()
    style.hasHint = true
    style.iconStyle = new YMaps.IconStyle()

    if geocoder.found > 0
      point = geocoder.get(0).getGeoPoint()
      placemark = new YMaps.Placemark(point)
      placemark.name = address
      placemark.description = desc
      placemark.setStyle(style)
      map.addOverlay(placemark)
    else
      console.log "#{address} not found"


$ ->
  # Init map
  map = new YMaps.Map(YMaps.jQuery("#YMapsID")[0])
  map.addControl(new YMaps.TypeControl())
  map.addControl(new YMaps.ToolBar())
  map.addControl(new YMaps.Zoom())
  map.addControl(new YMaps.MiniMap())
  map.addControl(new YMaps.ScaleLine())
  # Center point is Kiev
  map.setCenter(new YMaps.GeoPoint(30.522301, 50.451118), 12)

  # Placing marks
  for [address, desc] in TICKET_OFFICES
    placemark(address, desc)

  window.map = map
