Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA03D473
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 19:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405582AbfFKRor (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 13:44:47 -0400
Received: from mail-eopbgr750115.outbound.protection.outlook.com ([40.107.75.115]:36703
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404857AbfFKRoq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 13:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV+JlLV6Jflm+mRDAa+AM8+YYJG87sKFmhSKbqpN3O4=;
 b=FLe431dtpMerk0yEzO546zQ0jjI3Aw5vDkUxm4L4QX2CZ5J09rz7Ty2eNluYAruAQEcV7FDJgZhM1X58pG0wVhRUaDzGWyCCHRwUDroLSzrikjUBH5d18gzUeU9St/S9drx6/6PYYRkTTAbZzVQHI9N3ikdagnDPcYLubGjU/Do=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1674.namprd13.prod.outlook.com (10.171.155.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.5; Tue, 11 Jun 2019 17:44:41 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1987.010; Tue, 11 Jun 2019
 17:44:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.com" <neilb@suse.com>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Topic: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Index: AQHVFoClDLUWSno6kkqu5+tdKdASRKaD9P4AgABTyoCAAPi5AIAQdgMAgADl1oCAAAgVgIAABEUAgAASQICAAA47gIAAA36A
Date:   Tue, 11 Jun 2019 17:44:41 +0000
Message-ID: <6a4ace315ee7f9c72e4866384fcb800707a4cbe4.camel@hammerspace.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
         <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
         <87muj3tuuk.fsf@notabene.neil.brown.name>
         <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
         <87lfy9vsgf.fsf@notabene.neil.brown.name>
         <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
         <6693beb0989c83580235526e3d1b54fad0920d82.camel@hammerspace.com>
         <35A94418-7DE0-4656-90B4-5A0183BA371C@oracle.com>
         <266475174966dd473670d9fc9f6a6d6af3d87d44.camel@hammerspace.com>
         <217DDDDE-AA6D-47C8-AFC8-99548F29E1C2@oracle.com>
In-Reply-To: <217DDDDE-AA6D-47C8-AFC8-99548F29E1C2@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c4c884-041a-4d16-bc95-08d6ee947bcb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1674;
x-ms-traffictypediagnostic: DM5PR13MB1674:
x-microsoft-antispam-prvs: <DM5PR13MB16741937699695F0C4B002A6B8ED0@DM5PR13MB1674.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(396003)(366004)(376002)(136003)(189003)(199004)(6116002)(6246003)(2501003)(305945005)(3846002)(68736007)(6512007)(8936002)(7736002)(5660300002)(36756003)(4326008)(81156014)(53936002)(86362001)(478600001)(81166006)(25786009)(6916009)(316002)(66066001)(8676002)(229853002)(6506007)(6486002)(14444005)(476003)(66476007)(446003)(6436002)(76176011)(53546011)(256004)(66946007)(71190400001)(118296001)(2616005)(73956011)(5640700003)(71200400001)(64756008)(2906002)(54906003)(102836004)(66556008)(66446008)(486006)(11346002)(14454004)(26005)(186003)(76116006)(99286004)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1674;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: feCQgbFaTzJjNuK8c42aHz6isQrKdCYJeNml4P+VJWuSg1iD4IVnkeB0VplSuxnCq2XI+KwCNBxJfAA1i231wr98VJ2kOWBwTt6CwpNWaPLWLq6o47yiU+IhLJdofQ9yHR+OvUHZuz82xY4M4udLsB/+u6pGdKTU6NPu2N95QbdMg/pNytzzMhk+TjB6RYvhKXZDX3ZwtRVOZKeWGCEE4xiNyINQ2u4KyU/DMq6EEoTnSMXp3ndbkD5uZyn5IgrXiFHfyPnzcXnr4uzwRRFiaQo4Y0ijiFRwE1FAdGLSS2I22rLiv2X6Tqcp5nGjjCTYmWXOW264pTaVRx1issBojZRS9XQ6IskUrY8KVShOPEmNGzn7wmW6QZl7OwDu1GnM1D5BkfD/5kMX9KqMZRFaZu0NTXdGrfX0V3touH0BPNU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC3B7D39D84DB44A82F074B3FCAC36E3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c4c884-041a-4d16-bc95-08d6ee947bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 17:44:41.8343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1674
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTExIGF0IDEzOjMyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBKdW4gMTEsIDIwMTksIGF0IDEyOjQxIFBNLCBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+IHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIwMTktMDYt
MTEgYXQgMTE6MzUgLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4gPiBPbiBKdW4gMTEs
IDIwMTksIGF0IDExOjIwIEFNLCBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+ID4gPiB0cm9uZG15QGhh
bW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBUdWUsIDIwMTktMDYt
MTEgYXQgMTA6NTEgLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4g
PiBJZiBtYXhjb25uIGlzIGEgaGludCwgd2hlbiBkb2VzIHRoZSBjbGllbnQgb3BlbiBhZGRpdGlv
bmFsDQo+ID4gPiA+ID4gY29ubmVjdGlvbnM/DQo+ID4gPiA+IA0KPiA+ID4gPiBBcyBJJ3ZlIGFs
cmVhZHkgc3RhdGVkLCB0aGF0IGZ1bmN0aW9uYWxpdHkgaXMgbm90IHlldA0KPiA+ID4gPiBhdmFp
bGFibGUuDQo+ID4gPiA+IFdoZW4NCj4gPiA+ID4gaXQgaXMsIGl0IHdpbGwgYmUgdW5kZXIgdGhl
IGNvbnRyb2wgb2YgYSB1c2Vyc3BhY2UgZGFlbW9uIHRoYXQNCj4gPiA+ID4gY2FuDQo+ID4gPiA+
IGRlY2lkZSBvbiBhIHBvbGljeSBpbiBhY2NvcmRhbmNlIHdpdGggYSBzZXQgb2YgdXNlciBzcGVj
aWZpZWQNCj4gPiA+ID4gcmVxdWlyZW1lbnRzLg0KPiA+ID4gDQo+ID4gPiBUaGVuIHdoeSBkbyB3
ZSBuZWVkIGEgbW91bnQgb3B0aW9uIGF0IGFsbD8NCj4gPiA+IA0KPiA+IA0KPiA+IEZvciBvbmUg
dGhpbmcsIGl0IGFsbG93cyBwZW9wbGUgdG8gcGxheSB3aXRoIHRoaXMgdW50aWwgd2UgaGF2ZSBh
DQo+ID4gZnVsbHkNCj4gPiBhdXRvbWF0ZWQgc29sdXRpb24uIFRoZSBmYWN0IHRoYXQgcGVvcGxl
IGFyZSBhY3R1YWxseSBwdWxsaW5nIGRvd24NCj4gPiB0aGVzZSBwYXRjaGVzLCBmb3J3YXJkIHBv
cnRpbmcgdGhlbSBhbmQgdHJ5aW5nIHRoZW0gb3V0IHdvdWxkDQo+ID4gaW5kaWNhdGUNCj4gPiB0
aGF0IHRoZXJlIGlzIGludGVyZXN0IGluIGRvaW5nIHNvLg0KPiANCj4gQWdyZWVkIHRoYXQgaXQg
ZGVtb25zdHJhdGVzIHRoYXQgZm9sa3MgYXJlIGludGVyZXN0ZWQgaW4gaGF2aW5nDQo+IG11bHRp
cGxlIGNvbm5lY3Rpb25zLiBJIGNvdW50IG15c2VsZiBhbW9uZyB0aGVtLg0KPiANCj4gDQo+ID4g
U2Vjb25kbHksIGlmIHlvdXIgcG9saWN5IGlzICdJIGp1c3Qgd2FudCBuIGNvbm5lY3Rpb25zJyBi
ZWNhdXNlDQo+ID4gdGhhdA0KPiA+IGZpdHMgeW91ciB3b3JrbG9hZCByZXF1aXJlbWVudHMgKGUu
Zy4gYmVjYXVzZSBzYWlkIHdvcmtsb2FkIGlzIGJvdGgNCj4gPiBsYXRlbmN5IHNlbnNpdGl2ZSBh
bmQgYnVyc3R5KSwgdGhlbiBhIGRhZW1vbiBzb2x1dGlvbiB3b3VsZCBiZQ0KPiA+IHVubmVjZXNz
YXJ5LCBhbmQgbWF5IGJlIGVycm9yIHByb25lLg0KPiANCj4gV2h5IHdvdWxkbid0IHRoYXQgYmUg
dGhlIGRlZmF1bHQgb3V0LW9mLXRoZS1zaHJpbmt3cmFwIGNvbmZpZ3VyYXRpb24NCj4gdGhhdCBp
cyBpbnN0YWxsZWQgYnkgbmZzLXV0aWxzPw0KDQpXaGF0IGlzIHRoZSBwb2ludCBvZiBmb3JjaW5n
IHBlb3BsZSB0byBydW4gYSBkYWVtb24gaWYgYWxsIHRoZXkgd2FudCB0bw0KZG8gaXMgc2V0IHVw
IGEgZml4ZWQgbnVtYmVyIG9mIGNvbm5lY3Rpb25zPw0KDQo+IA0KPiA+IEEgbW91bnQgb3B0aW9u
IGlzIGhlbHBmdWwgaW4gdGhpcyBjYXNlLCBiZWNhdXNlIHlvdSBjYW4gcGVyZm9ybSB0aGUNCj4g
PiBzZXR1cCB0aHJvdWdoIHRoZSBub3JtYWwgZnN0YWIgb3IgYXV0b2ZzIGNvbmZpZyBmaWxlIGNv
bmZpZ3VyYXRpb24NCj4gPiByb3V0ZS4gSXQgYWxzbyBtYWtlIHNlbnNlIGlmIHlvdSBoYXZlIGEg
bmZzcm9vdCBzZXR1cC4NCj4gDQo+IE5GU1JPT1QgaXMgdGhlIG9ubHkgdXNhZ2Ugc2NlbmFyaW8g
d2hlcmUgSSBzZWUgYSBtb3VudCBvcHRpb24gYmVpbmcNCj4gYSBzdXBlcmlvciBhZG1pbmlzdHJh
dGl2ZSBpbnRlcmZhY2UuIEhvd2V2ZXIgSSBkb24ndCBmZWVsIHRoYXQNCj4gTkZTUk9PVCBpcyBn
b2luZyB0byBob3N0IHdvcmtsb2FkcyB0aGF0IHdvdWxkIG5lZWQgbXVsdGlwbGUNCj4gY29ubmVj
dGlvbnMuIEtJUw0KPiANCj4gDQo+ID4gRmluYWxseSwgZXZlbiBpZiB5b3UgZG8gd2FudCB0byBo
YXZlIGEgZGFlbW9uIG1hbmFnZSB5b3VyDQo+ID4gdHJhbnNwb3J0LA0KPiA+IGNvbmZpZ3VyYXRp
b24sIHlvdSBkbyB3YW50IGEgbWVjaGFuaXNtIHRvIGhlbHAgaXQgcmVhY2ggYW4NCj4gPiBlcXVp
bGlicml1bQ0KPiA+IHN0YXRlIHF1aWNrbHkuIENvbm5lY3Rpb25zIHRha2UgdGltZSB0byBicmlu
ZyB1cCBhbmQgdGVhciBkb3duDQo+ID4gYmVjYXVzZQ0KPiA+IHBlcmZvcm1hbmNlIG1lYXN1cmVt
ZW50cyB0YWtlIHRpbWUgdG8gYnVpbGQgdXAgc3VmZmljaWVudA0KPiA+IHN0YXRpc3RpY2FsDQo+
ID4gcHJlY2lzaW9uLiBGdXJ0aGVybW9yZSwgZG9pbmcgc28gY29tZXMgd2l0aCBhIG51bWJlciBv
ZiBoaWRkZW4NCj4gPiBjb3N0cywNCj4gPiBlLmcuOiBjaGV3aW5nIHVwIHByaXZpbGVnZWQgcG9y
dCBudW1iZXJzIGJ5IHB1dHRpbmcgdGhlbSBpbiBhDQo+ID4gVElNRV9XQUlUDQo+ID4gc3RhdGUu
IElmIHlvdSBrbm93IHRoYXQgYSBnaXZlbiBzZXJ2ZXIgaXMgYWx3YXlzIHN1YmplY3QgdG8gaGVh
dnkNCj4gPiB0cmFmZmljLCB0aGVuIGluaXRpYWxpc2luZyB0aGUgbnVtYmVyIG9mIGNvbm5lY3Rp
b25zIGFwcHJvcHJpYXRlbHkNCj4gPiBoYXMNCj4gPiB2YWx1ZS4NCj4gDQo+IEFnYWluLCBJIGRv
bid0IHNlZSBob3cgdGhpcyBpcyBub3Qgc29tZXRoaW5nIGEgY29uZmlnIGZpbGUgY2FuIGRvLg0K
DQpZb3UgY2FuLCBidXQgdGhhdCBtZWFucyB5b3UgaGF2ZSB0byBrZWVwIHNhaWQgY29uZmlnIGZp
bGUgdXAgdG8gZGF0ZQ0Kd2l0aCB0aGUgY29udGVudHMgb2YgL2V0Yy9mc3RhYiBldGMuIFB1bHZl
cmlzaW5nIGNvbmZpZ3VyYXRpb24gaW50bw0KbGl0dGxlIGJpdHMgYW5kIHBpZWNlcyB0aGF0IGFy
ZSBzY2F0dGVyZWQgYXJvdW5kIGluIGRpZmZlcmVudCBmaWxlcyBpcw0Kbm90IGEgdXNlciBmcmll
bmRseSBpbnRlcmZhY2UgZWl0aGVyLg0KDQo+IFRoZSBzdGF0ZWQgaW50ZW50IG9mICJuY29ubmVj
dCIgd2F5IGJhY2sgd2hlbiB3YXMgZm9yDQo+IGV4cGVyaW1lbnRhdGlvbi4NCj4gSXQgd29ya3Mg
Z3JlYXQgZm9yIHRoYXQhDQo+IA0KPiBJIGRvbid0IHNlZSBpdCBhcyBhIGRlc2lyYWJsZSBsb25n
LXRlcm0gYWRtaW5pc3RyYXRpdmUgaW50ZXJmYWNlLA0KPiB0aG91Z2guIEknZCByYXRoZXIgbm90
IG5haWwgaW4gYSBuZXcgbW91bnQgb3B0aW9uIHRoYXQgd2UgYWN0dWFsbHkNCj4gcGxhbiB0byBv
YnNvbGV0ZSBpbiBmYXZvciBvZiBhbiBhdXRvbWF0ZWQgbWVjaGFuaXNtLiBJJ2QgcmF0aGVyIHNl
ZQ0KPiB1cyBkZXNpZ24gdGhlIGFkbWluaXN0cmF0aXZlIGludGVyZmFjZSB3aXRoIGF1dG9tYXRp
b24gZnJvbSB0aGUNCj4gc3RhcnQuIFRoYXQgd2lsbCBoYXZlIGEgbG93ZXIgbG9uZy10ZXJtIG1h
aW50ZW5hbmNlIGNvc3QuDQo+IA0KPiBBZ2FpbiwgSSdtIG5vdCBvYmplY3RpbmcgdG8gc3VwcG9y
dCBmb3IgbXVsdGlwbGUgY29ubmVjdGlvbnMuIEl0J3MNCj4ganVzdCB0aGF0IGFkZGluZyBhIG1v
dW50IG9wdGlvbiBkb2Vzbid0IGZlZWwgbGlrZSBhIGZyaWVuZGx5IG9yDQo+IGZpbmlzaGVkIGlu
dGVyZmFjZSBmb3IgYWN0dWFsIHVzZXJzLiBBIGNvbmZpZyBmaWxlIChvciByZS11c2luZw0KPiBu
ZnMuY29uZikgc2VlbXMgdG8gbWUgbGlrZSBhIGJldHRlciBhcHByb2FjaC4NCg0KbmZzLmNvbmYg
aXMgZ3JlYXQgZm9yIGRlZmluaW5nIGdsb2JhbCBkZWZhdWx0cy4NCg0KSXQgY2FuIGRvIHNlcnZl
ciBzcGVjaWZpYyBjb25maWd1cmF0aW9uLCBidXQgaXMgbm90IGEgcG9wdWxhciBzb2x1dGlvbg0K
Zm9yIHRoYXQuIE1vc3QgcGVvcGxlIGFyZSBzdGlsbCBwdXR0aW5nIHRoYXQgaW5mb3JtYXRpb24g
aW4gL2V0Yy9mc3RhYg0Kc28gdGhhdCBpdCBhcHBlYXJzIGluIG9uZSBzcG90Lg0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
