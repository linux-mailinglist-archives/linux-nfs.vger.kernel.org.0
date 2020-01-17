Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C0140FC9
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgAQRYa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 12:24:30 -0500
Received: from mail-bn7nam10on2114.outbound.protection.outlook.com ([40.107.92.114]:6080
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbgAQRYa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Jan 2020 12:24:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frnuG48LlBhLXHY4LoLOvifgu6y7yXto91fLwu2q54NoI+PU3J/qEGOYS1IPEduuANOqrmsCpzVz5grjJUT6GmRwbfwtE5lUI/XFiCT6viqSosj9Bb2mlwQ3qdjg7mOnpgTEmT5YKVP8/kX3C/eRlgAqjmXZqMttrf7LvRt4KAZ2SzY/sDKaLaX+vPDHOVhWZ+nfc9hmNsFKHGsGFWBAeXNXYQkwI6tHkHTnLz/CZcZHKjDUyxt+OLN/kTdGZhNSDj5Iy5eCF2w2jR+d/8iOENcnO5VCsrPPIdwhPJmqwKkb0psxjJHCCsqq89oPfC43Eco8JVVqtuaS1Kn+FV3q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W5bpHMFtKh9x6qJNtYLkj8yngGfj7cSpL9RMpqkRGo=;
 b=AmvXL80UtKkTgNaNbqKCME2o3YbB+p2FoJyrEaaWoZVkcCF1zJJH6EqCI72m0zIW77OkssXcVgsYZ6wypp0lenBJaQFK6omZK8//wHLv5OBE12xfO0Mmv11vRTzhlxgicRN5TeMV3aqEGjD0ehW1s2zSokYlQS2ZM3VPo6hQ2llB4d8+a8UmjsgMccR3ilTG/xeExlF0C2ExiWjJ19rdfoXe3i8rkuNlWMqm5edZEDNai3rcR3Ln06OR0czEorw1f7hQ/fn46AwUr4V8jewJJkxxdXaYKJ8pKvx167BlLYGj0vCT9xJRhTdlXPSkmal0xMlDe82EfFSvC5kUxidM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W5bpHMFtKh9x6qJNtYLkj8yngGfj7cSpL9RMpqkRGo=;
 b=SHDcYYIc9k9XXqKnm4ewxpEp9a2v7QsdK2slWoSHe9WgkOozXPob7c+wckfMygAthLxaOtaeFXasNAA6ME/jALUQ2KvHx58kZtRGbyvcIC3aaxgTJ5bcBnrAhDp7M2qMYqdm4VQf+UQRbkmnwSk+edOEb6tVJJKJrgwSOPX85Rs=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2057.namprd13.prod.outlook.com (10.174.182.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Fri, 17 Jan 2020 17:24:26 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d32:cf4b:1b58:16ce%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 17:24:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmilkowski@gmail.com" <rmilkowski@gmail.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Thread-Topic: [PATCH v2] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Thread-Index: AdXGbKgtqm1QJU8yQtKfQBn7K7s7ZQG5DpoAAAKE7AA=
Date:   Fri, 17 Jan 2020 17:24:26 +0000
Message-ID: <962370db9ae3ba5a17ba390afe7f9de6cea571d4.camel@hammerspace.com>
References: <115c01d5c66d$5dcd7ae0$196870a0$@gmail.com>
         <041101d5cd50$e398d720$aaca8560$@gmail.com>
In-Reply-To: <041101d5cd50$e398d720$aaca8560$@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0875d8c8-cd4f-4ded-f0cc-08d79b721a26
x-ms-traffictypediagnostic: DM5PR1301MB2057:
x-microsoft-antispam-prvs: <DM5PR1301MB2057077C040FFCA929380B52B8310@DM5PR1301MB2057.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(39830400003)(346002)(136003)(199004)(189003)(478600001)(6512007)(36756003)(186003)(6486002)(8936002)(8676002)(54906003)(110136005)(81156014)(81166006)(2906002)(66946007)(91956017)(26005)(4326008)(76116006)(6506007)(53546011)(66476007)(71200400001)(64756008)(66556008)(5660300002)(66446008)(316002)(86362001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2057;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3eS47LRlZumfQDi9eCLkepJSS1XUgxEkviFNCBT/4SsuJi7ovYqragR9TSvz1ygWs3ttPN1JIVjBO1WzQtdSy4ibdeJ74s69Yfhty4o7fvYYIgC4iprkwEyLZRyloDtV0po/7AMf70uFDAG+JX5XMkP0o8XpYDrdzXWgnW2aY2F6UfmmCQSJN0lXgwCLKsJyn10IWVnk8tc+8r3uwFogIxJTMfeM387naFEUCBWtfAo02MrhkmKkP86QBo0Za4jIA7YOGSCBdT0tzsFdBh1k2K/RpFlVPefq1ZLMSqevFLjFj4OF6QejlHEXwR4h1SU9Y/LjViM2QY8P+j8WulXGi6B+JzecANrKPw18E6JwUFdit6POKRI557gVud0mXqKwyq2/DDCvEWxnT5B12YQbeWbSmcQ2CKZ4UnQyENcyH+EelI/zqQOn0ECM5NenRkCd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2374AB5434DB7545BFA655E0F5C6D271@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0875d8c8-cd4f-4ded-f0cc-08d79b721a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 17:24:26.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiR1BAcQy16yWXZUtWvI2eSKcKgbZHz9dX1tLJ4cy9SHdxp9+Lna1ax1BoDPyEjZY3WtO9xaj+tTSoYgQ+RSDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2057
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTE3IGF0IDE2OjEyICswMDAwLCBSb2JlcnQgTWlsa293c2tpIHdyb3Rl
Og0KPiBBbnlvbmUgcGxlYXNlPw0KPiANCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFJvYmVydCBNaWxrb3dza2kgPHJtaWxrb3dza2lAZ21haWwuY29tPiANCj4gU2Vu
dDogMDggSmFudWFyeSAyMDIwIDIxOjQ4DQo+IFRvOiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiAnVHJvbmQgTXlrbGVidXN0JyA8dHJvbmRteUBoYW1tZXJzcGFjZS5jb20+OyAnQ2h1
Y2sgTGV2ZXInDQo+IDxjaHVjay5sZXZlckBvcmFjbGUuY29tPjsgJ0FubmEgU2NodW1ha2VyJyA8
YW5uYS5zY2h1bWFrZXJAbmV0YXBwLmNvbQ0KPiA+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gTkZTdjQ6IHRyeSBsZWFzZSByZWNvdmVyeSBv
biBORlM0RVJSX0VYUElSRUQNCj4gDQo+IEZyb206IFJvYmVydCBNaWxrb3dza2kgPHJtaWxrb3dz
a2lAZ21haWwuY29tPg0KPiANCj4gQ3VycmVudGx5LCBpZiBhbiBuZnMgc2VydmVyIHJldHVybnMg
TkZTNEVSUl9FWFBJUkVEIHRvIG9wZW4oKSwgZXRjLg0KPiB3ZSByZXR1cm4gRUlPIHRvIGFwcGxp
Y2F0aW9ucyB3aXRob3V0IGV2ZW4gdHJ5aW5nIHRvIHJlY292ZXIuDQo+IA0KPiBGaXhlczogMjcy
Mjg5YTNkZjcyICgiTkZTdjQ6IG5mczRfZG9faGFuZGxlX2V4Y2VwdGlvbigpIGhhbmRsZQ0KPiBy
ZXZva2UvZXhwaXJ5DQo+IG9mIGEgc2luZ2xlIHN0YXRlaWQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBS
b2JlcnQgTWlsa293c2tpIDxybWlsa293c2tpQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMv
bmZzNHByb2MuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMg
aW5kZXgNCj4gNzZkMzcxNi4uMjQ3ODQwNQ0KPiAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRw
cm9jLmMNCj4gKysrIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gQEAgLTQ4MSw2ICs0ODEsMTAgQEAg
c3RhdGljIGludCBuZnM0X2RvX2hhbmRsZV9leGNlcHRpb24oc3RydWN0DQo+IG5mc19zZXJ2ZXIN
Cj4gKnNlcnZlciwNCj4gIAkJCQkJCXN0YXRlaWQpOw0KPiAgCQkJCWdvdG8gd2FpdF9vbl9yZWNv
dmVyeTsNCj4gIAkJCX0NCj4gKwkJCWlmIChzdGF0ZSA9PSBOVUxMKSB7DQo+ICsJCQkJbmZzNF9z
Y2hlZHVsZV9sZWFzZV9yZWNvdmVyeShjbHApOw0KPiArCQkJCWdvdG8gd2FpdF9vbl9yZWNvdmVy
eTsNCj4gKwkJCX0NCj4gIAkJCS8qIEZhbGwgdGhyb3VnaCAqLw0KPiAgCQljYXNlIC1ORlM0RVJS
X09QRU5NT0RFOg0KPiAgCQkJaWYgKGlub2RlKSB7DQo+IC0tDQo+IDEuOC4zLjENCj4gDQo+IA0K
DQpEb2VzIHRoaXMgYXBwbHkgdG8gYW55IGNhc2Ugb3RoZXIgdGhhbiBORlM0RVJSX0VYUElSRUQg
aW4gdGhlIHNwZWNpZmljDQpjYXNlIG9mIG5mczRfZG9fb3BlbigpPyBJIGNhbid0IHNlZSB0aGF0
IGl0IGRvZXMuIEl0IGxvb2tzIHRvIG1lIGFzIGlmDQp0aGUgb3BlbiByZWNvdmVyeSByb3V0aW5l
cyBhbHJlYWR5IGhhdmUgdGhlaXIgb3duIGhhbmRsaW5nIG9mIHRoaXMNCmNhc2UuDQoNCklmIHNv
LCB3aHkgbm90IGp1c3QgYWRkIGl0IGFzIGEgc3BlY2lhbCBjYXNlIGluIHRoZSBuZnM0X2RvX29w
ZW4oKQ0KZXJyb3IgaGFuZGxpbmc/IE90aGVyd2lzZSB0aGlzIHBhdGNoIHdpbGwgZW5kIHVwIG92
ZXJyaWRpbmcgb3RoZXINCmdlbmVyaWMgY2FzZXMgd2hlcmUgd2UgaGF2ZSBhbiBpbm9kZSwgYnV0
IG5vIG9wZW4gc3RhdGUuDQoNCk5vdGUgdGhhdCBfbmZzNF9kb19vcGVuKCkgYWxyZWFkeSB3YWl0
cyBmb3IgbGVhc2UgcmVjb3ZlcnksIHNvIHdlIG9ubHkNCm5lZWQgdGhlIGNhbGwgdG8gbmZzX3Nj
aGVkdWxlX2xlYXNlX3JlY292ZXJ5KCkuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
