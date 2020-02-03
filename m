Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0332151289
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 23:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBCWpW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 17:45:22 -0500
Received: from mail-eopbgr690125.outbound.protection.outlook.com ([40.107.69.125]:45742
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbgBCWpW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Feb 2020 17:45:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVcx/n/QlPtpNNbZr9GzjkfhJ3ukFWe+npLMVcGC42P/ezuBN8WXOpuOEKdbMf37S/VKpmJHRA7wk1kWPfFJdIICDeZJPxZKFkdgxkaihvSfojFuoPIv4OWPuG9nH+TzAY19kbJG0GshFvF9nkGwunLwcc/C1lM3Ro0OD0RL0/JIBuQuSXFwBX+ls+bDaiR0Uxj8KTykTFDz9lsvTzQ6x9wsDFQMV1hZY3IV7PWtZqLMV4JVQMldSFjBeNmCC78KJzGZTdppWsUDnlnoVMghnouGU72zeoOLj5d2CA0nRekaopTYP5U6riEEPHxgN7MIUIfG2gH7ekj/d6BGrfk5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQhNr8vakU7qzf7LdZJ3ITj5YizAMuoi3sJ65/YcOCk=;
 b=KhRl80uUt/PVHisZ3dfBwxQaJxAjKUQfBDRg4gH7DC9JP7Ify3ea20z9QBtTJ7fOxYXtP5XBC1sQNRvlY9b6S6lgktRcKn12LjE1VyD1EqysqSm1xs9JRxjYMP5bRguNohjSFBue7Tint2ZFWijJYwNSv05d++DcUmjZsujrXoYX99Hy4uLO3o2yMyuRxrftTSpHgNmDjQCdqARbksP0poSDCa7w2XOW0q0WHYuKJV5c21na36TqbLvngIzTgdkzqZF6/HfMxUpXcUtBOKXKdgmPb7FbfDh1o3gPj0UEoztptiUTN6hXW3O0ZRpI1e6OXeKB1Ca+geWqVJMlVFpYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQhNr8vakU7qzf7LdZJ3ITj5YizAMuoi3sJ65/YcOCk=;
 b=M7W2DOsgKzl/uBEbcBYU8DRSdKtft5pcIjjopOlzDp3+x4IqFbSWgjd5e42ytsc7CE7QRsVkNfuWbq1Xarn/yHh8IhKdRslwYeJgKVa3bKPpimCkwHn8EbSU0ptcVPQUtgdz7YGSaFFJ0mT1L8L/B4t3mgV3B7lGTA8CXNArZrA=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2220.namprd13.prod.outlook.com (10.174.186.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.18; Mon, 3 Feb 2020 22:45:16 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2707.018; Mon, 3 Feb 2020
 22:45:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Topic: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Index: AQHV2hv42rcDbF+6jk2nrb8C0oLYkagJ7Z6AgAANQ4CAAACzgIAAF2eA
Date:   Mon, 3 Feb 2020 22:45:16 +0000
Message-ID: <7acea747deb126b86fc4a2f2742362155a4cf698.camel@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
         <20200202225356.995080-2-trond.myklebust@hammerspace.com>
         <20200202225356.995080-3-trond.myklebust@hammerspace.com>
         <16a7298dacd9fd1d08cd26b7073e9ced62c5fa24.camel@netapp.com>
         <beb3c648da7f641d34f9a1cbef5639ba014de6db.camel@gmail.com>
         <af1ed1339b6854af4c6def212b1035d18ce863df.camel@netapp.com>
In-Reply-To: <af1ed1339b6854af4c6def212b1035d18ce863df.camel@netapp.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5120a196-188b-4176-570c-08d7a8fabd1a
x-ms-traffictypediagnostic: DM5PR1301MB2220:
x-microsoft-antispam-prvs: <DM5PR1301MB2220EA2356CAE588771CEBD7B8000@DM5PR1301MB2220.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39850400004)(136003)(346002)(376002)(199004)(189003)(66556008)(6506007)(54906003)(26005)(186003)(66946007)(64756008)(76116006)(316002)(66446008)(91956017)(66476007)(5660300002)(2616005)(36756003)(6486002)(8676002)(6916009)(2906002)(81156014)(6512007)(8936002)(4326008)(81166006)(86362001)(71200400001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2220;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsEBWGByFy1z5vixhn5GCndQ/hBoUHRcgPKvpgUM1bpqDNg6OQsi9h2aJRL57kgq4V03zGnVeghrTsP+CLWCuCkFTNYU4gHRv9WLSuO/gyjN2FdW6vQuoIxaoc5VXtxjl9qYbtn1sYRIvuP9dlsjZGdrY/GqjdbujQOVwPaKlS7xz+dBNJR2ZzoHdkCEn/uVSFf6MH7Vw+VPCQfnVOQyXK+rCySCTpvnJbedKVDAchKCwt3b8/4ii6S6tiBflKz39gk7fLnDausW9a5znqVN1+49C2NF2VKIIN5SyeZs+TG7sHMSN1NeXyEoZjt1SkFaKjImZT+Oxbd/p2EgwD3wyUz1w3V7u/fd6uCPMOwSiR0mJA0gSJoss9legObH6+DUO1L22lUlE6dmd6Nwo9183XCI/9F9zsK+PxtObVoQ3xzur5D0jRFmxYxt0e8W56of
x-ms-exchange-antispam-messagedata: gC3+R3MJzNqnfHRktkivBMFicxlJZGiRhGffb0TO0IUvcILeJT7AeNFhEGQBI7WJfFgLPLZvXc8vS8j6Ta76EaVP4cG1gurGoQfmrM7jz3c9ugJK60nh2dlJia6lQSpX3cT1t55miB8rn1nG46NlTg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5EE12B4B91A644AA5EE7DB50B776A27@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5120a196-188b-4176-570c-08d7a8fabd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 22:45:16.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qw4W+F2Sh+YttotBkAYAqL4774lkDrhv8SEv05BEGCI7Q25pjaPflXl0iPCStdWVKj1zg7k79RyAxZ/SziZPbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2220
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTAzIGF0IDIxOjIxICswMDAwLCBTY2h1bWFrZXIsIEFubmEgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMC0wMi0wMyBhdCAxNjoxOCAtMDUwMCwgVHJvbmQgTXlrbGVidXN0IHdy
b3RlOg0KPiA+IE9uIE1vbiwgMjAyMC0wMi0wMyBhdCAyMDozMSArMDAwMCwgU2NodW1ha2VyLCBB
bm5hIHdyb3RlOg0KPiA+ID4gSGkgVHJvbmQsDQo+ID4gPiANCj4gPiA+IE9uIFN1biwgMjAyMC0w
Mi0wMiBhdCAxNzo1MyAtMDUwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBXaGVu
IGEgTkZTIGRpcmVjdG9yeSBwYWdlIGNhY2hlIHBhZ2UgaXMgcmVtb3ZlZCBmcm9tIHRoZSBwYWdl
DQo+ID4gPiA+IGNhY2hlLA0KPiA+ID4gPiBpdHMgY29udGVudHMgYXJlIGZyZWVkIHRocm91Z2gg
YSBjYWxsIHRvDQo+ID4gPiA+IG5mc19yZWFkZGlyX2NsZWFyX2FycmF5KCkuDQo+ID4gPiA+IFRv
IHByZXZlbnQgdGhlIHJlbW92YWwgb2YgdGhlIHBhZ2UgY2FjaGUgZW50cnkgdW50aWwgYWZ0ZXIN
Cj4gPiA+ID4gd2UndmUNCj4gPiA+ID4gZmluaXNoZWQgcmVhZGluZyBpdCwgd2UgbXVzdCB0YWtl
IHRoZSBwYWdlIGxvY2suDQo+ID4gPiA+IA0KPiA+ID4gPiBGaXhlczogMTFkZTNiMTFlMDhjICgi
TkZTOiBGaXggYSBtZW1vcnkgbGVhayBpbiBuZnNfcmVhZGRpciIpDQo+ID4gPiA+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnICMgdjIuNi4zNysNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJv
bmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBmcy9uZnMvZGlyLmMgfCAzMCArKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCsp
LCAxMSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMv
ZGlyLmMgYi9mcy9uZnMvZGlyLmMNCj4gPiA+ID4gaW5kZXggYmEwZDU1OTMwZThhLi45MDQ2N2I0
NGVjMTMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiA+ID4gPiArKysgYi9m
cy9uZnMvZGlyLmMNCj4gPiA+ID4gQEAgLTcwNSw4ICs3MDUsNiBAQCBpbnQgbmZzX3JlYWRkaXJf
ZmlsbGVyKHZvaWQgKmRhdGEsIHN0cnVjdA0KPiA+ID4gPiBwYWdlKg0KPiA+ID4gPiBwYWdlKQ0K
PiA+ID4gPiAgc3RhdGljDQo+ID4gPiA+ICB2b2lkIGNhY2hlX3BhZ2VfcmVsZWFzZShuZnNfcmVh
ZGRpcl9kZXNjcmlwdG9yX3QgKmRlc2MpDQo+ID4gPiA+ICB7DQo+ID4gPiA+IC0JaWYgKCFkZXNj
LT5wYWdlLT5tYXBwaW5nKQ0KPiA+ID4gPiAtCQluZnNfcmVhZGRpcl9jbGVhcl9hcnJheShkZXNj
LT5wYWdlKTsNCj4gPiA+ID4gIAlwdXRfcGFnZShkZXNjLT5wYWdlKTsNCj4gPiA+ID4gIAlkZXNj
LT5wYWdlID0gTlVMTDsNCj4gPiA+ID4gIH0NCj4gPiA+ID4gQEAgLTcyMCwxOSArNzE4LDI4IEBA
IHN0cnVjdCBwYWdlDQo+ID4gPiA+ICpnZXRfY2FjaGVfcGFnZShuZnNfcmVhZGRpcl9kZXNjcmlw
dG9yX3QNCj4gPiA+ID4gKmRlc2MpDQo+ID4gPiA+ICANCj4gPiA+ID4gIC8qDQo+ID4gPiA+ICAg
KiBSZXR1cm5zIDAgaWYgZGVzYy0+ZGlyX2Nvb2tpZSB3YXMgZm91bmQgb24gcGFnZSBkZXNjLQ0K
PiA+ID4gPiA+IHBhZ2VfaW5kZXgNCj4gPiA+ID4gKyAqIGFuZCBsb2NrcyB0aGUgcGFnZSB0byBw
cmV2ZW50IHJlbW92YWwgZnJvbSB0aGUgcGFnZSBjYWNoZS4NCj4gPiA+ID4gICAqLw0KPiA+ID4g
PiAgc3RhdGljDQo+ID4gPiA+IC1pbnQgZmluZF9jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2Ny
aXB0b3JfdCAqZGVzYykNCj4gPiA+ID4gK2ludCBmaW5kX2FuZF9sb2NrX2NhY2hlX3BhZ2UobmZz
X3JlYWRkaXJfZGVzY3JpcHRvcl90ICpkZXNjKQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAgCWludCBy
ZXM7DQo+ID4gPiA+ICANCj4gPiA+ID4gIAlkZXNjLT5wYWdlID0gZ2V0X2NhY2hlX3BhZ2UoZGVz
Yyk7DQo+ID4gPiA+ICAJaWYgKElTX0VSUihkZXNjLT5wYWdlKSkNCj4gPiA+ID4gIAkJcmV0dXJu
IFBUUl9FUlIoZGVzYy0+cGFnZSk7DQo+ID4gPiA+IC0NCj4gPiA+ID4gLQlyZXMgPSBuZnNfcmVh
ZGRpcl9zZWFyY2hfYXJyYXkoZGVzYyk7DQo+ID4gPiA+ICsJcmVzID0gbG9ja19wYWdlX2tpbGxh
YmxlKGRlc2MtPnBhZ2UpOw0KPiA+ID4gPiAgCWlmIChyZXMgIT0gMCkNCj4gPiA+ID4gLQkJY2Fj
aGVfcGFnZV9yZWxlYXNlKGRlc2MpOw0KPiA+ID4gPiArCQlnb3RvIGVycm9yOw0KPiA+ID4gPiAr
CXJlcyA9IC1FQUdBSU47DQo+ID4gPiA+ICsJaWYgKGRlc2MtPnBhZ2UtPm1hcHBpbmcgIT0gTlVM
TCkgew0KPiA+ID4gPiArCQlyZXMgPSBuZnNfcmVhZGRpcl9zZWFyY2hfYXJyYXkoZGVzYyk7DQo+
ID4gPiA+ICsJCWlmIChyZXMgPT0gMCkNCj4gPiA+ID4gKwkJCXJldHVybiAwOw0KPiA+ID4gPiAr
CX0NCj4gPiA+ID4gKwl1bmxvY2tfcGFnZShkZXNjLT5wYWdlKTsNCj4gPiA+ID4gK2Vycm9yOg0K
PiA+ID4gPiArCWNhY2hlX3BhZ2VfcmVsZWFzZShkZXNjKTsNCj4gPiA+ID4gIAlyZXR1cm4gcmVz
Ow0KPiA+ID4gPiAgfQ0KPiA+ID4gPiAgDQo+ID4gPiANCj4gPiA+IENhbiB5b3UgZ2l2ZSBtZSBz
b21lIGd1aWRhbmNlIG9uIGhvdyB0byBhcHBseSB0aGlzIG9uIHRvcCBvZg0KPiA+ID4gRGFpJ3Mg
djINCj4gPiA+IHBhdGNoIGZyb20NCj4gPiA+IEphbnVhcnkgMjM/IFJpZ2h0IG5vdyBJIGhhdmUg
dGhlIG5mc2ktPnBhZ2VfaW5kZXggZ2V0dGluZyBzZXQNCj4gPiA+IGJlZm9yZQ0KPiA+ID4gdGhl
DQo+ID4gPiB1bmxvY2tfcGFnZSgpOg0KPiA+IA0KPiA+IFNpbmNlIHRoaXMgbmVlZHMgdG8gYmUg
YSBzdGFibGUgcGF0Y2gsIGl0IHdvdWxkIGJlIHByZWZlcmFibGUgdG8NCj4gPiBhcHBseQ0KPiA+
IHRoZW0gaW4gdGhlIG9wcG9zaXRlIG9yZGVyIHRvIGF2b2lkIGFuIGV4dHJhIGRlcGVuZGVuY3kg
b24gRGFpJ3MNCj4gPiBwYXRjaC4NCj4gDQo+IFRoYXQgbWFrZXMgc2Vuc2UuDQo+IA0KPiA+IFRo
YXQgc2FpZCwgc2luY2UgdGhlIG5mc2ktPnBhZ2VfaW5kZXggaXMgbm90IGEgcGVyLXBhZ2UgdmFy
aWFibGUsDQo+ID4gdGhlcmUNCj4gPiBpcyBubyBuZWVkIHRvIHB1dCBpdCB1bmRlciB0aGUgcGFn
ZSBsb2NrLg0KPiANCj4gR290IGl0LiBJJ2xsIHN3YXAgdGhlIG9yZGVyIG9mIGV2ZXJ5dGhpbmcs
IGFuZCBwdXQgdGhlIHBhZ2VfaW5kZXgNCj4gb3V0c2lkZSBvZiB0aGUNCj4gcGFnZSBsb2NrIHdo
ZW4gcmVzb2x2aW5nIHRoZSBjb25mbGljdC4NCj4gDQoNCk9vcHMuLi4gQWN0dWFsbHkgRGFpJ3Mg
Y29kZSBuZWVkcyB0byBnbyBpbiB0aGUgJ3JldHVybiAwJyBwYXRoIGFib3ZlDQooaS5lLiBhZnRl
ciBhIHN1Y2Nlc3NmdWwgY2FsbCB0byBuZnNfcmVhZGRpcl9zZWFyY2hfYXJyYXkoKSkuDQpJdCBz
aG91bGRuJ3QgZ28gaW4gdGhlIGVycm9yIHBhdGguDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
