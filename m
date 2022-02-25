Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EB34C44CC
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 13:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbiBYMo4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 07:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbiBYMoz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 07:44:55 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2132.outbound.protection.outlook.com [40.107.236.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACC11D9B79
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 04:44:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HED+XeKA1m1ni1G0HJLnAZ9DKIizu4K108+eP8wzD5qUhV1HnFMRa8f3Cf9x3zTDO9rfUyqWUg8Iv3j9vZOxmM6t/RhziJiVLd7vkMSPQi5cTmLVbbNaunXonHEoNAYTZ2P5i0K9YJy4OpoG3LLhaXmMndo2fGSwrQy+vk57p4C4394P36cOiRtu+3JZQjHnK9nNAD/5uoh0npZJCBZtjkS3DZYfPp+HjElv4oVJ+KIrzCdeWYnYkaQBj3A1i2z1erz/dc8GPwHQPRjgNPfMKisQv2Ii/9gddCSiBpZ1sA1h8koItaxMp5tGliC6xpf3CMWwHhdFqwhaIc7IUhfYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4wFav2cmPuuS0LIvvIYa3ET0GffkBUO7PsJZf4N5rg=;
 b=hlXne3N3FZqR7DJ8Bi6nYeJR/UASfcN2GKISouXIb6iwO9apZNrpR1/XvUfKKVnxX6Q4Tnz4vXqrtkOyaHuoZasHq45fqTYC3rVwCEvh+TRZoIxv7uoZWNVBIW4JIq8+sGT0rJT7qsQS+5J9TeW/6kafEQJUUOoE1vXkQv4YBoE+NidHa+62PndoJwT65Mg1zQSDeT5bU0/JQHsi6EAZ6jL1XoxYltnAf19Lreg0UDcqzETZktgNlauQdjtzCI37sswUDXXOMdc6P3fkxoTXOyh74M7gYz/Ic6W/lx2wkIJBWfIbZr0VYap8okZdZcSgj1mI09UvTAcgCnp4+mWu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4wFav2cmPuuS0LIvvIYa3ET0GffkBUO7PsJZf4N5rg=;
 b=OAuiXcs+b/p6CP1z+CtidZKQoBwzwKXNKlaKwh5fT214OMX5qFC1YBz5F68fzL0IIyFnDISWRu63ZqRy8AqEE2ZVIVF+bE03PDVvwGL1z4eY7wLTx6r94cHTxsdbsM+B56KK5wXG6QNbTaLXz6J2BKTNqEebPq6TD/xJMIjaRjo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5083.namprd13.prod.outlook.com (2603:10b6:610:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 12:44:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%7]) with mapi id 15.20.5038.010; Fri, 25 Feb 2022
 12:44:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v7 04/21] NFS: Calculate page offsets algorithmically
Thread-Topic: [PATCH v7 04/21] NFS: Calculate page offsets algorithmically
Thread-Index: AQHYKPs5ywYBluV2MUGDuP/AJsbtLqyiwBoAgADICgCAAJuVgIAAFRwA
Date:   Fri, 25 Feb 2022 12:44:17 +0000
Message-ID: <f3979d8b76eb54033f00f003007653a33efc84fe.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
         <20220223211305.296816-2-trondmy@kernel.org>
         <20220223211305.296816-3-trondmy@kernel.org>
         <20220223211305.296816-4-trondmy@kernel.org>
         <20220223211305.296816-5-trondmy@kernel.org>
         <EA90387C-B33D-4C81-BB80-8C0AB3251E5E@redhat.com>
         <e2ee4448d8deff22d3949b4828d5334a72542701.camel@hammerspace.com>
         <80E3965C-3338-4C44-99BA-08FB0B5728A8@redhat.com>
In-Reply-To: <80E3965C-3338-4C44-99BA-08FB0B5728A8@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c54accbe-befd-4a97-dad8-08d9f85c899f
x-ms-traffictypediagnostic: CH0PR13MB5083:EE_
x-microsoft-antispam-prvs: <CH0PR13MB5083BBFE9EFB2ED361E925F7B83E9@CH0PR13MB5083.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nabSNBfq6bIy0bffHriTPYnMfTmHKjWYfpi6UEyPKH+hQ4/0k0AjbJXHvYNzKSPilahOAd08xEVv9usuLywrB+zby1FgDxvm8M8j9hWi5kvs4RJaRFhK9BsTQll+EOwg+E2eS/QR3VX7gawU7ljEafU0fY+JQEv81XNFrwbZi8Z1bPHGD/Er4oRB0vMXAJQY9ne7ujxb8hsKhc/EB4IPK85n7NtjhlBNyLh37rth4fgttUvv5eTKHoETp/29LLkbHw2tqjGcKiIaWZB+Ejv9FQcwpGp7/kL2ChEu+YllCXM3TjKluR6Hm+bIqSqFY0sTQSrmeDVWUQdnUoDaVp9eMRX25Pgm6O2Lvq1Zh+wD2A4nCYl06sz2/F68FGYLcWKq4CYU+ga6pzkcjPrcUhs15kmtng5VxCK8mt/csznAF7ObT6GMp3PxLpUWVD49QPFx2jb1JKH3RkQ4BVR2HBA8I/Ki6vUaD6umxkL3ejJYWndduWKt/XBOWPr1i2wbqwJrQE4C7lsQhWYTXHDHy72vznYIMPxOYzxRRkxtTPk7tJTieL3AgIXjUaD+OoV0akGRTEoHSwLOpdULxUMDV1WyxmkyG1+nIWdur4BZSeuY5aCw+dRLqr42WkT7xy684NlxmidIbZ6uxSga6RW1s3J7iYTcM8BypM+1cm+UdbURY7ZRzuwckH/VK3f8F0CRVuI+F4CoOCoJkU/H/q5ALXKWMiYL1BFgoxBnXD4I8LMa2cWS64PrUMyQUy94Ac2DiUKV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(346002)(39840400004)(136003)(396003)(5660300002)(86362001)(122000001)(38100700002)(8936002)(38070700005)(2906002)(6916009)(64756008)(6506007)(53546011)(71200400001)(316002)(6486002)(508600001)(36756003)(26005)(186003)(83380400001)(2616005)(6512007)(8676002)(66556008)(4326008)(76116006)(66446008)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzIyUVF2REFBZGY3eEtjQTJNMjlwNDVySXBTeWNFZHpNSkM2QVk2SXNqeWU0?=
 =?utf-8?B?VXNWbDRaekNnSWE3M3ZPV2dsU3Rhbjd0NGZUUDBUbFg5YmxxMFpYMjRmUGM4?=
 =?utf-8?B?OVZ0THdiNEZkbFFjU3hFN0x2cUMrVUh4MUdMaUZjYVpjNXlITC9SdnpMV3dx?=
 =?utf-8?B?SEdYMExlK2x1cTkraVdPMGQwVDA1SkoxWERFNWZseXRicnpSb0tZaGdsU0Mx?=
 =?utf-8?B?WnFGTHpnN3Q2VU9JVVVJVVYwQW9GZ25LSXQ1VDVwd3BUL216U2EzS0cwa3ZV?=
 =?utf-8?B?OGRlTzBDemNrUTh4WTBlTS9YTEhTTm83NmZ4ME5LQWdRSmt5a0FveXdBRmdz?=
 =?utf-8?B?Q3dTejE4ekI4a3kyTlR0amhwa2hlZlhJa2cwVk92Y0hnUnJSazJZRHdhdlIr?=
 =?utf-8?B?UWJxRHlWOHpyazQ4R3VENjZyVzhLWFBvK1REazhLV2ZSWjhDZlhzZFFLOTZH?=
 =?utf-8?B?K1hHOVlPU1VWMXgxdEJBNEo3ZDdLcUw1SzU5NW1oeFQ3ZGFVTnVnZ1hpazcr?=
 =?utf-8?B?ZExMT0RwZFNtUTZDSmNlQTNMZm5venFiQ1lHSjh1aWVZZk13THZJMVJRT2NK?=
 =?utf-8?B?a2dwaW9PN1J4MWxacUVVR1pTZFQxbGwxWkNDVENYc21pWFJVR3JiUHQ3NUFh?=
 =?utf-8?B?T3ZaOVJJdGhjbkVmK1Y3dVlzUVVJTlJ2VzljRS9rSWNodFdCNjlUdEwxNCtE?=
 =?utf-8?B?ZzhSZmpBaTRaWVNST3Q1TGh6SWNtdWxqVWJqZTBBb251aTMwYUpJeGJlOXkr?=
 =?utf-8?B?VjhTekc5Uk9jOVBoY2Npbk9JVHl3dll1QUoxTmZPbVVINis3Q1ZHL1BGa2x3?=
 =?utf-8?B?ZitKeWhzWjBCT2Jqb2tPOGQ3eThDcE5GTlFNd1ZsZnBpYTgyV01iZkthUnd3?=
 =?utf-8?B?b3g5RWRQdDloTFdNZ0JpUVpLY3RkQmFpdTJwME9DUy91ejdNLzV4U214d3l0?=
 =?utf-8?B?Z0RCVzFmYjB0bExyc3F2d0FQaTNHcDdaSkN3d1NON2dYVjNablV1RU4vbGNp?=
 =?utf-8?B?Q2xpbnd2MlZnSzQxY2QyNS9qOGEyRkdscFZFVnluTmlWVTdKT2N2djM4MjZq?=
 =?utf-8?B?RGtud3V1UVlVUm4rSVdZa3BES0JXN0ZCNWpLVXVnUTlzU0o4OTZ3cFJ6ampS?=
 =?utf-8?B?ZDVuamRqeW5BbEFyMXo4ci9mbFBRcmdCMjByTW1KOUxWNTNHWXFsWFNoQlk2?=
 =?utf-8?B?bGQxQTc3QWpYYS9OUDZOSERtWlNIVUFIWE5iZnljODNtdWptSjcycmUvTWRF?=
 =?utf-8?B?WFBwZmluTHV6NkVlaGxTaGtZVTlpdXczWkRPaVBzcTNGNkJBc3NYRTd0d0RD?=
 =?utf-8?B?TTFBaVpPUGI2TlpRbU5OQ1pKcTN4SkE3eUhGblZZYjUwbXlSWE9Zc3lha2Yr?=
 =?utf-8?B?V0pEcWM1ZzZtQVdNM1c5eEtMOWw3Y3RsNlUraVhLaTU0RkhXOEszY0tITkVi?=
 =?utf-8?B?QVZUamk4RnlLTkpoaWtNc05FdHBKVnc2dExreGJRbVh1NytqRC9wRE5hTGVs?=
 =?utf-8?B?QVBSYjJPRlJrd0o1eUl6bFp3M01oejAvZjZ5YlVmVkVqa1dPTjRIZ1JudEVt?=
 =?utf-8?B?aC9wbzF2aHZLNllpYTBObVJETjlOcWl4dmhRVkNSdkZoa2FVQ3J4NXhFTzlz?=
 =?utf-8?B?TUs2MGRqSWxTY3llQnFwUVp6Unl5c1ZaSElvbnAwWlBnRklMajQ2bHdFb1dR?=
 =?utf-8?B?VWNIbHo3TitCc1BEUGJNSERKVGk1Z2g3Rkp3Q3Y4VTFrUGhZSnB2QWUxUXRD?=
 =?utf-8?B?REJranpta1IwbVVJYUIrRVcxZlJ2eUdzT04wRkIrTS9hK2RsWStxYmd4c2ZV?=
 =?utf-8?B?Y3Z2UFdlS3ZuYis5VncwMTFWY0hEemRsOVhBMklXMkdPSk03Rm9XQWVmbGFv?=
 =?utf-8?B?Y0VweUtVMWFhY3pxemE4dUtuclJlRGU5WUJFTnlIckJwV3BVbDRZc0ZNUTlC?=
 =?utf-8?B?Z0dpdFZ0S0tCRVZUbUl2SHhpaVlqNU1vSjlPM0dJNFhHUXJ1dWVLYnA1bEF4?=
 =?utf-8?B?NGY2RTVYZXFEWU5Zdm1jUy9waEl4RVJUTHRUQUVuKzFUUEVBOUZxeUl4YXJD?=
 =?utf-8?B?U2d1Ylh3bFF0S3Zmd0Y5aWZjajFDNWFJTFVvb3dFMk0zWmZGZG5vS2RiZjhu?=
 =?utf-8?B?cFdzZi81bURUTTZiQUdBTENqUUFmazlHdzJtOC9UY2tOT3NNUk9uQ3dUNW8z?=
 =?utf-8?Q?3Vn1ih7T2io+o050lF7NKlk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CDEBA3F1679BC469B1149CD6B815E7B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54accbe-befd-4a97-dad8-08d9f85c899f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 12:44:17.5976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Br/J3bqaGHPMY1wjrr6HQIanhtwuGbxKX6si5HXVNp1GW1X8LgHa0Z9llkcleISial5Ch8zXacnS/AGbrvcag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTI1IGF0IDA2OjI4IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyNCBGZWIgMjAyMiwgYXQgMjE6MTEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gVGh1LCAyMDIyLTAyLTI0IGF0IDA5OjE1IC0wNTAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+ID4gT24gMjMgRmViIDIwMjIsIGF0IDE2OjEyLCB0cm9uZG15QGtl
cm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IEluc3Rl
YWQgb2YgcmVseWluZyBvbiBjb3VudGluZyB0aGUgcGFnZSBvZmZzZXRzIGFzIHdlIHdhbGsNCj4g
PiA+ID4gdGhyb3VnaA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gcGFnZSBjYWNoZSwgc3dpdGNoIHRv
IGNhbGN1bGF0aW5nIHRoZW0gYWxnb3JpdGhtaWNhbGx5Lg0KPiA+ID4gPiANCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA+IDx0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBmcy9uZnMvZGlyLmMgfCAxOCAr
KysrKysrKysrKysrLS0tLS0NCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9u
ZnMvZGlyLmMgYi9mcy9uZnMvZGlyLmMNCj4gPiA+ID4gaW5kZXggOGYxN2FhZWJjZDc3Li5mMjI1
OGU5MjZkZjIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiA+ID4gPiArKysg
Yi9mcy9uZnMvZGlyLmMNCj4gPiA+ID4gQEAgLTI0OCwxNyArMjQ4LDIwIEBAIHN0YXRpYyBjb25z
dCBjaGFyDQo+ID4gPiA+ICpuZnNfcmVhZGRpcl9jb3B5X25hbWUoY29uc3QNCj4gPiA+ID4gY2hh
ciAqbmFtZSwgdW5zaWduZWQgaW50IGxlbikNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVy
biByZXQ7DQo+ID4gPiA+IMKgfQ0KPiA+ID4gPiANCj4gPiA+ID4gK3N0YXRpYyBzaXplX3QgbmZz
X3JlYWRkaXJfYXJyYXlfbWF4ZW50cmllcyh2b2lkKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqByZXR1cm4gKFBBR0VfU0laRSAtIHNpemVvZihzdHJ1Y3QgbmZzX2NhY2hlX2Fy
cmF5KSkgLw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVj
dCBuZnNfY2FjaGVfYXJyYXlfZW50cnkpOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiAN
Cj4gPiA+IFdoeSB0aGUgY2hvaWNlIHRvIHVzZSBhIHJ1bnRpbWUgZnVuY3Rpb24gY2FsbCByYXRo
ZXIgdGhhbiB0aGUNCj4gPiA+IGNvbXBpbGVyJ3MNCj4gPiA+IGNhbGN1bGF0aW9uP8KgIEkgc3Vz
cGVjdCB0aGF0IHRoZSBlbmQgcmVzdWx0IGlzIHRoZSBzYW1lLCBhcyB0aGUNCj4gPiA+IGNvbXBp
bGVyDQo+ID4gPiB3aWxsIG9wdGltaXplIGl0IGF3YXksIGJ1dCBJJ20gY3VyaW91cyBpZiB0aGVy
ZSdzIGEgZ29vZCByZWFzb24NCj4gPiA+IGZvcg0KPiA+ID4gdGhpcy4NCj4gPiA+IA0KPiA+IA0K
PiA+IFRoZSBjb21wYXJpc29uIGlzIG1vcmUgZWZmaWNpZW50IGJlY2F1c2Ugbm8gcG9pbnRlciBh
cml0aG1ldGljIGlzDQo+ID4gbmVlZGVkLiBBcyB5b3Ugc2FpZCwgdGhlIGFib3ZlIGZ1bmN0aW9u
IGFsd2F5cyBldmFsdWF0ZXMgdG8gYQ0KPiA+IGNvbnN0YW50LA0KPiA+IGFuZCB0aGUgYXJyYXkt
PnNpemUgaGFzIGJlZW4gcHJlLWNhbGN1bGF0ZWQuDQo+IA0KPiBDb21wYXJpc29ucyBhcmUgbW9y
ZSBlZmZpY2llbnQgdGhhbiB1c2luZyBzb21ldGhpbmcgbGlrZSB0aGlzPzoNCj4gDQo+IHN0YXRp
YyBjb25zdCBpbnQgbmZzX3JlYWRkaXJfYXJyYXlfbWF4ZW50cmllcyA9DQo+IMKgwqDCoMKgwqDC
oMKgIChQQUdFX1NJWkUgLSBzaXplb2Yoc3RydWN0IG5mc19jYWNoZV9hcnJheSkpIC8NCj4gwqDC
oMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVjdCBuZnNfY2FjaGVfYXJyYXlfZW50cnkpOw0KPiANCj4g
SSBkb24ndCB1bmRlcnN0YW5kIHdoeSwgSSBtdXN0IGFkbWl0LsKgwqAgSSdtIG5vdCBzYXlpbmcg
aXQgc2hvdWxkIGJlDQo+IGNoYW5nZWQsDQo+IEknbSBqdXN0IHRyeWluZyB0byBmaWd1cmUgb3V0
IHRoZSByZWFzb24gZm9yIHRoZSBmdW5jdGlvbiBkZWNsYXJhdGlvbg0KPiB3aGVuDQo+IHRoZSB2
YWx1ZSBpcyBhIGNvbnN0YW50LCBhbmQgSSB0aG91Z2h0IHRoZXJlIHdhcyBhIGhvbGUgaW4gbXkg
aGVhZC4NCj4gDQoNClVubGVzcyB3ZSdyZSB0YWxraW5nIGFib3V0IGEgY29tcGlsZXIgZnJvbSB0
aGUgMTk2MHMsIHRoZXJlIGlzIGxpdHRsZQ0KZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSB0d28gcHJv
cG9zYWxzLiBBbnkgbW9kZXJuIEMgY29tcGlsZXIgd29ydGggaXRzDQpzYWx0IHdpbGwga25vdyB0
byBpbmxpbmUgdGhlIG51bWVyaWMgdmFsdWUgaW50byB0aGUgY29tcGFyaXNvbiAoYW5kDQp3aWxs
IG9wdGltaXNlIGF3YXkgdGhlIHN0b3JhZ2Ugb2YgeW91ciB2YXJpYWJsZSkuDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
