Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB861470DE
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 19:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAWSfU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jan 2020 13:35:20 -0500
Received: from mail-eopbgr680130.outbound.protection.outlook.com ([40.107.68.130]:49435
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbgAWSfU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 Jan 2020 13:35:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpMFqRimVWly6GI2L7cnN/pgoX9mB4PSNzdEs/8GbVgn9Zu4xP8GZ0y2y8c2OeP/G5nCuMi5+aWvylZAjwGbIIeyL7MIZmsaayYSxFE5uSumjZKXKNdx3+D4HwR583wh83LWUSj/aZkMPvath6PlfYSZDMa3xyvSWOeTFR2W00CI23/0fg/Opxc1xNZpSJUjZn61ZYkoQsz01i9rj6HAiBRt8L8+Yals502nI1QyMl3r6NVECu1y/kbsCsSBe+AM5KnnlETBVFs0eHi7Z6mVpbusrecyEgAO+aqSWKmBeiBg3qIdz2NCMGQ1wBFxev6bDcATT0W9x4eedYtNEBCULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zGUlOPyRmyCdiTXXknNLv1wRGRMC8zhJksoUocQwgc=;
 b=nfZYjJXKF0wfiEZibiI78+1Ufg1UQU968vw/Rw0uKBLnFsjngM2Q0nBFVnOqTc//zG2hQQYVRObivRo5EIJz/1L9aTIq9WKjhyTjKGvKbD/99kslZq+BJbs+oYJk3Rph9SuTRxZ9j3J5gn00+KZYch/Hg/jy20hKfDWK9GYoGt8UzOWg+kOzXAU+Xcdh7xTuPOlLr9cSNjp7iux8AfF9gIVgxjtz15SAAh0s8Uofb2IJ+sBZsdqOoXqzz9ZHmxN2sVLgXoBzfXL0AsDhIvZIN+jllyTBGZpanT/Vlh3NVDMDorwtZ9Bm2ZbuE07DVifE5SM240OckQ/ianojAPmDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zGUlOPyRmyCdiTXXknNLv1wRGRMC8zhJksoUocQwgc=;
 b=aLazLXD5xO8JpC7Kn4DnoOpArDs0gPUJAOw0tgGTTpvyzC3Y2np2MsWYEOnOp3F/jBryQcxM0HJyH76IAwD8nYI8tYpTCPVhAgVdXEmv10/UjxS17BE5O51fRAlXpaRiKZFlaOunTGQf+d3fWKXfviDFvuLg+VSdvA4wpAlUqnQ=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2042.namprd13.prod.outlook.com (10.174.184.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.15; Thu, 23 Jan 2020 18:35:15 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 18:35:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH RFC] nfs: optimise readdir cache page invalidation
Thread-Topic: [PATCH RFC] nfs: optimise readdir cache page invalidation
Thread-Index: AQHV0X6U5aSV8zhXw0mJsuFxO+G2sqf4lLYA
Date:   Thu, 23 Jan 2020 18:35:15 +0000
Message-ID: <3a456c6e607700ee745b19d82481ec7193ca08eb.camel@hammerspace.com>
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
x-ms-office365-filtering-correlation-id: 7b5f76fa-f34e-4108-0cfe-08d7a032fd70
x-ms-traffictypediagnostic: DM5PR1301MB2042:
x-microsoft-antispam-prvs: <DM5PR1301MB20421FEFE0C8425C4A83A516B80F0@DM5PR1301MB2042.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39830400003)(376002)(136003)(199004)(189003)(186003)(36756003)(76116006)(66946007)(91956017)(66446008)(64756008)(66476007)(66556008)(8676002)(81166006)(81156014)(26005)(86362001)(316002)(5660300002)(2616005)(110136005)(478600001)(2906002)(6512007)(6506007)(6486002)(71200400001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2042;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4A6WRcBAAyCXR3tyCos1tGfQ5h74CeLwHwoar3Dfh0QFV2MVyFiyKk1Q8Dr4tf6yNfKLBdlnZ2jTU4kfTROxN5l+Nopu6Gb8ae0gyLPfJJk8j5tvDz3aPeNegV/rPCw6JcDheoODt51p2SLi7K9G3o0cDSG9WYdeRZe6HCPNTHDJRpaR77Ja9L3UEDYFUq4ZdQTrgy44GZdz0knpYvwHu8qmQaCCmfCw/pKRInGJsahUri1S0UjmDUpV98vM/z00wg9qVV3qdjilQZmjQyrWW65l1mjppngxtR3WEiFnueT5QHDJvk+oe6WdMNfwlLsuVxdappXoXI99D3n2S/v4M/ZzGnoJfNTDhfh5gVXJdcUN6fMZV3ouSJKQ+QNfHTpAWs3Kx80ikkftRATqYOQ9Gcj5id+h1keSXLmUvqdapUU4wOiseV+UPjcSiYPrLZxD
x-ms-exchange-antispam-messagedata: K4Ubwz2iqDxRRo1iLFmMOM4nQ98Varnvg4Nl+F/2/FyCMeJAoJQ9vdEteR0CEaBcTTvTKYmUxpiUUOaY7n7dC/6KSD02iZJp/YaURtYDB54BJVRmgRcK+cEWJll7uYMiQSyPgQE1HfFX4Oifav9pZw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <079C352F5B0558459266E1C5D54B810F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5f76fa-f34e-4108-0cfe-08d7a032fd70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 18:35:15.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zftll6j6O/Faf5Fj6EUjr87BwkMhVGfq2sEWYz8zIwDMcUtVM4u3JrHTyUHz/e8FQAqsQdIKz4qT9dPMhGoxiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2042
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
Z25lZC1vZmYtYnk6IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCg0KPiAN
Cj4gLS0tDQo+ICBmcy9uZnMvZGlyLmMgICAgICAgICAgIHwgMTQgKysrKysrKysrKysrKy0NCj4g
IGluY2x1ZGUvbGludXgvbmZzX2ZzLmggfCAgMyArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTYg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9k
aXIuYyBiL2ZzL25mcy9kaXIuYw0KPiBpbmRleCBlMTgwMDMzZTM1Y2YuLjNmYmYyZTQxZDUyMyAx
MDA2NDQNCj4gLS0tIGEvZnMvbmZzL2Rpci5jDQo+ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiBAQCAt
NDM3LDcgKzQzNywxMCBAQCB2b2lkIG5mc19mb3JjZV91c2VfcmVhZGRpcnBsdXMoc3RydWN0IGlu
b2RlDQo+ICpkaXIpDQo+ICAJaWYgKG5mc19zZXJ2ZXJfY2FwYWJsZShkaXIsIE5GU19DQVBfUkVB
RERJUlBMVVMpICYmDQo+ICAJICAgICFsaXN0X2VtcHR5KCZuZnNpLT5vcGVuX2ZpbGVzKSkgew0K
PiAgCQlzZXRfYml0KE5GU19JTk9fQURWSVNFX1JEUExVUywgJm5mc2ktPmZsYWdzKTsNCj4gLQkJ
aW52YWxpZGF0ZV9tYXBwaW5nX3BhZ2VzKGRpci0+aV9tYXBwaW5nLCAwLCAtMSk7DQo+ICsJCW5m
c196YXBfbWFwcGluZyhkaXIsIGRpci0+aV9tYXBwaW5nKTsNCj4gKwkJaWYgKE5GU19QUk9UTyhk
aXIpLT52ZXJzaW9uID09IDMpDQo+ICsJCQlpbnZhbGlkYXRlX21hcHBpbmdfcGFnZXMoZGlyLT5p
X21hcHBpbmcsDQo+ICsJCQkJbmZzaS0+cGFnZV9pbmRleCArIDEsIC0xKTsNCj4gIAl9DQo+ICB9
DQo+ICANCj4gQEAgLTcwOSw2ICs3MTIsOSBAQCBzdHJ1Y3QgcGFnZQ0KPiAqZ2V0X2NhY2hlX3Bh
Z2UobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90ICpkZXNjKQ0KPiAgaW50IGZpbmRfY2FjaGVfcGFn
ZShuZnNfcmVhZGRpcl9kZXNjcmlwdG9yX3QgKmRlc2MpDQo+ICB7DQo+ICAJaW50IHJlczsNCj4g
KwlzdHJ1Y3QgaW5vZGUgKmlub2RlOw0KPiArCXN0cnVjdCBuZnNfaW5vZGUgKm5mc2k7DQo+ICsJ
c3RydWN0IGRlbnRyeSAqZGVudHJ5Ow0KPiAgDQo+ICAJZGVzYy0+cGFnZSA9IGdldF9jYWNoZV9w
YWdlKGRlc2MpOw0KPiAgCWlmIChJU19FUlIoZGVzYy0+cGFnZSkpDQo+IEBAIC03MTcsNiArNzIz
LDEyIEBAIGludCBmaW5kX2NhY2hlX3BhZ2UobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90DQo+ICpk
ZXNjKQ0KPiAgCXJlcyA9IG5mc19yZWFkZGlyX3NlYXJjaF9hcnJheShkZXNjKTsNCj4gIAlpZiAo
cmVzICE9IDApDQo+ICAJCWNhY2hlX3BhZ2VfcmVsZWFzZShkZXNjKTsNCj4gKw0KPiArCWRlbnRy
eSA9IGZpbGVfZGVudHJ5KGRlc2MtPmZpbGUpOw0KPiArCWlub2RlID0gZF9pbm9kZShkZW50cnkp
Ow0KPiArCW5mc2kgPSBORlNfSShpbm9kZSk7DQo+ICsJbmZzaS0+cGFnZV9pbmRleCA9IGRlc2Mt
PnBhZ2VfaW5kZXg7DQo+ICsNCj4gIAlyZXR1cm4gcmVzOw0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oIGIvaW5jbHVkZS9saW51eC9uZnNfZnMuaA0KPiBp
bmRleCBjMDZiMWZkMTMwZjMuLmE1ZjhmMDNlY2Q1OSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9uZnNfZnMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L25mc19mcy5oDQo+IEBAIC0xNjgs
NiArMTY4LDkgQEAgc3RydWN0IG5mc19pbm9kZSB7DQo+ICAJc3RydWN0IHJ3X3NlbWFwaG9yZQly
bWRpcl9zZW07DQo+ICAJc3RydWN0IG11dGV4CQljb21taXRfbXV0ZXg7DQo+ICANCj4gKwkvKiB0
cmFjayBsYXN0IGFjY2VzcyB0byBjYWNoZWQgcGFnZXMgKi8NCj4gKwl1bnNpZ25lZCBsb25nCQlw
YWdlX2luZGV4Ow0KPiArDQo+ICAjaWYgSVNfRU5BQkxFRChDT05GSUdfTkZTX1Y0KQ0KPiAgCXN0
cnVjdCBuZnM0X2NhY2hlZF9hY2wJKm5mczRfYWNsOw0KPiAgICAgICAgICAvKiBORlN2NCBzdGF0
ZSAqLw0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
