Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5EF42653
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439095AbfFLMrX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 08:47:23 -0400
Received: from mail-eopbgr790121.outbound.protection.outlook.com ([40.107.79.121]:25703
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439172AbfFLMrX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 08:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKequCWH2cxjR7dWEJxnlocgkuoVAg2syHlIUZ+NXBE=;
 b=GwK1Ajg5FE0WF2e8HlqTrOBTcL7MAF4zbSQjZsqyFY7o06Ie8OdUFabft9gyb57iC0FbYXvED/NTzS5hPPOJb760L4QVweySp8zYweh0pd2Z1HrCLH7sWTvval5RrhLsCMIxQ2yCWvYGOFYKO1ejaNnTJJNE+41+xatrdNxikoA=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1257.namprd13.prod.outlook.com (10.168.114.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.7; Wed, 12 Jun 2019 12:47:18 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1987.010; Wed, 12 Jun 2019
 12:47:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "SteveD@RedHat.com" <SteveD@RedHat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.com" <neilb@suse.com>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Topic: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Index: AQHVFoClDLUWSno6kkqu5+tdKdASRKaD9P4AgABTyoCAAPi5AIAQdgMAgADl1oCAAAgVgIAABEUAgAASQICAAA47gIAAA36AgAE7qwCAAAOIAA==
Date:   Wed, 12 Jun 2019 12:47:18 +0000
Message-ID: <59754dc70887d8b90b755e02dafe11257a5dbbf4.camel@hammerspace.com>
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
         <6a4ace315ee7f9c72e4866384fcb800707a4cbe4.camel@hammerspace.com>
         <b3a9a877-a348-b680-6eb5-e10019ba46b7@RedHat.com>
In-Reply-To: <b3a9a877-a348-b680-6eb5-e10019ba46b7@RedHat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35d571ea-a21b-4ded-cc12-08d6ef341ad0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1257;
x-ms-traffictypediagnostic: DM5PR13MB1257:
x-microsoft-antispam-prvs: <DM5PR13MB125779D8C2B92543DF63AFF5B8EC0@DM5PR13MB1257.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39830400003)(366004)(136003)(189003)(199004)(6436002)(118296001)(6512007)(36756003)(486006)(66066001)(2501003)(6116002)(3846002)(478600001)(68736007)(6486002)(26005)(5660300002)(53546011)(86362001)(256004)(14444005)(102836004)(6506007)(76176011)(186003)(54906003)(476003)(73956011)(99286004)(316002)(110136005)(4326008)(81156014)(8936002)(8676002)(81166006)(76116006)(14454004)(66946007)(66476007)(66556008)(64756008)(66446008)(6246003)(71200400001)(71190400001)(229853002)(7736002)(25786009)(2616005)(11346002)(305945005)(446003)(53936002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1257;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4osk1w01XmaV9DVV09q1lxxX5vrX2qdTodqBFuqD2g/boutwbgEcEV7V7tk/FVqzphiNhwVoIUjG4Yn/tu25B8KV8ZcB+jjW0i4aeZPcpofv4UpbRoI1XjEPE3o1zXehl/grt7hx6o7jyfyS5PTuDzVI4L6CMQ4jIyLOs8rHRlzuKz99aFWRr78YJJkgesiVK8B0eBoJeY/UufDN7nL2WCKLmS0sBSfA7z3EnjBl+20Uv4Tpj07lFphU1LsevN+2fvKvtOGu/nsLvaxjD5tJ0nXSloY5SdSp2AJypzlM2LqOyRGrgmOPWawVkxBNJcgOtuyNT9Y4S/0gapntw4drIhgTkq4Oy8J+hHMtrYplXkvpV7hqxcJOUhSZm2MIM/iJvwyvQsHNlq9Y0HlijGDaktriHlnneldn97FiRVz05CY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67C43D715D18AB49A26F0B04CE50633D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d571ea-a21b-4ded-cc12-08d6ef341ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 12:47:18.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1257
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTEyIGF0IDA4OjM0IC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiANCj4gT24gNi8xMS8xOSAxOjQ0IFBNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gT24g
VHVlLCAyMDE5LTA2LTExIGF0IDEzOjMyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+
ID4gT24gSnVuIDExLCAyMDE5LCBhdCAxMjo0MSBQTSwgVHJvbmQgTXlrbGVidXN0IDwNCj4gPiA+
ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24g
VHVlLCAyMDE5LTA2LTExIGF0IDExOjM1IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+
ID4gPiA+IE9uIEp1biAxMSwgMjAxOSwgYXQgMTE6MjAgQU0sIFRyb25kIE15a2xlYnVzdCA8DQo+
ID4gPiA+ID4gPiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAxOS0wNi0xMSBhdCAxMDo1MSAtMDQwMCwgQ2h1Y2sgTGV2
ZXIgd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSWYgbWF4Y29ubiBpcyBhIGhp
bnQsIHdoZW4gZG9lcyB0aGUgY2xpZW50IG9wZW4NCj4gPiA+ID4gPiA+ID4gYWRkaXRpb25hbA0K
PiA+ID4gPiA+ID4gPiBjb25uZWN0aW9ucz8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQXMg
SSd2ZSBhbHJlYWR5IHN0YXRlZCwgdGhhdCBmdW5jdGlvbmFsaXR5IGlzIG5vdCB5ZXQNCj4gPiA+
ID4gPiA+IGF2YWlsYWJsZS4NCj4gPiA+ID4gPiA+IFdoZW4NCj4gPiA+ID4gPiA+IGl0IGlzLCBp
dCB3aWxsIGJlIHVuZGVyIHRoZSBjb250cm9sIG9mIGEgdXNlcnNwYWNlIGRhZW1vbg0KPiA+ID4g
PiA+ID4gdGhhdA0KPiA+ID4gPiA+ID4gY2FuDQo+ID4gPiA+ID4gPiBkZWNpZGUgb24gYSBwb2xp
Y3kgaW4gYWNjb3JkYW5jZSB3aXRoIGEgc2V0IG9mIHVzZXINCj4gPiA+ID4gPiA+IHNwZWNpZmll
ZA0KPiA+ID4gPiA+ID4gcmVxdWlyZW1lbnRzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZW4g
d2h5IGRvIHdlIG5lZWQgYSBtb3VudCBvcHRpb24gYXQgYWxsPw0KPiA+ID4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+ID4gRm9yIG9uZSB0aGluZywgaXQgYWxsb3dzIHBlb3BsZSB0byBwbGF5IHdpdGgg
dGhpcyB1bnRpbCB3ZSBoYXZlDQo+ID4gPiA+IGENCj4gPiA+ID4gZnVsbHkNCj4gPiA+ID4gYXV0
b21hdGVkIHNvbHV0aW9uLiBUaGUgZmFjdCB0aGF0IHBlb3BsZSBhcmUgYWN0dWFsbHkgcHVsbGlu
Zw0KPiA+ID4gPiBkb3duDQo+ID4gPiA+IHRoZXNlIHBhdGNoZXMsIGZvcndhcmQgcG9ydGluZyB0
aGVtIGFuZCB0cnlpbmcgdGhlbSBvdXQgd291bGQNCj4gPiA+ID4gaW5kaWNhdGUNCj4gPiA+ID4g
dGhhdCB0aGVyZSBpcyBpbnRlcmVzdCBpbiBkb2luZyBzby4NCj4gPiA+IA0KPiA+ID4gQWdyZWVk
IHRoYXQgaXQgZGVtb25zdHJhdGVzIHRoYXQgZm9sa3MgYXJlIGludGVyZXN0ZWQgaW4gaGF2aW5n
DQo+ID4gPiBtdWx0aXBsZSBjb25uZWN0aW9ucy4gSSBjb3VudCBteXNlbGYgYW1vbmcgdGhlbS4N
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+IFNlY29uZGx5LCBpZiB5b3VyIHBvbGljeSBpcyAnSSBq
dXN0IHdhbnQgbiBjb25uZWN0aW9ucycgYmVjYXVzZQ0KPiA+ID4gPiB0aGF0DQo+ID4gPiA+IGZp
dHMgeW91ciB3b3JrbG9hZCByZXF1aXJlbWVudHMgKGUuZy4gYmVjYXVzZSBzYWlkIHdvcmtsb2Fk
IGlzDQo+ID4gPiA+IGJvdGgNCj4gPiA+ID4gbGF0ZW5jeSBzZW5zaXRpdmUgYW5kIGJ1cnN0eSks
IHRoZW4gYSBkYWVtb24gc29sdXRpb24gd291bGQgYmUNCj4gPiA+ID4gdW5uZWNlc3NhcnksIGFu
ZCBtYXkgYmUgZXJyb3IgcHJvbmUuDQo+ID4gPiANCj4gPiA+IFdoeSB3b3VsZG4ndCB0aGF0IGJl
IHRoZSBkZWZhdWx0IG91dC1vZi10aGUtc2hyaW5rd3JhcA0KPiA+ID4gY29uZmlndXJhdGlvbg0K
PiA+ID4gdGhhdCBpcyBpbnN0YWxsZWQgYnkgbmZzLXV0aWxzPw0KPiA+IA0KPiA+IFdoYXQgaXMg
dGhlIHBvaW50IG9mIGZvcmNpbmcgcGVvcGxlIHRvIHJ1biBhIGRhZW1vbiBpZiBhbGwgdGhleQ0K
PiA+IHdhbnQgdG8NCj4gPiBkbyBpcyBzZXQgdXAgYSBmaXhlZCBudW1iZXIgb2YgY29ubmVjdGlv
bnM/DQo+ID4gDQo+ID4gPiA+IEEgbW91bnQgb3B0aW9uIGlzIGhlbHBmdWwgaW4gdGhpcyBjYXNl
LCBiZWNhdXNlIHlvdSBjYW4gcGVyZm9ybQ0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gc2V0dXAgdGhy
b3VnaCB0aGUgbm9ybWFsIGZzdGFiIG9yIGF1dG9mcyBjb25maWcgZmlsZQ0KPiA+ID4gPiBjb25m
aWd1cmF0aW9uDQo+ID4gPiA+IHJvdXRlLiBJdCBhbHNvIG1ha2Ugc2Vuc2UgaWYgeW91IGhhdmUg
YSBuZnNyb290IHNldHVwLg0KPiA+ID4gDQo+ID4gPiBORlNST09UIGlzIHRoZSBvbmx5IHVzYWdl
IHNjZW5hcmlvIHdoZXJlIEkgc2VlIGEgbW91bnQgb3B0aW9uDQo+ID4gPiBiZWluZw0KPiA+ID4g
YSBzdXBlcmlvciBhZG1pbmlzdHJhdGl2ZSBpbnRlcmZhY2UuIEhvd2V2ZXIgSSBkb24ndCBmZWVs
IHRoYXQNCj4gPiA+IE5GU1JPT1QgaXMgZ29pbmcgdG8gaG9zdCB3b3JrbG9hZHMgdGhhdCB3b3Vs
ZCBuZWVkIG11bHRpcGxlDQo+ID4gPiBjb25uZWN0aW9ucy4gS0lTDQo+ID4gPiANCj4gPiA+IA0K
PiA+ID4gPiBGaW5hbGx5LCBldmVuIGlmIHlvdSBkbyB3YW50IHRvIGhhdmUgYSBkYWVtb24gbWFu
YWdlIHlvdXINCj4gPiA+ID4gdHJhbnNwb3J0LA0KPiA+ID4gPiBjb25maWd1cmF0aW9uLCB5b3Ug
ZG8gd2FudCBhIG1lY2hhbmlzbSB0byBoZWxwIGl0IHJlYWNoIGFuDQo+ID4gPiA+IGVxdWlsaWJy
aXVtDQo+ID4gPiA+IHN0YXRlIHF1aWNrbHkuIENvbm5lY3Rpb25zIHRha2UgdGltZSB0byBicmlu
ZyB1cCBhbmQgdGVhciBkb3duDQo+ID4gPiA+IGJlY2F1c2UNCj4gPiA+ID4gcGVyZm9ybWFuY2Ug
bWVhc3VyZW1lbnRzIHRha2UgdGltZSB0byBidWlsZCB1cCBzdWZmaWNpZW50DQo+ID4gPiA+IHN0
YXRpc3RpY2FsDQo+ID4gPiA+IHByZWNpc2lvbi4gRnVydGhlcm1vcmUsIGRvaW5nIHNvIGNvbWVz
IHdpdGggYSBudW1iZXIgb2YgaGlkZGVuDQo+ID4gPiA+IGNvc3RzLA0KPiA+ID4gPiBlLmcuOiBj
aGV3aW5nIHVwIHByaXZpbGVnZWQgcG9ydCBudW1iZXJzIGJ5IHB1dHRpbmcgdGhlbSBpbiBhDQo+
ID4gPiA+IFRJTUVfV0FJVA0KPiA+ID4gPiBzdGF0ZS4gSWYgeW91IGtub3cgdGhhdCBhIGdpdmVu
IHNlcnZlciBpcyBhbHdheXMgc3ViamVjdCB0bw0KPiA+ID4gPiBoZWF2eQ0KPiA+ID4gPiB0cmFm
ZmljLCB0aGVuIGluaXRpYWxpc2luZyB0aGUgbnVtYmVyIG9mIGNvbm5lY3Rpb25zDQo+ID4gPiA+
IGFwcHJvcHJpYXRlbHkNCj4gPiA+ID4gaGFzDQo+ID4gPiA+IHZhbHVlLg0KPiA+ID4gDQo+ID4g
PiBBZ2FpbiwgSSBkb24ndCBzZWUgaG93IHRoaXMgaXMgbm90IHNvbWV0aGluZyBhIGNvbmZpZyBm
aWxlIGNhbg0KPiA+ID4gZG8uDQo+ID4gDQo+ID4gWW91IGNhbiwgYnV0IHRoYXQgbWVhbnMgeW91
IGhhdmUgdG8ga2VlcCBzYWlkIGNvbmZpZyBmaWxlIHVwIHRvDQo+ID4gZGF0ZQ0KPiA+IHdpdGgg
dGhlIGNvbnRlbnRzIG9mIC9ldGMvZnN0YWIgZXRjLiBQdWx2ZXJpc2luZyBjb25maWd1cmF0aW9u
IGludG8NCj4gPiBsaXR0bGUgYml0cyBhbmQgcGllY2VzIHRoYXQgYXJlIHNjYXR0ZXJlZCBhcm91
bmQgaW4gZGlmZmVyZW50IGZpbGVzDQo+ID4gaXMNCj4gPiBub3QgYSB1c2VyIGZyaWVuZGx5IGlu
dGVyZmFjZSBlaXRoZXIuDQo+ID4gDQo+ID4gPiBUaGUgc3RhdGVkIGludGVudCBvZiAibmNvbm5l
Y3QiIHdheSBiYWNrIHdoZW4gd2FzIGZvcg0KPiA+ID4gZXhwZXJpbWVudGF0aW9uLg0KPiA+ID4g
SXQgd29ya3MgZ3JlYXQgZm9yIHRoYXQhDQo+ID4gPiANCj4gPiA+IEkgZG9uJ3Qgc2VlIGl0IGFz
IGEgZGVzaXJhYmxlIGxvbmctdGVybSBhZG1pbmlzdHJhdGl2ZSBpbnRlcmZhY2UsDQo+ID4gPiB0
aG91Z2guIEknZCByYXRoZXIgbm90IG5haWwgaW4gYSBuZXcgbW91bnQgb3B0aW9uIHRoYXQgd2UN
Cj4gPiA+IGFjdHVhbGx5DQo+ID4gPiBwbGFuIHRvIG9ic29sZXRlIGluIGZhdm9yIG9mIGFuIGF1
dG9tYXRlZCBtZWNoYW5pc20uIEknZCByYXRoZXINCj4gPiA+IHNlZQ0KPiA+ID4gdXMgZGVzaWdu
IHRoZSBhZG1pbmlzdHJhdGl2ZSBpbnRlcmZhY2Ugd2l0aCBhdXRvbWF0aW9uIGZyb20gdGhlDQo+
ID4gPiBzdGFydC4gVGhhdCB3aWxsIGhhdmUgYSBsb3dlciBsb25nLXRlcm0gbWFpbnRlbmFuY2Ug
Y29zdC4NCj4gPiA+IA0KPiA+ID4gQWdhaW4sIEknbSBub3Qgb2JqZWN0aW5nIHRvIHN1cHBvcnQg
Zm9yIG11bHRpcGxlIGNvbm5lY3Rpb25zLg0KPiA+ID4gSXQncw0KPiA+ID4ganVzdCB0aGF0IGFk
ZGluZyBhIG1vdW50IG9wdGlvbiBkb2Vzbid0IGZlZWwgbGlrZSBhIGZyaWVuZGx5IG9yDQo+ID4g
PiBmaW5pc2hlZCBpbnRlcmZhY2UgZm9yIGFjdHVhbCB1c2Vycy4gQSBjb25maWcgZmlsZSAob3Ig
cmUtdXNpbmcNCj4gPiA+IG5mcy5jb25mKSBzZWVtcyB0byBtZSBsaWtlIGEgYmV0dGVyIGFwcHJv
YWNoLg0KPiA+IA0KPiA+IG5mcy5jb25mIGlzIGdyZWF0IGZvciBkZWZpbmluZyBnbG9iYWwgZGVm
YXVsdHMuDQo+ID4gDQo+ID4gSXQgY2FuIGRvIHNlcnZlciBzcGVjaWZpYyBjb25maWd1cmF0aW9u
LCBidXQgaXMgbm90IGEgcG9wdWxhcg0KPiA+IHNvbHV0aW9uDQo+ID4gZm9yIHRoYXQuIE1vc3Qg
cGVvcGxlIGFyZSBzdGlsbCBwdXR0aW5nIHRoYXQgaW5mb3JtYXRpb24gaW4NCj4gPiAvZXRjL2Zz
dGFiDQo+ID4gc28gdGhhdCBpdCBhcHBlYXJzIGluIG9uZSBzcG90Lg0KPiA+IA0KPiBXaGF0IGFi
b3V0IG5mc21vdW50LmNvbmY/IFRoYXQgc2VlbXMgbGlrZSBhIG1vcmUgcmVhc29uYWJsZSBwbGFj
ZQ0KPiB0byBkZWZpbmUgaG93IG1vdW50cyBzaG91bGQgd29yay4uLiANCj4gDQoNClRoYXQgaGFz
IHRoZSBleGFjdCBzYW1lIHByb2JsZW0uIEFzIGxvbmcgYXMgaXQgZGVmaW5lcyBnbG9iYWwgZGVm
YXVsdHMsDQp0aGVuIGZpbmUsIGJ1dCBpZiBpdCBwdWx2ZXJpc2VzIHRoZSBjb25maWd1cmF0aW9u
IGZvciBlYWNoIGFuZCBldmVyeQ0Kc2VydmVyLCBhbmQgbWFrZXMgaXQgaGFyZGVyIHRvIHRyYWNl
IHdoYXQgd2hhdCBvdmVycmlkZXMgYXJlIGJlaW5nDQphcHBsaWVkLCBhbmQgd2hlcmUgdGhleSBh
cmUgYmVpbmcgYXBwbGllZCB0aGVuIGl0IGlzIG5vdCBoZWxwZnVsLg0KDQpBbm90aGVyIGlzc3Vl
IHRoZXJlIGlzIHRoYXQgbmVpdGhlciBuZnMuY29uZiBub3IgbmZzbW91bnQuY29uZiBhcmUNCmJl
aW5nIHVzZWQgYnkgYWxsIGltcGxlbWVudGF0aW9ucyBvZiB0aGUgbW91bnQgdXRpbGl0eS4gQXMg
ZmFyIGFzIEkNCmtub3cgdGhleSBhcmUgbm90IHN1cHBvcnRlZCBieSBidXN5Ym94LCBmb3IgaW5z
dGFuY2UuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
