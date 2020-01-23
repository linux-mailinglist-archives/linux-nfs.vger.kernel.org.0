Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44549145FAC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 01:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAWAKX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 19:10:23 -0500
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com ([40.107.236.100]:20702
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgAWAKX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 22 Jan 2020 19:10:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8MmNdxDkKvYuHVvqsQLksEeJWEMDap3Fcpp1b7dz9WDaTh2gFEMjy5qx1deqpndeyN8vjTC9s4wcyQhRupJuYNdxmnEht9MY0PuX+Dqv6sAqkMg8cvhTudSsSo2DMLWjKFlqr1BibuhGFEjg5mAFb1ooFdY4JkdKkQasDyJlSCyOU0m0fvBQHjdH8hdytUelZtwSjwh4zyXicWIQRJOuNBNDq+grpsNjogHIu1Ec+3Vxek3nEvoZIC6V8JjtgWfE4MjA3SO3H3t1CK74V5sMdlDLS/Ev7oUz7zumZEAJeaiWEqtU/pTTljjJB6MABUn5FrtQWuQWiupZC86RMYJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MmFpK1dZOGEmR4hu47ADJexDSgdEI8lEVgU3hx7gwQ=;
 b=K4B+MlG08hrKQSsadADqNqs7qMvKnhkTZnjl549uO7bvicyNaclJfFiDDpLS7u6Fy4XJsx8HRgCfarf0n65DIuqsEjYieqG3omLUFDLiuoowC5h2u2aGpG4Bk18S5AldoNEB/Db8/TJo2fb9Yx2AK0a5QqOQ+qaP04K2Dczjcfo/cVbXooTEXL6WOQQ2fiBr4mXX8bnhygvYicpmuAsSENTOTztHoHc2aEpP6EP/+W8lWgW3DBb1NSSilxD+NWF3GLJGGyv/NHUZ1/HR4u6anb4dngTftXkaNXzz7x3vlgMRQQriMINdkCFXFwSYWbQ8azVGv+kGWJBquWSWmcAUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MmFpK1dZOGEmR4hu47ADJexDSgdEI8lEVgU3hx7gwQ=;
 b=KCrJrSPG5eJVWXqiou/5a5ANbj6ZCu37OQevV4loxUmIuFKB/YNSLdf7fdo55DtHajJKmggkhWVDuAG4zOamjtkBJQjqDqAv5ZWO7jxzSqQjUOpJ7jURCKtmbdGYb4gaIaQTnVhBtOHXafnRSdmbiLgxQhA4J/mOm6AqH+C+IGk=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2171.namprd13.prod.outlook.com (10.174.181.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.15; Thu, 23 Jan 2020 00:10:16 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 00:10:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH RFC] nfs: optimise readdir cache page invalidation
Thread-Topic: [PATCH RFC] nfs: optimise readdir cache page invalidation
Thread-Index: AQHV0X6U5aSV8zhXw0mJsuFxO+G2sqf3X/sA
Date:   Thu, 23 Jan 2020 00:10:16 +0000
Message-ID: <5d9ccb1b287760cc11798bef496510b9cf8aee75.camel@hammerspace.com>
References: <20200122234853.101576-1-dai.ngo@oracle.com>
In-Reply-To: <20200122234853.101576-1-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [63.235.104.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 117bad6f-6293-4d7b-fd1c-08d79f989fef
x-ms-traffictypediagnostic: DM5PR1301MB2171:
x-microsoft-antispam-prvs: <DM5PR1301MB21711E785704411F0B3AFA19B80F0@DM5PR1301MB2171.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(366004)(39830400003)(199004)(189003)(478600001)(81166006)(81156014)(316002)(2906002)(6486002)(8936002)(2616005)(8676002)(110136005)(6512007)(36756003)(5660300002)(66446008)(66476007)(71200400001)(26005)(76116006)(66946007)(66556008)(64756008)(6506007)(86362001)(186003)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2171;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UNFN9fc+cRlyZZn0twpN9uFH3eV/n9a8rItUJKzZ0Iz4wvSw6The4Gmw4G+1u04pq4AkpHqH4ct5m7Hsb0dX2nm1nWmE6/ptKv0g3q6vQr1MrV8q4Q4x7Jzav+8XrD/5Kd7hUrWSUHhq2SbzQfbMLoRj3rWgW/VtjyppTyhp3ke0aNzPcj7fzgPrO4tC4wNPnWSiFRxVujXhAv0n36EF6YIlTD+MBcFf2bQYG5LjnImK3OuB2vngwXtozjXQWnALh3zTSWLm5YfJUIpaRl9DDbjkYfGnUda+PbbyU0a7IxVHQAG3MFCt0Y85CbWgvI9tQc+PKvd0I/S3cNAp/SDejxOCo9v2TFoQny4Xv3RUvGJ2pLQnlBxDNVIIXjcs28A7fxHjrzqqpHYHGOBFAm5nZjGOY0P0nj1yfoEcJ7EDKNZmUC/4LQ6C3uUARF52F5ij
x-ms-exchange-antispam-messagedata: iduAdW+PEa6IYUtBDGMM+Li2tA9/rLKFT2ZA8Re0DQ+eaHYVDeleDdc8UmKNg08uIVOVHQYOMZccjhqyyWsoVWkdev7Wk3Lhg/VhWCFpBoihItxr9C7IMUsL8yMRTqipzru0buKRgn4uUYHUdSBXRQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <530B01AF5827A2419A013795981F5135@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117bad6f-6293-4d7b-fd1c-08d79f989fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 00:10:16.2015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hX1wDgUGRF1tkho6TvGJ15XCC9vveafNr5TsFQwks7FDjXdyRWVm9XbXtQVCMiYoHUkoZOO92HvDva8ba9XCRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2171
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTIyIGF0IDE4OjQ4IC0wNTAwLCBEYWkgTmdvIHdyb3RlOg0KPiBXaGVu
IHRoZSBkaXJlY3RvcnkgaXMgbGFyZ2UgYW5kIGl0J3MgYmVpbmcgbW9kaWZpZWQgYnkgb25lIGNs
aWVudA0KPiB3aGlsZSBhbm90aGVyIGNsaWVudCBpcyBkb2luZyB0aGUgJ2xzIC1sJyBvbiB0aGUg
c2FtZSBkaXJlY3RvcnkgdGhlbg0KPiB0aGUgY2FjaGUgcGFnZSBpbnZhbGlkYXRpb24gZnJvbSBu
ZnNfZm9yY2VfdXNlX3JlYWRkaXJwbHVzIGNhdXNlcw0KPiB0aGUgcmVhZGluZyBjbGllbnQgdG8g
a2VlcCByZXN0YXJ0aW5nIFJFQURESVJQTFVTIGZyb20gY29va2llIDANCj4gd2hpY2ggY2F1c2Vz
IHRoZSAnbHMgLWwnIHRvIHRha2UgYSB2ZXJ5IGxvbmcgdGltZSB0byBjb21wbGV0ZSwNCj4gcG9z
c2libHkgbmV2ZXIgY29tcGxldGluZy4NCj4gDQo+IEN1cnJlbnRseSB3aGVuIG5mc19mb3JjZV91
c2VfcmVhZGRpcnBsdXMgaXMgY2FsbGVkIHRvIHN3aXRjaCBmcm9tDQo+IFJFQURESVIgdG8gUkVB
RERJUlBMVVMsIGl0IGludmFsaWRhdGVzIGFsbCB0aGUgY2FjaGVkIHBhZ2VzIG9mIHRoZQ0KPiBk
aXJlY3RvcnkuIFRoaXMgY2FjaGUgcGFnZSBpbnZhbGlkYXRpb24gY2F1c2VzIHRoZSBuZXh0IG5m
c19yZWFkZGlyDQo+IHRvIHJlLXJlYWQgdGhlIGRpcmVjdG9yeSBjb250ZW50IGZyb20gY29va2ll
IDAuDQo+IA0KPiBUaGlzIHBhdGNoIGlzIHRvIG9wdGltaXNlIHRoZSBjYWNoZSBpbnZhbGlkYXRp
b24gaW4NCj4gbmZzX2ZvcmNlX3VzZV9yZWFkZGlycGx1cyBieSBvbmx5IHRydW5jYXRpbmcgdGhl
IGNhY2hlZCBwYWdlcyBmcm9tDQo+IGxhc3QgcGFnZSBpbmRleCBhY2Nlc3NlZCB0byB0aGUgZW5k
IHRoZSBmaWxlLiBJdCBhbHNvIG1hcmtzIHRoZQ0KPiBpbm9kZSB0byBkZWxheSBpbnZhbGlkYXRp
bmcgYWxsIHRoZSBjYWNoZWQgcGFnZSBvZiB0aGUgZGlyZWN0b3J5DQo+IHVudGlsIHRoZSBuZXh0
IGluaXRpYWwgbmZzX3JlYWRkaXIgb2YgdGhlIG5leHQgJ2xzJyBpbnN0YW5jZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCj4gDQo+IC0tLQ0KPiAg
ZnMvbmZzL2Rpci5jICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKystDQo+ICBpbmNsdWRlL2xp
bnV4L25mc19mcy5oIHwgIDMgKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvZGlyLmMgYi9mcy9u
ZnMvZGlyLmMNCj4gaW5kZXggZTE4MDAzM2UzNWNmLi4zZmJmMmU0MWQ1MjMgMTAwNjQ0DQo+IC0t
LSBhL2ZzL25mcy9kaXIuYw0KPiArKysgYi9mcy9uZnMvZGlyLmMNCj4gQEAgLTQzNyw3ICs0Mzcs
MTAgQEAgdm9pZCBuZnNfZm9yY2VfdXNlX3JlYWRkaXJwbHVzKHN0cnVjdCBpbm9kZQ0KPiAqZGly
KQ0KPiAgCWlmIChuZnNfc2VydmVyX2NhcGFibGUoZGlyLCBORlNfQ0FQX1JFQURESVJQTFVTKSAm
Jg0KPiAgCSAgICAhbGlzdF9lbXB0eSgmbmZzaS0+b3Blbl9maWxlcykpIHsNCj4gIAkJc2V0X2Jp
dChORlNfSU5PX0FEVklTRV9SRFBMVVMsICZuZnNpLT5mbGFncyk7DQo+IC0JCWludmFsaWRhdGVf
bWFwcGluZ19wYWdlcyhkaXItPmlfbWFwcGluZywgMCwgLTEpOw0KPiArCQluZnNfemFwX21hcHBp
bmcoZGlyLCBkaXItPmlfbWFwcGluZyk7DQo+ICsJCWlmIChORlNfUFJPVE8oZGlyKS0+dmVyc2lv
biA9PSAzKQ0KPiArCQkJaW52YWxpZGF0ZV9tYXBwaW5nX3BhZ2VzKGRpci0+aV9tYXBwaW5nLA0K
PiArCQkJCW5mc2ktPnBhZ2VfaW5kZXggKyAxLCAtMSk7DQoNCkxldCdzIGRvIHRoaXMgZm9yIE5G
U3Y0IGFzIHdlbGwuIFRoZSBtb3RpdmF0aW9uIGlzIHRoZSBzYW1lOiB0byBhbGxvdw0KdXMgdG8g
cmVwbGFjZSBhIHNlcmllcyBvZiBHRVRBVFRSIGNhbGxzIHRvIG9uZSBvciBtb3JlIFJFQURESVJQ
TFVTDQpjYWxscy4NCg0KPiAgCX0NCj4gIH0NCj4gIA0KPiBAQCAtNzA5LDYgKzcxMiw5IEBAIHN0
cnVjdCBwYWdlDQo+ICpnZXRfY2FjaGVfcGFnZShuZnNfcmVhZGRpcl9kZXNjcmlwdG9yX3QgKmRl
c2MpDQo+ICBpbnQgZmluZF9jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdCAqZGVz
YykNCj4gIHsNCj4gIAlpbnQgcmVzOw0KPiArCXN0cnVjdCBpbm9kZSAqaW5vZGU7DQo+ICsJc3Ry
dWN0IG5mc19pbm9kZSAqbmZzaTsNCj4gKwlzdHJ1Y3QgZGVudHJ5ICpkZW50cnk7DQo+ICANCj4g
IAlkZXNjLT5wYWdlID0gZ2V0X2NhY2hlX3BhZ2UoZGVzYyk7DQo+ICAJaWYgKElTX0VSUihkZXNj
LT5wYWdlKSkNCj4gQEAgLTcxNyw2ICs3MjMsMTIgQEAgaW50IGZpbmRfY2FjaGVfcGFnZShuZnNf
cmVhZGRpcl9kZXNjcmlwdG9yX3QNCj4gKmRlc2MpDQo+ICAJcmVzID0gbmZzX3JlYWRkaXJfc2Vh
cmNoX2FycmF5KGRlc2MpOw0KPiAgCWlmIChyZXMgIT0gMCkNCj4gIAkJY2FjaGVfcGFnZV9yZWxl
YXNlKGRlc2MpOw0KPiArDQo+ICsJZGVudHJ5ID0gZmlsZV9kZW50cnkoZGVzYy0+ZmlsZSk7DQo+
ICsJaW5vZGUgPSBkX2lub2RlKGRlbnRyeSk7DQo+ICsJbmZzaSA9IE5GU19JKGlub2RlKTsNCj4g
KwluZnNpLT5wYWdlX2luZGV4ID0gZGVzYy0+cGFnZV9pbmRleDsNCj4gKw0KPiAgCXJldHVybiBy
ZXM7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbmZzX2ZzLmggYi9p
bmNsdWRlL2xpbnV4L25mc19mcy5oDQo+IGluZGV4IGMwNmIxZmQxMzBmMy4uYTVmOGYwM2VjZDU5
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oDQo+ICsrKyBiL2luY2x1ZGUv
bGludXgvbmZzX2ZzLmgNCj4gQEAgLTE2OCw2ICsxNjgsOSBAQCBzdHJ1Y3QgbmZzX2lub2RlIHsN
Cj4gIAlzdHJ1Y3Qgcndfc2VtYXBob3JlCXJtZGlyX3NlbTsNCj4gIAlzdHJ1Y3QgbXV0ZXgJCWNv
bW1pdF9tdXRleDsNCj4gIA0KPiArCS8qIHRyYWNrIGxhc3QgYWNjZXNzIHRvIGNhY2hlZCBwYWdl
cyAqLw0KPiArCXVuc2lnbmVkIGxvbmcJCXBhZ2VfaW5kZXg7DQo+ICsNCj4gICNpZiBJU19FTkFC
TEVEKENPTkZJR19ORlNfVjQpDQo+ICAJc3RydWN0IG5mczRfY2FjaGVkX2FjbAkqbmZzNF9hY2w7
DQo+ICAgICAgICAgIC8qIE5GU3Y0IHN0YXRlICovDQoNCk90aGVyd2lzZSwgdGhlIHBhdGNoIGxv
b2tzIGdvb2QgdG8gbWUuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
