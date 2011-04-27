function centerMapToDefault() {
    map.setCenter(new OpenLayers.LonLat(lon,lat),zoom);
}

function initMap() {
    var followUp = null;
    /*for(var option in options){self[option] = options[option];}*/
    var mapOptions = {numZoomLevels: 18}
    map = new OpenLayers.Map($('map'),mapOptions);
    map.addLayer(baseLayer);
    centerMapToDefault();
    state = "UNKNOWN";
    
    /**
    *case statements here should be replaced by lookup references
    */
    
    var template = {externalGraphic: "${icon}",graphicWidth:"${width}",graphicHeight:"${height}"};
    
    var cont = {
        radius: function(feature){return Math.min(feature.attributes.count, 7) + 3;},
        icon: function(feature) { return "/images/" + feature.attributes.icon; },
        width: function(feature){ w = 12;
            var _icon = feature.attributes.icon;
            switch(_icon) {
                case 'marker.png': w = 32; break;
                case 'pink-marker.png': w = 32; break;
                case 'highlight.gif': w = 45; break;
            }
            return w;
        },
        height:function(feature){ h = 29;
            var _icon = feature.attributes.icon;
            switch(_icon) {
                case 'marker.png': w = 32; break;
                case 'pink-marker.png': w = 32; break;
                case 'highlight.gif': w = 45; break;
            }
            return h;
        }
    };


     style = new OpenLayers.Style(template, {context: cont});
     vLayer = new OpenLayers.Layer.Vector("markers",
      {
         projection: new OpenLayers.Projection("EPSG:4326"),
         styleMap: new OpenLayers.StyleMap({
         "default": style,
         "select": g
       })
      });

     map.addLayer(vLayer);

    
    for(var key in controls){
        var control = controls[key];
        map.addControl(control);
        control.activate();
    }
   }
    
    
    function highlightPoint(point, options) {
        if(typeof(options) == 'undefined') { options = {};}
        point["icon"] = 'highlight.gif';
        options["layer"] = 'highlight';
        if(!options["centerMap"]) {  options["centerMap"] = true; }
        options["zoom"] = 13;
        render([point], options);
        map.raiseLayer(map.getLayersByName('markers').first(),1);
    }
    
    function removeLabel(){
        map.removePopup(popup);
    }
    
    function showLabel(vectorObj) {
        var _lat, _lon, _info;
        _lat = vectorObj.geometry.getCentroid().x;
        _lon = vectorObj.geometry.getCentroid().y;
        _info = vectorObj.attributes.info;
        showPopup(_lat, _lon, _info);
    }
    
    function showPopup(lat, lon, content) {
        if(popup != null) { map.removePopup(popup);}
        popup = new OpenLayers.Popup.FramedCloud("infopopup",
            new OpenLayers.LonLat(lat, lon),
            new OpenLayers.Size(200,50),
            content,
            null,
            true,
            function(e) { map.removePopup(popup);});
        map.addPopup(popup);
    }
    
    
    function render(result,options) {
        var icon = null;
        if(typeof(options) == 'undefined') {
            options = {};
        }
        
        var mapBounds = map.getExtent();
        var _layer = (typeof(options) == 'undefined' || !options["layer"]) ? 'markers' : options["layer"];
        var cur_layer = map.getLayersByName("markers");
        var pointList = [];
        var center = (typeof(options) == 'undefined' || options.center) ? true : false;
        /**
        * this rule should be applied for a newly added feature or feature being editted
        *
        */
        var point = null;
        var disp = "";
        var _bounds = new OpenLayers.Bounds();
        var pgeom = null;
        result.each(
            function(record){
                _props = {'fid': (record.id || null),'info': (record.info || record.label || null),'icon': (record.icon || icon || 'marker.png'), 'type' : _layer};
                var pgeom = new OpenLayers.Geometry.Point(record.lon,record.lat);
                _bounds.extend(pgeom.getBounds());
                point = new OpenLayers.Feature.Vector(pgeom,_props, null);
                point.fid = record.id;
                point.icon = record.icon;
                pointList.push(point);
            }
        );

        
        vLayer.addFeatures(pointList);
        if(options["hideLayer"] == true) {
            cur_layer.setVisibility(false);
        }
        
        if (options["centerMap"] && options["centerMap"] == true ) {
            var _center = _bounds.getCenterLonLat();
            map.setCenter(_center);
            var _zoom = options["zoom"] ? options["zoom"] : map.getZoomForExtent(_bounds);
            _zoom > 15 ? map.zoomTo(15) : map.zoomTo(_zoom);
        }
    }
    
    function resizeExtent(bounds){
        bounds.left *= 0.80;
        bounds.bottom *= 0.80;
        bounds.right *= 1.20;
        bounds.top *= 1.20;
        return bounds;
    }
    
    function clearAllLayers() {
        map.layers.each(function(layer) {
            if(!layer.isBaseLayer) {
                layer.destroyFeatures();
            }
        });
    }
    
    function clearLayers(layers) {
        layers.each(function(layer) {
            map.getLayersByName(layer).first().destroyFeatures();
        });
    }
    
    
    function parseJSON(jsonData) {
        var parsedData;
        try {
            parsedData = eval("(" + jsonData + ")");
        }
        catch(e) {
            parsedData = eval(jsonData);
        }
        return parsedData;
    }
    
    
    function isVisible(layer) {
        var lyrs = map.getLayersByName(layer)
        return lyrs.length == 0 ? false : lyrs.first().getVisibility();
    }
    
    function hideAllLayers(options) {
        layers.each(function(l){
            map.getLayersByName(l).first().setVisibility(false);
            obj = $(l);
            if(obj){
                obj.checked = "";
            }
        });
        
    }
    
    function showLocation(location, options) {
        var arr = new Array();
        arr.push(location);
        render(arr, options);
    }
    
    // Global variables
    
    var layers = ["markers"];
    
    var controls = {
        "logo": new OpenLayers.Control.MapunityText(),
        "position": new OpenLayers.Control.MousePosition({'displayProjection': new OpenLayers.Projection("EPSG:4326"),'numDigits':4})
        //"hover": new OpenLayers.Control.Hover(),
        //"panZoom": new OpenLayers.Control.PanZoomBar()
    };
    
    var g = OpenLayers.Util.extend({},OpenLayers.Feature.Vector.style['default']);
    g.graphicWidth = 45;
    g.graphicHeight = 45;
    g.graphicXOffset = -(g.graphicWidth/2);
    g.graphicYOffset = -(g.graphicHeight/2);
    g.externalGraphic = "../images/highlight.gif";
    g.graphicOpacity = 1;
    
    var name = 'India - Mapunity';
    var cluster = new OpenLayers.Strategy.Cluster();
    var tile_url = ["http://tiles0.mapunity.org","http://tiles1.mapunity.org","http://tiles2.mapunity.org","http://tiles3.mapunity.org"];
    var baseLayer = new OpenLayers.Layer.GTileGrid(name,tile_url,{},{'projection': new OpenLayers.Projection("EPSG:4326")});
    //var baseLayer = new OpenLayers.Layer.Google("Google Map", {numZoomLevels: 18,'displayInLayerSwitcher':false});
    var map = null;
    var zoom = 12;
    var z = zoom;
    var lat = 12.9600;
    var lon= 77.60181;
    var minZoom = 10;
    var maxZoom = 18;
    var vLayer = null; //vector layer
    var sLayer = null; // for displaying selection
    var state = "UNKNOWN"; //initialize the state to unknown
    var dragControl = null;
    var loc = null;
    var newFids = [];
    var selectedFeature = null;
    var frm = null;
    var cache = null;
    var hiddenLayers = [];
    var dest = "posts";
    var rslt = "results";
    var rsltHTML = "<ul id=results></ul>";
    var style;
    var style_route = {
        strokeColor: "#FF0000",
        strokeOpacity: 1,
        strokeWidth: 3,
        pointRadius: 6,
        pointerEvents: "visiblePainted"
    };
    var popup = null;
    var layerCount = null;
