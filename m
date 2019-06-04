Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0534F6B
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFDR7D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 13:59:03 -0400
Received: from mail-eopbgr730123.outbound.protection.outlook.com ([40.107.73.123]:46880
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfFDR7D (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 13:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vInLYXECmkujHezdDpjvkwLDrqcnYd03CwrH4WfXp2w=;
 b=akq8b4J0MwZQa/Z0x0tGMBcKLb/yzq/1Us4zC7QXvy+Vp4n2bfmPxZCS48nGjPBVRXA0XneV7aefMUxzWy5WcNtmbmTAZEbw99SmnUJYe8CqD+9ZFbnkoH11muuhJK/enTn22LZ4NX22CQaYAIX2pCUvtbLdC1cuqhhVa+kmUjo=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1019.namprd13.prod.outlook.com (10.168.237.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 4 Jun 2019 17:59:00 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1965.007; Tue, 4 Jun 2019
 17:59:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 2/3] mountd: Ensure nfsd_path_strip_root() uses the
 canonicalised path
Thread-Topic: [PATCH 2/3] mountd: Ensure nfsd_path_strip_root() uses the
 canonicalised path
Thread-Index: AQHVGjAEqdFAvv6WuUKwXOwL1x0aFaaLpOOAgAAlGAA=
Date:   Tue, 4 Jun 2019 17:58:59 +0000
Message-ID: <1fb61a70b5eea0cd4735aa5ae3050382b317f886.camel@hammerspace.com>
References: <20190603171227.29148-1-trond.myklebust@hammerspace.com>
         <20190603171227.29148-2-trond.myklebust@hammerspace.com>
         <20190603171227.29148-3-trond.myklebust@hammerspace.com>
         <20190604154611.GC19422@fieldses.org>
In-Reply-To: <20190604154611.GC19422@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.175.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96c896b8-5df5-48b7-3671-08d6e9165267
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1019;
x-ms-traffictypediagnostic: DM5PR13MB1019:
x-microsoft-antispam-prvs: <DM5PR13MB10192F5908C1870953CC9CFDB8150@DM5PR13MB1019.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39830400003)(189003)(199004)(7736002)(4326008)(305945005)(6436002)(99286004)(256004)(6246003)(8676002)(118296001)(73956011)(14454004)(476003)(66556008)(2616005)(81166006)(6486002)(76116006)(1730700003)(64756008)(6916009)(81156014)(66946007)(66476007)(66446008)(11346002)(3846002)(6116002)(446003)(486006)(6512007)(229853002)(54906003)(25786009)(26005)(71190400001)(66066001)(6506007)(8936002)(316002)(76176011)(71200400001)(36756003)(102836004)(5640700003)(53936002)(478600001)(2501003)(5660300002)(2351001)(186003)(2906002)(68736007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1019;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xcFuX0kLr/nyAZ4qKxM+IsDDeHqM01P6mql7McfFPfB8OjpbbCfojbJ+O6xc4kybQu7oJ3zx+wIcEqpY49Kl/ohhQXLMD8flSJI8oCSiJvV8UKeSA1yIHq9tKY8ZIdZXJ1poaOt/Fr6qJfY4XmXBLsjcUMr2evJ4hRM2LhUdwvpN3bhZqL/N91mTrf5jsyx0fbowDu4agLHHsic+MRqTPxGwK5ST7+DUfQffxBndVIFcMUummUeoZsZSTf3VrySA7wyW71cXzjUkRiSnaOZBeCQxGmH5wJF33oJvPoWg9wIfbc5ADqJAd5ULcUI5+OolAvtMd/RoIF4l2SCR3/RK7wU4q+k8Fq3+9NOUAH0romUyJaAi/KUGZvAz5s5g/+NYceHq1RRkvSe1BQUuPLewbu9xZkl/HddHvTWGEYvr8hI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF9295890361EE40AC53389205B36A6C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c896b8-5df5-48b7-3671-08d6e9165267
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 17:58:59.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1019
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTA0IGF0IDExOjQ2IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIE1vbiwgSnVuIDAzLCAyMDE5IGF0IDAxOjEyOjI2UE0gLTA0MDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBXaGVuIGF0dGVtcHRpbmcgdG8gc3RyaXAgdGhlIHJvb3QgcGF0aCwg
d2Ugc2hvdWxkIGZpcnN0DQo+ID4gY2Fub25pY2FsaXNlDQo+ID4gdGhlIHJvb3QgcGF0aG5hbWUu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+ICBzdXBwb3J0L21pc2MvbmZzZF9wYXRo
LmMgfCAxNyArKysrKysrKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc3VwcG9ydC9t
aXNjL25mc2RfcGF0aC5jIGIvc3VwcG9ydC9taXNjL25mc2RfcGF0aC5jDQo+ID4gaW5kZXggMmY0
MWE3OTNjNTM0Li45YjM4ZGQ5NjAwN2YgMTAwNjQ0DQo+ID4gLS0tIGEvc3VwcG9ydC9taXNjL25m
c2RfcGF0aC5jDQo+ID4gKysrIGIvc3VwcG9ydC9taXNjL25mc2RfcGF0aC5jDQo+ID4gQEAgLTEs
NiArMSw3IEBADQo+ID4gICNpbmNsdWRlIDxlcnJuby5oPg0KPiA+ICAjaW5jbHVkZSA8c3lzL3R5
cGVzLmg+DQo+ID4gICNpbmNsdWRlIDxzeXMvc3RhdC5oPg0KPiA+ICsjaW5jbHVkZSA8bGltaXRz
Lmg+DQo+ID4gICNpbmNsdWRlIDxzdGRsaWIuaD4NCj4gPiAgI2luY2x1ZGUgPHVuaXN0ZC5oPg0K
PiA+ICANCj4gPiBAQCAtNjIsMTMgKzYzLDIxIEBAIG5mc2RfcGF0aF9uZnNkX3Jvb3RkaXIodm9p
ZCkNCj4gPiAgY2hhciAqDQo+ID4gIG5mc2RfcGF0aF9zdHJpcF9yb290KGNoYXIgKnBhdGhuYW1l
KQ0KPiA+ICB7DQo+ID4gKwljaGFyIGJ1ZmZlcltQQVRIX01BWF07DQo+ID4gIAljb25zdCBjaGFy
ICpkaXIgPSBuZnNkX3BhdGhfbmZzZF9yb290ZGlyKCk7DQo+ID4gIAljaGFyICpyZXQ7DQo+ID4g
IA0KPiA+IC0JcmV0ID0gc3Ryc3RyKHBhdGhuYW1lLCBkaXIpOw0KPiA+IC0JaWYgKCFyZXQgfHwg
cmV0ICE9IHBhdGhuYW1lKQ0KPiA+IC0JCXJldHVybiBwYXRobmFtZTsNCj4gPiAtCXJldHVybiBw
YXRobmFtZSArIHN0cmxlbihkaXIpOw0KPiA+ICsJaWYgKCFkaXIpDQo+ID4gKwkJZ290byBvdXQ7
DQo+ID4gKwlpZiAocmVhbHBhdGgoZGlyLCBidWZmZXIpKSB7DQo+ID4gKwkJcmV0ID0gc3Ryc3Ry
KHBhdGhuYW1lLCBidWZmZXIpOw0KPiA+ICsJCWlmIChyZXQgPT0gcGF0aG5hbWUpDQo+ID4gKwkJ
CXJldHVybiBwYXRobmFtZSArIHN0cmxlbihkaXIpOw0KPiA+ICsJfSBlbHNlDQo+ID4gKwkJeGxv
ZyhEX0dFTkVSQUwsICIlczogZmFpbGVkIHRvIHJlc29sdmUgcGF0aCAlczogJW0iLA0KPiA+ICsJ
CQkJX19mdW5jX18sIGRpcik7DQo+ID4gK291dDoNCj4gPiArCXJldHVybiBwYXRobmFtZTsNCj4g
DQo+IEkgc3RpbGwgZG9uJ3QgZ2V0IHRoaXMuDQo+IA0KPiBTbyBpbiB0aGUgY2FzZSBzdHJzdHIg
ZG9lc24ndCBmaW5kIGFueXRoaW5nLCBpdCByZXR1cm5zIHRoZSBwYXRoDQo+IHVuY2hhbmdlZC4N
Cj4gDQo+IFRoYXQgbWVhbnMgdGhhdCBpZiB0aGUgbmV4dF9tbnQoKSBjYWxsZXIgYXNrcyB3aGV0
aGVyIHRoZXJlIGFyZSBhbnkNCj4gbW91bnRzIHVuZGVybmVhdGggL3Jvb3RkaXIvYS9iLCBhbmQg
bmV4dGRpciBmaW5kcyBhIG1vdW50cG9pbnQgYXQNCj4gL2EvYi9jLCBpdCBjYW4gcmV0dXJuIHRo
YXQsIHJpZ2h0Pw0KPiANCg0KQWNrLiBTZW5kaW5nIG91dCBhIHYyIG9mIHRoZXNlIHBhdGNoZXMu
DQoNClRoYW5rcyBCcnVjZSENCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
