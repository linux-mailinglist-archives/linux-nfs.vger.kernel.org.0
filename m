Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C59AD213
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 04:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfIIC6l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Sep 2019 22:58:41 -0400
Received: from mail-eopbgr780101.outbound.protection.outlook.com ([40.107.78.101]:36555
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733260AbfIIC6l (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 8 Sep 2019 22:58:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsUwrRQnvdQ0FL45E90FrF+5Rl9Lx5nBZ1pGUNaVSn5nTllZG58CiRGZrcYMo3cYH53KV1/Hb6jzgf4VrKu+emOWmErb4f5y76SWIp3shvvypvQbjCKA9tUnUSodbuPIAQUxCGQ2Hl0aT3+CZ+LbQbMzLa9z1Kf7Zzxxlv6ISiqhI65o7sT20CT2Eplf3/BqYm6kUS00DVQo5i6HxOVXcYjorfnXTqTawlMtLnSgbYDcwcNGr45IWxXGOFd+rlFpcC9mxLWi1EIuv8L9bfKSP8Y2U2YRQy9awB114LW9XmAkimOtz6PDURJaEi1aPEBqL/rsC4eCwjEYi5suG5p6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCgjx8pBNUVbIji12BS49huN1zrKtD64LRXCHnPbqKo=;
 b=akl4D1G92RtPh1aaaZ/Tf39xZpZqtv2EWGxm9Ra5MM9gL9pOJz00tJ3kxKTuqi347DI+de3wNtlt9mUhDTJT+WirUsddRTUDBATv02go1wN8xaLE90dlHNI9JTkq4fCxjcoJOvKRXWocK+emL7ZbZVnFp+APBuV1ouNzsFZ+cfU2GOH1B+IewiydC6qYzbp+aSBnZHAO0Zc0iZG8qFFmBWlDjJPlGWSg3WGY9smAw33ekZX6z5Rx9aXORecKUQz5CAPL3JWHhWLg0KmPiAD0mLGlZed8qfhDiIzlv0Tt2CZxHIDAodYDyLnLVk999rDvSNw2IWU0ekoRZPmIJbIw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCgjx8pBNUVbIji12BS49huN1zrKtD64LRXCHnPbqKo=;
 b=gShelNFSjdZWFXOxWjmLmOYxF1qB3IyZtFsVcqNtOUG3SgXjKfKmXqgHjODK9Qtsh9CI+zMgkgHD2EW/00zEMzBYPzXHuhhdK5cNpPeWFG2h83IOOfGWD9znJN9tGHIbg6TjGCRg1uTlwVZg6pdeSIBk83gCVII0punV45RvGu4=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1850.namprd13.prod.outlook.com (10.171.155.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Mon, 9 Sep 2019 02:58:36 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2263.005; Mon, 9 Sep 2019
 02:58:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>
Subject: Re: nfs-for-5.3-3 update "breaks" NFSv4 directIO somehow
Thread-Topic: nfs-for-5.3-3 update "breaks" NFSv4 directIO somehow
Thread-Index: AQHVXYqWkaBiigZLzUiLlkqzKNa/B6cQsH6AgBIDDgCAAAZNgA==
Date:   Mon, 9 Sep 2019 02:58:35 +0000
Message-ID: <77a371f6d9c290de0cca00ff272ea831e0d124b8.camel@hammerspace.com>
References: <20190828102256.3nhyb2ngzitwd7az@XZHOUW.usersys.redhat.com>
         <00923c9f5d5a69e8225640abcf7ad54df2cb62d2.camel@hammerspace.com>
         <20190909023600.sxygdyclxm4ivllw@XZHOUW.usersys.redhat.com>
In-Reply-To: <20190909023600.sxygdyclxm4ivllw@XZHOUW.usersys.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.167.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39fe7ae5-8adf-4b37-827b-08d734d19bba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1850;
x-ms-traffictypediagnostic: DM5PR13MB1850:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM5PR13MB18502EA991897D58C2983EEEB8B70@DM5PR13MB1850.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(366004)(136003)(346002)(376002)(189003)(199004)(6506007)(81166006)(118296001)(66066001)(5660300002)(81156014)(15650500001)(66446008)(64756008)(6436002)(66556008)(66476007)(86362001)(71200400001)(71190400001)(76116006)(76176011)(36756003)(66946007)(8676002)(91956017)(14454004)(15974865002)(99286004)(7736002)(102836004)(5024004)(14444005)(53546011)(2501003)(186003)(26005)(11346002)(476003)(2616005)(3846002)(2906002)(486006)(6116002)(6246003)(229853002)(25786009)(2351001)(316002)(54906003)(478600001)(8936002)(4326008)(6486002)(966005)(256004)(6916009)(6306002)(1361003)(53936002)(6512007)(5640700003)(305945005)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1850;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oFiqGevtg6KHpE5k9j14k1AIQIPuYxdS4ac3xM6kFDz0PO5L1JmhGSux09bR43aO7W8ax3lilL68SVq00SWEZJldNtyr8eqGQr4KeVP0Ru9T+fNFqTvJA/ntYRq4pShPvnpCFpGhuB6oAw7bGq66s52HAXQnmiOpE0/myKVHEoAGBw8OL7bOIUxqbGT/oYEYvGt3vHEJ7RH+pRiDeVRVrULmJ9sJrQa2MgFJa4sDfl8qhr0PN+KJDK1WJW/xh4cK7SyxzzHldPIQwjQeMmBXDjvQWgwXjQu6T9fxuPkv9PLtCpxiU4WUsbNmn9oRkKzO69a984OnS/eoH7jZCUjzqxCWr0BaQRd/CUJlMaMSGK8PVHCdIWvmvfoqNWmuJFP6C6HYKMGoUwpYsE0+mIkvm53Tnv8M0BptCQ7R0Eh36JE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAD735D8DBFECA479A1639498BDD391E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fe7ae5-8adf-4b37-827b-08d734d19bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 02:58:35.9276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUM1OiO58aC+gjeEWAXTK3eqWa4I4TsypzY/dRowbmK8OaCm2D8jmAhxhCyRXwKsgyg+CO0XIx2pFwpEhv9GKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1850
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTA5IGF0IDEwOjM2ICswODAwLCBNdXJwaHkgWmhvdSB3cm90ZToNCj4g
T24gV2VkLCBBdWcgMjgsIDIwMTkgYXQgMDM6MzI6MjVQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0
IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAxOS0wOC0yOCBhdCAxODoyMiArMDgwMCwgTXVycGh5IFpo
b3Ugd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gSWYgd3JpdGUgdG8gZmlsZSB3aXRo
IE9fRElSRUNULCB0aGVuIHJlYWQgaXQgd2l0aG91dCBPX0RJUkVDVCwNCj4gPiA+IHJlYWQNCj4g
PiA+IHJldHVybnMgMC4NCj4gPiA+IEZyb20gdHNoYXJrIG91dHB1dCwgbG9va3MgbGlrZSB0aGUg
UkVBRCBjYWxsIGlzIG1pc3NpbmcuDQo+ID4gPiANCj4gPiA+IExUUFsxXSBkaW8gdGVzdHMgc3Bv
dCB0aGlzLiBUaGluZ3Mgd29yayB3ZWxsIGJlZm9yZSB0aGlzIHVwZGF0ZS4NCj4gPiA+IA0KPiA+
ID4gQmlzZWN0IGxvZyBpcyBwb2ludGluZyB0bzoNCj4gPiA+IA0KPiA+ID4gCWNvbW1pdCA3ZTEw
Y2MyNWJmYTBkZDM2MDJiYmNmNWNjOWM3NTlhOTBlYjY3NWRjDQo+ID4gPiAJQXV0aG9yOiBUcm9u
ZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiAJRGF0
ZTogICBGcmkgQXVnIDkgMTI6MDY6NDMgMjAxOSAtMDQwMA0KPiA+ID4gCQ0KPiA+ID4gCSAgICBO
RlM6IERvbid0IHJlZnJlc2ggYXR0cmlidXRlcyB3aXRoIG1vdW50ZWQtb24tZmlsZQ0KPiA+ID4g
aW5mb3JtYXRpbw0KPiA+ID4gDQo+ID4gPiBXaXRoIHRoaXMgY29tbWl0IHJldmVydGVkLCB0aGUg
dGVzdHMgcGFzcyBhZ2Fpbi4NCj4gPiA+IA0KPiA+ID4gSXQncyBvbmx5IGFib3V0IE5GU3Y0KDQu
MCA0LjEgYW5kIDQuMiksIE5GU3YzIHdvcmtzIHdlbGwuDQo+ID4gPiANCj4gPiA+IEJpc2VjdCBs
b2csIG91dHB1dHMgb2YgdHNoYXJrLCBzYW1wbGUgdGVzdCBwcm9ncmFtbWUgZGVyaXZlZCBmcm9t
DQo+ID4gPiBMVFAgZGlvdGVzdDAyLmMgYW5kIGEgc2ltcGxlIHRlc3Qgc2NyaXB0IGFyZSBhdHRh
Y2hlZC4NCj4gPiA+IA0KPiA+ID4gSWYgdGhpcyBpcyBhbiBleHBlY3RlZCBjaGFuZ2UsIHdlIHdp
bGwgbmVlZCB0byB1cGRhdGUgdGhlDQo+ID4gPiB0ZXN0Y2FzZXMuDQo+ID4gDQo+ID4gVGhhdCBp
cyBub3QgaW50ZW50aW9uYWwsIHNvIHRoYW5rcyBmb3IgcmVwb3J0aW5nIGl0ISBEb2VzIHRoZQ0K
PiA+IGZvbGxvd2luZw0KPiA+IGZpeCBoZWxwPw0KPiANCj4gSGkgVHJvbmQsDQo+IA0KPiBXaWxs
IHlvdSBxdWV1ZSB0aGlzIGZpeCBmb3IgdjUuMyA/DQo+IA0KPiBUaGFua3MhDQo+IA0KDQpJdCBp
cyBhbHJlYWR5IGluIDUuMy1yYzg6IA0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD1lYjNkOGY0MjIz
MWFlYzY1YjY0YjA3OWRkMTdiZDZjMDA4YTNmZTI5DQoNCkNoZWVycw0KICBUcm9uZA0KDQo+ID4g
ODwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBGcm9tIGNlNjE2MThiYzA4NWQ4Y2VhOGE2
MTRiNWUxZWIwOWUxNmVhOGUwMzYgTW9uIFNlcCAxNyAwMDowMDowMA0KPiA+IDIwMDENCj4gPiBG
cm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+
ID4gRGF0ZTogV2VkLCAyOCBBdWcgMjAxOSAxMToyNjoxMyAtMDQwMA0KPiA+IFN1YmplY3Q6IFtQ
QVRDSF0gTkZTOiBGaXggaW5vZGUgZmlsZWlkIGNoZWNrcyBpbiBhdHRyaWJ1dGUNCj4gPiByZXZh
bGlkYXRpb24gY29kZQ0KPiA+IA0KPiA+IFdlIHdhbnQgdG8gdGhyb3cgb3V0IHRoZSBhdHRyYnV0
ZSBpZiBpdCByZWZlcnMgdG8gdGhlIG1vdW50ZWQgb24NCj4gPiBmaWxlaWQsDQo+ID4gYW5kIG5v
dCB0aGUgcmVhbCBmaWxlaWQuIEhvd2V2ZXIgd2UgZG8gbm90IHdhbnQgdG8gYmxvY2sgY2FjaGUN
Cj4gPiBjb25zaXN0ZW5jeQ0KPiA+IHVwZGF0ZXMgZnJvbSBORlN2NCB3cml0ZXMuDQo+ID4gDQo+
ID4gUmVwb3J0ZWQtYnk6IE11cnBoeSBaaG91IDxqZW5jY2Uua2VybmVsQGdtYWlsLmNvbT4NCj4g
PiBGaXhlczogN2UxMGNjMjViZmEwICgiTkZTOiBEb24ndCByZWZyZXNoIGF0dHJpYnV0ZXMgd2l0
aCBtb3VudGVkLQ0KPiA+IG9uLWZpbGUuLi4iKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15
a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZnMvbmZzL2lub2RlLmMgfCAxNCArKysrKysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9m
cy9uZnMvaW5vZGUuYyBiL2ZzL25mcy9pbm9kZS5jDQo+ID4gaW5kZXggYzc2NGNmZTQ1NmU1Li5k
N2U3OGIyMjBjZjYgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL2lub2RlLmMNCj4gPiArKysgYi9m
cy9uZnMvaW5vZGUuYw0KPiA+IEBAIC0xNDA0LDEwICsxNDA0LDExIEBAIHN0YXRpYyBpbnQNCj4g
PiBuZnNfY2hlY2tfaW5vZGVfYXR0cmlidXRlcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3Qg
bmZzX2ZhdHRyDQo+ID4gKmZhdA0KPiA+ICAJCXJldHVybiAwOw0KPiA+ICANCj4gPiAgCS8qIE5v
IGZpbGVpZD8gSnVzdCBleGl0ICovDQo+ID4gLQlpZiAoIShmYXR0ci0+dmFsaWQgJiBORlNfQVRU
Ul9GQVRUUl9GSUxFSUQpKQ0KPiA+IC0JCXJldHVybiAwOw0KPiA+ICsJaWYgKCEoZmF0dHItPnZh
bGlkICYgTkZTX0FUVFJfRkFUVFJfRklMRUlEKSkgew0KPiA+ICsJCWlmIChmYXR0ci0+dmFsaWQg
JiBORlNfQVRUUl9GQVRUUl9NT1VOVEVEX09OX0ZJTEVJRCkNCj4gPiArCQkJcmV0dXJuIDA7DQo+
ID4gIAkvKiBIYXMgdGhlIGlub2RlIGdvbmUgYW5kIGNoYW5nZWQgYmVoaW5kIG91ciBiYWNrPyAq
Lw0KPiA+IC0JaWYgKG5mc2ktPmZpbGVpZCAhPSBmYXR0ci0+ZmlsZWlkKSB7DQo+ID4gKwl9IGVs
c2UgaWYgKG5mc2ktPmZpbGVpZCAhPSBmYXR0ci0+ZmlsZWlkKSB7DQo+ID4gIAkJLyogSXMgdGhp
cyBwZXJoYXBzIHRoZSBtb3VudGVkLW9uIGZpbGVpZD8gKi8NCj4gPiAgCQlpZiAoKGZhdHRyLT52
YWxpZCAmIE5GU19BVFRSX0ZBVFRSX01PVU5URURfT05fRklMRUlEKQ0KPiA+ICYmDQo+ID4gIAkJ
ICAgIG5mc2ktPmZpbGVpZCA9PSBmYXR0ci0+bW91bnRlZF9vbl9maWxlaWQpDQo+ID4gQEAgLTE4
MDgsMTAgKzE4MDksMTEgQEAgc3RhdGljIGludCBuZnNfdXBkYXRlX2lub2RlKHN0cnVjdCBpbm9k
ZQ0KPiA+ICppbm9kZSwgc3RydWN0IG5mc19mYXR0ciAqZmF0dHIpDQo+ID4gIAkJCWF0b21pY19y
ZWFkKCZpbm9kZS0+aV9jb3VudCksIGZhdHRyLT52YWxpZCk7DQo+ID4gIA0KPiA+ICAJLyogTm8g
ZmlsZWlkPyBKdXN0IGV4aXQgKi8NCj4gPiAtCWlmICghKGZhdHRyLT52YWxpZCAmIE5GU19BVFRS
X0ZBVFRSX0ZJTEVJRCkpDQo+ID4gLQkJcmV0dXJuIDA7DQo+ID4gKwlpZiAoIShmYXR0ci0+dmFs
aWQgJiBORlNfQVRUUl9GQVRUUl9GSUxFSUQpKSB7DQo+ID4gKwkJaWYgKGZhdHRyLT52YWxpZCAm
IE5GU19BVFRSX0ZBVFRSX01PVU5URURfT05fRklMRUlEKQ0KPiA+ICsJCQlyZXR1cm4gMDsNCj4g
PiAgCS8qIEhhcyB0aGUgaW5vZGUgZ29uZSBhbmQgY2hhbmdlZCBiZWhpbmQgb3VyIGJhY2s/ICov
DQo+ID4gLQlpZiAobmZzaS0+ZmlsZWlkICE9IGZhdHRyLT5maWxlaWQpIHsNCj4gPiArCX0gZWxz
ZSBpZiAobmZzaS0+ZmlsZWlkICE9IGZhdHRyLT5maWxlaWQpIHsNCj4gPiAgCQkvKiBJcyB0aGlz
IHBlcmhhcHMgdGhlIG1vdW50ZWQtb24gZmlsZWlkPyAqLw0KPiA+ICAJCWlmICgoZmF0dHItPnZh
bGlkICYgTkZTX0FUVFJfRkFUVFJfTU9VTlRFRF9PTl9GSUxFSUQpDQo+ID4gJiYNCj4gPiAgCQkg
ICAgbmZzaS0+ZmlsZWlkID09IGZhdHRyLT5tb3VudGVkX29uX2ZpbGVpZCkNCj4gPiAtLSANCj4g
PiAyLjIxLjANCj4gPiANCj4gPiAtLSANCj4gPiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiBMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQo+ID4gdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KPiA+IA0KPiA+IA0KVHJvbmQgTXlrbGVidXN0DQpDVE8sIEhhbW1lcnNw
YWNlIEluYw0KNDMwMCBFbCBDYW1pbm8gUmVhbCwgU3VpdGUgMTA1DQpMb3MgQWx0b3MsIENBIDk0
MDIyDQp3d3cuaGFtbWVyLnNwYWNlDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
