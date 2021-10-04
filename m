Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C754204F7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 04:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhJDCkr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 3 Oct 2021 22:40:47 -0400
Received: from mail-dm6nam12on2102.outbound.protection.outlook.com ([40.107.243.102]:64385
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230295AbhJDCkr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 3 Oct 2021 22:40:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKwiXu5XqASEh9gA2yLRg1M5huryAzV+yml+I53dxbwkRzSXRns++aL9qEq7ok/7OtTXINydnCLHm8ltCnz1Ue0vLHLeMGMTJmczwLbfzFPeumF0UZFYSYUT3dOtUmh5EF+I8v9v22tB7R1WdiliWyuCPhvnVRk/kaMvoGAQGl6lhz1mXgJffr1u1hS4/1ftFXzyV288PafpOOoX2imoyjfntd7N/PDpthB4R9SXgcZ9gGD6566tVl7Mn4yONxBu59SAJzGhWfTXgwC6DvlEjtmIwM5u7V9zgJZPe0v5JLjIr2fZJrFb+wofpPbtRAP3E0EnDJM4PBvBnUNnM88EqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDj93w+3t3E9+ZWrf74ukCQRWzX08iCxHIPEcFkrvOY=;
 b=VETngmJhzN7XeekvFi2XvyFoo4qscOUv57dxRUbYCR/tLU6LUAC5H7b9QCebtAyWEczBn4WIqpjwpl+025D3UOqq8PYXLZOXZtKkOAQhpY8eiPoao18lLczVSGkII1cO7NCpRIWeaUVOSS58f36PTdDrl7PQJ7ZNm5r6HNV6TmLJ+X88WL4A8297j3s4nSmmcJCES2zlN0yaHUPxP8fVGlLe0AeGJQaDFwYkdKTq+YlFGyhAEpxJQFdf+FBWYa9bUKN5mdgcwGMtgiHFiPgHxGRT8zrRjGGFAWA2BMbXbudXw4xJagZbr7Zj8Pubp8uuvAmSNKA07ERztN8FUua8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDj93w+3t3E9+ZWrf74ukCQRWzX08iCxHIPEcFkrvOY=;
 b=LjLt43RmkOzBCCr7ZgyKTQ7BrTPg2deKOpITHKFrnHNkVGR5Wd7TZ38Upc0QyJsXtX4iKScSNJR68xEroNUtYNP79wxG4IqVI9r4cyoB59lqMa76mOf+fPgrMGFrqT9zIUqbzShtSGHWTzM54wFqcIJA3VFmVhSQlDVYjzSfFUQ=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4650.namprd13.prod.outlook.com (2603:10b6:610:c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.11; Mon, 4 Oct
 2021 02:38:56 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%6]) with mapi id 15.20.4587.016; Mon, 4 Oct 2021
 02:38:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: fix minor issues with automount expiry.
Thread-Topic: [PATCH] NFS: fix minor issues with automount expiry.
Thread-Index: AQHXgz1QwTMxOir8S0GqJDHUdruHjqvCi3iA
Date:   Mon, 4 Oct 2021 02:38:56 +0000
Message-ID: <c5d29af93a55854b831d519b01c8f3e29e62fb50.camel@hammerspace.com>
References: <162742773175.21659.17666555162574585184@noble.neil.brown.name>
In-Reply-To: <162742773175.21659.17666555162574585184@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ffbd70-1425-4799-d365-08d986e01ce9
x-ms-traffictypediagnostic: CH0PR13MB4650:
x-microsoft-antispam-prvs: <CH0PR13MB465089FADBD1ED7FD71924CBB8AE9@CH0PR13MB4650.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jOcwAcx5BVsRSioniJiXhaVwz2hCTLmheUVukvgzR1wfbSFr/iWxs/0FQ0WiOX0wcUlnPi4QvuMGEKdEcE89yIP3eu4+oFdgeXpjx+Vuy/2I2CtLatr8kDtSiGgYqPXwVdQdFtfAOgu+Yt3AtjXr2QXtgHaJRP0w0Sp+DPtAJ3TqlySQEb6pPGqxz0xUdpEp7A4vDE9BMQpsqs/TLUae1fXWd65UaH9B7+h8L0fEHdaJQp9PeiSNt6FdcwkwkdY+I+Bcm7kvOkRysTTOiXGx1rzwu/kU+eAXpO3I9JTT79jb0lR4S9T0dsvkiQNcOhj4mV0p35v8DOOejC/2+hQPcbWUB4p4lyTjWD4UKIbH6LSmnuI9TS1UfS8LsRIBYMPAhA5bwtB20AHOYxIwhskMc5GrNX0tEroU+RfrUhJmuVGP4jo3ofldpUYxiQNIf2Xaxf1XUESk9lxLgcz7jbKwAt0qIL4r+kN7Mg7LCZ+1mDVrxFqBbtvTXjYxcH9jzZO6Th02lAnTeOmt/zVr5Gbt0b1p+2eY56KDr8ieH9CgNViKeSdIm6Xo1URMttKGM3lt1EeZPzV2dZ4ZdrzrWNVUlLoe2m14GSeQMIw3f7KtrmI6S6WLMjoILOTo4QalgKSzOnlKlriGYp+1y3Ig3eSVskSdpY/SzBMeybmEY7gHmcdmi37nn1cu316JrXRWiwFWpBOj0aVoy+Rwbj4H2YA9Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(366004)(376002)(396003)(346002)(2616005)(186003)(110136005)(316002)(6506007)(86362001)(5660300002)(83380400001)(66446008)(64756008)(122000001)(66946007)(6486002)(66476007)(6512007)(508600001)(66556008)(38070700005)(8676002)(8936002)(76116006)(36756003)(71200400001)(2906002)(26005)(4326008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0VtQnZsckJVSjRHZEs0RVQxRVFtcDRsbFlyRjQwUWcyV3Q1Y3BSVCswTjQ4?=
 =?utf-8?B?Z3EwMmxDTE82OTBPMzRHNW9hNW44YXJuN0hxM3NtUXdCc05xeldGTzZpcmtM?=
 =?utf-8?B?MzByeTFZcFJWNUtFUlpEeFkwWHEvQlRRY3VLaHlVNloyQlVWWEdpKzZnR1VJ?=
 =?utf-8?B?VlZjOEhKSDFwQXh2OWhkVnZyOUdwZjdUSWJLOHpJaVNycUw5UGQxcVhFZjhj?=
 =?utf-8?B?WE9Ra3JBbFRhcnBlcWJ0Sy81Q09QY09YbFpIazg5Y09yelhZUytsSmNEUXVG?=
 =?utf-8?B?RGhCQml6ZWpEUmpaNXdyc29tRVAxS1Nza1RwUnF6RnRmODQvOGxFNmNucWp1?=
 =?utf-8?B?ZnVOWnU1R3dIaHJ0cm9mMTk1WU00Z0FQM0VVdWJEanBIMUxyTlJERkNQZnJ1?=
 =?utf-8?B?VGJFWThTVkpLc3hnM2N5WnVCY3NWUklPZDZRNUVqcEF6cVg2ZDkycUN2VlVu?=
 =?utf-8?B?b3VlSnRhVFJCS3Jwb2YrU1RIbG5GbHZIaS82aGlGb0JiQ3J0RldmMzhMMGQr?=
 =?utf-8?B?L2lBWGgzNEtDR21OQjlSRi80Y0h3VzcyK1VSSzk5R1J2UVZYZHJMOStsWThm?=
 =?utf-8?B?OEJMOXBjekJEVEVmRDJ6cmZCaG5CSlZ2VzdWd3o0Ulp1V0ZqU21WdWNxZFEx?=
 =?utf-8?B?UDFXeHJ3eCtlWlRFd1FnZktLcHE3Y1pQQWo2QUU4RDRDQ2pkengxQjVCY0d4?=
 =?utf-8?B?WEtJdEVENXJuRjVKTzM4U2QwdTJxUUJ3N05GaWhWY1YzemhHeGJibTJmUjR2?=
 =?utf-8?B?YXZ2cEFrd2R2dHJXM0hHZUwxOWlqcWdUME9hUVROTWY1WXE4Vmh6SE5VbWh4?=
 =?utf-8?B?alNGZm5paXZYQnJqRU5ka25Nd0JSeVhzZ1ZRQlZNWkx3T1d4N1F5d1orYjVp?=
 =?utf-8?B?c25Ia0NIWnprK1MzRjJOUFdYamU4bHNocUFhem1HdW5hYnRmeFVEWXFVT1NU?=
 =?utf-8?B?QWc5WGQxMEpwcUJiMUhDekNSYXZJR1ozV3NlZ0tLcExPakhEaXhrWU8ydnMz?=
 =?utf-8?B?QlVLU3E1N1NYTkMrT0lLRitqZ29kcEliTTV4M2EzaVNac3IwRlI3OWhGM1hI?=
 =?utf-8?B?MHBiKzNYODdQOUIvbHQ1b3VNcllrYmJaMjdWSGdRTUgzUUM3Yy82T1FxdVhR?=
 =?utf-8?B?T0FMYlZqTXNzWGVOUzc3WVV3WFd4WXJsU3NPOGl6VUcyNkQ0UUtDQ2hEUHpJ?=
 =?utf-8?B?NWZ4alZkVHUyc29Za0RaQzcyVmZtSmNueU1MWlJ4a1R4S2pBMDRyUmFScDcy?=
 =?utf-8?B?RzE3ZkRZRnFvNGRjcThncmRCNFNlWlgzenF2eTB6ckx2YU01VStmbzc3RWVK?=
 =?utf-8?B?NW8vdmg4NGp2eThvK3AzWVY1emh6RXg1RGJIbU1JUmd5WUtGVFJnTXNsMjNa?=
 =?utf-8?B?SnFIZ3V4OTM4SzJ6cDNYSVEvY1FwNUdyOThiSnBWUUxqRTkyekFtNTdvNC9C?=
 =?utf-8?B?WnhvdmRuc3FzdlRtcWlGQjdpVXVWL1d2TUdyWnhCV0NXcVV6K1RqbThVeVJD?=
 =?utf-8?B?bXZwaTlOWmNoMlV3cU5qVjRWQkdjR01RekowMVJ6RE15Q2VHQnFvcWprMjF5?=
 =?utf-8?B?RGw2UzJ0Z3l0WXJ6M1pWQlpGUm1ya1NPeDA5NUFlWFlqSDhPcEt0VGp6UDNy?=
 =?utf-8?B?N2tXNkZacGI3dEtZaGJibVlXVGhVcElWamVrcEdzeXJFVWZYSTJjanVLck1R?=
 =?utf-8?B?YmVlQlZZQUgyNytMOC9tNnQzSlpQbmg3YmQ2MXlTYUJ4cGQwZmxiRmxDR3ow?=
 =?utf-8?Q?QWFKgUUh2QnbxuaFuw4r93Bn3v7eQ0mUXgpyrQ9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <09C69DF94DEBFF449E1994F4FF6DF1A1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ffbd70-1425-4799-d365-08d986e01ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 02:38:56.3636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74n34a7Xss3EFO5bFmOoBVM2LXlUEMy9g6MKigx2bil1MOPblHKlnH3oQmZ/jL6pdlTTJdD1dWOgbdcIoUiaaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4650
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTI4IGF0IDA5OjE1ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiAxLyBJZiBhdXRvbW91bnQgZXhwaXJ5IHRpbWVvdXQgaXMgc2V0IHRvIHplcm8sIG5ldyBtb3Vu
dHMgYXJlIG5vdA0KPiBhZGRlZA0KPiDCoMKgIHRvIHRoZSBsaXN0LsKgIElmIHRoZSB0aW1lb3V0
IGlzIHRoZW4gY2hhbmdlZCwgdGhvc2UgcHJldmlvdXNseQ0KPiDCoMKgIG1vdW50cyB3aWxsIHN0
aWxsIG5vdCBiZSB0aW1lZCBvdXQuwqAgVGhpcyBpcyBwcm9iYWJseSBub3Qgd2hhdA0KPiDCoMKg
IHdvdWxkIGJlIGV4cGVjdGVkLsKgIFNpbXBseSByZWZ1c2luZyB0byBzdGFydCB0aGUgdGltZXIN
Cj4gwqDCoCBpcyBzdWZmaWNpZW50IHRvIHByZXZlbnQgdGltZW91dC4NCj4gDQo+IDIvIHRoZSBN
T0RVTEVfUEFSTV9ERVNDIGZvciBuZnNfbW91bnRwb2ludF9leHBpcnlfdGltZW91dCBpcyBtaXNz
aW5nDQo+IMKgwqAgYSBzcGFjZSBiZXR3ZWVuIHRvIHR3byBzZW50ZW5jZXMuwqAgVGhpcyBpcyBo
aWRkZW4gYnkgdGhlIGZhY3QgdGhhdA0KPiDCoMKgIHRoZSBzdHJpbmcgaXMgYnJva2VuIG9udG8g
dG8gbGluZSAtIGFnYWluc3QgY3VycmVudCBwb2xpY3kuDQo+IMKgwqAgU28gam9pbiBvbnRvIGEg
c2luZ2xlIChsb25nKSBsaW5lLCBhbmQgYWRkIHRoZSBzcGFjZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE5laWxCcm93biA8bmVpbGJAc3VzZS5kZT4NCj4gLS0tDQo+IMKgZnMvbmZzL25hbWVzcGFj
ZS5jIHwgNSArKy0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25hbWVzcGFjZS5jIGIvZnMvbmZz
L25hbWVzcGFjZS5jDQo+IGluZGV4IGJjMGM2OThmMzM1MC4uYmU1ZTc3YTgwODExIDEwMDY0NA0K
PiAtLS0gYS9mcy9uZnMvbmFtZXNwYWNlLmMNCj4gKysrIGIvZnMvbmZzL25hbWVzcGFjZS5jDQo+
IEBAIC0xOTYsMTAgKzE5NiwxMCBAQCBzdHJ1Y3QgdmZzbW91bnQgKm5mc19kX2F1dG9tb3VudChz
dHJ1Y3QgcGF0aA0KPiAqcGF0aCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBn
b3RvIG91dF9mYzsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoG1udGdldChtbnQpOyAvKiBwcmV2
ZW50IGltbWVkaWF0ZSBleHBpcmF0aW9uICovDQo+ICvCoMKgwqDCoMKgwqDCoG1udF9zZXRfZXhw
aXJ5KG1udCwgJm5mc19hdXRvbW91bnRfbGlzdCk7DQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAodGlt
ZW91dCA8PSAwKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2Zj
Ow0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqBtbnRfc2V0X2V4cGlyeShtbnQsICZuZnNfYXV0b21v
dW50X2xpc3QpOw0KPiDCoMKgwqDCoMKgwqDCoMKgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZuZnNf
YXV0b21vdW50X3Rhc2ssIHRpbWVvdXQpOw0KDQpOQUNLLg0KDQpUaGUgZXhpc3RpbmcgY29kZSBp
cyB2ZXJ5IGRlbGliZXJhdGUgYWJvdXQgX25vdF8gYWRkaW5nIHRoZSBtb3VudHBvaW50DQp0byB0
aGUgZXhwaXJhdGlvbiBsaXN0IGlmIHRoZSB0aW1lb3V0IGlzIG5lZ2F0aXZlIG9yIHplcm8uIFRo
YXQncyB0aGUNCndob2xlIHBvaW50LiBDaGFuZ2luZyB0aGUgdGltZW91dCB2YWx1ZSBhZnRlciB0
aGUgZmFjdCBpcyBub3Qgc3VwcG9zZWQNCnRvIGFmZmVjdCB0aGUgc3RhdGUgb2YgdGhvc2UgbW91
bnRwb2ludHMuDQoNCj4gwqANCj4gwqBvdXRfZmM6DQo+IEBAIC0zNjYsNSArMzY2LDQgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzDQo+IHBhcmFtX29wc19uZnNfdGltZW91
dCA9IHsNCj4gwqANCj4gwqBtb2R1bGVfcGFyYW0obmZzX21vdW50cG9pbnRfZXhwaXJ5X3RpbWVv
dXQsIG5mc190aW1lb3V0LCAwNjQ0KTsNCj4gwqBNT0RVTEVfUEFSTV9ERVNDKG5mc19tb3VudHBv
aW50X2V4cGlyeV90aW1lb3V0LA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIlNl
dCB0aGUgTkZTIGF1dG9tb3VudGVkIG1vdW50cG9pbnQgdGltZW91dCB2YWx1ZQ0KPiAoc2Vjb25k
cykuIg0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIlZhbHVlcyA8PSAwIHR1cm4g
ZXhwaXJhdGlvbiBvZmYuIik7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiU2V0
IHRoZSBORlMgYXV0b21vdW50ZWQgbW91bnRwb2ludCB0aW1lb3V0IHZhbHVlDQo+IChzZWNvbmRz
KS4gVmFsdWVzIDw9IDAgdHVybiBleHBpcmF0aW9uIG9mZi4iKTsNCg0KLS0gDQpUcm9uZCBNeWts
ZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15
a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
