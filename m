Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8933D504
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Mar 2021 14:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhCPNjQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Mar 2021 09:39:16 -0400
Received: from mail-bn7nam10on2101.outbound.protection.outlook.com ([40.107.92.101]:23041
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232085AbhCPNio (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Mar 2021 09:38:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yki1l7TpDv8tfh8L89U8aSAdmxtjNQAlExk0nskAZhPmB2INRFqeemDh7uYgBF//CzETCITfH4540W2aipvgKoNO+6MJDhFy28+wSk37enPYra1qEqa6dTMMksXjE/w2+Sq+ZbNf45s0rVrlJfWUcSK4+oTMuZLxR8hoaon+SNz8QlslkhtJBFUNgK9peQlTrMqJdn3xlw+yd25+BylAK/pq2tuUKnadje+dokigvhtO4bOLRzhe9aATP8fjwIxzOq0YP+vlvZE+0UlUg3dke7MhhchzEX1/tBGPOwHa+uDttotOalKM0OzC9DfznNwQk2bcfJT1zOev6JVHhNQg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6EO2NWDDbNLdNXMx6bW96kHerIE7kh8VfT78UE7PLc=;
 b=dooOfV8vxQPolLhXcgiuOLbbx4YiRlTFnlfGbM4o3NBt6XKGFXDKL1oLYh6d0khIj02FlZ/kkUONMFm3ey4yzNAmUmgtnf+UUWKCX+u+/202vcZdH+OcetU+1qz6y/3og+eIQ7FOXeYuyvbsqiq+1OSq76hbnjOp8Y7omObPSc0ECxh4UcoDyVip4a4UAnHc7fINfCsf5IzYwpAyf/h1xYCek+P8+9v21H7jX5jS10BcffqeyAE8To1tsUs4P3+YT/igTDr40IXOOo1TdZc+XNwLARJGGJR12bLiftJqqVLKryzEXdoF89agpK2l5N9Xru1NbGkISYGNS/c0GdcqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6EO2NWDDbNLdNXMx6bW96kHerIE7kh8VfT78UE7PLc=;
 b=AAKID0bhNCtKj/gcEvG6UD2FdOXk/g3kQXOhYWKjutz/dkhZTpp0OBoXvMF3omxpAgxJoAShKST/HzNDCclLS61EJM88olOH5M4KQ050aG6f6LcOy302Vl+PTCEQ/0R6FxSRCmQJiukWgvEusYu7Ou3mJkPTkl/16O1Kh+FyqFo=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB4522.namprd13.prod.outlook.com (2603:10b6:610:62::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.13; Tue, 16 Mar
 2021 13:38:36 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3955.010; Tue, 16 Mar 2021
 13:38:36 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Nagendra.Tomar@microsoft.com" <Nagendra.Tomar@microsoft.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: Subsequent READDIR calls should carry non-zero
 cookieverifier
Thread-Topic: [PATCH] nfs: Subsequent READDIR calls should carry non-zero
 cookieverifier
Thread-Index: AdcaTmABw9JrWsV8R0CYehOiwIkkQgAG0j8A
Date:   Tue, 16 Mar 2021 13:38:36 +0000
Message-ID: <309d0acaa6a40c0668429ff97096bb44f1d1ac3b.camel@hammerspace.com>
References: <KU1P153MB0197AE46D423F3AB32ADEF419E6B9@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KU1P153MB0197AE46D423F3AB32ADEF419E6B9@KU1P153MB0197.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce07b8b4-e694-4305-1aaf-08d8e880ccfa
x-ms-traffictypediagnostic: CH2PR13MB4522:
x-microsoft-antispam-prvs: <CH2PR13MB45224C028AC54C2D970CA0C1B86B9@CH2PR13MB4522.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8hXM5xrE63PzCgX27IRq2FeLtvZK2NXrAn1afawo6yucs68ZZ4SvQHA9+0n/u/DR7LnzAqmJk6ARaIhkohIUT2uTaBW13AoFrZ22646+rorIPNXoxMFrN12qqrPqwwjfd7hozN98cg7RgO0AYON54YfR5mdcOhHZv/G0n+npWbOwv+GXUHF+QpX7d5lEPYizrlSBGTRhNpYWhVYe1TZEDb5/yJwvjNJU9eLy8zImbqT1kgjoD1HBWaMowFEfDWXAte6C/CDcDEM6JA/ot9kv9btbv+lxHgpSVRaauiWVqwahA/rlIxo+isER2Q2cwbGZYeeS8WI2i2Vh9sXlo+G7Klp6CdYKqgl9VO1aNCm8MX/OsNc1WEtufZ5rqeKwpPGtzG0ZI3EBZI1GVZGfWgiPx+r+u8j+1aSWmEq0Wc3ZfnFOQUsDHO7mbajQjaRCyXPNWlFhTFJHMvtmYxdFMi/hxyrH9MOfQwM7LjarRR7d6WHZ7cmkM6/4llHjX58tX8jVgukuOIg/BWcrxJXrN/ld+Cayrh3AYlit0RSHTb7gTgCFqL2yyjQCO28PdcKpnHg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(376002)(39840400004)(396003)(6506007)(83380400001)(186003)(5660300002)(71200400001)(4326008)(66476007)(2616005)(8676002)(8936002)(86362001)(6512007)(26005)(66446008)(110136005)(36756003)(64756008)(6486002)(66556008)(76116006)(478600001)(316002)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d2ZjZFdPRUhiVEhiejRvZDdUeEV0TlpGZGFsQ3M1ckZlTE9XNUlmT0pFL2pT?=
 =?utf-8?B?c0ZIR0FsMnFKZWI2WEhlNER6akJBblJtL05vZnVEaFNsZlh1NzdINGJTSXFs?=
 =?utf-8?B?YUVUbVlPdk83WXk0S3g0YzA2WUg4VCs0OG45cExDd05DM2cxbHJxQ1Vnenl0?=
 =?utf-8?B?NE9TRGZCVHFGMldGQjBuWnNzVDZaRUsvVmhma3JRN01lT2RjTERxWTBmS0c3?=
 =?utf-8?B?cXpNWXM0U1E2ZW1qQkN5TWU0Q1kxUmlzWHk4dVBxSHNPTjQ2cFpEa2xKdUs4?=
 =?utf-8?B?S3RXMzZUZVBVNzBZZldTKy9kUW9ua0FUR01wUy9md21ldVljMWwzSGEwQWR3?=
 =?utf-8?B?cU9aUXZ4YXp3OHhtcTRwZEhaZHpEcWo4eHRaU0JsVkVPTFpuQTZaekFHN2gw?=
 =?utf-8?B?WXZsdHhSc0crMXhRMGlHWTEwOTMwamZsaGNTTlkxZjY5RWFIdXdseUVOME9T?=
 =?utf-8?B?NnpSd2ZaS3dSREtqOVBBWDVoWTVqcGxJZ3ZkTFdqMkw3bjQwNnd3bldFQ0Ju?=
 =?utf-8?B?dE85VldYTVl1WjlERm41RnJtaUJsd2RUYkt1TzlGYTJZdFVrYnViaU4zRkwv?=
 =?utf-8?B?ODNvb2F0SXBVejAvQkpsOTZoRFJES1ZGV05GYnBkUytCM2dYL3k3RENQZ2Rk?=
 =?utf-8?B?WXN2c0tWQUxSUitlQnRSTUZLR0JMSG1lejYvS2lKeHMzZHlEL1l2cGQ4andF?=
 =?utf-8?B?MnJwMHZWOTRWb0FxYkNQaEUrVTRyVktyNWo5ZlRHT3JwaUJWYS9Fb0NFMjFN?=
 =?utf-8?B?ZFRDV08zb2psSmVVbElxb01DZFhZSGdkWWM1VXNiaHp1ZUV0SEtiSVhuZU51?=
 =?utf-8?B?TGlYQnhOeHQxVG1zaUtLQTNJTUxjNFpIVFh2T0Rxb3ZiTXZVdVlhKzk5OTRC?=
 =?utf-8?B?S1lrRENpbVh1U1JOWWNFYU1uRVVZMDJyUnpOdEV3R1FQN3BqZG5URHpxc0tr?=
 =?utf-8?B?ald6OTZoRVArYTZoZnBmbklJeHUxU2ZBK0lJdVVUNmQ5MXh6VkU2b25wL2Fv?=
 =?utf-8?B?QXhPdVhnYnVkVEtCYlFBNVFYNjc3UzREVGJaWnlvTzE5d3ZHUm9lajZxRHVp?=
 =?utf-8?B?eE16anlGd25jNGM0L08rcEQrb1pzdy9XNnprYzVKUTVYZDl3bWs5cFlRcFNw?=
 =?utf-8?B?TWE5N1hSNmVBbFIxUXNra0xHN2ZJWEh4MVlFdVFIUG1YOEFIa2k0a0hQNXg5?=
 =?utf-8?B?MjJyQVF4SVEvbm05MzB2a2JoMGZrYXg3bHBDbWZEUWtCWnU0cW5GOTJmSTdo?=
 =?utf-8?B?TjRzajVoRDU3Ykc2b293ZnZ5MElqdkp0YlFuR0JQTjNlYzJRdS9lb2t1VDhv?=
 =?utf-8?B?Tzc1d1M5Y0VWdlRyRzByN1ByTjlTMWtvMGI1NmFZZ0VxcGI3SFZEZjhnRk16?=
 =?utf-8?B?NWhwYStmVXBZNzJjdldKblpNNlEyeHAvbGV6VkM0cDdWaStHV1o5YTlaVVNC?=
 =?utf-8?B?b3VvYlpaRHVleTFUQi80OUQyRVlXbXNRcEc5NHAvT1QvanRVaXBOdFRyT2Er?=
 =?utf-8?B?QUtQUWQ4TmNJcThBbkk3dE5ma2RHcC8vOGU3UFRlRnh0cDNZcUpXUkZFWmhx?=
 =?utf-8?B?RjdFVVlMV3IzQmxIQnNTSFFhdlNJcUVXWG5lVGdKYkJ6bkdkekNJbzdrbkNB?=
 =?utf-8?B?WVRxcDk4RVRucmF6T2dsb1RNWkVMVW00L01tekxTQTh2WHl6blgzNTF4SVdQ?=
 =?utf-8?B?eXlkbmFBUzI4VzFjRXkxOXR1OURPeVkxNUdxY1RWR2tPdHZyRTcrNGJHNHBN?=
 =?utf-8?Q?3l6ZaoPAoXHmtLD1bpV/lkftURA+LseGyhnRC+V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F795D3D069CBB74BBB16A293D0287F6C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce07b8b4-e694-4305-1aaf-08d8e880ccfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 13:38:36.3477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkBi16+N84Odf8YLDkenvXnp+5rYKYvHoxvFHluP4lXOA7s4Kd84DC6FQd7NtpNFmRihnpRcs30qCRAoE4TgUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4522
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAzLTE2IGF0IDEwOjI1ICswMDAwLCBOYWdlbmRyYSBUb21hciB3cm90ZToN
Cj4gRnJvbTogTmFnZW5kcmEgUyBUb21hciA8bmF0b21hckBtaWNyb3NvZnQuY29tPg0KPiANCj4g
SWYgdGhlIGxvb3AgaW4gbmZzX3JlYWRkaXJfeGRyX3RvX2FycmF5KCkgcnVucyBtb3JlIHRoYW4g
b25jZSwNCj4gc3Vic2VxdWVudA0KPiBSRUFERElSIFJQQ3MgbWF5IHdyb25nbHkgY2FycnkgYSB6
ZXJvIGNvb2tpZSB2ZXJpZmllciBhbmQgbm9uLXplcm8NCj4gY29va2llLg0KPiBNYWtlIHN1cmUg
c3Vic2VxdWVudCBjYWxscyB0byBSRUFERElSIGNhcnJ5IHRoZSBjb29raWUgdmVyaWZpZXINCj4g
cmV0dXJuZWQNCj4gYnkgdGhlIGZpcnN0IGNhbGwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOYWdl
bmRyYSBTIFRvbWFyIDxuYXRvbWFyQG1pY3Jvc29mdC5jb20+DQo+IC0tLQ0KPiBkaWZmIC0tZ2l0
IGEvZnMvbmZzL2Rpci5jIGIvZnMvbmZzL2Rpci5jDQo+IGluZGV4IGZjNGY0OTBmMmQ3OC4uMDhh
MWUyZTMxZDBiIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZGlyLmMNCj4gKysrIGIvZnMvbmZzL2Rp
ci5jDQo+IEBAIC04NjYsNiArODY2LDggQEAgc3RhdGljIGludCBuZnNfcmVhZGRpcl94ZHJfdG9f
YXJyYXkoc3RydWN0DQo+IG5mc19yZWFkZGlyX2Rlc2NyaXB0b3IgKmRlc2MsDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOw0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gwqANCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHZlcmZfYXJnID0gdmVyZl9yZXM7DQo+ICsNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBzdGF0dXMgPSBuZnNfcmVhZGRpcl9wYWdlX2ZpbGxlcihkZXNjLCBlbnRy
eSwgcGFnZXMsDQo+IHBnbGVuLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYXJyYXlzLCBuYXJyYXlzKTsNCj4gwqDCoMKgwqDCoMKgwqDCoH0gd2hpbGUgKCFzdGF0
dXMgJiYgbmZzX3JlYWRkaXJfcGFnZV9uZWVkc19maWxsaW5nKHBhZ2UpKTsNCg0KVGhhdCBsb29r
cyBnb29kIHRvIG1lLiBIb3dldmVyIHdoZW4gbG9va2luZyBvdmVyIHRoYXQgY29kZSwgSSB0aGlu
ayBJDQpzcG90dGVkIGEgc2ltaWxhciBpc3N1ZSB3aGVuIHdlJ3JlIGRvaW5nIHVuY2FjaGVkIHJl
YWRkaXIgaW4gb3JkZXIgdG8NCnRyeSB0byByZWNvdmVyIGEgbWlzc2luZyBjb29raWUuIEkgdGhl
cmVmb3JlIENjZWQgeW91IG9uIHRoZSBwb3N0aW5nDQpmb3IgdGhhdCBwYXRjaC4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
