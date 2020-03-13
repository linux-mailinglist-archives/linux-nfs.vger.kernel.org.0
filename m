Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56ABC184D4B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 18:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCMRKt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 13:10:49 -0400
Received: from mail-eopbgr680096.outbound.protection.outlook.com ([40.107.68.96]:35080
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbgCMRKt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Mar 2020 13:10:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSaeMCZ/6ycM1c8dMxeTBpiEvAZ+3Boisz1PCFClbjCFMG+iOViRhLYqXEi95TRpbIr5XnSFQIOJCIqOWmkMWpcAjEIzrFlIjaByFTBCnbpTXU7fMMIhoc0biGAzIVl3ImRD0r3BwS4I7QoVpR+w1dt3fPSUWTgYhFb8ZopJj9cqNBex8cBoN+DSZJynGbMZQi2CIxEtu4AErKpMWInQ9J7+mSbrTIsSBh/WoKHeBihy5iorA2i5QepCXDw3uuubL5AZ4jQ1rsxrl7VrrNCNzKX621qBOOE5tH0j5+Uf7ovJw/Dn8HHtSwTqMdVoofkcPl6YovxBYKp3uhEu0BiC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GHZbYj5HKtL7IURsc8vYrPEK1mjuV5MuyqQY+2f54s=;
 b=h7wvqiK4YllTGK/NKxtWGqoLWF8QSpT5IIG39SZ17P6VmVtFwk8bOE1C66eRt0rIaK0tMEPb4EQvYbrWT0HXypzp7FBsgvsPn+AD3KY/Y00DvY/FbZQrkOcfkZxbJQdlVAbHl7ph0IzY8Pg7fpjTbSaxyXHpYgXN1ggbiQKXI+Ry9WSUlpkL5Ug820Tv9kl9J/rSib4qQG3HooOMQDK8p++r8JiY7IP9SFlgSrfd8fqTiA7XcAmOWCceXc2Zi7SuMoJ9BuwzoMPlJjpCbPnplke/zILTNZxoPjWsEQYptGyq3mLVTeSGamnBtzjiZnswBRxEa3nCxxCSRPAJGY0sNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GHZbYj5HKtL7IURsc8vYrPEK1mjuV5MuyqQY+2f54s=;
 b=XaDp9Ub0/BnoN7dj8xjePeAKwx5XruebnQVeBHgcZWbKBuxXmh9m7zpRuMfYF44lSYl10WGM1Cf8KLF1b37ll8JeizhKzn3aK+zDP/eZ14oB5K8tQt6wjQNn4fMtlElkKbGhsyiSgiLdDrbJhxzhbbyN7Yk8S1XxTwGxk6/Kk+c=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (2603:10b6:4:34::34)
 by DM5PR1301MB2012.namprd13.prod.outlook.com (2603:10b6:4:31::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Fri, 13 Mar
 2020 17:10:45 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 17:10:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>
CC:     "fllinden@amazon.com" <fllinden@amazon.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
Thread-Topic: [PATCH 03/13] NFSv4.2: query the server for extended attribute
 support
Thread-Index: AQHV998vv0PI2kCOxkaGqYUZpy0TZqhFIw8AgABNQICAAAbIgIAA6XKAgAAseIDnRh56DZi6GW6A
Date:   Fri, 13 Mar 2020 17:10:45 +0000
Message-ID: <5c2dab63e720e366ab13a9b27677eb9324a924d0.camel@hammerspace.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
         <20200311195613.26108-4-fllinden@amazon.com>
         <530167624.4533477.1584029710746.JavaMail.zimbra@desy.de>
         <20200312205139.GA32293@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <20200312211555.GA5974@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
         <948465413.4651196.1584097887947.JavaMail.zimbra@desy.de>
         <6792d6a6012a241b8bd1555eea8c592ff318a444.camel@hammerspace.com>
         <345401476.4712575.1584109192253.JavaMail.zimbra@desy.de>
In-Reply-To: <345401476.4712575.1584109192253.JavaMail.zimbra@desy.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccf3fd45-c033-4bde-e2de-08d7c77177e2
x-ms-traffictypediagnostic: DM5PR1301MB2012:
x-microsoft-antispam-prvs: <DM5PR1301MB20125C7048F8E435F79A1717B8FA0@DM5PR1301MB2012.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(136003)(376002)(366004)(396003)(199004)(64756008)(81156014)(66946007)(8936002)(66476007)(6916009)(6506007)(81166006)(86362001)(54906003)(2906002)(36756003)(8676002)(316002)(71200400001)(478600001)(5660300002)(76116006)(91956017)(66556008)(6512007)(2616005)(4326008)(186003)(66446008)(26005)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2012;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeL7LSXieE/bxGhEXp/Sm8oB4oWRKqId47/hAqWzfxNAwfla13lz95LXKsaJXspro9b5JpmyKg9/WQTTbs31n0nOvJKnHVdY21y9VzIw6kCQFptO/cgD8QH0bx9uWs4tPRO5r5P5i4X+cX3ynpvzslb/RmHHt2aZqH+Rino+xGvHTxnBQqFJW9hvh6cGBisHpE/zVgVzbgWXYTScH11oFkMCR1PucdYZQBt8YrwecGKtV9EANoKHOQCpu2hK9ywN80RkSgYwclpYYFvNAjOlnnmwIWH3s5vXoglro01mrVsPhqmCTYUSl/m2QUI1Nk8qEwsPT7DN1JVgEZXt51LrZnwpvw8hZqAAQTBG32D6ZLfo26vUQxNvRGlmOzSpuD2MO1tgviHjAG5xej0yK1SUY3cHIv9ZZFgki8VNLMKoRqM7Aaz8Z1TdcGirtSHmcvHr
x-ms-exchange-antispam-messagedata: avdNELpDl1gTv6vSAuITkq6GGX/HsO0kePUqDuzyNsorbZuScLbVUweW3PNAz7fuxOhe0GWYCqmjzcCRvXHqiJR4ycQ/F5U3C5bSWKsRUbqvWR2tQsBuQMwIuFL1OfzCvBSdy21tSnd1jIjFW1LAeA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <97BF96EB1CB36343B6B638C02A892C46@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf3fd45-c033-4bde-e2de-08d7c77177e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 17:10:45.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sQijsdzSsJPNPfwVO792AFb7m8W5sZxAHUC46B8/jSPUWBFCMx95VjsfdPZBFMOU3bk1R8qAxM09VgDWbCryQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2012
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTEzIGF0IDE1OjE5ICswMTAwLCBNa3J0Y2h5YW4sIFRpZ3JhbiB3cm90
ZToNCj4gDQo+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0NCj4gPiBGcm9tOiAidHJvbmRt
eSIgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPg0KPiA+IFRvOiAiRnJhbmsgdmFuIGRlciBMaW5k
ZW4iIDxmbGxpbmRlbkBhbWF6b24uY29tPiwgIlRpZ3Jhbg0KPiA+IE1rcnRjaHlhbiIgPHRpZ3Jh
bi5ta3J0Y2h5YW5AZGVzeS5kZT4NCj4gPiBDYzogImxpbnV4LW5mcyIgPGxpbnV4LW5mc0B2Z2Vy
Lmtlcm5lbC5vcmc+LCAiQW5uYSBTY2h1bWFrZXIiIDwNCj4gPiBhbm5hLnNjaHVtYWtlckBuZXRh
cHAuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTMsIDIwMjAgMjo1MDozOCBQTQ0KPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDMvMTNdIE5GU3Y0LjI6IHF1ZXJ5IHRoZSBzZXJ2ZXIgZm9y
IGV4dGVuZGVkDQo+ID4gYXR0cmlidXRlIHN1cHBvcnQNCj4gPiBPbiBGcmksIDIwMjAtMDMtMTMg
YXQgMTI6MTEgKzAxMDAsIE1rcnRjaHlhbiwgVGlncmFuIHdyb3RlOg0KPiA+ID4gSGkgRnJhbmss
DQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgdGhlIHdheSBob3cgeW91IGhhdmUgaW1wbGVtZW50ZWQg
aXMgYWxtb3N0IGNvcnJlY3QuIFlvdQ0KPiA+ID4gcXVlcnkNCj4gPiA+IHNlcnZlciBmb3Igc3Vw
cG9ydGVkIGF0dHJpYnV0ZXMuIEFzIHJlc3VsdCBjbGllbnQgd2lsbCBnZXQgYWxsDQo+ID4gPiBh
dHRyaWJ1dGVzDQo+ID4gPiBzdXBwb3J0ZWQgYnUgdGhlIHNlcnZlciBhbmQgaWYgRkFUVFI0X1hB
VFRSX1NVUFBPUlQgaXMgcmV0dXJuZWQsDQo+ID4gPiB0aGVuDQo+ID4gPiBjbGllbnQNCj4gPiA+
IGFkZHMgeGF0dHIgY2FwYWJpbGl0eS4gVGhpcyB0aGUgd2F5IGhvdyBJIHJlYWQgcmZjODI3Ni4g
RG8geW91DQo+ID4gPiBoYXZlIGENCj4gPiA+IGRpZmZlcmVudA0KPiA+ID4gb3Bpbmlvbj8NCj4g
PiA+IA0KPiA+IA0KPiA+ICd4YXR0cl9zdXBwb3J0JyBzZWVtcyBsaWtlIGEgcHJvdG9jb2wgaGFj
ayB0byBhbGxvdyB0aGUgY2xpZW50IHRvDQo+ID4gZGV0ZXJtaW5lIHdoZXRoZXIgb3Igbm90IHRo
ZSB4YXR0ciBvcGVyYXRpb25zIGFyZSBzdXBwb3J0ZWQuDQo+ID4gDQo+ID4gVGhlIHJlYXNvbiB3
aHkgaXQgaXMgYSBoYWNrIGlzIHRoYXQgJ3N1cHBvcnRlZF9hdHRycycgaXMgYWxzbyBhDQo+ID4g
cGVyLQ0KPiA+IGZpbGVzeXN0ZW0gYXR0cmlidXRlLCBhbmQgdGhlcmUgaXMgbm8gdmFsdWUgaW4g
YWR2ZXJ0aXNpbmcNCj4gPiAneGF0dHJfc3VwcG9ydCcgdGhlcmUgdW5sZXNzIHlvdXIgZmlsZXN5
c3RlbSBhbHNvIHN1cHBvcnRzIHhhdHRycy4NCj4gPiANCj4gPiBJT1c6IHRoZSBwcm90b2NvbCBm
b3JjZXMgeW91IHRvIGRvIDIgcm91bmQgdHJpcHMgdG8gdGhlIHNlcnZlciBpbg0KPiA+IG9yZGVy
DQo+ID4gdG8gZmlndXJlIG91dCBzb21ldGhpbmcgdGhhdCByZWFsbHkgc2hvdWxkIGJlIG9idmlv
dXMgd2l0aCAxIHJvdW5kDQo+ID4gdHJpcC4NCj4gPiANCj4gDQo+IFNvIHlvdSBzYXkgIHRoYXQg
Y2xpZW50IGhhdmUgdG8gcXVlcnkgZm9yIHhhdHRyX3N1cHBvcnQgZXZlcnkgdGltZQ0KPiB0aGUN
Cj4gZnNpZCBpcyBjaGFuZ2luZz8NCj4gDQoNCkFjY29yZGluZyB0byB0aGUgc3BlYyBpdCBpcyBh
IHBlci1maWxlc3lzdGVtIGF0dHJpYnV0ZSwganVzdCBsaWtlDQpzdXBwb3J0ZWRfYXR0cnMuLi4N
Cg0KQ2hlZXJzDQogIFRyb25kDQoNCj4gVGlncmFuLg0KPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4g
PiAgICBUaWdyYW4uDQo+ID4gPiANCj4gPiA+IC0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0N
Cj4gPiA+ID4gRnJvbTogIkZyYW5rIHZhbiBkZXIgTGluZGVuIiA8ZmxsaW5kZW5AYW1hem9uLmNv
bT4NCj4gPiA+ID4gVG86ICJUaWdyYW4gTWtydGNoeWFuIiA8dGlncmFuLm1rcnRjaHlhbkBkZXN5
LmRlPg0KPiA+ID4gPiBDYzogIlRyb25kIE15a2xlYnVzdCIgPHRyb25kLm15a2xlYnVzdEBoYW1t
ZXJzcGFjZS5jb20+LCAiQW5uYQ0KPiA+ID4gPiBTY2h1bWFrZXIiIDxhbm5hLnNjaHVtYWtlckBu
ZXRhcHAuY29tPiwgImxpbnV4LW5mcyINCj4gPiA+ID4gPGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5v
cmc+DQo+ID4gPiA+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMiwgMjAyMCAxMDoxNTo1NSBQTQ0K
PiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDAzLzEzXSBORlN2NC4yOiBxdWVyeSB0aGUgc2Vy
dmVyIGZvcg0KPiA+ID4gPiBleHRlbmRlZA0KPiA+ID4gPiBhdHRyaWJ1dGUgc3VwcG9ydA0KPiA+
ID4gPiBPbiBUaHUsIE1hciAxMiwgMjAyMCBhdCAwODo1MTozOVBNICswMDAwLCBGcmFuayB2YW4g
ZGVyIExpbmRlbg0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiAxKSBUaGUgeGF0dHJfc3VwcG9y
dCBhdHRyaWJ1dGUgZXhpc3RzDQo+ID4gPiA+ID4gMikgVGhlIHhhdHRyIHN1cHBvcnQgYXR0cmli
dXRlIGV4aXN0cyAqYW5kKiBpdCdzIHRydWUgZm9yIHRoZQ0KPiA+ID4gPiA+IHJvb3QgZmgNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBDdXJyZW50bHkgdGhlIGNvZGUgZG9lcyAyKSBpbiBvbmUgb3Bl
cmF0aW9uLiBUaGF0IG1pZ2h0IG5vdA0KPiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gMTAwJQ0KPiA+
ID4gPiA+IGNvcnJlY3QgLSB0aGUgUkZDIGRvZXMgbWVudGlvbiB0aGF0IChzZWN0aW9uIDguMik6
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gIkJlZm9yZSBpbnRlcnJvZ2F0aW5nIHRoaXMgYXR0cmli
dXRlIHVzaW5nIEdFVEFUVFIsIGEgY2xpZW50DQo+ID4gPiA+ID4gc2hvdWxkDQo+ID4gPiA+ID4g
IGRldGVybWluZSB3aGV0aGVyIGl0IGlzIGEgc3VwcG9ydGVkIGF0dHJpYnV0ZSBieQ0KPiA+ID4g
PiA+IGludGVycm9nYXRpbmcNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiAgc3VwcG9ydGVkX2F0
dHJzIGF0dHJpYnV0ZS4iDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhhdCdzIGEgInNob3VsZCIs
IG5vdCBhICJNVVNUIiwgYnV0IGl0J3Mgc3RpbGwgd2F2aW5nIGl0cw0KPiA+ID4gPiA+IGZpbmdl
cg0KPiA+ID4gPiA+IGF0IHlvdSBub3QgdG8gZG8gdGhpcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBTaW5jZSA4LjIuMSBzYXlzOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICJIb3dldmVyLCBhIGNs
aWVudCBtYXkgcmVhc29uYWJseSBhc3N1bWUgdGhhdCBhIHNlcnZlcg0KPiA+ID4gPiA+ICAob3Ig
ZmlsZSBzeXN0ZW0pIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCB0aGUgeGF0dHJfc3VwcG9ydA0KPiA+
ID4gPiA+IGF0dHJpYnV0ZQ0KPiA+ID4gPiA+ICBkb2VzIG5vdCBwcm92aWRlIHhhdHRyIHN1cHBv
cnQsIGFuZCBpdCBhY3RzIG9uIHRoYXQgYmFzaXMuIg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IC4u
SSB0aGluayB5b3UncmUgcmlnaHQsIGFuZCB0aGUgY29kZSBzaG91bGQganVzdCB1c2UgdGhlDQo+
ID4gPiA+ID4gZXhpc3RlbmNlDQo+ID4gPiA+ID4gb2YgdGhlIGF0dHJpYnV0ZSBhcyBhIHNpZ25h
bCB0aGF0IHRoZSBzZXJ2ZXIga25vd3MgYWJvdXQNCj4gPiA+ID4gPiB4YXR0cnMgLQ0KPiA+ID4g
PiA+IG9wZXJhdGlvbnMgc2hvdWxkIHN0aWxsIGVycm9yIG91dCBjb3JyZWN0bHkgaWYgaXQgZG9l
c24ndC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJJ2xsIG1ha2UgdGhhdCBjaGFuZ2UsIHRoYW5r
cy4NCj4gPiA+ID4gDQo+ID4gPiA+IC4ub3IsIGFsdGVybmF0aXZlbHksIG9ubHkgcXVlcnkgeGF0
dHJfc3VwcG9ydCBpbg0KPiA+ID4gPiBuZnM0X3NlcnZlcl9jYXBhYmlsaXRpZXMsDQo+ID4gPiA+
IGFuZCB0aGVuIGl0cyBhY3R1YWwgdmFsdWUsIGlmIGl0IGV4aXN0cywgaW4gbmZzNF9mc19pbmZv
Lg0KPiA+ID4gPiANCj4gPiA+ID4gQW55IG9waW5pb25zIG9uIHRoaXM/DQo+ID4gPiA+IA0KPiA+
ID4gPiAtIEZyYW5rDQo+ID4gLS0NCj4gPiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiBMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQo+ID4gdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
