Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3812482748
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 00:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfHEWEn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Aug 2019 18:04:43 -0400
Received: from mail.nwra.com ([72.52.192.72]:51026 "EHLO mail.nwra.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbfHEWEn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 5 Aug 2019 18:04:43 -0400
Received: from barry.cora.nwra.com (inferno.cora.nwra.com [204.134.157.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail.nwra.com (Postfix) with ESMTPS id 8A5B7340584;
        Mon,  5 Aug 2019 15:04:41 -0700 (PDT)
Subject: Re: NFS issues
To:     Daniel Kobras <kobras@puzzle-itc.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <98c9d382-a0ff-99a1-f3c3-90868d6357b7@nwra.com>
 <0452e7bf-947a-fb2c-6250-7fd49a7c5d7e@puzzle-itc.de>
From:   Orion Poplawski <orion@nwra.com>
Organization: NWRA
Message-ID: <7fa073eb-38c4-ecc5-17bc-1c978b7790df@nwra.com>
Date:   Mon, 5 Aug 2019 16:04:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0452e7bf-947a-fb2c-6250-7fd49a7c5d7e@puzzle-itc.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000402030301030505020102"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000402030301030505020102
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/4/19 2:03 PM, Daniel Kobras wrote:
> Hi!
>=20
> Am 03.08.19 um 00:21 schrieb Orion Poplawski:
>>    I'm not able to mount a kerberos nfs share from a Ubuntu 18 machine=
 on a
>> Fedora 30 machine.  Fedora 29 client works fine.  I get a permission
>> denied message.
> The tshark output isn't verbose enough to tell for sure whether this is=

> the cause, but krb5 in Fedora 30 no longer supports various weak
> encryption types. I'd recommend to double check the available enctypes
> for your server's nfs principal. More details at:
> https://fedoraproject.org/wiki/Changes/krb5_crypto_modernization
>=20
> Kind regards,
>=20
> Daniel
>=20

Thanks for the response.  Turns out to have be an incorrect FQDN in use o=
n one
machine - the OS difference was a coincidence.

--=20
Orion Poplawski
Manager of NWRA Technical Systems          720-772-5637
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                 https://www.nwra.com/


--------------ms000402030301030505020102
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CjYwggTpMIID0aADAgECAgRMDow4MA0GCSqGSIb3DQEBBQUAMIG0MRQwEgYDVQQKEwtFbnRy
dXN0Lm5ldDFAMD4GA1UECxQ3d3d3LmVudHJ1c3QubmV0L0NQU18yMDQ4IGluY29ycC4gYnkg
cmVmLiAobGltaXRzIGxpYWIuKTElMCMGA1UECxMcKGMpIDE5OTkgRW50cnVzdC5uZXQgTGlt
aXRlZDEzMDEGA1UEAxMqRW50cnVzdC5uZXQgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgKDIw
NDgpMB4XDTExMTExMTE1MzgzNFoXDTIxMTExMjAwMTczNFowgaUxCzAJBgNVBAYTAlVTMRYw
FAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BTIGlz
IGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1c3Qs
IEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0EwggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDEMo1C0J4ZnVuQWhBMtRAAIbkHSN6uboDW/xRQBuh1r2tG
juelT63DjLD6e+AZkf3wY61xSfOoHB+rNBkgTktU6QCTvnAIMd6JU6xXvCTvKo9C1PfqlSVd
FHbSzacS+huytFxhQL1f3VebRFXYxYkZPGU9uejUpS3CLNPqgzGiCDxeWa4SLioKjF7zszGu
Cq1+7LBJCfynLiIeaGQ0nRbjpj0DMUAW95T2Sxk0yZfmIpxI3mSggwtYBZjEIkaJBf2jvvZJ
TGEDFqT4Cpkc4sDGfmkCMleQA68AlKG53M6v7/R8GM4wC8qH+NVfH1lR2IsLuTjGWMJTfNom
1NvyvZDNAgMBAAGjggEOMIIBCjAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB/wIB
ADAzBggrBgEFBQcBAQQnMCUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLmVudHJ1c3QubmV0
MDIGA1UdHwQrMCkwJ6AloCOGIWh0dHA6Ly9jcmwuZW50cnVzdC5uZXQvMjA0OGNhLmNybDA7
BgNVHSAENDAyMDAGBFUdIAAwKDAmBggrBgEFBQcCARYaaHR0cDovL3d3dy5lbnRydXN0Lm5l
dC9ycGEwHQYDVR0OBBYEFAmRpbrp8i4qdd/Nfv53yvLea5skMB8GA1UdIwQYMBaAFFXkgdER
gL7YibkIozH5oSQJFrlwMA0GCSqGSIb3DQEBBQUAA4IBAQAKibWxMzkQsSwJee7zG22odkq0
w3jj5/8nYTTMSuzYgu4fY0rhfUV6REaqVsaATN/IdQmcYSHZPk3LoBr0kYolpXptG7lnGT8l
M9RBH2E/GCKTyD73w+kP51j0nh9O45/h1d83uvyx7YA2ZmaFJlditeJusIJq0KwjE9EXFUYJ
WXbOp3CniB5xJz4d3tnqnQiKfyuW8oubFH/KRXJPCi1bv865e+iMiEyP114JkKDnyPmAPq3B
MrJGw/3NDAzlwv1PCbeCIJK802SfBzFN9s81aTek70c/JSt7Dt+bO7JxPSfOlC57Jq1InwR/
nxuHzHodsSCQFQiuAhHTwwA9qOtHMIIFRTCCBC2gAwIBAgIQF5XJg+ffrZoAAAAATDX/LTAN
BgkqhkiG9w0BAQsFADCBpTELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4x
OTA3BgNVBAsTMHd3dy5lbnRydXN0Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVy
ZW5jZTEfMB0GA1UECxMWKGMpIDIwMTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVz
dCBDbGFzcyAyIENsaWVudCBDQTAeFw0xNzEyMTUxNzE3MTBaFw0yMDEyMTUxNzQ3MDBaMIGT
MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEm
MCQGA1UEChMdTm9ydGhXZXN0IFJlc2VhcmNoIEFzc29jaWF0ZXMxNTAWBgNVBAMTD09yaW9u
IFBvcGxhd3NraTAbBgkqhkiG9w0BCQEWDm9yaW9uQG53cmEuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAop24yyNf/vYlUdWtgHFHWcittcBFeMIWS5GJxcDDYSjYfHUY
hiEq8D4eMrktwirxZqnGTwMdN+RCqrnNZSR/YOsHSwpsW+9eOtAAlHMPCbaPsS+X0xxZX3VR
SdxXulwELCE6Saik1UMQ0MWHts1TwNuDrAXlvmoxCHgXSgcs4ukfNSOAs49Ol09tOt5xI5NA
Cz2sDjAiwonIm2ccuqbc5zJZiL2YOVTzOq9Aa/i38tRldTYkJH80WgnpmMZTSgGLua8kwA/u
4Lmax2VEcoRMw9zzmJav8gFNpQDbVnO3Ik2nlreJ/FX9+JmUa7zDn4FS0rT37ZJ7rOA3N968
CwBHAwIDAQABo4IBfzCCAXswDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMC
BggrBgEFBQcDBDBCBgNVHSAEOzA5MDcGC2CGSAGG+mwKAQQCMCgwJgYIKwYBBQUHAgEWGmh0
dHA6Ly93d3cuZW50cnVzdC5uZXQvcnBhMGoGCCsGAQUFBwEBBF4wXDAjBggrBgEFBQcwAYYX
aHR0cDovL29jc3AuZW50cnVzdC5uZXQwNQYIKwYBBQUHMAKGKWh0dHA6Ly9haWEuZW50cnVz
dC5uZXQvMjA0OGNsYXNzMnNoYTIuY2VyMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwu
ZW50cnVzdC5uZXQvY2xhc3MyY2EuY3JsMBkGA1UdEQQSMBCBDm9yaW9uQG53cmEuY29tMB8G
A1UdIwQYMBaAFAmRpbrp8i4qdd/Nfv53yvLea5skMB0GA1UdDgQWBBSU5GXZh96BMn8UDBnI
wT0CYlbijTAJBgNVHRMEAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQAj5E9g5NtdnH5bR1qKtyUG
L9Rd6BIZBrVIMoEkpXi6rRwhfeAV2cU5T/Te94+pv5JkBQfJQAakeQM+VRvSHtODHTPot12I
pX/Dm9oxhKXpWIveNjC/6Qbx+/E6iNvUGTtTTtCfwwpmyzVpUnJUN0B9XSHy78+fjJkDUIv6
byrBSC/zW0MxSd0HKtr2Do3FYZgEmFiEchDzwJeTmpJiJN/IVk/gtfJXSYQFOA0QawovCSvG
gZy/0fRY5y8h1MDWmVBRrHBRoL+ot9Q6nbhMyszvEGIVYVvWleE3Zcpu0teQ5WDv7WYs6ZZe
xIkGhIIW65NWIa1rG+UYok993UqK2FGnMYIEXzCCBFsCAQEwgbowgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEBeVyYPn362a
AAAAAEw1/y0wDQYJYIZIAWUDBAIBBQCgggJ1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTE5MDgwNTIyMDQ0MFowLwYJKoZIhvcNAQkEMSIEIHkkONF/BBqN
MgvFBR5uzcB5b/YJi+6KETIYEFNOl/cuMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgcsGCSsGAQQBgjcQBDGBvTCBujCBpTELMAkG
A1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xOTA3BgNVBAsTMHd3dy5lbnRydXN0
Lm5ldC9DUFMgaXMgaW5jb3Jwb3JhdGVkIGJ5IHJlZmVyZW5jZTEfMB0GA1UECxMWKGMpIDIw
MTAgRW50cnVzdCwgSW5jLjEiMCAGA1UEAxMZRW50cnVzdCBDbGFzcyAyIENsaWVudCBDQQIQ
F5XJg+ffrZoAAAAATDX/LTCBzQYLKoZIhvcNAQkQAgsxgb2ggbowgaUxCzAJBgNVBAYTAlVT
MRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMTkwNwYDVQQLEzB3d3cuZW50cnVzdC5uZXQvQ1BT
IGlzIGluY29ycG9yYXRlZCBieSByZWZlcmVuY2UxHzAdBgNVBAsTFihjKSAyMDEwIEVudHJ1
c3QsIEluYy4xIjAgBgNVBAMTGUVudHJ1c3QgQ2xhc3MgMiBDbGllbnQgQ0ECEBeVyYPn362a
AAAAAEw1/y0wDQYJKoZIhvcNAQEBBQAEggEAYUaOTM3YYGwy2AiFvhnOQ20rry3mRgJ3BvcS
5i7FGVDfs+ftyJukWcz0HyHQ/LJ7wABCcrfIYGsKU2WyagEYQSCTgpRhgkBSfJmHVMsYnwt6
1nfMocFryHhgUPfT61dNe2fumt6njtnGasx4soPHCGfszD3juPMZEicOQ2aVd2X4fowKCxDm
p3BKCMl4UcJUKcGalpXrYIxjO26imBpKBoJNV76ClEr03QnSlzhSsY4Dc4bKvW7qMgjl4+WD
jXmkC+Nl6Ix4HcZNIWYO746oRZB3rlF0zK22FpPHKqjhc/HtiR6imjJMeOc+8RfHwtm4boAj
dlwK+Y6M/Fcr+S2/vAAAAAAAAA==
--------------ms000402030301030505020102--
