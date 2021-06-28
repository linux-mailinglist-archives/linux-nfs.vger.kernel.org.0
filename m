Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138AC3B6AA5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 23:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhF1WCI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 18:02:08 -0400
Received: from mail-sn1anam02on2097.outbound.protection.outlook.com ([40.107.96.97]:39351
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233976AbhF1WCH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Jun 2021 18:02:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFp3GNbzGZZ40ovgnT2qddl/M2Hxkbpvh9xtDsMbyDRuZVjw8Boig34vk52NlZGbqGzXXT+yYTgvnt0GDSjF+x4BhUqrhkqL3u3SrPblnmlmVOhcEAozEIPIZwfp7oQZnpCXYPi1ELewcD/+2D8V3bEh2e6rCVIaNj/p4TV2YaBT368zrD7qLg78yW2MqT3lw7Y2TRkiiHu0I7ymrceF/lrFzJYdFEQGGiG8ScaZj7F0ntkTaDusYrYtxNz6UT5EThGHZcnhjbcNn2/vtpMW+FgyL4JTd20IrYy76LvmcMaMQK7gw0ZbpUnYTX4csa1/p20y+/VL9KmGjm6gBp1gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91RCHdDhfMQT/JJTegLYwrk8mCjVv4aFAaU+VSSJlgs=;
 b=gqVsLT9TF4Y7FufnH1GHusjEbhQSbOH1B4DVGhFTdBFALI2Xgo/T0T+0GPgAxUMvLDrf5DNWtGz8DHM4EgPD/4zRgjRp+6jRFblrSB9zaarwjbCVcTfyj0oq1Wn+QQHFwgFFfHYtw2YowsF9k3EEI4Z6n7pQ+LkpANtAHR+ZEYS1JAKTENzuMh9HiaNZFe/x9RA8vvJSvdxxUrsNkD/pdIMZDelIDJlllhSWrOgXqjqpprdeSarkSZSWOeVfL0fi6tGag90owrzWXWxlmLmDhP67mVFtmv12g6f6EmDJmMsbzAokPFo7Lkn2xmE73RVRIlS/o8UONAyKrHV1PAFdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91RCHdDhfMQT/JJTegLYwrk8mCjVv4aFAaU+VSSJlgs=;
 b=Z7b52zfXTFqP4Zv+pwE2q5QC+4PMvHXtpfFH4Wc4HNLOmrhQtu5zmCBKeqE3Xlj80DLWF2I1GbfkrOch/YMah3xtFP4PGoG1gSp9GXReKkvlQVH89yWeOmhYDehWiTTFgyAEBgmkziQuo0rbXbb/DJa75RSA7CS6aXGk7NIbg4E=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3720.namprd13.prod.outlook.com (2603:10b6:610:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.19; Mon, 28 Jun
 2021 21:59:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::cc40:f406:86f9:3e05%4]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 21:59:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
Thread-Topic: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
Thread-Index: AQHXbESDVNEfZ6l1Z0mr+wlKyxwP6KspybkAgAAiQ4CAAA1AgA==
Date:   Mon, 28 Jun 2021 21:59:38 +0000
Message-ID: <e9f38da48bfaf1b43546e273493afc907c52def5.camel@hammerspace.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
         <1624901943-20027-5-git-send-email-dwysocha@redhat.com>
         <efc373dd3f321f2f45e749a5edb383f2a11a7b78.camel@hammerspace.com>
         <CALF+zO=CFMYUGRG2m77XQy=LVVd-Zf_a+oQrJATymu-iqHRNtA@mail.gmail.com>
In-Reply-To: <CALF+zO=CFMYUGRG2m77XQy=LVVd-Zf_a+oQrJATymu-iqHRNtA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6afa548-aa7a-4507-72ac-08d93a800661
x-ms-traffictypediagnostic: CH2PR13MB3720:
x-microsoft-antispam-prvs: <CH2PR13MB372074526E11EE7718AA327AB8039@CH2PR13MB3720.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4CGrlOavikMq9SGePEbh0TuIKlRNzD74MI0yM8mnVGYQi3qg4pYAEa9pSDxiv+qH91vmdgBsZuG7s2nhj+2Bxw8Hyt+APTmpdJ5tJR4wPZIJfXSbXEyUbJ5AvZTJ8pvvxsAwdUXN+h4jF5Hey5qZy9p4vWpzlGlIwQScNUpREnvOQ3uE11MXIOYwgSYG7NMMTrLVfudaxRKm6/rrimaHcNO1zItDJQPprUz4gXQ1Io+KiI610zTuTGK2J8nNsp9WfuQ9UJcpVySKES00PdVk6h8S25sx4y964ClWLASJN927zeIfNobHaZUndWNGrddF3gUoW97qkZi26XjH5uw36i9JeKrkBFDZQl/whjOny5bLlnQZiNeCsl+67A35fYHR+6vFjJJSMANfxQIhovM+/mTD4AndTE7v3HXPQinlFY+O5vr2zlnssAQJ0I9SR2AITnPk0KsrihRZNQNSiLoLtQJPNSe2rU/I3xJYoGj5LnnTUkXWKUJX6LQK+1RtYT1ttsC3cZxV3pFpzK9dZjLdNGTi5XQf2wKImneVwSZ6bQSHhAV1OYkDIR9o68vzqlhNA6tm9/cN6WvBZIZBiqP/u1fwvLLjQdO6xdEgdu0jMLy8BCypcVLhvCHFrhfjmUzWe0lP9XJbNBjIHj/w5yAxeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39840400004)(376002)(122000001)(54906003)(4326008)(6512007)(8676002)(8936002)(316002)(6916009)(478600001)(71200400001)(38100700002)(2906002)(6486002)(53546011)(6506007)(2616005)(64756008)(186003)(86362001)(5660300002)(66446008)(76116006)(66946007)(66476007)(66556008)(36756003)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWlGMTRoV0h5cWYzS3Y2OFF2SURub1Q2YXNMYTJ0S1pLRWdyRFIvUWN5K0tL?=
 =?utf-8?B?WCtPOUJhTTF4SW9CU21DYVRoY3VZUkx5UmFpclQrazNCdDVWKzUzZXN3Wm9U?=
 =?utf-8?B?akNmMis3MU9zdmd0d3h4TU4zcld5dTR6ZFRWMEM5SktFUzNFeHZVSmIrZVZQ?=
 =?utf-8?B?SE13dFJyMEpjcVVlYUdZcUlIb0hzQXRBdUNQSzgyZFl0YkpaMTE4NFZqKzd6?=
 =?utf-8?B?OTArRkw2Q0p6RitZcUc5YTZxdjFLU2dJMUhHUWhZTG15V1FIR1M2UGNtQUZE?=
 =?utf-8?B?Z2VPdmpSVC9ndkNHWVc0NjJ4VzI3UUFtMDdobklYL09IWmpzcnRxcU9WR1dh?=
 =?utf-8?B?K3B2Y0p0MTFKakdpT05WSDhNdDhTRmhabElPdG1CUjRmMGI5NUZuQ1NMNk82?=
 =?utf-8?B?N25oUEMwNVlmYlE2SVQ1L3l3MDI5d1RaR3IzbHlUSUNrcnVHU3R4RFVVQmE4?=
 =?utf-8?B?dUQ1TVJ1UjZIZ3FWcDZpaWJiVUUvZzFjN2pVclFoR1ZqVkFiVlM3ald3ZVJ5?=
 =?utf-8?B?dWhRcU01OVJETHB6R0lSQ3JTK3o3WnFDU0IyaitLWVNRRWNNaHh1TW1hM2RY?=
 =?utf-8?B?SFVJWXRqdHpZU2ZRVXVuZk9pMDNnUWN0YnlpWlJBdi9HcUZ6ZExyVEVYTEpN?=
 =?utf-8?B?UGRNOGUxNy84Z3VJMVF1UVQzNEMyNFRzdnVnMERUQWNkOFA3SXNPaWs3aDJk?=
 =?utf-8?B?MzNHUGFZSnFFM1hWRWlsakdLQjFKM25ubkNwNy9PLzE1em1PWXJDZ1dhSlRS?=
 =?utf-8?B?SG5ueC8zc3ZueUEyY2dGa2grb0k0eWduVVZvNW0rSml4TkllSTVqUFNhejNI?=
 =?utf-8?B?S2FQVGZNb3l4cDRSTTRTNHMzblR1MXhmUEc4UldIdW1lLzlwVTM5eEI2KzVN?=
 =?utf-8?B?WGpSS3NDZGl0amxxNjJsVTNUUzhua2NCTWRKc28zVzZHSmNqVUgvS3pvWFZz?=
 =?utf-8?B?K0VBVytSbXROM2ZYVlFxU2FaazhsL203Vyt2NjJsQXBqYUI1SGhSQUJRSFRF?=
 =?utf-8?B?Z0FVdlJyM1hzUHAzeElNRFRRc0ZXZ0poNW55TERZd2dadjJ2Y0FZWVZ2MDF4?=
 =?utf-8?B?NnI0WW1ZYVVnMFg5WG8vZnlNU2twT3Brc3pBYnZjanluSmtTNGduMzYrU2FX?=
 =?utf-8?B?czFOclBVeUhDbEVKMHRpUkp6T1AyQ0lOWXhlWTNMZGtJMTVlQjRWUUM3UVR0?=
 =?utf-8?B?L252dVF1NW4wZ3RGNGpwd0NzdE1qSFpyMGU3TWFZMjlnSmJhd0tMbHZ6Q2hw?=
 =?utf-8?B?YUhxam1ySXFXWmZFaFU4V3UxNVRycXVNQzZHMENEeFVRSjJsbDVkK1BjbXMz?=
 =?utf-8?B?TmFsaHhHTVlhY0JFbkUwZktSOVdwVG84azl1M0k4THA0VDB4V1Fxd3ZWQnRu?=
 =?utf-8?B?VlBKUDEvd1JFVHNOWUozaERsQ280aXE3Ym9NN0hwLzhQQUEveCtpaHhnTFBx?=
 =?utf-8?B?bGFVb1RJckRheWFPV1VrOHBjaUlWVk1Yb0ZkZ29QcjlCb3hSRFhLQmpyRkpI?=
 =?utf-8?B?Z2hoRURKTWwzVGgxM3Y4M280VnpVK0hBeDdzeEF4cjJKUE93dkVIMzZHMXlV?=
 =?utf-8?B?RDhERS9malpnTGFXK1p0MVdZQzVvaFFxMWt6ZG5RMlZBcTVkSzRHVmZYRHFP?=
 =?utf-8?B?RWxKdXZYU2ZnbjFtRzNvVTR3VjBYN0lUVTZVc0dvczkrQ3pVazJ4cW00elFp?=
 =?utf-8?B?SDFqcmQ1T3hFdGhaekJzKzdwNDd2OERyRzRKTGVCS3VqUzVFNm5NWVVubjYw?=
 =?utf-8?Q?iW7y9MQsp27XCYJGVrjAHIKMzO30lVkyop4DY4J?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF03F54F5AC1D6419139E1B312E3644C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6afa548-aa7a-4507-72ac-08d93a800661
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 21:59:38.6362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wg95o+geiUbQQjFwZ1TnefJLylMrrRf++OyO5+UyeOVOoXx0T3pd0ZJxf2H74VoBV1FJv34nrL9uk64oDFDv7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3720
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA2LTI4IGF0IDE3OjEyIC0wNDAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gTW9uLCBKdW4gMjgsIDIwMjEgYXQgMzowOSBQTSBUcm9uZCBNeWtsZWJ1c3QNCj4g
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIDIwMjEt
MDYtMjggYXQgMTM6MzkgLTA0MDAsIERhdmUgV3lzb2NoYW5za2kgd3JvdGU6DQo+ID4gPiBFYXJs
aWVyIGNvbW1pdHMgcmVmYWN0b3JlZCBzb21lIE5GUyByZWFkIGNvZGUgYW5kIHJlbW92ZWQNCj4g
PiA+IG5mc19yZWFkcGFnZV9hc3luYygpLCBidXQgbmVnbGVjdGVkIHRvIHByb3Blcmx5IGZpeHVw
DQo+ID4gPiBuZnNfcmVhZHBhZ2VfZnJvbV9mc2NhY2hlX2NvbXBsZXRlKCkuwqAgVGhlIGNvZGUg
cGF0aCBpcw0KPiA+ID4gb25seSBoaXQgd2hlbiBzb21ldGhpbmcgdW51c3VhbCBvY2N1cnMgd2l0
aCB0aGUgY2FjaGVmaWxlcw0KPiA+ID4gYmFja2luZyBmaWxlc3lzdGVtLCBzdWNoIGFzIGFuIElP
IGVycm9yIG9yIHdoaWxlIGEgY29va2llDQo+ID4gPiBpcyBiZWluZyBpbnZhbGlkYXRlZC4NCj4g
PiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGF2ZSBXeXNvY2hhbnNraSA8ZHd5c29jaGFAcmVk
aGF0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBmcy9uZnMvZnNjYWNoZS5jIHwgMTQgKysrKysr
KysrKysrLS0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvZnNjYWNoZS5jIGIv
ZnMvbmZzL2ZzY2FjaGUuYw0KPiA+ID4gaW5kZXggYzRjMDIxYzZlYmJkLi5kMzA4Y2I3ZTFkZDQg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9uZnMvZnNjYWNoZS5jDQo+ID4gPiArKysgYi9mcy9uZnMv
ZnNjYWNoZS5jDQo+ID4gPiBAQCAtMzgxLDE1ICszODEsMjUgQEAgc3RhdGljIHZvaWQNCj4gPiA+
IG5mc19yZWFkcGFnZV9mcm9tX2ZzY2FjaGVfY29tcGxldGUoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICpjb250ZXh0LA0K
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGVycm9yKQ0KPiA+
ID4gwqB7DQo+ID4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBuZnNfcmVhZGRlc2MgZGVzYzsNCj4g
PiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGlub2RlICppbm9kZSA9IHBhZ2UtPm1hcHBpbmctPmhv
c3Q7DQo+ID4gPiArDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBkZnByaW50ayhGU0NBQ0hFLA0KPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIk5GUzogcmVhZHBhZ2VfZnJvbV9m
c2NhY2hlX2NvbXBsZXRlDQo+ID4gPiAoMHglcC8weCVwLyVkKVxuIiwNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhZ2UsIGNvbnRleHQsIGVycm9yKTsNCj4gPiA+IA0K
PiA+ID4gLcKgwqDCoMKgwqDCoCAvKiBpZiB0aGUgcmVhZCBjb21wbGV0ZXMgd2l0aCBhbiBlcnJv
ciwgd2UganVzdCB1bmxvY2sNCj4gPiA+IHRoZQ0KPiA+ID4gcGFnZSBhbmQgbGV0DQo+ID4gPiAt
wqDCoMKgwqDCoMKgwqAgKiB0aGUgVk0gcmVpc3N1ZSB0aGUgcmVhZHBhZ2UgKi8NCj4gPiA+IMKg
wqDCoMKgwqDCoMKgIGlmICghZXJyb3IpIHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBTZXRQYWdlVXB0b2RhdGUocGFnZSk7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdW5sb2NrX3BhZ2UocGFnZSk7DQo+ID4gPiArwqDCoMKgwqDCoMKgIH0gZWxz
ZSB7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXNjLmN0eCA9IGNvbnRl
eHQ7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZnNfcGFnZWlvX2luaXRf
cmVhZCgmZGVzYy5wZ2lvLCBpbm9kZSwgZmFsc2UsDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiA+
ID4gJm5mc19hc3luY19yZWFkX2NvbXBsZXRpb25fb3BzKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGVycm9yID0gcmVhZHBhZ2VfYXN5bmNfZmlsbGVyKCZkZXNjLCBwYWdl
KTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnJvcikNCj4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+
ID4gDQo+ID4gVGhpcyBjb2RlIHBhdGggY2FuIGNsZWFybHkgZmFpbCB0b28uIFdoeSBjYW4gd2Ug
bm90IGZpeCB0aGlzIGNvZGUNCj4gPiB0bw0KPiA+IGFsbG93IGl0IHRvIHJldHVybiB0aGF0IHJl
cG9ydGVkIGVycm9yIHNvIHRoYXQgd2UgY2FuIGhhbmRsZSB0aGUNCj4gPiBmYWlsdXJlIGNhc2Ug
aW4gbmZzX3JlYWRwYWdlKCkgaW5zdGVhZCBvZiBkZWFkLWVuZGluZyBoZXJlPw0KPiA+IA0KPiAN
Cj4gTWF5YmUgdGhlIGJlbG93IHBhdGNoIGlzIHdoYXQgeW91IGhhZCBpbiBtaW5kP8KgIFRoYXQg
d2F5IGlmIGZzY2FjaGUNCj4gaXMgZW5hYmxlZCwgbmZzX3JlYWRwYWdlKCkgc2hvdWxkIGJlaGF2
ZSB0aGUgc2FtZSB3YXkgYXMgaWYgaXQncyBub3QsDQo+IGZvciB0aGUgY2FzZSB3aGVyZSBhbiBJ
TyBlcnJvciBvY2N1cnMgaW4gdGhlIE5GUyByZWFkIGNvbXBsZXRpb24NCj4gcGF0aC4NCj4gDQo+
IElmIHdlIGNhbGwgaW50byBmc2NhY2hlIGFuZCB3ZSBnZXQgYmFjayB0aGF0IHRoZSBJTyBoYXMg
YmVlbg0KPiBzdWJtaXR0ZWQsDQo+IHdhaXQgdW50aWwgaXQgaXMgY29tcGxldGVkLCBzbyB3ZSds
bCBjYXRjaCBhbnkgSU8gZXJyb3JzIGluIHRoZSByZWFkDQo+IGNvbXBsZXRpb24NCj4gcGF0aC7C
oCBUaGlzIGRvZXMgbm90IHNvbHZlIHRoZSAiY2F0Y2ggdGhlIGludGVybmFsIGVycm9ycyIsIElP
VywgdGhlDQo+IG9uZXMgdGhhdCBzaG93IHVwIGFzIHBnX2Vycm9yLCB0aGF0IHdpbGwgcHJvYmFi
bHkgcmVxdWlyZSBjb3B5aW5nDQo+IHBnX2Vycm9yIGludG8gbmZzX29wZW5fY29udGV4dC5lcnJv
ciBmaWVsZC4NCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvcmVhZC5jIGIvZnMvbmZzL3JlYWQu
Yw0KPiBpbmRleCA3OGI5MTgxZTk0YmEuLjI4ZTMzMTgwODBlMCAxMDA2NDQNCj4gLS0tIGEvZnMv
bmZzL3JlYWQuYw0KPiArKysgYi9mcy9uZnMvcmVhZC5jDQo+IEBAIC0zNTcsMTMgKzM1NywxMyBA
QCBpbnQgbmZzX3JlYWRwYWdlKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgcGFnZQ0KPiAqcGFn
ZSkNCj4gwqDCoMKgwqDCoMKgwqAgfSBlbHNlDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBkZXNjLmN0eCA9DQo+IGdldF9uZnNfb3Blbl9jb250ZXh0KG5mc19maWxlX29wZW5fY29u
dGV4dChmaWxlKSk7DQo+IA0KPiArwqDCoMKgwqDCoMKgIHhjaGcoJmRlc2MuY3R4LT5lcnJvciwg
MCk7DQo+IMKgwqDCoMKgwqDCoMKgIGlmICghSVNfU1lOQyhpbm9kZSkpIHsNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IG5mc19yZWFkcGFnZV9mcm9tX2ZzY2FjaGUoZGVz
Yy5jdHgsIGlub2RlLA0KPiBwYWdlKTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChyZXQgPT0gMCkNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGdvdG8gb3V0Ow0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZ290byBvdXRfd2FpdDsNCj4gwqDCoMKgwqDCoMKgwqAgfQ0KPiANCj4gLcKgwqDC
oMKgwqDCoCB4Y2hnKCZkZXNjLmN0eC0+ZXJyb3IsIDApOw0KPiDCoMKgwqDCoMKgwqDCoCBuZnNf
cGFnZWlvX2luaXRfcmVhZCgmZGVzYy5wZ2lvLCBpbm9kZSwgZmFsc2UsDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZuZnNfYXN5bmNf
cmVhZF9jb21wbGV0aW9uX29wcyk7DQo+IA0KPiBAQCAtMzczLDYgKzM3Myw3IEBAIGludCBuZnNf
cmVhZHBhZ2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBwYWdlDQo+ICpwYWdlKQ0KPiANCj4g
wqDCoMKgwqDCoMKgwqAgbmZzX3BhZ2Vpb19jb21wbGV0ZV9yZWFkKCZkZXNjLnBnaW8pOw0KPiDC
oMKgwqDCoMKgwqDCoCByZXQgPSBkZXNjLnBnaW8ucGdfZXJyb3IgPCAwID8gZGVzYy5wZ2lvLnBn
X2Vycm9yIDogMDsNCj4gK291dF93YWl0Og0KPiDCoMKgwqDCoMKgwqDCoCBpZiAoIXJldCkgew0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gd2FpdF9vbl9wYWdlX2xvY2tl
ZF9raWxsYWJsZShwYWdlKTsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgh
UGFnZVVwdG9kYXRlKHBhZ2UpICYmICFyZXQpDQo+IA0KPiANCj4gDQo+IA0KPiA+ID4gKw0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX3BhZ2Vpb19jb21wbGV0ZV9yZWFk
KCZkZXNjLnBnaW8pOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+ID4gwqB9DQo+ID4gPiAN
Cj4gPiANCj4gPiAtLQ0KPiA+IFRyb25kIE15a2xlYnVzdA0KPiA+IExpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCj4gPiB0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQo+ID4gDQo+ID4gDQo+IA0KDQpZZXMsIHBsZWFzZS4gVGhpcyBhdm9pZHMgdGhhdCBkdXBs
aWNhdGlvbiBvZiBORlMgcmVhZCBjb2RlIGluIHRoZQ0KZnNjYWNoZSBsYXllci4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
