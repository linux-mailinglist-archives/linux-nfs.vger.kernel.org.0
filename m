Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417BA1470E7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2020 19:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAWSiA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jan 2020 13:38:00 -0500
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:36110
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728205AbgAWSh7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 Jan 2020 13:37:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXPeNBQUO7mP4a5BVJPilg3Y/CX3B9GXGAHF/2LP5uqILTYCh9gr1SWffv882aWg9XFL1eWT427XbdCbODFjQTAVlT4v8Q1RZpy83gTcmP3c+o474dMDsK5Ur8jO+J1j3cXZy/yRMrtpTB/84wVza7YU+4/T7Ldv+5BeVRNHdb6q1VoPRdqFbhyYHI70s5z3CygV4MY7WQkXqV5XgXG/mwN/eDLf4PkMWVUNRyyjJ12FxBaZnCEgdJuVJzNitTmxBw5eS+ULeDpFJEqS7a1XoK+BRaBTGTVFERwcW2zal8dtReZclSrvjFTOBZ9S0QCjeBDED/7GERKysOR2QyaqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5fXZwkIBu8gJsOaUUQv2DSKkDZT49K27x2PazNXg8k=;
 b=IYvrcwZR5Ve3uSxKkqgXJwQ2g9Ja0/X1RvFrDKvJxt8xyuF9vqND+ol3f2gF3nQ+bDCh9W4cPgBjqFjRjjchdBI6ha4w+T/YQKO20irNfep/wsoNPytY4FXqUlRLRLXjHCLf/qqYHkWqsmnwYlOnDE5i/QhG8VGlt0aJU/kGYOvfh2r3g6L75fEQ+J6DSruInRy802Fq1ChyaCe3hKqNZP2crM1Oj/mtjts95JcvZGeAHWlI03Y+YJMaGkMoXP5ILjKDNOENvtyOZHk8dVMRFAeDyLHtWCqLHopB+noKWgf/5O948MSH4U5cjx2jHXfaJR4SWETwdBNA+N+5IRLCsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5fXZwkIBu8gJsOaUUQv2DSKkDZT49K27x2PazNXg8k=;
 b=Ts+gm1Ur7TU+5HwLz22nc8WyTkyCYejOb0r6QU7YaUeD9GEYAhJHekGdLbL+ukwGLyyPidnQnpm8eB4rPD0Ai9uimXPcOZbimPGy3sTlZUvwbOU97JqEBL7qTvHj/f+3zOS0IivzjCRu/tjA0TD96hBeh8XXTFOvbS0AICEgj+U=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1995.namprd13.prod.outlook.com (10.174.184.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.17; Thu, 23 Jan 2020 18:37:54 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2665.017; Thu, 23 Jan 2020
 18:37:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH RFC] nfs: optimise readdir cache page invalidation
Thread-Topic: [PATCH RFC] nfs: optimise readdir cache page invalidation
Thread-Index: AQHV0X6U5aSV8zhXw0mJsuFxO+G2sqf4lLYAgAAAvoA=
Date:   Thu, 23 Jan 2020 18:37:54 +0000
Message-ID: <e04a5d2e2ca57d932346d2372ec45ce32df84231.camel@hammerspace.com>
References: <20200122234853.101576-1-dai.ngo@oracle.com>
         <3a456c6e607700ee745b19d82481ec7193ca08eb.camel@hammerspace.com>
In-Reply-To: <3a456c6e607700ee745b19d82481ec7193ca08eb.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [63.235.104.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bf78cfd-2ad7-407a-daa2-08d7a0335c5f
x-ms-traffictypediagnostic: DM5PR1301MB1995:
x-microsoft-antispam-prvs: <DM5PR1301MB1995A9856A062782CE19FB50B80F0@DM5PR1301MB1995.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(8676002)(86362001)(478600001)(316002)(15974865002)(81166006)(6506007)(8936002)(81156014)(26005)(66446008)(186003)(6512007)(64756008)(76116006)(66476007)(66556008)(91956017)(6486002)(71200400001)(2906002)(2616005)(110136005)(36756003)(66946007)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1995;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkisL9TCbO17bbPbPXFM9TCAB9YwQmyWoSPWo6R09wqsrTz5z/8MhINwaDVL9IUgIeHhoIw5crQMb6rW9uaG3qO9jKBgYQePvH0ZN7lJWL6TR0dgWL+g5F5ctLvlDqvJvXOilKyWrBf/zKw8aFQgwnD5kBAEgVTRs8S5Lo0jel1E4+T6tdlAHfRa2QxAbcPIVVY0Muov2XNGaN7JJ/X7WzOaeow6jueutoQIWmZhqblXdhZoKWOGcrxgmqhzcdJtL/c/F5/CNR7GXtluQ22wbIheE2FaGOxGTO52R2ZRz1UbjPJW/dxdfoGX6cxIO6bww3U5nKFF7wrFOvHEktWYrEloQ9taWal2Yqcg129c5thXvl2l5wFvcMvMfdGMEBoLbCWbCdqJ+7lazRiGKCsfba6e4g8JYrzq4/jyzelTHfoidW1XDQ0dBGVnzCkHPGD+ubpCgmCL5/DrD1rCIno3qpbYyAc+cYdNenO3A4X1RjQ=
x-ms-exchange-antispam-messagedata: Cb9wl/ruZitc/Pxu2AGLqz75z+adtok8AaNVh89Mb4alv584Cm8IT5j6fGUpDYvKxG6+k82RoIBgIgUn3XMg2DZeZ+BhMJP4TRuEhqbGkxsu4SgXOcXzaDqStvmHXPwx+XTPYP7uAofIuY6rJm2ohw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F360C040E9495E4BB147F23E3D7F09F2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf78cfd-2ad7-407a-daa2-08d7a0335c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 18:37:54.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZVVx/DsCgLfQxyGZVP9c/5xSCmVUrD2LzBH2Fae/jDO4RePIEJhgTOq+0ZMTYhW/GqsSkOlMmy4poNSjzDXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1995
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTIzIGF0IDEwOjM1IC0wODAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFdlZCwgMjAyMC0wMS0yMiBhdCAxODo0OCAtMDUwMCwgRGFpIE5nbyB3cm90ZToNCj4g
PiBXaGVuIHRoZSBkaXJlY3RvcnkgaXMgbGFyZ2UgYW5kIGl0J3MgYmVpbmcgbW9kaWZpZWQgYnkg
b25lIGNsaWVudA0KPiA+IHdoaWxlIGFub3RoZXIgY2xpZW50IGlzIGRvaW5nIHRoZSAnbHMgLWwn
IG9uIHRoZSBzYW1lIGRpcmVjdG9yeQ0KPiA+IHRoZW4NCj4gPiB0aGUgY2FjaGUgcGFnZSBpbnZh
bGlkYXRpb24gZnJvbSBuZnNfZm9yY2VfdXNlX3JlYWRkaXJwbHVzIGNhdXNlcw0KPiA+IHRoZSBy
ZWFkaW5nIGNsaWVudCB0byBrZWVwIHJlc3RhcnRpbmcgUkVBRERJUlBMVVMgZnJvbSBjb29raWUg
MA0KPiA+IHdoaWNoIGNhdXNlcyB0aGUgJ2xzIC1sJyB0byB0YWtlIGEgdmVyeSBsb25nIHRpbWUg
dG8gY29tcGxldGUsDQo+ID4gcG9zc2libHkgbmV2ZXIgY29tcGxldGluZy4NCj4gPiANCj4gPiBD
dXJyZW50bHkgd2hlbiBuZnNfZm9yY2VfdXNlX3JlYWRkaXJwbHVzIGlzIGNhbGxlZCB0byBzd2l0
Y2ggZnJvbQ0KPiA+IFJFQURESVIgdG8gUkVBRERJUlBMVVMsIGl0IGludmFsaWRhdGVzIGFsbCB0
aGUgY2FjaGVkIHBhZ2VzIG9mIHRoZQ0KPiA+IGRpcmVjdG9yeS4gVGhpcyBjYWNoZSBwYWdlIGlu
dmFsaWRhdGlvbiBjYXVzZXMgdGhlIG5leHQgbmZzX3JlYWRkaXINCj4gPiB0byByZS1yZWFkIHRo
ZSBkaXJlY3RvcnkgY29udGVudCBmcm9tIGNvb2tpZSAwLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2gg
aXMgdG8gb3B0aW1pc2UgdGhlIGNhY2hlIGludmFsaWRhdGlvbiBpbg0KPiA+IG5mc19mb3JjZV91
c2VfcmVhZGRpcnBsdXMgYnkgb25seSB0cnVuY2F0aW5nIHRoZSBjYWNoZWQgcGFnZXMgZnJvbQ0K
PiA+IGxhc3QgcGFnZSBpbmRleCBhY2Nlc3NlZCB0byB0aGUgZW5kIHRoZSBmaWxlLiBJdCBhbHNv
IG1hcmtzIHRoZQ0KPiA+IGlub2RlIHRvIGRlbGF5IGludmFsaWRhdGluZyBhbGwgdGhlIGNhY2hl
ZCBwYWdlIG9mIHRoZSBkaXJlY3RvcnkNCj4gPiB1bnRpbCB0aGUgbmV4dCBpbml0aWFsIG5mc19y
ZWFkZGlyIG9mIHRoZSBuZXh0ICdscycgaW5zdGFuY2UuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFRyb25k
IE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCg0KU29ycnkgSSBp
bnRlbmRlZCB0aGlzIGZvciB0aGUgUEFUQ0h2Mi4uLiBJJ3ZlIGxvb2tlZCB0aHJvdWdoIHRoYXQN
CnZlcnNpb24gYW5kIGl0IGxvb2tzIE9LIHRvIG1lLg0KDQpBbm5hLCBwbGVhc2UgYXBwbHkgdGhl
IGxhdGVyIHYyIGluc3RlYWQgb2YgdGhpcyBvbmUuLi4NCg0KPiANCj4gPiAtLS0NCj4gPiAgZnMv
bmZzL2Rpci5jICAgICAgICAgICB8IDE0ICsrKysrKysrKysrKystDQo+ID4gIGluY2x1ZGUvbGlu
dXgvbmZzX2ZzLmggfCAgMyArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBi
L2ZzL25mcy9kaXIuYw0KPiA+IGluZGV4IGUxODAwMzNlMzVjZi4uM2ZiZjJlNDFkNTIzIDEwMDY0
NA0KPiA+IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiA+ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiA+IEBA
IC00MzcsNyArNDM3LDEwIEBAIHZvaWQgbmZzX2ZvcmNlX3VzZV9yZWFkZGlycGx1cyhzdHJ1Y3Qg
aW5vZGUNCj4gPiAqZGlyKQ0KPiA+ICAJaWYgKG5mc19zZXJ2ZXJfY2FwYWJsZShkaXIsIE5GU19D
QVBfUkVBRERJUlBMVVMpICYmDQo+ID4gIAkgICAgIWxpc3RfZW1wdHkoJm5mc2ktPm9wZW5fZmls
ZXMpKSB7DQo+ID4gIAkJc2V0X2JpdChORlNfSU5PX0FEVklTRV9SRFBMVVMsICZuZnNpLT5mbGFn
cyk7DQo+ID4gLQkJaW52YWxpZGF0ZV9tYXBwaW5nX3BhZ2VzKGRpci0+aV9tYXBwaW5nLCAwLCAt
MSk7DQo+ID4gKwkJbmZzX3phcF9tYXBwaW5nKGRpciwgZGlyLT5pX21hcHBpbmcpOw0KPiA+ICsJ
CWlmIChORlNfUFJPVE8oZGlyKS0+dmVyc2lvbiA9PSAzKQ0KPiA+ICsJCQlpbnZhbGlkYXRlX21h
cHBpbmdfcGFnZXMoZGlyLT5pX21hcHBpbmcsDQo+ID4gKwkJCQluZnNpLT5wYWdlX2luZGV4ICsg
MSwgLTEpOw0KPiA+ICAJfQ0KPiA+ICB9DQo+ID4gIA0KPiA+IEBAIC03MDksNiArNzEyLDkgQEAg
c3RydWN0IHBhZ2UNCj4gPiAqZ2V0X2NhY2hlX3BhZ2UobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90
ICpkZXNjKQ0KPiA+ICBpbnQgZmluZF9jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3Jf
dCAqZGVzYykNCj4gPiAgew0KPiA+ICAJaW50IHJlczsNCj4gPiArCXN0cnVjdCBpbm9kZSAqaW5v
ZGU7DQo+ID4gKwlzdHJ1Y3QgbmZzX2lub2RlICpuZnNpOw0KPiA+ICsJc3RydWN0IGRlbnRyeSAq
ZGVudHJ5Ow0KPiA+ICANCj4gPiAgCWRlc2MtPnBhZ2UgPSBnZXRfY2FjaGVfcGFnZShkZXNjKTsN
Cj4gPiAgCWlmIChJU19FUlIoZGVzYy0+cGFnZSkpDQo+ID4gQEAgLTcxNyw2ICs3MjMsMTIgQEAg
aW50IGZpbmRfY2FjaGVfcGFnZShuZnNfcmVhZGRpcl9kZXNjcmlwdG9yX3QNCj4gPiAqZGVzYykN
Cj4gPiAgCXJlcyA9IG5mc19yZWFkZGlyX3NlYXJjaF9hcnJheShkZXNjKTsNCj4gPiAgCWlmIChy
ZXMgIT0gMCkNCj4gPiAgCQljYWNoZV9wYWdlX3JlbGVhc2UoZGVzYyk7DQo+ID4gKw0KPiA+ICsJ
ZGVudHJ5ID0gZmlsZV9kZW50cnkoZGVzYy0+ZmlsZSk7DQo+ID4gKwlpbm9kZSA9IGRfaW5vZGUo
ZGVudHJ5KTsNCj4gPiArCW5mc2kgPSBORlNfSShpbm9kZSk7DQo+ID4gKwluZnNpLT5wYWdlX2lu
ZGV4ID0gZGVzYy0+cGFnZV9pbmRleDsNCj4gPiArDQo+ID4gIAlyZXR1cm4gcmVzOw0KPiA+ICB9
DQo+ID4gIA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oIGIvaW5jbHVk
ZS9saW51eC9uZnNfZnMuaA0KPiA+IGluZGV4IGMwNmIxZmQxMzBmMy4uYTVmOGYwM2VjZDU5IDEw
MDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbmZzX2ZzLmgNCj4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L25mc19mcy5oDQo+ID4gQEAgLTE2OCw2ICsxNjgsOSBAQCBzdHJ1Y3QgbmZzX2lub2Rl
IHsNCj4gPiAgCXN0cnVjdCByd19zZW1hcGhvcmUJcm1kaXJfc2VtOw0KPiA+ICAJc3RydWN0IG11
dGV4CQljb21taXRfbXV0ZXg7DQo+ID4gIA0KPiA+ICsJLyogdHJhY2sgbGFzdCBhY2Nlc3MgdG8g
Y2FjaGVkIHBhZ2VzICovDQo+ID4gKwl1bnNpZ25lZCBsb25nCQlwYWdlX2luZGV4Ow0KPiA+ICsN
Cj4gPiAgI2lmIElTX0VOQUJMRUQoQ09ORklHX05GU19WNCkNCj4gPiAgCXN0cnVjdCBuZnM0X2Nh
Y2hlZF9hY2wJKm5mczRfYWNsOw0KPiA+ICAgICAgICAgIC8qIE5GU3Y0IHN0YXRlICovDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KQ1RPLCBIYW1tZXJzcGFjZSBJbmMNCjQzMDAgRWwgQ2FtaW5vIFJl
YWwsIFN1aXRlIDEwNQ0KTG9zIEFsdG9zLCBDQSA5NDAyMg0Kd3d3LmhhbW1lci5zcGFjZQ0KDQoN
Cg==
