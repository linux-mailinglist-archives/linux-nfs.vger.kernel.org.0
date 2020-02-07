Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52554155940
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2020 15:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgBGOZc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Feb 2020 09:25:32 -0500
Received: from mail-bn7nam10on2123.outbound.protection.outlook.com ([40.107.92.123]:63774
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbgBGOZb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 7 Feb 2020 09:25:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYJRB6VPpmhrDcu5hDQbFyNnbG5ztDmUoNjjiQ+mtEM02sXV02F85jeiRIVkpFwGjiMAqy+b2uA3SQBGs790m3k0Z+mqU5HH/DIg8NkiG2oa5u2Gcz7Cno2zh5dvFtgR+WgmMQjomErRBSCZWTCPVgAnDkBdqZOmpWjBShlJtxHD7185ZepJVwfDTaS1hz+hh4M0KZ9UimXKk3FC+ldyG8UgjTxTcMmA+cMv1KkOPIpAFI77E4hSSWsD6gf6OwDPXSJeEEL/y7/GXNjPtVRf9iY7P2ZaxUvQPo9g4XPYcv7gOcQbpw9YOqCFrN3mCD0x3cFEJLhiYlwWksxEuDYL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl9NJqoYYqmd7DPqXbLUgpPLkSH4S6E/Okeu5arYkdc=;
 b=DhOr2fXlI+N5H4AKits1/pkw3hwgmi07Hrmf4V2uGq6zfxWNP/mJ5YM/Wlc+JdcYaZyrs8ZPtzgOuEtGoIpmISGQX7CCNc2WuUNq1hS5OSVD314WXRlbO1fHtefB5BUm9V3pGV0IxL8uWVez4bLVcf9itkXgPj6R/WCLEUGwMqGyCvHBPhHRbdjU9+zm22lCu31RnLdqLHLW54YSQMFpX4svQIAhvr33iX1/UQsGRJbX+P+zzOLBlwCJBSypFuU6hbgOxkxYHMVa7he0+BLBmKlW/DLHP9LvlRx1SkE+bCFNIwuOF9ukBtOHEI0fpIcbMq9xOLIyOxWe6SN2AWvQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl9NJqoYYqmd7DPqXbLUgpPLkSH4S6E/Okeu5arYkdc=;
 b=fiLIIWNwGE5Vnr6KeYJUeXwigJMdMWhbhFDVyaCUVPxPnU047ePvGXuwfMi2+NHHFRFWntzRnOeRUlrHl8DYyF6fHY8oLKdlXQ4avwdszbjEc4IIoDRGMaohPsdUEhlsZOrx3LHScXmWJqhvLNewT00/tQ93Ic31l+XDwuvm9tg=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2044.namprd13.prod.outlook.com (10.174.186.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.15; Fri, 7 Feb 2020 14:25:28 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 14:25:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Thread-Topic: [PATCH] SUNRPC/cache: Allow garbage collection of invalid cache
 entries
Thread-Index: AQHVyvwJPYRIWp4ZtEelpB+N9lu4ZqgOgFIAgAFulwA=
Date:   Fri, 7 Feb 2020 14:25:27 +0000
Message-ID: <8dc1ed17de98e4b59fb9e408692c152456863a20.camel@hammerspace.com>
References: <20200114165738.922961-1-trond.myklebust@hammerspace.com>
         <20200206163322.GB2244@fieldses.org>
In-Reply-To: <20200206163322.GB2244@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d241c756-3764-4421-4bd9-08d7abd99448
x-ms-traffictypediagnostic: DM5PR1301MB2044:
x-microsoft-antispam-prvs: <DM5PR1301MB20446689A919786C1F12B51AB81C0@DM5PR1301MB2044.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39840400004)(136003)(376002)(366004)(199004)(189003)(36756003)(478600001)(81166006)(81156014)(8676002)(71200400001)(4326008)(8936002)(2906002)(6512007)(6486002)(54906003)(186003)(26005)(316002)(66946007)(66446008)(91956017)(76116006)(66476007)(66556008)(64756008)(86362001)(2616005)(5660300002)(6506007)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2044;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jt8eeZ3imb//D/3QZ2O1DRoRgxWzCCa7BY+jTm2eX29b3IySlsBwmqXK8gRpea+UuqX/wqQL6RaYd+h4Az6D7AmZxVjQN4E8wT/Z13jZLHn44AEya68EHp87z3K7w83AA6ujH4X3TkvQdnLcIBBL77nnL9y/kMpeF3bucdvYoBpFPxxVhfX+5uPJ/mcLC6XxGlBz0bJtrinKdvesrxAR/dRgRMjL//eS2No+ZndSS1deY8SogrhKFAAsToLnQRdvdSpFZnFV8FTTeqnDnVwe055l/gUJ/s2sBadq8HdJCCAs8zARFDfUm0OxZipZ1oj4k9s/eoQtbJ5USYCX6eF6TgGhoefyZIUSChaiKgTYD5zJUC4f7Sb4FGS8a2pX8LPMcL5UtrQtCfqFdrTv87EGuXcqwWAvOWZCoTQj3+u13QGEimrbEZ1CKUYQi3QV9Jeg
x-ms-exchange-antispam-messagedata: F3ImBC/iJuChoTYBFF8/jkfPoD2XcaSDX0iYi6W8MesdRcOOweqq8yU3iPQX9eOgIk1If+bSiPShoIapgCIyjP4feJFtngdcboEMepSYQnJYqU1Af7FaIjUnoxLvA8QuJu2mLpVjKOc6cbDDLfqTjQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2322DD220E199F40A106AE46482905E2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d241c756-3764-4421-4bd9-08d7abd99448
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 14:25:27.9124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wII5AopgldjB5bKq6V+Mc6v0cRHTudkBt4C9k4CqMRXr20gEwk2R9sYfIHHaGwzC16ahuyy4s5krW3guWZLuyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2044
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTA2IGF0IDExOjMzIC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgSmFuIDE0LCAyMDIwIGF0IDExOjU3OjM4QU0gLTA1MDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBJZiB0aGUgY2FjaGUgZW50cnkgbmV2ZXIgZ2V0cyBpbml0aWFsaXNl
ZCwgd2Ugd2FudCB0aGUgZ2FyYmFnZQ0KPiA+IGNvbGxlY3RvciB0byBiZSBhYmxlIHRvIGV2aWN0
IGl0LiBPdGhlcndpc2UgaWYgdGhlIHVwY2FsbCBkYWVtb24NCj4gPiBmYWlscyB0byBpbml0aWFs
aXNlIHRoZSBlbnRyeSwgd2UgZW5kIHVwIG5ldmVyIGV4cGlyaW5nIGl0Lg0KPiANCj4gQ291bGQg
eW91IHRlbGwgdXMgbW9yZSBhYm91dCB3aGF0IG1vdGl2YXRlZCB0aGlzPw0KPiANCj4gSXQncyBj
YXVzaW5nIGZhaWx1cmVzIG9uIHB5bmZzIHNlcnZlci1yZWJvb3QgdGVzdHMuICBJIGhhdmVuJ3Qg
cGlubmVkDQo+IGRvd24gdGhlIGNhdXNlIHlldCwgYnV0IGl0IGxvb2tzIGxpa2UgaXQgY291bGQg
YmUgYSByZWdyZXNzaW9uIHRvIHRoZQ0KPiBiZWhhdmlvciBLaW5nbG9uZyBNZWUgZGVzY3JpYmVz
IGluIGRldGFpbCBpbiBoaXMgb3JpZ2luYWwgcGF0Y2guDQo+IA0KDQpDYW4geW91IHBvaW50IG1l
IHRvIHRoZSB0ZXN0cyB0aGF0IGFyZSBmYWlsaW5nPw0KDQpUaGUgbW90aXZhdGlvbiBoZXJlIGlz
IHRvIGFsbG93IHRoZSBnYXJiYWdlIGNvbGxlY3RvciB0byBkbyBpdHMgam9iIG9mDQpldmljdGlu
ZyBjYWNoZSBlbnRyaWVzIGFmdGVyIHRoZXkgYXJlIHN1cHBvc2VkIHRvIGhhdmUgdGltZWQgb3V0
LiBUaGUNCmZhY3QgdGhhdCB1bmluaXRpYWxpc2VkIGNhY2hlIGVudHJpZXMgYXJlIGdpdmVuIGFu
IGluZmluaXRlIGxpZmV0aW1lLA0KYW5kIGFyZSBuZXZlciBldmljdGVkIGlzIGEgZGUgZmFjdG8g
bWVtb3J5IGxlYWsgaWYsIGZvciBpbnN0YW5jZSwgdGhlDQptb3VudGQgZGFlbW9uIGlnbm9yZXMg
dGhlIGNhY2hlIHJlcXVlc3QsIG9yIHRoZSBkb3duY2FsbCBpbg0KZXhwa2V5X3BhcnNlKCkgb3Ig
c3ZjX2V4cG9ydF9wYXJzZSgpIGZhaWxzIHdpdGhvdXQgYmVpbmcgYWJsZSB0byB1cGRhdGUNCnRo
ZSByZXF1ZXN0Lg0KDQpUaGUgdGhyZWFkcyB0aGF0IGFyZSB3YWl0aW5nIGZvciB0aGUgY2FjaGUg
cmVwbGllcyBhbHJlYWR5IGhhdmUgYQ0KbWVjaGFuaXNtIGZvciBkZWFsaW5nIHdpdGggdGltZW91
dHMgKHdpdGggY2FjaGVfd2FpdF9yZXEoKSBhbmQgZGVmZXJyZWQNCnJlcXVlc3RzKSwgc28gdGhl
IHF1ZXN0aW9uIGlzIHdoYXQgaXMgc28gc3BlY2lhbCBhYm91dCB1bmluaXRpYWxpc2VkDQpyZXF1
ZXN0cyB0aGF0IHdlIGhhdmUgdG8gbGVhayB0aGVtIGluIG9yZGVyIHRvIGF2b2lkIGEgcHJvYmxl
bSB3aXRoDQpyZWJvb3Q/DQoNCj4gRHJvcHBpbmcgZm9yIHRoZSB0aW1lIGJlaW5nLg0KPiANCj4g
LS1iLg0KPiANCj4gPiBGaXhlczogZDZmYzg4MjFjMmQyICgiU1VOUlBDL0NhY2hlOiBBbHdheXMg
dHJlYXQgdGhlIGludmFsaWQgY2FjaGUNCj4gPiBhcyB1bmV4cGlyZWQiKQ0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9zdW5ycGMvY2FjaGUuaCB8ICAzIC0tLQ0KPiA+
ICBuZXQvc3VucnBjL2NhY2hlLmMgICAgICAgICAgIHwgMzYgKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0NCj4gPiAtLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9u
cygrKSwgMjAgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvc3VucnBjL2NhY2hlLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvc3VucnBjL2NhY2hlLmgNCj4g
PiBpbmRleCBmODYwMzcyNGZiZWUuLjA0MjhkZDIzZmQ3OSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3N1bnJwYy9jYWNoZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zdW5ycGMv
Y2FjaGUuaA0KPiA+IEBAIC0yMDIsOSArMjAyLDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGNhY2hl
X3B1dChzdHJ1Y3QgY2FjaGVfaGVhZA0KPiA+ICpoLCBzdHJ1Y3QgY2FjaGVfZGV0YWlsICpjZCkN
Cj4gPiAgDQo+ID4gIHN0YXRpYyBpbmxpbmUgYm9vbCBjYWNoZV9pc19leHBpcmVkKHN0cnVjdCBj
YWNoZV9kZXRhaWwgKmRldGFpbCwNCj4gPiBzdHJ1Y3QgY2FjaGVfaGVhZCAqaCkNCj4gPiAgew0K
PiA+IC0JaWYgKCF0ZXN0X2JpdChDQUNIRV9WQUxJRCwgJmgtPmZsYWdzKSkNCj4gPiAtCQlyZXR1
cm4gZmFsc2U7DQo+ID4gLQ0KPiA+ICAJcmV0dXJuICAoaC0+ZXhwaXJ5X3RpbWUgPCBzZWNvbmRz
X3NpbmNlX2Jvb3QoKSkgfHwNCj4gPiAgCQkoZGV0YWlsLT5mbHVzaF90aW1lID49IGgtPmxhc3Rf
cmVmcmVzaCk7DQo+ID4gIH0NCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9jYWNoZS5jIGIv
bmV0L3N1bnJwYy9jYWNoZS5jDQo+ID4gaW5kZXggNTJkOTI3MjEwZDMyLi45OWQ2MzAxNTBhZjYg
MTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3N1bnJwYy9jYWNoZS5jDQo+ID4gKysrIGIvbmV0L3N1bnJw
Yy9jYWNoZS5jDQo+ID4gQEAgLTY1LDEzICs2NSwxNCBAQCBzdGF0aWMgc3RydWN0IGNhY2hlX2hl
YWQNCj4gPiAqc3VucnBjX2NhY2hlX2ZpbmRfcmN1KHN0cnVjdCBjYWNoZV9kZXRhaWwgKmRldGFp
bCwNCj4gPiAgDQo+ID4gIAlyY3VfcmVhZF9sb2NrKCk7DQo+ID4gIAlobGlzdF9mb3JfZWFjaF9l
bnRyeV9yY3UodG1wLCBoZWFkLCBjYWNoZV9saXN0KSB7DQo+ID4gLQkJaWYgKGRldGFpbC0+bWF0
Y2godG1wLCBrZXkpKSB7DQo+ID4gLQkJCWlmIChjYWNoZV9pc19leHBpcmVkKGRldGFpbCwgdG1w
KSkNCj4gPiAtCQkJCWNvbnRpbnVlOw0KPiA+IC0JCQl0bXAgPSBjYWNoZV9nZXRfcmN1KHRtcCk7
DQo+ID4gLQkJCXJjdV9yZWFkX3VubG9jaygpOw0KPiA+IC0JCQlyZXR1cm4gdG1wOw0KPiA+IC0J
CX0NCj4gPiArCQlpZiAoIWRldGFpbC0+bWF0Y2godG1wLCBrZXkpKQ0KPiA+ICsJCQljb250aW51
ZTsNCj4gPiArCQlpZiAodGVzdF9iaXQoQ0FDSEVfVkFMSUQsICZ0bXAtPmZsYWdzKSAmJg0KPiA+
ICsJCSAgICBjYWNoZV9pc19leHBpcmVkKGRldGFpbCwgdG1wKSkNCj4gPiArCQkJY29udGludWU7
DQo+ID4gKwkJdG1wID0gY2FjaGVfZ2V0X3JjdSh0bXApOw0KPiA+ICsJCXJjdV9yZWFkX3VubG9j
aygpOw0KPiA+ICsJCXJldHVybiB0bXA7DQo+ID4gIAl9DQo+ID4gIAlyY3VfcmVhZF91bmxvY2so
KTsNCj4gPiAgCXJldHVybiBOVUxMOw0KPiA+IEBAIC0xMTQsMTcgKzExNSwxOCBAQCBzdGF0aWMg
c3RydWN0IGNhY2hlX2hlYWQNCj4gPiAqc3VucnBjX2NhY2hlX2FkZF9lbnRyeShzdHJ1Y3QgY2Fj
aGVfZGV0YWlsICpkZXRhaWwsDQo+ID4gIA0KPiA+ICAJLyogY2hlY2sgaWYgZW50cnkgYXBwZWFy
ZWQgd2hpbGUgd2Ugc2xlcHQgKi8NCj4gPiAgCWhsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdSh0bXAs
IGhlYWQsIGNhY2hlX2xpc3QpIHsNCj4gPiAtCQlpZiAoZGV0YWlsLT5tYXRjaCh0bXAsIGtleSkp
IHsNCj4gPiAtCQkJaWYgKGNhY2hlX2lzX2V4cGlyZWQoZGV0YWlsLCB0bXApKSB7DQo+ID4gLQkJ
CQlzdW5ycGNfYmVnaW5fY2FjaGVfcmVtb3ZlX2VudHJ5KHRtcCwNCj4gPiBkZXRhaWwpOw0KPiA+
IC0JCQkJZnJlZW1lID0gdG1wOw0KPiA+IC0JCQkJYnJlYWs7DQo+ID4gLQkJCX0NCj4gPiAtCQkJ
Y2FjaGVfZ2V0KHRtcCk7DQo+ID4gLQkJCXNwaW5fdW5sb2NrKCZkZXRhaWwtPmhhc2hfbG9jayk7
DQo+ID4gLQkJCWNhY2hlX3B1dChuZXcsIGRldGFpbCk7DQo+ID4gLQkJCXJldHVybiB0bXA7DQo+
ID4gKwkJaWYgKCFkZXRhaWwtPm1hdGNoKHRtcCwga2V5KSkNCj4gPiArCQkJY29udGludWU7DQo+
ID4gKwkJaWYgKHRlc3RfYml0KENBQ0hFX1ZBTElELCAmdG1wLT5mbGFncykgJiYNCj4gPiArCQkg
ICAgY2FjaGVfaXNfZXhwaXJlZChkZXRhaWwsIHRtcCkpIHsNCj4gPiArCQkJc3VucnBjX2JlZ2lu
X2NhY2hlX3JlbW92ZV9lbnRyeSh0bXAsIGRldGFpbCk7DQo+ID4gKwkJCWZyZWVtZSA9IHRtcDsN
Cj4gPiArCQkJYnJlYWs7DQo+ID4gIAkJfQ0KPiA+ICsJCWNhY2hlX2dldCh0bXApOw0KPiA+ICsJ
CXNwaW5fdW5sb2NrKCZkZXRhaWwtPmhhc2hfbG9jayk7DQo+ID4gKwkJY2FjaGVfcHV0KG5ldywg
ZGV0YWlsKTsNCj4gPiArCQlyZXR1cm4gdG1wOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCWhsaXN0
X2FkZF9oZWFkX3JjdSgmbmV3LT5jYWNoZV9saXN0LCBoZWFkKTsNCj4gPiAtLSANCj4gPiAyLjI0
LjENCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
