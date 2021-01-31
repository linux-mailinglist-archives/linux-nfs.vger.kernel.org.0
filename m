Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AE4309EFB
	for <lists+linux-nfs@lfdr.de>; Sun, 31 Jan 2021 21:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhAaUme (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jan 2021 15:42:34 -0500
Received: from mail-bn8nam11on2112.outbound.protection.outlook.com ([40.107.236.112]:12541
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229644AbhAaUmc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 31 Jan 2021 15:42:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXIEs6uDKwdeK675AjbyBz43zrtsS3JRodR6QRkpMCGCr/QIsTyFbDjIq8Wuh6VD26rXNjhnGcIS13E8Pf6aAjMhkoXhVN7BVZrHvV2mNi2FjKIzcC2SFCFmpaAR23ybbaljSZLYoKrCWLh4txnPCFyyrqV9NW0/GbkcaScoekQCMKdazg7hlH0FiZDIQGpeVGT58Va1VedY97U9fE9S9uHDHqgF4zXYsF0QzaaafyNuR1c/Ctwd5HcQI2bLw8rCyfkzy7zaX4X4ohE5dJPl4Ppg9lXj9DzgXumI9PCIA75zJFDCKghCVGiOu8/20RbKHbMyMWIHNrQgQq1nTPSLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpTz4hTnbgf9D/TE2uAW+d5yyC5pnmioosxa0mEkbBU=;
 b=a9XV5BjBeP3KcCglSNZrF2eQ+SuORaA1eYcBk/7ajB7cyAz96Vwyj3V/h42/i8Rcza+uGiywwhuI1neQXJQGRHxB7DExO5phoxpQ0FjqtMRx+t4n8xSmVz7iKxBBU7wbg+88AEsRUoTIKAMe0b+FjI49OtL3MSwZUdGGBpI4D3cPokv1qnN4z2E4Q1LnsXwCcjKyksFhtiWx+cOFxHeU6QJ1EHMT8bdRyJB42aUY7h4cD/1KIIP+GSvJpjUKsreUIHYYy292GdXjT7As1NeIjObVmG8dD0Ldir7GX4kaBHqFI7LkLtB4vpjjnVZGvrCmhqA5dChPB/nepMMwKXXi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpTz4hTnbgf9D/TE2uAW+d5yyC5pnmioosxa0mEkbBU=;
 b=O98XmJjStHEfz75QGxUYLWT02sLoQ6pRuZUl1ZNlszMWF95ejKWj3pn2tkjcbMewvV5Ih1juQoEp9gCCqol9/4bGYWcqWG5HChEtHMcu0rkUWLrcCc/9jwdxWWSHFowM/8XXpvdu9Tq0MKe6Tim/WikYMmBqM95l1oGtyeyCLMM=
Received: from (2603:10b6:610:21::29) by
 CH2PR13MB3511.namprd13.prod.outlook.com (2603:10b6:610:25::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8; Sun, 31 Jan 2021 20:41:37 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3825.013; Sun, 31 Jan 2021
 20:41:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "guy@vastdata.com" <guy@vastdata.com>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: we don't support removing system.nfs4_acl
Thread-Topic: [PATCH] nfs: we don't support removing system.nfs4_acl
Thread-Index: AQHW9cYMuXIITkQqQEuvjSotXZGpBqo9sNIAgAAiJoCAABBKgIAABEGAgARP34A=
Date:   Sun, 31 Jan 2021 20:41:37 +0000
Message-ID: <7a078b4d22c8d769a42a0c2b47fd501479e47a7b.camel@hammerspace.com>
References: <20210128223638.GE29887@fieldses.org>
         <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
         <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
         <20210129023527.GA11864@fieldses.org> <20210129025041.GA12151@fieldses.org>
In-Reply-To: <20210129025041.GA12151@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fc73a13-817b-4d7f-6b60-08d8c6289af9
x-ms-traffictypediagnostic: CH2PR13MB3511:
x-microsoft-antispam-prvs: <CH2PR13MB35116D55E4A4754C4FFEF540B8B79@CH2PR13MB3511.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cfotjv++qrMOH9Qwybhbk2MU14gvnn4uBcLo7er9NleceVir5+nBcSQrp16VjW2qEa0+/cUjBVViwEbvjqx7cEEYnncsmRA0yu9SwDunpV4axpx+o2JwNIwFLageihzZBvu7iK51f6miC6e83YGx9MHtjlY+Czir8nZbAMQ27lCj4cE+CW5tXPIIMaCaZh01gFNInCI5JYZH7okSZAQErDP6vu1l5HQl43iTKYicYLRdDGK2crMKwFm7nAVrzihXGC0KTcHlJzfUu4FukXfut4PcdpQUERQ9rk1yXexCl7+a750IWO884OTZiKX1moDZ9iJcmPkJCRYMctkX3QS5p6ZSxYhbHpOF/NNmNzexA67WHUCuUg8pKYtSnWRjpkFqFFRHaeHgrwj/Q0JmbRt+rxZ3dzXx61eKfKN2E04cA2NQ/uW3cWuS3yK8cHBQBlrH6AXrQJzSMkDp5DLO8LlbjllfE6PVZR3f6lMr5ba3ji41jwD/zgEoFyjGuS2BqfnZpo2+7zdwta6k5+gbg9AOCel6wLORYkiBRM759Vy5+KGxroRRCjeFC0CJrWREHaYBVT5BP6hWscFUBv1H7ejaAN/Mm25QGn2LPQlc53yQyNY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(366004)(39830400003)(2616005)(36756003)(6506007)(316002)(6486002)(54906003)(6512007)(6916009)(5660300002)(8676002)(76116006)(4326008)(2906002)(26005)(71200400001)(86362001)(8936002)(478600001)(66946007)(186003)(966005)(66476007)(66446008)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?b2tPb0lKTWpENHpkaUt2WklFUHNOajhaR3pNVlYxLzZPQjBvOTNVWnJpWHhG?=
 =?utf-8?B?T09tWWpWWloyZjZHY0diNGhLK2N2dXVmY1lLN2JTSzMwQnMyOW1XdlJVREFi?=
 =?utf-8?B?SEJOQytxVWFURVh1RWpMdnpkSkpEbGFQd2xDdklBWjZZNDVrWjVvV1JSdFJk?=
 =?utf-8?B?TXhEellMMW5KYW5LNHU4WXZOb0xGaEZxRmxFQldMUFdpcEMwL3B0cTd0aSty?=
 =?utf-8?B?cURTM05OckdHeWk2UXEyZE9tdDhNWnJMbVdwTjBTMHRReWhEQmxGWEs3VGhP?=
 =?utf-8?B?SFFsZ1kwaXBtcUZEZFZXd1lPVHllNXVnMGg4YlFnMVk2WVp6elNqWlB5WE14?=
 =?utf-8?B?VmMyVklhOGRzOFlOWmJ1Sk43S0dDMkY5STVZcW5KSVNwaFdSa2tlSGoxd21u?=
 =?utf-8?B?bzIxVmhiUW1idE9udnA3WVpMclk4bVNOZThHOWMwOVlwa3N4cFFnditXRDBR?=
 =?utf-8?B?VkdvQjRKY2F6RFNhdStra3BBdkRSVmpKN0xGZ2FRVkhDTUEzcXRzM1ZzdTlW?=
 =?utf-8?B?amlXdzVqdm95dmxNRDNVZzRCYUZtcUhqVnppY09oT0J5MU5rZjFiQURac0hr?=
 =?utf-8?B?ZVdnblRITGx2RjRYcGpXalpNL2ZRWGRLUTBjUklNdlZFOEtVTVNaUmNEV2hj?=
 =?utf-8?B?d2tiek53b216RUFNY3BvbHROWi9LU0c2bm1yU3hFT1hGV1F0SUNCdzRDK3Bw?=
 =?utf-8?B?aDhnbkJRakQ2RTlEQjFNamU4NTR6dDY0N0l6REN3c3JXYlpHNG5xT0JMZXVK?=
 =?utf-8?B?NE8vei9iSEQ3amRydU9RcTF3STY1b25ONFh4eEphOU1UYm9RU05kNmo3OGFE?=
 =?utf-8?B?SW91SHloMVV1UjV2TS9pWTZNRmlYYkVUL2I5OUlWVExMNlZFNG53b1JISy83?=
 =?utf-8?B?K1hza1FENTlXaDF6dk9sOEs1ME80THJoa2JkUnZrVWJsdXJua2V3QXlOMVk1?=
 =?utf-8?B?Zm1FSXJJM2k2eEpJdnF1eU1VM3Y3Q2hwRzVxZmc5eGxrdTE0OWNJSnRVSlJK?=
 =?utf-8?B?S2VoWHlySjNjZDBaVTlnZWNUbnMrWk44RmZTcGlmOS9kMHMzVUdRcmQ0SWtR?=
 =?utf-8?B?Si9ITlVQZmVvdWRLdWlBNG1KVGxCUFp5Y0N0VE5qd2dYcitoUVIrbm1oYWtp?=
 =?utf-8?B?MkJjOGJFVVZveVdQcGxXUlpaZFkvNG5RVmcyYytXb0NsSXdVSGx4K2I2NE1I?=
 =?utf-8?B?MFFDVnhEZVJFc3JXc3B2UGtMcTlidjFxelBleHZVN2xTSkUvTkVjQnVTMEkv?=
 =?utf-8?B?VWpyeGRVb29YbWFIVnZtZSt0RWVHNU5IaDJNclkwZkRHQjFQSTBLenhvWGVk?=
 =?utf-8?B?d3BCSmU3MHFTRk9VSDFiemUwSHJBOW5jb3JRVHRuQzZvTW1LUHJraWlpeWcx?=
 =?utf-8?B?WUkySTgxVXNDY21raXVoc210bS9JNkZyYjJKQ21nU3JWL2V0dXQ1dWtGSmo2?=
 =?utf-8?B?aVlXSXpnajNpeERQd09ScUlqNGlaN1BQUzYwZXJRPT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA897DA9982B7B439CEEED6C94F7F983@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc73a13-817b-4d7f-6b60-08d8c6289af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 20:41:37.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSHjjqZMFoZS3R5FWfDRx6BQ1cwWI5u6WkCtkzfVs8rssF10ml61/32mbPjC2otB2ZOpyJ1jdMQj/k5ZXMucfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3511
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTI4IGF0IDIxOjUwIC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVGh1LCBKYW4gMjgsIDIwMjEgYXQgMDk6MzU6MjdQTSAtMDUwMCwgYmZpZWxk
c0BmaWVsZHNlcy5vcmfCoHdyb3RlOg0KPiA+IE5vdGUgdGhhdCB0aGlzIHBhdGNoIGRvZXNuJ3Qg
cHJldmVudCBhbiBhcHBsaWNhdGlvbiBmcm9tIHNldHRpbmcgYQ0KPiA+IHplcm8tbGVuZ3RoIEFD
TC7CoCBUaGUgeGF0dHIgZm9ybWF0IGlzIFhEUiB3aXRoIHRoZSBmaXJzdCBmb3VyIGJ5dGVzDQo+
ID4gcmVwcmVzZW50aW5nIHRoZSBudW1iZXIgb2YgQUNFcywgc28geW91J2Qgc2V0IGEgemVyby1s
ZW5ndGggQUNMIGJ5DQo+ID4gcGFzc2luZyBkb3duIGEgNC1ieXRlIGFsbC16ZXJvIGJ1ZmZlciBh
cyB0aGUgbmV3IHZhbHVlIG9mIHRoZQ0KPiA+IHN5c3RlbS5uZnM0X2FjbCB4YXR0ci4NCj4gPiAN
Cj4gPiBBIHplcm8tbGVuZ3RoIE5VTEwgYnVmZmVyIGlzIHdoYXQncyB1c2VkIHRvIGltcGxlbWVu
dCByZW1vdmV4YXR0cjoNCj4gPiANCj4gPiBpbnQNCj4gPiBfX3Zmc19yZW1vdmV4YXR0cihzdHJ1
Y3QgZGVudHJ5ICpkZW50cnksIGNvbnN0IGNoYXIgKm5hbWUpDQo+ID4gew0KPiA+IMKgwqDCoMKg
wqDCoMKgwqAuLi4NCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGhhbmRsZXItPnNldChoYW5k
bGVyLCBkZW50cnksIGlub2RlLCBuYW1lLCBOVUxMLCAwLA0KPiA+IFhBVFRSX1JFUExBQ0UpOw0K
PiA+IH0NCj4gPiANCj4gPiBUaGF0J3MgdGhlIGNhc2UgdGhpcyBwYXRjaCBjb3ZlcnMuDQo+IA0K
PiBTbywgSSBzaG91bGQgaGF2ZSBzYWlkIGluIHRoZSBjaGFuZ2Vsb2csIGFwb2xvZ2llcy0tdGhl
IGJlaGF2aW9yDQo+IHdpdGhvdXQNCj4gdGhpcyBwYXRjaCBpcyB0aGF0IHdoZW4gaXQgZ2V0cyBh
IHJlbW92ZXhhdHRyLCB0aGUgY2xpZW50IHNlbmRzIGENCj4gU0VUQVRUUiB3aXRoIGEgYml0bWFw
IGNsYWltaW5nIHRoZXJlJ3MgYW4gQUNMIGF0dHJpYnV0ZSwgYnV0IGENCj4gemVyby1sZW5ndGgg
YXR0cmlidXRlIHZhbHVlIGxpc3QsIGFuZCB0aGUgc2VydmVyIChjb3JyZWN0bHkpIHJldHVybnMN
Cj4gQkFEWERSLg0KPiANCg0KSSBkb24ndCBzZWUgYW55dGhpbmcgaW4gdGhlIHNwZWMgdGhhdCBw
cm9oaWJpdHMgYSB6ZXJvIGxlbmd0aCBhcnJheQ0Kc2l6ZSBmb3IgbmZzNDFfYWNlczw+IG9yIHN0
YXRlcyB0aGF0IHNob3VsZCByZXR1cm4gTkZTNEVSUl9CQURYRFIuIFdoeQ0Kc2hvdWxkbid0IHdl
IGFsbG93IHRoYXQ/DQoNCldpbmRvd3MsIGZvciBpbnN0YW5jZSBoYXMgZXhwbGljaXQgc3VwcG9y
dCBmb3Igc3VjaCBhbiBBQ0w6DQpodHRwczovL2RvY3MubWljcm9zb2Z0LmNvbS9lbi11cy93aW5k
b3dzL3dpbjMyL3NlY2F1dGh6L251bGwtZGFjbHMtYW5kLWVtcHR5LWRhY2xzDQoNCg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
