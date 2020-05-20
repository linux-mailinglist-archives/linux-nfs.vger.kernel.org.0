Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1341DA78F
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 03:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgETByc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 May 2020 21:54:32 -0400
Received: from mail-bn8nam12on2096.outbound.protection.outlook.com ([40.107.237.96]:9729
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728300AbgETByc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 19 May 2020 21:54:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz8hsj1czkimvsC+d6NxcPtMINgmy4yz95chtn72/qSoZnRtRPTI205idB2pub1F1ZODpJt37QlaA0+IotO0m7qHTLj90TQcnESMqc1zEaOA/H7xLO4hzwcRYcOPTrPFqCreudO/zEfFyl2EhC228+EhjNKuGWJ8+Eb1ouJnAckKMM6LpOGSJllYFUU2N4KIvXyv79Vl8IPp6HfmNIJCcxpKRGSR3y4lV4qwNBZAMetKC06AuQkwZ79gF0TKiwbrvm+Gnud4iU6YiFJ2JCPxO462sIHLnKRsDjcYyDUZejVw/uVmUNLlsLZkYheZ227ZcSbk5Vx6mwaZSu/YBGV6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilyW0OZqLLzhAqv/BK1B/3FKysD3xVnKmWaLlvTIkL8=;
 b=kKHthiQwofo7bQnERZHG5TqYjae7IepfRIHk8HpizagxwRIG1tOVW3v7/6FAAlf4uORyrTA55xZOvu4kql/cC59BpE1vaF6X8ocHTrBF9LfRpulRv+zY3d9+IFep9v87H9S4zkdaA4iDfZhp9jDxp18AyRXZp/Gs73b5LmBrhU+ohQbYG3FkurgP9Gs7ia8EB8e681ZYZUBZ4X4nOku0fxf7WxVBgoYvP2O2hpzlPYa6S2zkrNLgXoJkm6mE4wn4QABeSyq0tfaJDbisi+3ws4OOP2KtP8ccWJSs8J/d3HRdP0j77VLDMeY7h6DGgf1sUqHl/eRWyhQ36eLVRnFIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilyW0OZqLLzhAqv/BK1B/3FKysD3xVnKmWaLlvTIkL8=;
 b=K8I7Tm1Z79ZUbalfP4sCn5CF0ZMyY53HfgNtbH/7kWONdDYXBu3nx1CtRKGXNSfL+v8SIrENFOSOyKthi80mOvqYCI+ThMolfqEFCrAT5b9xnjsDoRGsOXrbUhlHzyFoRvrg8CFLGJZeDkd8vWYQqpOwO0YdNIgEJ/YeFjS41rw=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3685.namprd13.prod.outlook.com (2603:10b6:610:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.13; Wed, 20 May
 2020 01:54:28 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3021.013; Wed, 20 May 2020
 01:54:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "zhengbin13@huawei.com" <zhengbin13@huawei.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>
Subject: Re: [PATCH] nfs: set invalid blocks after NFSv4 writes
Thread-Topic: [PATCH] nfs: set invalid blocks after NFSv4 writes
Thread-Index: AQHWLkVP4n3xagAidk2FWJRqg49nKaiwNqWA
Date:   Wed, 20 May 2020 01:54:28 +0000
Message-ID: <0ae8ca00c11b7136b035336eb1e4f6b7c8723fb1.camel@hammerspace.com>
References: <20200520013037.113612-1-zhengbin13@huawei.com>
In-Reply-To: <20200520013037.113612-1-zhengbin13@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bde27475-0b64-4ce6-156d-08d7fc60bb39
x-ms-traffictypediagnostic: CH2PR13MB3685:
x-microsoft-antispam-prvs: <CH2PR13MB3685D73DB6AE2AF66124C629B8B60@CH2PR13MB3685.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CBNN8jngWZeZPuNhzENxCVxFXafWTWeDQ6vshOL38GoQ6PhOMNStUaRdlUeUtQz3L8zfxiuDiSejk5cScQ1nx5pmVEE/JaQmbBqTB0IGQdLrovaiZEBNanh6kbWVGg//QHzZAb2lQhZxqOa+mwureizKLEJZIIN/fBSV17TIve0Aw18wY7jzlttHXpYOSgo9MCBjeFQvKMTnVxqPaZdWREfmyjshhyspjb9q1CkgqvPsl7/GCsEk5Z7RLm5UZKC87Dqloy++tkneYpb+Z9jKo5ajMaUGNTRsY9Tyn1MKcvyPj1iYACwteeS5Qd9lJRpZHpnJkus379jL7/Z88gwmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(366004)(396003)(346002)(39830400003)(86362001)(6512007)(5660300002)(478600001)(8936002)(8676002)(316002)(4326008)(71200400001)(2906002)(36756003)(76116006)(6506007)(26005)(54906003)(186003)(110136005)(6486002)(64756008)(66556008)(66476007)(66446008)(66946007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1PrGXc7wWCbHBu+v1ytcxk/udWanjqRBRA0P6ADG0LMbeTUMA/gYOEuU3KkZyPq4DsKHZabhFIrGYOGFTEAQ+yelC3hI0+qwml6I2vtIN/mPuanPkYFRFTW8Ebck0Pg3YYsH35Z3LrSEU+u1IyX8P2FKotaJUOU8Oq3MhJOantDhowd9MOemwUgvOJ9RYCCLgTTFYLzQV/GxbaT5bnbAzHFVkLK+XWUpbY5AFI7lp0Vypv9CXcjkQykPQmGvW3MT4IQbCnjVg+ByHJeccjmHJUC8/ajBH3tlSD0hb9cUWbgzbGcWvLVJMVYAQ8IxbhosOta654VyBNsjXcBJ2UL8HYVH70orC0ka0q9pJb5qy1vqCPp3gjoU1yn9S5X+ozKp23obbfWF93c+wnkU8tdYxakchi8Dyg7QNc8gRpRvpiGcdCzsWu/u8/UNYmg3++1uRY5yeVdKvZuutjH3co3VJWrPwqmGe9r/4ywWroUb0Bo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <46F108B89B03664382FE0D8E76AEE5E1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde27475-0b64-4ce6-156d-08d7fc60bb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 01:54:28.3115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9Qk2393JgIdZwFn3ekGPsr+oPD4O3SrhgDsMhSRqjiGH+zZYWYlYuXKlrYhyj18SMAi1x9vUipRQq+VZz/N2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3685
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTIwIGF0IDA5OjMwICswODAwLCBaaGVuZyBCaW4gd3JvdGU6DQo+IFVz
ZSB0aGUgZm9sbG93aW5nIGNvbW1hbmQgdG8gdGVzdCBuZnN2NChzaXplIG9mIGZpbGUxTSBpcyAx
TUIpOg0KPiBtb3VudCAtdCBuZnMgLW8gdmVycz00LjAsYWN0aW1lbz02MCAxMjcuMC4wLjEvZGly
MSAvbW50DQo+IGNwIGZpbGUxTSAvbW50DQo+IGR1IC1oIC9tbnQvZmlsZTFNICAtLT4wIHdpdGhp
biA2MHMsIHRoZW4gMU0NCj4gDQo+IFdoZW4gd3JpdGUgaXMgZG9uZShjcCBmaWxlMU0gL21udCks
IHdpbGwgY2FsbCB0aGlzOg0KPiBuZnNfd3JpdGViYWNrX2RvbmUNCj4gICBuZnM0X3dyaXRlX2Rv
bmUNCj4gICAgIG5mczRfd3JpdGVfZG9uZV9jYg0KPiAgICAgICBuZnNfd3JpdGViYWNrX3VwZGF0
ZV9pbm9kZQ0KPiAgICAgICAgIG5mc19wb3N0X29wX3VwZGF0ZV9pbm9kZV9mb3JjZV93Y2NfbG9j
a2VkKGNoYW5nZSwgY3RpbWUsDQo+IG10aW1lDQo+IG5mc19wb3N0X29wX3VwZGF0ZV9pbm9kZV9m
b3JjZV93Y2NfbG9ja2VkDQo+ICAgIG5mc19zZXRfY2FjaGVfaW52YWxpZA0KPiAgICBuZnNfcmVm
cmVzaF9pbm9kZV9sb2NrZWQNCj4gICAgICBuZnNfdXBkYXRlX2lub2RlDQo+IA0KPiBuZnNkIHdy
aXRlIHJlc3BvbnNlIGNvbnRhaW5zIGNoYW5nZSwgY3RpbWUsIG10aW1lLCB0aGUgZmxhZyB3aWxs
IGJlDQo+IGNsZWFyIGFmdGVyIG5mc191cGRhdGVfaW5vZGUuIEhvd2VydmVyLCB3cml0ZSByZXNw
b25zZSBkb2VzIG5vdA0KPiBjb250YWluDQo+IHNwYWNlX3VzZWQsIHByZXZpb3VzIG9wZW4gcmVz
cG9uc2UgY29udGFpbnMgc3BhY2VfdXNlZCB3aG9zZSB2YWx1ZSBpcw0KPiAwLA0KPiBzbyBpbm9k
ZS0+aV9ibG9ja3MgaXMgc3RpbGwgMC4NCj4gDQo+IG5mc19nZXRhdHRyICAtLT5jYWxsZWQgYnkg
ImR1IC1oIg0KPiAgIGRvX3VwZGF0ZSB8PSBmb3JjZV9zeW5jIHx8IG5mc19hdHRyaWJ1dGVfY2Fj
aGVfZXhwaXJlZCAtLT5mYWxzZSBpbg0KPiA2MHMNCj4gICBjYWNoZV92YWxpZGl0eSA9IFJFQURf
T05DRShORlNfSShpbm9kZSktPmNhY2hlX3ZhbGlkaXR5KQ0KPiAgIGRvX3VwZGF0ZSB8PSBjYWNo
ZV92YWxpZGl0eSAmIChORlNfSU5PX0lOVkFMSURfQVRUUiAgICAtLT5mYWxzZQ0KPiAgIGlmIChk
b191cGRhdGUpIHsNCj4gICAgICAgICBfX25mc19yZXZhbGlkYXRlX2lub2RlDQo+ICAgfQ0KPiAN
Cj4gV2l0aGluIDYwcywgZG9lcyBub3Qgc2VuZCBnZXRhdHRyIHJlcXVlc3QgdG8gbmZzZCwgdGh1
cyAiZHUgLWgNCj4gL21udC9maWxlMU0iDQo+IGlzIDAuDQo+IA0KPiBBZGQgYSBORlNfSU5PX0lO
VkFMSURfQkxPQ0tTIGZsYWcsIHNldCBpdCB3aGVuIG5mc3Y0IHdyaXRlIGlzIGRvbmUuDQo+IA0K
PiBGaXhlczogMTZlMTQzNzUxNzI3ICgiTkZTOiBNb3JlIGZpbmUgZ3JhaW5lZCBhdHRyaWJ1dGUg
dHJhY2tpbmciKQ0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuZyBCaW4gPHpoZW5nYmluMTNAaHVhd2Vp
LmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvaW5vZGUuYyAgICAgICAgIHwgOSArKysrKysrLS0NCj4g
IGluY2x1ZGUvbGludXgvbmZzX2ZzLmggfCA2ICsrKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25m
cy9pbm9kZS5jIGIvZnMvbmZzL2lub2RlLmMNCj4gaW5kZXggYjlkMDkyMWNiNGZlLi4yZDc0M2U0
MmZlZTEgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9pbm9kZS5jDQo+ICsrKyBiL2ZzL25mcy9pbm9k
ZS5jDQo+IEBAIC0xNzY0LDcgKzE3NjQsOCBAQCBpbnQNCj4gbmZzX3Bvc3Rfb3BfdXBkYXRlX2lu
b2RlX2ZvcmNlX3djY19sb2NrZWQoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0DQo+IG5mc19m
YQ0KPiAgCXN0YXR1cyA9IG5mc19wb3N0X29wX3VwZGF0ZV9pbm9kZV9sb2NrZWQoaW5vZGUsIGZh
dHRyLA0KPiAgCQkJTkZTX0lOT19JTlZBTElEX0NIQU5HRQ0KPiAgCQkJfCBORlNfSU5PX0lOVkFM
SURfQ1RJTUUNCj4gLQkJCXwgTkZTX0lOT19JTlZBTElEX01USU1FKTsNCj4gKwkJCXwgTkZTX0lO
T19JTlZBTElEX01USU1FDQo+ICsJCQl8IE5GU19JTk9fSU5WQUxJRF9CTE9DS1MpOw0KPiAgCXJl
dHVybiBzdGF0dXM7DQo+ICB9DQo+IA0KPiBAQCAtMjAzMyw4ICsyMDM0LDEyIEBAIHN0YXRpYyBp
bnQgbmZzX3VwZGF0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUNCj4gKmlub2RlLCBzdHJ1Y3QgbmZzX2Zh
dHRyICpmYXR0cikNCj4gIAkJaW5vZGUtPmlfYmxvY2tzID0gbmZzX2NhbGNfYmxvY2tfc2l6ZShm
YXR0ci0NCj4gPmR1Lm5mczMudXNlZCk7DQo+ICAJfSBlbHNlIGlmIChmYXR0ci0+dmFsaWQgJiBO
RlNfQVRUUl9GQVRUUl9CTE9DS1NfVVNFRCkNCj4gIAkJaW5vZGUtPmlfYmxvY2tzID0gZmF0dHIt
PmR1Lm5mczIuYmxvY2tzOw0KPiAtCWVsc2UNCj4gKwllbHNlIHsNCj4gKwkJbmZzaS0+Y2FjaGVf
dmFsaWRpdHkgfD0gc2F2ZV9jYWNoZV92YWxpZGl0eSAmDQo+ICsJCQkJKE5GU19JTk9fSU5WQUxJ
RF9CTE9DS1MNCj4gKwkJCQl8IE5GU19JTk9fUkVWQUxfRk9SQ0VEKTsNCj4gIAkJY2FjaGVfcmV2
YWxpZGF0ZWQgPSBmYWxzZTsNCj4gKwl9DQo+IA0KPiAgCS8qIFVwZGF0ZSBhdHRydGltZW8gdmFs
dWUgaWYgd2UncmUgb3V0IG9mIHRoZSB1bnN0YWJsZSBwZXJpb2QNCj4gKi8NCj4gIAlpZiAoYXR0
cl9jaGFuZ2VkKSB7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L25mc19mcy5oIGIvaW5j
bHVkZS9saW51eC9uZnNfZnMuaA0KPiBpbmRleCA3M2VkYTQ1ZjFjZmQuLjc3ZWZkY2ExMmNhYiAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9uZnNfZnMuaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L25mc19mcy5oDQo+IEBAIC0yMjcsMTQgKzIyNywxNiBAQCBzdHJ1Y3QgbmZzNF9jb3B5X3N0
YXRlIHsNCj4gICNkZWZpbmUgTkZTX0lOT19JTlZBTElEX0NUSU1FCUJJVCg5KQkJLyogY2FjaGVk
DQo+IGN0aW1lIGlzIGludmFsaWQgKi8NCj4gICNkZWZpbmUgTkZTX0lOT19JTlZBTElEX01USU1F
CUJJVCgxMCkJCS8qIGNhY2hlZA0KPiBtdGltZSBpcyBpbnZhbGlkICovDQo+ICAjZGVmaW5lIE5G
U19JTk9fSU5WQUxJRF9TSVpFCUJJVCgxMSkJCS8qIGNhY2hlZCBzaXplIGlzDQo+IGludmFsaWQg
Ki8NCj4gLSNkZWZpbmUgTkZTX0lOT19JTlZBTElEX09USEVSCUJJVCgxMikJCS8qIG90aGVyDQo+
IGF0dHJzIGFyZSBpbnZhbGlkICovDQo+ICsjZGVmaW5lIE5GU19JTk9fSU5WQUxJRF9CTE9DS1MJ
QklUKDEyKSAgICAgICAgIC8qIGNhY2hlZA0KPiBibG9ja3MgYXJlIGludmFsaWQgKi8NCj4gKyNk
ZWZpbmUgTkZTX0lOT19JTlZBTElEX09USEVSCUJJVCgxMykJCS8qIG90aGVyDQo+IGF0dHJzIGFy
ZSBpbnZhbGlkICovDQo+ICAjZGVmaW5lIE5GU19JTk9fREFUQV9JTlZBTF9ERUZFUglcDQo+IC0J
CQkJQklUKDEzKQkJLyogRGVmZXJyZWQgY2FjaGUNCj4gaW52YWxpZGF0aW9uICovDQo+ICsJCQkJ
QklUKDE0KQkJLyogRGVmZXJyZWQgY2FjaGUNCj4gaW52YWxpZGF0aW9uICovDQo+IA0KPiAgI2Rl
ZmluZSBORlNfSU5PX0lOVkFMSURfQVRUUgkoTkZTX0lOT19JTlZBTElEX0NIQU5HRSBcDQo+ICAJ
CXwgTkZTX0lOT19JTlZBTElEX0NUSU1FIFwNCj4gIAkJfCBORlNfSU5PX0lOVkFMSURfTVRJTUUg
XA0KPiAgCQl8IE5GU19JTk9fSU5WQUxJRF9TSVpFIFwNCj4gKwkJfCBORlNfSU5PX0lOVkFMSURf
QkxPQ0tTIFwNCg0KQ2FuIHdlIHBsZWFzZSByZXBsYWNlIHRoaXMgd2l0aCBhbiBleHBsaWNpdCBj
aGVjayBmb3IgU1RBVFhfQkxPQ0tTIGluDQpuZnNfZ2V0YXR0cigpPyBUaGUgYWJvdmUgd291bGQg
anVzdCBtZWFuIHdlIGFsd2F5cyByZXZhbGlkYXRlDQppbmRlcGVuZGVudGx5IG9mIHdoZXRoZXIg
b3Igbm90IHRoZSB1c2VyIGNhcmVzLg0KDQo+ICAJCXwgTkZTX0lOT19JTlZBTElEX09USEVSKQkv
KiBpbm9kZSBtZXRhZGF0YSBpcyBpbnZhbGlkDQo+ICovDQo+IA0KPiAgLyoNCj4gLS0NCj4gMi4y
Ni4wLjEwNi5nOWZhZGVkZA0KPiANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
