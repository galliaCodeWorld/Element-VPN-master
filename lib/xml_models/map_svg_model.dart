class MapSvgVectorPath {
  String pathValue;
  MapSvgVectorAttribute attributes;

  MapSvgVectorPath(
    this.pathValue,
  );

  MapSvgVectorPath.withAttributes(this.pathValue, this.attributes);

  factory MapSvgVectorPath.fromXML(Map<String, dynamic> xml) {
    if (xml == null) {
      return null;
    } else {
      return MapSvgVectorPath(xml["path"]);
    }
  }
}

class MapSvgPathStyle {
  String colorName;
  String opacityValue;

  MapSvgPathStyle(this.colorName, this.opacityValue);
}

class MapSvgVectorAttribute {
  String id;
  String dataName;
  String dataId;
  String destination;
  MapSvgPathStyle style;

  MapSvgVectorAttribute(
    this.id,
    this.dataName,
    this.dataId,
    this.destination,
    this.style,
  );
}

class VectorCoordinate {
  double x;
  double y;

  VectorCoordinate(this.x, this.y);
}
