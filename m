Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326D3148EAE
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2020 20:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbgAXTZD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jan 2020 14:25:03 -0500
Received: from mail-co1nam11on2109.outbound.protection.outlook.com ([40.107.220.109]:52448
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389871AbgAXTZD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 24 Jan 2020 14:25:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOLTNG+rw6rZwuNFTZ6UZ3fvvUKz8aowuHCbKgNlxrDlBohXAVLN3oY0skD0XPNRIAsq+zQ3QIpke5c6Z+FAYm0K+L627FQA0Zn0JBOc1ChKfAqaSTq3xqLgCR4GM4WGKxazF2lQu8fUhCCtH4wAWfRfDq7Reg7NWitVu/FeOWXNMnqpt6HjqydTd9dp88xM17jZA34Qdx5NyZ4D2KaIRMZAw/YKt3yqdelSs1HedQdeAPgLvcZMzlK7F5n3ARK+pNkDUHeyWSSN3Yxh/67peOp4JaeGCQZTi6MJL3A9xR0uf8opXnM68faMjj6e5ivGPTtmhYMawKRnhNad4qWnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5Kjza8tO9e+FA+Gzj/JtXAttAnjtsfl9TwVoYExzzU=;
 b=JA5yJ/XqYcM3eARqe9j2Dt92ONwf2rrmdRJSDVJScLa8hjMHr+mmlPJ0M5BboKtDNhu1Dm7/w4ChUW/5bSU8fN8dKdFeLZVsrqcUtl+1FCm0eFFZP+wNcTSjWLQ7eRRnrTam1opodjwFZ15StoEhF6BxSpBhZyB2WPGI7aZv9T7kPcXmWzWCdhcVyEUy5sueNU0fxzkL7/dgoDg6GSnes6+RJA+M5aphC+aL735R/MHQ/xTQWaigx1ehA/Z5YLGWpMHtO4OpjoP8VRYO6aYJVYEiQdFKeRun93HIdBj1o0G+DzIPLntv29wgsJcstnbXAio2pZQPr6JN0janVy8lmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5Kjza8tO9e+FA+Gzj/JtXAttAnjtsfl9TwVoYExzzU=;
 b=DYvlLzJtHcrCJNFJvs4WcbFwhSNXuaAgABXVdzwgvKoAF23CINX2Mj2CcBjt3fikIknS1utoGfHC7HUk8r/nKjiPo2irF9bFKRIRj24HMuEYQ7bwPkkYeNIiZQ6FJLv0QrnaR5iLww3cy0wb2YWvqnCBEn/NH93VnodQwT08s9s=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1882.namprd13.prod.outlook.com (10.174.186.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.12; Fri, 24 Jan 2020 19:24:58 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2665.017; Fri, 24 Jan 2020
 19:24:58 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: Revalidate once when holding a delegation
Thread-Topic: [PATCH] NFS: Revalidate once when holding a delegation
Thread-Index: AQHV0r/sgnCq9BoGhE2W4paUJOMO4qf6MmyA
Date:   Fri, 24 Jan 2020 19:24:58 +0000
Message-ID: <ab9d72c908d5c3cecc53ec049572a7675ad12072.camel@hammerspace.com>
References: <c65905b1e2fdaddc6271cbf510d7e30c8790de63.1579874894.git.bcodding@redhat.com>
In-Reply-To: <c65905b1e2fdaddc6271cbf510d7e30c8790de63.1579874894.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [63.235.104.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9df4129-e780-4c8c-f869-08d7a10319da
x-ms-traffictypediagnostic: DM5PR1301MB1882:
x-microsoft-antispam-prvs: <DM5PR1301MB1882309EBE5DE4A5B80F2EAAB80E0@DM5PR1301MB1882.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(8676002)(36756003)(91956017)(64756008)(316002)(76116006)(186003)(66446008)(5660300002)(2616005)(66476007)(71200400001)(66556008)(110136005)(6512007)(86362001)(4326008)(66946007)(6506007)(8936002)(2906002)(81166006)(26005)(478600001)(6486002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1882;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WASDa50UYdyC7Ni9xztdiBiqdGWSudESLS91AEI83YHv0U8erceZUUR+3eIpzCopZbazbPLx8Onim3mpQBC1ijS9089AOe52p7HLgGu2+Ui5hsOs9qVU/YJRm+Nj990mVNRxUMVb6/N1z5ZY7gyNHneGAGbni5JhkViXj5XjdDU37+3bQStGqPTPiXbXZcmE+4DHnlm+qVvKTfiaF85MKvRr6ayv4GyA0pxrIx6ZTwtZGxhwU0Po8e+/IGylDJM8rJbjDjWOGLPhwvMH1/MVdNLRSMU1cxKp+sibLiPCGbd+7IUsh+KBBuX5hM3puvyso/t2w/7PB9BQTrGXAzJtC/4vX/bsi8K2vTPPklJjgJZyBKZmcWux0ZLBNFElS3gm5ibk+vtsHbZo08YRuPAJrqQAGsRieRVdykn8+kjaSFBoyv3pLfEwCyGUupVRhE+N
x-ms-exchange-antispam-messagedata: +9u5yCepVFilVUkm7NFXhp7tp4mxRxUZaPcR2+r2xpmYKX2BiOCF2nU3VezvKTnLGwFAKmJMVavFTyAChlSqicNUBr5Dap8uFskR22R0RH/xCoU75vbbb+johBIywXq8ZjxPLvPZ3F1lHOxmrCE/9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5974F60751A9448A7FC5D6831BAB0F7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9df4129-e780-4c8c-f869-08d7a10319da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 19:24:58.5719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQIMyuHydzL0XcWB5Dz0wCYeldB8gfsAOvVwFeypKvZbWe+VTg27Cd/SmWwG7NFIetJwHr+u+TFPilbpQsQ2zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1882
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTI0IGF0IDA5OjA5IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBJZiB3ZSBza2lwIGxvb2t1cCByZXZhbGlkYXRhaW9uIHdoaWxlIGhvbGRpbmcgYSBk
ZWxlZ2F0aW9uLCB3ZSBtaWdodA0KPiBtaXNzDQo+IHRoYXQgdGhlIGZpbGUgaGFzIGNoYW5nZWQg
ZGlyZWN0b3JpZXMgb24gdGhlIHNlcnZlci4gIFRoaXMgY2FuIGhhcHBlbg0KPiBpZg0KPiB0aGUg
ZmlsZSBpcyBtb3ZlZCBpbiBiZXR3ZWVuIHRoZSBjbGllbnQgY2FjaGluZyBhIGRlbnRyeSBhbmQN
Cj4gb2J0YWluaW5nIGENCj4gZGVsZWdhdGlvbi4gIFRoYXQgY2FuIGJlIHJlcHJvZHVjZWQgb24g
YSBzaW5nbGUgc3lzdGVtIHdpdGggdGhpcw0KPiBiYXNoOg0KPiANCj4gbWtkaXIgLXAgL2V4cG9y
dHMvZGlyezEsMn0NCj4gZXhwb3J0ZnMgLW8gcncgbG9jYWxob3N0Oi9leHBvcnRzDQo+IG1vdW50
IC10IG5mcyAtb3Y0LjEsbm9hYyBsb2NhbGhvc3Q6L2V4cG9ydHMgL21udC9sb2NhbGhvc3QNCj4g
DQo+IHRvdWNoIC9leHBvcnRzL2RpcjEvZnViYXINCj4gDQo+IGNhdCAvbW50L2xvY2FsaG9zdC9k
aXIxL2Z1YmFyDQo+IG12IC9tbnQvbG9jYWxob3N0L2RpcnsxLDJ9L2Z1YmFyDQo+IA0KPiBtdiAv
ZXhwb3J0cy9kaXJ7MiwxfS9mdWJhcg0KPiANCj4gY2F0IC9tbnQvbG9jYWxob3N0L2RpcjEvZnVi
YXINCj4gbXYgL21udC9sb2NhbGhvc3QvZGlyezEsMn0vZnViYXINCj4gDQo+IEluIHRoaXMgZXhh
bXBsZSwgdGhlIGZpbmFsIGBtdmAgd2lsbCBzdGF0IHNvdXJjZSBhbmQgZGVzdGluYXRpb24gYW5k
DQo+IGZpbmQNCj4gdGhleSBhcmUgdGhlIHNhbWUgZGVudHJ5Lg0KPiANCj4gVG8gZml4IHRoaXMg
d2l0aG91dCBnaXZpbmcgdXAgdGhlIGluY3JlYXNlZCBsb29rdXAgcGVyZm9ybWFuY2UgdGhhdA0K
PiBob2xkaW5nDQo+IGEgZGVsZWdhdGlvbiBwcm92aWRlcywgbGV0J3MgcmV2YWxpZGF0ZSB0aGUg
ZGVudHJ5IG9ubHkgb25jZSBhZnRlcg0KPiBvYnRhaW5pbmcgYSBkZWxlZ2F0aW9uIGJ5IHBsYWNp
bmcgYSBtYWdpYyB2YWx1ZSBpbiB0aGUgZGVudHJ5J3MNCj4gdmVyaWZpZXIuDQo+IA0KPiBTdWdn
ZXN0ZWQtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdAcmVkaGF0
LmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvZGlyLmMgfCAyMCArKysrKysrKysrKysrKysrKystLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rpci5jIGIvZnMvbmZzL2Rpci5jDQo+IGluZGV4IGUxODAw
MzNlMzVjZi4uODFhNWEyOGQwMDE1IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4gKysr
IGIvZnMvbmZzL2Rpci5jDQo+IEBAIC0xMDczLDYgKzEwNzMsNyBAQCBpbnQgbmZzX25lZ19uZWVk
X3JldmFsKHN0cnVjdCBpbm9kZSAqZGlyLA0KPiBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksDQo+ICAJ
cmV0dXJuICFuZnNfY2hlY2tfdmVyaWZpZXIoZGlyLCBkZW50cnksIGZsYWdzICYgTE9PS1VQX1JD
VSk7DQo+ICB9DQo+ICANCj4gKyNkZWZpbmUgTkZTX0RFTEVHQVRJT05fVkVSRiAweGZlZWRkZWFm
DQo+ICBzdGF0aWMgaW50DQo+ICBuZnNfbG9va3VwX3JldmFsaWRhdGVfZG9uZShzdHJ1Y3QgaW5v
ZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0KPiAgCQkJICAgc3RydWN0IGlub2RlICpp
bm9kZSwgaW50IGVycm9yKQ0KPiBAQCAtMTEzMyw2ICsxMTM0LDcgQEAgbmZzX2xvb2t1cF9yZXZh
bGlkYXRlX2RlbnRyeShzdHJ1Y3QgaW5vZGUgKmRpciwNCj4gc3RydWN0IGRlbnRyeSAqZGVudHJ5
LA0KPiAgCXN0cnVjdCBuZnNfZmggKmZoYW5kbGU7DQo+ICAJc3RydWN0IG5mc19mYXR0ciAqZmF0
dHI7DQo+ICAJc3RydWN0IG5mczRfbGFiZWwgKmxhYmVsOw0KPiArCXVuc2lnbmVkIGxvbmcgdmVy
aWZpZXI7DQo+ICAJaW50IHJldDsNCj4gIA0KPiAgCXJldCA9IC1FTk9NRU07DQo+IEBAIC0xMTU0
LDYgKzExNTYsMTEgQEAgbmZzX2xvb2t1cF9yZXZhbGlkYXRlX2RlbnRyeShzdHJ1Y3QgaW5vZGUN
Cj4gKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0KPiAgCWlmIChuZnNfcmVmcmVzaF9pbm9k
ZShpbm9kZSwgZmF0dHIpIDwgMCkNCj4gIAkJZ290byBvdXQ7DQo+ICANCj4gKwlpZiAoTkZTX1BS
T1RPKGRpciktPmhhdmVfZGVsZWdhdGlvbihpbm9kZSwgRk1PREVfUkVBRCkpDQo+ICsJCXZlcmlm
aWVyID0gTkZTX0RFTEVHQVRJT05fVkVSRjsNCj4gKwllbHNlDQo+ICsJCXZlcmlmaWVyID0gbmZz
X3NhdmVfY2hhbmdlX2F0dHJpYnV0ZShkaXIpOw0KPiArDQo+ICAJbmZzX3NldHNlY3VyaXR5KGlu
b2RlLCBmYXR0ciwgbGFiZWwpOw0KPiAgCW5mc19zZXRfdmVyaWZpZXIoZGVudHJ5LCBuZnNfc2F2
ZV9jaGFuZ2VfYXR0cmlidXRlKGRpcikpOw0KPiAgDQo+IEBAIC0xMTY3LDYgKzExNzQsMTUgQEAg
bmZzX2xvb2t1cF9yZXZhbGlkYXRlX2RlbnRyeShzdHJ1Y3QgaW5vZGUNCj4gKmRpciwgc3RydWN0
IGRlbnRyeSAqZGVudHJ5LA0KPiAgCXJldHVybiBuZnNfbG9va3VwX3JldmFsaWRhdGVfZG9uZShk
aXIsIGRlbnRyeSwgaW5vZGUsIHJldCk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgbmZzX2Rl
bGVnYXRpb25fbWF0Y2hlc19kZW50cnkoc3RydWN0IGlub2RlICpkaXIsDQo+ICsJCQlzdHJ1Y3Qg
ZGVudHJ5ICpkZW50cnksIHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ICt7DQo+ICsJaWYgKE5GU19Q
Uk9UTyhkaXIpLT5oYXZlX2RlbGVnYXRpb24oaW5vZGUsIEZNT0RFX1JFQUQpICYmDQo+ICsJCWRl
bnRyeS0+ZF90aW1lID09IE5GU19ERUxFR0FUSU9OX1ZFUkYpDQo+ICsJCXJldHVybiAxOw0KPiAr
CXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICAvKg0KPiAgICogVGhpcyBpcyBjYWxsZWQgZXZlcnkg
dGltZSB0aGUgZGNhY2hlIGhhcyBhIGxvb2t1cCBoaXQsDQo+ICAgKiBhbmQgd2Ugc2hvdWxkIGNo
ZWNrIHdoZXRoZXIgd2UgY2FuIHJlYWxseSB0cnVzdCB0aGF0DQo+IEBAIC0xMTk3LDcgKzEyMTMs
NyBAQCBuZnNfZG9fbG9va3VwX3JldmFsaWRhdGUoc3RydWN0IGlub2RlICpkaXIsDQo+IHN0cnVj
dCBkZW50cnkgKmRlbnRyeSwNCj4gIAkJZ290byBvdXRfYmFkOw0KPiAgCX0NCj4gIA0KPiAtCWlm
IChORlNfUFJPVE8oZGlyKS0+aGF2ZV9kZWxlZ2F0aW9uKGlub2RlLCBGTU9ERV9SRUFEKSkNCj4g
KwlpZiAobmZzX2RlbGVnYXRpb25fbWF0Y2hlc19kZW50cnkoZGlyLCBkZW50cnksIGlub2RlKSkN
Cj4gIAkJcmV0dXJuIG5mc19sb29rdXBfcmV2YWxpZGF0ZV9kZWxlZ2F0ZWQoZGlyLCBkZW50cnks
DQo+IGlub2RlKTsNCj4gIA0KPiAgCS8qIEZvcmNlIGEgZnVsbCBsb29rIHVwIGlmZiB0aGUgcGFy
ZW50IGRpcmVjdG9yeSBoYXMgY2hhbmdlZCAqLw0KPiBAQCAtMTYzNSw3ICsxNjUxLDcgQEAgbmZz
NF9kb19sb29rdXBfcmV2YWxpZGF0ZShzdHJ1Y3QgaW5vZGUgKmRpciwNCj4gc3RydWN0IGRlbnRy
eSAqZGVudHJ5LA0KPiAgCWlmIChpbm9kZSA9PSBOVUxMKQ0KPiAgCQlnb3RvIGZ1bGxfcmV2YWw7
DQo+ICANCj4gLQlpZiAoTkZTX1BST1RPKGRpciktPmhhdmVfZGVsZWdhdGlvbihpbm9kZSwgRk1P
REVfUkVBRCkpDQo+ICsJaWYgKG5mc19kZWxlZ2F0aW9uX21hdGNoZXNfZGVudHJ5KGRpciwgZGVu
dHJ5LCBpbm9kZSkpDQo+ICAJCXJldHVybiBuZnNfbG9va3VwX3JldmFsaWRhdGVfZGVsZWdhdGVk
KGRpciwgZGVudHJ5LA0KPiBpbm9kZSk7DQo+ICANCj4gIAkvKiBORlMgb25seSBzdXBwb3J0cyBP
UEVOIG9uIHJlZ3VsYXIgZmlsZXMgKi8NCg0KVGhpcyBwYXRjaCBuZWVkcyB0byBmaXggbmZzX2Zv
cmNlX2xvb2t1cF9yZXZhbGlkYXRlKCkgdG8gYXZvaWQgdGhlDQp2YWx1ZSBORlNfREVMRUdBVElP
Tl9WRVJGLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
