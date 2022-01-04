Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9320F4845AC
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jan 2022 16:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiADP4g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jan 2022 10:56:36 -0500
Received: from mail-dm6nam10on2128.outbound.protection.outlook.com ([40.107.93.128]:33472
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235202AbiADPyj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrQ9CXGmCZ/XXfl2ZHhi7nRzgwEGbfN+yzAiR/G09PPCRPUsuznMcIvYo0zevBpc8d4OfzDFfXm2+078Z9OhlHeXSTQ5rp2o6pTdyqdrE5+kNt5oUhX50+4aBZeNRKcOSPdpeWMP592s3wckkAitror7qKa0jmb2deTs+co8OAPeQFEPqSFXnujEJVdGDJH3BgbrH/tch/oFJLzmrPRY1qYGx5HlU04s3Q3FnxMxdiTeCvttZqXHluJiOR7tmHtwhWt1OiTnTPcsP5eltBWPESbE95XYooh5CKVzX6RTcecJThoA6FF0BKMmkOnpWPX1MJSVs3U8f1Fwi1auP2zejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLIvUFl4YGQjL/kosNlHoWVO0lpFfWPCQJ0akOY0cnc=;
 b=TnZBcB8P3HERaUJ+Jh8vhDBioPVh1H1Tp71TPK8uymn1So2ObmTUIH5rDt3xEh1e2AlicoilwVP2dfYiR13S2OLSyOJrQot/kg5NoJd7PfEMg7eXuDzEWOTKdNPNKIRmuWk0FJFMvoWGpHAxb4Q5EkdP2+j7osXVGjJAgZB8Zz/l7A/htZo8+0pHBhLrQGPYqsNTBLeCNumFK2eRnUQbPQ7wlqK61aUJpHv7Vi6kPF/JHFQY6abWC7nkIUgQM1fSbmgiTUMRwu8GzPTt4M699Ca4Qskv1qGrfPKzSVwF61y3lF7dTvmdSICiKeWJnLroWA1YMKb+0XPG1kSTjA3rdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLIvUFl4YGQjL/kosNlHoWVO0lpFfWPCQJ0akOY0cnc=;
 b=Y7biWUHowtwU2iJrvZvErmsx6qeoaKdjwh2Wwt9ER0GDfn8YRBz2aCZ1ejawMP/lD7JuccksU2+vcy1DU8KmpUslJepgUvjbLMDd4McpBitNgpF3qn4L3gMSPLpSPLaGXXupISYcVYSOnmRxQm3wlRbXO6WaQbtdNwU1RTkJoos=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 PH0PR13MB5613.namprd13.prod.outlook.com (2603:10b6:510:142::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.12; Tue, 4 Jan
 2022 15:54:34 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::15bd:faea:f83a:2874]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::15bd:faea:f83a:2874%4]) with mapi id 15.20.4867.007; Tue, 4 Jan 2022
 15:54:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>
Subject: Re: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqKDxq04E9R4EezGQhAvzMsOqjeMTgAgABM3wCAAF7VgIAF4BMAgJ9AToCAAArJgILGzxlrgAooz4CAAR4sAIAANXEAgAAxJICAAAZDAA==
Date:   Tue, 4 Jan 2022 15:54:31 +0000
Message-ID: <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>
References: <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
         <20200618200905.GA10313@fieldses.org> <20200622135222.GA6075@fieldses.org>
         <20201001214749.GK1496@fieldses.org>
         <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
         <20201006172607.GA32640@fieldses.org>
         <164066831190.25899.16641224253864656420@noble.neil.brown.name>
         <20220103162041.GC21514@fieldses.org>
         <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
         <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
         <20220104153205.GA7815@fieldses.org>
In-Reply-To: <20220104153205.GA7815@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5276e522-0b36-441a-5a45-08d9cf9a7f71
x-ms-traffictypediagnostic: PH0PR13MB5613:EE_
x-microsoft-antispam-prvs: <PH0PR13MB5613502237CFF0C92903C405B84A9@PH0PR13MB5613.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/noVkqv3onUxQlq66dMMqOFsUViR3woX0tgRcfqllKhQLbYE+Ye0ZHqB4U5kCPrrykEjvkbUS9XfFMooKj4wbo87mnY2sIPOekjWqkGDqiVwcRhMeK06533NVI0G2pPAcWHHxBtNChFL9QUBLByWmGrM/Ix+3EDUhb0vIYMwPaCNyUc2CiWxiRWPm3H48tykdo6CPG4jUU9EUYd/zR5mzUHligF9EZBD7tWakMpAXqaZB6a4fvkHIrrMRRIsurNBdznHZzBz84K9L0pttgS/7MgKD7rtG1b6TSd9MX67vTCmda3C1VxaPXR/OdREbkD82OrMR6GJyDQ/rR15SJSbiWDsUo0k11Ikr65GMQtmQWEqDqIB/K3rC98RSetH4YeugijZHnagAyCzFiIakTVDJSEDiziCWCn6im0ro5N+WqAEIBxTIOJ7jB1adKIn7Ds/mTGQjzlzOXFSU95rR5AZh8ihdEbqMiH1cLa7sEdYe89qpAwiXvr+hVWCgh2VXplAaKP0oWwAuVHCcJD7RFnpINJhxyt+X3CoPaWX9MhkJ7owYc1W2KACECbM/xNnro0/H9pQvO6FiLbzwZJQMUOGFsCqcFe1/nxcGwLivVDqvb6rNUkRgUXavr+GMv0/kdL8EyYQX0D7U196fgOjcePx6ZnUdKwUBDtFB2e6Vpoq2LMNp/ISDehozNV5IgfZnjuVFsal26KjZ3biIcHkTmu0UwzsHqFYC6HTZtD1HJ3CEkPNxsS/ANh0LsNN8x88jQAQ1mPz1nFJE2eqZK9SUFk5K3lf6KzFEzCg14LFYLx8qk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(376002)(346002)(396003)(39830400003)(8936002)(54906003)(36756003)(6506007)(3480700007)(38100700002)(508600001)(76116006)(83380400001)(38070700005)(26005)(91956017)(6916009)(966005)(71200400001)(2616005)(2906002)(316002)(86362001)(4326008)(66946007)(66476007)(122000001)(6512007)(66446008)(64756008)(66556008)(5660300002)(6486002)(8676002)(186003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGZqN2cwc2pTMVFFbGRxaVlYb0x5cmQzV2RmdC9mMWVsUDR3dXhBTGtEQzBj?=
 =?utf-8?B?aXRORUxpVmxsY2RZWE9SckI4S0taMDBuS3ZJaVErc2hwS3ZLWGczV1hUZUJZ?=
 =?utf-8?B?VnZTYW51T1NBMVRpcCtsSzdlWGFNbnRFRnAxelRJL2I4bk9iSTViZkdMZnIy?=
 =?utf-8?B?VjhsK3RsSFM4TXJweGFpTGc1WVpabWtzRTk4Y3BHT21BUWpGRW82U0o2eU5w?=
 =?utf-8?B?QUo1VCt0VWpWTUxTSHpFWlpsd1RUSGJpa3ptUEFZZ29aZEVXQWpaRlg5TlFp?=
 =?utf-8?B?eDBKenhhNW9PZnBhR2tYWlpacFdjQklyQU1LTWkycU45cnk3cmF1V0h6bmdk?=
 =?utf-8?B?YnhZWFFlRlQ0OW5BaTNSQmw2S2sxTGlzYUxyYmxhUG5qVTZnZnFKaDkzYzJm?=
 =?utf-8?B?cEtvcG9pWVBNbnBqb1o3TXFjT2dHYkVLM2J2ZkJGR2hNL0JsazVVTUFualhl?=
 =?utf-8?B?dGxKSEwxK3UxczcyL3B2dzlzRE5zNk1UVitMbnJYNXNraUNJRWhLUHVKL3h2?=
 =?utf-8?B?SVpET0xRK0crdUU2OXhBcjNRTTB0UVZaK3l4LytQNXlQekEzcGl1aE5xMlly?=
 =?utf-8?B?VnRZTnJrcHY5M3BVZXMreHQ1K1FUb3NwNXlRR1Z1amlKY0JRZ1dwd1Jwb0pT?=
 =?utf-8?B?cmUvQ2FuR01WenBOYmdNYkJHd3kvUEQvUDNwZjJzYWl3ZXZhcGg4M3lrdVF6?=
 =?utf-8?B?eHJGbVNmVlNqOUxoeFlsZVZCbkd0WGhQazNSQlROSU9GUFBIdFc2eFRGa3Uw?=
 =?utf-8?B?dnFORFRFeFNwdWVsd2lGakVCdzNCUE4ySVZjMkJNZGFEeEZaR1BrU1hhbWxj?=
 =?utf-8?B?WWl2QjdMQnJkR2JnaElBWWgrYU1rN0V3YlZ6SHFsc3NNZ2U2VFFabzU5VUt1?=
 =?utf-8?B?a2ovVGw1YjRqZmkwOXhKUDVJUld0TVo5Um9sbDBLNkJ5R2YwL2NVQ3lCMFNJ?=
 =?utf-8?B?dzBhWFU4a1hONzIvSysySVVmUGpxYStibXR0L3Fialp1UlJvV0NEK0t2SW9R?=
 =?utf-8?B?emp1Q3BuWEphc0o0QUhBSWpuV04wb0dTUjVSejdpemxCNnp3T2dXZHhKNGVH?=
 =?utf-8?B?SUJDUGFINE5xVUw3U0tqbG5SSjF5QVI1R08rcWhxc0tBK2dZWXVMdnRrbng3?=
 =?utf-8?B?Wndyd0lCVVJWYzZVRHc4NE50Z1FUSFBCS0RQRkVMaWY0NHZ4Q1lFMk5tMlBm?=
 =?utf-8?B?ZVduNktOSTMramgzaTJISVJ1UWlGcUxIc0g5S3lsTVZXdmpXeE1IaE9sTGtv?=
 =?utf-8?B?NDFtZmcwU1BKZ0JVZitIQysrcVYrTjlZZVloQVkrTzYwTDZ3RittL0VGaFdD?=
 =?utf-8?B?MlVLZkJJSmRYK1l2NDE0Znd1b0JsR0hnalFLeEVFNjF5Nk40Nlgyd05WRE9U?=
 =?utf-8?B?cWdoTE9LMGxKa0RXWnZrM2dIR0hGYmxJbml6Ri9nOWFHalpReEFEUmgwSzdo?=
 =?utf-8?B?aDRDL1I3UTFieU5Xb3VDSnMrVDZXOXhrTXFKWTBROTJPTkM1V2ZycHlya2Yr?=
 =?utf-8?B?cU00NGpEbEZXb2Q1MVQvcm9nQUxUVnZVTWZnM0FZeDFIWks0UnJsaG9qMXhj?=
 =?utf-8?B?SE0vTzRuLzFwR2hUQklsVDV3bFd0SWFEVVQza0FHem5zL0xta1d2VnU4UjE2?=
 =?utf-8?B?dWl6L1kwcXJFek5Za1RtWHo3aE1ESC9zYUI2QUtmc0RJSTlDM0lwOTNWMzdi?=
 =?utf-8?B?M2ZBUWJKODdRWUhzSUFLOTVGOTNPS2EyYlF2WVNUbGVFdTlUUjY3d1BqSmlW?=
 =?utf-8?B?dWRaVEk0RU94OTVWYmdMSFZuS0VIMm1tRVhLYlZaV2ZrZHlSaHBSc2V1MmI2?=
 =?utf-8?B?bjgyMW1kSHl5emZ1U1NaaHloV3NtUG5VZm9zWGl5YUxHQUs2NVNHQ0NWVHJE?=
 =?utf-8?B?SmwrSldsQWFVNkpJdXFpUnlab0FhUGo5cUxBTzNUQ2MxV3g4Z2F1c0h5KzZY?=
 =?utf-8?B?ZmptY2hMbzdPMnR4TXZHamc1S1NYcHovNzFxQzlFanNtL2UxcmI3UXBTYXVI?=
 =?utf-8?B?SzdPZUc3c0dmdWEzS29TSm5veUpEMFdLVk1KKzQ2dVVBVm1YRGlWeTQ2RWpY?=
 =?utf-8?B?NU1ZYWJXZVAvbThhQk9scHZIeWM0cGM0NURiODY0dGR3S0d1QmprTjlQZ0p2?=
 =?utf-8?B?SlYwdVQvRnNyVmpad09UYjI0ZzRvQ3IxVjlXYWVIamlLTi8vSVpuMFErRnZi?=
 =?utf-8?Q?FPoRk376VjrGZJA8H6ifMNQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6902A139F067443A31D9D099520584D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5276e522-0b36-441a-5a45-08d9cf9a7f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 15:54:31.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYJbdWolNzJo4DlwOpEMQmrrMsftRA118MwqgyEYLtPoyjZvCwq8VaOkCVi9MJ2YTf6ucRAFpTnltErBxC86Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5613
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTA0IGF0IDEwOjMyIC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVHVlLCBKYW4gMDQsIDIwMjIgYXQgMTI6MzY6MTRQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMi0wMS0wNCBhdCAwOToyNCArMDAwMCwg
aW5vZ3VjaGkueXVraUBmdWppdHN1LmNvbcKgd3JvdGU6DQo+ID4gPiBIaSBOZWlsIGFuZCBCcnVj
ZSwNCj4gPiA+IA0KPiA+ID4gVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KPiA+ID4gTm93
IEkgaGF2ZSB1bmRlcnN0b29kIHRoYXQgdGhpcyBiZWhhdmlvciBpcyBieSBkZXNpZ24uDQo+ID4g
PiANCj4gPiA+ID4gPiBXaXRoIE5GU3Y0IHRoZXJlIGlzIG5vIGF0b21pY2l0eSBndWFyYW50ZWVz
IHJlbGF0aW5nIHRvDQo+ID4gPiA+ID4gd3JpdGVzDQo+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4g
Y2hhbmdlaWQuDQo+ID4gPiA+ID4gVGhlcmUgaXMgcHJvdmlzaW9uIGZvciBhdG9taWNpdHkgYXJv
dW5kIGRpcmVjdG9yeSBvcGVyYXRpb25zLA0KPiA+ID4gPiA+IGJ1dA0KPiA+ID4gPiA+IG5vdA0K
PiA+ID4gPiA+IGFyb3VuZCBkYXRhIG9wZXJhdGlvbnMuDQo+ID4gPiANCj4gPiA+IFNvIEkgZmVl
bCBsaWtlIGNsaWVudHMgY2Fubm90IGFsd2F5cyB0cnVzdCBjaGFuZ2VpZCBpbiBORlN2NC4gDQo+
ID4gPiBTaG91bGQgaXQgYmUgZGVzY3JpYmVkIGluIHRoZSBzcGVjPw0KPiA+ID4gDQo+ID4gPiBG
b3IgZXhhbXBsZSwgdGhlIGZvbGxvd2luZyBzZWN0aW9uIHJlZmVycyBhYm91dCB0aGUgdXNhZ2Ug
b2YNCj4gPiA+IGNoYW5nZWlkOg0KPiA+ID4gaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9k
b2MvaHRtbC9kcmFmdC1kbm92ZWNrLW5mc3Y0LXJmYzU2NjFiaXMjc2VjdGlvbi0xNC4zLjENCj4g
PiA+IA0KPiA+ID4gSXQgc2F5cyBjbGllbnRzIHVzZSBjaGFuZ2UgYXR0cmlidXRlICIgdG8gZW5z
dXJlIHRoYXQgdGhlIGRhdGENCj4gPiA+IGZvcg0KPiA+ID4gdGhlIE9QRU5lZCBmaWxlIGlzIHN0
aWxsIA0KPiA+ID4gY29ycmVjdGx5IHJlZmxlY3RlZCBpbiB0aGUgY2xpZW50J3MgY2FjaGUuIiBC
dXQgaW4gZmFjdCwgaXQgY291bGQNCj4gPiA+IGJlDQo+ID4gPiB3cm9uZy4NCj4gPiANCj4gPiBU
aGUgZXhpc3RlbmNlIG9mIGJ1Z2d5IHNlcnZlcnMgaXMgbm90IGEgcHJvYmxlbSBmb3IgdGhlIGNs
aWVudCB0bw0KPiA+IGRlYWwNCj4gPiB3aXRoLiBJdCdzIGEgcHJvYmxlbSBmb3IgdGhlIHNlcnZl
ciB2ZW5kb3JzIHRvIGZpeC4NCj4gDQo+IEkgYWdyZWUgdGhhdCwgaW4gdGhlIGFic2VuY2Ugb2Yg
YnVncywgdGhlcmUncyBubyBwcm9ibGVtIHdpdGggdXNpbmcNCj4gdGhlDQo+IGNoYW5nZSBhdHRy
aWJ1dGUgdG8gcHJvdmlkZSBjbG9zZS10by1vcGVuIGNhY2hlIGNvbnNpc3RlbmN5Lg0KPiANCj4g
VGhlIGludGVyZXN0aW5nIHF1ZXN0aW9uIHRvIG1lIGlzIGhvdyB5b3UgdXNlIGxvY2tzIHRvIHBy
b3ZpZGUgY2FjaGUNCj4gY29uc2lzdGVuY3kuDQo+IA0KPiBMYW5ndWFnZSBsaWtlIHRoYXQgaW4N
Cj4gaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2MvaHRtbC9yZmM3NTMwI3NlY3Rpb24t
MTAuMy4ywqBpbXBsaWVzDQo+IHRoYXQgeW91IGNhbiBnZXQgc29tZXRoaW5nIGxpa2UgbG9jYWwg
Y2FjaGUgY29uc2lzdGVuY3kgYnkgd3JpdGUtDQo+IGxvY2tpbmcNCj4gdGhlIHJhbmdlcyB5b3Ug
d3JpdGUsIHJlYWQtbG9ja2luZyB0aGUgcmFuZ2VzIHlvdSByZWFkLCBmbHVzaGluZw0KPiBiZWZv
cmUNCj4gd3JpdGUgdW5sb2NrcywgYW5kIGNoZWNraW5nIGNoYW5nZSBhdHRyaWJ1dGVzIGJlZm9y
ZSByZWFkIGxvY2tzLg0KPiANCj4gSW4gZmFjdCwgdGhhdCBkb2Vzbid0IGd1YXJhbnRlZSB0aGF0
IHJlYWRlcnMgc2VlIHByZXZpb3VzIHdyaXRlcy4NCj4gDQoNCkl0IGRvZXMgaWYgeW91IGFyZSBk
b2luZyBmdWxsIGZpbGUgbG9ja2luZy4gSSBhZ3JlZSBpdCB3aWxsIG5vdCwgaWYgeW91DQphcmUg
ZG9pbmcgcGFydGlhbCBmaWxlIGxvY2tpbmcuDQoNCklPVzogSWYgdHdvIGNsaWVudHMgY2FuIHBv
dGVudGlhbGx5IGJvdGggd3JpdGUgdG8gZGlmZmVyZW50IHBhcnRzIG9mDQp0aGUgc2FtZSBmaWxl
IGF0IHRoZSBzYW1lIHRpbWUsIHRoZW4gdGhhdCB0aGUgY2hhbmdlIGF0dHJpYnV0ZSBpcw0KaW5z
dWZmaWNpZW50IHRvIGRldGVybWluZSB3aGV0aGVyIG9yIG5vdCB0aGF0IHdhcyBpbmRlZWQgd2hh
dCBoYXBwZW5lZC4NCg0KSG93ZXZlciBpZiBvbmx5IG9uZSBjbGllbnQgY2FuIHdyaXRlIHRvIHRo
ZSBmaWxlIGF0IGFueSB0aW1lLCB0aGVuIHRoZQ0KY2hhbmdlIGF0dHJpYnV0ZSBjaGVjayBzaG91
bGQgYmUgc3VmZmljaWVudCwgZ2l2ZW4gYSBORlN2NCBzcGVjDQpjb21wbGlhbnQgc2VydmVyLg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
