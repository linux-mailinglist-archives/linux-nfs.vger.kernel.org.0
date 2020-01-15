Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B313CC9F
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2020 19:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAOSyX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jan 2020 13:54:23 -0500
Received: from mail-eopbgr680104.outbound.protection.outlook.com ([40.107.68.104]:31968
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728904AbgAOSyX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 Jan 2020 13:54:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrUaGRzj672HtDBkbiqYGRnAggU/0DtS2tcL8x+WMzJjCd2D9B+KucT+/mZrIgIR8HZwnRTWRlHh8WvmMrPWBXHn718eFIIjoHaWLW3XZlepmvGiwWlwPsbJ+qqXp/97p0MGIjGJzKDhsVB2fv0QkyfTIJ6LsGT3D+4q1qHd1RgMRWLB+/tE60qIhQ/zdI5UQsD32oX2KwISHfQTx57n3rvWtTU8f1hZ/LeNkzKuki++wVU18E0bjY190zjjbv2nul/sYtfm6VL6d8AxzqC33JVBncvlgXJBFWnj0CmlEz/WS/uThM/nZKLOmclSG8R6UwATccEfzYgHXt5d0bhfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvkIMayQ62j3u9UYx3euKnpx59VqCh7IFbKNvDfcuUY=;
 b=Jm1k9m6rVsI5FzcLffoxnG1Ze7wasZbFKUkq6D74RqBun5BFLC+9ywtAKH3vq52ZLwQV+fO9tN2x510uUjBhZ/O1F8G+tiGIqvHFk1vwixoQVB8QGzI60YWvlColaVWcGDVXPt89D9x+1EBe+s53Knmrkf88GDqIvy5AgAbWKyzhmY0PKDExswv2NVo/YYw2cVf/NzTuYp1rcyXyQvchPmq++goanMapg4P5No656d05czUyORCdYv8t6sL7fgbnvhVWGQ3FjC5nbc1RRU7OJWHPRaCPtSRPzSVpNcBplCrgpDJu0mi3s1YBtz/hhdX2Gx0Gr5CUUrIj8i/FPHJosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvkIMayQ62j3u9UYx3euKnpx59VqCh7IFbKNvDfcuUY=;
 b=bd5twRa+Am20tnPylfgyuGrnkNzILN3YYR/byFTEAUyIkH/HXK/R5DPoIFSAAQQCyRTDARlPv66NUecYsY7H+8BzYDq+/2r6Sbo8ZUBzI+xp92CWa2kFOLHMWaJ1NgNH4lSb4wumRFi2liATH9wk7wRNWlG9cXoKgdtONSj4ztE=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2028.namprd13.prod.outlook.com (10.174.182.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Wed, 15 Jan 2020 18:54:15 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 18:54:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: 'ls -lrt' performance issue on large dir while dir is being
 modified
Thread-Topic: 'ls -lrt' performance issue on large dir while dir is being
 modified
Thread-Index: AQHVtTrg9UEu5xyd+UCr2UuPhZ9qAafCacsAgCnKFQCAAAwFgA==
Date:   Wed, 15 Jan 2020 18:54:15 +0000
Message-ID: <9fdf37ffe4b3f7016a60e3a61c2087a825348b28.camel@hammerspace.com>
References: <e04baa28-2460-4ced-e387-618ea32d827c@oracle.com>
         <a41af3d6-8280-e315-fb65-a9285bad50ec@oracle.com>
         <770937d3-9439-db4a-1f6e-59a59f2c08b9@oracle.com>
In-Reply-To: <770937d3-9439-db4a-1f6e-59a59f2c08b9@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e6b3788-5038-4a9f-2f35-08d799ec514f
x-ms-traffictypediagnostic: DM5PR1301MB2028:
x-microsoft-antispam-prvs: <DM5PR1301MB20289B52FA2952C2C463DB95B8370@DM5PR1301MB2028.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(199004)(189003)(91956017)(2906002)(66946007)(66476007)(2616005)(66446008)(76116006)(64756008)(186003)(66556008)(6512007)(5660300002)(110136005)(8936002)(81166006)(26005)(81156014)(508600001)(4326008)(8676002)(6486002)(86362001)(71200400001)(6506007)(53546011)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2028;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJ+086NLTroZRkleHNXFdhY8irAUuTyLZW+g27mv+ig3hwJZAWaCoTGuhusfx4tMeHnyUlmO8MQH8lHhZBcoIt/uxifxZ1nhDTiow3DKV0JhurzT5soC4ECIu5MFCn2y7GxN7Y9CKviLye16EpMG53NYg6bQPVw1pv1dLoglLJZdAUEsBdwJhKiexdtDVaW2YR4SDfeubnJqzRT6X88GOVYmOd8jUYrr4+B61kKcpMxp7AynIKi4rtjb3uQ+IcZTIYO81PL+1NJbXJjhtAmcGpZaxwTgZ09y1TFU7h2jIP9p6U+VR9k+BhY1it8GiVQISeameukUL/bBzqpiIalVhXOqBtR+D8dJle5FhYQZSK9aGtm9+Dwn7JILYYep/fUYfQySzDbppJPXEoSSKxt05oFvGl7cpSaLRykSuibWK5nXvOoqKS8UFGA5SMjlJvaQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6013B36BDA57F44B80F688403AB0F552@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6b3788-5038-4a9f-2f35-08d799ec514f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 18:54:15.1230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1GOsh5aJzHzjFl/Tk57TnE2E9KF+KcfLsU7/sk/F2zR4XJgSJV4GNSc9+8eP5xPjdikBmS0yjQsLCvZEN4U7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2028
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTE1IGF0IDEwOjExIC0wODAwLCBEYWkgTmdvIHdyb3RlOg0KPiBIaSBB
bm5hLCBUcm9uZCwNCj4gDQo+IFdvdWxkIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgeW91ciBvcGlu
aW9uIHJlZ2FyZGluZyByZXZlcnRpbmcgdGhlDQo+IGNoYW5nZSBpbg0KPiBuZnNfZm9yY2VfdXNl
X3JlYWRkaXJwbHVzIHRvIGNhbGwgbmZzX3phcF9tYXBwaW5nIGluc3RlYWQgb2YNCj4gaW52YWxp
ZGF0ZV9tYXBwaW5nX3BhZ2VzLg0KPiBUaGlzIGNoYW5nZSBpcyB0byBwcmV2ZW50IHRoZSBjb29r
aWUgb2YgdGhlIFJFQURESVJQTFVTIHRvIGJlIHJlc2V0DQo+IHRvIDAgd2hpbGUNCj4gYW4gaW5z
dGFuY2Ugb2YgJ2xzJyBpcyBydW5uaW5nIGFuZCB0aGUgZGlyZWN0b3J5IGlzIGJlaW5nIG1vZGlm
aWVkLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rpci5jIGIvZnMvbmZzL2Rpci5jIGlu
ZGV4IA0KPiA+IGE3M2UyZjhiZDhlYy4uNWQ0YTY0NTU1ZmE3IDEwMDY0NCAtLS0gYS9mcy9uZnMv
ZGlyLmMgKysrIA0KPiA+IGIvZnMvbmZzL2Rpci5jIEBAIC00NDQsNyArNDQ0LDcgQEAgdm9pZCAN
Cj4gPiBuZnNfZm9yY2VfdXNlX3JlYWRkaXJwbHVzKHN0cnVjdCBpbm9kZSAqZGlyKSAgICAgIGlm
IA0KPiA+IChuZnNfc2VydmVyX2NhcGFibGUoZGlyLCBORlNfQ0FQX1JFQURESVJQTFVTKSAmJiAg
ICAgICAgICANCj4gPiAhbGlzdF9lbXB0eSgmbmZzaS0+b3Blbl9maWxlcykpIHsgICAgICAgICAg
DQo+ID4gc2V0X2JpdChORlNfSU5PX0FEVklTRV9SRFBMVVMsICZuZnNpLT5mbGFncyk7IC0gICAg
ICAgIA0KPiA+IGludmFsaWRhdGVfbWFwcGluZ19wYWdlcyhkaXItPmlfbWFwcGluZywgMCwgLTEp
OyArICAgICAgICANCj4gPiBuZnNfemFwX21hcHBpbmcoZGlyLCBkaXItPmlfbWFwcGluZyk7ICAg
ICAgfSAgfSANCj4gDQo+IFRoYW5rcywNCj4gLURhaQ0KPiANCj4gT24gMTIvMTkvMTkgODowMSBQ
TSwgRGFpIE5nbyB3cm90ZToNCj4gPiBIaSBBbm5hLCBUcm9uZCwNCj4gPiANCj4gPiBJIG1hZGUg
YSBtaXN0YWtlIHdpdGggdGhlIDUuNSBudW1iZXJzLiBUaGUgVk0gdGhhdCBydW5zIDUuNSBoYXMN
Cj4gPiBzb21lDQo+ID4gcHJvYmxlbXMuIFRoZXJlIGlzIG5vIHJlZ3Jlc3Npb24gd2l0aCA1LjUs
IGhlcmUgYXJlIHRoZSBuZXcNCj4gPiBudW1iZXJzOg0KPiA+IA0KPiA+IFVwc3RyZWFtIExpbnV4
IDUuNS4wLXJjMSBbT1JJXSA5MzI5NjogM20xMC45MTdzICAxOTc4OTE6IDEwbTM1Ljc4OXMNCj4g
PiBVcHN0cmVhbSBMaW51eCA1LjUuMC1yYzEgW01PRF0gOTg2MTQ6IDFtNTkuNjQ5cyAgMTkyODAx
OiAzbTU1LjAwM3MNCj4gPiANCj4gPiBNeSBhcG9sb2dpZXMgZm9yIHRoZSBtaXN0YWtlLg0KPiA+
IA0KPiA+IE5vdyB0aGVyZSBpcyBubyByZWdyZXNzaW9uIHdpdGggNS41LCBJJ2QgbGlrZSB0byBn
ZXQgeW91ciBvcGluaW9uDQo+ID4gcmVnYXJkaW5nIHRoZSBjaGFuZ2UgdG8gcmV2ZXJ0IHRoZSBj
YWxsIGZyb20NCj4gPiBpbnZhbGlkYXRlX21hcHBpbmdfcGFnZXMNCj4gPiB0byBuZnNfemFwX21h
cHBpbmcgaW4gbmZzX2ZvcmNlX3VzZV9yZWFkZGlycGx1cyB0byBwcmV2ZW50IHRoZQ0KPiA+IGN1
cnJlbnQgJ2xzJyBmcm9tIHJlc3RhcnRpbmcgdGhlIFJFQURESVJQTFVTMyBmcm9tIGNvb2tpZSAw
LiBJJ20NCj4gPiBub3QgcXVpdGUgc3VyZSBhYm91dCB0aGUgaW50ZW50aW9uIG9mIHRoZSBwcmlv
ciBjaGFuZ2UgZnJvbQ0KPiA+IG5mc196YXBfbWFwcGluZyB0byBpbnZhbGlkYXRlX21hcHBpbmdf
cGFnZXMgc28gdGhhdCBpcyB3aHkgSSdtDQo+ID4gc2Vla2luZyBhZHZpc2UuIE9yIGRvIHlvdSBo
YXZlIGFueSBzdWdnZXN0aW9ucyB0byBhY2hpZXZlIHRoZSBzYW1lPw0KPiA+IA0KPiA+IFRoYW5r
cywNCj4gPiAtRGFpDQo+ID4gDQo+ID4gT24gMTIvMTcvMTkgNDozNCBQTSwgRGFpIE5nbyB3cm90
ZToNCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBJJ2QgbGlrZSB0byByZXBvcnQgYW4gaXNzdWUg
d2l0aCAnbHMgLWxydCcgb24gTkZTdjMgY2xpZW50IHRha2VzDQo+ID4gPiBhIHZlcnkgbG9uZyB0
aW1lIHRvIGRpc3BsYXkgdGhlIGNvbnRlbnQgb2YgYSBsYXJnZSBkaXJlY3RvcnkNCj4gPiA+ICgx
MDBrIC0gMjAwayBmaWxlcykgd2hpbGUgdGhlIGRpcmVjdG9yeSBpcyBiZWluZyBtb2RpZmllZCBi
eQ0KPiA+ID4gYW5vdGhlciBORlN2MyBjbGllbnQuDQo+ID4gPiANCj4gPiA+IFRoZSBwcm9ibGVt
IGNhbiBiZSByZXByb2R1Y2VkIHVzaW5nIDMgc3lzdGVtcy4gT25lIHN5c3RlbSBzZXJ2ZXMNCj4g
PiA+IGFzIHRoZSBORlMgc2VydmVyLCBvbmUgc3lzdGVtIHJ1bnMgYXMgdGhlIGNsaWVudCB0aGF0
IGRvaW5nIHRoZQ0KPiA+ID4gJ2xzIC1scnQnIGFuZCBhbm90aGVyIHN5c3RlbSBydW5zIHRoZSBj
bGllbnQgdGhhdCBjcmVhdGVzIGZpbGVzDQo+ID4gPiBvbiB0aGUgc2VydmVyLg0KPiA+ID4gICAg
IENsaWVudDEgY3JlYXRlcyBmaWxlcyB1c2luZyB0aGlzIHNpbXBsZSBzY3JpcHQ6DQo+ID4gPiAN
Cj4gPiA+ID4gIyEvYmluL3NoDQo+ID4gPiA+IA0KPiA+ID4gPiBpZiBbICQjIC1sdCAyIF07IHRo
ZW4NCj4gPiA+ID4gICAgICAgICBlY2hvICJVc2FnZTogJDAgbnVtYmVyX29mX2ZpbGVzIGJhc2Vf
ZmlsZW5hbWUiDQo+ID4gPiA+ICAgICAgICAgZXhpdA0KPiA+ID4gPiBmaSAgICBuZmlsZXM9JDEN
Cj4gPiA+ID4gZm5hbWU9JDINCj4gPiA+ID4gZWNobyAiY3JlYXRpbmcgJG5maWxlcyBmaWxlcyB1
c2luZyBmaWxlbmFtZVskZm5hbWVdLi4uIg0KPiA+ID4gPiBpPTAgICAgICAgICB3aGlsZSBbIGkg
LWx0ICRuZmlsZXMgXSA7DQo+ID4gPiA+IGRvICAgICAgICAgICAgaT1gZXhwciAkaSArIDFgDQo+
ID4gPiA+ICAgICAgICAgZWNobyAieHl6IiA+ICRmbmFtZSRpDQo+ID4gPiA+ICAgICAgICAgZWNo
byAiJGZuYW1lJGkiIGRvbmUNCj4gPiA+IA0KPiA+ID4gQ2xpZW50MiBydW5zICd0aW1lIGxzIC1s
cnQgL3RtcC9tbnQvYmQxIHx3YyAtbCcgaW4gYSBsb29wLg0KPiA+ID4gDQo+ID4gPiBUaGUgbmV0
d29yayB0cmFjZXMgYW5kIGR0cmFjZSBwcm9iZXMgc2hvd2VkIG51bWVyb3VzIFJFQURESVJQTFVT
Mw0KPiA+ID4gcmVxdWVzdHMgcmVzdGFydGluZyAgZnJvbSBjb29raWUgMCB3aGljaCBzZWVtZWQg
dG8gaW5kaWNhdGUgdGhlDQo+ID4gPiBjYWNoZWQgcGFnZXMgb2YgdGhlIGRpcmVjdG9yeSB3ZXJl
IGludmFsaWRhdGVkIGNhdXNpbmcgdGhlIHBhZ2VzDQo+ID4gPiB0byBiZSByZWZpbGxlZCBzdGFy
dGluZyBmcm9tIGNvb2tpZSAwIHVudGlsIHRoZSBjdXJyZW50IHJlcXVlc3RlZA0KPiA+ID4gY29v
a2llLiAgVGhlIGNhY2hlZCBwYWdlIGludmFsaWRhdGlvbiB3ZXJlIHRyYWNrZWQgdG8NCj4gPiA+
IG5mc19mb3JjZV91c2VfcmVhZGRpcnBsdXMoKS4gIFRvIHZlcmlmeSwgSSBtYWRlIHRoZSBiZWxv
dw0KPiA+ID4gbW9kaWZpY2F0aW9uLCByYW4gdGhlIHRlc3QgZm9yIHZhcmlvdXMga2VybmVsIHZl
cnNpb25zIGFuZA0KPiA+ID4gY2FwdHVyZWQgdGhlIHJlc3VsdHMgc2hvd24gYmVsb3cuDQo+ID4g
PiANCj4gPiA+IFRoZSBtb2RpZmljYXRpb24gaXM6DQo+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYw0KPiA+ID4gPiBpbmRleCBhNzNlMmY4YmQ4
ZWMuLjVkNGE2NDU1NWZhNyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZnMvbmZzL2Rpci5jDQo+ID4g
PiA+ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiA+ID4gPiBAQCAtNDQ0LDcgKzQ0NCw3IEBAIHZvaWQg
bmZzX2ZvcmNlX3VzZV9yZWFkZGlycGx1cyhzdHJ1Y3QgaW5vZGUNCj4gPiA+ID4gKmRpcikNCj4g
PiA+ID4gICAgICBpZiAobmZzX3NlcnZlcl9jYXBhYmxlKGRpciwgTkZTX0NBUF9SRUFERElSUExV
UykgJiYNCj4gPiA+ID4gICAgICAgICAgIWxpc3RfZW1wdHkoJm5mc2ktPm9wZW5fZmlsZXMpKSB7
DQo+ID4gPiA+ICAgICAgICAgIHNldF9iaXQoTkZTX0lOT19BRFZJU0VfUkRQTFVTLCAmbmZzaS0+
ZmxhZ3MpOw0KPiA+ID4gPiAtICAgICAgICBpbnZhbGlkYXRlX21hcHBpbmdfcGFnZXMoZGlyLT5p
X21hcHBpbmcsIDAsIC0xKTsNCj4gPiA+ID4gKyAgICAgICAgbmZzX3phcF9tYXBwaW5nKGRpciwg
ZGlyLT5pX21hcHBpbmcpOw0KPiA+ID4gPiAgICAgIH0NCj4gPiA+ID4gIH0NCg0KVGhpcyBjaGFu
Z2UgaXMgb25seSByZXZlcnRpbmcgcGFydCBvZiBjb21taXQgNzlmNjg3YTNkZTllLiBNeSBwcm9i
bGVtDQp3aXRoIHRoYXQgaXMgYXMgZm9sbG93czoNCg0KUkZDMTgxMyBzdGF0ZXMgdGhhdCBORlN2
MyBSRUFERElSUExVUyBjb29raWVzIGFuZCB2ZXJpZmllcnMgbXVzdCBtYXRjaA0KdGhvc2UgcmV0
dXJuZWQgYnkgcHJldmlvdXMgUkVBRERJUlBMVVMgY2FsbHMsIGFuZCBSRUFERElSIGNvb2tpZXMg
YW5kDQp2ZXJpZmllcnMgbXVzdCBtYXRjaCB0aG9zZSByZXR1cm5lZCBieSBwcmV2aW91cyBSRUFE
RElSIGNhbGxzLiBJdCBzYXlzDQpub3RoaW5nIGFib3V0IGJlaW5nIGFibGUgdG8gYXNzdW1lIGNv
b2tpZXMgZnJvbSBSRUFERElSIGFuZCBSRUFERElSUExVUw0KY2FsbHMgYXJlIGludGVyY2hhbmdl
YWJsZS4gU28gdGhlIG9ubHkgcmVhc29uIEkgY2FuIHNlZSBmb3IgdGhlDQppbnZhbGlkYXRlX21h
cHBpbmdfcGFnZXMoKSBpcyB0byBlbnN1cmUgdGhhdCB3ZSBkbyBzZXBhcmF0ZSB0aGUgdHdvDQpj
b29raWUgY2FjaGVzLg0KDQpPVE9ILCBmb3IgTkZTdjQsIHRoZXJlIGlzIG5vIHNlcGFyYXRlIFJF
QURESVJQTFVTIGZ1bmN0aW9uLCBzbyB0aGVyZQ0KcmVhbGx5IGRvZXMgbm90IGFwcGVhciB0byBi
ZSBhbnkgcmVhc29uIHRvIGNsZWFyIHRoZSBwYWdlIGNhY2hlIGF0IGFsbA0KYXMgd2UncmUgc3dp
dGNoaW5nIGJldHdlZW4gcmVxdWVzdGluZyBhdHRyaWJ1dGVzIG9yIG5vdC4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
