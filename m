Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3266C1FF4B5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2020 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgFRO3v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jun 2020 10:29:51 -0400
Received: from mail-bn7nam10on2128.outbound.protection.outlook.com ([40.107.92.128]:5496
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbgFRO3r (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 18 Jun 2020 10:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNrwvkyHZ/qz991hQElD1P7xkAzRZqmeLOnN2rl4fELubYDrhM6tViVF5hVUNMUyqLxTc8MYIoy1g+iKE0E6YMXxYIVF9aTpBqRvTSE24CfRxOVOELGBms0JYz2/KjYBv9dpcwcpBJwbobLJOJe0cf5oIZGP0Wzo/HawQ5g/dacE58UX+bf4dqo35pwnlJ+dbMnXSdKpo0a5mCTxW7B57CF4y9mnxXmRkaJmtX+rJ37th6V50+dB3nsuXgrXYtz1o9VW2D/2JGAbcyj7Cl3Ng2Q9by3xJcMWwHyqexe0QMPq0bDcp8sHnViFm3dVjyQFZc6larCJbkwc0C4Vi/j4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU/8PmSozVToWmGQaYdrWgsaD6YER0vwDFLsCSmihuI=;
 b=HiVc6JEm+shpn8FSnPPxPYgUb4RfRBHu035Pa5af/GnzG9SN7PEv8oCDliKeScGGXeBgZGtFgj/KnkoEYh/UM1qI1iqTd92HKhShw7YVqDMFJVT4vjfWbNMmn7pYYN/j7/IT8+GPmLPon6LY3XhLOTbpHhMyoUYFf+zfF66PJWGFFQxGT6x6cnHv69cEDWEvqnO5pDmXHXcISK2+WXPuzDa7VhvndAiY3XiFX8CeqCgGwdjkSuQABiaLreAASzfolM0xWy8ZJFcfy7Pp4FtU+cFP0h7R2lr2OjPwH+Iy9T7IIyg/7S34AQ+tfCVb1cLla9BKhkrk3kkJWu1EVUzxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU/8PmSozVToWmGQaYdrWgsaD6YER0vwDFLsCSmihuI=;
 b=F6YXB6+4xxI/jPpLw49ViiHb9vrvIJXabygK8yaddn7DOT48ZfrhcuFNXhDd+0Uxg4UkWlU1lYsW2X8jQDzXD+If8n+7IQpnkzLWY3BvjikVW7Tqm3Ux6Y0bZCgQbJVlIMQmF23QgQPcmnsAOXqThKjxka2Dsb5VWLzqDkM8pwA=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3766.namprd13.prod.outlook.com (2603:10b6:610:9d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.12; Thu, 18 Jun
 2020 14:29:43 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3109.018; Thu, 18 Jun 2020
 14:29:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqKDxq04E9R4EezGQhAvzMsOqjeMTgAgABM3wA=
Date:   Thu, 18 Jun 2020 14:29:42 +0000
Message-ID: <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
References: <20200608211945.GB30639@fieldses.org>
         <OSBPR01MB2949040AA49BC9B5F104DA1FEF9B0@OSBPR01MB2949.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2949040AA49BC9B5F104DA1FEF9B0@OSBPR01MB2949.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de6a053d-d131-4844-c9f6-08d813940ad3
x-ms-traffictypediagnostic: CH2PR13MB3766:
x-microsoft-antispam-prvs: <CH2PR13MB3766B529D4C54CC816546796B89B0@CH2PR13MB3766.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPKEfqdZr2MF2aB0QgAPl4fPG5IbUx9irUv3ep6w5pytTNzy/HtuE3VoBiW/5vgCE7VyRS86wsvOjgoo5kKiolcK1LXZfOpx40uiwmGhWF/QcjO8zkkaO2d7R8Ncv01Zx3/2iRE96dUGxg052mHR2b24y1Df2vI9+vvmT18EBzFA8CkdVKlb4NyXJlrI4xFNYaDrqREZ+SOmAJbnT4r6hbKFbvLLXZsQz93pSqL+N9eN7pPdn42fq6/P6shyWtb/rWDhE8guxeWNTSzfyOIfXDZ7Z6/tnJJzAx4uidCySzr99R71RU2f9evhDfUE98xGad0l4CTMAjHMFNbmz3ipm5rCofAub4PGPA6jpgBnsLjpJXdwitpR/XwP+Rz2Zod9Xe9UDhIo4Ph9JNx3aJWmXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(366004)(136003)(376002)(346002)(396003)(76116006)(316002)(6506007)(86362001)(26005)(8676002)(6486002)(66946007)(6512007)(36756003)(66446008)(8936002)(3480700007)(64756008)(71200400001)(66556008)(2616005)(83380400001)(66476007)(966005)(478600001)(5660300002)(2906002)(110136005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Dc/+fXQXD+0lzp9iS8k4boE8urZo76aopIPA35Nw6/bKBDZkofdmL7E4W5c72kPYLxiKKKo4T6dDask0MncuyDtGHcVaVdI76X1jK9dGn4QkWUpfUde7KgfVgyHtKVwjsvRU95012Cx4jd6u+F1qBrmKOW5YZkPWpv/KJLjl8HfgfUHey0cVoKiynXiL2bM3Lhf4rbgoJXawvHL9VqEQJd9MjHRV+JwmxaK33676UkAHmOe++SXXSxGHi18WxK32T82/v8GnlF1y3529hKoXdTdjlaVGcTJxerkAm2pc4OaC9qgBKWRlsctXMlk9SjYCrDVG1PwI0C+B9cYOpX0+ESTFZ22AuLVD9Ao1TT/VvP5tE+1agneEkSnr3Rp1wfgpiwYjO6tqrPkie/W6JRT881v9+gFZvhS+BFqxQeLmU+LoPbreagSSUwytFpyKycof9biIld+TdpkTpWFOZq1uUuWoZFnlyY39WffK4WKJqFk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E9D78BF673B5F43AC783E64256F676F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6a053d-d131-4844-c9f6-08d813940ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 14:29:42.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EeZnieSkOHW6L6Uif95Nwc7sIbyaId88xOYUXDkwC3L5SzzWeSvziIvuy3rPzVBNCU04Qp8MARlxGs4zccC/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3766
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTE4IGF0IDA5OjU0ICswMDAwLCBpbm9ndWNoaS55dWtpQGZ1aml0c3Uu
Y29tIHdyb3RlOg0KPiA+IFdoYXQgZG9lcyB0aGUgY2xpZW50IGRvIHRvIGl0cyBjYWNoZSB3aGVu
IGl0IHdyaXRlcyB0byBhIGxvY2tlZA0KPiA+IHJhbmdlPw0KPiA+IA0KPiA+IFRoZSBSRkM6DQo+
ID4gDQo+ID4gCWh0dHBzOi8vdG9vbHMuaWV0Zi5vcmcvaHRtbC9yZmM3NTMwI3NlY3Rpb24tMTAu
My4yDQo+ID4gDQo+ID4gc2VlbXMgdG8gYXBwbHkgdGhhdCB5b3Ugc2hvdWxkIGdldCBzb21ldGhp
bmcgbGlrZSBsb2NhbC1maWxlc3lzdGVtDQo+ID4gc2VtYW50aWNzIGlmIHlvdSB3cml0ZS1sb2Nr
IGFueSByYW5nZSB0aGF0IHlvdSB3cml0ZSB0byBhbmQgcmVhZC0NCj4gPiBsb2NrDQo+ID4gYW55
IHJhbmdlIHRoYXQgeW91IHJlYWQgZnJvbS4NCj4gPiANCj4gPiBCdXQgSSBzZWUgYSByZXBvcnQg
dGhhdCB3aGVuIGFwcGxpY2F0aW9ucyB3cml0ZSB0byBub24tb3ZlcmxhcHBpbmcNCj4gPiByYW5n
ZXMgKHdoaWxlIHRha2luZyBsb2NrcyBvdmVyIHRob3NlIHJhbmdlcyksIHRoZXkgZG9uJ3Qgc2Vl
IGVhY2gNCj4gPiBvdGhlcidzIHVwZGF0ZXMuDQo+ID4gDQo+ID4gSSB0aGluayBmb3Igc2ltdWx0
YW5lb3VzIG5vbi1vdmVybGFwcGluZyB3cml0ZXMgdG8gd29yayB0aGF0IHdheSwNCj4gPiB0aGUN
Cj4gPiBjbGllbnQgd291bGQgbmVlZCB0byBpbnZhbGlkYXRlIGl0cyBjYWNoZSBvbiB1bmxvY2sg
KGV4Y2VwdCBmb3IgdGhlDQo+ID4gbG9ja2VkIHJhbmdlKS4gIEJ1dCBpIGNhbid0IHRlbGwgd2hh
dCB0aGUgY2xpZW50J3MgZGVzaWduZWQgdG8gZG8uDQo+IA0KPiBTaW11bHRhbmVvdXMgbm9uLW92
ZXJsYXBwaW5nIFdSSVRFcyBpcyBub3QgdGFrZW4gaW50byBjb25zaWRlcmF0aW9uDQo+IGluIFJG
Qzc1MzAuDQo+IEkgcGVyc29uYWxseSB0aGluayBpdCBpcyBub3QgbmVjZXNzYXJ5IHRvIGRlYWwg
d2l0aCB0aGlzIGNhc2UgYnkNCj4gbW9kaWZ5aW5nIHRoZSBrZXJuZWwgYmVjYXVzZQ0KPiB0aGUg
YXBwbGljYXRpb24gb24gdGhlIGNsaWVudCBjYW4gYmUgaW1wbGVtZW50ZWQgdG8gYXZvaWQgaXQu
DQo+IA0KPiBTZXJpYWxpemF0aW9uIG9mIHRoZSBzaW11bHRhbmVvdXMgb3BlcmF0aW9ucyBtYXkg
YmUgb25lIG9mIHRoZSB3YXlzLg0KPiBKdXN0IGJlZm9yZSB0aGUgd3JpdGUgb3BlcmF0aW9uLCBl
YWNoIGNsaWVudCBsb2NrcyBhbmQgcmVhZHMgdGhlDQo+IG92ZXJsYXBwZWQgcmFuZ2Ugb2YgZGF0
YQ0KPiBpbnN0ZWFkIG9mIG9idGFpbmluZyBhIGxvY2sgaW4gdGhlaXIgb3duIG5vbi1vdmVybGFw
cGluZyByYW5nZS4NCj4gVGhleSBjYW4gcmVmbGVjdCB1cGRhdGVzIGZyb20gb3RoZXIgY2xpZW50
cyBpbiB0aGlzIGNhc2UuDQo+IA0KPiBZdWtpIElub2d1Y2hpDQo+IA0KPiA+IC0tYi4NCg0KU2Vl
IHRoZSBmdW5jdGlvbiAnZnMvbmZzL2ZpbGUuYzpkb19zZXRsaygpJy4gV2UgZmx1c2ggZGlydHkg
ZmlsZSBkYXRhDQpib3RoIGJlZm9yZSBhbmQgYWZ0ZXIgdGFraW5nIHRoZSBieXRlIHJhbmdlIGxv
Y2suIEFmdGVyIHRha2luZyB0aGUNCmxvY2ssIHdlIGZvcmNlIGEgcmV2YWxpZGF0aW9uIG9mIHRo
ZSBkYXRhIGJlZm9yZSByZXR1cm5pbmcgY29udHJvbCB0bw0KdGhlIGFwcGxpY2F0aW9uICh1bmxl
c3MgdGhlcmUgaXMgYSBkZWxlZ2F0aW9uIHRoYXQgYWxsb3dzIHVzIHRvIGNhY2hlDQptb3JlIGFn
Z3Jlc3NpdmVseSkuDQoNCkluIGFkZGl0aW9uLCBpZiB5b3UgbG9vayBhdCBmcy9uZnMvZmlsZS5j
OmRvX3VubGsoKSB5b3UnbGwgbm90ZSB0aGF0IHdlDQpmb3JjZSBhIGZsdXNoIG9mIGFsbCBkaXJ0
eSBmaWxlIGRhdGEgYmVmb3JlIHJlbGVhc2luZyB0aGUgbG9jay4NCg0KRmluYWxseSwgbm90ZSB0
aGF0IHdlIHR1cm4gb2ZmIGFzc3VtcHRpb25zIG9mIGNsb3NlLXRvLW9wZW4gY2FjaGluZw0Kc2Vt
YW50aWNzIHdoZW4gd2UgZGV0ZWN0IHRoYXQgdGhlIGFwcGxpY2F0aW9uIGlzIHVzaW5nIGxvY2tp
bmcsIGFuZCB3ZQ0KdHVybiBvZmYgb3B0aW1pc2F0aW9ucyBzdWNoIGFzIGFzc3VtaW5nIHdlIGNh
biBleHRlbmQgd3JpdGVzIHRvIHBhZ2UNCmJvdW5kYXJpZXMgd2hlbiB0aGUgcGFnZSBpcyBtYXJr
ZWQgYXMgYmVpbmcgdXAgdG8gZGF0ZS4NCg0KSU9XOiBpZiBhbGwgdGhlIGNsaWVudHMgYXJlIHJ1
bm5pbmcgTGludXgsIHRoZW4gdGhlIHRocmVhZCB0aGF0IHRvb2sNCnRoZSBsb2NrIHNob3VsZCBz
ZWUgMTAwJSB1cCB0byBkYXRlIGRhdGEgaW4gdGhlIGxvY2tlZCByYW5nZS4gSSBiZWxpZXZlDQpt
b3N0IChpZiBub3QgYWxsKSBub24tTGludXggY2xpZW50cyB1c2Ugc2ltaWxhciBzZW1hbnRpY3Mg
d2hlbg0KdGFraW5nL3JlbGVhc2luZyBieXRlIHJhbmdlIGxvY2tzLCBzbyB0aGV5IHRvbyBzaG91
bGQgYmUgZmluZS4NCg0KVGhlIG9ubHkgMiBpc3N1ZXMgSSBjYW4gdGhpbmsgb2Ygb2ZmaGFuZCB0
aGF0IG1pZ2h0IGJsb3cgdGhpbmdzIHVwIGFyZToNCg0KICAgMS4gVGhlIGNsaWVudCB0aGlua3Mg
aXQgaG9sZHMgYSBkZWxlZ2F0aW9uIHdoZW4gaXQgZG9lcyBub3QgKGUuZy4NCiAgICAgIGJlY2F1
c2UgdGhlIGRlbGVnYXRpb24gd2FzIHJldm9rZWQpIGNhdXNpbmcgaXQgdG8gYXNzdW1lIGl0IGNh
bg0KICAgICAgY2FjaGUgYWdncmVzc2l2ZWx5Lg0KICAgMi4gVGhlIGNoYW5nZSBhdHRyaWJ1dGUg
b24gdGhlIHNlcnZlciBpbXBsZW1lbnRhdGlvbiBpcyBiYXNlZCBvbiBhDQogICAgICBjdGltZSB3
aXRoIGNyYXBweSByZXNvbHV0aW9uIHRoYXQgY2F1c2VzIHRoZSBjbGllbnQgdG8gYmVsaWV2ZSB0
aGUNCiAgICAgIGRhdGEgaGFzIG5vdCBjaGFuZ2VkIG9uIHRoZSBzZXJ2ZXIgZXZlbiB0aG91Z2gg
aXQgaGFzIChhLmsuYS4gJ2V4dDMNCiAgICAgIHN5bmRyb21lJykuDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
