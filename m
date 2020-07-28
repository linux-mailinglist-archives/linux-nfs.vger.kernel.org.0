Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB14230D82
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jul 2020 17:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgG1PRQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jul 2020 11:17:16 -0400
Received: from mail-mw2nam12on2120.outbound.protection.outlook.com ([40.107.244.120]:54720
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730778AbgG1PRP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Jul 2020 11:17:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeRE4EyJK+qE404nXGkkKA59q7oCOWV1sVHyFKk5QjRF8rmpg97LESrVZ6Yj+R+J1dGYq0KnZA9okxAaNYARqAH9jHhLNa28IAcxBCsN8NvCbn/DP3rusyH4JFB/BVU/Z0aE3x+XUCDnHmz7TMI2Jk+EPhRL6aVQecCFm8peyybj9L2trNKt2eGyg+pEEHbHPoypZH31Ixfm4Ldv4/QXtmM+VltzTM19dhnAxoGNWNKJ71Ah6s1vHjKph71g3r4W4nEGxlECANvRZkuFgE0rHDLPawkjzTGZnk0OcGptfz85iiV3cbe1uA+uVNb8VbCPPgdjwrTMEQRb/7YsabY5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCto7CF4KGqrOWzw4VQh36WcBwFnSspb+vMZz6Ziswg=;
 b=OEsSzfTWG8U27z7oGQEJFgrvS6JNwJ2FJJaTBj4h1gwIOZCpSbNq9aCctM/zQHJXNbN0QIlWmhSfTjx6vX4jlqkWRlAbUApIxjunk9UrPnq1lWpmcqrQUV4o7phWEY6hrGVs/KCZfDk/+YmSu37FQdDED8+GgNEe8DBXTnZ0uDS2xJzX21/x6+eoSFo3do+ojmp8kiYG5sbwvp3orVGRIavakwX8gH3KBvUyNwBUBRVoMcseTSh3Bq0u6mPVy9gYJPC7wCoce6jXVhRJzdF8Qovp21Jxta2TxmiohPFRAP41tjU+LjmvnPEAEqlHEJZl8JTOUTbe3M/4j53A8oaXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCto7CF4KGqrOWzw4VQh36WcBwFnSspb+vMZz6Ziswg=;
 b=CrPsiady3RkDDNpe3j+3vjRaVxHD/XYMU2EPCWTLCzvhY6BcqTh8YZ6s8VlrV+4thgYEYo2hkuyBmC3H3hnDB6mTNq39VtLIcG0QzqYAJdwxaUPTSA7h+efogpER3RjsF5A03BNh4C3N6e9VZtcNz6B4pXNdc7ch/TEDakKTLMA=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3400.namprd13.prod.outlook.com (2603:10b6:610:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10; Tue, 28 Jul
 2020 15:17:12 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 15:17:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Thread-Topic: [PATCH] NFSv4.2: Fix an error code in nfs4_xattr_cache_init()
Thread-Index: AQHWZAhvCZQFVT7SMUyvX1UCoywirakbn4CAgAF8w4A=
Date:   Tue, 28 Jul 2020 15:17:12 +0000
Message-ID: <4bb93c1413151ccbd918cc371c67555042763e11.camel@hammerspace.com>
References: <20200727112344.GH389488@mwanda>
         <20200727163423.GA7563@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20200727163423.GA7563@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95212e4c-bef1-4133-854d-08d833094de2
x-ms-traffictypediagnostic: CH2PR13MB3400:
x-microsoft-antispam-prvs: <CH2PR13MB34000EA270CD9AC641D000E5B8730@CH2PR13MB3400.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVfZxP4nXO45e7+jgBHfaNF90DAekVpDXRyAMVgvJV/MqwBpLIq38eIof5gTdPyHR3i5HyK3QdEMh84cUcc+DUTFhJ+Yv78ZjFihkRYNDe/8SjC6OYhGlicCv1JfStA3412Jw94xuU4g/jFmLBIb5BbKA1BJImgucIu+8oBdupsHVygPgNKeyFxRrl9hJJbLxZ5Whbo4ucT6oepauzoW267XTuAehVdfnLiiWNbBrM6pJ31q1/13FMesA/71Ou7imGWiH6AfmAtAPtsVPqFdQeBrFeWBEdDsSJyPnbkim581UdiQOpiYygWnMRX0wuDkl5XLdsCPNxAb4rw5NEQRqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(136003)(346002)(39840400004)(366004)(66476007)(66946007)(66556008)(186003)(66446008)(76116006)(26005)(71200400001)(2906002)(8936002)(5660300002)(478600001)(6512007)(316002)(64756008)(36756003)(54906003)(110136005)(4326008)(6506007)(86362001)(6486002)(2616005)(83380400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sOsxlbAuchpCgmeE8rgPPELD5U1WiiqslUq235sdfZHSAkI4mZeYsvrFuxGa714PwQ/nb9+Bq4vmGp3L2jyv7YqwA0mr6OF3Aqt7INbJSTWvDxfaVV5ry1sAAxY/4rdaZoPrelcNuihvyFRmU2vAfUD33qVCN+PyuU8JI/rGHWUfiNqXX76q5aTiadbaApBWQV+gTSI6zbxDoIc1L2x1wTvspBa7gwaOLdB51LMz6qUrBqcRoGjG5J9i1Kthb3Ga/SVitQs070fWjjLpVHMu8I4jIOpqRHQhBVzHeiAJJAufQsj/pKNzOBU9P7kvoV2QV9w/A5XsCldMEvzmBS5nmB+RRHJLfTVRdop5PWRLEV1C4TXB2MU9UeAMgXm8B/DfcpN6yEKh6Cc/Dwhs1Q/dImKAJTPD8GoCMJ31tNm/R+kyf5Zj/m+Qf4qF6eF2PNT7VhGQ9B7tn8xUzIc+Zs32hHqGD1zrQm77nMwUSO6qoD2yg2LCbJTz/NN5c2DnsZ3n0IxTrm4pjqrQR2RuyUuwN7MjTWsZm1wsOMeoV9BuHjL0kVkwGMskkLQzpJ/yyq60XvPir8yzH5g1Iw66ctH/YZiKBhu4GkeMzXq7vnSA+TulQ7Eo4GU5sQBpdhn1YUXb0NvRm8y+/ooWo/XdK/SzuQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D84C2C84DF235B449A9E264DA2BF4F02@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95212e4c-bef1-4133-854d-08d833094de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 15:17:12.6838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5FoNO/dy6BVdScWIL6+jfoWwcrgz17RzeCX5kKTnAQcrOZ6/HI6MqUqDARMy/kZQdkIXMcnbXp/NrjzAJQYhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3400
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTI3IGF0IDE2OjM0ICswMDAwLCBGcmFuayB2YW4gZGVyIExpbmRlbiB3
cm90ZToNCj4gSGkgRGFuLA0KPiANCj4gT24gTW9uLCBKdWwgMjcsIDIwMjAgYXQgMDI6MjM6NDRQ
TSArMDMwMCwgRGFuIENhcnBlbnRlciB3cm90ZToNCj4gPiANCj4gPiBUaGlzIHNob3VsZCByZXR1
cm4gLUVOT01FTSBvbiBmYWlsdXJlIGluc3RlYWQgb2Ygc3VjY2Vzcy4NCj4gPiANCj4gPiBGaXhl
czogOTVhZDM3ZjkwYzMzICgiTkZTdjQuMjogYWRkIGNsaWVudCBzaWRlIHhhdHRyIGNhY2hpbmcu
IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNs
ZS5jb20+DQo+ID4gLS0tDQo+ID4gLS0tDQo+ID4gIGZzL25mcy9uZnM0MnhhdHRyLmMgfCA0ICsr
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNDJ4YXR0ci5jIGIvZnMvbmZzL25mczQy
eGF0dHIuYw0KPiA+IGluZGV4IDIzZmRhYjk3N2EyYS4uZTc1YzRiYjcwMjY2IDEwMDY0NA0KPiA+
IC0tLSBhL2ZzL25mcy9uZnM0MnhhdHRyLmMNCj4gPiArKysgYi9mcy9uZnMvbmZzNDJ4YXR0ci5j
DQo+ID4gQEAgLTEwNDAsOCArMTA0MCwxMCBAQCBpbnQgX19pbml0IG5mczRfeGF0dHJfY2FjaGVf
aW5pdCh2b2lkKQ0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIG91dDI7DQo+ID4gDQo+ID4gICAg
ICAgICBuZnM0X3hhdHRyX2NhY2hlX3dxID0gYWxsb2Nfd29ya3F1ZXVlKCJuZnM0X3hhdHRyIiwN
Cj4gPiBXUV9NRU1fUkVDTEFJTSwgMCk7DQo+ID4gLSAgICAgICBpZiAobmZzNF94YXR0cl9jYWNo
ZV93cSA9PSBOVUxMKQ0KPiA+ICsgICAgICAgaWYgKG5mczRfeGF0dHJfY2FjaGVfd3EgPT0gTlVM
TCkgew0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0KPiA+ICAgICAgICAgICAg
ICAgICBnb3RvIG91dDE7DQo+ID4gKyAgICAgICB9DQo+ID4gDQo+ID4gICAgICAgICByZXQgPSBy
ZWdpc3Rlcl9zaHJpbmtlcigmbmZzNF94YXR0cl9jYWNoZV9zaHJpbmtlcik7DQo+ID4gICAgICAg
ICBpZiAocmV0KQ0KPiA+IC0tDQo+ID4gMi4yNy4wDQo+ID4gDQo+IA0KPiBUaGFua3MgZm9yIGNh
dGNoaW5nIHRoYXQgb25lLiBTaW5jZSB0aGlzIGlzIGFnYWluc3QgbGludXgtbmV4dCB2aWENCj4g
VHJvbmQsDQo+IEkgYXNzdW1lIFRyb25kIHdpbGwgYWRkIGl0IHRvIGhpcyB0cmVlIChyaWdodD8p
DQo+IA0KPiBJbiBhbnkgY2FzZToNCj4gDQo+IA0KPiBSZXZpZXdlZC1ieTogRnJhbmsgdmFuIGRl
ciBMaW5kZW4gPGZsbGluZGVuQGFtYXpvbi5jb20+DQo+IA0KPiANCj4gLSBGcmFuaw0KDQpGcmFu
aywgd2h5IGRvIHdlIG5lZWQgYSB3b3JrcXVldWUgaGVyZSBhdCBhbGw/DQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
