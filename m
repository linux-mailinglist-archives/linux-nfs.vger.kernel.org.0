Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D0A3F1B65
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Aug 2021 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhHSOPS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Aug 2021 10:15:18 -0400
Received: from mail-bn8nam11on2112.outbound.protection.outlook.com ([40.107.236.112]:46561
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235352AbhHSOPS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Aug 2021 10:15:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXhcPqYo2VHTp/UN6Wt7/Ak+9TCLdPotpX8/YYepXkYF42aUJzVr1Eqp/prd6SPjrw4EFeYJysKatetpjsnewgW0paMQFPx0O9Ht4ph8Rgr2WS57tHLrI+9r8kRbi6D/h95LbFGcxpH3TheMiwLaTdpj/tu39G/TL+7uhNCqrfbQ0WJtfGNQmE1NkC/9AH43CSBXOssKgwwVSO8jAzWlbzFfpF5FWhXkgzgV6RJWWjCrdsDuAq9JDLFNXuKwsp0vwdFUnywFv8BO87lBSmUYgG/IYIWxFx66CgsskC4RF5kY2B5rbznoEcG92KSHi9RdDeUdcq9yrlRbok33M3DVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/thwOijVd/jw4/TGPf1I5kC1P3bAgqmAXjMisqCcmM=;
 b=BAqEJ3hYDeUbP07WbOX3ipKerJ7Llm+IOd5ljnX+BaN0U5gLdSrod86jxWKINHWn58OC3IwZWmorFKCbzrPb9hx8gld02AXNLzz096Ewq/3oVQ2mJJDDmfCjSPBMNnv9qRnIlneKON7x8iI9zTEod6DUNVF1gcud1CAX7WMr95lh4FR3q2LCpP9PSthPQhRj0naV7yOWyhJGRPSPWfDETiqda8/DU6Adp7KhQDT83wFGgFDYKP1Un1X3V6Hm7pdGYEJf2cBHUG5SynDwC7ooTsg/6gIiOUye+UBAjSmDwexX39IPcaP1XBGal8JE+DJ3iclE/3cnEJoVitK0RFhgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/thwOijVd/jw4/TGPf1I5kC1P3bAgqmAXjMisqCcmM=;
 b=NADl4MBJ4Ohe5ubWF/WDC08oQ+ZP3aCDzzdOZhZPRkFEOcsSb1q1q4Cc7qvx0qRw/eWPI80Se+1bGYjPsJi5XdwAQhaZNYdWa5BGQhuZPPePqKuey1ocLIxkF9OL4I33vz171lzqdtUA09/YmcvGxydnY0l7dQp01ZBTU28868o=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3464.namprd13.prod.outlook.com (2603:10b6:610:2f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.14; Thu, 19 Aug
 2021 14:14:38 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%7]) with mapi id 15.20.4457.006; Thu, 19 Aug 2021
 14:14:38 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Topic: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Index: AQHXlPXbrsxTI02VrkeJ/wH346Zxu6t6ysMAgAAEEICAABBWgA==
Date:   Thu, 19 Aug 2021 14:14:38 +0000
Message-ID: <69e8d4c3ae302ba51a92e20c927006ad33b2486c.camel@hammerspace.com>
References: <162937592206.2298.13447589794033256951.stgit@klimt.1015granger.net>
         <ed3fbd005a9a2e3a6217085ebe05e80cd78766ba.camel@hammerspace.com>
         <6D4FFB37-B5CB-410B-A3C9-AAC92F611520@oracle.com>
In-Reply-To: <6D4FFB37-B5CB-410B-A3C9-AAC92F611520@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ca2face-d294-4112-a261-08d9631bae41
x-ms-traffictypediagnostic: CH2PR13MB3464:
x-microsoft-antispam-prvs: <CH2PR13MB34642DE7EC0FFC801FAC2C67B8C09@CH2PR13MB3464.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rAAv9BbeYDg55+tJtj25VvzmOtEntdbh6WNJju3U2UWPhX2P6t/OMIgQSSmYw/MPPOmpTLwbxL1bVw4ZZBdE3/SMwrBvTaj8vOpHOgIh5fCS7Nv8zP/ptXz6P5dN1sPWDKhY2vELIjznfTzEi3ZkqtaSPCbTsTzELx4FYtdxGor2JlEjmDqgBbb6VbNa85o3FVqCkEfdYUn0QUYzZDBKfZk7PXxLS+MDIJ5RqlckA0c6eiYPzjhUvB55TiUl7h+NkW2Gh7++yIHyX1hYDBCZPM5EwW+qVipenmz7m0Z95/UvrM/cHXi5RZroeeVBUmwAQoA5z2w7GfdwtTWdurnDzEsITJsljO6rXk9H2CPS4F5wzRSHc1OtHq2wffrcIcgG/APKoerbSE7MiCYzKaYvDOrmJiPhQkkhLJD16GS36zvAnUzGe2RE7Z4GhLOtsnxOSHlAiqL5DaZbCQMep4fsWBxuf+5wq0RPbd0dEAMRCdwgjUSPc26Lj81+lRrRAFO6a/w6DeeSteHZ7ZNRovoZUhwGOxkRovr2FWTZtVDQKiQyaie8N8e64+ouhTuL+8vI/GiATFq7RloWZ7srXdbgc9kgd1FPS8qHbrpXW8RBDCapvjAIQJHxA3ZEzWDv6VMNa30GENX3bDUGoLsGnlHzxyotPa1SA14VHyCldpLZJgEWWVNvjY7q41rPOQOY6bhcB6VdDeZWFX+dsxg7ADbaT+73SW4e55oNosidW8GryRs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(366004)(346002)(376002)(136003)(6486002)(66556008)(66476007)(6512007)(66446008)(66946007)(122000001)(4326008)(64756008)(2906002)(2616005)(76116006)(5660300002)(478600001)(86362001)(53546011)(6506007)(83380400001)(26005)(38100700002)(8676002)(38070700005)(71200400001)(8936002)(6916009)(186003)(316002)(36756003)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVNhRW04Qk1Ia2YraVVEYUYweU5hZ0VYeThXbVVHWVVJUlNEcHJOSGUvZlpZ?=
 =?utf-8?B?TkFsbHFFd3lwTzVjUXVHZjFzaFh4WFBZUURpZ1paZk1zeTFTUkd3Wk5UNWlQ?=
 =?utf-8?B?LzhVNzJQeTl6THREYkMvSFVJdC8wVmtKUG11ckxiMG9rMmJkbERJaUpoT3lD?=
 =?utf-8?B?RUZwbDREbGhoWmdWS29ZUTNoMitsRlY4RjhTU3Vva0RBRW5HamNPWE1uVk9L?=
 =?utf-8?B?bGVIU3BWZzJLL3RON2tEYVdaU2F1OTU0T0lkYmxSeWVoWWRoSmRUeGZORTRy?=
 =?utf-8?B?eHdaZk85akVQMnhGUkR2RjU2UnZJd1dFMU5xR1Fia1BtVlFXbjN5TkkrNlFz?=
 =?utf-8?B?RDRtYWVSSWpYSTl2MmRNYTQzNm43dDFSSzB1dFFMZ0FZalBya2JwQUhVV2ly?=
 =?utf-8?B?cEFWRFE1dzJnbkYzWlRIOEN5ME42blg0WjR2WXQ1Nm9peFJKR1AzMGx5MitK?=
 =?utf-8?B?MlBCMThBVFc3Qk54dHUvcjRjOXppSTIzNG9oMngvd3JXOUlGUFh2Y1ZsN2hF?=
 =?utf-8?B?QnBMMmt0VkNJOXFMZGtlTjR1UElnQXhWRjVIN243Y3BMOTBqc21jY1pnbE1q?=
 =?utf-8?B?VnN3UkVMRnJZTWM5dVJpN3EvVENEbnVGeEw5dEora1cxb284M1lMVk9TblZ2?=
 =?utf-8?B?djdHUEUrN0cxQUlnZXNYTDFuMThuZmc4MzIyci9UU0M1TmF5RGplcW9JRlFO?=
 =?utf-8?B?dS9lb0IxRHZGamFqSTIxRXgwU1JUTDE4LzRYdzlHV2hxTjdYN0tXS3gvbTFI?=
 =?utf-8?B?N0tYOGRob0l6SlBPVWp6NHQzcTNMZktqZTNWOXZYb1BKVG1JS0pteWROQ3ZM?=
 =?utf-8?B?RVBqZGRrdEsrTUZHdHhPVWNnYjhnUXIzZjBZZGVldzlua1FlcnJTWDRpMVJr?=
 =?utf-8?B?b0d0cEs0MUtkMUR2UnUwaDRmbGQvZnNGZmVYcDZnRVR2NDFLZXdwdmRobW9Q?=
 =?utf-8?B?VDVVcmQzNG9DcXBpRUYzbnJRbGRRdncxMysvRmNqOStRVHVuL1JmQU1tMmEx?=
 =?utf-8?B?S24xNlVOUkJQckFqMXV2NlY3NUxaUWtCM1BWUjZWalBTY2xUWGkxZnEwbTlm?=
 =?utf-8?B?TEZQQTF2TFFYcFVTOXBpejNBUHRoSzd5cXV5WU5HNWR6eW5YM0J0SW9JL1RR?=
 =?utf-8?B?TGNTM0VPN0ZkWEVpczVZRmN4aXkrMDA5eTJKUWpMbzdtREZBODJ6RWk0N1pU?=
 =?utf-8?B?WURuOTJyYzRoT3RCdUc0QXoyd1l5Z0NoOFpoNVhHWkJuS1dvN3Z6VHphYVN1?=
 =?utf-8?B?aGdrY0wxeTNWQVJ2MHRaa2lQTVBmZ3ByaW1EczdJUkVPT0pkMndGQmtjOWNS?=
 =?utf-8?B?NXgxTlR1VkJ5eTU5RXVBSTlTTGJwTmV5cktuL3J6WHRPWVhTYjFMVzBwT2cz?=
 =?utf-8?B?WE54Rm83Zkx3RWdoQ1lVa1R4d2FadFVIRTJueHFlRThuV2kxcDVVTTg4NHJM?=
 =?utf-8?B?UnJtdlRYMmI0eWlHNXNIWWZWZWRnbnFTTEFxbzhXY1NUS1JvaTJHWG9qNEVk?=
 =?utf-8?B?bXBmQnNLejh0UVk5V0ppaUV1dUhrTmIyUjBtbktEN09NYzI1TFFBQU04bkwy?=
 =?utf-8?B?MUw2eDN3NjljNUIvR0FIaUg3NVZOdlFxNmtyRkdqdHZ3Und5RDRNWUZrVHBt?=
 =?utf-8?B?RmFjb2hDVXM0R2JjVFA3S3R3d3p4Zjd6ZTRHaWIzZC9mQWZhUkRKNkVZb2Vw?=
 =?utf-8?B?N3NKSmFqSVROd2dmMzBwdXpwb3djK0srQ0lBM0paM1dYNnRXcGplNjQzYmkw?=
 =?utf-8?Q?/LOHL+dfyi+jjanSEbFkLHjgd5zm6AEe4KH6bpc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <683B5CDB057D3A4FAF948DA71FDDAB50@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca2face-d294-4112-a261-08d9631bae41
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 14:14:38.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xGVsi/fwwbzl0hminr7i392YJOm6kYBw7SMgiwlN19uaFRHcAdpk0HfxHIgXGq34wwuBc1f0DQIsHQodSeTbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3464
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTE5IGF0IDEzOjE2ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBBdWcgMTksIDIwMjEsIGF0IDk6MDEgQU0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1
LCAyMDIxLTA4LTE5IGF0IDA4OjI5IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+IFdp
dGggTkZTdjQuMSsgb24gUkRNQSwgYmFja2NoYW5uZWwgcmVjb3ZlcnkgYXBwZWFycyBub3QgdG8g
d29yay4NCj4gPiA+IA0KPiA+ID4geHBydF9zZXR1cF94eHhfYmMoKSBpcyBpbnZva2VkIGJ5IHRo
ZSBjbGllbnQncyBmaXJzdA0KPiA+ID4gQ1JFQVRFX1NFU1NJT04NCj4gPiA+IG9wZXJhdGlvbiwg
YW5kIGl0IGFsd2F5cyBtYXJrcyB0aGUgcnBjX2NsbnQncyB0cmFuc3BvcnQgYXMNCj4gPiA+IGNv
bm5lY3RlZC4NCj4gPiA+IA0KPiA+ID4gT24gYSBzdWJzZXF1ZW50IENSRUFURV9TRVNTSU9OLCBp
ZiBycGNfY3JlYXRlKCkgaXMgY2FsbGVkIGFuZA0KPiA+ID4geHB0X2JjX3hwcnQgaXMgcG9wdWxh
dGVkLCBpdCBtaWdodCBub3QgYmUgY29ubmVjdGVkIChmb3INCj4gPiA+IGluc3RhbmNlLA0KPiA+
ID4gaWYgYSBiYWNrY2hhbm5lbCBmYXVsdCBoYXMgb2NjdXJyZWQpLiBFbnN1cmUgdGhhdCBjb2Rl
IHBhdGgNCj4gPiA+IHJldHVybnMNCj4gPiA+IGEgY29ubmVjdGVkIHhwcnQgYWxzby4NCj4gPiA+
IA0KPiA+ID4gUmVwb3J0ZWQtYnk6IFRpbW8gUm90aGVucGllbGVyIDx0aW1vQHJvdGhlbnBpZWxl
ci5vcmc+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3Jh
Y2xlLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBuZXQvc3VucnBjL2NsbnQuYyB8wqDCoMKgIDEg
Kw0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiA+IA0KPiA+ID4g
ZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvY2xudC5jIGIvbmV0L3N1bnJwYy9jbG50LmMNCj4gPiA+
IGluZGV4IDhiNGRlNzBlOGVhZC4uNTcwNDgwYTY0OWEzIDEwMDY0NA0KPiA+ID4gLS0tIGEvbmV0
L3N1bnJwYy9jbG50LmMNCj4gPiA+ICsrKyBiL25ldC9zdW5ycGMvY2xudC5jDQo+ID4gPiBAQCAt
NTM1LDYgKzUzNSw3IEBAIHN0cnVjdCBycGNfY2xudCAqcnBjX2NyZWF0ZShzdHJ1Y3QNCj4gPiA+
IHJwY19jcmVhdGVfYXJncyAqYXJncykNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB4cHJ0ID0gYXJncy0+YmNfeHBydC0+eHB0X2JjX3hwcnQ7DQo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHhwcnQpIHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeHBydF9nZXQoeHBydCk7DQo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeHBydF9zZXRfY29ubmVj
dGVkKHhwcnQpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gcnBjX2NyZWF0ZV94cHJ0KGFyZ3MsIHhwcnQpOw0KPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiA+IMKgwqDCoMKgwqDCoMKgIH0NCj4gPiA+
IA0KPiA+ID4gDQo+ID4gDQo+ID4gTm8uIFRoaXMgaXMgd3JvbmcuIElmIHRoZSBjb25uZWN0aW9u
IGdvdCBkaXNjb25uZWN0ZWQsIHRoZW4gdGhlDQo+ID4gY2xpZW50DQo+ID4gbmVlZHMgdG8gcmVj
b25uZWN0IGFuZCBidWlsZCBhIG5ldyBjb25uZWN0aW9uIGFsdG9nZXRoZXIuIFdlIGNhbid0DQo+
ID4ganVzdA0KPiA+IG1ha2UgcHJldGVuZCB0aGF0IHRoZSBvbGQgY29ubmVjdGlvbiBzdGlsbCBl
eGlzdHMuDQo+IA0KPiBUaGUgcGF0Y2ggZGVzY3JpcHRpb24gaXMgbm90IGNsZWFyOiB0aGUgY2xp
ZW50IGhhcyBub3QgZGlzY29ubmVjdGVkLg0KPiBUaGUgZm9yd2FyZCBjaGFubmVsIGlzIGZ1bmN0
aW9uaW5nIHByb3Blcmx5LCBhbmQgdGhlIHNlcnZlciBoYXMgc2V0DQo+IFNFUTRfU1RBVFVTX0JB
Q0tDSEFOTkVMX0ZBVUxULg0KPiANCj4gVG8gcmVjb3ZlciwgdGhlIGNsaWVudCBzZW5kcyBhIERF
U1RST1lfU0VTU0lPTiAvIENSRUFURV9TRVNTSU9OIHBhaXINCj4gb24gdGhlIGV4aXN0aW5nIGNv
bm5lY3Rpb24uIE9uIHRoZSBzZXJ2ZXIsIHNldHVwX2NhbGxiYWNrX2NsaWVudCgpDQo+IGludm9r
ZXMgcnBjX2NyZWF0ZSgpIGFnYWluIC0tIGl0J3MgdGhpcyBzdGVwIHRoYXQgaXMgZmFpbGluZyBk
dXJpbmcNCj4gdGhlIHNlY29uZCBDUkVBVEVfU0VTU0lPTiBvbiBhIGNvbm5lY3Rpb24gYmVjYXVz
ZSB0aGUgb2xkIHhwcnQNCj4gaXMgcmV0dXJuZWQgYnV0IGl0J3Mgc3RpbGwgbWFya2VkIGRpc2Nv
bm5lY3RlZC4NCj4gDQoNCkhvdyBpcyB0aGF0IGhhcHBlbmluZz8gQXMgZmFyIGFzIEkgY2FuIHRl
bGwsIHRoZSBvbmx5IHRoaW5nIHRoYXQgY2FuDQpjYXVzZSB0aGUgYmFja2NoYW5uZWwgdG8gYmUg
bWFya2VkIGFzIGNsb3NlZCBpcyBhIGNhbGwgdG8NCnN2Y19kZWxldGVfeHBydCgpLCB3aGljaCBl
eHBsaWNpdGx5IGNhbGxzIHhwcnQtPnhwdF9iY194cHJ0LT5vcHMtDQo+Y2xvc2UoeHBydC0+eHB0
X2JjX3hwcnQpLg0KDQpUaGUgc2VydmVyIHNob3VsZG4ndCBiZSByZXVzaW5nIGFueXRoaW5nIGZy
b20gdGhhdCBzdmNfeHBydCBhZnRlciB0aGF0Lg0KDQo+IEFuIGFsdGVybmF0aXZlIHdvdWxkIGJl
IHRvIGVuc3VyZSB0aGF0IHNldHVwX2NhbGxiYWNrX2NsaWVudCgpDQo+IGFsd2F5cyBwdXRzIHhw
dF9iY194cHJ0IGJlZm9yZSBpdCBpbnZva2VzIHJwY19jcmVhdGUoKS4gQnV0IGl0DQo+IGxvb2tl
ZCB0byBtZSBsaWtlIHJwY19jcmVhdGUoKSBhbHJlYWR5IGhhcyBhIGJ1bmNoIG9mIGxvZ2ljIHRv
DQo+IGRlYWwgd2l0aCBhbiBleGlzdGluZyB4cHRfYmNfeHBydC4NCj4gDQo+IA0KDQpUaGUgY29u
bmVjdGlvbiBzdGF0dXMgaXMgbWFuYWdlZCBieSB0aGUgdHJhbnNwb3J0IGxheWVyLCBub3QgdGhl
IFJQQw0KY2xpZW50IGxheWVyLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNs
aWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbQ0KDQoNCg==
