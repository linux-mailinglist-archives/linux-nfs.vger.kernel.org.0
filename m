Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED735B3128
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2019 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfIORaN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Sep 2019 13:30:13 -0400
Received: from mail-eopbgr750135.outbound.protection.outlook.com ([40.107.75.135]:55282
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725270AbfIORaM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Sep 2019 13:30:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXFPZU1yxsP1YLvRl28KuE4o5pj/hPSFl3/OQO1mEK06rYnJu8UfQf2AZ2EGZY5GPMyoKOxWq9mytjhMTBB36ECNKFkwMxNPi3xRd8a82Zt70Xhpz9CbAhCdAw6YHmCoatKSs/nKix+nxvLaFnMq9LzzZ7GKZ1dV4fmsgWDhVfb8EoBv34NZXSVVATII/JuaosSZ8TGQrmDc+Mm9m46En5ulbAzYbQ/Prz6Bv0GPLRBmA+Bor9zX0h+z0WyffN1RoamIigNQFAwC2GGkdD14uxa41l1SKy1F6rHzAoMbVN2UWvGc2R60hDjwmtnB3bz23Obge9ZhZiEzo4ldoYqGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOtxbOWucbkJT//FlIguUVbA3lAGJPoRFHQSiJRSElU=;
 b=DRi1Mxpo5Z98it3X6zj5IiBl6PuIRv3NySKmCfE7PpVjHj2DIo6FfqwXQgpqri2R5U2+m+a2/RhBvYr0Erc09ZPZOlyxRlqTe2E2scb1iAQ4xTan6kAK1/CZ3ITlYpfbU4l1bM4rCguc4UpgNBSI/1x9S0zKKbwNRG3+y0FpXwEMIfFaVfJT00DvrReo48sMUBJh6lul57FSd2GoK9XmRVq318e4wp+t9bsY4gZPYeuTDo8q5jZ8lrvXgRS2vaGxAFUC+Kb20WidxbBmOyMA/H3WEbkSxn/XUDzNy9lrMED8PV8sOWNzTe009YG1tOyjZccJ7hOt82kadbU5Cgjk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOtxbOWucbkJT//FlIguUVbA3lAGJPoRFHQSiJRSElU=;
 b=WCco5A5qsVijmDLO3DYi+g4f0YZTI2LojtnN6iz3P1Jvd672H+/37/xfFvnGoIDVGXRgyoWSah59SlkIxzKwXGURnSPd5IBI1u19e5f+etUQpRMnlK4/EQf2i7lHla6j+ZLAE7g7scvQCkdrSrOXGPDYzrIyL14RyU3a8T1RKSw=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1642.namprd13.prod.outlook.com (10.171.154.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.10; Sun, 15 Sep 2019 17:30:08 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2284.009; Sun, 15 Sep 2019
 17:30:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "tibbs@math.uh.edu" <tibbs@math.uh.edu>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "km@cm4all.com" <km@cm4all.com>
Subject: Re: [PATCH v2 1/2] SUNRPC: Fix buffer handling of GSS MIC without
 slack
Thread-Topic: [PATCH v2 1/2] SUNRPC: Fix buffer handling of GSS MIC without
 slack
Thread-Index: AQHVa9wIr8lC8mPonUalGxHMt50vBKcs8ZKAgAANIoA=
Date:   Sun, 15 Sep 2019 17:30:07 +0000
Message-ID: <444c663d56f9f8292d233ec903b39871df14826a.camel@hammerspace.com>
References: <9f9848f4cbb03b09c7f28f8a43fb27120703ae49.1568557832.git.bcodding@redhat.com>
         <8350AC46-9CFA-410D-AC0C-EF2ACE24FD74@oracle.com>
In-Reply-To: <8350AC46-9CFA-410D-AC0C-EF2ACE24FD74@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.167.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c04b02a-9b3a-4a6c-eeff-08d73a025a81
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1642;
x-ms-traffictypediagnostic: DM5PR13MB1642:
x-microsoft-antispam-prvs: <DM5PR13MB16428C76B4545E3722626D9AB88D0@DM5PR13MB1642.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-forefront-prvs: 01613DFDC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39830400003)(376002)(346002)(189003)(199004)(2501003)(64756008)(25786009)(76176011)(66476007)(76116006)(91956017)(66946007)(6116002)(3846002)(66446008)(2906002)(36756003)(186003)(14444005)(256004)(66556008)(6512007)(99286004)(54906003)(26005)(6246003)(8676002)(53936002)(5660300002)(486006)(476003)(316002)(4326008)(11346002)(110136005)(66066001)(446003)(2616005)(53546011)(6506007)(102836004)(305945005)(6486002)(229853002)(6436002)(118296001)(14454004)(86362001)(8936002)(71200400001)(71190400001)(81166006)(81156014)(478600001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1642;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J/q5AIBvJjVcDR+ZAwmkeWx/JK+43KTUXAAu0fzJyhlzJd6Gt7YMXevYxuuU3FzDjjoz4MT1gi9dnf7t7jvrT8qM5Ti7L2YQb46yufKhXiZ6a+W3bpFZ+TOPh9i2mgLwGVzx+r3RzwpdkeBqdg3kOSI18TuVWZrIBmXJjtgiOciSXNjO9qU5ZLsXC4dKOc4+JXDIkPnWkjX/rd3W10w502XdpD6w38SJh9C8RgmTchbTHjhwTei3x7Ho5BAdjHwvMgx4LHBsbIgO8SgP1ppXAClfSdfaUthqlAKJdWFKx+C0uKVpVQLnymQWHj9EVAIy+c5JI/iN5DTfQ2fo8MAeA52kSBWLyc4gcZ8mU4Js366k3OWwuKKQ59239QeGobxjjeoKEqugd35/CvUumCcug0UT+MZViYgf8/m6vjFB2MY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F92AE279E5C71D4BBA2717EB56258A96@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c04b02a-9b3a-4a6c-eeff-08d73a025a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2019 17:30:07.8015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiK3uKR7oU1GqnASSvJ74wjsh9bAEndtGaqy2+3I/EmXw5fC7KBqD+Q1fpEcsj15/8ydj/GiO1e5Xi1jpOMt6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1642
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDE5LTA5LTE1IGF0IDEyOjQzIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SGkgQmVuLQ0KPiANCj4gDQo+ID4gT24gU2VwIDE1LCAyMDE5LCBhdCAxMTo0MSBBTSwgQmVuamFt
aW4gQ29kZGluZ3RvbiA8DQo+ID4gYmNvZGRpbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4gDQo+
ID4gVGhlIEdTUyBNZXNzYWdlIEludGVncml0eSBDaGVjayBkYXRhIGZvciBrcmI1aSBtYXkgbGll
IHBhcnRpYWxseSBpbg0KPiA+IHRoZSBYRFINCj4gPiByZXBseSBidWZmZXIncyBwYWdlcyBhbmQg
dGFpbC4gIElmIHNvLCB3ZSB0cnkgdG8gY29weSB0aGUgZW50aXJlDQo+ID4gTUlDIGludG8NCj4g
PiBmcmVlIHNwYWNlIGluIHRoZSB0YWlsLiAgQnV0IGFzIHRoZSBlc3RpbWF0aW9ucyBvZiB0aGUg
c2xhY2sgc3BhY2UNCj4gPiByZXF1aXJlZA0KPiA+IGZvciBhdXRoZW50aWNhdGlvbiBhbmQgdmVy
aWZpY2F0aW9uIGhhdmUgaW1wcm92ZWQgdGhlcmUgbWF5IGJlIGxlc3MNCj4gPiBmcmVlDQo+ID4g
c3BhY2UgaW4gdGhlIHRhaWwgdG8gY29tcGxldGUgdGhpcyBjb3B5IC0tIHNlZSBjb21taXQgMmM5
NGI4ZWNhMWEyDQo+ID4gKCJTVU5SUEM6IFVzZSBhdV9yc2xhY2sgd2hlbiBjb21wdXRpbmcgcmVw
bHkgYnVmZmVyIHNpemUiKS4gIEluDQo+ID4gZmFjdCwgdGhlcmUNCj4gPiBtYXkgb25seSBiZSBy
b29tIGluIHRoZSB0YWlsIGZvciBhIHNpbmdsZSBjb3B5IG9mIHRoZSBNSUMsIGFuZCBub3QNCj4g
PiBwYXJ0IG9mDQo+ID4gdGhlIE1JQyBhbmQgdGhlbiBhbm90aGVyIGNvbXBsZXRlIGNvcHkuDQo+
ID4gDQo+ID4gVGhlIHJlYWwgd29ybGQgZmFpbHVyZSByZXBvcnRlZCBpcyB0aGF0IGBsc2Agb2Yg
YSBkaXJlY3Rvcnkgb24gTkZTDQo+ID4gbWF5DQo+ID4gc29tZXRpbWVzIHJldHVybiAtRUlPLCB3
aGljaCBjYW4gYmUgdHJhY2VkIGJhY2sgdG8NCj4gPiB4ZHJfYnVmX3JlYWRfbmV0b2JqKCkNCj4g
PiBmYWlsaW5nIHRvIGZpbmQgYXZhaWxhYmxlIGZyZWUgc3BhY2UgaW4gdGhlIHRhaWwgdG8gY29w
eSB0aGUgTUlDLg0KPiA+IA0KPiA+IEZpeCB0aGlzIGJ5IGNoZWNraW5nIGZvciB0aGUgY2FzZSBv
ZiB0aGUgTUlDIGNyb3NzaW5nIHRoZQ0KPiA+IGJvdW5kYXJpZXMgb2YNCj4gPiBoZWFkLCBwYWdl
cywgYW5kIHRhaWwuIElmIHNvLCBzaGlmdCB0aGUgYnVmZmVyIHVudGlsIHRoZSBNSUMgaXMNCj4g
PiBjb250YWluZWQNCj4gPiBjb21wbGV0ZWx5IHdpdGhpbiB0aGUgcGFnZXMgb3IgdGFpbC4gIFRo
aXMgYWxsb3dzIHRoZSByZW1haW5kZXIgb2YNCj4gPiB0aGUNCj4gPiBmdW5jdGlvbiB0byBjcmVh
dGUgYSBzdWIgYnVmZmVyIHRoYXQgZGlyZWN0bHkgYWRkcmVzcyB0aGUgY29tcGxldGUNCj4gPiBN
SUMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRp
bmdAcmVkaGF0LmNvbT4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY1LjENCj4g
PiAtLS0NCj4gPiBuZXQvc3VucnBjL3hkci5jIHwgMzIgKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0NCj4gPiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveGRyLmMgYi9uZXQvc3Vu
cnBjL3hkci5jDQo+ID4gaW5kZXggNDhjOTNiOWU1MjVlLi5hMjljZTczYzMwMjkgMTAwNjQ0DQo+
ID4gLS0tIGEvbmV0L3N1bnJwYy94ZHIuYw0KPiA+ICsrKyBiL25ldC9zdW5ycGMveGRyLmMNCj4g
PiBAQCAtMTIzNywxNiArMTIzNywyOSBAQCB4ZHJfZW5jb2RlX3dvcmQoc3RydWN0IHhkcl9idWYg
KmJ1ZiwNCj4gPiB1bnNpZ25lZCBpbnQgYmFzZSwgdTMyIG9iaikNCj4gPiBFWFBPUlRfU1lNQk9M
X0dQTCh4ZHJfZW5jb2RlX3dvcmQpOw0KPiA+IA0KPiA+IC8qIElmIHRoZSBuZXRvYmogc3RhcnRp
bmcgb2Zmc2V0IGJ5dGVzIGZyb20gdGhlIHN0YXJ0IG9mIHhkcl9idWYgaXMNCj4gPiBjb250YWlu
ZWQNCj4gPiAtICogZW50aXJlbHkgaW4gdGhlIGhlYWQgb3IgdGhlIHRhaWwsIHNldCBvYmplY3Qg
dG8gcG9pbnQgdG8gaXQ7DQo+ID4gb3RoZXJ3aXNlDQo+ID4gLSAqIHRyeSB0byBmaW5kIHNwYWNl
IGZvciBpdCBhdCB0aGUgZW5kIG9mIHRoZSB0YWlsLCBjb3B5IGl0IHRoZXJlLA0KPiA+IGFuZA0K
PiA+IC0gKiBzZXQgb2JqIHRvIHBvaW50IHRvIGl0LiAqLw0KPiA+ICsgKiBlbnRpcmVseSBpbiB0
aGUgaGVhZCwgcGFnZXMsIG9yIHRhaWwsIHNldCBvYmplY3QgdG8gcG9pbnQgdG8NCj4gPiBpdDsg
b3RoZXJ3aXNlDQo+ID4gKyAqIHNoaWZ0IHRoZSBidWZmZXIgdW50aWwgaXQgaXMgY29udGFpbmVk
IGVudGlyZWx5IHdpdGhpbiB0aGUNCj4gPiBwYWdlcyBvciB0YWlsLg0KPiA+ICsgKi8NCj4gPiBp
bnQgeGRyX2J1Zl9yZWFkX25ldG9iaihzdHJ1Y3QgeGRyX2J1ZiAqYnVmLCBzdHJ1Y3QgeGRyX25l
dG9iag0KPiA+ICpvYmosIHVuc2lnbmVkIGludCBvZmZzZXQpDQo+ID4gew0KPiA+IAlzdHJ1Y3Qg
eGRyX2J1ZiBzdWJidWY7DQo+ID4gKwl1bnNpZ25lZCBpbnQgYm91bmRhcnk7DQo+ID4gDQo+ID4g
CWlmICh4ZHJfZGVjb2RlX3dvcmQoYnVmLCBvZmZzZXQsICZvYmotPmxlbikpDQo+ID4gCQlyZXR1
cm4gLUVGQVVMVDsNCj4gPiAtCWlmICh4ZHJfYnVmX3N1YnNlZ21lbnQoYnVmLCAmc3ViYnVmLCBv
ZmZzZXQgKyA0LCBvYmotPmxlbikpDQo+ID4gKwlvZmZzZXQgKz0gNDsNCj4gPiArDQo+ID4gKwkv
KiBJcyB0aGUgb2JqIHBhcnRpYWxseSBpbiB0aGUgaGVhZD8gKi8NCj4gPiArCWJvdW5kYXJ5ID0g
YnVmLT5oZWFkWzBdLmlvdl9sZW47DQo+ID4gKwlpZiAob2Zmc2V0IDwgYm91bmRhcnkgJiYgKG9m
ZnNldCArIG9iai0+bGVuKSA+IGJvdW5kYXJ5KQ0KPiA+ICsJCXhkcl9zaGlmdF9idWYoYnVmLCBi
b3VuZGFyeSAtIG9mZnNldCk7DQo+ID4gKw0KPiA+ICsJLyogSXMgdGhlIG9iaiBwYXJ0aWFsbHkg
aW4gdGhlIHBhZ2VzPyAqLw0KPiA+ICsJYm91bmRhcnkgKz0gYnVmLT5wYWdlX2xlbjsNCj4gPiAr
CWlmIChvZmZzZXQgPCBib3VuZGFyeSAmJiAob2Zmc2V0ICsgb2JqLT5sZW4pID4gYm91bmRhcnkp
DQo+ID4gKwkJeGRyX3Nocmlua19wYWdlbGVuKGJ1ZiwgYm91bmRhcnkgLSBvZmZzZXQpOw0KPiA+
ICsNCj4gPiArCWlmICh4ZHJfYnVmX3N1YnNlZ21lbnQoYnVmLCAmc3ViYnVmLCBvZmZzZXQsIG9i
ai0+bGVuKSkNCj4gPiAJCXJldHVybiAtRUZBVUxUOw0KPiA+IA0KPiA+IAkvKiBJcyB0aGUgb2Jq
IGNvbnRhaW5lZCBlbnRpcmVseSBpbiB0aGUgaGVhZD8gKi8NCj4gPiBAQCAtMTI1OCwxNyArMTI3
MSwxMCBAQCBpbnQgeGRyX2J1Zl9yZWFkX25ldG9iaihzdHJ1Y3QgeGRyX2J1Zg0KPiA+ICpidWYs
IHN0cnVjdCB4ZHJfbmV0b2JqICpvYmosIHVuc2lnbmVkIGluDQo+ID4gCWlmIChzdWJidWYudGFp
bFswXS5pb3ZfbGVuID09IG9iai0+bGVuKQ0KPiA+IAkJcmV0dXJuIDA7DQo+ID4gDQo+ID4gLQkv
KiB1c2UgZW5kIG9mIHRhaWwgYXMgc3RvcmFnZSBmb3Igb2JqOg0KPiA+IC0JICogKFdlIGRvbid0
IGNvcHkgdG8gdGhlIGJlZ2lubmluZyBiZWNhdXNlIHRoZW4gd2UnZCBoYXZlDQo+ID4gLQkgKiB0
byB3b3JyeSBhYm91dCBkb2luZyBhIHBvdGVudGlhbGx5IG92ZXJsYXBwaW5nIGNvcHkuDQo+ID4g
LQkgKiBUaGlzIGFzc3VtZXMgdGhlIG9iamVjdCBpcyBhdCBtb3N0IGhhbGYgdGhlIGxlbmd0aCBv
ZiB0aGUNCj4gPiAtCSAqIHRhaWwuKSAqLw0KPiA+ICsJLyogb2JqIGlzIGluIHRoZSBwYWdlczog
bW92ZSB0byBlbmQgb2YgdGhlIHRhaWwgKi8NCj4gDQo+IEhvdyBhYm91dCAiLyogRmluZCBhIGNv
bnRpZ3VvdXMgYXJlYSBpbiBAYnVmIHRvIGhvbGQgYWxsIG9mIEBvYmogKi8iDQo+ID8NCj4gDQo+
IA0KPiA+IAlpZiAob2JqLT5sZW4gPiBidWYtPmJ1ZmxlbiAtIGJ1Zi0+bGVuKQ0KPiA+IAkJcmV0
dXJuIC1FTk9NRU07DQo+ID4gLQlpZiAoYnVmLT50YWlsWzBdLmlvdl9sZW4gIT0gMCkNCj4gPiAt
CQlvYmotPmRhdGEgPSBidWYtPnRhaWxbMF0uaW92X2Jhc2UgKyBidWYtDQo+ID4gPnRhaWxbMF0u
aW92X2xlbjsNCj4gPiAtCWVsc2UNCj4gPiAtCQlvYmotPmRhdGEgPSBidWYtPmhlYWRbMF0uaW92
X2Jhc2UgKyBidWYtDQo+ID4gPmhlYWRbMF0uaW92X2xlbjsNCj4gPiArCW9iai0+ZGF0YSA9IGJ1
Zi0+dGFpbFswXS5pb3ZfYmFzZSArIGJ1Zi0+dGFpbFswXS5pb3ZfbGVuOw0KPiANCj4gWW91ciBu
ZXcgY29kZSBhc3N1bWVzIHRoYXQgd2hlbiBrcmI1aSBpcyBpbiB1c2UsIHRoZSB1cHBlciBsYXll
ciB3aWxsDQo+IGFsd2F5cw0KPiBwcm92aWRlIGEgbm9uLU5VTEwgdGFpbC0+aW92X2xlbi4gSSB3
b3VsZG4ndCBzd2VhciB0aGF0IHdpbGwgYWx3YXlzDQo+IGJlIHRydWU6DQo+IFRoZSByZWFzb24g
Zm9yIHRoZSAiaWYgKGJ1Zi0+dGFpbFswXS5pb3ZfbGVuKSIgY2hlY2sgaXMgdG8gc2VlDQo+IHdo
ZXRoZXIgdGhlDQo+IHVwcGVyIGxheWVyIGluZGVlZCBoYXMgc2V0IHVwIGEgdGFpbC4gaW92X2xl
biB3aWxsIGJlIG5vbi16ZXJvIG9ubHkNCj4gd2hlbiB0aGUNCj4gdXBwZXIgbGF5ZXIgaGFzIHBy
b3ZpZGVkIGEgdGFpbCBidWZmZXIuDQoNCkZvciB0aGUgY2FzZSB3aGVyZSB3ZSBvbmx5IGhhdmUg
a3ZlYyBkYXRhLCB0aGVuIHhkcl9idWZfaW5pdCgpIGFzc2lnbnMNCmFsbCB0aGUgYWxsb2NhdGVk
IGJ1ZmZlciB0byB0aGUgaGVhZGVyLCBzbyB0aGUgbWljIHNob3VsZCBiZQ0KY29udGlndW91c2x5
IGJ1ZmZlcmVkIHRoZXJlLg0KDQpJZiB3ZSBoYXZlIHBhZ2UgZGF0YSwgdGhlbiB0aGUgZmFjdCB0
aGF0IGF1dGgtPmF1X3JzbGFjayA+IGF1dGgtDQo+YXVfcmFsaWduIHNob3VsZCBlbnN1cmUgdGhh
dCB3ZSBoYXZlIGFsbG9jYXRlZCBhIHN1ZmZpY2llbnRseSBsYXJnZQ0KdGFpbCBidWZmZXIgKHNl
ZSBycGNfcHJlcGFyZV9yZXBseV9wYWdlcygpKS4NCg0KQlRXOiB0aGlzIGFsc28gbWVhbnMgd2Ug
c2hvdWxkIHJlYWxseSBvbmx5IG5lZWQgdG8gbW92ZSB0aGUgbWljIGluIHRoZQ0KY2FzZSB3aGVy
ZSBidWYtPnBhZ2VfbGVuICE9IDAuDQpJdCBhbHNvIG1lYW5zIHRoYXQgd2Ugc2hvdWxkIHByb2Jh
Ymx5IGNoYW5nZSB4ZHJfaW5saW5lX3BhZ2VzKCkgdG8gYmUgYQ0Kc3RhdGljIGZ1bmN0aW9uLCBz
aW5jZSB0aGUgYXNzdW1wdGlvbiBhYm92ZSBmYWlscyBpZiB0aGUgdXNlciBkb2VzIG5vdA0KY2Fs
bCBycGNfcHJlcGFyZV9yZXBseV9wYWdlcygpIGluIG9yZGVyIHRvIGNhbGN1bGF0ZSB0aGUgaGVh
ZGVyDQphbGlnbm1lbnQgY29ycmVjdGx5Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
