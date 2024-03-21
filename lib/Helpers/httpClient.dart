import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http/io_client.dart';

class CreateHttpClint{

  /*Future<http.Client> getClient()async {
    final sslCert = await rootBundle.load('Assets/cert/cert.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    HttpClient httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return cert.pem == sslCert;
      };

    IOClient ioClient = IOClient(httpClient);
    return ioClient;
  }*/

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('assets/cert/cert.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  Future<http.Client> getSSLPinningClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }

}