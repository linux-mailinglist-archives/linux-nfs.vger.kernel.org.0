Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8C8115728
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfLFS2U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 13:28:20 -0500
Received: from mail-dm6nam10on2118.outbound.protection.outlook.com ([40.107.93.118]:38625
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbfLFS2U (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Dec 2019 13:28:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri4ersjeel3twrapXtcFgR5dnTsk83P6mlirnZDopfLIt0lHZV0CiZkNC0H444AhX/g94+mC3xJwkoWOOFocLuexIjMxt/2Ldw6FyLLoYkiZyP79c3vaEmp88+oco5oGeplMTFPPN3zx6AFsQt8uqaqpZK5cEPR0qgdsnu6sxkx5ItazX432lvnXlOQMJRYP8umCYkMeS1uv7JmXH3ThGvwgpOmed5bgI3VKl1J2pCWlz+5hOxetxEw9pYZUo4gkwgoK5B0g5/3MaiFb4a/qTv+fYG+9xaH0W5SjCDnrPx8d/t97Ltnah4zJuvUH3oXF2mLauwzqUk38Ku91QJP+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPJ8D+7uhe5ud9ajmAgm7FScvYQe6ajkGRhr1Pa2a38=;
 b=R2OOVdINCeFmE36na0EWguNdSIpQXI9BQTTNMl8fxNRnm//H7+V1nuNMn3RqbBokrv6+CgWMrYzdWuzWNkKK+h6A54UUAEO+0DuAVfHlP9yAYV4DD8sLiKLfd5GPCsXZDDh2crIMT2OnhTg/UdcWd49bIALImP2lN/GpeNj6F/WW9cQE32JFo2HLONnxEPmJdRSHn/vHDSvZk5KW0jn2BZvHQXDtlge+Gk+UFwG7I59ksjmDdUop3Rjj2yg+el/2UvQgokW2iInv8PJnw+iehGBfSzFnxQy5M8yObGrNuSE/ZvHz5FnI5Qq+PxqScdgYyaUNg7205aFLrgwgZt2M9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPJ8D+7uhe5ud9ajmAgm7FScvYQe6ajkGRhr1Pa2a38=;
 b=dxLgrCJoc+kweqRVOfEEXjcMWLk2EA4CpQnPdvH7aom3WvhksP1I7OwuCpFBuM4wa61l88OBFINPf94h4XLFCHjtKPL3o6HtZdOHcH5qyzI1SLY2sR1cmA4wIqB8uoKdlJeTtzWl6q099J7fd6bvijiHn/79fCgOvdC7VXgFrv4=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2170.namprd13.prod.outlook.com (10.174.184.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.8; Fri, 6 Dec 2019 18:28:14 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2516.017; Fri, 6 Dec 2019
 18:28:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "madhuparnabhowmik04@gmail.com" <madhuparnabhowmik04@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
Subject: Re: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Thread-Topic: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Thread-Index: AQHVrEg0Ten5696hykeZOOX4T18u0aetRJkAgAAemACAAAj4AIAAARsA
Date:   Fri, 6 Dec 2019 18:28:14 +0000
Message-ID: <127792d6811173921733542052f061a18991f441.camel@hammerspace.com>
References: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
         <20191206160238.GE2889@paulmck-ThinkPad-P72>
         <2ec21ec537144bb3c0d5fbdaf88ea022d07b7ff8.camel@hammerspace.com>
         <20191206182414.GH2889@paulmck-ThinkPad-P72>
In-Reply-To: <20191206182414.GH2889@paulmck-ThinkPad-P72>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [88.95.63.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52516442-5a4a-4057-5f6e-08d77a7a0ed1
x-ms-traffictypediagnostic: DM5PR1301MB2170:
x-microsoft-antispam-prvs: <DM5PR1301MB2170803BEEE3BF2C7E35BC71B85F0@DM5PR1301MB2170.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39840400004)(366004)(199004)(189003)(54906003)(6512007)(118296001)(8676002)(86362001)(99286004)(66556008)(66476007)(81156014)(1730700003)(76116006)(2616005)(66446008)(64756008)(508600001)(305945005)(5640700003)(91956017)(229853002)(81166006)(316002)(66946007)(26005)(71190400001)(71200400001)(5660300002)(2906002)(102836004)(8936002)(186003)(36756003)(4326008)(76176011)(6916009)(6486002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2170;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q6a6IQNNwYzqMP+wUi0SLsRyFX8XASWLF3IOLmSyZXnAbsdnh7MXQaIdqjH5izSVzVVHWbh1gi1HQL8Ln25CoUlkvuRJElkMJRDJSdcd6Un29bSfrfB/DJ9xv0dfN5Vz8GBJPM8VMy9uv1b4EbQkWnArbdLJBfj+VCB6CKcegVXpSnBrV4EEsL4wflUY0+V0Ek4nIYcVN6oYtnsFhtflUEPrHCyRag+5aLbN4CZtSj2KVwaHMRh1RzhiDIYOlDrdMgdR7fJboZeS4jKpL2WMTxssQPGf/mWcDTOSmInpToTIc1Xgf1wc+FJVTnq0usq3dpu4PfJ6g/wDyW5HlGrgf9rU9GFMJ07T8F9sEUeq/FHHGlCbFB05OIjZYrPkCO0hS+rtEickQ7lqyalCXi3RzbtZ4bEbDY9nHc+IDOWSlfxlJOWQaN3lD8KKU1HrREYS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3C06C068ACA064C8DBA722A46859A79@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52516442-5a4a-4057-5f6e-08d77a7a0ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 18:28:14.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ym2MgMWNkVgJ2ekk2mYuIqus2tOKYIh1GVfmhmEsieg3n3fljYRvx1TnnrryayNLvhi7D3JymRiyCUUxlrdhrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2170
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDE5LTEyLTA2IGF0IDEwOjI0IC0wODAwLCBQYXVsIEUuIE1jS2VubmV5IHdyb3Rl
Og0KPiBPbiBGcmksIERlYyAwNiwgMjAxOSBhdCAwNTo1MjoxMFBNICswMDAwLCBUcm9uZCBNeWts
ZWJ1c3Qgd3JvdGU6DQo+ID4gSGkgUGF1bCwNCj4gPiANCj4gPiBPbiBGcmksIDIwMTktMTItMDYg
YXQgMDg6MDIgLTA4MDAsIFBhdWwgRS4gTWNLZW5uZXkgd3JvdGU6DQo+ID4gPiBPbiBGcmksIERl
YyAwNiwgMjAxOSBhdCAwODo0Njo0MFBNICswNTMwLCANCj4gPiA+IG1hZGh1cGFybmFiaG93bWlr
MDRAZ21haWwuY29tIHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBNYWRodXBhcm5hIEJob3dtaWsgPG1h
ZGh1cGFybmFiaG93bWlrMDRAZ21haWwuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBwYXRj
aCBmaXhlcyB0aGUgZm9sbG93aW5nIGVycm9yczoNCj4gPiA+ID4gZnMvbmZzL2Rpci5jOjIzNTM6
MTQ6IGVycm9yOiBpbmNvbXBhdGlibGUgdHlwZXMgaW4gY29tcGFyaXNvbg0KPiA+ID4gPiBleHBy
ZXNzaW9uIChkaWZmZXJlbnQgYWRkcmVzcyBzcGFjZXMpOg0KPiA+ID4gPiBmcy9uZnMvZGlyLmM6
MjM1MzoxNDogICAgc3RydWN0IGxpc3RfaGVhZCBbbm9kZXJlZl0gPGFzbjo0PiAqDQo+ID4gPiA+
IGZzL25mcy9kaXIuYzoyMzUzOjE0OiAgICBzdHJ1Y3QgbGlzdF9oZWFkICoNCj4gPiA+ID4gDQo+
ID4gPiA+IGNhdXNlZCBkdWUgdG8gZGlyZWN0bHkgYWNjZXNzaW5nIHRoZSBwcmV2IHBvaW50ZXIg
b2YNCj4gPiA+ID4gYSBSQ1UgcHJvdGVjdGVkIGxpc3QuDQo+ID4gPiA+IEFjY2Vzc2luZyB0aGUg
cG9pbnRlciB1c2luZyB0aGUgbWFjcm8gbGlzdF9wcmV2X3JjdSgpIGZpeGVzDQo+ID4gPiA+IHRo
aXMNCj4gPiA+ID4gZXJyb3IuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYWRo
dXBhcm5hIEJob3dtaWsgPA0KPiA+ID4gPiBtYWRodXBhcm5hYmhvd21pazA0QGdtYWlsLmNvbT4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBmcy9uZnMvZGlyLmMgfCAyICstDQo+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gDQo+ID4g
PiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvZGlyLmMgYi9mcy9uZnMvZGlyLmMNCj4gPiA+ID4gaW5k
ZXggZTE4MDAzM2UzNWNmLi4yMDM1MjU0Y2MyODMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2ZzL25m
cy9kaXIuYw0KPiA+ID4gPiArKysgYi9mcy9uZnMvZGlyLmMNCj4gPiA+ID4gQEAgLTIzNTAsNyAr
MjM1MCw3IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gbmZzX2FjY2Vzc19nZXRfY2FjaGVkX3JjdShz
dHJ1Y3QNCj4gPiA+ID4gaW5vZGUgKmlub2RlLCBjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlDQo+ID4g
PiA+ICAJcmN1X3JlYWRfbG9jaygpOw0KPiA+ID4gPiAgCWlmIChuZnNpLT5jYWNoZV92YWxpZGl0
eSAmIE5GU19JTk9fSU5WQUxJRF9BQ0NFU1MpDQo+ID4gPiA+ICAJCWdvdG8gb3V0Ow0KPiA+ID4g
PiAtCWxoID0gcmN1X2RlcmVmZXJlbmNlKG5mc2ktDQo+ID4gPiA+ID5hY2Nlc3NfY2FjaGVfZW50
cnlfbHJ1LnByZXYpOw0KPiA+ID4gPiArCWxoID0gcmN1X2RlcmVmZXJlbmNlKGxpc3RfcHJldl9y
Y3UoJm5mc2ktDQo+ID4gPiA+ID4gYWNjZXNzX2NhY2hlX2VudHJ5X2xydSkpOw0KPiA+ID4gDQo+
ID4gPiBBbmQgYXMgbm90ZWQgaW4gdGhlIGVhcmxpZXIgZW1haWwsIHdoYXQgaXMgcHJldmVudGlu
ZyBjb25jdXJyZW50DQo+ID4gPiBpbnNlcnRpb25zIGludG8gIGFuZCBkZWxldGlvbnMgZnJvbSB0
aGlzIGxpc3Q/DQo+ID4gPiANCj4gPiA+IG8JVGhpcyB1c2Ugb2YgbGlzdF9tb3ZlX3RhaWwoKSBp
cyBPSyBiZWNhdXNlIGl0IGRvZXMgbm90IHBvaXNvbi4NCj4gPiA+IAlUaG91Z2ggaXQgaXNuJ3Qg
YmVpbmcgYWxsIHRoYXQgZnJpZW5kbHkgdG8gbG9ja2xlc3MgYWNjZXNzIHRvDQo+ID4gPiAJLT5w
cmV2IC0tIG5vIFdSSVRFX09OQ0UoKSBpbiBsaXN0X21vdmVfdGFpbCgpLg0KPiA+ID4gDQo+ID4g
PiBvCVRoZSB1c2Ugb2YgbGlzdF9hZGRfdGFpbCgpIGlzIG5vdCBzYWZlIHdpdGggUkNVIHJlYWRl
cnMsIHRob3VnaA0KPiA+ID4gCXRoZXkgZG8gYXQgbGVhc3QgcGFydGlhbGx5IGNvbXBlbnNhdGUg
dmlhIHVzZSBvZiBzbXBfd21iKCkNCj4gPiA+IAlpbiBuZnNfYWNjZXNzX2FkZF9jYWNoZSgpIGJl
Zm9yZSBjYWxsaW5nDQo+ID4gPiBuZnNfYWNjZXNzX2FkZF9yYnRyZWUoKS4NCj4gPiA+IA0KPiA+
ID4gbwlUaGUgbGlzdF9kZWwoKSBuZWFyIHRoZSBlbmQgb2YgbmZzX2FjY2Vzc19hZGRfcmJ0cmVl
KCkgd2lsbA0KPiA+ID4gCXBvaXNvbiB0aGUgLT5wcmV2IHBvaW50ZXIuICBJIGRvbid0IHNlZSBo
b3cgdGhpcyBpcyBzYWZlIGdpdmVuDQo+ID4gPiB0aGUNCj4gPiA+IAlwb3NzaWJpbGl0eSBvZiBh
IGNvbmN1cnJlbnQgY2FsbCB0bw0KPiA+ID4gbmZzX2FjY2Vzc19nZXRfY2FjaGVkX3JjdSgpLg0K
PiA+IA0KPiA+IFRoZSBwb2ludGVyIG5mc2ktPmFjY2Vzc19jYWNoZV9lbnRyeV9scnUgaXMgdGhl
IGhlYWQgb2YgdGhlIGxpc3QsDQo+ID4gc28gaXQNCj4gPiB3b24ndCBnZXQgcG9pc29uZWQuIEZ1
cnRoZXJtb3JlLCB0aGUgb2JqZWN0cyBpdCBwb2ludHMgdG8gYXJlIGZyZWVkDQo+ID4gdXNpbmcg
a2ZyZWVfcmN1KCksIHNvIHRoZXkgd2lsbCBzdXJ2aXZlIGFzIGxvbmcgYXMgd2UgaG9sZCB0aGUg
cmN1DQo+ID4gcmVhZA0KPiA+IGxvY2suIFRoZSBvYmplY3QncyBjcmVkIHBvaW50ZXJzIGFsc28g
cG9pbnRzIHRvIHNvbWV0aGluZyB0aGF0IGlzDQo+ID4gZnJlZWQNCj4gPiBpbiBhbiByY3Utc2Fm
ZSBtYW5uZXIuDQo+ID4gDQo+ID4gVGhlIHByb2JsZW0gaGVyZSBpcyByYXRoZXIgdGhhdCBhIHJh
Y2luZyBsaXN0X2RlbCgpIGNhbiBjYXVzZSBuZnNpLQ0KPiA+ID4gYWNjZXNzX2NhY2hlX2VudHJ5
X2xydSB0byBiZSBlbXB0eSwgd2hpY2ggaXMgcHJlc3VtYWJseSB3aHkgTmVpbA0KPiA+ID4gYWRk
ZWQNCj4gPiB0aGF0IGNoZWNrIHBsdXMgdGhlIGVtcHR5IGNyZWQgcG9pbnRlciBjaGVjayBpbiB0
aGUgZm9sbG93aW5nIGxpbmUuDQo+ID4gDQo+ID4gVGhlIGJhcnJpZXIgc2VtYW50aWNzIG1heSBi
ZSBzdXNwZWN0LCBhbHRob3VnaCB0aGUgc3BpbiB1bmxvY2sNCj4gPiBhZnRlcg0KPiA+IGxpc3Rf
ZGVsKCkgc2hvdWxkIHByZXN1bWFibHkgZ3VhcmFudGVlIHJlbGVhc2Ugc2VtYW50aWNzPw0KPiAN
Cj4gQWgsIE9LLCBzbyB5b3UgYXJlIG9ubHkgZXZlciB1c2luZyAtPnByZXYgb25seSBmcm9tIHRo
ZSBoZWFkIG9mIHRoZQ0KPiBsaXN0LA0KPiBhbmQgcHJlc3VtYWJseSBuZXZlciBkbyBsaXN0X2Rl
bCgpIG9uIHRoZSBoZWFkIGl0c2VsZi4gIChEb24ndCBsYXVnaCwNCj4gdGhpcyBkb2VzIHJlYWxs
eSBoYXBwZW4gYXMgYSB3YXkgdG8gcmVtb3ZlIHRoZSBlbnRpcmUgbGlzdCwgdGhvdWdoDQo+IHBl
cmhhcHMgd2l0aCBsaXN0X2RlbF9pbml0KCkgcmF0aGVyIHRoYW4gbGlzdF9kZWwoKS4pDQoNCkNv
cnJlY3QuDQoNCj4gTWF5YmUgd2Ugc2hvdWxkIGhhdmUgYSBsaXN0X3RhaWxfcmN1KCkgdGhhdCBp
cyBvbmx5IGV4cGVjdGVkIHRvIHdvcmsNCj4gb24gdGhlIGhlYWQgb2YgdGhlIGxpc3Q/DQo+IA0K
DQpUaGF0IG1pZ2h0IGJlIHRoZSBiZXN0IHdheSB0byByZXNvbHZlIHRoaXMsIHllcy4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
