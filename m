Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E123C27CE
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jul 2021 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGIQ6C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jul 2021 12:58:02 -0400
Received: from mail-dm6nam08on2120.outbound.protection.outlook.com ([40.107.102.120]:55019
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhGIQ6B (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 9 Jul 2021 12:58:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9uVWwpd45aU1UfLzmKMCLzi7eS83DktlIdA3/cltFFA0s8t1re0FB3HZIAit79lxn9uoui6P8BTbOouHhtkfgCTDDvjXAib30eiIXSKGeFd4pRn81+tgynjF5WyGJxHgUeqdYEdEUN2HasJ6ZKUlip0EcLIeev8pbrTfZTVgncNjmHg4zJh/GXU7IKZ5Gj1DwqAcA7kRmmocusPLAgLQe7um4T5Nlazb2nNT2DPUvgZOk8GWKOU3D6y2m3BOu0rLzHDcm/CAQXwHt+jOloJPuGmk0bQ+4Ca1KhKGgfFTM11BqyRuAW1/2ae/DeLKvCOuQdWF7KIs2IgD/qYdgJH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZUDDYzx/aLZkYvmnH4CX0C1q+u4K/IVjwiUl3Lrrm0=;
 b=mRCXTbmxLh8PYCdDV3Ojn3cQZteuOE0OHn+aKpYqwJrEoNxrjoUlFUuoyPY1sE4DYQr06aG/rTfxJW8sto1lkc3mAYmDKjiyB795Qa570wbEWjy2DMFJ9Eh62UW0vt4Tjo0Ia+o3zpbljwkfL+F0jzOcMiBfSMlIe8OjqdpIJU3gFo6xPo4kmWHZAWXJqcSEUjJGbCIaoBhOBIXUna0XhMNzYw6Qfn6KZYFmc4s7tFIdopJJ4tHkLZwJ71IZn8JGEjK1F6zMLpjuwJAsFR1LnIdTBVz9SvgR5DZFu0lynis3TrEp8NJv7Elp1bUZi/hzVMzv8LpAR5p2ZW3QtdMX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZUDDYzx/aLZkYvmnH4CX0C1q+u4K/IVjwiUl3Lrrm0=;
 b=fz51sQ899mOYsBrr4PuDqEjbaglL0wyIKixhSz01qgnlSKt1UJsYRf+ZSaMrreheH6/XfaVlB2623TU5yhgee9rpsdUmvKiDKLgDiAl1BChVhyU3VbYkOViN4F2hopjKZU+F4I+a8avp6ZBOR/HNieyPnjdFsJZVPzDwdjqrsvA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5185.namprd13.prod.outlook.com (2603:10b6:610:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.17; Fri, 9 Jul
 2021 16:55:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%5]) with mapi id 15.20.4331.014; Fri, 9 Jul 2021
 16:55:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull NFS client changes for 5.14
Thread-Topic: [GIT PULL] Please pull NFS client changes for 5.14
Thread-Index: AQHXdCVSsONytk0AxU++JO0oG+EdIas63OyAgAABKQA=
Date:   Fri, 9 Jul 2021 16:55:15 +0000
Message-ID: <448e0f2b96b7fa85f1dd520b39a24747ea9487ed.camel@hammerspace.com>
References: <6809750d3e746fb0732995bb9a0c1fa846bbd486.camel@hammerspace.com>
         <CAHk-=wjvNb9GVdbWz+xxY274kuw=xkYBoBYHHHO7tscr1V0YAQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjvNb9GVdbWz+xxY274kuw=xkYBoBYHHHO7tscr1V0YAQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d723d6b9-bf67-4f93-639b-08d942fa5397
x-ms-traffictypediagnostic: CH0PR13MB5185:
x-microsoft-antispam-prvs: <CH0PR13MB51851007855BE006EAECF426B8189@CH0PR13MB5185.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: auHrrxD64FPQrelZYd3C9hDhP7OQ0cjZQ8ch/7cxLYCEE3TUV4SfdXITZbMQt8tb9O+3w6dyMbIQ6Kx4CuHJDxxIhlqAIOmaVVaCRqOzMfthZzbQaeJUNNEYNad62PGaWNy/JoB51Pp1RMVtUSX0BCX8bupMPX4QncfRidD5nm0CkmCfDlTe6y8OxJK7Q78DW8p7ljGdwWzKWJ8sTYNm0pHTlHQL1OUPnSJMAkDZNAs4hf15EG7KigYjTuaQg2bc1cm8nKiUBn0GRiyjaTltqDNZcTClJFV117vErjuhD3+hKp3RdAWhHNtCs4tgaY1HDqQ7sA26IOxT5wxSxptdmokS6l2ircIK+O/WWOVKEP9lhrl99fSrcjpFmRMKf7SayM/zECIyemn4LwseJPFFM8Uy4fFL7TCwas2hzfTLhuacgX6HCNrOmZPYymjnEGzzefHt0uCNCoYQwPfS54bK3DZel8x2zIv3Qo16r2smPNKG9ZrNXDWwOyDkaxq36ZaEmSbhlXr7EA4zTOjt4b9aXOC1zLVzlHgBwd9GA0CtoL6sscrTl5NnymUqzzghAHIGY79emd83GtOvCQiPRzOy/xcw7rdoW7dLMicbVrTDwHvErBjNho06URtlr6b8H8aL6SQ682PHHlSAXrvVYZhUAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(376002)(136003)(122000001)(4326008)(8936002)(66476007)(86362001)(8676002)(316002)(66556008)(64756008)(76116006)(66446008)(71200400001)(66946007)(478600001)(6512007)(6486002)(83380400001)(26005)(5660300002)(186003)(6916009)(2616005)(53546011)(38100700002)(6506007)(36756003)(2906002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3FnTjVvZW9aOStlVTlIdjZLOTRrZEFxVExka2ZEU1IycnVBeGpXOGJNY0s3?=
 =?utf-8?B?dDFBZENGSy83bVVvVkJISm1uaHByNzltbmlEc09sMXdpZDZ0eWZtT1dCVGZX?=
 =?utf-8?B?dUZWR01TaFdUaG5UcUE3ek9DNDY3WVE5bmJwc0ZkdXRnQTRQSnROTUlvZFNX?=
 =?utf-8?B?WkZiM0F4QlUvTEdDd1lQZUdrV0Y2ZXZ2cGM1aGNBdzJKSFBKQ21mdmpiNWZq?=
 =?utf-8?B?ZTJRYlczTlpIamZoVk0yK2g4MmVZa09oVUxxT1Rhb1NvcWVLYW1kU1FUb3BC?=
 =?utf-8?B?WFRheFl6UEVjMWdZWU5oTC9aczFWUmdzNFpqQmkrMnJ6MFFVVXRiQllHWlg1?=
 =?utf-8?B?N3FtK3VMKzJaTGg4dHBVUHp4cm05TXA2c2VYbzRVUmFiNGh3SS9DQ3A2N3Bj?=
 =?utf-8?B?Qy9rd0kyVktzNHM2QXdpdURnbmhXQjBNRyt1N3N4R1BLc1p6bGtrK1B2dkcx?=
 =?utf-8?B?a1ZEYTVGcExocS9TQmtaczVVUUFuOUNCbDFQUDVIYUFYdDhpTHVVQVJOanIx?=
 =?utf-8?B?UjVXaHZaWHhmVjk3U2h2RjArWFg2MGI0MDNRMkQ1dkpaUzgxWUx5QzdRanU5?=
 =?utf-8?B?SEZUeGlzeVFBMGJCcFpleGtjd2xWS1hWNUEyMkZyMS9kUHd5cjV2Y0poVkZ6?=
 =?utf-8?B?eUJibk9OYjVmYXVjbmY3MnQxSTNnaHB2WGZEbytSTm1HbUp6Yk1CQTdEMHls?=
 =?utf-8?B?eXk1QnFqVXNkWXlLSGczOHByc2lseXo2b2ZmYlpvdno3MXpxS0dHK09yQVNw?=
 =?utf-8?B?Z1puOUZCbmNaYWRJRzJhbDFWUm1uZmNmWTNJaEhBNE5GbXJSUnpzbkZaQTNj?=
 =?utf-8?B?VWY5Z0d1Zk9ncTRRUHdMaG1qL05EZ3VjeTVJUzRpR3JjaFg3RkljUjRFMDVZ?=
 =?utf-8?B?TXg1d1o3UGRYckhsS2ZvbGZBNFNnMmhzTFBUSnVpYTM4Tk1oN0dTdmdrb1Vn?=
 =?utf-8?B?Tmg4Z29ydk1NcTJwS09YRHp1Q1pMSjFIZ281U2JwUXF0S2JyYnowdTBTZXhl?=
 =?utf-8?B?Z0JWbHJlbXJiK0FzZktreWZyUE9UeDVyak9aZGltUGFiRTZCbzI3bGJXWTE2?=
 =?utf-8?B?YUZXZm9uVnA4VG04NFpsamJ3SUk3dUc4N1pLSEE3dlR2bmtCY0dQRkU5TTM0?=
 =?utf-8?B?aEpHRWtKSnhtNzl1eFgxU095TEJSaDJ2cGd6RzJSVy9LdjRQN3FkQnpRYTAw?=
 =?utf-8?B?NVo1Tm1OUCtnRWNuRDBpMHJQUU1IckVBam9uVG50Vk0rbVpGaFJYNFZYaE5W?=
 =?utf-8?B?R0RHamp4ekVzOWxlRktBSGMzbTBab24xMWlQY1JuRkduSUFIOU96bnZqMUxF?=
 =?utf-8?B?eFZNaDUrV29VdVlnQnJQc3hrbzFBZVFWdUF2WlBjTWY4K2RscXUrTGpRd29t?=
 =?utf-8?B?cFJCRDFTWE1Mc1RtSnZ4MGpLWEdoYWR3NGl4anduWVFOYmxUMjlnTXN1NkJH?=
 =?utf-8?B?RTh4L25ESCtSa0ZiWjFJTC9yNVd3TDRiRFZwL0IzQm5tTlBabjFNRXFOalds?=
 =?utf-8?B?SHhEZ3VyMDVtZzRCVjQrSnZlSmFXTGxJM0sxQTdoOUo5Yks1Z2h5NkZ2UDlK?=
 =?utf-8?B?RTN2ZXJjQXNjWWxDVEhaRDZ2ZmNobHpVd1RWeHQveGFReWlpczVQUWNLcW1v?=
 =?utf-8?B?OUt3MGxhQ0pWY040bEdUVnk1QjJQcUNocFlPUkw2dHVKSXNReTczQnRZdHFH?=
 =?utf-8?B?am9pcHVFMWFnZHFjTDlDTjA5M2R1RjZscG50Z0F2VFV1U1R1blI4SVU3cU93?=
 =?utf-8?Q?aPa5M3jr868vvteJutapP5B1fIY1p6z+x94KqAi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD65891C963F3248A751B1D6DEDA31E3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d723d6b9-bf67-4f93-639b-08d942fa5397
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 16:55:16.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhJIRLn4mzNGV7yaDEVYPoK18gId1xLd+XtpVlG+p7NKg4xO7ZNHyYipM0hcKz7lc/rwk2H9s3JcNUkA7/GtxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5185
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA3LTA5IGF0IDA5OjUxIC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gT24gVGh1LCBKdWwgOCwgMjAyMSBhdCAxMToxNiBBTSBUcm9uZCBNeWtsZWJ1c3QNCj4gPHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBQbGVhc2Ugbm90ZSB0aGF0
IHRoaXMgYnJhbmNoIHdhcyByZWJhc2VkIHRvZGF5LiBUaGUgcmVhc29uIHdhcyBJDQo+ID4gZGlz
Y292ZXJlZA0KPiA+IHRoYXQgb25lIG9mIHRoZSB0b3BpYyBicmFuY2hlcyB0aGF0IHdhcyBtZXJn
ZWQgY29udGFpbmVkIHNvbWUNCj4gPiBkdXBsaWNhdGVkIHBhdGNoZXMNCj4gPiBmcm9tIHRoZSBt
YWluIGJyYW5jaCAobWVhIGN1bHBhKS4gU28gdGhlIHJlYmFzZSBzaW1wbHkgcmVtb3ZlZA0KPiA+
IHRob3NlIGR1cGxpY2F0ZXMNCj4gPiBmcm9tIHRoZSB0b3BpYyBicmFuY2guDQo+IA0KPiBQbGVh
c2UgZG9uJ3QgcmViYXNlIGp1c3QgZm9yIHBvaW50bGVzcyBkZXRhaWxzIGxpa2UgdGhpcy4NCj4g
DQo+IER1cGxpY2F0ZSBwYXRjaGVzIGFyZW4ndCBhIHByb2JsZW0sIGFuZCB3ZSBoYXZlIHRoZW0g
YWxsIHRoZSB0aW1lLg0KPiANCj4gWWVzLCB0aGV5IGNhbiBjYXVzZSBhbm5veWluZyBtZXJnZSBj
b25mbGljdHMgKG5vdCBvbiB0aGVpciBvd24gLQ0KPiBpZGVudGljYWwgcGF0Y2hlcyB3aWxsIG1l
cmdlIGp1c3QgZmluZSAtIGJ1dCBpZiB0aGVyZSBhcmUgdGhlbg0KPiAqb3RoZXIqDQo+IGNoYW5n
ZXMgdG8gdGhlIHNhbWUgYXJlYSkuIEJ1dCBpdCdzIHNlbGRvbSBhbGwgdGhhdCBiaWcgb2YgYSBk
ZWFsLA0KPiBhbmQNCj4gaWYgdGhlcmUncyBqdXN0IGEgY291cGxlIG9mIGR1cGxpY2F0ZXMsIHRo
ZW4gcmViYXNpbmcgaXMgbXVjaCBfd29yc2VfDQo+IHRoYW4gdGhlIGZpeC4NCj4gDQo+IElmIHRo
ZXJlIHdlcmUgKnRvbnMqIG9mIGR1cGxpY2F0ZSBwYXRjaGVzLCBhbmQgeW91IGhhdmUgc29tZSB3
b3JrZmxvdw0KPiBpc3N1ZSwgdGhhdCdzIG9uZSB0aGluZyAtIGFuZCB0aGVuIHlvdSBuZWVkIHRv
IGZpeCB0aGUgd29ya2Zsb3cuIEJ1dA0KPiBwYXJ0aWN1bGFybHkgZm9yIGp1c3QgYSBjb3VwbGUg
b2YgcGF0Y2hlcywgcmViYXNpbmcgYW5kIGxvc2luZyBhbGwNCj4gdGhlDQo+IHRlc3RpbmcgaXMg
cmVhbGx5IGVudGlyZWx5IHRoZSB3cm9uZyB0aGluZyB0byBkby4NCj4gDQo+IEluIG90aGVyIHdv
cmRzOiBvbmx5IHJlYmFzZSBmb3IgKmNhdGFzdHJvcGhpYyogc3R1ZmYuIE9ubHkgeW8gZml4DQo+
IHRoaW5ncyB0aGF0IGFyZSBhY3RpdmVseSBicm9rZW4uIE5vdCBmb3Igc29tZSBtaW5vciB0ZWNo
bmljYWwgaXNzdWUuDQo+IA0KPiBJJ3ZlIHB1bGxlZCB0aGlzLCBidXQgcGxlYXNlIGF2b2lkIHRo
aXMgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTGlu
dXMNCg0KVGhhbmtzISBJdCBkaWRuJ3QgcmVzdWx0IGluIGFueSBvdmVyYWxsIGNvZGUgY2hhbmdl
cyBvciBldmVuIGNoYW5nZXMgdG8NCnRoZSByZXN1bHQgb2YgdGhlIG1lcmdlcy4gSG93ZXZlciBp
ZiB5b3UncmUgT0sgd2l0aCB0aGUgb2NjYXNpb25hbA0KZHVwbGljYXRlIHBhdGNoIHRoZW4gSSds
bCBtYWtlIHN1cmUgdG8gYXZvaWQgdGhpcyBpbiB0aGUgZnV0dXJlLg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
