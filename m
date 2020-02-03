Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD7151106
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 21:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgBCUbg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 15:31:36 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:17370
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbgBCUbf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Feb 2020 15:31:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqp2KyrfcxnzaVJRLQOCrwQq50+flQMbfhtqjmFD2B73NyXBpPIBiGmXdX22WcK7flXP78ZB1+jzS6gYE1XxYyhzadyUGqS+SkbSciyd+7qFbbBpcRtSaiOZnwgByZb8E12HMamNjlmTczPzBjGH8funX6WlaI5Ov7N2djwz3mRCOv0y3xx0nNENxoOJNuM+WWHjiQgnDESLpEt4fWoko2bUSUSa1UR/157gfrVQSL+yaz0hkbwInZlpSGuOQFUdMyfHkGoxHLUv3F5HxA/OylvMwYHtufVJfhipDyuZGp9i98DL0Rm4h85eiMmt7F1xwzzAH1gP3k1aWjhJhc2/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtVNEdxpj6yu2HbcvGeeuIx+KPaNftzH+mKP1fYVems=;
 b=EgpvcBOOihvvvI5WPwGFsppWEpfLy2OmCqQqNbP4EZb8W50JGXm9zwqPWu/Xws81mM9JplwTdoOAXJZJ2lg+Dr49v/nNXDTeVI4fD4Z2opIROMHUytoWnnMY2iiFbSpblH6o033hAyekA+AzgitOtGTm5oCYeeSziuAhLSn174VQAjk7BUp/Wh0qblGZ3pts92X6+jfr8Cb1COpXD2lfninFXOPNLWYH1Qpar9udRcrSOeiTXSe24x784ZS5/Y7CM6B9APOnYd2sAN7LiMfbTQmlfeFJN/OnkCm9R+uQgOOJYaY2Y99KR6S+tj0KVtfjzWOYFZEe3t2tJpUcJY6kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtVNEdxpj6yu2HbcvGeeuIx+KPaNftzH+mKP1fYVems=;
 b=SjnILQLoERYgl1NBQB6qIcTb3NbZyF4TbQfzhOb8/Nsusto6K46EufqFFHz8AfGEj+1y1aU9u4UaFz3HRV0o0izZ0HOaF20MGsbvNo9i0rLW4YpdpnFhTrCuOsfnFt/o69/9aVhmp35AelgseuHAffuGOXnzpSHt3TA3/yv7KRI=
Received: from DM6PR06MB6091.namprd06.prod.outlook.com (20.179.161.77) by
 DM6PR06MB6458.namprd06.prod.outlook.com (20.180.22.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 20:31:31 +0000
Received: from DM6PR06MB6091.namprd06.prod.outlook.com
 ([fe80::f1f3:b30c:a1bc:ad26]) by DM6PR06MB6091.namprd06.prod.outlook.com
 ([fe80::f1f3:b30c:a1bc:ad26%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 20:31:31 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "trondmy@gmail.com" <trondmy@gmail.com>
CC:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Topic: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Thread-Index: AQHV2hv46pnojp8PA0aFY+L/g5EnF6gJ7Z0A
Date:   Mon, 3 Feb 2020 20:31:31 +0000
Message-ID: <16a7298dacd9fd1d08cd26b7073e9ced62c5fa24.camel@netapp.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
         <20200202225356.995080-2-trond.myklebust@hammerspace.com>
         <20200202225356.995080-3-trond.myklebust@hammerspace.com>
In-Reply-To: <20200202225356.995080-3-trond.myklebust@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2f23b27-ce9e-437a-b357-08d7a8e80dfe
x-ms-traffictypediagnostic: DM6PR06MB6458:
x-microsoft-antispam-prvs: <DM6PR06MB64581A613AB2085D759C54E1F8000@DM6PR06MB6458.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(6916009)(36756003)(86362001)(71200400001)(66476007)(2616005)(5660300002)(316002)(4326008)(76116006)(478600001)(66556008)(26005)(8936002)(64756008)(66446008)(81156014)(54906003)(81166006)(91956017)(186003)(66946007)(8676002)(2906002)(6486002)(6506007)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB6458;H:DM6PR06MB6091.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbBA4sB/cNoYhK7DUiFNUrf7MN3KZrqjF5CjGftKv/736VU3yKABf//84KQoa/y+4bXQTrGJn1TQJoApJy7qPYH0BdSn+EeUhCHYUEhyHOCNkVcqzSoVnClzUXGJ8ZOgNSaFPteiXIPYTLZ9O3uB9ZPQ4Jc6teVk4mW1UjpNLQB2i59o1K/Iy4+k0CKmw7X8E92Zu7o1RLRj+HZ+pMwX67HVXw6jaNbscNwXddTOfBmEGONvjQp3qmu/9yiS4AgH7khibDOydDLcl+eI1yj00SMvd/TOSu9q+iP0TS1RRQX+9HiotAxJ2sFiQPlzT4QyGZm1eUEFGKRl15dCqDxNSKvJBEeSg3B5gdzQK9oRUPqSGGx2xN9I6fsARLFVaSI1bC6fKtuqOvcw19bHQ9qsHhSSRjY5qd0SyDnFlhUDaixc8la8yKL1uYG+UtZiC98+
x-ms-exchange-antispam-messagedata: dLWFJlaJS33uUN8IWw04tDbkGmmtRcquI9lcG33IUjjwiEEhBnH7OSITIvGyzPvOgX+4D4IafXnYpzNWCyieDbOIZJLFeK9G75aeNPY+4wtlNHC5kZgVM8VfhYt5E0m82o+snMcXGprQlxN/nb1keQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DABBEA42F0621469EC638B5BF85553B@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f23b27-ce9e-437a-b357-08d7a8e80dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 20:31:31.5430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klDVqFyv7XI1C8aMMQgVtnuBz9q/Y0s11thtfQVY5tzYFOAPX1Nz8XiXWoFjt7mfzLrDDXctSXTvLHoWimLtUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6458
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgVHJvbmQsDQoNCk9uIFN1biwgMjAyMC0wMi0wMiBhdCAxNzo1MyAtMDUwMCwgVHJvbmQgTXlr
bGVidXN0IHdyb3RlOg0KPiBXaGVuIGEgTkZTIGRpcmVjdG9yeSBwYWdlIGNhY2hlIHBhZ2UgaXMg
cmVtb3ZlZCBmcm9tIHRoZSBwYWdlIGNhY2hlLA0KPiBpdHMgY29udGVudHMgYXJlIGZyZWVkIHRo
cm91Z2ggYSBjYWxsIHRvIG5mc19yZWFkZGlyX2NsZWFyX2FycmF5KCkuDQo+IFRvIHByZXZlbnQg
dGhlIHJlbW92YWwgb2YgdGhlIHBhZ2UgY2FjaGUgZW50cnkgdW50aWwgYWZ0ZXIgd2UndmUNCj4g
ZmluaXNoZWQgcmVhZGluZyBpdCwgd2UgbXVzdCB0YWtlIHRoZSBwYWdlIGxvY2suDQo+IA0KPiBG
aXhlczogMTFkZTNiMTFlMDhjICgiTkZTOiBGaXggYSBtZW1vcnkgbGVhayBpbiBuZnNfcmVhZGRp
ciIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjIuNi4zNysNCj4gU2lnbmVkLW9m
Zi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0K
PiAtLS0NCj4gIGZzL25mcy9kaXIuYyB8IDMwICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYw0KPiBpbmRleCBi
YTBkNTU5MzBlOGEuLjkwNDY3YjQ0ZWMxMyAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2Rpci5jDQo+
ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiBAQCAtNzA1LDggKzcwNSw2IEBAIGludCBuZnNfcmVhZGRp
cl9maWxsZXIodm9pZCAqZGF0YSwgc3RydWN0IHBhZ2UqIHBhZ2UpDQo+ICBzdGF0aWMNCj4gIHZv
aWQgY2FjaGVfcGFnZV9yZWxlYXNlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdCAqZGVzYykNCj4g
IHsNCj4gLQlpZiAoIWRlc2MtPnBhZ2UtPm1hcHBpbmcpDQo+IC0JCW5mc19yZWFkZGlyX2NsZWFy
X2FycmF5KGRlc2MtPnBhZ2UpOw0KPiAgCXB1dF9wYWdlKGRlc2MtPnBhZ2UpOw0KPiAgCWRlc2Mt
PnBhZ2UgPSBOVUxMOw0KPiAgfQ0KPiBAQCAtNzIwLDE5ICs3MTgsMjggQEAgc3RydWN0IHBhZ2Ug
KmdldF9jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdA0KPiAqZGVzYykNCj4gIA0K
PiAgLyoNCj4gICAqIFJldHVybnMgMCBpZiBkZXNjLT5kaXJfY29va2llIHdhcyBmb3VuZCBvbiBw
YWdlIGRlc2MtPnBhZ2VfaW5kZXgNCj4gKyAqIGFuZCBsb2NrcyB0aGUgcGFnZSB0byBwcmV2ZW50
IHJlbW92YWwgZnJvbSB0aGUgcGFnZSBjYWNoZS4NCj4gICAqLw0KPiAgc3RhdGljDQo+IC1pbnQg
ZmluZF9jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdCAqZGVzYykNCj4gK2ludCBm
aW5kX2FuZF9sb2NrX2NhY2hlX3BhZ2UobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90ICpkZXNjKQ0K
PiAgew0KPiAgCWludCByZXM7DQo+ICANCj4gIAlkZXNjLT5wYWdlID0gZ2V0X2NhY2hlX3BhZ2Uo
ZGVzYyk7DQo+ICAJaWYgKElTX0VSUihkZXNjLT5wYWdlKSkNCj4gIAkJcmV0dXJuIFBUUl9FUlIo
ZGVzYy0+cGFnZSk7DQo+IC0NCj4gLQlyZXMgPSBuZnNfcmVhZGRpcl9zZWFyY2hfYXJyYXkoZGVz
Yyk7DQo+ICsJcmVzID0gbG9ja19wYWdlX2tpbGxhYmxlKGRlc2MtPnBhZ2UpOw0KPiAgCWlmIChy
ZXMgIT0gMCkNCj4gLQkJY2FjaGVfcGFnZV9yZWxlYXNlKGRlc2MpOw0KPiArCQlnb3RvIGVycm9y
Ow0KPiArCXJlcyA9IC1FQUdBSU47DQo+ICsJaWYgKGRlc2MtPnBhZ2UtPm1hcHBpbmcgIT0gTlVM
TCkgew0KPiArCQlyZXMgPSBuZnNfcmVhZGRpcl9zZWFyY2hfYXJyYXkoZGVzYyk7DQo+ICsJCWlm
IChyZXMgPT0gMCkNCj4gKwkJCXJldHVybiAwOw0KPiArCX0NCj4gKwl1bmxvY2tfcGFnZShkZXNj
LT5wYWdlKTsNCj4gK2Vycm9yOg0KPiArCWNhY2hlX3BhZ2VfcmVsZWFzZShkZXNjKTsNCj4gIAly
ZXR1cm4gcmVzOw0KPiAgfQ0KPiAgDQoNCkNhbiB5b3UgZ2l2ZSBtZSBzb21lIGd1aWRhbmNlIG9u
IGhvdyB0byBhcHBseSB0aGlzIG9uIHRvcCBvZiBEYWkncyB2MiBwYXRjaCBmcm9tDQpKYW51YXJ5
IDIzPyBSaWdodCBub3cgSSBoYXZlIHRoZSBuZnNpLT5wYWdlX2luZGV4IGdldHRpbmcgc2V0IGJl
Zm9yZSB0aGUNCnVubG9ja19wYWdlKCk6DQoNCkBAIC03MzIsMTUgKzczMywyNCBAQCBpbnQgZmlu
ZF9jYWNoZV9wYWdlKG5mc19yZWFkZGlyX2Rlc2NyaXB0b3JfdCAqZGVzYykNCiAJaWYgKElTX0VS
UihkZXNjLT5wYWdlKSkNCiAJCXJldHVybiBQVFJfRVJSKGRlc2MtPnBhZ2UpOw0KIA0KLQlyZXMg
PSBuZnNfcmVhZGRpcl9zZWFyY2hfYXJyYXkoZGVzYyk7DQorCXJlcyA9IGxvY2tfcGFnZV9raWxs
YWJsZShkZXNjLT5wYWdlKTsNCiAJaWYgKHJlcyAhPSAwKQ0KIAkJY2FjaGVfcGFnZV9yZWxlYXNl
KGRlc2MpOw0KKwkJZ290byBlcnJvcjsNCisJcmVzID0gLUVBR0FJTjsNCisJaWYgKGRlc2MtPnBh
Z2UtPm1hcHBpbmcgIT0gTlVMTCkgew0KKwkJcmVzID0gbmZzX3JlYWRkaXJfc2VhcmNoX2FycmF5
KGRlc2MpOw0KKwkJaWYgKHJlcyA9PSAwKQ0KKwkJCXJldHVybiAwOw0KKwl9DQogDQogCWRlbnRy
eSA9IGZpbGVfZGVudHJ5KGRlc2MtPmZpbGUpOw0KIAlpbm9kZSA9IGRfaW5vZGUoZGVudHJ5KTsN
CiAJbmZzaSA9IE5GU19JKGlub2RlKTsNCiAJbmZzaS0+cGFnZV9pbmRleCA9IGRlc2MtPnBhZ2Vf
aW5kZXg7DQotDQorCXVubG9ja19wYWdlKGRlc2MtPnBhZ2UpOw0KK2Vycm9yOg0KKwljYWNoZV9w
YWdlX3JlbGVhc2UoZGVzYyk7DQogCXJldHVybiByZXM7DQogfQ0KIA0KDQpQbGVhc2UgbGV0IG1l
IGtub3cgaWYgdGhlcmUgaXMgYSBiZXR0ZXIgd2F5IHRvIGhhbmRsZSB0aGUgY29uZmxpY3QhDQoN
CkFubmENCg0KDQo+IEBAIC03NDcsNyArNzU0LDcgQEAgaW50IHJlYWRkaXJfc2VhcmNoX3BhZ2Vj
YWNoZShuZnNfcmVhZGRpcl9kZXNjcmlwdG9yX3QNCj4gKmRlc2MpDQo+ICAJCWRlc2MtPmxhc3Rf
Y29va2llID0gMDsNCj4gIAl9DQo+ICAJZG8gew0KPiAtCQlyZXMgPSBmaW5kX2NhY2hlX3BhZ2Uo
ZGVzYyk7DQo+ICsJCXJlcyA9IGZpbmRfYW5kX2xvY2tfY2FjaGVfcGFnZShkZXNjKTsNCj4gIAl9
IHdoaWxlIChyZXMgPT0gLUVBR0FJTik7DQo+ICAJcmV0dXJuIHJlczsNCj4gIH0NCj4gQEAgLTc4
Niw3ICs3OTMsNiBAQCBpbnQgbmZzX2RvX2ZpbGxkaXIobmZzX3JlYWRkaXJfZGVzY3JpcHRvcl90
ICpkZXNjKQ0KPiAgCQlkZXNjLT5lb2YgPSB0cnVlOw0KPiAgDQo+ICAJa3VubWFwKGRlc2MtPnBh
Z2UpOw0KPiAtCWNhY2hlX3BhZ2VfcmVsZWFzZShkZXNjKTsNCj4gIAlkZnByaW50ayhESVJDQUNI
RSwgIk5GUzogbmZzX2RvX2ZpbGxkaXIoKSBmaWxsaW5nIGVuZGVkIEAgY29va2llICVMdTsNCj4g
cmV0dXJuaW5nID0gJWRcbiIsDQo+ICAJCQkodW5zaWduZWQgbG9uZyBsb25nKSpkZXNjLT5kaXJf
Y29va2llLCByZXMpOw0KPiAgCXJldHVybiByZXM7DQo+IEBAIC04MzIsMTMgKzgzOCwxMyBAQCBp
bnQgdW5jYWNoZWRfcmVhZGRpcihuZnNfcmVhZGRpcl9kZXNjcmlwdG9yX3QgKmRlc2MpDQo+ICAN
Cj4gIAlzdGF0dXMgPSBuZnNfZG9fZmlsbGRpcihkZXNjKTsNCj4gIA0KPiArIG91dF9yZWxlYXNl
Og0KPiArCW5mc19yZWFkZGlyX2NsZWFyX2FycmF5KGRlc2MtPnBhZ2UpOw0KPiArCWNhY2hlX3Bh
Z2VfcmVsZWFzZShkZXNjKTsNCj4gICBvdXQ6DQo+ICAJZGZwcmludGsoRElSQ0FDSEUsICJORlM6
ICVzOiByZXR1cm5zICVkXG4iLA0KPiAgCQkJX19mdW5jX18sIHN0YXR1cyk7DQo+ICAJcmV0dXJu
IHN0YXR1czsNCj4gLSBvdXRfcmVsZWFzZToNCj4gLQljYWNoZV9wYWdlX3JlbGVhc2UoZGVzYyk7
DQo+IC0JZ290byBvdXQ7DQo+ICB9DQo+ICANCj4gIC8qIFRoZSBmaWxlIG9mZnNldCBwb3NpdGlv
biByZXByZXNlbnRzIHRoZSBkaXJlbnQgZW50cnkgbnVtYmVyLiAgQQ0KPiBAQCAtOTAzLDYgKzkw
OSw4IEBAIHN0YXRpYyBpbnQgbmZzX3JlYWRkaXIoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdA0K
PiBkaXJfY29udGV4dCAqY3R4KQ0KPiAgCQkJYnJlYWs7DQo+ICANCj4gIAkJcmVzID0gbmZzX2Rv
X2ZpbGxkaXIoZGVzYyk7DQo+ICsJCXVubG9ja19wYWdlKGRlc2MtPnBhZ2UpOw0KPiArCQljYWNo
ZV9wYWdlX3JlbGVhc2UoZGVzYyk7DQo+ICAJCWlmIChyZXMgPCAwKQ0KPiAgCQkJYnJlYWs7DQo+
ICAJfSB3aGlsZSAoIWRlc2MtPmVvZik7DQo=
