Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5CB28F45E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Oct 2020 16:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgJOOIH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Oct 2020 10:08:07 -0400
Received: from mail-bn8nam08on2126.outbound.protection.outlook.com ([40.107.100.126]:5504
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730730AbgJOOIG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Oct 2020 10:08:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF1Hrr/P4sN1Ku7ShEGGmGYUc5keMlQa536nWNpm8+owKUoVD8rVSqLcnb2HD6Y4H+KYeMzkYIK+VnuRo+CHBe6YefW2Vty6qIucCuPPrpbDt5f2Ox0O3vPQqQF7p1NOCVaynco0yd+CSa1ykfPUoIU+UDUixIjolH5j4fDNSsWGcvLq0eoG8SGhadFfstZU05tGneFSdTJ7OIfjQaBMMzx0bFj75hMJ3Pg1e5JE8lh53MWTdWqkIlNNmK2vCJRaLndjNOrO6TV4QAk/RJniduRD3N5+7sUrUAtqZx15PSHV4RYW7rGXH/4yYJ6wypX+ibBtShLAvQt3A8nXrLWp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X2hwVQYcE2SYkk3tK32B2ImNIaU+c5ug8DNZwtoMgY=;
 b=ZpATaRFSKG+Jxayx9nAXNf1z3wEDRZwKzI4gpsB4hZQHNnhbXa09smfLnAiVJQUSyBwzFpbvpinA8B/RrYknOj7yguFprn+1cadmbZQVtUrM8fYql+0GPkr/dPYPOdwIWhl5hzZmAKa0YEQ4Lr9gggTmzVU34lnL/ql6SVD3FeZHhwYsqciiYyESKnbP6HRoVBzSfgh8NDp3og5UN2bLI9ODv5VRx5HJvm8R5wNl4owAvaXNbhSWKoEmtcZwISIOgp6BaZDgRlnU2vrAbBbAVUfw9IIg2Tjx+0zzbPd+4Z92V4931Gi74EURiUBq866oWP42W+g3rgZp2jKTdIV1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X2hwVQYcE2SYkk3tK32B2ImNIaU+c5ug8DNZwtoMgY=;
 b=NQYbtRefEEbH1rGCm95U1EJYChkoMRc2VjYKNF5nzIJXOCfNKEo3vtp3byT7DU3C+TkiQOWd/n+NAys1QFiNfdeTXiT9RF70LU6aC7ahVMm3D/mhE+kUY/x0X2HF0bZeq+rcxdhki7SZj8gBWyZYbLmTgvmcs7fRdj0xpdrSjHo=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3678.namprd13.prod.outlook.com (2603:10b6:208:1e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11; Thu, 15 Oct
 2020 14:08:02 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%8]) with mapi id 15.20.3499.004; Thu, 15 Oct 2020
 14:08:02 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jencce.kernel@gmail.com" <jencce.kernel@gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: support EXCHGID4_FLAG_SUPP_FENCE_OPS 4.2
 EXCHANGE_ID flag
Thread-Topic: [PATCH 1/1] NFSv4.2: support EXCHGID4_FLAG_SUPP_FENCE_OPS 4.2
 EXCHANGE_ID flag
Thread-Index: AQHWovgVepyvCv5tRU+MEtlMvD45C6mYsz0A
Date:   Thu, 15 Oct 2020 14:08:02 +0000
Message-ID: <a3aa9091ff44b69d8dd266a9e7cd51b96fcdb9a7.camel@hammerspace.com>
References: <20201015133543.58589-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20201015133543.58589-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8b9c5f6-07b3-4d93-fce8-08d87113bac2
x-ms-traffictypediagnostic: MN2PR13MB3678:
x-microsoft-antispam-prvs: <MN2PR13MB36789F4A0B2C6966A938BE75B8020@MN2PR13MB3678.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6XhrwtUxX2JQye8LJCX7YAlOTii47FB/PC7sOMFhQwcpERaDfI3lesy/WxKZ+/DaWdBhdL9mXAPSDXlpSh7vKFRYWZWN6sxdh9K2n9wOwRjnMgmhRdYKjbGPLFLxM+7iGI0IlCWocfaTBmT5x0tdw49PQ553ZJk6m4OXruJ/KyczotJv1GqX/Mo4zUC/Rzv3THBfkIMi2o9cthcFX2qLcv0q1I/Ko91uv/Zuf0TCYbdQzIGnKgg75SsW+9uQXbMPtNnqRO6/JFJFgUf9sCzY4G/MVgnYpDWjWRECCDY2lsnEBxnV4G2W7dpKQkitiyn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(376002)(136003)(366004)(346002)(4326008)(8676002)(8936002)(478600001)(6506007)(186003)(26005)(2616005)(316002)(6512007)(86362001)(5660300002)(66446008)(2906002)(71200400001)(6486002)(66946007)(66476007)(83380400001)(4001150100001)(36756003)(54906003)(64756008)(91956017)(110136005)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Y+1uv9eL6DIzgqvbXtyZVRr6RQrqdhVEib9u5803e93EfQMD0XSfqDaUE0bX82HtBteOtMR+lDkZhQvjus3SbilA8OuKfkwmF2I+Px8ijMmhr2u2IbBBu8RPEvcZVQ2/JN6XomYB3K5c6jYQeVR0E/VTArRguFapw6x6dqThZqmcf+aqHNErvDJGpnfqje2Bix0gYReYwHe2vcL/TXeVRNvotOrUS7Wnmh5kHDV9D5zNMg92zWjcTwueIdYQ/+UyrbpNc5OCufP8L2QRVcgJ3A+jiipN4WMQ4fUpTm964j2vt74UMKaSRFbQOGHbswHVbQwG0JsXwIE+4QG0k+tYxQxSbSOe+8Cqtjs2B+uJ6ghgFYf8SFxYqJVrohdug5GHg8jqlA10InOxcER5kGjli92sp3yrs52fT8bGpb/0KoICMxqBximURQcyDC1+RZwFIsopLVtd5xBFmG3dmwi8EZAgtpxbZ5GUbMgB2H5zdySkPqoKexCG9IKvIcxg1gyzm/Bcp5Vm9NKuuBFXWN0EAyJa1UNocwxK3rAXmmhxK0xBq//Y4jvYBhAco+yjXVNdx5EncPm1Iw5mAn1Fw1diJBe8P8yuyr52v2JivY72fUUEmFzEIqCAXPkLvNvg2a2ZE6W/baF3dyyANSw4RfNlvw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B67649A4BEB1B149AC819B2C05B9A163@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b9c5f6-07b3-4d93-fce8-08d87113bac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 14:08:02.2422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8Ki9RoS2pd7JblrDZn43021BffgZFKASX2RhwBjg7T9nJy1ht5bcxKKG8+lX7ljCxl/4TNUJxw5RmCykcSbng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3678
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gVGh1LCAyMDIwLTEwLTE1IGF0IDA5OjM1IC0wNDAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5j
b20+DQo+IA0KPiBSRkMgNzg2MiBpbnRyb2R1Y2VkIGEgbmV3IGZsYWcgdGhhdCBlaXRoZXIgY2xp
ZW50IG9yIHNlcnZlciBpcw0KPiBhbGxvd2VkIHRvIHNldDogRVhDSEdJRDRfRkxBR19TVVBQX0ZF
TkNFX09QUy4NCj4gDQo+IENsaWVudCBuZWVkcyB0byB1cGRhdGUgaXRzIGJpdG1hc2sgdG8gYWxs
b3cgZm9yIHRoaXMgZmxhZyB2YWx1ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmll
dnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiBDQzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+
DQo+IC0tLQ0KPiAgZnMvbmZzL25mczRwcm9jLmMgICAgICAgICB8IDkgKysrKysrLS0tDQo+ICBp
bmNsdWRlL3VhcGkvbGludXgvbmZzNC5oIHwgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZz
NHByb2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IGluZGV4IDZlOTVjODVmZTM5NS4uMjBmMmUw
ZjVjNWJhIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiArKysgYi9mcy9uZnMv
bmZzNHByb2MuYw0KPiBAQCAtODAzOSw5ICs4MDM5LDExIEBAIGludCBuZnM0X3Byb2Nfc2VjaW5m
byhzdHJ1Y3QgaW5vZGUgKmRpciwgY29uc3QNCj4gc3RydWN0IHFzdHIgKm5hbWUsDQo+ICAgKiBi
b3RoIFBORlMgYW5kIE5PTl9QTkZTIGZsYWdzIHNldCwgYW5kIG5vdCBoYXZpbmcgb25lIG9mIE5P
Tl9QTkZTLA0KPiBQTkZTLCBvcg0KPiAgICogRFMgZmxhZ3Mgc2V0Lg0KPiAgICovDQo+IC1zdGF0
aWMgaW50IG5mczRfY2hlY2tfY2xfZXhjaGFuZ2VfZmxhZ3ModTMyIGZsYWdzKQ0KPiArc3RhdGlj
IGludCBuZnM0X2NoZWNrX2NsX2V4Y2hhbmdlX2ZsYWdzKHUzMiBmbGFncywgaW50IHZlcnNpb24p
DQo+ICB7DQo+IC0JaWYgKGZsYWdzICYgfkVYQ0hHSUQ0X0ZMQUdfTUFTS19SKQ0KPiArCWlmICh2
ZXJzaW9uID49IDIgJiYgKGZsYWdzICYgfkVYQ0hHSUQ0XzJfRkxBR19NQVNLX1IpKQ0KPiArCQln
b3RvIG91dF9pbnZhbDsNCj4gKwllbHNlIGlmICh2ZXJzaW9uIDwgMiAmJiAoZmxhZ3MgJiB+RVhD
SEdJRDRfRkxBR19NQVNLX1IpKQ0KPiAgCQlnb3RvIG91dF9pbnZhbDsNCj4gIAlpZiAoKGZsYWdz
ICYgRVhDSEdJRDRfRkxBR19VU0VfUE5GU19NRFMpICYmDQo+ICAJICAgIChmbGFncyAmIEVYQ0hH
SUQ0X0ZMQUdfVVNFX05PTl9QTkZTKSkNCj4gQEAgLTg0NTQsNyArODQ1Niw4IEBAIHN0YXRpYyBp
bnQgX25mczRfcHJvY19leGNoYW5nZV9pZChzdHJ1Y3QNCj4gbmZzX2NsaWVudCAqY2xwLCBjb25z
dCBzdHJ1Y3QgY3JlZCAqY3JlDQo+ICAJaWYgKHN0YXR1cyAgIT0gMCkNCj4gIAkJZ290byBvdXQ7
DQo+ICANCj4gLQlzdGF0dXMgPSBuZnM0X2NoZWNrX2NsX2V4Y2hhbmdlX2ZsYWdzKHJlc3AtPmZs
YWdzKTsNCj4gKwlzdGF0dXMgPSBuZnM0X2NoZWNrX2NsX2V4Y2hhbmdlX2ZsYWdzKHJlc3AtPmZs
YWdzLA0KPiArCQkJY2xwLT5jbF9tdm9wcy0+bWlub3JfdmVyc2lvbik7DQo+ICAJaWYgKHN0YXR1
cyAgIT0gMCkNCj4gIAkJZ290byBvdXQ7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFw
aS9saW51eC9uZnM0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvbmZzNC5oDQo+IGluZGV4IGJmMTk3
ZTk5Yjk4Zi4uM2ZhYTk0ODY3ZmVjIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgv
bmZzNC5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9uZnM0LmgNCj4gQEAgLTE0Niw2ICsx
NDYsNyBAQA0KPiAgICovDQo+ICAjZGVmaW5lIEVYQ0hHSUQ0X0ZMQUdfTUFTS19BCQkJMHg0MDA3
MDEwMw0KPiAgI2RlZmluZSBFWENIR0lENF9GTEFHX01BU0tfUgkJCTB4ODAwNzAxMDMNCj4gKyNk
ZWZpbmUgRVhDSEdJRDRfMl9GTEFHX01BU0tfUgkJCTB4ODAwNzAxMDQNCj4gIA0KPiAgI2RlZmlu
ZSBTRVE0X1NUQVRVU19DQl9QQVRIX0RPV04JCTB4MDAwMDAwMDENCj4gICNkZWZpbmUgU0VRNF9T
VEFUVVNfQ0JfR1NTX0NPTlRFWFRTX0VYUElSSU5HCTB4MDAwMDAwMDINCg0KVGhhbmtzISBJIGZp
bmQgaXQgdmVyeSBhbm5veWluZyB0aGF0IHRoZSBORlN2NC4yIHNwZWMgYWxsb3dzIHRoZSBzZXJ2
ZXINCnRvIHJldHVybiBhIG5ldyBFWENIQU5HRV9JRCBmbGFnIHRoYXQgaXMgbm90IGJhY2t3YXJk
IGNvbXBhdGlibGUgd2l0aA0KTkZTdjQuMSwgZGVzcGl0ZSB0aGUgY2xpZW50IG5vdCBjaGFuZ2lu
ZyBpdHMgYXJndW1lbnRzIGFuZCBhc2tpbmcgZm9yDQp0aGF0IGJlaGF2aW91ci4NCg0KQ2FuIHlv
dSBwbGVhc2UgYWRkIGluIGEgZGVmaW5pdGlvbiBmb3IgRVhDSEdJRDRfRkxBR19TVVBQX0ZFTkNF
X09QUw0Kd2hpbGUgd2UncmUgYXQgaXQsIHNvIHRoYXQgd2UgY2FuIGRvY3VtZW50IHdoeSB0aGVy
ZSBpcyBhIGNoYW5nZSBpbiB0aGUNCm1hc2s/DQoNCkFsc28gcGxlYXNlIG5vdGUgdGhhdCBFWENI
R0lENF8yX0ZMQUdfTUFTS19SIG5lZWRzIHRvIHRha2UgYSB2YWx1ZSBvZg0KKEVYQ0hHSUQ0X0ZM
QUdfTUFTS19SIHwgRVhDSEdJRDRfRkxBR19TVVBQX0ZFTkNFX09QUyksIHNpbmNlIGFsbCB0aGUN
CmV4aXN0aW5nIGZsYWdzIGluIEVYQ0hHSUQ0X0ZMQUdfTUFTS19SIGFyZSBzdGlsbCB2YWxpZC4g
U28gdGhlIGFib3ZlDQpkZWZpbmUgbmVlZHMgdG8gcmVhZCBhcw0KDQojZGVmaW5lIEVYQ0hHSUQ0
XzJfRkxBR19NQVNLX1IJCTB4ODAwNzAxMDcNCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
