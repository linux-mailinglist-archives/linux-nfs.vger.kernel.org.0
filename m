Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D14186F90
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2020 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbgCPQEo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Mar 2020 12:04:44 -0400
Received: from mail-eopbgr680103.outbound.protection.outlook.com ([40.107.68.103]:8526
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731838AbgCPQEo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Mar 2020 12:04:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6vd7qe6s8HSSsMKeu/Q6L4TTZLQSkwEXPputfUlhS37eY0mvN4KHiWYp//QFjRumUeZ+icnIlMaPsIHskVinLNeEApGzl5WHLQgX7OReuZyZBQ85MlSt64kewBacQcRf6sYaBEyEcKHhtgepBE2gkZZ135qR3gIvO9hR27yUV5RZQveR1m2hAZyWr+SMl+e+9DncWZAWuq2q7vsFYgeRcPJfCI7TkwnDndZwDUrZVBMnevNycYSXNAG/Dn6eQTgVR13dh08WRfrpWvCqc6rZVOWCeir0JX7mrTHmiZ2qRjioEHTvK+URJjjpnAh9MVN6X/oAU6fXRTatoEu1kWPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHRcVkeQacdfn9aW7hb6MPkTXHQ13nLTrWaYvN4nnNQ=;
 b=hsW5IUPWF5BVEP3u1U6aeneLTUKvFW/OX5rLJzXrnr4dRSBmP7e5FuypxINfQ3wyEBEK6vsEVOv6yc3wRp1/rG4nimaketS1+qaNm92I32w5ImjSAtUw+UwBaUljq5+dPDulL+esvUhnxigZv4atORtOCljIrGRYNSYG1iCC6fTqsMQyd0aE0ksGswXUIdD9Yk2yT7Q8OK1bz3Car4uKQKBMaEyeTAM8+7sJQ9hUtNU7neFRUIuC96pTXzf+5r2Gf5K5hpgEWaINYHSBabmDdswQQGtcUpjwK2t2ko9XrE6/lGD0c3CN9UGn8tdhi8byJ/+THelC64EAdeEOTzSMFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHRcVkeQacdfn9aW7hb6MPkTXHQ13nLTrWaYvN4nnNQ=;
 b=Ij5mMfd2C2PCs1b4iDjyw9Tu2XawcR1onGbTjTH2DSZEfshaNBS/FxyH8jCuGLviS/RwnGvZrtW0z8PVr5ZfIjp/MTLIWTO2Ve/P6lFGNUlCjOO1LovL/tPXHHQ4CnUuFLNlRic7tf6fHK/Yy0dxQ1d/XCbwzvtbY0Cptiid+DY=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3765.namprd13.prod.outlook.com (2603:10b6:610:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.6; Mon, 16 Mar
 2020 16:04:39 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36%7]) with mapi id 15.20.2835.013; Mon, 16 Mar 2020
 16:04:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "kolga@netapp.com" <kolga@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Fix NFS server build errors
Thread-Topic: [PATCH] NFSD: Fix NFS server build errors
Thread-Index: AQHV80cnhSr6jRwikkaKupIAu/omHag600GAgADlwwCAD7mcgA==
Date:   Mon, 16 Mar 2020 16:04:39 +0000
Message-ID: <384e6acb2cd88596a2d02e18123e9f452ff5ab4b.camel@hammerspace.com>
References: <20200305233433.14530.61315.stgit@klimt.1015granger.net>
         <631f52a1-b557-9137-0a7c-f493ac3339af@huawei.com>
         <734C2816-BB0C-4E6B-9894-67C9754DC071@oracle.com>
In-Reply-To: <734C2816-BB0C-4E6B-9894-67C9754DC071@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e73d787d-00ec-4adf-7075-08d7c9c3bb6c
x-ms-traffictypediagnostic: CH2PR13MB3765:
x-microsoft-antispam-prvs: <CH2PR13MB3765E67B3CE1F616ABCEDA86B8F90@CH2PR13MB3765.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(376002)(39830400003)(199004)(316002)(76116006)(53546011)(6506007)(478600001)(4326008)(6512007)(8936002)(64756008)(36756003)(66446008)(66556008)(66476007)(66946007)(5660300002)(71200400001)(86362001)(2616005)(81156014)(81166006)(186003)(8676002)(26005)(110136005)(6486002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR13MB3765;H:CH2PR13MB3398.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dPKWkTschVfnOI9F3Xdj8gd8PxFEhZKfhYac9widVc7Cg4524ITA1+VMHbYK8AU+4haBtyzD+gzA9U2QIOYh4ZKPai4uNsu4CKiHVMNSrYZj03MjcAjm6hnWfpO1RG6PktU/HOgmZm1lIbeLRABDhdnyza0dcdFhOpKQsvtmJTTSPKZLy4MzYqFaT76cALMSZMbBipvq4Wze9dKcJ62TaYSsfzKMhNbUAFta19+kiBnz8nIsykoEetBcD94RAyJA8DMgWfd5HfrieZzkAhQeN5pvpNLXsWdR1AZn5untsRPelDy2Ede1GWN/E2fe4OtTkpl7fRFF+6RSWPRw+jT+eclM7bAuua+hoxNyK4qvr9VBJxfdcDIWB9xYYS6ByEuf/o9TPac5yYKrqAAk++8p1p5k9yK+NYaOjmlS0OS35a/NcYiuwsiD1Y9FkLxzyOjm
x-ms-exchange-antispam-messagedata: pSIX5zgnYRPl5+9GvPUICcPpmFsJiEv/ihxVceQoI9+MbbZZHR4QafwJy25FJ6TfIXCtioyprqLHfiG+90STqvCwDfXDkHzgJd9iz6TrnNCbyMAcqJNt7q8UhSESruTMsq949Tc41Soysaezs/XnIg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6551BB399FD4D4CAFC72FB4AE553AA4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73d787d-00ec-4adf-7075-08d7c9c3bb6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 16:04:39.4987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFLY8Mwa4JOjhFAUBq75CyPSEi5EXyPkGYkdf0zOgAa80TE0eNU8dcZsWzG24LmrHpT7swk4+5eEXp+yDhZEKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3765
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTA2IGF0IDEwOjU2IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBNYXIgNSwgMjAyMCwgYXQgOToxNCBQTSwgWXVlaGFpYmluZyA8eXVlaGFpYmluZ0BodWF3
ZWkuY29tPg0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIDIwMjAvMy82IDc6MzgsIENodWNrIExl
dmVyIHdyb3RlOg0KPiA+ID4geXVlaGFpYmluZ0BodWF3ZWkuY29tIHJlcG9ydHMgdGhlIGZvbGxv
d2luZyBidWlsZCBlcnJvcnMgYXJpc2UNCj4gPiA+IHdoZW4NCj4gPiA+IENPTkZJR19ORlNEX1Y0
XzJfSU5URVJfU1NDIGlzIHNldCBhbmQgdGhlIE5GUyBjbGllbnQgaXMgbm90IGJ1aWx0DQo+ID4g
PiBpbnRvIHRoZSBrZXJuZWw6DQo+ID4gPiANCj4gPiA+IGZzL25mc2QvbmZzNHByb2MubzogSW4g
ZnVuY3Rpb24gYG5mc2Q0X2RvX2NvcHknOg0KPiA+ID4gbmZzNHByb2MuYzooLnRleHQrMHgyM2I3
KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYG5mczQyX3NzY19jbG9zZScNCj4gPiA+
IGZzL25mc2QvbmZzNHByb2MubzogSW4gZnVuY3Rpb24gYG5mc2Q0X2NvcHknOg0KPiA+ID4gbmZz
NHByb2MuYzooLnRleHQrMHg1ZDJhKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYG5m
c19zYl9kZWFjdGl2ZScNCj4gPiA+IGZzL25mc2QvbmZzNHByb2MubzogSW4gZnVuY3Rpb24gYG5m
c2Q0X2RvX2FzeW5jX2NvcHknOg0KPiA+ID4gbmZzNHByb2MuYzooLnRleHQrMHg2MWQ1KTogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYG5mczQyX3NzY19vcGVuJw0KPiA+ID4gbmZzNHBy
b2MuYzooLnRleHQrMHg2Mzg5KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiA+ID4gYG5mc19z
Yl9kZWFjdGl2ZScNCj4gPiA+IA0KPiA+ID4gVGhlIG5ldyBpbnRlci1zZXJ2ZXIgY29weSBjb2Rl
IGludm9rZXMgY2xpZW50IGZ1bmN0aW9ucy4gVW50aWwNCj4gPiA+IHRoZQ0KPiA+ID4gTkZTIHNl
cnZlciBoYXMgaW5mcmFzdHJ1Y3R1cmUgdG8gbG9hZCB0aGUgYXBwcm9wcmlhdGUgTkZTIGNsaWVu
dA0KPiA+ID4gbW9kdWxlcyB0byBoYW5kbGUgaW50ZXItc2VydmVyIGNvcHkgcmVxdWVzdHMsIGxl
dCdzIGNvbnN0cmFpbiB0aGUNCj4gPiA+IHdheSB0aGlzIGZlYXR1cmUgaXMgYnVpbHQuDQo+ID4g
PiANCj4gPiA+IFJlcG9ydGVkLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+
DQo+ID4gPiBGaXhlczogY2UwODg3YWM5NmQzICgiTkZTRCBhZGQgbmZzNCBpbnRlciBzc2MgdG8g
bmZzZDRfY29weSIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2
ZXJAb3JhY2xlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gZnMvbmZzZC9LY29uZmlnIHwgICAgMiAr
LQ0KPiA+ID4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gPiANCj4gPiA+IFl1ZSAtIGRvZXMgdGhpcyB3b3JrIGZvciB5b3U/IFRoZSBkZXBlbmRlbmN5
IGlzIGVhc2llciBmb3IgbWUgdG8NCj4gPiA+IHVuZGVyc3RhbmQuDQo+ID4gDQo+ID4gSXQgd29y
a3MgZm9yIG1lLg0KPiA+IA0KPiA+IFRlc3RlZC1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0Bo
dWF3ZWkuY29tPiAjIGJ1aWxkLXRlc3RlZA0KPiANCj4gVGhhbmtzLCBJJ3ZlIGFkZGVkIHRoaXMg
dGFnIGFuZCBwdXNoZWQgdG8gbmZzZC01LjctdGVzdGluZy4NCj4gDQo+IEJydWNlIGFuZCBPbGdh
LCB5b3UgY2FuIHN0aWxsIHZldG8gdGhpcyBhcHByb2FjaCB1bnRpbCBJIHB1c2ggaW50bw0KPiBs
aW51eC1uZXh0LiBJdCB3aWxsIGJlIGEgY291cGxlIG9mIHdlZWtzIGF0IGxlYXN0Lg0KPiANCj4g
DQo+ID4gPiBCcnVjZSBhbmQgT2xnYSAtIE9LIHdpdGggdGhpcyB0ZW1wb3Jhcnkgc29sdXRpb24/
DQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnNkL0tjb25maWcgYi9mcy9uZnNkL0tj
b25maWcNCj4gPiA+IGluZGV4IGYzNjhmMzIxNWY4OC4uOTlkMmNhZTkxYmQ2IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZnMvbmZzZC9LY29uZmlnDQo+ID4gPiArKysgYi9mcy9uZnNkL0tjb25maWcNCj4g
PiA+IEBAIC0xMzYsNyArMTM2LDcgQEAgY29uZmlnIE5GU0RfRkxFWEZJTEVMQVlPVVQNCj4gPiA+
IA0KPiA+ID4gY29uZmlnIE5GU0RfVjRfMl9JTlRFUl9TU0MNCj4gPiA+IAlib29sICJORlN2NC4y
IGludGVyIHNlcnZlciB0byBzZXJ2ZXIgQ09QWSINCj4gPiA+IC0JZGVwZW5kcyBvbiBORlNEX1Y0
ICYmIE5GU19WNF8xICYmIE5GU19WNF8yDQo+ID4gPiArCWRlcGVuZHMgb24gTkZTRF9WNCAmJiBO
RlNfVjRfMSAmJiBORlNfVjRfMiAmJiBORlNfRlM9eQ0KPiA+ID4gCWhlbHANCj4gPiA+IAkgIFRo
aXMgb3B0aW9uIGVuYWJsZXMgc3VwcG9ydCBmb3IgTkZTdjQuMiBpbnRlciBzZXJ2ZXIgdG8NCj4g
PiA+IAkgIHNlcnZlciBjb3B5IHdoZXJlIHRoZSBkZXN0aW5hdGlvbiBzZXJ2ZXIgY2FsbHMgdGhl
IE5GU3Y0LjINCj4gDQoNCkknZCBsaWtlIHRvIHN1Z2dlc3QgdGhhdCB3ZSBkbyB0aGlzIGRpZmZl
cmVudGx5Lg0KDQpMZXQncyBhZGQgYSBzdHJ1Y3R1cmUNCg0Kc3RydWN0IHNzY19jbGllbnRfb3Bz
IHsNCiAgICAgIHN0cnVjdCBmaWxlICooKm9wZW4pKHN0cnVjdCB2ZnNtb3VudCAqc3NfbW50LA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG5mc19maCAqc3JjX2ZoLCBuZnM0X3N0
YXRlaWQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICpzdGF0ZWlkKTsNCiAgICAgIHZvaWQg
KCpjbG9zZSkoc3RydWN0IGZpbGUgKmZpbGVwKTsNCn07DQoNCmFuZCB0aGVuIGFsbG93IHRoZSBj
bGllbnQgdG8gcmVnaXN0ZXIgdGhhdCBzdHJ1Y3R1cmUgaW4NCmZzL25mcy9uZnNfY29tbW9uIHdo
ZW4gaXQgaXMgbG9hZGVkIChhbmQgdW5yZWdpc3RlciB3aGVuIGl0IGlzDQp1bmxvYWRlZCkuIFRo
ZSAnb3BlbicgYW5kICdjbG9zZScgZmllbGRzIGdldCBzZXQgdG8gYmUgcG9pbnRlcnMgdG8gdGhl
DQpmdW5jdGlvbnMgbmZzNDJfc3NjX29wZW4gYW5kIG5mczQyX3NzY19jbG9zZS4NCg0KV2UgY2Fu
IHRoZW4gYWRkIGZ1bmN0aW9ucyBpbiBmcy9uZnMvbmZzX2NvbW1vbiB0byBhY2Nlc3MgdGhlIGZ1
bmN0aW9ucw0Kc3RvcmVkIGluIHN0cnVjdCBzc2NfY2xpZW50X29wcywgYW5kIHRoYXQgY2FuIGJl
IGNhbGxlZCBieSB0aGUga25mc2QNCnNlcnZlci4NCg0KVGhpcyB3b3VsZCBhbGxvdyB1cyB0byBr
ZWVwIGJvdGggdGhlIG5mcyBjbGllbnQgYW5kIHNlcnZlciBhcyBtb2R1bGVzLg0KT25seSBuZnNf
Y29tbW9uIG5lZWRzIHRvIGJlIGNvbXBpbGVkIGludG8gdGhlIGtlcm5lbCAoYXMgaXMgdGhlIGNh
c2UNCmFscmVhZHkgdG9kYXkpLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
