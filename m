Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440AA42711
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 15:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439298AbfFLNK1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 09:10:27 -0400
Received: from mail-eopbgr780100.outbound.protection.outlook.com ([40.107.78.100]:58816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbfFLNK0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 09:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY3CrTai02W9168C2OdCJGNXIp84CWWnS1HevHWx+I8=;
 b=Y/lkg3JBp6J1aGHYqH8WK2xQHaXsTnie+P2kBKOT12npd8lsndiDWRJRDCIg9En7nxoefLtvtGleQugM19KKsLZzvaNetaV7EASQZUlnrRBtjk/8vNS+7EfCVKLgkV3VHikK1k4NGCNcqppMvGwGXlUWVeNoGkXo3dpUgFgZgBM=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1514.namprd13.prod.outlook.com (10.175.111.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Wed, 12 Jun 2019 13:10:18 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1987.010; Wed, 12 Jun 2019
 13:10:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "SteveD@RedHat.com" <SteveD@RedHat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.com" <neilb@suse.com>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Topic: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Index: AQHVFoClDLUWSno6kkqu5+tdKdASRKaD9P4AgABTyoCAAPi5AIAQdgMAgADl1oCAAAgVgIAABEUAgAASQICAAA47gIAAA36AgAE7qwCAAAOIAIAABm0A
Date:   Wed, 12 Jun 2019 13:10:18 +0000
Message-ID: <7bced42ba30089a99acb6f1b00ed5fb1a61b1791.camel@hammerspace.com>
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
         <59754dc70887d8b90b755e02dafe11257a5dbbf4.camel@hammerspace.com>
In-Reply-To: <59754dc70887d8b90b755e02dafe11257a5dbbf4.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c967612-c4f6-41d8-d314-08d6ef375165
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1514;
x-ms-traffictypediagnostic: DM5PR13MB1514:
x-microsoft-antispam-prvs: <DM5PR13MB15143F8B0677A986BAAD3C2AB8EC0@DM5PR13MB1514.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39830400003)(136003)(189003)(199004)(53434003)(476003)(8936002)(76176011)(53936002)(110136005)(54906003)(81166006)(6246003)(7736002)(305945005)(256004)(8676002)(186003)(14444005)(25786009)(26005)(99286004)(5660300002)(486006)(14454004)(81156014)(2616005)(11346002)(446003)(6506007)(53546011)(71200400001)(478600001)(71190400001)(68736007)(6436002)(4326008)(316002)(36756003)(6486002)(118296001)(6116002)(3846002)(229853002)(102836004)(86362001)(73956011)(66066001)(2501003)(66556008)(66446008)(64756008)(76116006)(91956017)(66946007)(6512007)(2906002)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1514;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h109UOnZQSBZoFKsdZGuCfu6+26r1Aq8/sTuwj+rB+BlOqZ4vLO/A49MnN8AdHyjJ43GTRqcu7Tmjhw2Hcl+w9u4LMwTL39cZ5ubc0sy6wouBAkWDuPdS9AgLwZjxdyUvK69fa2XGW8yZtOYq4cHOH4R1XaRSfxZO7JSu3eawNRkGLb1HGOxDF8oJuEh4U5rW5MGgqS0qQ2tKijUgC22i2Lw5d/mrxYZvHj8wpPOPBHJl/mSYNVvaP4zaIaY3xdLEPhdttZgAr7k+2qLVrw1vb5lSROnc8ARcYSyeT5XBkv9dA/9xXlfVCAw45rc6OqwJvaboYlKUEPbaW7aqP7/+ufb2pus5DxmL/RSOo1CUTpqHPfT6jPrsdA3aZFeefK+ONfbXT8rKilOdcisyjQRdB6WnI7/Z5OwRMysYyBB2AY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A1BD7B8944AF84AA0FC9734AD2D79BB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c967612-c4f6-41d8-d314-08d6ef375165
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 13:10:18.6600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1514
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTEyIGF0IDEyOjQ3ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAxOS0wNi0xMiBhdCAwODozNCAtMDQwMCwgU3RldmUgRGlja3NvbiB3cm90
ZToNCj4gPiBPbiA2LzExLzE5IDE6NDQgUE0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+
IE9uIFR1ZSwgMjAxOS0wNi0xMSBhdCAxMzozMiAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+
ID4gPiA+ID4gT24gSnVuIDExLCAyMDE5LCBhdCAxMjo0MSBQTSwgVHJvbmQgTXlrbGVidXN0IDwN
Cj4gPiA+ID4gPiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gT24gVHVlLCAyMDE5LTA2LTExIGF0IDExOjM1IC0wNDAwLCBDaHVjayBMZXZlciB3
cm90ZToNCj4gPiA+ID4gPiA+ID4gT24gSnVuIDExLCAyMDE5LCBhdCAxMToyMCBBTSwgVHJvbmQg
TXlrbGVidXN0IDwNCj4gPiA+ID4gPiA+ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gT24gVHVlLCAyMDE5LTA2LTExIGF0IDEw
OjUxIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiA+ID4gSWYgbWF4Y29ubiBpcyBhIGhpbnQsIHdoZW4gZG9lcyB0aGUgY2xpZW50IG9wZW4NCj4g
PiA+ID4gPiA+ID4gPiBhZGRpdGlvbmFsDQo+ID4gPiA+ID4gPiA+ID4gY29ubmVjdGlvbnM/DQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBBcyBJJ3ZlIGFscmVhZHkgc3RhdGVkLCB0aGF0
IGZ1bmN0aW9uYWxpdHkgaXMgbm90IHlldA0KPiA+ID4gPiA+ID4gPiBhdmFpbGFibGUuDQo+ID4g
PiA+ID4gPiA+IFdoZW4NCj4gPiA+ID4gPiA+ID4gaXQgaXMsIGl0IHdpbGwgYmUgdW5kZXIgdGhl
IGNvbnRyb2wgb2YgYSB1c2Vyc3BhY2UgZGFlbW9uDQo+ID4gPiA+ID4gPiA+IHRoYXQNCj4gPiA+
ID4gPiA+ID4gY2FuDQo+ID4gPiA+ID4gPiA+IGRlY2lkZSBvbiBhIHBvbGljeSBpbiBhY2NvcmRh
bmNlIHdpdGggYSBzZXQgb2YgdXNlcg0KPiA+ID4gPiA+ID4gPiBzcGVjaWZpZWQNCj4gPiA+ID4g
PiA+ID4gcmVxdWlyZW1lbnRzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGVuIHdoeSBk
byB3ZSBuZWVkIGEgbW91bnQgb3B0aW9uIGF0IGFsbD8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IEZvciBvbmUgdGhpbmcsIGl0IGFsbG93cyBwZW9wbGUgdG8gcGxheSB3aXRo
IHRoaXMgdW50aWwgd2UNCj4gPiA+ID4gPiBoYXZlDQo+ID4gPiA+ID4gYQ0KPiA+ID4gPiA+IGZ1
bGx5DQo+ID4gPiA+ID4gYXV0b21hdGVkIHNvbHV0aW9uLiBUaGUgZmFjdCB0aGF0IHBlb3BsZSBh
cmUgYWN0dWFsbHkgcHVsbGluZw0KPiA+ID4gPiA+IGRvd24NCj4gPiA+ID4gPiB0aGVzZSBwYXRj
aGVzLCBmb3J3YXJkIHBvcnRpbmcgdGhlbSBhbmQgdHJ5aW5nIHRoZW0gb3V0IHdvdWxkDQo+ID4g
PiA+ID4gaW5kaWNhdGUNCj4gPiA+ID4gPiB0aGF0IHRoZXJlIGlzIGludGVyZXN0IGluIGRvaW5n
IHNvLg0KPiA+ID4gPiANCj4gPiA+ID4gQWdyZWVkIHRoYXQgaXQgZGVtb25zdHJhdGVzIHRoYXQg
Zm9sa3MgYXJlIGludGVyZXN0ZWQgaW4gaGF2aW5nDQo+ID4gPiA+IG11bHRpcGxlIGNvbm5lY3Rp
b25zLiBJIGNvdW50IG15c2VsZiBhbW9uZyB0aGVtLg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4g
PiA+ID4gU2Vjb25kbHksIGlmIHlvdXIgcG9saWN5IGlzICdJIGp1c3Qgd2FudCBuIGNvbm5lY3Rp
b25zJw0KPiA+ID4gPiA+IGJlY2F1c2UNCj4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gZml0cyB5
b3VyIHdvcmtsb2FkIHJlcXVpcmVtZW50cyAoZS5nLiBiZWNhdXNlIHNhaWQgd29ya2xvYWQNCj4g
PiA+ID4gPiBpcw0KPiA+ID4gPiA+IGJvdGgNCj4gPiA+ID4gPiBsYXRlbmN5IHNlbnNpdGl2ZSBh
bmQgYnVyc3R5KSwgdGhlbiBhIGRhZW1vbiBzb2x1dGlvbiB3b3VsZA0KPiA+ID4gPiA+IGJlDQo+
ID4gPiA+ID4gdW5uZWNlc3NhcnksIGFuZCBtYXkgYmUgZXJyb3IgcHJvbmUuDQo+ID4gPiA+IA0K
PiA+ID4gPiBXaHkgd291bGRuJ3QgdGhhdCBiZSB0aGUgZGVmYXVsdCBvdXQtb2YtdGhlLXNocmlu
a3dyYXANCj4gPiA+ID4gY29uZmlndXJhdGlvbg0KPiA+ID4gPiB0aGF0IGlzIGluc3RhbGxlZCBi
eSBuZnMtdXRpbHM/DQo+ID4gPiANCj4gPiA+IFdoYXQgaXMgdGhlIHBvaW50IG9mIGZvcmNpbmcg
cGVvcGxlIHRvIHJ1biBhIGRhZW1vbiBpZiBhbGwgdGhleQ0KPiA+ID4gd2FudCB0bw0KPiA+ID4g
ZG8gaXMgc2V0IHVwIGEgZml4ZWQgbnVtYmVyIG9mIGNvbm5lY3Rpb25zPw0KPiA+ID4gDQo+ID4g
PiA+ID4gQSBtb3VudCBvcHRpb24gaXMgaGVscGZ1bCBpbiB0aGlzIGNhc2UsIGJlY2F1c2UgeW91
IGNhbg0KPiA+ID4gPiA+IHBlcmZvcm0NCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBzZXR1cCB0
aHJvdWdoIHRoZSBub3JtYWwgZnN0YWIgb3IgYXV0b2ZzIGNvbmZpZyBmaWxlDQo+ID4gPiA+ID4g
Y29uZmlndXJhdGlvbg0KPiA+ID4gPiA+IHJvdXRlLiBJdCBhbHNvIG1ha2Ugc2Vuc2UgaWYgeW91
IGhhdmUgYSBuZnNyb290IHNldHVwLg0KPiA+ID4gPiANCj4gPiA+ID4gTkZTUk9PVCBpcyB0aGUg
b25seSB1c2FnZSBzY2VuYXJpbyB3aGVyZSBJIHNlZSBhIG1vdW50IG9wdGlvbg0KPiA+ID4gPiBi
ZWluZw0KPiA+ID4gPiBhIHN1cGVyaW9yIGFkbWluaXN0cmF0aXZlIGludGVyZmFjZS4gSG93ZXZl
ciBJIGRvbid0IGZlZWwgdGhhdA0KPiA+ID4gPiBORlNST09UIGlzIGdvaW5nIHRvIGhvc3Qgd29y
a2xvYWRzIHRoYXQgd291bGQgbmVlZCBtdWx0aXBsZQ0KPiA+ID4gPiBjb25uZWN0aW9ucy4gS0lT
DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiBGaW5hbGx5LCBldmVuIGlmIHlvdSBkbyB3
YW50IHRvIGhhdmUgYSBkYWVtb24gbWFuYWdlIHlvdXINCj4gPiA+ID4gPiB0cmFuc3BvcnQsDQo+
ID4gPiA+ID4gY29uZmlndXJhdGlvbiwgeW91IGRvIHdhbnQgYSBtZWNoYW5pc20gdG8gaGVscCBp
dCByZWFjaCBhbg0KPiA+ID4gPiA+IGVxdWlsaWJyaXVtDQo+ID4gPiA+ID4gc3RhdGUgcXVpY2ts
eS4gQ29ubmVjdGlvbnMgdGFrZSB0aW1lIHRvIGJyaW5nIHVwIGFuZCB0ZWFyDQo+ID4gPiA+ID4g
ZG93bg0KPiA+ID4gPiA+IGJlY2F1c2UNCj4gPiA+ID4gPiBwZXJmb3JtYW5jZSBtZWFzdXJlbWVu
dHMgdGFrZSB0aW1lIHRvIGJ1aWxkIHVwIHN1ZmZpY2llbnQNCj4gPiA+ID4gPiBzdGF0aXN0aWNh
bA0KPiA+ID4gPiA+IHByZWNpc2lvbi4gRnVydGhlcm1vcmUsIGRvaW5nIHNvIGNvbWVzIHdpdGgg
YSBudW1iZXIgb2YNCj4gPiA+ID4gPiBoaWRkZW4NCj4gPiA+ID4gPiBjb3N0cywNCj4gPiA+ID4g
PiBlLmcuOiBjaGV3aW5nIHVwIHByaXZpbGVnZWQgcG9ydCBudW1iZXJzIGJ5IHB1dHRpbmcgdGhl
bSBpbiBhDQo+ID4gPiA+ID4gVElNRV9XQUlUDQo+ID4gPiA+ID4gc3RhdGUuIElmIHlvdSBrbm93
IHRoYXQgYSBnaXZlbiBzZXJ2ZXIgaXMgYWx3YXlzIHN1YmplY3QgdG8NCj4gPiA+ID4gPiBoZWF2
eQ0KPiA+ID4gPiA+IHRyYWZmaWMsIHRoZW4gaW5pdGlhbGlzaW5nIHRoZSBudW1iZXIgb2YgY29u
bmVjdGlvbnMNCj4gPiA+ID4gPiBhcHByb3ByaWF0ZWx5DQo+ID4gPiA+ID4gaGFzDQo+ID4gPiA+
ID4gdmFsdWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBBZ2FpbiwgSSBkb24ndCBzZWUgaG93IHRoaXMg
aXMgbm90IHNvbWV0aGluZyBhIGNvbmZpZyBmaWxlIGNhbg0KPiA+ID4gPiBkby4NCj4gPiA+IA0K
PiA+ID4gWW91IGNhbiwgYnV0IHRoYXQgbWVhbnMgeW91IGhhdmUgdG8ga2VlcCBzYWlkIGNvbmZp
ZyBmaWxlIHVwIHRvDQo+ID4gPiBkYXRlDQo+ID4gPiB3aXRoIHRoZSBjb250ZW50cyBvZiAvZXRj
L2ZzdGFiIGV0Yy4gUHVsdmVyaXNpbmcgY29uZmlndXJhdGlvbg0KPiA+ID4gaW50bw0KPiA+ID4g
bGl0dGxlIGJpdHMgYW5kIHBpZWNlcyB0aGF0IGFyZSBzY2F0dGVyZWQgYXJvdW5kIGluIGRpZmZl
cmVudA0KPiA+ID4gZmlsZXMNCj4gPiA+IGlzDQo+ID4gPiBub3QgYSB1c2VyIGZyaWVuZGx5IGlu
dGVyZmFjZSBlaXRoZXIuDQo+ID4gPiANCj4gPiA+ID4gVGhlIHN0YXRlZCBpbnRlbnQgb2YgIm5j
b25uZWN0IiB3YXkgYmFjayB3aGVuIHdhcyBmb3INCj4gPiA+ID4gZXhwZXJpbWVudGF0aW9uLg0K
PiA+ID4gPiBJdCB3b3JrcyBncmVhdCBmb3IgdGhhdCENCj4gPiA+ID4gDQo+ID4gPiA+IEkgZG9u
J3Qgc2VlIGl0IGFzIGEgZGVzaXJhYmxlIGxvbmctdGVybSBhZG1pbmlzdHJhdGl2ZQ0KPiA+ID4g
PiBpbnRlcmZhY2UsDQo+ID4gPiA+IHRob3VnaC4gSSdkIHJhdGhlciBub3QgbmFpbCBpbiBhIG5l
dyBtb3VudCBvcHRpb24gdGhhdCB3ZQ0KPiA+ID4gPiBhY3R1YWxseQ0KPiA+ID4gPiBwbGFuIHRv
IG9ic29sZXRlIGluIGZhdm9yIG9mIGFuIGF1dG9tYXRlZCBtZWNoYW5pc20uIEknZCByYXRoZXIN
Cj4gPiA+ID4gc2VlDQo+ID4gPiA+IHVzIGRlc2lnbiB0aGUgYWRtaW5pc3RyYXRpdmUgaW50ZXJm
YWNlIHdpdGggYXV0b21hdGlvbiBmcm9tIHRoZQ0KPiA+ID4gPiBzdGFydC4gVGhhdCB3aWxsIGhh
dmUgYSBsb3dlciBsb25nLXRlcm0gbWFpbnRlbmFuY2UgY29zdC4NCj4gPiA+ID4gDQo+ID4gPiA+
IEFnYWluLCBJJ20gbm90IG9iamVjdGluZyB0byBzdXBwb3J0IGZvciBtdWx0aXBsZSBjb25uZWN0
aW9ucy4NCj4gPiA+ID4gSXQncw0KPiA+ID4gPiBqdXN0IHRoYXQgYWRkaW5nIGEgbW91bnQgb3B0
aW9uIGRvZXNuJ3QgZmVlbCBsaWtlIGEgZnJpZW5kbHkgb3INCj4gPiA+ID4gZmluaXNoZWQgaW50
ZXJmYWNlIGZvciBhY3R1YWwgdXNlcnMuIEEgY29uZmlnIGZpbGUgKG9yIHJlLXVzaW5nDQo+ID4g
PiA+IG5mcy5jb25mKSBzZWVtcyB0byBtZSBsaWtlIGEgYmV0dGVyIGFwcHJvYWNoLg0KPiA+ID4g
DQo+ID4gPiBuZnMuY29uZiBpcyBncmVhdCBmb3IgZGVmaW5pbmcgZ2xvYmFsIGRlZmF1bHRzLg0K
PiA+ID4gDQo+ID4gPiBJdCBjYW4gZG8gc2VydmVyIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24sIGJ1
dCBpcyBub3QgYSBwb3B1bGFyDQo+ID4gPiBzb2x1dGlvbg0KPiA+ID4gZm9yIHRoYXQuIE1vc3Qg
cGVvcGxlIGFyZSBzdGlsbCBwdXR0aW5nIHRoYXQgaW5mb3JtYXRpb24gaW4NCj4gPiA+IC9ldGMv
ZnN0YWINCj4gPiA+IHNvIHRoYXQgaXQgYXBwZWFycyBpbiBvbmUgc3BvdC4NCj4gPiA+IA0KPiA+
IFdoYXQgYWJvdXQgbmZzbW91bnQuY29uZj8gVGhhdCBzZWVtcyBsaWtlIGEgbW9yZSByZWFzb25h
YmxlIHBsYWNlDQo+ID4gdG8gZGVmaW5lIGhvdyBtb3VudHMgc2hvdWxkIHdvcmsuLi4gDQo+ID4g
DQo+IA0KPiBUaGF0IGhhcyB0aGUgZXhhY3Qgc2FtZSBwcm9ibGVtLiBBcyBsb25nIGFzIGl0IGRl
ZmluZXMgZ2xvYmFsDQo+IGRlZmF1bHRzLA0KPiB0aGVuIGZpbmUsIGJ1dCBpZiBpdCBwdWx2ZXJp
c2VzIHRoZSBjb25maWd1cmF0aW9uIGZvciBlYWNoIGFuZCBldmVyeQ0KPiBzZXJ2ZXIsIGFuZCBt
YWtlcyBpdCBoYXJkZXIgdG8gdHJhY2Ugd2hhdCB3aGF0IG92ZXJyaWRlcyBhcmUgYmVpbmcNCj4g
YXBwbGllZCwgYW5kIHdoZXJlIHRoZXkgYXJlIGJlaW5nIGFwcGxpZWQgdGhlbiBpdCBpcyBub3Qg
aGVscGZ1bC4NCj4gDQo+IEFub3RoZXIgaXNzdWUgdGhlcmUgaXMgdGhhdCBuZWl0aGVyIG5mcy5j
b25mIG5vciBuZnNtb3VudC5jb25mIGFyZQ0KPiBiZWluZyB1c2VkIGJ5IGFsbCBpbXBsZW1lbnRh
dGlvbnMgb2YgdGhlIG1vdW50IHV0aWxpdHkuIEFzIGZhciBhcyBJDQo+IGtub3cgdGhleSBhcmUg
bm90IHN1cHBvcnRlZCBieSBidXN5Ym94LCBmb3IgaW5zdGFuY2UuDQo+IA0KDQpCVFc6IEp1c3Qg
YSByZW1pbmRlciB0aGF0IG5laXRoZXIgbmZzLmNvbmYgbm9yIG5mc21vdW50LmNvbmYgYXJlIGtl
cm5lbA0KQVBJcy4gVGhleSBhcmUganVzdCBjb25maWd1cmF0aW9uIGZpbGVzIGZvciBvdGhlciB1
dGlsaXRpZXMgYW5kIGRhZW1vbnMNCnRoYXQgYWN0dWFsbHkgY2FsbCBrZXJuZWwgQVBJcy4gU28g
dGFsayBhYm91dCBzaGlmdGluZyB0aGUNCnJlc3BvbnNpYmlsaXR5IGZvciBkZWZpbmluZyBjb25u
ZWN0aW9uIHRvcG9sb2dpZXMgdG8gdGhvc2UgZmlsZXMgaXMgbm90DQpoZWxwZnVsIHVubGVzcyB5
b3UgYWxzbyBkZXNjcmliZSAoYW5kIGRldmVsb3ApIHRoZSBrZXJuZWwgaW50ZXJmYWNlcyB0bw0K
YmUgdXNlZCBieSB3aGF0ZXZlciByZWFkcyB0aG9zZSBmaWxlcy4NCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
