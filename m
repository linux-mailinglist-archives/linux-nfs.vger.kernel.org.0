Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF053DF70B
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Aug 2021 23:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhHCVoK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 17:44:10 -0400
Received: from mail-bn8nam11on2128.outbound.protection.outlook.com ([40.107.236.128]:49313
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229577AbhHCVoK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Aug 2021 17:44:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDSEqhfdjqw2kpw2Bh/bJl66hfeq5st8ZG3z8FgwvxTQWO0mkfSO1GQZEsY4a/XDGy33oFDYfOi9Rk7WbVmLEF9kdEdUQ25Ud5OhkCxSH/WtGWBg1zSoGHVl3BgA021cNkbTSx36VOMg0ZrfFqbAXFDGOtH+sYTWf9h3Z9m21GDrHolmCEafElYBEXc0T2Emh3h3KHoQgPzE9FmoN490c44Vl011Lv70sEIMJk2LgHZkqjf4YG1YRoxuQlvKLDZWI5etqyhEkO28+S9RxjiLLUxPWa+ftJRzhz8AtMljMYbZUm6kHEm9TZJi6ai/SF6wFX2hYhvGJp2q703F+CXXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL6eTkQbexWribkXMwm+0G6BRUFAoxQ+aOK0RkDAKrQ=;
 b=hA34pmeHnBvEgREvzi5taRHP69jGjK5UvDz7hU5C2zhsxWuLW4d/y8htjvKdWimD1EQL2bh9cPVAlAn5+jpEHBe267cwspG8KR/kOieTlhskNhxuS3eflvIAxSZR8n4SZaLhHZpMR/UAdI/YLUMC9/IJKBkFKCqn8DdFnGeKHa2BcljL2NaydnVT8t3pP4L25IV3XBe7es4CQkK/tkvTgQRjF71XpBDL5HSMRaLQtYrNE/RFyd9HaRpU1fIzpn6dVPdfbZ59cRgvo8E/rNjqR/BePV1brRMxNzW+Vd/xOxMP89CUDiHgadd/5Vblv040PAGWMHh3T9jU/qses9oqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL6eTkQbexWribkXMwm+0G6BRUFAoxQ+aOK0RkDAKrQ=;
 b=Og8AYhZEp5ayvUPpPR1mO0J2e2VHQP/VJAdKkq0XIT3vZWDpHSs9BMrI7j6F9MC0j6kADuCkmk02AoJyjjw6NiRcIL45RE8CvKFlsPhlv34ciMwqh0xZ9XudUx3NKJ5e2ay6cZk2PGFiL1m4BM+EhLY+h+2Od+9uMJ4WAh9rCBA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4730.namprd13.prod.outlook.com (2603:10b6:610:c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.13; Tue, 3 Aug
 2021 21:43:55 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4394.015; Tue, 3 Aug 2021
 21:43:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqAgAao74CAAAokgIAACEIAgAACAoA=
Date:   Tue, 3 Aug 2021 21:43:55 +0000
Message-ID: <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
         <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
         <20210803203051.GA3043@fieldses.org>
         <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>
         <20210803213642.GA4042@fieldses.org>
In-Reply-To: <20210803213642.GA4042@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac19a8ea-0c64-4c91-7c0a-08d956c7cb06
x-ms-traffictypediagnostic: CH0PR13MB4730:
x-microsoft-antispam-prvs: <CH0PR13MB47309748A4916CEE03CDCAB6B8F09@CH0PR13MB4730.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeJM2NefK2K5c84/WefynHfVBhYQTPumYR7c1/tOcW4+RayTWmwnv1nVDF5eC0HuIG5+neNy72y3+s9W3+NPTTvOBcYXGlckzSe7CbRCA2mf6Qwt8vkeJmO/lt45C8YbLaOREyDkQyocnHM1yg2Hbjw/S2HFSGxBhB4ARKLa2Y/Z1BsOKN+UJVeoOTIVcTnL+QUpEa1V54Vl0PqOFmqJ3bojApOs+Xq3gjc77YKi4mwGNpvqnWt3pywabetqcONUJqK8M3fuPRpR6YFWw7uS/u0CWuujsSw7+6cxvtT99Beo4i+NfuYvAHdvtwdGRIuIZ+MJIj1NkFpSheormIvCavnq/vJREM+Z9fTulq41P3vs0g1nEc5341GFgSw+VB32P0L46ldHrAR/2nvKVEMG+LkVCyRX/kO9bG0J+m88SYshhQBtu3lTcOm6kjVWO3RLUifqya5BERZYRa8cY6amZGFAk7cHlx8/EBGIVggPo26jjzTN13fZ+H6F81NvuPNF3nAZt22SwIgO6Hx2+VKi1+qvnEcamtrhZv9jL93aLJqmz27KEXLlkERm8B5Scn9VEP4vSpb0US8aKp4p7WmpLoVtiOuBz5GXNuk62P+hnM+Esul6MGtq4oV6VTZy4EbiRTVeoSfzjMefwo46E6w3l8QxdQzKBmVN87sQHZBqWp8PuVj3QHyQqa5FTM6Ijso6ruOmGPEBybSvn/drv4Ze9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39840400004)(346002)(376002)(86362001)(8936002)(8676002)(6916009)(54906003)(38100700002)(2906002)(36756003)(316002)(122000001)(38070700005)(2616005)(6506007)(5660300002)(6512007)(186003)(66556008)(66476007)(66946007)(76116006)(71200400001)(66446008)(64756008)(26005)(4326008)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVRCVWg2d1Y1enhtRFVaM0daeDVtQU1ENVhLN1FqZ282eUpBMFlDZ0NMQmxv?=
 =?utf-8?B?Y3pvYlJBT0doMCtVc0IyWDkwQ1k4WmVQWDlySHh1dGt6QUJDSS9HYll0Wmto?=
 =?utf-8?B?NDAzU3UxZnhCZU9sVDRBeVhKSndnL2pUWkZUdU5KSmNSMU9HRVpWMkVOazdL?=
 =?utf-8?B?TWJrK2tTTW5KYXJjRXhjckc5VmlNelpXQ1pXNWhvdXluNmJQNHNWQnZmNThm?=
 =?utf-8?B?SGpTaHljaHI5dE5CZWxRZVpTdUtsZ3E4U0RkMmNNT0RJQU5hU0lWWU5tY2ho?=
 =?utf-8?B?NkFLMUZLcVJIZER4UHcwN0dDNDBITFdlMmtCSkR1Q1pTTEhGVC90ZUxoc3dx?=
 =?utf-8?B?K3c3RHJyY3JjS0dxc1RCc0JVRHBvamJDNmJlV1RZWVk2bmVZR2E1Wms4ODBS?=
 =?utf-8?B?SExlNk1wMVJ0MWJRcUV4ZkFzZXBadE9HTDZBMlU0Nk5XOHRES2szQUJSUzYy?=
 =?utf-8?B?SlFIT3V6L0JOUHIrZlBaOUdncHZUejZaclNjZktvUFJTZENTRkJTSzBKdkRG?=
 =?utf-8?B?b3kxWFVkb0hOSzVtcWtRQzBUQU9pVDhYaDNTZjF0K2VVb1J6VDRTdGRaTXht?=
 =?utf-8?B?SnJSRjF6NTVXVFprQ1VjVkdBbjE1UTVnZm82YnhKbEcxeWZ4aitwcE1qa3Mw?=
 =?utf-8?B?T0ZtRkNWR3lGMUxNYUZDQmRoUnZFekMzRjFDVmVheVNJNy9hNWVmSy82dml0?=
 =?utf-8?B?VFJrbTRjb3grTG9xT2hPcWR1V1lzRmpHR3ZjZ0VXMTBRbHcyODE3VmpIVjN0?=
 =?utf-8?B?VjNBRnVkUFMrODgvckxONWtDVUs2YUJoMzFZeldoRlNvbE5IN3NMMDFOaURK?=
 =?utf-8?B?WFVMbkFJa21pM0ZNMDJGZXBGT1lDQWJiZm5JVnNabkJmcmdqbTFjOFNWK0sw?=
 =?utf-8?B?ZnNjU0djRkZxUHBVbU1PWHBuTWY4UjA4M0Z0UTdGV05iWVR6K0FOUklVN1dD?=
 =?utf-8?B?VThNSVkzelJpcjFSRW1RTmJDU1BFdzlMN0ttTVdiNTNSdC8rQW1JSjZVdFRQ?=
 =?utf-8?B?Q3dNL0dlVUFXWkYva2ZoVm5sZHhudWp4b0lKd0Yyemd5NVh4UVRuUlNkV0pV?=
 =?utf-8?B?a0RrZ0hObTFBTU5KK0c2bjNDQ3hBWWZnTGVmOXBuQ3N1aU45cGxUaEpxaVd3?=
 =?utf-8?B?WXJVc2l5T1JadTR2WUtiL0xJUk1VVE1ycG4yUUF2NVU5WG5YSVVLa09GSm5z?=
 =?utf-8?B?OExWVlZMdTlWTGhsWjRsd3l4V3VWR0pEdjhYVjlrWmRDNkNJdjJoN2hsaEtG?=
 =?utf-8?B?Zjc3RjQ5RzJWOWszdHdCNzZVeVd5Y2JOUjB3eHIvWG5FMUdOMEJtQjJXT1lR?=
 =?utf-8?B?UG5SSW9kd0RUdjdudEZ2cmZ1cnJ3blkxQmFmajd0NEU3QXdSWFE0V29Zc2RX?=
 =?utf-8?B?aVhsZlJkQ0M2OXVvaTFONzVrRFpsTUdUVVpFRnkvSStJUUJYendSYXJJR1lO?=
 =?utf-8?B?K2xwV2kxbStSWDlNTDJZTTFZTWRBbkpOWlc3N1pyMDg4ZDdJTElDaUFuRm9j?=
 =?utf-8?B?RG5lSDBoditRcitiOXVNOFNGLzhJY3puMnNMTDU0Ym41Rm9nVFRsb3VTVG1I?=
 =?utf-8?B?YzBtUHNIdmZTOUMzNTc5RW5QdVRmOXpwdy9WTTB4Tjg5QnNCRGs5cXkzQlRa?=
 =?utf-8?B?SEpIUzBySlh1VFFLUEdudzNqcDd0aXRBcVdONURjL0tGTUtEeWJ3Ni9uaDhl?=
 =?utf-8?B?aGhpWDhKTjZab3g1Q2taR2R4NG12dWk2YnFxRFg3SHpqeEpjUnJyeFNpVFZD?=
 =?utf-8?Q?Yy8hXn+QZNPNm5xWlNEEwWxq35EnYJyATF6w28y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C559927F73F338499A2BBB11145D8F5F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac19a8ea-0c64-4c91-7c0a-08d956c7cb06
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 21:43:55.1025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItHTk+614Lsx7exUBP//KelDCQgGHPz6/E7fx4FIagdT6AwbswfXKpDYDCw9y0gT+/jY+enOtfYvhjF82M1qqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4730
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTAzIGF0IDE3OjM2IC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVHVlLCBBdWcgMDMsIDIwMjEgYXQgMDk6MDc6MTFQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMS0wOC0wMyBhdCAxNjozMCAtMDQwMCwg
Si4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBKdWwgMzAsIDIwMjEgYXQgMDI6
NDg6NDFQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBGcmksIDIw
MjEtMDctMzAgYXQgMDk6MjUgLTA0MDAsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4g
PiA+ID4gSSBoYXZlIHNvbWUgZm9sa3MgdW5oYXBweSBhYm91dCBiZWhhdmlvciBjaGFuZ2VzIGFm
dGVyOg0KPiA+ID4gPiA+IDQ3OTIxOTIxOGZiZQ0KPiA+ID4gPiA+IE5GUzoNCj4gPiA+ID4gPiBP
cHRpbWlzZSBhd2F5IHRoZSBjbG9zZS10by1vcGVuIEdFVEFUVFIgd2hlbiB3ZSBoYXZlIE5GU3Y0
DQo+ID4gPiA+ID4gT1BFTg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEJlZm9yZSB0aGlzIGNoYW5n
ZSwgYSBjbGllbnQgaG9sZGluZyBhIFJPIG9wZW4gd291bGQNCj4gPiA+ID4gPiBpbnZhbGlkYXRl
DQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gcGFnZWNhY2hlIHdoZW4gZG9pbmcgYSBzZWNvbmQg
Ulcgb3Blbi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBOb3cgdGhlIGNsaWVudCBkb2Vzbid0IGlu
dmFsaWRhdGUgdGhlIHBhZ2VjYWNoZSwgdGhvdWdoDQo+ID4gPiA+ID4gdGVjaG5pY2FsbHkNCj4g
PiA+ID4gPiBpdCBjb3VsZA0KPiA+ID4gPiA+IGJlY2F1c2Ugd2Ugc2VlIGEgY2hhbmdlYXR0ciB1
cGRhdGUgb24gdGhlIFJXIE9QRU4gcmVzcG9uc2UuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSBm
ZWVsIHRoaXMgaXMgYSBncmV5IGFyZWEgaW4gQ1RPIGlmIHdlJ3JlIGFscmVhZHkgaG9sZGluZyBh
bg0KPiA+ID4gPiA+IG9wZW4uwqANCj4gPiA+ID4gPiBEbyB3ZQ0KPiA+ID4gPiA+IGtub3cgaG93
IHRoZSBjbGllbnQgb3VnaHQgdG8gYmVoYXZlIGluIHRoaXMgY2FzZT/CoCBTaG91bGQgdGhlDQo+
ID4gPiA+ID4gY2xpZW50J3Mgb3Blbg0KPiA+ID4gPiA+IHVwZ3JhZGUgdG8gUlcgaW52YWxpZGF0
ZSB0aGUgcGFnZWNhY2hlPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSXQncyBub3Qg
YSAiZ3JleSBhcmVhIGluIGNsb3NlLXRvLW9wZW4iIGF0IGFsbC4gSXQgaXMgdmVyeSBjdXQNCj4g
PiA+ID4gYW5kDQo+ID4gPiA+IGRyaWVkLg0KPiA+ID4gPiANCj4gPiA+ID4gSWYgeW91IG5lZWQg
dG8gaW52YWxpZGF0ZSB5b3VyIHBhZ2UgY2FjaGUgd2hpbGUgdGhlIGZpbGUgaXMNCj4gPiA+ID4g
b3BlbiwNCj4gPiA+ID4gdGhlbg0KPiA+ID4gPiBieSBkZWZpbml0aW9uIHlvdSBhcmUgaW4gYSBz
aXR1YXRpb24gd2hlcmUgdGhlcmUgaXMgYSB3cml0ZSBieQ0KPiA+ID4gPiBhbm90aGVyDQo+ID4g
PiA+IGNsaWVudCBnb2luZyBvbiB3aGlsZSB5b3UgYXJlIHJlYWRpbmcuIFlvdSdyZSBjbGVhcmx5
IG5vdCBkb2luZw0KPiA+ID4gPiBjbG9zZS0NCj4gPiA+ID4gdG8tb3Blbi4NCj4gPiA+IA0KPiA+
ID4gRG9jdW1lbnRhdGlvbiBpcyByZWFsbHkgdW5jbGVhciBhYm91dCB0aGlzIGNhc2UuwqAgRXZl
cnkNCj4gPiA+IGRlZmluaXRpb24gb2YNCj4gPiA+IGNsb3NlLXRvLW9wZW4gdGhhdCBJJ3ZlIHNl
ZW4gc2F5cyB0aGF0IGl0IHJlcXVpcmVzIGEgY2FjaGUNCj4gPiA+IGNvbnNpc3RlbmN5DQo+ID4g
PiBjaGVjayBvbiBldmVyeSBhcHBsaWNhdGlvbiBvcGVuLsKgIEkndmUgbmV2ZXIgc2VlbiBvbmUg
dGhhdCBzYXlzDQo+ID4gPiAib24NCj4gPiA+IGV2ZXJ5IG9wZW4gdGhhdCBkb2Vzbid0IG92ZXJs
YXAgd2l0aCBhbiBhbHJlYWR5LWV4aXN0aW5nIG9wZW4gb24NCj4gPiA+IHRoYXQNCj4gPiA+IGNs
aWVudCIuDQo+ID4gPiANCj4gPiA+IFRoZXkgKnVzdWFsbHkqIGFsc28gcHJlZmFjZSB0aGF0IGJ5
IHNheWluZyB0aGF0IHRoaXMgaXMgbW90aXZhdGVkDQo+ID4gPiBieQ0KPiA+ID4gdGhlDQo+ID4g
PiB1c2UgY2FzZSB3aGVyZSBvcGVucyBkb24ndCBvdmVybGFwLsKgIEJ1dCBpdCdzIG5ldmVyIG1h
ZGUgY2xlYXINCj4gPiA+IHRoYXQNCj4gPiA+IHRoYXQncyBwYXJ0IG9mIHRoZSBkZWZpbml0aW9u
Lg0KPiA+ID4gDQo+ID4gDQo+ID4gSSdtIG5vdCBmb2xsb3dpbmcgeW91ciBsb2dpYy4NCj4gDQo+
IEl0J3MganVzdCBhIHF1ZXN0aW9uIG9mIHdoYXQgZXZlcnkgc291cmNlIEkgY2FuIGZpbmQgc2F5
cyBjbG9zZS10by0NCj4gb3Blbg0KPiBtZWFucy7CoCBFLmcuLCBORlMgSWxsdXN0cmF0ZWQsIHAu
IDI0OCwgIkNsb3NlLXRvLW9wZW4gY29uc2lzdGVuY3kNCj4gcHJvdmlkZXMgYSBndWFyYW50ZWUg
b2YgY2FjaGUgY29uc2lzdGVuY3kgYXQgdGhlIGxldmVsIG9mIGZpbGUgb3BlbnMNCj4gYW5kDQo+
IGNsb3Nlcy7CoCBXaGVuIGEgZmlsZSBpcyBjbG9zZWQgYnkgYW4gYXBwbGljYXRpb24sIHRoZSBj
bGllbnQgZmx1c2hlcw0KPiBhbnkNCj4gY2FjaGVkIGNoYW5ncyB0byB0aGUgc2VydmVyLsKgIFdo
ZW4gYSBmaWxlIGlzIG9wZW5lZCwgdGhlIGNsaWVudA0KPiBpZ25vcmVzDQo+IGFueSBjYWNoZSB0
aW1lIHJlbWFpbmluZyAoaWYgdGhlIGZpbGUgZGF0YSBhcmUgY2FjaGVkKSBhbmQgbWFrZXMgYW4N
Cj4gZXhwbGljaXQgR0VUQVRUUiBjYWxsIHRvIHRoZSBzZXJ2ZXIgdG8gY2hlY2sgdGhlIGZpbGUg
bW9kaWZpY2F0aW9uDQo+IHRpbWUuIg0KPiANCj4gPiBUaGUgY2xvc2UtdG8tb3BlbiBtb2RlbCBh
c3N1bWVzIHRoYXQgdGhlIGZpbGUgaXMgb25seSBiZWluZw0KPiA+IG1vZGlmaWVkIGJ5DQo+ID4g
b25lIGNsaWVudCBhdCBhIHRpbWUgYW5kIGl0IGFzc3VtZXMgdGhhdCBmaWxlIGNvbnRlbnRzIG1h
eSBiZQ0KPiA+IGNhY2hlZA0KPiA+IHdoaWxlIGFuIGFwcGxpY2F0aW9uIGlzIGhvbGRpbmcgaXQg
b3Blbi4NCj4gPiBUaGUgcG9pbnQgY2hlY2tzIGV4aXN0IGluIG9yZGVyIHRvIGRldGVjdCBpZiB0
aGUgZmlsZSBpcyBiZWluZw0KPiA+IGNoYW5nZWQNCj4gPiB3aGVuIHRoZSBmaWxlIGlzIG5vdCBv
cGVuLg0KPiA+IA0KPiA+IExpbnV4IGRvZXMgbm90IGhhdmUgYSBwZXItYXBwbGljYXRpb24gY2Fj
aGUuIEl0IGhhcyBhIHBhZ2UgY2FjaGUNCj4gPiB0aGF0DQo+ID4gaXMgc2hhcmVkIGFtb25nIGFs
bCBhcHBsaWNhdGlvbnMuIEl0IGlzIGltcG9zc2libGUgZm9yIHR3bw0KPiA+IGFwcGxpY2F0aW9u
cw0KPiA+IHRvIG9wZW4gdGhlIHNhbWUgZmlsZSB1c2luZyBidWZmZXJlZCBJL08sIGFuZCB5ZXQg
c2VlIGRpZmZlcmVudA0KPiA+IGNvbnRlbnRzLg0KPiANCj4gUmlnaHQsIHNvIGJhc2VkIG9uIHRo
ZSBkZXNjcmlwdGlvbnMgbGlrZSB0aGUgb25lIGFib3ZlLCBJIHdvdWxkIGhhdmUNCj4gZXhwZWN0
ZWQgYm90aCBhcHBsaWNhdGlvbnMgdG8gc2VlIG5ldyBkYXRhIGF0IHRoYXQgcG9pbnQuDQoNCldo
eT8gVGhhdCB3b3VsZCBiZSBhIGNsZWFyIHZpb2xhdGlvbiBvZiB0aGUgY2xvc2UtdG8tb3BlbiBy
dWxlIHRoYXQNCm5vYm9keSBlbHNlIGNhbiB3cml0ZSB0byB0aGUgZmlsZSB3aGlsZSBpdCBpcyBv
cGVuLg0KDQo+IA0KPiBNYXliZSB0aGF0J3Mgbm90IHByYWN0aWNhbCB0byBpbXBsZW1lbnQuwqAg
SXQnZCBiZSBuaWNlIGF0IGxlYXN0IGlmDQo+IHRoYXQNCj4gd2FzIGV4cGxpY2l0IGluIHRoZSBk
b2N1bWVudGF0aW9uLg0KPiANCj4gLS1iLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
