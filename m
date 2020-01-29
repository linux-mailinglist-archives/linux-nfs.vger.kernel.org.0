Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F014CCEE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgA2PEp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 10:04:45 -0500
Received: from mail-mw2nam12on2103.outbound.protection.outlook.com ([40.107.244.103]:27321
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbgA2PEp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Jan 2020 10:04:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMheeTmGs8+IRhOkJ5n5NAYmuPN4fzrvz4fsoBDHQL1GNqgdsENWkyZI+DxzlETExsHPWd6Df7stkrB6U21S+1NhnpdcXPIQpTaOE4iDP8LiZelyuhn+tkFjowsBARbLZU7unV57zxsUU+7Eja+t78ck2dkelkEQZAkPyAA1naoBWr00VTxgCfCu8Ci4OQjzhFJLG2mdcjT6Gfn+d2ev/ycYF6s9p00KtpDcwqxz8gETwQA6B+kObh0Klwa7fXdI3BvTil6kAHcC39IvzJWdpocNNcQuidgbQtN1RKmlUMMnwKYAEuSbletCzjqSkDG1kucyrdsklMC320dmygNLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtV8nmRFA6sT3iDdCxuAVuKAyz2q+I0WoI7vTmyAXIs=;
 b=XUKrLTQIwh0R1FT7MBFPojAcyK0LonAXg5/JP9Od0oTK5Bbg9ih75OOkUKl/MM/X6ohQrg0UFT0yCyKXaAqBjcnt6BsSScvMopz1eAEDgnAyRJ+h5TKZ0Rk8LJuwITm7o7aKm/S4XQsYVsKyyOu2v4Z5MLSwHytste5nDVJmBE25Dy4tqR6rMWax8G3A4/w8amXbXl847BjhsGD+tHE7Q+iZ9imitMFVGkTBceO4kY+6l8qOlbWOD1Bml7afpsvCYzy/J0+zRb6XhZwYmfBum9Ju9iGKjthbO467mbk+0kKtpWbGFUXBqK1xb/gA7gs7xMSmQktqFWV009udjBHWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtV8nmRFA6sT3iDdCxuAVuKAyz2q+I0WoI7vTmyAXIs=;
 b=HWVc7tUt6kcru97GxSr2eNnGFS2ZS6gfLApjm5+b7FVQITiMYPuMUKuYe/rvGtVd3UguWjiH0D7wA7j1tacZ7bdWSPbIBsq5o+x0Q1pOdPvZrxsWfZvYtVMXoRx9fAEig+6DoXk1H2u8ZDMmcEhvIEy6EnLFMPKUgLeoA5ldAYs=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2218.namprd13.prod.outlook.com (10.174.184.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Wed, 29 Jan 2020 15:04:40 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2686.019; Wed, 29 Jan 2020
 15:04:40 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v2] NFS: Revalidate once when holding a delegation
Thread-Topic: [PATCH v2] NFS: Revalidate once when holding a delegation
Thread-Index: AQHV1e9om4L2YbskUEmxr8p6E5Q5GagAOwsAgABKJQCAABCKAIAAApwAgAAEoICAART/AIAADQaA
Date:   Wed, 29 Jan 2020 15:04:40 +0000
Message-ID: <7d83d09f968394646424c61e9fa28b7b2a6d9b1a.camel@hammerspace.com>
References: <bcb5ffd399c4434730e6d100a5b7cae5e207244e.1580225161.git.bcodding@redhat.com>
         <9e28aaaff4eae411e0a9d6b94b3d69f7514454cb.camel@hammerspace.com>
         <be1a465a0cf52ddae6d2ba26069dff0500b0ea4b.camel@hammerspace.com>
         <d1600385a53358aa69f6f839987a1b11fa2dd5e8.camel@hammerspace.com>
         <5e157e8a6298ecb640414591988c1e76e8a6fd40.camel@hammerspace.com>
         <3deb5458d142529c0f23669a1b9edaaf4ad032a5.camel@hammerspace.com>
         <A95E0924-D2E8-4D02-951C-36D33070D0CD@redhat.com>
In-Reply-To: <A95E0924-D2E8-4D02-951C-36D33070D0CD@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc507961-f83e-417a-138d-08d7a4cc90f6
x-ms-traffictypediagnostic: DM5PR1301MB2218:
x-microsoft-antispam-prvs: <DM5PR1301MB22185006B1E1ACABFC02A645B8050@DM5PR1301MB2218.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(189003)(199004)(26005)(5660300002)(54906003)(53546011)(66476007)(6506007)(66446008)(6512007)(64756008)(66556008)(2616005)(86362001)(81166006)(81156014)(8676002)(36756003)(6486002)(76116006)(66946007)(91956017)(8936002)(186003)(71200400001)(110136005)(508600001)(2906002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2218;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oq6Mvew9/dXL582CmjwpldH+ZOoRFWrKwdySexxBiAPkwsvqVzUm4jVFKXTktfueJU7OgEZuvTo4g9PsXfOyzb4qkkeG5Nb/zXRr83X1lE5zzSzTB0KNaW3NPsf+iomqLIOdTtuBuV4LpKhyc9qGfsiqRNKyToktZFr0wt3bdw+t9tZYhXkYjaeu7m3ALy6O34rDYOkAi6GZxlhAsgyvpHSyQ+g0a+Om/4x89o7p/GRdc1cH0qW6w4n1L1FXfM5tG8frYw5lAKOTEgWBn6nkUE9TIhPvCjXwaNkaGtHtQbXpAJ/KaA8G/KxYZVBzdetfhFcjWO5BvBwLoFTqoMH9MRhGUh7QUHDD3Oy1dLH6+keYUT+IqWZfRQUNqR305htAu0yY/z/KS92PW9F0UZmD/X/vucPXucQgZnoAZ9HqhgLdmRN8nfhG77dv4DGRNFOm
x-ms-exchange-antispam-messagedata: 46bvVLLD8ZtANeNTuGYjUgIQ4CEivR2d5f64WoBYaQ+C1PV64ZuKENFF2x8xMRZkPAXbnyumwcCwwYc5dkVWuwLwilmXYlqxN2iVGi7tZxLA6yNr+NLK+XKh4rGx14RwY2N+RUtAwWsyX19xGBf9Nw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DDDE0DC579A314E96C69B88B88B5295@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc507961-f83e-417a-138d-08d7a4cc90f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 15:04:40.7814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjc6fyZN3lj1p3BOzpGgLkP9cCuiPEOV7eHmyv2Tqq5yaoXEXDhVT7si6ufJUKLphvssOa4xHtPI63GuhJWgQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2218
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTI5IGF0IDA5OjE4IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyOCBKYW4gMjAyMCwgYXQgMTY6NDYsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gVHVlLCAyMDIwLTAxLTI4IGF0IDIxOjMwICswMDAwLCBUcm9uZCBNeWtsZWJ1
c3Qgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDIwMjAtMDEtMjggYXQgMTY6MjAgLTA1MDAsIFRyb25k
IE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIwLTAxLTI4IGF0IDE1OjIxIC0w
NTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVlLCAyMDIwLTAxLTI4
IGF0IDEwOjU2IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBU
dWUsIDIwMjAtMDEtMjggYXQgMTA6MjYgLTA1MDAsIEJlbmphbWluIENvZGRpbmd0b24NCj4gPiA+
ID4gPiA+IHdyb3RlOg0KPiAuLi4NCj4gPiA+ID4gPiA+ID4gKwlpZiAoTkZTX1BST1RPKGRpcikt
PmhhdmVfZGVsZWdhdGlvbihpbm9kZSwgRk1PREVfUkVBRCkpDQo+ID4gPiA+ID4gPiA+ICsJCXZl
cmlmaWVyID0gTkZTX0RFTEVHQVRJT05fVkVSRjsNCj4gPiA+ID4gPiA+ID4gKwllbHNlDQo+ID4g
PiA+ID4gPiA+ICsJCXZlcmlmaWVyID0gbmZzX3NhdmVfY2hhbmdlX2F0dHJpYnV0ZShkaXIpOw0K
PiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ICAJbmZzX3NldHNlY3VyaXR5KGlub2RlLCBm
YXR0ciwgbGFiZWwpOw0KPiA+ID4gPiA+ID4gPiAgCW5mc19zZXRfdmVyaWZpZXIoZGVudHJ5LA0K
PiA+ID4gPiA+ID4gPiBuZnNfc2F2ZV9jaGFuZ2VfYXR0cmlidXRlKGRpcikpOw0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IE9vcHMhIFdoZW4gcmV2aWV3aW5nLCBJIG1pc3NlZCB0aGlzLiBTaG91bGRu
J3QgdGhlIGFib3ZlIGJlDQo+ID4gPiA+ID4gY2hhbmdlZA0KPiA+ID4gPiA+IHRvDQo+ID4gPiA+
ID4gbmZzX3NldF92ZXJpZmllcihkZW50cnksIHZlcmlmaWVyKSA/DQo+IA0KPiBVZ2gsIHllcC4N
Cj4gDQo+ID4gPiA+IC4uLmFuZCBvbiBhIHNpbWlsYXIgdmVpbjogbmZzX2xvb2t1cF9yZXZhbGlk
YXRlX2RlbGVnYXRlZCgpDQo+ID4gPiA+IG5lZWRzDQo+ID4gPiA+IHRvDQo+ID4gPiA+IGNoYW5n
ZSBzbyBhcyB0byBub3QgcmVzZXQgdGhlIHZlcmlmaWVyLi4uDQo+ID4gPiA+IA0KPiA+ID4gPiBT
b3JyeSBmb3Igbm90IGNhdGNoaW5nIHRoYXQgb25lIGVpdGhlci4NCj4gPiA+IA0KPiA+ID4gTm90
IG15IGRheS4uLg0KPiA+ID4gDQo+ID4gPiBuZnNfcHJpbWVfZGNhY2hlKCkgd2lsbCBjbG9iYmVy
IHRoZSB2ZXJpZmllciB0b28gaW4gdGhlDQo+ID4gPiBuZnNfc2FtZV9maWxlKCkNCj4gPiA+IGNh
c2UuIFRoYXQgb25lIGFsc28gbmVlZHMgdG8gc2V0IE5GU19ERUxFR0FUSU9OX1ZFUkYgaWYgdGhl
cmUgaXMNCj4gPiA+IGENCj4gPiA+IGRlbGVnYXRpb24uDQo+ID4gPiANCj4gPiA+IFBlcmhhcHMg
YWRkIGEgaGVscGVyIGZ1bmN0aW9uIGZvciB0aGF0ICsNCj4gPiA+IG5mc19sb29rdXBfcmV2YWxp
ZGF0ZV9kZW50cnkoKT8NCj4gPiANCj4gPiAuLi4uYW5kIGZpbmFsbHksIHdlIHNob3VsZCByZW1v
dmUgdGhlIGNhbGwgdG8gbmZzX3NldF92ZXJpZmllcigpDQo+ID4gZnJvbQ0KPiA+IG5mczRfZmls
ZV9vcGVuKCkuIEFzaWRlIGZyb20gYmVpbmcgaW5jb3JyZWN0IGluIHRoZSBjYXNlIHdoZXJlIHdl
DQo+ID4gdXNlZA0KPiA+IGFuIG9wZW4tYnktZmlsZWhhbmRsZSwgdGhhdCBjYXNlIGlzIHRha2Vu
IGNhcmUgb2YgaW4gdGhlIHByZWNlZGluZw0KPiA+IGRlbnRyeSByZXZhbGlkYXRpb24uDQo+IA0K
PiBPaywgSSdsbCBnZXQgdGhlc2UgZG9uZS4gIFRoaXMgZG9lc24ndCBtYWtlIHRoZSByZXZhbGlk
YXRpb24gY29kZQ0KPiBhbnkgc2ltcGxlci4gSSBhbSBpbXByZXNzZWQgdGhhdCB5b3UgY2FuIHNw
b3QgdGhlc2UgcHJvYmxlbXMganVzdA0KPiBkb2luZw0KPiByZXZpZXcuICBJIGRvIHdpc2ggd2Ug
Y291bGQgdXNlIGRfZnNkYXRhLCBzZWVtcyBsaWtlIGV4YWN0bHkgdGhlIGtpbmQNCj4gb2YgdGhp
bmcgd2UgbmVlZCBpdCBmb3IsIGJ1dCBpcyBpdCB3b3J0aCBpdCB0byBkbyBhbm90aGVyIGFsbG9j
YXRpb24NCj4gZXZlcnkNCj4gdGltZSB3ZSBuZWVkIGEgZGVudHJ5LiAgSSB3b25kZXIgaWYgd2Un
cmUgZ29pbmcgdG8gZW5kIHVwIGhhdmluZyBtb3JlDQo+IGNhc2VzIGxpa2UgdGhpcywgb3Igd2Fu
dCB0byBoYXZlIG1vcmUgcHJpdmF0ZSBpbmZvcm1hdGlvbiBwZXItZGVudHJ5Lg0KPiANCj4gUmln
aHQgbm93IGRfZnNkYXRhIGhvbGRzIHRoZSBkZXZpY2VuYW1lIGZvciBJU19ST09ULCBhbmQgY2Fj
aGVzIHRoZQ0KPiBhcHByb3ByaWF0ZSBpbmZvIGZvciBhIGRlbGF5ZWQgcmVtb3ZhbCBvZiBzaWxs
eS1yZW5hbWVkIGZpbGVzLg0KPiANCj4gUHJvYmxlbSBpcyB0aGF0IHdlIGRvbid0IGRyb3AgdGhl
IGRlbGVnYXRpb24gdW50aWwgYWZ0ZXIgY2FjaGluZyB0aGUNCj4gc2lsbHktcmVuYW1lIGRhdGEs
IGFuZCB0aGVuIHdlJ3JlIHN0aWxsIGRvaW5nIHRoZSBzYW1lIHNvcnRzIG9mDQo+IHRoaW5ncw0K
PiB0cnlpbmcgdG8gZmlndXJlIG91dCB3aGF0IGRhdGEgaXMgaW4gd2hpY2ggZGVudHJ5Lg0KPiAN
Cj4gTWF5YmUgQWwgd291bGQgYmUgd2lsbGluZyB0byByZXNlcnZlIHNvbWUgb2YgdGhlIHRvcCBv
ZiBkX2ZsYWdzIGZvcg0KPiBmaWxlc3lzdGVtcyB0byB1c2UgcHJpdmF0ZWx5Pw0KPiANCj4gQWws
IGNhbiB3ZSBoYXZlIHN1Y2g/ICBORlMgYWxyZWFkeSBoYXMgRENBQ0hFX05GU0ZTX1JFTkFNRUQs
IHRoYXQNCj4gY291bGQgbW92ZQ0KPiB1cCBhYm92ZSB0aGUgY29yZSBkX2ZsYWdzPw0KDQpJIGRp
ZCBsb29rIGludG8gdGhpcyBhIGZldyB3ZWVrcyBhZ28sIGFuZCBpdCBzZWVtZWQgdG8gbWUgdGhh
dCB3ZSdyZQ0KYWxyZWFkeSBsb3cgb24gZnJlZSBiaXRzIGluIGRfZmxhZ3MuDQoNCkFuIGFsdGVy
bmF0aXZlIG1pZ2h0IGp1c3QgYmUgdG8gcmVzZXJ2ZSBhIHdob2xlIGJpdCBpbiBkX3RpbWUgYXMg
YmVpbmcNCnRoZSAnZGVsZWdhdGVkIGRlbnRyeSByZXZhbGlkYXRlZCcgYml0LiBlLmcuIHJlc2Vy
dmUgYml0ICdCSVRTX1BFUl9MT05HDQotIDEnIChvciBqdXN0IGJpdCAnMCcpIGZvciB0aGF0IHB1
cnBvc2UuDQoNCldlIHdvdWxkIHRoZW4gd2FudCB0byBjaGFuZ2UgbmZzX3NldF92ZXJpZmllcigp
IHRvIHNldCB0aGUgdmVyaWZpZXIgaW4NCnRoZSByZW1haW5pbmcgYml0cywgYW5kIGhhdmUgaXQg
c2V0IHRoZSBkZWxlZ2F0ZWQgZGVudHJ5IHJldmFsaWRhdGVkDQpiaXQgZGVwZW5kaW5nIG9uIHdo
ZXRoZXIgdGhlcmUgaXMgYSBkZWxlZ2F0aW9uIGZvciB0aGUgaW5vZGUgYXQgdGhlDQp0aW1lIG9m
IHJldmFsaWRhdGlvbi4NCldlIG1heSBhbHNvIHdhbnQgdG8gZG8gdGhlIHNhbWUgc2V0dGluZyBv
ZiB0aGUgZGVsZWdhdGlvbiBiaXQgaW4NCm5mc192ZXJpZnlfY2hhbmdlX2F0dHJpYnV0ZSgpIHdo
ZW4gdGhlcmUgaXMgYSBzdWNjZXNzZnVsIG1hdGNoIG9mIHRoZQ0KcmVtYWluaW5nIHZlcmlmaWVy
Lg0KDQpGaW5hbGx5LCB3ZSBzaG91bGQgaGF2ZSBuZnNfbWFya19kZWxlZ2F0aW9uX3Jldm9rZWQo
KSBhbmQNCm5mc19zdGFydF9kZWxlZ2F0aW9uX3JldHVybl9sb2NrZWQoKSBjbGVhciB0aGF0IGRl
bGVnYXRlZCBkZW50cnkNCnJldmFsaWRhdGVkIGJpdCwgcGVyaGFwcyBieSBpdGVyYXRpbmcgb3Zl
ciB0aGUgaW5vZGUtPmlfZGVudHJ5IGxpc3Q/DQoNCk5vdGUgdGhhdCB0aGlzIGhhcyB0aGUgYWR2
YW50YWdlIHRoYXQgc2luY2UgdGhlIGFjdHVhbCB2ZXJpZmllciBwYXJ0IG9mDQpkZW50cnktPmRf
dGltZSBjYW4gYmUga2VwdCB1cCB0byBkYXRlIHdoaWxlIHdlIGhvbGQgdGhlIGRlbGVnYXRpb24s
IHdlDQpkb24ndCBoYXZlIHRvIHdvcnJ5IGFib3V0IHRoZSBkZW50cnkgZ2V0dGluZyByZXZhbGlk
YXRlZCBmb3Igbm8gcmVhc29uDQphZnRlciB0aGUgZGVsZWdhdGlvbiBpcyByZXR1cm5lZC4NCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
