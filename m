Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C153E3D2A0
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404650AbfFKQlT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 12:41:19 -0400
Received: from mail-eopbgr740118.outbound.protection.outlook.com ([40.107.74.118]:40608
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405021AbfFKQlT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 12:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gvozt7W1xnBD8zpYmbpoeCCckaEdNaaDVt5GX1G2i/k=;
 b=YVJf2Mc4t7NXhemoI3PxEtJWB37erfseFw7mlZhMoTJQpmhqfMDdOd7rs5IgW8jOUaz6yCLvhHqvWmKFw+nWadatAYMuTEfouWmM6dVAptXB2b7n2Q3TjKnOF11DsU4d7y53PSu84hbOUCfsuN6a7Ajx8mttmhMsyFNXyXlrrAY=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1852.namprd13.prod.outlook.com (10.171.156.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.5; Tue, 11 Jun 2019 16:41:15 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1987.010; Tue, 11 Jun 2019
 16:41:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.com" <neilb@suse.com>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Topic: [PATCH 0/9] Multiple network connections for a single NFS mount.
Thread-Index: AQHVFoClDLUWSno6kkqu5+tdKdASRKaD9P4AgABTyoCAAPi5AIAQdgMAgADl1oCAAAgVgIAABEUAgAASQIA=
Date:   Tue, 11 Jun 2019 16:41:15 +0000
Message-ID: <266475174966dd473670d9fc9f6a6d6af3d87d44.camel@hammerspace.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
         <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
         <87muj3tuuk.fsf@notabene.neil.brown.name>
         <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
         <87lfy9vsgf.fsf@notabene.neil.brown.name>
         <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
         <6693beb0989c83580235526e3d1b54fad0920d82.camel@hammerspace.com>
         <35A94418-7DE0-4656-90B4-5A0183BA371C@oracle.com>
In-Reply-To: <35A94418-7DE0-4656-90B4-5A0183BA371C@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2edd8865-192b-4b5a-2f49-08d6ee8b9ee9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1852;
x-ms-traffictypediagnostic: DM5PR13MB1852:
x-microsoft-antispam-prvs: <DM5PR13MB1852E8230B6F7E7A96497E19B8ED0@DM5PR13MB1852.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39830400003)(396003)(376002)(199004)(189003)(256004)(478600001)(118296001)(54906003)(6916009)(2906002)(2351001)(186003)(99286004)(305945005)(68736007)(66066001)(446003)(26005)(2616005)(476003)(11346002)(6116002)(3846002)(486006)(86362001)(102836004)(6486002)(66556008)(66476007)(76176011)(6436002)(6506007)(14454004)(6512007)(229853002)(76116006)(64756008)(316002)(66446008)(36756003)(73956011)(53546011)(5640700003)(66946007)(6246003)(81156014)(8676002)(81166006)(71200400001)(5660300002)(53936002)(25786009)(8936002)(2501003)(7736002)(71190400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1852;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lDt2aXVFl+h94ojRRUFwudoQ8eBzm1J+lLEGYwL7/pZfnrae1rIfdUqxgPyUS+HxzELw8P0SerqbaQpGDNb6pm3LGo+T9WgbRABy8jVbxyedrg9kU+3FD0o5rwRgM+G1SypOsPcjC4eLdfkNZjnOmmlhPipl9LEwRBGa8DD1AQ4CXA/kAj+DhnNo+03JlfedB0QFVWNic3UeF5mps+28w9K7zlqzvbkY88Sy9GRfAeitHxkmkYpu9JHukgnL2HiScgn2VVrbKVFUt7MzgwlbUrFsjPfFgsSYDTH0gO1poRLmWMJiXtu0Rbx66/U3clST63efwJnsOqJV0kUzaVmt/mEvrwS7EZexlwrYhcIVubfhAJvnEva7HP4wY7St30G/HHsRVh0aqUjHhSAFz0uoLdq2ujk9Soqz4K/l5YNKFlQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <031C27633637B64BAC4D1AEBA571504F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edd8865-192b-4b5a-2f49-08d6ee8b9ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 16:41:15.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1852
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTExIGF0IDExOjM1IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBKdW4gMTEsIDIwMTksIGF0IDExOjIwIEFNLCBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+IHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIwMTktMDYt
MTEgYXQgMTA6NTEgLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+IA0KPiA+ID4gSWYgbWF4
Y29ubiBpcyBhIGhpbnQsIHdoZW4gZG9lcyB0aGUgY2xpZW50IG9wZW4gYWRkaXRpb25hbA0KPiA+
ID4gY29ubmVjdGlvbnM/DQo+ID4gDQo+ID4gQXMgSSd2ZSBhbHJlYWR5IHN0YXRlZCwgdGhhdCBm
dW5jdGlvbmFsaXR5IGlzIG5vdCB5ZXQgYXZhaWxhYmxlLg0KPiA+IFdoZW4NCj4gPiBpdCBpcywg
aXQgd2lsbCBiZSB1bmRlciB0aGUgY29udHJvbCBvZiBhIHVzZXJzcGFjZSBkYWVtb24gdGhhdCBj
YW4NCj4gPiBkZWNpZGUgb24gYSBwb2xpY3kgaW4gYWNjb3JkYW5jZSB3aXRoIGEgc2V0IG9mIHVz
ZXIgc3BlY2lmaWVkDQo+ID4gcmVxdWlyZW1lbnRzLg0KPiANCj4gVGhlbiB3aHkgZG8gd2UgbmVl
ZCBhIG1vdW50IG9wdGlvbiBhdCBhbGw/DQo+IA0KDQpGb3Igb25lIHRoaW5nLCBpdCBhbGxvd3Mg
cGVvcGxlIHRvIHBsYXkgd2l0aCB0aGlzIHVudGlsIHdlIGhhdmUgYSBmdWxseQ0KYXV0b21hdGVk
IHNvbHV0aW9uLiBUaGUgZmFjdCB0aGF0IHBlb3BsZSBhcmUgYWN0dWFsbHkgcHVsbGluZyBkb3du
DQp0aGVzZSBwYXRjaGVzLCBmb3J3YXJkIHBvcnRpbmcgdGhlbSBhbmQgdHJ5aW5nIHRoZW0gb3V0
IHdvdWxkIGluZGljYXRlDQp0aGF0IHRoZXJlIGlzIGludGVyZXN0IGluIGRvaW5nIHNvLg0KDQpT
ZWNvbmRseSwgaWYgeW91ciBwb2xpY3kgaXMgJ0kganVzdCB3YW50IG4gY29ubmVjdGlvbnMnIGJl
Y2F1c2UgdGhhdA0KZml0cyB5b3VyIHdvcmtsb2FkIHJlcXVpcmVtZW50cyAoZS5nLiBiZWNhdXNl
IHNhaWQgd29ya2xvYWQgaXMgYm90aA0KbGF0ZW5jeSBzZW5zaXRpdmUgYW5kIGJ1cnN0eSksIHRo
ZW4gYSBkYWVtb24gc29sdXRpb24gd291bGQgYmUNCnVubmVjZXNzYXJ5LCBhbmQgbWF5IGJlIGVy
cm9yIHByb25lLg0KQSBtb3VudCBvcHRpb24gaXMgaGVscGZ1bCBpbiB0aGlzIGNhc2UsIGJlY2F1
c2UgeW91IGNhbiBwZXJmb3JtIHRoZQ0Kc2V0dXAgdGhyb3VnaCB0aGUgbm9ybWFsIGZzdGFiIG9y
IGF1dG9mcyBjb25maWcgZmlsZSBjb25maWd1cmF0aW9uDQpyb3V0ZS4gSXQgYWxzbyBtYWtlIHNl
bnNlIGlmIHlvdSBoYXZlIGEgbmZzcm9vdCBzZXR1cC4NCg0KRmluYWxseSwgZXZlbiBpZiB5b3Ug
ZG8gd2FudCB0byBoYXZlIGEgZGFlbW9uIG1hbmFnZSB5b3VyIHRyYW5zcG9ydCwNCmNvbmZpZ3Vy
YXRpb24sIHlvdSBkbyB3YW50IGEgbWVjaGFuaXNtIHRvIGhlbHAgaXQgcmVhY2ggYW4gZXF1aWxp
YnJpdW0NCnN0YXRlIHF1aWNrbHkuIENvbm5lY3Rpb25zIHRha2UgdGltZSB0byBicmluZyB1cCBh
bmQgdGVhciBkb3duIGJlY2F1c2UNCnBlcmZvcm1hbmNlIG1lYXN1cmVtZW50cyB0YWtlIHRpbWUg
dG8gYnVpbGQgdXAgc3VmZmljaWVudCBzdGF0aXN0aWNhbA0KcHJlY2lzaW9uLiBGdXJ0aGVybW9y
ZSwgZG9pbmcgc28gY29tZXMgd2l0aCBhIG51bWJlciBvZiBoaWRkZW4gY29zdHMsDQplLmcuOiBj
aGV3aW5nIHVwIHByaXZpbGVnZWQgcG9ydCBudW1iZXJzIGJ5IHB1dHRpbmcgdGhlbSBpbiBhIFRJ
TUVfV0FJVA0Kc3RhdGUuIElmIHlvdSBrbm93IHRoYXQgYSBnaXZlbiBzZXJ2ZXIgaXMgYWx3YXlz
IHN1YmplY3QgdG8gaGVhdnkNCnRyYWZmaWMsIHRoZW4gaW5pdGlhbGlzaW5nIHRoZSBudW1iZXIg
b2YgY29ubmVjdGlvbnMgYXBwcm9wcmlhdGVseSBoYXMNCnZhbHVlLg0KDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
