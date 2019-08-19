Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8392361
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfHSM0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 08:26:01 -0400
Received: from mail-eopbgr00095.outbound.protection.outlook.com ([40.107.0.95]:53825
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbfHSM0B (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Aug 2019 08:26:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRbagZl1FJ4I89YtDgUqB+2gOKzlcTtWIxEsQrRI3edXTN+0BCwRjxkaXDeymn629VErQYO3FcMm2J8ZZMp+OeTgii60Jej123ZIBpSEzeH5qNUplD29Jt9dpncxylsx/ybcUMSKsaEUYFOtGNUyBxG70R+LQNEq3J4d1khOs2xsjqWCUiVd6Dnwe24xOiGuvyQQeDWJdt8ZwxuQbP4GaQbXvPGhPbDo7lPPUE2CaMkDcYDl0dM6qWt2ubfCvS/EEouX8MPaH5BgfOuYTp29mN0eyFzt2JbGolhiJJb8BTewVqhQyOLK13T24Nk6nlQiVJAklEMFSSt0YA2dEgqEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAk8OCk7cvB0TFSdbBBh9RF89WkLFSvspN6FpQ1pumI=;
 b=RJl1KkhOw9xHmkAXlSk+aATTurP2tpem6NWXAvR8HA00I1BDIY9Zaf4BGdb8tWGoucnORcgoSBOyhkUr+m5ILRudUE/5elUS0YECFsMdgNBCTKyif0jG6mU+eAU440mKRVu3oEJomUiF3uZFcLIbl4po8phzcOlIElz1w7ftktjSZ6QC4jsngGyLqINvALtkD1GY7Ytm+KyMyQVy/CqFy4xZUfx75FkIoiD8cGRN8moo1nhv7hcLyfhBHyc/XIg+c52aFki5P05jACNH0F0pWrvoxFqvoSwhXmEo1XOGmWONUDfBphBqkr+cH0xZg9YnA9VUt4MirEa/xV450+pxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAk8OCk7cvB0TFSdbBBh9RF89WkLFSvspN6FpQ1pumI=;
 b=Bu5hbAKm+mrfoq6rbWEOjAp4b0cbClRy20yB8pbqz7ujygM5l1fOBQXfXNh/8L5XkYlVw1XyZwFFh/xvyrUm71d/4ZeSLSjkw62pI75HV6UkxOClY5cqrHRMEnxzrQ6g2cIv5G54Gbh445Vwz38J+NqHyXCkHwTgu1vl8g2/ZGI=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3642.eurprd07.prod.outlook.com (52.133.6.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.11; Mon, 19 Aug 2019 12:25:53 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::d90c:c96:8d6a:362d]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::d90c:c96:8d6a:362d%6]) with mapi id 15.20.2199.011; Mon, 19 Aug 2019
 12:25:53 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: nfs4 server stops responding
Thread-Topic: nfs4 server stops responding
Thread-Index: AQHVVok9rVIGR5acmEyxP58lNJPUiw==
Date:   Mon, 19 Aug 2019 12:25:52 +0000
Message-ID: <eb70e71ba0b1caafb96e136d83aa9c097f2a6930.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f99654ec-41bb-49d6-152f-08d724a06097
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:HE1PR0702MB3642;
x-ms-traffictypediagnostic: HE1PR0702MB3642:
x-microsoft-antispam-prvs: <HE1PR0702MB36420CFB6F6E2E467B6FF5BEB4A80@HE1PR0702MB3642.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(110136005)(6512007)(36756003)(2616005)(6116002)(256004)(8936002)(14444005)(2201001)(118296001)(71190400001)(71200400001)(102836004)(486006)(6506007)(186003)(476003)(86362001)(26005)(4326008)(5660300002)(66066001)(2501003)(76116006)(305945005)(7736002)(66946007)(64756008)(66476007)(66446008)(66556008)(53936002)(99286004)(478600001)(316002)(6486002)(81156014)(81166006)(8676002)(6436002)(25786009)(2906002)(3846002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3642;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4EqXkdSf1ilQhMOb44TPNFmLfIC5IxYjV62K/HyL5gsBpP6w5AWDjts8TWyBWBcT5ErKXc4fA1jr0pijIuvffWs7Cv2t3seVaXYY0K6uDd1+YnC+zJjY8nDNR4nsL4OJnwZdwIIWyPTZGcfVbbiP5swo1MmtI7YBVplmbQeIvLc7z1ZshTxSVwPvOo7Xs/VKG6Np//q/8O08NR3OmWzuxg5fDees1yfEH+Ss43HUL5VaTsbCNFIky4jRLOmNkWxpVlUXcl1ceGHpKhhSe8YQOcXEp6LpHjjRRhEfhWCIj2nSJCl/3pFBF+E7dI9413G3ZrAYI5rByHbUW2vs7BS+43CV42Vmurim5WEYngC0wbsDRJ/FM57YjLON0ohXH1B1CRQTvRwew4P+DnhKT0cvIaUqtlshHg2924y8va2Ep0A=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15C0CE3A23C0334590213FCCDBB05E88@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99654ec-41bb-49d6-152f-08d724a06097
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 12:25:52.8306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RfB4yOBX7PqiyECOif8v6ZljgZ9GzCIesMgtE2QGq5bJ+odnXHil93eJeXsCGM1JpYK4E4c9QQzlVp2K3h0zwmFcSzHRGmhETTHaVRv3aQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3642
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGVsbG8sDQoNCkkgaGF2ZSB0d28gVk1zLCBleHBvcnRpbmcgc29tZSBkaXJlY3RvcmllcyBpbiBv
bmUgVk06DQojIGNhdCAvZXRjL2V4cG9ydHMNCi9tbnQgMTkyLjE2OC4xLjAvMjQocm8sZnNpZD0w
LG5vX3N1YnRyZWVfY2hlY2ssc3luYykNCi9tbnQvZXhwb3J0DQoxOTIuMTY4LjEuMC8yNChydyxu
b19yb290X3NxdWFzaCxzeW5jLG5vX3dkZWxheSxub19zdWJ0cmVlX2NoZWNrKQ0KWy4uLl0NCg0K
QW5kIE5GUyBtb3VudGluZyBpbiB0aGUgc2Vjb25kIFZNOg0KIyBncmVwIG5mcyAvcHJvYy9tb3Vu
dHMgDQpzZXJ2ZXI6L2V4cG9ydCAvbW50L2V4cG9ydCBuZnM0DQpydyxyZWxhdGltZSx2ZXJzPTQu
Mixyc2l6ZT0xMDQ4NTc2LHdzaXplPTEwNDg1NzYsbmFtbGVuPTI1NSwNCmFjcmVnbWluPTEsYWNy
ZWdtYXg9MSxhY2Rpcm1pbj0xLGFjZGlybWF4PTEsaGFyZCxub3JkaXJwbHVzLA0KcHJvdG89dGNw
LHRpbWVvPTYwMCxyZXRyYW5zPTIsc2VjPXN5cyxjbGllbnRhZGRyPTE5Mi4xNjguMS4xMSwNCmxv
Y2FsX2xvY2s9bm9uZSxhZGRyPTE5Mi4xNjguMS4xMCAwIDANClsuLi5dDQoNCklmIEkga2VlcCBz
b21lIGZpbGUgZGVzY3JpcHRvciBvcGVuIGZvciBzZXZlcmFsIG1pbnV0ZXMgaW4gdGhlIHNlY29u
ZCBWTSwNCmZvciBleGFtcGxlIGJ5IHJ1bm5pbmcgdGhpczoNCiMgc2xlZXAgMTBtID4vbW50L2V4
cG9ydC90ZXN0DQoNClRoZW4gcmVzdWx0IGlzIHRoYXQgdGhlIE5GUyBtb3VudCBzdG9wcyByZXNw
b25kaW5nOiB0aGUgc2xlZXAgcHJvY2Vzcw0KbmV2ZXIgZmluaXNoZWQgYnV0IGlzICJmb3JldmVy
IiBzdHVjayBpbiAoa2lsbGFibGUpIEQgc3RhdGUsIGFuZCBhbnkgSS9PDQphdHRlbXB0IGZyb20g
b3RoZXIgcHJvY2Vzc2VzIGluIC9tbnQvZXhwb3J0IG5ldmVyIGZpbmlzaC4NCkl0J3MgYWx3YXlz
IHJlcHJvZHVjaWJsZSB3aXRoIHRoaXMgc2xlZXAgY29tbWFuZC4NClRvIHJlY292ZXIgdGhlIG1v
dW50cG9pbnQgSSBuZWVkIHRvIHJlYm9vdCB0aGUgc2Vjb25kIFZNLg0KDQpLZXJuZWwgdmVyc2lv
biBpcyA1LjMuMC1yYzQgaW4gYm90aCBWTXMuDQpBbHNvIHJlcHJvZHVjaWJsZSB3aXRoIDQuMTQu
eCBhbmQgNC4xOS54DQoNCiMgcHMgYXV4fGdyZXAgc2xlZXANCnJvb3QgICAgICAyNTI0ICAwLjAg
IDAuMCAgIDU5MDAgICA2ODggcHRzLzAgICAgRCAgICAxNDowNCAgIDA6MDAgc2xlZXAgNW0NCg0K
IyBncmVwIC1DMTAwIG5mcyAvcHJvYy8qL3N0YWNrDQovcHJvYy8yNTI0L3N0YWNrOls8MD5dIG5m
czRfZG9fY2xvc2UrMHg4N2QvMHhiMjAgW25mc3Y0XQ0KL3Byb2MvMjUyNC9zdGFjazpbPDA+XSBf
X3B1dF9uZnNfb3Blbl9jb250ZXh0KzB4Mjk3LzB4NGYwIFtuZnNdDQovcHJvYy8yNTI0L3N0YWNr
Ols8MD5dIG5mc19maWxlX3JlbGVhc2UrMHhiZS8weGYwIFtuZnNdDQovcHJvYy8yNTI0L3N0YWNr
LVs8MD5dIF9fZnB1dCsweDFkZi8weDY5MA0KL3Byb2MvMjUyNC9zdGFjay1bPDA+XSB0YXNrX3dv
cmtfcnVuKzB4MTIzLzB4MWIwDQovcHJvYy8yNTI0L3N0YWNrLVs8MD5dIGV4aXRfdG9fdXNlcm1v
ZGVfbG9vcCsweDEyMS8weDE0MA0KL3Byb2MvMjUyNC9zdGFjay1bPDA+XSBkb19zeXNjYWxsXzY0
KzB4MmQxLzB4MzcwDQovcHJvYy8yNTI0L3N0YWNrLVs8MD5dIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCi0tDQovcHJvYy81NjEvc3RhY2stWzwwPl0gX19ycGNfZXhl
Y3V0ZSsweDY5Mi8weGIxMCBbc3VucnBjXQ0KL3Byb2MvNTYxL3N0YWNrLVs8MD5dIHJwY19ydW5f
dGFzaysweDQ1Zi8weDVkMCBbc3VucnBjXQ0KL3Byb2MvNTYxL3N0YWNrOls8MD5dIG5mczRfY2Fs
bF9zeW5jX3NlcXVlbmNlKzB4MTJhLzB4MjEwIFtuZnN2NF0NCi9wcm9jLzU2MS9zdGFjazpbPDA+
XSBfbmZzNF9wcm9jX2dldGF0dHIrMHgxOWEvMHgyMDAgW25mc3Y0XQ0KL3Byb2MvNTYxL3N0YWNr
Ols8MD5dIG5mczRfcHJvY19nZXRhdHRyKzB4ZGEvMHgyMzAgW25mc3Y0XQ0KL3Byb2MvNTYxL3N0
YWNrOls8MD5dIF9fbmZzX3JldmFsaWRhdGVfaW5vZGUrMHgyZWQvMHg3YTAgW25mc10NCi9wcm9j
LzU2MS9zdGFjazpbPDA+XSBuZnNfZG9fYWNjZXNzKzB4NjA1LzB4ZDAwIFtuZnNdDQovcHJvYy81
NjEvc3RhY2s6WzwwPl0gbmZzX3Blcm1pc3Npb24rMHg1MDAvMHg1ZTAgW25mc10NCi9wcm9jLzU2
MS9zdGFjay1bPDA+XSBpbm9kZV9wZXJtaXNzaW9uKzB4MmRkLzB4M2YwDQovcHJvYy81NjEvc3Rh
Y2stWzwwPl0gbGlua19wYXRoX3dhbGsucGFydC42MCsweDY4MS8weGU0MA0KL3Byb2MvNTYxL3N0
YWNrLVs8MD5dIHBhdGhfbG9va3VwYXQuaXNyYS42MysweDFhZi8weDg1MA0KL3Byb2MvNTYxL3N0
YWNrLVs8MD5dIGZpbGVuYW1lX2xvb2t1cC5wYXJ0Ljc5KzB4MTY1LzB4MzYwDQovcHJvYy81NjEv
c3RhY2stWzwwPl0gdmZzX3N0YXR4KzB4YjkvMHgxNDANCi9wcm9jLzU2MS9zdGFjay1bPDA+XSBf
X2RvX3N5c19uZXdzdGF0KzB4NzcvMHhkMA0KL3Byb2MvNTYxL3N0YWNrLVs8MD5dIGRvX3N5c2Nh
bGxfNjQrMHg5YS8weDM3MA0KL3Byb2MvNTYxL3N0YWNrLVs8MD5dIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCg0KDQpJbiBkbWVzZyBvZiBzZWNvbmQgVk0gc29tZXRp
bWVzIG5mcyBjb21wbGFpbnRzIGFyZSBzZWVuOg0KDQpbICAzODYuMzYyODk3XSBuZnM6IHNlcnZl
ciB4eXogbm90IHJlc3BvbmRpbmcsIHN0aWxsIHRyeWluZw0KDQpBbnkgaWRlYXMgd2hhdCdzIGdv
aW5nIHdyb25nIGhlcmUuLi4/DQoNCi1Ub21taQ0KDQo=
