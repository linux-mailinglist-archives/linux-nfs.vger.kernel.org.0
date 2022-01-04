Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EAE4841AD
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jan 2022 13:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiADMgR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jan 2022 07:36:17 -0500
Received: from mail-dm3nam07on2097.outbound.protection.outlook.com ([40.107.95.97]:1166
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbiADMgR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jan 2022 07:36:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUnHOWI8w1x+x0gqEdtM80TjXjE8AuRwhgcTUFOPjtjeSWBjTvM2gfzclkO82o057wY747zWPeSjwiv/2rbzNyQDkefoRmXdoBboyaOxOxfBKv5DSdJfQU7qjc63PZVArLXd2vs+7kEbGKPqvTMcbkk9zkZzJbTZgunI+Jzdn/pv3rZsiSES4B3t8YJpwl7yXjUda17XPubqtK41nnw/jJHod6tzsifxe+I/ka2OopUp+8M6U8RuZRt7VWhYLBAydAPhN3n5I1cyKE+imPtp8iFGksXuNzv8vIuuhC5678+8BictObNeCsbEZOgOplyiA7e8QzCLpr1XR6BR7xdnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U6p9db6EX1UVNgctJRV+u84MaiF484Y9FnFRApa0TI=;
 b=VzzI4ipK6UT5SPgnKTGmsl7VI8mKokynr+EJ+O1l5MZXKa2WbDnpGqAc4Awb0B5NMfTzOh+HfPbZt67OHcBAidQ+BfaAghpuxMi9Lcgu7UzFPg4Ll7qloRhWKRs/rtQVZDrEDKULPXwtg8bdt/rvbYpreyU9rE6fqdeM9JAsISW0AnYs1oJA02C48jf6dXZx6BBym8t7vej/CnUPihDjTbC71FKxvQ/+Y3ZxbMH++M7sh/X6LNbHH+AIPw8QmV3VH9mGrjjgrE5Zl43JY5ofgkupYa2eFNZ3kIxCb0cdDHITFtfqk6rJGB1h+0rIWQCAj8eHiZaRpkSQ15pWkSiYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U6p9db6EX1UVNgctJRV+u84MaiF484Y9FnFRApa0TI=;
 b=FT9i8V3zl193fDXNDOPfyDM/gHk+fZVnizhMaSVeeaWr9mptWRbNHkbTpgLeTjIE5syRC/9sQ1H+omWxluEVFlYoR0bjwW9DyXIbWSndvSyDsgI3nF1jc65xNqOmywGvEX6d0fU/iqlGwDvAfFcg0JpnHUL+BmAqtO9VfVHovR0=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 DM5PR13MB1513.namprd13.prod.outlook.com (2603:10b6:3:124::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.6; Tue, 4 Jan 2022 12:36:14 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::15bd:faea:f83a:2874]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::15bd:faea:f83a:2874%4]) with mapi id 15.20.4867.007; Tue, 4 Jan 2022
 12:36:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>,
        "neilb@suse.de" <neilb@suse.de>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "mbenjami@redhat.com" <mbenjami@redhat.com>
Subject: Re: client caching and locks
Thread-Topic: client caching and locks
Thread-Index: AQHWPdqKDxq04E9R4EezGQhAvzMsOqjeMTgAgABM3wCAAF7VgIAF4BMAgJ9AToCAAArJgILGzxlrgAooz4CAAR4sAIAANXEA
Date:   Tue, 4 Jan 2022 12:36:14 +0000
Message-ID: <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
References: <20200608211945.GB30639@fieldses.org>
         <22b841f7a8979f19009c96f31a7be88dd177a47a.camel@hammerspace.com>
         <20200618200905.GA10313@fieldses.org> <20200622135222.GA6075@fieldses.org>
         <20201001214749.GK1496@fieldses.org>
         <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
         <20201006172607.GA32640@fieldses.org>
         <164066831190.25899.16641224253864656420@noble.neil.brown.name>
         <20220103162041.GC21514@fieldses.org>
         <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71a852f1-6e2b-4266-8ff0-08d9cf7ecbf2
x-ms-traffictypediagnostic: DM5PR13MB1513:EE_
x-microsoft-antispam-prvs: <DM5PR13MB15134231EE0F9177F7C4B17FB84A9@DM5PR13MB1513.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lj2bbxX99L8k/OLyX4uW0NitIHyVFZT8M8Z7s7DXB++ByEHz/g0Td4TKkKjk5eHwIIl6UQ6vfEDii0iVuLmZ64pABzCMVqA+i5K5rML5SQTulPDeWqE5YJGaw0uj4bQkjI+Yh0fBrVCt9NMlPMo+B0V8u539Q8FN+1Zfxi3FYzxzMU4agKt8c8wRjv6wmmJsbaDcVmBDH8JmYB5baxstN/vVtltq6NAg1+GaMcJ/IIM+nTQKACw9GmYU1/5LVlO7InfYIwThAw/1QQM9STaGAJt9DqgfKNXiiNjoSrpLub3V6bO3XwXV9m4uyYkWDKcdVB5EeX3Q6Q+brN021LlilZqEaLqCm+lVqYnupVF8an4BUiCdMoW0ItfHsTmPrExXWrsEuIKvNu3Y/j1KfdCQUhXcAdA/ujddUfG7957o729PRI/RLJSp8nP5sEUoDxUT0y866XZesDc4tAN2p9iWElS+tiRtM6qIOwA0lPF08fLaUiy4miBUVxYotKjU9bdeA7izut1YTBkVJeWNidFAGawah4FExO2Y8H/HFbksjvpcbkcs6IWXt9bMKKIil3YNn0BwkWWUqvc85VdYRdlrf2G1JHmWRb8mzncYzn6s5LdRx+s8nhRk7NvCqBCITc1pqONCsgKw8kPoYLV0JpbSV8IsPl94EpOJt9oQN1dk2qd+mShpaCfKmKGIu64s+uG1KrkSQeJAgeicu4LO+KQ/3CTVS+Y4DecK4g5K2OhW8lH8ZIYpZcx1DTX1sn8H9pWS18Ked6e0bIBdxOdcC2bRBt3R7u49Z33AMr87mRmhCUFud2KzOTkUVzQKFlm0t7T5lrNGqSLRbNJDbGCKrqe0qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(136003)(39830400003)(396003)(346002)(6506007)(966005)(6512007)(66556008)(64756008)(66476007)(8676002)(2906002)(66446008)(4326008)(8936002)(86362001)(38070700005)(38100700002)(91956017)(186003)(76116006)(36756003)(122000001)(110136005)(66946007)(2616005)(5660300002)(6486002)(3480700007)(71200400001)(54906003)(508600001)(26005)(316002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjNxRjNIK3doOWt2bjRyclBMRC9rT0ZnWUFlLzAweFVPQ2kvMG9kR1IzSFpX?=
 =?utf-8?B?eEJTQWoyRU1oWEYzTGJmaEViblRLaHVoVDZFTVVqTWM3Vkx4alNlR250d0R2?=
 =?utf-8?B?TUVLOXRWUERGbFhqK0lLTXZaK0ViVTJ5dWNSNzNpbzJSRHdpZ096MWZDRmVN?=
 =?utf-8?B?TWNuNG5LUW1LWHVlQU1YMmJoNlBPWlRMN3RSb1p3WnhpbmhETFFaZVFHQnJi?=
 =?utf-8?B?bE1iMFhZQUJpY05WendLQ3ZsdnVOUkZ1d0ZJMlJDa0xFY1V2YlRTOVBFajVo?=
 =?utf-8?B?V21PZWFqZ3pTdzNDQzZnMUE0ZUZGQVNSUXRGV0hHSUVOc0xpc25xZUY2bWtI?=
 =?utf-8?B?R0JQL0RGQXp3TnVjSTRBNmFGaFFRRGhVMGtmTlZGUEVvNU9ZU0xjcmRvUGJ5?=
 =?utf-8?B?M205cFRZNGs0NWYydHhrMCtGb0pZem9uRWowS1RvbVB1cnNFMjhYWFZJZzdT?=
 =?utf-8?B?Wm0xWjNUY3BPOHRrREFWUUVKOTJhTEJmcEYvTXFIREZWQjZKZ2VxQzRRWXNz?=
 =?utf-8?B?OEFsQS9FM2hDSkFpZHlaUkJXWk9HaWJheXpGZ09kVXNtZktncTBHdXVxT2ti?=
 =?utf-8?B?akJrRHBFdlR4MjJTSHlkN0dUZkNxOWxpMy9LREppZGlCUDNpSlY1NVh6cldQ?=
 =?utf-8?B?aEdNelkvcmVTQThhM0E4dm1IQlNtMHYzaDhuQUdsTnd0NEpRTC9YYWYyK2Ri?=
 =?utf-8?B?YmVrM1dRYk5oMFYxUEJiMXFlbmI5Ry9KeEk1WG9ONDNkeU56bnpiaGtIVGIx?=
 =?utf-8?B?QzNFTUJ3ZGRFNFVsVU5HTWxtYUt5SmYrUTVLWGxORktjWUc0VjRka1czZXdZ?=
 =?utf-8?B?Slh0M1F4NmhwbzUrUkRBU1hpQWhHMWVaem05ZFNQQk1EUmU4d2VqRTg0RFdJ?=
 =?utf-8?B?L28yeDlWcTAveGE3NmM4TjcreCtubVVXeFhyOUs2NzRVU1h0ckQ2ckp0MHYz?=
 =?utf-8?B?MU1DWGF6Z25ZU2gvRTdMU1pCa1hkZWJSME1HSk5LWnliUmNxTTNuTWpoallU?=
 =?utf-8?B?K3JwSDhESXU0TFZ1Z2w0V2xqeXo4Y0RlU0VxeEdIRXBHZjJodHpmMU1tb3E5?=
 =?utf-8?B?dnRkV0JmdFhoRGRJckU5cjNVOG1aOGZiZ0tzbEZhM0JrVXNhWVV3T2NwWXdl?=
 =?utf-8?B?dW9mT2xBT1Z5amdTSElCamM5UzFuRU5HYkR2RVJEdlkrOXJyKzZLU1VjazBo?=
 =?utf-8?B?Mk1KcUNXSi9sZG1FMHRzMFFXTEprMXo1TkFhVUlFTzdXWUZ6R29xb1dibEVB?=
 =?utf-8?B?L1lGTEJkQ2xRd0gyTUM2QnlHaDV5dW1yQi9UWTFPK3A1MkpVVUpOZkgvYjRq?=
 =?utf-8?B?U3ZkeXhMVUZsVUQyWGUyQUg0Sk4zWnVPL2hjRzQ0eVJDNldRNXh2NUdML1Fv?=
 =?utf-8?B?SVVWWGpVK01JOHNQRTJUMFRoanYvdXYyeG8zSVk5YmdxSjNHbFpnTTEvQ2lD?=
 =?utf-8?B?NDFYN0dmZktzamVKWk5vYnhham9HdnhDaFRyREJsT3M5ek00bzZXcmJrU0lW?=
 =?utf-8?B?cFFhMzhEYzNTTzJwTW1xK0tUZUx0U0JUUkhPMWtxbEl2aTY4bGlnOElpNEJa?=
 =?utf-8?B?WWE5bHErYVBOdlFvNWZMdittRlJxZHJnak1qNnhDS1BKQ2RaM3l1WDBRR3JF?=
 =?utf-8?B?TVpnTlplS2ZYV010cGhBbXBMcGhPSjRMZ1BQemJ3bEQyMjBZTEVmQjJoNklL?=
 =?utf-8?B?ek5SZUlmS2tpQjdISUYxR0IyNytRdFp4Ym9xYTNPOVdTY3I4dWR6dzNLVEhw?=
 =?utf-8?B?UmsvR0o3ajhob2Nxa2VQVE9PRWptVS9QM1g2Um5tVVpReWtoSUJ4OE84SzN5?=
 =?utf-8?B?OHZlSldKbWUzTTJOWmwrQ2g2aXdSa01QL1VNT1N5REhEaGt3RnRpMFNRd0FC?=
 =?utf-8?B?UGRYZXRHM2tzRmdESFFxbnVzanlJcnJRZzFoUnN0SHY1TnhWdHhFTDFOV3V2?=
 =?utf-8?B?ejNrWEhqTkEwNVVBdEZHTHEyeDdsZExoWjM5cmE3RUE0MHZyMExPZDB2Y1Vo?=
 =?utf-8?B?WmFDQmpYRjZ1ZjFFUlU4enZxU0lpbllOV3UySVRKNXlvdmRCZzdQRXc0UGNr?=
 =?utf-8?B?aXAzcS95VFVKeGQ4dlFXTzRGN0UyTVZoNmptaHJiTTFJREZhdWg3OWRoMmdO?=
 =?utf-8?B?VUYyWnZ0dUhaRXdSTUhZejE5alpyMHdpWEREdEZBUzErU29OSVRxb29rVGdz?=
 =?utf-8?Q?jdazfcPgcjwGoG2fM/cnlSU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <156EC78A0AEB3F4087904A3C90FDB890@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a852f1-6e2b-4266-8ff0-08d9cf7ecbf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 12:36:14.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E01VX4ZqvelDNa784DD9ZcEhBm903n24Z81E26Pf4+wVjBKVt/hlA0H11oJ24h6JkAMHPu0DCQ70z7oHmonFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1513
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTA0IGF0IDA5OjI0ICswMDAwLCBpbm9ndWNoaS55dWtpQGZ1aml0c3Uu
Y29tIHdyb3RlOg0KPiBIaSBOZWlsIGFuZCBCcnVjZSwNCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91
ciBjb21tZW50cy4NCj4gTm93IEkgaGF2ZSB1bmRlcnN0b29kIHRoYXQgdGhpcyBiZWhhdmlvciBp
cyBieSBkZXNpZ24uDQo+IA0KPiA+ID4gV2l0aCBORlN2NCB0aGVyZSBpcyBubyBhdG9taWNpdHkg
Z3VhcmFudGVlcyByZWxhdGluZyB0byB3cml0ZXMNCj4gPiA+IGFuZA0KPiA+ID4gY2hhbmdlaWQu
DQo+ID4gPiBUaGVyZSBpcyBwcm92aXNpb24gZm9yIGF0b21pY2l0eSBhcm91bmQgZGlyZWN0b3J5
IG9wZXJhdGlvbnMsIGJ1dA0KPiA+ID4gbm90DQo+ID4gPiBhcm91bmQgZGF0YSBvcGVyYXRpb25z
Lg0KPiANCj4gU28gSSBmZWVsIGxpa2UgY2xpZW50cyBjYW5ub3QgYWx3YXlzIHRydXN0IGNoYW5n
ZWlkIGluIE5GU3Y0LiANCj4gU2hvdWxkIGl0IGJlIGRlc2NyaWJlZCBpbiB0aGUgc3BlYz8NCj4g
DQo+IEZvciBleGFtcGxlLCB0aGUgZm9sbG93aW5nIHNlY3Rpb24gcmVmZXJzIGFib3V0IHRoZSB1
c2FnZSBvZg0KPiBjaGFuZ2VpZDoNCj4gaHR0cHM6Ly9kYXRhdHJhY2tlci5pZXRmLm9yZy9kb2Mv
aHRtbC9kcmFmdC1kbm92ZWNrLW5mc3Y0LXJmYzU2NjFiaXMjc2VjdGlvbi0xNC4zLjENCj4gDQo+
IEl0IHNheXMgY2xpZW50cyB1c2UgY2hhbmdlIGF0dHJpYnV0ZSAiIHRvIGVuc3VyZSB0aGF0IHRo
ZSBkYXRhIGZvcg0KPiB0aGUgT1BFTmVkIGZpbGUgaXMgc3RpbGwgDQo+IGNvcnJlY3RseSByZWZs
ZWN0ZWQgaW4gdGhlIGNsaWVudCdzIGNhY2hlLiIgQnV0IGluIGZhY3QsIGl0IGNvdWxkIGJlDQo+
IHdyb25nLg0KPiANCj4gWXVraSBJbm9ndWNoaQ0KDQpUaGUgZXhpc3RlbmNlIG9mIGJ1Z2d5IHNl
cnZlcnMgaXMgbm90IGEgcHJvYmxlbSBmb3IgdGhlIGNsaWVudCB0byBkZWFsDQp3aXRoLiBJdCdz
IGEgcHJvYmxlbSBmb3IgdGhlIHNlcnZlciB2ZW5kb3JzIHRvIGZpeC4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
