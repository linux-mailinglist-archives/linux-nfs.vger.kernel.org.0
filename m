Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C084214C254
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2020 22:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA1Vqo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jan 2020 16:46:44 -0500
Received: from mail-mw2nam12on2104.outbound.protection.outlook.com ([40.107.244.104]:25440
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgA1Vqo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Jan 2020 16:46:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iau5BeNpXM3RLpqE/Er2wU51GyF1q7ApQ2VUDYxh4SYMSHjTv8Go1slF/nvlbESQ15wJICv3/7dhVa8c/Rf8puazxa8y/jHZc9cXKOBenmInzmeEHh9KgxXurM3Q6RCahDpTN2/l2jMiP8Ppr1Tc6Za7sNRa6ikk2W+rj1Ah5Fyg2f7buhfr6tdpEssjtoGq0XrX/TYMFxgUh8wCh7WEVsCAldOoxRs1S8gH49KaG9aBpD+oi92RVEt9xz+Zj4JWyk0d+uEDT7bWzpahrAOfcP015U5OZRvFqoD3v8nHt1Euo/qt2Oje7ZSiU/b904fngHoVfPU9YNsEjQu8HjRGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df40m1XhdhN1o6DaQNMZjmcmLbSqs686nMOk5JZ0+sM=;
 b=PSUJg6uB0VyGe0g3GU8zpetoJejWoGvSsXPPt+dbHALIT90lYZumISBcwcqf1yEUkqPTieDMlzfy1x+xq1reL64DURq+RveRE6rqySeBO7PNiqx10DrDGIOcL4G53Iy6ElYJ8gBfrYZcXYKDtM1ilCqCoAD2Nro3kvjeLtWzxZLdTI2+C2n8cCSV88zgKDJaoOPeRNyTCZNyzzI41dGTclOitO/mWxzaMBw/ZSGtl+BKxUN0PMp/MYd+kjdvXh0W/nvoE0/nQAXJbv5Knan5VLKeRAoH+3ZYl20Ej2NtUU+bNFN3BN8Bt6pAcy1j7oVcPPnywINiw6iZ+h+SwdVqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df40m1XhdhN1o6DaQNMZjmcmLbSqs686nMOk5JZ0+sM=;
 b=L2VGeCOt0xX1ZwXOl/yn2xK7cru23Bjy6/Kc0Uh0lKU0o0LhSaxi9tpNSrnmM8oUBiy3mltcalebvIVjGo3r2ZJlFepdchg1+cMWgAvMwD1fpzJ64znTSl0qtV6Uqxs2T1tE3zNYqzggcTYyorio4dIh521ZLSml3rvzhEwnfvk=
Received: from BN6PR1301MB2097.namprd13.prod.outlook.com (10.174.87.14) by
 BN6PR1301MB2001.namprd13.prod.outlook.com (10.174.89.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Tue, 28 Jan 2020 21:46:39 +0000
Received: from BN6PR1301MB2097.namprd13.prod.outlook.com
 ([fe80::40e1:9ff5:2b8c:38bf]) by BN6PR1301MB2097.namprd13.prod.outlook.com
 ([fe80::40e1:9ff5:2b8c:38bf%5]) with mapi id 15.20.2686.019; Tue, 28 Jan 2020
 21:46:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFS: Revalidate once when holding a delegation
Thread-Topic: [PATCH v2] NFS: Revalidate once when holding a delegation
Thread-Index: AQHV1e9om4L2YbskUEmxr8p6E5Q5GagAOwsAgABKJQCAABCKAIAAApwAgAAEoIA=
Date:   Tue, 28 Jan 2020 21:46:39 +0000
Message-ID: <3deb5458d142529c0f23669a1b9edaaf4ad032a5.camel@hammerspace.com>
References: <bcb5ffd399c4434730e6d100a5b7cae5e207244e.1580225161.git.bcodding@redhat.com>
         <9e28aaaff4eae411e0a9d6b94b3d69f7514454cb.camel@hammerspace.com>
         <be1a465a0cf52ddae6d2ba26069dff0500b0ea4b.camel@hammerspace.com>
         <d1600385a53358aa69f6f839987a1b11fa2dd5e8.camel@hammerspace.com>
         <5e157e8a6298ecb640414591988c1e76e8a6fd40.camel@hammerspace.com>
In-Reply-To: <5e157e8a6298ecb640414591988c1e76e8a6fd40.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afa82437-0be0-4248-3b6a-08d7a43b8e3a
x-ms-traffictypediagnostic: BN6PR1301MB2001:
x-microsoft-antispam-prvs: <BN6PR1301MB20017E1067AA073B748F26EFB80A0@BN6PR1301MB2001.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39840400004)(376002)(189003)(199004)(2906002)(66476007)(316002)(110136005)(66556008)(64756008)(66446008)(76116006)(66946007)(91956017)(478600001)(5660300002)(81166006)(81156014)(8676002)(71200400001)(6486002)(8936002)(36756003)(6506007)(86362001)(2616005)(26005)(186003)(4326008)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1301MB2001;H:BN6PR1301MB2097.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1sQMRxUmyRovHKsWK3dkHjWFT/sNriBNxl2ODAzjtQ/Lg0G3QYDeSkYl9U4IrO30aEUKi1ZigzAbxN+WvCPwHsY9focXtKvAYGrB8nu8z+EbAmeDTCyMx6FutLns+qr3E3XQxTJphVrfrB4H+ks7izQ/Z8RYzlmTUT/nceUZcKd4TskD0+d42vLF5Tq9iGu4beZCn9o2xUngnu+shZi3ZqEOQlDqEkyh6noMLEzfBP2GEGkNyz6EjQtkN4Q04QJxMhEnwonwWBM25Cx+elDl7+Juay0ExzKAo8t3U7zyZwiArEEBNfjfbKQe7njfyrR0B0r4iKEX5R6JqH67ot8mbPGb5azrINqfkKz8Sgg14QqQNpDzGD15uYxqIxMel3iIWr8jZJcBWyU4Fk55jFyEcgo642JAcmfuBp9an8RRnuED5+jQaYCq6GKrhRbxo9nO
x-ms-exchange-antispam-messagedata: WQtWrfgDEn07gzcdJ042xx99XOBWL8I+Kqx91r4KPWfh/ML0KXbtE54VkgYvmWNfT4pUncoXqjVaRMpQnbILdWT+fgMewp5oa17YYIEA345vAUtQfbl2dc/0SDyRh4o1rLcgINI3U5C4jlyTTKcL1g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEFE961D88EA8F4BBFC8658D3C5097F2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa82437-0be0-4248-3b6a-08d7a43b8e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 21:46:39.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsMu874zLskk7ijb4uAsgUTKBq1ii+giPq46uZe4YK1Y8HgPTkAwAc2DCSI+xgydgFsJ773mPeKmKnTonf9dLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1301MB2001
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTI4IGF0IDIxOjMwICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyMC0wMS0yOCBhdCAxNjoyMCAtMDUwMCwgVHJvbmQgTXlrbGVidXN0IHdy
b3RlOg0KPiA+IE9uIFR1ZSwgMjAyMC0wMS0yOCBhdCAxNToyMSAtMDUwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+ID4gT24gVHVlLCAyMDIwLTAxLTI4IGF0IDEwOjU2IC0wNTAwLCBUcm9u
ZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAyMC0wMS0yOCBhdCAxMDoyNiAt
MDUwMCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90ZToNCj4gPiA+ID4gPiBJZiB3ZSBza2lwIGxv
b2t1cCByZXZhbGlkYXRhaW9uIHdoaWxlIGhvbGRpbmcgYSBkZWxlZ2F0aW9uLA0KPiA+ID4gPiA+
IHdlDQo+ID4gPiA+ID4gbWlnaHQNCj4gPiA+ID4gPiBtaXNzDQo+ID4gPiA+ID4gdGhhdCB0aGUg
ZmlsZSBoYXMgY2hhbmdlZCBkaXJlY3RvcmllcyBvbiB0aGUgc2VydmVyLiAgVGhpcw0KPiA+ID4g
PiA+IGNhbg0KPiA+ID4gPiA+IGhhcHBlbg0KPiA+ID4gPiA+IGlmDQo+ID4gPiA+ID4gdGhlIGZp
bGUgaXMgbW92ZWQgaW4gYmV0d2VlbiB0aGUgY2xpZW50IGNhY2hpbmcgYSBkZW50cnkgYW5kDQo+
ID4gPiA+ID4gb2J0YWluaW5nIGENCj4gPiA+ID4gPiBkZWxlZ2F0aW9uLiAgVGhhdCBjYW4gYmUg
cmVwcm9kdWNlZCBvbiBhIHNpbmdsZSBzeXN0ZW0gd2l0aA0KPiA+ID4gPiA+IHRoaXMNCj4gPiA+
ID4gPiBiYXNoOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IG1rZGlyIC1wIC9leHBvcnRzL2Rpcnsx
LDJ9DQo+ID4gPiA+ID4gZXhwb3J0ZnMgLW8gcncgbG9jYWxob3N0Oi9leHBvcnRzDQo+ID4gPiA+
ID4gbW91bnQgLXQgbmZzIC1vdjQuMSxub2FjIGxvY2FsaG9zdDovZXhwb3J0cyAvbW50L2xvY2Fs
aG9zdA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHRvdWNoIC9leHBvcnRzL2RpcjEvZnViYXINCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBjYXQgL21udC9sb2NhbGhvc3QvZGlyMS9mdWJhcg0KPiA+ID4g
PiA+IG12IC9tbnQvbG9jYWxob3N0L2RpcnsxLDJ9L2Z1YmFyDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gbXYgL2V4cG9ydHMvZGlyezIsMX0vZnViYXINCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBjYXQg
L21udC9sb2NhbGhvc3QvZGlyMS9mdWJhcg0KPiA+ID4gPiA+IG12IC9tbnQvbG9jYWxob3N0L2Rp
cnsxLDJ9L2Z1YmFyDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSW4gdGhpcyBleGFtcGxlLCB0aGUg
ZmluYWwgYG12YCB3aWxsIHN0YXQgc291cmNlIGFuZA0KPiA+ID4gPiA+IGRlc3RpbmF0aW9uDQo+
ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gZmluZA0KPiA+ID4gPiA+IHRoZXkgYXJlIHRoZSBzYW1l
IGRlbnRyeS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUbyBmaXggdGhpcyB3aXRob3V0IGdpdmlu
ZyB1cCB0aGUgaW5jcmVhc2VkIGxvb2t1cA0KPiA+ID4gPiA+IHBlcmZvcm1hbmNlDQo+ID4gPiA+
ID4gdGhhdA0KPiA+ID4gPiA+IGhvbGRpbmcNCj4gPiA+ID4gPiBhIGRlbGVnYXRpb24gcHJvdmlk
ZXMsIGxldCdzIHJldmFsaWRhdGUgdGhlIGRlbnRyeSBvbmx5IG9uY2UNCj4gPiA+ID4gPiBhZnRl
cg0KPiA+ID4gPiA+IG9idGFpbmluZyBhIGRlbGVnYXRpb24gYnkgcGxhY2luZyBhIG1hZ2ljIHZh
bHVlIGluIHRoZQ0KPiA+ID4gPiA+IGRlbnRyeSdzDQo+ID4gPiA+ID4gdmVyaWZpZXIuDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gU3VnZ2VzdGVkLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+ID4g
PiA+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gPiA+ID4g
PiAtLS0NCj4gPiA+ID4gPiAgZnMvbmZzL2Rpci5jIHwgMjIgKysrKysrKysrKysrKysrKysrKyst
LQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rpci5jIGIv
ZnMvbmZzL2Rpci5jDQo+ID4gPiA+ID4gaW5kZXggZTE4MDAzM2UzNWNmLi5lOWQwN2RjZDZkNmYg
MTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZnMvbmZzL2Rpci5jDQo+ID4gPiA+ID4gKysrIGIvZnMv
bmZzL2Rpci5jDQo+ID4gPiA+ID4gQEAgLTk0OSw2ICs5NDksNyBAQCBzdGF0aWMgaW50IG5mc19m
c3luY19kaXIoc3RydWN0IGZpbGUNCj4gPiA+ID4gPiAqZmlscCwNCj4gPiA+ID4gPiBsb2ZmX3Qg
c3RhcnQsIGxvZmZfdCBlbmQsDQo+ID4gPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ID4gPiAgfQ0K
PiA+ID4gPiA+ICANCj4gPiA+ID4gPiArI2RlZmluZSBORlNfREVMRUdBVElPTl9WRVJGIDB4ZmVl
ZGRlYWYNCj4gPiA+ID4gPiAgLyoqDQo+ID4gPiA+ID4gICAqIG5mc19mb3JjZV9sb29rdXBfcmV2
YWxpZGF0ZSAtIE1hcmsgdGhlIGRpcmVjdG9yeSBhcw0KPiA+ID4gPiA+IGhhdmluZw0KPiA+ID4g
PiA+IGNoYW5nZWQNCj4gPiA+ID4gPiAgICogQGRpcjogcG9pbnRlciB0byBkaXJlY3RvcnkgaW5v
ZGUNCj4gPiA+ID4gPiBAQCAtOTYyLDYgKzk2Myw4IEBAIHN0YXRpYyBpbnQgbmZzX2ZzeW5jX2Rp
cihzdHJ1Y3QgZmlsZQ0KPiA+ID4gPiA+ICpmaWxwLA0KPiA+ID4gPiA+IGxvZmZfdCBzdGFydCwg
bG9mZl90IGVuZCwNCj4gPiA+ID4gPiAgdm9pZCBuZnNfZm9yY2VfbG9va3VwX3JldmFsaWRhdGUo
c3RydWN0IGlub2RlICpkaXIpDQo+ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiAgCU5GU19JKGRpcikt
PmNhY2hlX2NoYW5nZV9hdHRyaWJ1dGUrKzsNCj4gPiA+ID4gPiArCWlmIChORlNfSShkaXIpLT5j
YWNoZV9jaGFuZ2VfYXR0cmlidXRlID09DQo+ID4gPiA+ID4gTkZTX0RFTEVHQVRJT05fVkVSRikN
Cj4gPiA+ID4gPiArCQlORlNfSShkaXIpLT5jYWNoZV9jaGFuZ2VfYXR0cmlidXRlKys7DQo+ID4g
PiA+IA0KPiA+ID4gPiBBY3R1YWxseSwgSSB0aGluayBhIHNsaWdodCBtb2RpZmljYXRpb24gdG8g
dGhpcyBjYW4gbWlnaHQgYmUNCj4gPiA+ID4gYmVuZWZpY2lhbC4gSWYgd2UgY2hhbmdlIHRvIHRo
ZSBmb2xsb3dpbmc6DQo+ID4gPiA+IA0KPiA+ID4gPiAJaWYgKHVubGlrZWx5KE5GU19JKGRpcikt
PmNhY2hlX2NoYW5nZV9hdHRyaWJ1dGUgPT0NCj4gPiA+ID4gTkZTX0RFTEVHQVRJT05fVkVSRiAt
IDEpKQ0KPiA+ID4gPiAJCU5GU19JKGRpciktPmNhY2hlX2NoYW5nZV9hdHRyaWJ1dGUgPQ0KPiA+
ID4gPiBORlNfREVMRUdBVElPTl9WRVJGICsgMTsNCj4gPiA+ID4gIAllbHNlDQo+ID4gPiA+IAkJ
TkZTX0koZGlyKS0+Y2FjaGVfY2hhbmdlX2F0dHJpYnV0ZSsrOw0KPiA+ID4gPiANCj4gPiA+IA0K
PiA+ID4gLi4uYWN0dWFsbHksIGl0IHdvdWxkIGJlIG5pY2UgdG8gY2xlYW4gdGhhdCB1cCB0b28g
dXNpbmcgYQ0KPiA+ID4gZGVjbGFyYXRpb24NCj4gPiA+IG9mICdzdHJ1Y3QgbmZzX2lub2RlICpu
ZnNpID0gTkZTX0koZGlyKSk7Jw0KPiA+ID4gDQo+ID4gPiA+IHRoZW4gdGhhdCBzaG91bGQgZW5z
dXJlIHRob3NlIHJlYWRlcnMgb2YgY2FjaGVfY2hhbmdlX2F0dHJpYnV0ZQ0KPiA+ID4gPiB0aGF0
DQo+ID4gPiA+IGRvDQo+ID4gPiA+IG5vdCB1c2UgbG9ja2luZyB3aWxsIGFsc28gbmV2ZXIgc2Vl
IHRoZSB2YWx1ZQ0KPiA+ID4gPiBORlNfREVMRUdBVElPTl9WRVJGDQo+ID4gPiA+IChhc3N1bWlu
ZyB0aGF0IGdjYyBkb2Vzbid0IG9wdGltaXNlIHRoZSBhYm92ZSB0byBzb21ldGhpbmcNCj4gPiA+
ID4gd2VpcmQpLg0KPiA+ID4gPiANCj4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ICBFWFBPUlRfU1lN
Qk9MX0dQTChuZnNfZm9yY2VfbG9va3VwX3JldmFsaWRhdGUpOw0KPiA+ID4gPiA+ICANCj4gPiA+
ID4gPiBAQCAtMTEzMyw2ICsxMTM2LDcgQEAgbmZzX2xvb2t1cF9yZXZhbGlkYXRlX2RlbnRyeShz
dHJ1Y3QNCj4gPiA+ID4gPiBpbm9kZQ0KPiA+ID4gPiA+ICpkaXIsDQo+ID4gPiA+ID4gc3RydWN0
IGRlbnRyeSAqZGVudHJ5LA0KPiA+ID4gPiA+ICAJc3RydWN0IG5mc19maCAqZmhhbmRsZTsNCj4g
PiA+ID4gPiAgCXN0cnVjdCBuZnNfZmF0dHIgKmZhdHRyOw0KPiA+ID4gPiA+ICAJc3RydWN0IG5m
czRfbGFiZWwgKmxhYmVsOw0KPiA+ID4gPiA+ICsJdW5zaWduZWQgbG9uZyB2ZXJpZmllcjsNCj4g
PiA+ID4gPiAgCWludCByZXQ7DQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ICAJcmV0ID0gLUVOT01F
TTsNCj4gPiA+ID4gPiBAQCAtMTE1NCw2ICsxMTU4LDExIEBAIG5mc19sb29rdXBfcmV2YWxpZGF0
ZV9kZW50cnkoc3RydWN0DQo+ID4gPiA+ID4gaW5vZGUNCj4gPiA+ID4gPiAqZGlyLCBzdHJ1Y3Qg
ZGVudHJ5ICpkZW50cnksDQo+ID4gPiA+ID4gIAlpZiAobmZzX3JlZnJlc2hfaW5vZGUoaW5vZGUs
IGZhdHRyKSA8IDApDQo+ID4gPiA+ID4gIAkJZ290byBvdXQ7DQo+ID4gPiA+ID4gIA0KPiA+ID4g
PiA+ICsJaWYgKE5GU19QUk9UTyhkaXIpLT5oYXZlX2RlbGVnYXRpb24oaW5vZGUsIEZNT0RFX1JF
QUQpKQ0KPiA+ID4gPiA+ICsJCXZlcmlmaWVyID0gTkZTX0RFTEVHQVRJT05fVkVSRjsNCj4gPiA+
ID4gPiArCWVsc2UNCj4gPiA+ID4gPiArCQl2ZXJpZmllciA9IG5mc19zYXZlX2NoYW5nZV9hdHRy
aWJ1dGUoZGlyKTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gIAluZnNfc2V0c2VjdXJpdHkoaW5v
ZGUsIGZhdHRyLCBsYWJlbCk7DQo+ID4gPiA+ID4gIAluZnNfc2V0X3ZlcmlmaWVyKGRlbnRyeSwN
Cj4gPiA+ID4gPiBuZnNfc2F2ZV9jaGFuZ2VfYXR0cmlidXRlKGRpcikpOw0KPiA+ID4gDQo+ID4g
PiBPb3BzISBXaGVuIHJldmlld2luZywgSSBtaXNzZWQgdGhpcy4gU2hvdWxkbid0IHRoZSBhYm92
ZSBiZQ0KPiA+ID4gY2hhbmdlZA0KPiA+ID4gdG8NCj4gPiA+IG5mc19zZXRfdmVyaWZpZXIoZGVu
dHJ5LCB2ZXJpZmllcikgPw0KPiA+IA0KPiA+IC4uLmFuZCBvbiBhIHNpbWlsYXIgdmVpbjogbmZz
X2xvb2t1cF9yZXZhbGlkYXRlX2RlbGVnYXRlZCgpIG5lZWRzDQo+ID4gdG8NCj4gPiBjaGFuZ2Ug
c28gYXMgdG8gbm90IHJlc2V0IHRoZSB2ZXJpZmllci4uLg0KPiA+IA0KPiA+IFNvcnJ5IGZvciBu
b3QgY2F0Y2hpbmcgdGhhdCBvbmUgZWl0aGVyLg0KPiANCj4gTm90IG15IGRheS4uLg0KPiANCj4g
bmZzX3ByaW1lX2RjYWNoZSgpIHdpbGwgY2xvYmJlciB0aGUgdmVyaWZpZXIgdG9vIGluIHRoZQ0K
PiBuZnNfc2FtZV9maWxlKCkNCj4gY2FzZS4gVGhhdCBvbmUgYWxzbyBuZWVkcyB0byBzZXQgTkZT
X0RFTEVHQVRJT05fVkVSRiBpZiB0aGVyZSBpcyBhDQo+IGRlbGVnYXRpb24uDQo+IA0KPiBQZXJo
YXBzIGFkZCBhIGhlbHBlciBmdW5jdGlvbiBmb3IgdGhhdCArDQo+IG5mc19sb29rdXBfcmV2YWxp
ZGF0ZV9kZW50cnkoKT8NCg0KLi4uLmFuZCBmaW5hbGx5LCB3ZSBzaG91bGQgcmVtb3ZlIHRoZSBj
YWxsIHRvIG5mc19zZXRfdmVyaWZpZXIoKSBmcm9tDQpuZnM0X2ZpbGVfb3BlbigpLiBBc2lkZSBm
cm9tIGJlaW5nIGluY29ycmVjdCBpbiB0aGUgY2FzZSB3aGVyZSB3ZSB1c2VkDQphbiBvcGVuLWJ5
LWZpbGVoYW5kbGUsIHRoYXQgY2FzZSBpcyB0YWtlbiBjYXJlIG9mIGluIHRoZSBwcmVjZWRpbmcN
CmRlbnRyeSByZXZhbGlkYXRpb24uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
