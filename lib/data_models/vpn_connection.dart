class VpnConnection {
  String username;
  String password;
  String url;
  String key;
  String identifier;
  String tag;
  String imgUrl;
  String assetUri;

  VpnConnection({
    this.username,
    this.password,
    this.key,
    this.url,
    this.identifier,
    this.tag,
    this.imgUrl,
    this.assetUri,
  });

  VpnConnection.fromJson(Map<String, dynamic> json)
        username = json['username'],
        password = json['password'],
        url = json['url'],
        assetUri = json['asset_uri'],
        key = json['shared_key'],
        tag = json['tag'],
        identifier = json['identifier'];
}
