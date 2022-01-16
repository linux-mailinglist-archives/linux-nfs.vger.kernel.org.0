Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E048FDB1
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jan 2022 16:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiAPPrR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 10:47:17 -0500
Received: from mail-mw2nam08on2125.outbound.protection.outlook.com ([40.107.101.125]:19424
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232426AbiAPPrR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 16 Jan 2022 10:47:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5/224V1gY6iqdokGbzUe+o81n0JVzWDoHDgGbjvPknv4/CTVXf5mmxTXCvY5WggFFEH7yl/WHP8I/HnCBTqyvvJ7rpEY4M1NJWZdLzp7cWpu4Vj2q8xE2DflcH4xrFJHC5cABEuEi6H2BzXTXriFsfHKHk9CJJgjAQ/v3+FerSS5Y/9ZMQ/UfQ35vqGKVrnsFMBV3IlwBNGwkuI3t8Wnmobih9a39bWyJjBH14J0fPeTOU+ghHagz41TgaWSvvyO+9WcDIkp7iEcdiYzCuYzM2yYnS4D/mmRGUbtcbF1tWRZbHHkPzUMM+Ebd9BjRJjBudTgphKHrh3BtaAo5J/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HqGkIwS+Mb3bQF1IeSwcSRRc95kwwTflJNDiTBDad8=;
 b=EHgjY8UKeaU3EX6/hnhg1MhQduzGzLI6+h4BzXfsMkx/kG52FIEf0p0jo0EgJ1IS8RkuU9NtyvTAwCubCK0HeERUXoW9EAjGc1HrAAaej/gb1WAGxCHiOhTmskgjrxwa7HC4ebOxq6LiKfnHpW82yDq+rgIDK1W6dWQujowpQZKxqtdcasrpQE6wXto6EZfX7yqwUXIkrjki7LUFUyr8NicvwAXXlc9TrverUlFsjeE7fbBe0v+jrhjX6SBSJo16lb7S70u4h3vrA3fDk9SDxnu5udtU01pKswrC+uTy7rN+mwi47Y9rPvAY4wTwQPtoLAqQ8eAk1yi4bm+rMiZAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HqGkIwS+Mb3bQF1IeSwcSRRc95kwwTflJNDiTBDad8=;
 b=BU14tPkYugrcB4nZFA4Tl8UfyqwEO+7QteyM5HU4BrrF31U9bTbV6LK3XttQOD6HvNO2DIgJ6CAnOegQ15fmybmHHKHwyqtLXDOVcPo8BzeMtiBvoMJyReVHelbMhqJwb1t7SnIDaGhJvWDK9akShMGMcwYo48mMd4RxzPAKeRg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BYAPR13MB2870.namprd13.prod.outlook.com (2603:10b6:a03:b0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.6; Sun, 16 Jan
 2022 15:47:14 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%4]) with mapi id 15.20.4909.006; Sun, 16 Jan 2022
 15:47:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trix@redhat.com" <trix@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: simplify check for freeing cn_resp
Thread-Topic: [PATCH] NFS: simplify check for freeing cn_resp
Thread-Index: AQHYCudmQhAs9BAlUEKcvJ0AyTNIL6xlytgA
Date:   Sun, 16 Jan 2022 15:47:14 +0000
Message-ID: <9362b77845cecef630cd2cf98e3daf557318941b.camel@hammerspace.com>
References: <20220116144301.399581-1-trix@redhat.com>
In-Reply-To: <20220116144301.399581-1-trix@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b878331-2742-48f2-db47-08d9d90777a4
x-ms-traffictypediagnostic: BYAPR13MB2870:EE_
x-microsoft-antispam-prvs: <BYAPR13MB28705BB66678DC19CD0AA374B8569@BYAPR13MB2870.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CzoZpHi+07LvyzCY/3weVsx97YinndD7sMOFn5GkA9qeSTN9sb2fw8ticJUd1d4wEhKnY1zwpB0/PDy9V9LK8smo7AxmY65v2VxLBxIVQRNrd4DwcFAbO/xavYEcs7n/O150Wm06DfvFg+QtgpWu3Hzon/CGaQU3N1Y74cVf+6WqNAm2aTrMIOU8hC7vdRGgsANLmxanD4905h3lGVlnEWdS8Ve4w7hbWCRJT6Qp50w+Vn3r3GWv2s1eqma0RstG3UrRC7gmj4tY7n7XiLGybQq+75pRzindZzmWTmXeWM5W5buvRKoeXWyIcMMyjcgJIy4YDgavDbF/nJ6JLKVA94GwrFezRfPN+kfkuFswMgsLS086rmGeX6ZuOd9irfPG7StzCQhoR9laZy9yFt6kGHgS22Zyu0kCnBtdP2uQG/k01Fkbf+wwciuED69hiBpvfhP+BW9CyxyszbCZqsg3YgTP+ON3IvH8Laq1F+IJ9yQScNW+8x1q0szUTqAS/r0CeIj8NVzzwh9V8KgoybY6cEgsoJss6U66AxP9QnCSrVU51/HX7r3Jw3/iDdw/H8orRBPdRr3jmFSGnYCkl4ceebP5JLb09uYS6bmLxb6sCcUzQ4ThG3AwV9cphc3jsrC1u8se3/iz42BI1Dmjd5O+uy7OXQvIRNIZuh8p/6gAo7ZMc6GpTuPHfA0p8K5KqwrMf8B8XrdGTlOnl0LdXgJeTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(396003)(39830400003)(366004)(376002)(346002)(86362001)(2906002)(38070700005)(186003)(2616005)(26005)(6486002)(110136005)(54906003)(71200400001)(76116006)(508600001)(122000001)(8936002)(66556008)(6512007)(38100700002)(5660300002)(316002)(36756003)(8676002)(6506007)(4326008)(83380400001)(66946007)(64756008)(66446008)(66476007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXdXNUFHaVhJUXRGOWh0anpFSFQxVXoweURrS3orK2hGYmhCWmlwNStGbDl0?=
 =?utf-8?B?akZNZ0Z3S0N0NmsrZXF0S09xWndPR3hCSElpb2RNM0lBSjBlaHA1c1JkbjFm?=
 =?utf-8?B?RENHQ21BZ3ZqR1N2NXJQUGhLS25oNUw2Um8rdDByOEEyWUI2RlNSWEdndkZl?=
 =?utf-8?B?dnByaTVlK2tYWWhzakpDYkhBT2Z0aEl4ZHNJMHNCWDI1bEt4UjdMelpNdFd4?=
 =?utf-8?B?bm5ERUVrQkEvbndqbmJONm9aUGlGUUh0Y3Y4ajNlRXpLVFJNNHZpV0pBaWJI?=
 =?utf-8?B?djhUM1dXMkU2eStsMGxsdjRWUEkzcEVkWWxLOXFxYzV5VDRUOW9aT2FhZXVZ?=
 =?utf-8?B?YkRHdUZibXF1c3NIenJiYWhZVzN5dTZVT1lZcTZHaWRJTzVKQ3I1MnNoWnhZ?=
 =?utf-8?B?Z2NLMU9PM0tYS3drNDRzK3h4UkhFVmZGY2dpWDJlZDVEYjlqa05ORU9QMXY5?=
 =?utf-8?B?NGhjem9ncUFzNjFTNzJtWjh3bGl1WlFOcUtBc2M3YXR2ZTl3UCtsMVArdTJl?=
 =?utf-8?B?am1CVkZhNHpDOFZ2OTdZcXdSdExYcmR6VkM5SWd1Q1NIeXBQWXJKT05tRm42?=
 =?utf-8?B?em1SeElvUjZwQXVJcEtRS0x4dkdJUmR2Z2ZQMC8weHZqY3dZR0tLYi9CVkR1?=
 =?utf-8?B?UCthM01qSG81YWt5ZElVL1FkdGRUMGdUVlNSZkJHUUtBVW56bERET2lKRS9l?=
 =?utf-8?B?V1VDKy9YYUo4MFozdnNKWlNOZldiRG1ydDFySGkvV3hNa1NqZkhzRitqUkxV?=
 =?utf-8?B?cHh0Y2g3aE04RHFJdkNPazBiK28yU0NRVy8yNnhSOG1NSzBBR2Z1THpuZXpS?=
 =?utf-8?B?YWhGcnRESVZIUDJvNlZsNytGU1o1U2syOEp1YXRmdmlwdUw3NTRSYjdvUEFp?=
 =?utf-8?B?bnpqNWQvR1JHaFJ3dE5pQ1pKay9FN0RjSHZsQk9hd0xZb3pDVkdMeVh5cENX?=
 =?utf-8?B?UDlMZkg1bXlDaGkwOTMrNVQ5N0dIYTNqcThkL1pSWjhwZjc5TEhXVGxncEtT?=
 =?utf-8?B?ZFZhVlh1OEhHUkVUYlNKWEV4K0N3bnlSRHRiUmZoVUZSVXpXaXdHcEVuQnpw?=
 =?utf-8?B?VVVsdFJpdXVkYXRkTmRFN0dxbVU3ZW5ZenJUcUFPVnl6WXRmZ2tYZS96d0xF?=
 =?utf-8?B?aFVtOXJrMExkV2pBWXFhSGYzeFlPZERqTUdRcFNFQmZRYk1XKzZmcU9CUmdn?=
 =?utf-8?B?ZlVZTHYwWjMzZVJWMlBsMTFwd0Nkak9JRURBY1lDSjVGT1dGK09kNVZHajNh?=
 =?utf-8?B?Y25sRGhjbG5JTVp1bU5QT2JVdmNQVjRqQmxXTTdtNGxtaVhMSnNLamEySVBt?=
 =?utf-8?B?aEt1R3ByNDdNVFZ0QmZTaGphOXJyTUtRQWxmSmppOWxFY1ZxTCtHbUVMREt1?=
 =?utf-8?B?cklNakE5MFhoQVVwYnBvckdSSGpUMU9lTFRJWmt1TlRUa2NkKzFNSDYvT1NI?=
 =?utf-8?B?cGRUYkovUmxaVElxWEFWWmhCM2FneTZ5V2NINnloViswZE9hSXc1cHQ5dWxQ?=
 =?utf-8?B?YzBFc29jdjd2THBnZ0FkVTdVbnI2VnZJbzI5aTVzeGFxcndGN1ZwN1NqMmFi?=
 =?utf-8?B?V2JnUlEwbHV5aUczTzVvcVd5d21IeXpIeWE4b3RuenVrOHNwSyszamF6QVFP?=
 =?utf-8?B?dUZxZ3oxZUdzWE9VT2pVdXo5YzUzdEMyeHpxV1JZOExNWGxIdXBxUHB1WkFt?=
 =?utf-8?B?TENtbkE1b2pNOGNpdG9Vc1pqdTRiZWp3bnpDMlI3NzhyRkZIV3ExK2lNRnpT?=
 =?utf-8?B?OTQvZVFrUmxRWWdJdnEwa2FscXRoWEVEL1BpZWZxZU1lVXpCVTdKM0tRQ21x?=
 =?utf-8?B?MXJiUGJwejI1MEpGN0FrL3pnMFBhUEw3V0lQTWt1eUJlOTZ4OUdJRVRjZ2RM?=
 =?utf-8?B?eEZucHdMeHU5dEx2K3Z1S0ZtN0hWaXlKc2plNTZQQncxaktUZUlsQlZEc0l6?=
 =?utf-8?B?ZCtNSmFGOGl2ZU9KeDl3UW5vWUZETFVwWkRMdGl4SEJWcHRjczRPY1lqNlds?=
 =?utf-8?B?WFNtbnFQR2MyU2MzOG9xSlJUUmh3OWhMNEs0TnZ2cEw5MnBJRllFL1dQci9G?=
 =?utf-8?B?VUJFUFZub29KUkpnbUx3N082dnVwYmRvdUR1ZGYwQTFyWFJaazBLalltMXZr?=
 =?utf-8?B?ZUN3YlZEKzVBNE1mUnprcytKa09qYkdJYWtPSmZmd1JMMksyNjE5Z1o3QXlv?=
 =?utf-8?Q?IFkPOpM/F4HtDOowpWstMj8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34017DD5DB062244A307A43851BCEB6F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b878331-2742-48f2-db47-08d9d90777a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2022 15:47:14.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KPjIxCmpguCvnXXhkh/E8sVk+IAPmh3vfP/elcEE2USt1MdSzniTwezGShG78NZFkdItwEypasUJNcwiN98mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2870
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgVG9tLA0KDQpPbiBTdW4sIDIwMjItMDEtMTYgYXQgMDY6NDMgLTA4MDAsIHRyaXhAcmVkaGF0
LmNvbSB3cm90ZToNCj4gRnJvbTogVG9tIFJpeCA8dHJpeEByZWRoYXQuY29tPg0KPiANCj4gbmZz
NDJfZmlsZXNfZnJvbV9zYW1lX3NlcnZlcigpIGlzIGNhbGxlZCB0byBjaGVjayBpZiBmcmVlaW5n
DQo+IGNuX3Jlc3AgaXMgcmVxdWlyZWQuwqAgSW5zdGVhZCBvZiBjYWxsaW5nIGEgZnVuY3Rpb24s
IGNoZWNrDQo+IHRoZSBwb2ludGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVG9tIFJpeCA8dHJp
eEByZWRoYXQuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMvbmZzNGZpbGUuYyB8IDIgKy0NCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9mcy9uZnMvbmZzNGZpbGUuYyBiL2ZzL25mcy9uZnM0ZmlsZS5jDQo+IGluZGV4IGU3
OWFlNGNiYzM5NWUuLjY3NzYzMWVhNGNmYjMgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0Zmls
ZS5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0ZmlsZS5jDQo+IEBAIC0xODAsNyArMTgwLDcgQEAgc3Rh
dGljIHNzaXplX3QgX19uZnM0X2NvcHlfZmlsZV9yYW5nZShzdHJ1Y3QgZmlsZQ0KPiAqZmlsZV9p
biwgbG9mZl90IHBvc19pbiwNCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IG5mczQyX3Byb2NfY29w
eShmaWxlX2luLCBwb3NfaW4sIGZpbGVfb3V0LCBwb3Nfb3V0LA0KPiBjb3VudCwNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG5zcywgY25ycywgc3luYyk7DQo+IMKgb3V0Og0KPiAtwqDCoMKgwqDCoMKgwqBpZiAoIW5mczQy
X2ZpbGVzX2Zyb21fc2FtZV9zZXJ2ZXIoZmlsZV9pbiwgZmlsZV9vdXQpKQ0KPiArwqDCoMKgwqDC
oMKgwqBpZiAoY25fcmVzcCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBrZnJl
ZShjbl9yZXNwKTsNCg0KVGhlIGtlcm5lbCBjb252ZW50aW9uIGluIHRoZXNlIGNpcmN1bXN0YW5j
ZXMgaXMgdG8ganVzdCBza2lwIHRoZSBOVUxMDQpwb2ludGVyIGNoZWNrLCBzaW5jZSBrZnJlZSgp
IGRvZXMgdGhhdCBhbnl3YXkuDQoNCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQgPT0gLUVBR0FJ
TikNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIHJldHJ5Ow0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
