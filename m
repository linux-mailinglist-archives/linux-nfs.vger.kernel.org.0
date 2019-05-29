Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC22E2F1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2019 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfE2RN5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 13:13:57 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:13314
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfE2RN5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 13:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdyNU2PGZc9Ijgq/oaQsb7KquXrMnTreu+8dj6Cw5a8=;
 b=d/Ttb7M3/Phmjfrg2zLtFBw+zxSig6Lj+dkQqdGTgdv2C7ehg0v6VBtk4j1Vu47QFS+tgtMkFnOeaNsk8TkBrM0RLtbJCV05P/aG++c2NxZvHmMO5zHwPt47jMVEsAuMWVSgmMS+Z4NMXlcEtdzVOneclszOXE0sZGWESGsJSlA=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1113.namprd13.prod.outlook.com (10.168.119.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.12; Wed, 29 May 2019 17:13:52 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Wed, 29 May 2019
 17:13:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "nbowler@draconx.ca" <nbowler@draconx.ca>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Olga.Kornievskaia@netapp.com" <Olga.Kornievskaia@netapp.com>
Subject: Re: PROBLEM: oops spew with Linux 5.1.5 (NFS regression?)
Thread-Topic: PROBLEM: oops spew with Linux 5.1.5 (NFS regression?)
Thread-Index: AQHVFjHGFgpyC3z9qUaYOUWJf0WI2aaCV1+A
Date:   Wed, 29 May 2019 17:13:52 +0000
Message-ID: <ceecedad1b650f703a12ec3424493c4a73d1e20e.camel@hammerspace.com>
References: <20190529151003.hzmesyoiopnbcgkb@aura.draconx.ca>
In-Reply-To: <20190529151003.hzmesyoiopnbcgkb@aura.draconx.ca>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac5b07d0-4512-4ea5-2595-08d6e4590626
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1113;
x-ms-traffictypediagnostic: DM5PR13MB1113:
x-microsoft-antispam-prvs: <DM5PR13MB11135C8162B99F6653808060B81F0@DM5PR13MB1113.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39830400003)(189003)(199004)(68736007)(256004)(6512007)(66066001)(14454004)(36756003)(14444005)(8676002)(53546011)(11346002)(6246003)(486006)(53936002)(2501003)(2201001)(6436002)(2906002)(86362001)(478600001)(76176011)(6506007)(71200400001)(102836004)(99286004)(71190400001)(229853002)(316002)(26005)(305945005)(186003)(110136005)(6486002)(81166006)(81156014)(25786009)(446003)(476003)(2616005)(8936002)(66476007)(66446008)(64756008)(66556008)(66946007)(3846002)(5660300002)(118296001)(76116006)(7736002)(73956011)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1113;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WwiFqrQm73YCSCOBl+pst9OCPDfjjPd0iZT9bp5dfdHJmBavxBROtLijZGYSn9wAdUh3bmCaPm0kc77KIQDmxr0P1wCu77EHabl4VrJ4pzBsKY1MzW+jmAKC2M1hEPe+FbZMWZQNLuOEuoBXBbsI5mmaMz50kqoxsL+PiUervQlHYectdFYiW9n2uehY5QdBfrsEXToNqYlwKn0DypeAltuzik+YQyYiEi5cknamfGF6lTjfvSyVSPXdS/6jEESvNJd8obwC8VBGGyJ2gSdcgImueY4z7EyEf+5vTrhDExEX+IVcegzYcbnApEgsYo67RSfk1/PQwbw84vYdNpw0tpy2kLEjkJfzIp86LASjVWwuawmDCxP3g1OoUfb/vYS7VgS5osDAS4dYXPnAmIQNG5i6GZ7N+URAxYhQ0DylCJU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB23A037CED9FF42A986F1D533FCC75D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5b07d0-4512-4ea5-2595-08d6e4590626
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 17:13:52.4678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1113
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTI5IGF0IDExOjEwIC0wNDAwLCBOaWNrIEJvd2xlciB3cm90ZToNCj4g
SGksDQo+IA0KPiBJIHVwZ3JhZGVkIHRvIExpbnV4IDUuMS41IG9uIG9uZSBtYWNoaW5lIHllc3Rl
cmRheSwgYW5kIHRoaXMgbW9ybmluZw0KPiBJDQo+IGhhcHBlbmVkIG5vdGljZWQgYSBsYXJnZSBh
bW91bnQgb2YgYmFja3RyYWNlcyBpbiB0aGUgbG9nLiAgSXQgYXBwZWFycw0KPiB0aGF0IHRoZSBz
eXN0ZW0gb29wc2VkIDYyIHRpbWVzIG92ZXIgYSBwZXJpb2Qgb2YgYWJvdXQgNSBtaW51dGVzLA0K
PiBwcm9kdWNpbmcgYWJvdXQgaGFsZiBhIG1lZ2FieXRlIG9mIGxvZyBtZXNzYWdlcywgYWZ0ZXIg
d2hpY2ggdGhlDQo+IG1lc3NhZ2VzIHN0b3BwZWQuICBObyBpZGVhIHdoYXQgYWN0aW9uIChpZiBh
bnkpIHRyaWdnZXJlZCB0aGVzZS4NCj4gDQo+IEhvd2V2ZXIsIG90aGVyIHRoYW4gdGhlIG5vaXNl
IGluIHRoZSBsb2dzIHRoZXJlIGlzIG5vdGhpbmcgb2J2aW91c2x5DQo+IGJyb2tlbiwgYnV0IEkg
dGhvdWdodCBJIHNob3VsZCByZXBvcnQgdGhlIHNwZXdzIGFueXdheS4gIEkgd2FzDQo+IHJ1bm5p
bmcNCj4gNS4wLjkgcHJldmlvdXNseSBhbmQgaGF2ZSBub3Qgc2VlbiBhbnkgc2ltaWxhciBlcnJv
cnMuICBUaGUgZmlyc3QNCj4gY291cGxlDQo+IHNwZXdzIGFyZSBhcHBlbmRlZC4gIEFsbCA2NCBm
YXVsdHMgbG9vayB2ZXJ5IHNpbWlsYXIgdG8gdGhlc2Ugb25lcywNCj4gd2l0aA0KPiB0aGUgc2Ft
ZSBmYXVsdGluZyBhZGRyZXNzIGFuZCB0aGUgc2FtZSBycGNfY2hlY2tfdGltZW91dCBmdW5jdGlv
biBhdA0KPiB0aGUNCj4gdG9wIG9mIHRoZSBiYWNrdHJhY2UuDQoNCk9LLCBJIHRoaW5rIHRoaXMg
aXMgdGhlIHNhbWUgcHJvYmxlbSB0aGF0IE9sZ2Egd2FzIHNlZWluZyAoQ2NlZCksIGFuZA0KaXQg
bG9va3MgbGlrZSBJIG1pc3NlZCB0aGUgdXNlLWFmdGVyLWZyZWUgaXNzdWUgd2hlbiB0aGUgc2Vy
dmVyIHJldHVybnMNCmEgY3JlZGVudGlhbCBlcnJvciB3aGVuIHNoZSBhc2tlZC4NCg0KSSBiZWxp
ZXZlIHRoYXQgdGhlIGZvbGxvd2luZyBwYXRjaCBzaG91bGQgZml4IGl0Og0KDQo4PC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KRnJvbSAzMzkwNWY1YTdkMWQyMDBkYjhlZWIzZjRlYTg2NzBjOWRhNGNiNjRkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tPg0KRGF0ZTogV2VkLCAyOSBNYXkgMjAxOSAxMjo0OTo1MiAtMDQwMA0K
U3ViamVjdDogW1BBVENIXSBTVU5SUEM6IEZpeCBhIHVzZSBhZnRlciBmcmVlIHdoZW4gYSBzZXJ2
ZXIgcmVqZWN0cyB0aGUNCiBSUENTRUNfR1NTIGNyZWRlbnRpYWwNCg0KVGhlIGFkZGl0aW9uIG9m
IHJwY19jaGVja190aW1lb3V0KCkgdG8gY2FsbF9kZWNvZGUgY2F1c2VzIGFuIE9vcHMNCndoZW4g
dGhlIFJQQ1NFQ19HU1MgY3JlZGVudGlhbCBpcyByZWplY3RlZC4NClRoZSByZWFzb24gaXMgdGhh
dCBycGNfZGVjb2RlX2hlYWRlcigpIHdpbGwgY2FsbCB4cHJ0X3JlbGVhc2UoKSBpbg0Kb3JkZXIg
dG8gZnJlZSB0YXNrLT50a19ycXN0cCwgd2hpY2ggaXMgbmVlZGVkIGJ5IHJwY19jaGVja190aW1l
b3V0KCkNCnRvIGNoZWNrIHdoZXRoZXIgb3Igbm90IHdlIHNob3VsZCBleGl0IGR1ZSB0byBhIHNv
ZnQgdGltZW91dC4NCg0KVGhlIGZpeCBpcyB0byBtb3ZlIHRoZSBjYWxsIHRvIHhwcnRfcmVsZWFz
ZSgpIGludG8gY2FsbF9kZWNvZGUoKSBzbw0Kd2UgY2FuIHBlcmZvcm0gaXQgYWZ0ZXIgcnBjX2No
ZWNrX3RpbWVvdXQoKS4NCg0KUmVwb3J0ZWQtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxvbGdhLmtv
cm5pZXZza2FpYUBnbWFpbC5jb20+DQpSZXBvcnRlZC1ieTogTmljayBCb3dsZXIgPG5ib3dsZXJA
ZHJhY29ueC5jYT4NCkZpeGVzOiBjZWE1Nzc4OWU0MDggKCJTVU5SUEM6IENsZWFuIHVwIikNCkNj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjUuMSsNClNpZ25lZC1vZmYtYnk6IFRyb25kIE15
a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCi0tLQ0KIG5ldC9zdW5y
cGMvY2xudC5jIHwgMjggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL25l
dC9zdW5ycGMvY2xudC5jIGIvbmV0L3N1bnJwYy9jbG50LmMNCmluZGV4IGQ2ZTU3ZGE1NmM5NC4u
NGMwMmMzN2ZhNzc0IDEwMDY0NA0KLS0tIGEvbmV0L3N1bnJwYy9jbG50LmMNCisrKyBiL25ldC9z
dW5ycGMvY2xudC5jDQpAQCAtMjQyNiwxNyArMjQyNiwyMSBAQCBjYWxsX2RlY29kZShzdHJ1Y3Qg
cnBjX3Rhc2sgKnRhc2spDQogCQlyZXR1cm47DQogCWNhc2UgLUVBR0FJTjoNCiAJCXRhc2stPnRr
X3N0YXR1cyA9IDA7DQotCQkvKiBOb3RlOiBycGNfZGVjb2RlX2hlYWRlcigpIG1heSBoYXZlIGZy
ZWVkIHRoZSBSUEMgc2xvdCAqLw0KLQkJaWYgKHRhc2stPnRrX3Jxc3RwID09IHJlcSkgew0KLQkJ
CXhkcl9mcmVlX2J2ZWMoJnJlcS0+cnFfcmN2X2J1Zik7DQotCQkJcmVxLT5ycV9yZXBseV9ieXRl
c19yZWN2ZCA9IDA7DQotCQkJcmVxLT5ycV9yY3ZfYnVmLmxlbiA9IDA7DQotCQkJaWYgKHRhc2st
PnRrX2NsaWVudC0+Y2xfZGlzY3J0cnkpDQotCQkJCXhwcnRfY29uZGl0aW9uYWxfZGlzY29ubmVj
dChyZXEtPnJxX3hwcnQsDQotCQkJCQkJCSAgICByZXEtPnJxX2Nvbm5lY3RfY29va2llKTsNCi0J
CX0NCisJCXhkcl9mcmVlX2J2ZWMoJnJlcS0+cnFfcmN2X2J1Zik7DQorCQlyZXEtPnJxX3JlcGx5
X2J5dGVzX3JlY3ZkID0gMDsNCisJCXJlcS0+cnFfcmN2X2J1Zi5sZW4gPSAwOw0KKwkJaWYgKHRh
c2stPnRrX2NsaWVudC0+Y2xfZGlzY3J0cnkpDQorCQkJeHBydF9jb25kaXRpb25hbF9kaXNjb25u
ZWN0KHJlcS0+cnFfeHBydCwNCisJCQkJCQkgICAgcmVxLT5ycV9jb25uZWN0X2Nvb2tpZSk7DQog
CQl0YXNrLT50a19hY3Rpb24gPSBjYWxsX2VuY29kZTsNCiAJCXJwY19jaGVja190aW1lb3V0KHRh
c2spOw0KKwkJYnJlYWs7DQorCWNhc2UgLUVLRVlSRUpFQ1RFRDoNCisJCXRhc2stPnRrX2FjdGlv
biA9IGNhbGxfcmVzZXJ2ZTsNCisJCXJwY19jaGVja190aW1lb3V0KHRhc2spOw0KKwkJcnBjYXV0
aF9pbnZhbGNyZWQodGFzayk7DQorCQkvKiBFbnN1cmUgd2Ugb2J0YWluIGEgbmV3IFhJRCBpZiB3
ZSByZXRyeSEgKi8NCisJCXhwcnRfcmVsZWFzZSh0YXNrKTsNCiAJfQ0KIH0NCiANCkBAIC0yNTcy
LDExICsyNTc2LDcgQEAgcnBjX2RlY29kZV9oZWFkZXIoc3RydWN0IHJwY190YXNrICp0YXNrLCBz
dHJ1Y3QgeGRyX3N0cmVhbSAqeGRyKQ0KIAkJCWJyZWFrOw0KIAkJdGFzay0+dGtfY3JlZF9yZXRy
eS0tOw0KIAkJdHJhY2VfcnBjX19zdGFsZV9jcmVkcyh0YXNrKTsNCi0JCXJwY2F1dGhfaW52YWxj
cmVkKHRhc2spOw0KLQkJLyogRW5zdXJlIHdlIG9idGFpbiBhIG5ldyBYSUQhICovDQotCQl4cHJ0
X3JlbGVhc2UodGFzayk7DQotCQl0YXNrLT50a19hY3Rpb24gPSBjYWxsX3Jlc2VydmU7DQotCQly
ZXR1cm4gLUVBR0FJTjsNCisJCXJldHVybiAtRUtFWVJFSkVDVEVEOw0KIAljYXNlIHJwY19hdXRo
ZXJyX2JhZGNyZWQ6DQogCWNhc2UgcnBjX2F1dGhlcnJfYmFkdmVyZjoNCiAJCS8qIHBvc3NpYmx5
IGdhcmJsZWQgY3JlZC92ZXJmPyAqLw0KLS0gDQoyLjIxLjANCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
