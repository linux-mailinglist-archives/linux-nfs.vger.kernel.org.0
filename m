Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3453B68F6
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 21:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhF1TUO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 15:20:14 -0400
Received: from mail-bn8nam11on2095.outbound.protection.outlook.com ([40.107.236.95]:49633
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235667AbhF1TUN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Jun 2021 15:20:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChBYzW7IY7WrwAK/TLlO/1GuX2zNIMgxr9MyioJvvng5w0UpPGAYRLTx8rH9Fbvyj6hcwr1DIrRa9HOeYznzc1s19Hpbt4Vy5jEs1ypAQD1CFYbYup5QnmdLx+YRXcjWZ0NNZeXAXdCqzTWwgKJOdZKN8B/nQrQZLbi2+7kZwvlYPS89XjX+r1nlmzRT9x2ef4SGIFJMTPjGcSQBn4hleQWPCQTjelgpak1lkmohmmRvFFesqrJSG9uuAoISteDC5MqE1/d3KnByc7+bidOnoEWXmVhiyCuTUAnFKJIcGt30VT2h9eHt1PCJiTYu0lIkdyEQ5AS5e7lTT7oNXbmJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYqP2h2Sd6aaEjli3VZBf60j7aAZagjHPTAanC87Zrg=;
 b=HAb0ULze1vZ5jraduI30JaFuCfKXY8k9MLCtLE1w0uGp0O9k81a6kMzBNffxZiPMTmmWhff58v4uq7sw/qwlffdPJCV9fPpnrEzLx06DoCywkl19guyVTwLqS6FhnNHUFRvXNwIAixknklmNYeIhIwXAggGRGIVlz25U89f8sMxOUeRPVREUKIPsF35G8A7zi/uoZOwr2FVVFdhcIM1suZ7yu+uhF3KXrPCehJtSIF4XaSo+RTgbGqi4q8+9xckRvaWF1miyGaZpaTALsv/mQiXQnXRTRX6zUL/2dmaTCNdW34kANPu+XGP192AwJIiEDHlpH6cuirgMX0Tr7oRfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYqP2h2Sd6aaEjli3VZBf60j7aAZagjHPTAanC87Zrg=;
 b=OniWrhhZg5QiIn9AeQqRqgDSU1/4viJ9mp5XBKiCy3fty7/GAzAZU1n/+YmQIkXSUVfV0B/+ROjrkt4E0GelqtNwyHFnSgaW8zhjMytSLgc6L8YSTlaQWaMkP6MbAQANnguOQPx2xbjMmj99vTo8n98QLc8iVdS4LIqoxN29sAI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4636.namprd13.prod.outlook.com (2603:10b6:610:dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8; Mon, 28 Jun
 2021 19:17:45 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 19:17:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] NFS: Ensure nfs_readpage returns promptly when
 internal error occurs
Thread-Topic: [PATCH 2/4] NFS: Ensure nfs_readpage returns promptly when
 internal error occurs
Thread-Index: AQHXbESBxYbm8C/KlUeWrZKSUbsmt6spzAIA
Date:   Mon, 28 Jun 2021 19:17:45 +0000
Message-ID: <2561b4f973e14eba413f648b657a7945830af202.camel@hammerspace.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
         <1624901943-20027-3-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1624901943-20027-3-git-send-email-dwysocha@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1318aae8-c358-4d35-d783-08d93a696909
x-ms-traffictypediagnostic: CH0PR13MB4636:
x-microsoft-antispam-prvs: <CH0PR13MB463648F7A2EDC67B3BE41E3CB8039@CH0PR13MB4636.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjofe+gG7pYh4Cw8xAx+yuL8Q36f+J7IVVK5Bi9b1HVxEJR9zT8BpL02ocPqo0gbP+MnBnxW2Mz41yWAvesHgZxNwsTA2NrSuX7dtUBGtcGU87GCS5ezTh1vfaUT6hbd2tmR4EydhjzIi1Pf1mkHDgi6yvqCGsDwKZhIycmph+vvCqDu1kjk+3RkCPYjx8RLiDIf6TSPy7DDSGquw2A5VgFV72S5dk4ZPktLvD+BsuKXNs83n2RhSKLfAucJ+/vLplbYS2OIEsIq8VnxxBIPr19Cwr8y33PqFf2JtHGhjD5cWkYFj0gZFZykZOF1mTdaz1h0LCHmOk/hoUGqMVhKsFl6hLE+5/e3ARH6PfbAFTTWEYai8yVmM3h764JUDoDXQqSqTTpePnqqBME43pqihZ4EpMUHqk9y7J/HL7LT5U/vRHfFE/2hJEWZhRwZYmsYzL22biIBxZRlpyrikmYeze45EGlkXpHNI4VbekskooJWHclyGmtK0JPkGqvYiMUYCPZjOFB94/86Xt9FhrwAZU7o8sw3bnZHiWOtjyalrFg5OKTz0JWw+e4/uPHO0cZCBz1W+XYIkt+bajwfXA4nBhU2axgDwh2Y/pNwHAzLvp5NbfNHl43kQuI/NOAMLVh+0KmEip04e5ywVAVvK9POHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(366004)(376002)(396003)(346002)(6486002)(8676002)(6506007)(316002)(110136005)(4326008)(8936002)(26005)(186003)(2616005)(6512007)(478600001)(83380400001)(66556008)(5660300002)(76116006)(36756003)(66476007)(86362001)(2906002)(122000001)(38100700002)(71200400001)(66946007)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlZUWXMwQ0x2MEV3Mm5SdDRtZ2h2dTlua1ZRQVNMazAzaFgrcURyK0dmemtx?=
 =?utf-8?B?MmZtYUtDRzJnVHR5VS9KK0hnZjg3SS9YbS9TOTB6US94UTNZc2hQQyswZldk?=
 =?utf-8?B?L2xaUk45UDBHTDA2ZmJ3Ymh6c2dTTkh5eVBoc213OEJocHR6ZjdyWG1UVjBY?=
 =?utf-8?B?QzB3aDhKMWNhQTFWcnRaTTNtenhVblB3Sm5oNEwxYW1yeUJ4TkNWU1o1djB6?=
 =?utf-8?B?THA4YUVoci9rNXZzN1RqbTdSVzVhS3ZXeUI5N2YwSjR3ZzU0N3BPWFBOQkp5?=
 =?utf-8?B?MlZmcVIzNnNJb21mcU4wbzYwU0NnbjZIR0FlSzhrcnVqL2RmcVhuaGx0RmdY?=
 =?utf-8?B?WnFET3N6dzEwTm1xQWV0d0NaYW1oVk5PUFhzUFhvZjdLUmJ1ZXgrWmEydjJi?=
 =?utf-8?B?RlVNQnhYVTNBQmRCVTk3S3VYZHpvQkFvTHcrb3Uyc0V5WllQckMwUGl6OWJG?=
 =?utf-8?B?ZHZyS3VkWkp0WVN5SUJWOEk3WkhOSGR0QkFNTjlxNmo3TThTNFdPYnFlVWts?=
 =?utf-8?B?ZHFQRTJWMk5IYU1pM3lqbEFxTkhUV0pGRGsxNkEzOXQwS3cwM0tsUEZyQUZa?=
 =?utf-8?B?K0NwR3hjSExQTlA0Z2Z0VWR3OGNVT2dBZkd1aTAzS2NQNU9ZQ20wWFdodTNS?=
 =?utf-8?B?ZzhFc0JVWEhlMmFkZi9MdE1XdDlMUUZxNFovcnBUVnpIQlB3bFQrNlh3andm?=
 =?utf-8?B?eWFYc3JuR3lGVGVsVktMaDYwVnU0K1daNWp1eVRUM1RwSWR6d0lVakYwNUhw?=
 =?utf-8?B?TTJkRURQM3dtd1lWN2t4NHZ5NDdrUTRaSGhPbStJcVY0dVBIN0gzckZITkNq?=
 =?utf-8?B?YVFteWlaVUFWU1RjWE41WHh4ckFjVGxiT1hQSS9WUU03ejNPL2tCLys3ZVU2?=
 =?utf-8?B?YzM1V3U3Yzcwd3NsVWZ4UkU4TEVJQ1JzM0JUakxEU1B0MlVDSjNjdEZkRDBl?=
 =?utf-8?B?RlJvQTJEWG5MSk45dE1zNFlTY2pBYUFLUU1tUWt4aVpmTmtOTkIwN2NVRWRJ?=
 =?utf-8?B?bENCL3VwUUFiV3I5VllKQXhleHRrUGFGMEUzdU9COHBDNVN0d0orRTFxZHZi?=
 =?utf-8?B?TzVTQUNkcHJrKzJoRmd6Ym5YN0RkZWF6Zjc5cWczSzV0aXo0VTF5Wkh5NjZ0?=
 =?utf-8?B?V0ZDOU9oNzc2VG91a3lqSVNIUG9mRDZrQS9TM3htYXcvMGVYYXQwQ0t5a3Fj?=
 =?utf-8?B?Lzk2TWpuS0c0aEh0a3lBTHFkKysrNllMUHFLem51Z0syYVp0VlhnaGFkL1RS?=
 =?utf-8?B?NnBnQXcxUHlxYy80WGFmWm1MWTBia2MzQU4zV09ISytiU2ZsRlVreDJxRXBT?=
 =?utf-8?B?THJwbUY3dzZlZmdyc2NGUXMxcUg3UHhTeVBORFhiQUFwSnQyck9QaUpPcnd4?=
 =?utf-8?B?by82aU1rRWp4NlFaZDRZM2o5SHljdldTcWJoYkVUYUpSVmdtQy9vZitNOUhp?=
 =?utf-8?B?TGJZOFNWMFJ3YmVSRHkyTjJMQTd0a3k1elhhRFJXZ1NkbDFIRHZCRkp2SE5w?=
 =?utf-8?B?QUt1NDBLRXJJNXk1cUs5czlndGFXczZaVnZ0bldsdDZGN1ZZR0VUL2FvVXRv?=
 =?utf-8?B?WUttajllMkxseUY1bmZlNUFqdm8ydjB2UXh1YWxaSTFHY2pBL3hud0h1a29V?=
 =?utf-8?B?bW0vbHh4SzNNQVZKQS9BQXZNWU5lK1I2VElYcDg4NC9zbFVFNGh6ZVpBdTVC?=
 =?utf-8?B?YmhEWnhyUlRJMFM0Njcvc1pObHFmcnFsTzBGWnd1TW8xQlRTUXBaQmY1czZF?=
 =?utf-8?Q?smspWkTf9gkq2a0d8HQLm7F0KXRPdBWxZT5p8RT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D68DD12EE7E4845BAB1D1B47D00D7FE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1318aae8-c358-4d35-d783-08d93a696909
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 19:17:45.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YD+W6p+Kz37+QONBAyTicMe4ndi88bWz8/w/91IND4R9j9yYWTpmkC9S9lZPzusNBbijAQhuIZDhH/E3UxE/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4636
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTI4IGF0IDEzOjM5IC0wNDAwLCBEYXZlIFd5c29jaGFuc2tpIHdyb3Rl
Og0KPiBBIHByZXZpb3VzIHJlZmFjdG9yaW5nIG9mIG5mc19yZWFkcGFnZSgpIG1pZ2h0IGVuZCB1
cCBjYWxsaW5nDQo+IHdhaXRfb25fcGFnZV9sb2NrZWRfa2lsbGFibGUoKSBldmVuIGlmIHJlYWRw
YWdlX2FzeW5jX2ZpbGxlcigpIGZhaWxlZA0KPiB3aXRoIGFuIGludGVybmFsIGVycm9yIGFuZCBw
Z19lcnJvciB3YXMgbm9uLXplcm8gKGZvciBleGFtcGxlLCBpZg0KPiBuZnNfY3JlYXRlX3JlcXVl
c3QoKSBmYWlsZWQpLsKgIEluIHRoZSBjYXNlIG9mIGFuIGludGVybmFsIGVycm9yLA0KPiBza2lw
IG92ZXIgd2FpdF9vbl9wYWdlX2xvY2tlZF9raWxsYWJsZSgpIGFzIHRoaXMgaXMgb25seSBuZWVk
ZWQNCj4gd2hlbiB0aGUgcmVhZCBpcyBzZW50IGFuZCBhbiBlcnJvciBvY2N1cnMgZHVyaW5nIGNv
bXBsZXRpb24gaGFuZGxpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZlIFd5c29jaGFuc2tp
IDxkd3lzb2NoYUByZWRoYXQuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMvcmVhZC5jIHwgMjEgKysr
KysrKysrKysrLS0tLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyks
IDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL3JlYWQuYyBiL2ZzL25m
cy9yZWFkLmMNCj4gaW5kZXggNjg0YTczMGY2NjcwLi5iMDY4MDM1MWRmMjMgMTAwNjQ0DQo+IC0t
LSBhL2ZzL25mcy9yZWFkLmMNCj4gKysrIGIvZnMvbmZzL3JlYWQuYw0KPiBAQCAtNzQsNyArNzQs
NyBAQCB2b2lkIG5mc19wYWdlaW9faW5pdF9yZWFkKHN0cnVjdA0KPiBuZnNfcGFnZWlvX2Rlc2Ny
aXB0b3IgKnBnaW8sDQo+IMKgfQ0KPiDCoEVYUE9SVF9TWU1CT0xfR1BMKG5mc19wYWdlaW9faW5p
dF9yZWFkKTsNCj4gwqANCj4gLXN0YXRpYyB2b2lkIG5mc19wYWdlaW9fY29tcGxldGVfcmVhZChz
dHJ1Y3QgbmZzX3BhZ2Vpb19kZXNjcmlwdG9yDQo+ICpwZ2lvKQ0KPiArc3RhdGljIGludCBuZnNf
cGFnZWlvX2NvbXBsZXRlX3JlYWQoc3RydWN0IG5mc19wYWdlaW9fZGVzY3JpcHRvcg0KPiAqcGdp
bykNCj4gwqB7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX3BnaW9fbWlycm9yICpwZ207
DQo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIG5wYWdlczsNCj4gQEAgLTg4LDYgKzg4
LDggQEAgc3RhdGljIHZvaWQgbmZzX3BhZ2Vpb19jb21wbGV0ZV9yZWFkKHN0cnVjdA0KPiBuZnNf
cGFnZWlvX2Rlc2NyaXB0b3IgKnBnaW8pDQo+IMKgwqDCoMKgwqDCoMKgwqBORlNfSShwZ2lvLT5w
Z19pbm9kZSktPnJlYWRfaW8gKz0gcGdtLT5wZ19ieXRlc193cml0dGVuOw0KPiDCoMKgwqDCoMKg
wqDCoMKgbnBhZ2VzID0gKHBnbS0+cGdfYnl0ZXNfd3JpdHRlbiArIFBBR0VfU0laRSAtIDEpID4+
DQo+IFBBR0VfU0hJRlQ7DQo+IMKgwqDCoMKgwqDCoMKgwqBuZnNfYWRkX3N0YXRzKHBnaW8tPnBn
X2lub2RlLCBORlNJT1NfUkVBRFBBR0VTLCBucGFnZXMpOw0KPiArDQo+ICvCoMKgwqDCoMKgwqDC
oHJldHVybiBwZ2lvLT5wZ19lcnJvciA8IDAgPyBwZ2lvLT5wZ19lcnJvciA6IDA7DQo+IMKgfQ0K
PiDCoA0KPiDCoA0KPiBAQCAtMzczLDE2ICszNzUsMTcgQEAgaW50IG5mc19yZWFkcGFnZShzdHJ1
Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHBhZ2UNCj4gKnBhZ2UpDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZuZnNfYXN5bmNfcmVhZF9j
b21wbGV0aW9uX29wcyk7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqByZXQgPSByZWFkcGFnZV9h
c3luY19maWxsZXIoJmRlc2MsIHBhZ2UpOw0KPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7DQo+IMKgDQo+IC3CoMKgwqDC
oMKgwqDCoGlmICghcmV0KQ0KDQpDYW4ndCB0aGlzIHBhdGNoIGJhc2ljYWxseSBiZSByZWR1Y2Vk
IHRvIHRoZSBhYm92ZSAyIGNoYW5nZXM/IFRoZSByZXN0DQphcHBlYXJzIGp1c3QgdG8gYmUgc2hp
ZnRpbmcgY29kZSBhcm91bmQuIEknbSBzZWVpbmcgbm90aGluZyBpbiB0aGUNCnJlbWFpbmluZyBw
YXRjaGVzIHRoYXQgYWN0dWFsbHkgZGVwZW5kcyBvbiBuZnNfcGFnZWlvX2NvbXBsZXRlX3JlYWQo
KQ0KcmV0dXJuaW5nIGEgdmFsdWUuDQoNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG5mc19wYWdlaW9fY29tcGxldGVfcmVhZCgmZGVzYy5wZ2lvKTsNCj4gK8KgwqDCoMKgwqDCoMKg
cmV0ID0gbmZzX3BhZ2Vpb19jb21wbGV0ZV9yZWFkKCZkZXNjLnBnaW8pOw0KPiArwqDCoMKgwqDC
oMKgwqBpZiAocmV0KQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7
DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gd2FpdF9vbl9wYWdlX2xvY2tlZF9raWxsYWJs
ZShwYWdlKTsNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFQYWdlVXB0b2RhdGUocGFnZSkgJiYgIXJl
dCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHhjaGcoJmRlc2MuY3R4
LT5lcnJvciwgMCk7DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoHJldCA9IGRlc2MucGdpby5wZ19l
cnJvciA8IDAgPyBkZXNjLnBnaW8ucGdfZXJyb3IgOiAwOw0KPiAtwqDCoMKgwqDCoMKgwqBpZiAo
IXJldCkgew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gd2FpdF9vbl9w
YWdlX2xvY2tlZF9raWxsYWJsZShwYWdlKTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmICghUGFnZVVwdG9kYXRlKHBhZ2UpICYmICFyZXQpDQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0geGNoZygmZGVzYy5jdHgtPmVycm9y
LCAwKTsNCj4gLcKgwqDCoMKgwqDCoMKgfQ0KPiDCoG91dDoNCj4gwqDCoMKgwqDCoMKgwqDCoHB1
dF9uZnNfb3Blbl9jb250ZXh0KGRlc2MuY3R4KTsNCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBy
ZXQ7DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
