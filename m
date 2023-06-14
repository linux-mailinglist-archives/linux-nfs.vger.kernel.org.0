Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2449730384
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 17:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjFNPUM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343813AbjFNPUG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 11:20:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2101.outbound.protection.outlook.com [40.107.92.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1DFC3;
        Wed, 14 Jun 2023 08:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP8nhVpAg6VK47K8to5As1b8hi2fYBWY77lFcOfddNRaariV9SBFAkXu5LhHgy5YVjgkWYh2e/OrKtMSJKCyT5uSbeTO5iWXKKbLRjWloBzBe3boC2vAsQ5rdLSmd8qknGoHSdewYTCYJf1/r6rTwozRnDAe/xM/WJwA+igQGvTKavf0hulEwYY78yoZuA1JLlsgL+R/tEM4SzTEeYiibEbEJerhI2dbHO7SSx0Yt/w08C771tpmy2fMDiRsQzMjjJxXlG8WArVDR8z/nLuvKi2bInlR8MXeC4PC8f3Sy22x6VQP6L3en5GOyn8jBQjbDWuvEhcziv6y38pDPLEzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czvNOoAsATx6jPvID+gvhRuHI85vpOVqHqcGu5+5cm0=;
 b=QoAcs++0FZB0aygzKG12osbO21GGTuHMXrbQloafOpRXaVem86D9Z3YMau+/un1qrzXrLoBFtUwxE18Th43evFabNj9eS4q1B00hzZhwk3Ig9C5fW/m6DbLo3YA/sAxRsewMOd44GTD1uD35UHKGUrvTxZnof7mPeWD/Q+YCd+oqnriTgb8p7DSClvRhTrjot5Fls/y/FD4w8GbcgaR2mw26QTbCe+E0+bkWT0JL5YGQWpKKzJiENeoofqjcC+PdIKwn1gaNclJuGZgmKvrqyLxIfEqR+XXqhsK9SoBU1AjUEAiyFqDnF0ir+jo6hs4mWvZ6d4sxVh2ogS7qCN6FHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czvNOoAsATx6jPvID+gvhRuHI85vpOVqHqcGu5+5cm0=;
 b=FEbZxOBfJbkvzKeKNVf8EalRjSjOB2xg3WX5UFrNwQcl+MfirJnHvQQl46WrUbJSmbEg3rl6mI3jg5btmmg5qr40yVZsB4LfKyEx7LxL9V03C5Dxv6wfuVG7E2B3tsqcQdJETejkRLiZQlHG5FJghYAUvCaq8HStyLxLnjdBg+M=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3987.namprd13.prod.outlook.com (2603:10b6:5:2a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 15:19:59 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::6a2f:f437:6816:78f8%6]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 15:19:59 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "cymi20@fudan.edu.cn" <cymi20@fudan.edu.cn>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsroot: Fix missing check for return value of strsep()
Thread-Topic: [PATCH] nfsroot: Fix missing check for return value of strsep()
Thread-Index: AQHZnszcoTCvxuIl00GBkTwUcpZWGa+KacIA
Date:   Wed, 14 Jun 2023 15:19:59 +0000
Message-ID: <83fd43a8acec2d07ee7bd49afc830988354784ed.camel@hammerspace.com>
References: <20230614143058.112300-1-cymi20@fudan.edu.cn>
In-Reply-To: <20230614143058.112300-1-cymi20@fudan.edu.cn>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3987:EE_
x-ms-office365-filtering-correlation-id: 0ad24b36-488d-4557-137c-08db6cead16f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8QP/tC+5G1ADhK2zX5IhL/0Fqk0EjzO0UK1lUCyW3Ih5Hd73wuJGSOw5Wmjb4gjYunW/laLyswDAoyPWf31vCnmbb7WlU4YDbwNOHmEHrKHTBYL7XcFIZ6ogxeq12QCuAOPKG3Jk0CTu3QxUuUYOF/1QNmxFgq+cSsxvnxJQNyQKcMqQXPJrHixKqhDFwXm/444qA2TmNxC2sxDd22jwJZefFd488Lx9bSKaHD0x/lORszkvlmDemoQAqns13WeznRNTVWBHKAd7nLgdoSeWiPRURx1SLuKgjVg6umuCy7KQzfwYhSMmGRGEzLxQgP4iBqmi7WJzIZcIRQmeE+pkTd9dRvI71nj/5ZFYS5jlgN/Y7nxtGFWdbmxIZWEX5WkKelpB2WqzGa4+dhyz7w5Y8lTrtW+fyfp5tYifPy22gDAyLH+B+kWohD91dJbWbMuwKLykwKgkQy80pYifMoAz/3HDF0lUzCi7FX2rjeA0N0qwXVMpihxuV2W/TDnNpZEyyL6x2rfZVJUilp1zVDcHxY8KVSZyX6kCzhAuoGTn4NGrA+LDHxK03BiZJFIcZec/f6jgP5hWjTzxwNdwvF+GY486I/u9P/ntU0LRePbROvmVrYrFoYY3yhx+bnjWGXhOt+LbR0jl7nlVmhk5xB8weuFWvut5dXv0izCG8sEg5k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(376002)(136003)(366004)(346002)(451199021)(8936002)(6486002)(26005)(8676002)(6512007)(41300700001)(38100700002)(36756003)(478600001)(86362001)(71200400001)(66946007)(6916009)(66446008)(4326008)(76116006)(66476007)(66556008)(64756008)(316002)(122000001)(38070700005)(54906003)(6506007)(5660300002)(83380400001)(186003)(2616005)(966005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEt5SHJBSXBvOTQrSDlPUGc0Q01QYTdablI2ODh4Z0dnU1ZEdnRjVFVsMzZh?=
 =?utf-8?B?SFpaMXE0RVFqNERUd1Q3bGJYcUREMEY4aDFlaFNpOVJWeW8xUi8yL2NsblJL?=
 =?utf-8?B?V2tCV2FZYWpMbHNYSU9jMUJkbWZBMVZhN2ZOODFCd3dlamU1Q3JPNGE2aFUz?=
 =?utf-8?B?L3pwNUc2dG1HdzYrU1I5eFVTUUhOM3VuVURZMnFnR21sNzZhRXdYUWJKcmhR?=
 =?utf-8?B?QmJLNVVCU3krSTlrTnZvRGhGU0dsc3RLaDZQUkdiQnZid2lNWi9sOXRhR0RF?=
 =?utf-8?B?SkwrczBRR3Rua05jVDlKZUF1UkpDa1dhQWNtSnB4bXB3MnhVRHJiQVVVelhk?=
 =?utf-8?B?M3YyZCtMRTQ0QTk4SFdUTlZaSkxOWVNrTDh3UjFSZVhKR01VdGVVNXo0WXE1?=
 =?utf-8?B?VFVXUnJQd1lMR3dNRTdqOVVYK3drM29mSytRRnJ6VzBKQnBUUUZ3amkxeGtv?=
 =?utf-8?B?UmNXbnBHZGw3U0xVRlhiOXFpN21FMUFlTXJOcmxESXM0V0FjUzBVc0U4R2dy?=
 =?utf-8?B?WUhLS2VzZ2VGVGdBVFRYNzNxK0xsd2hrTlVaM2I1Y05uTW1PYnlhWmozNnM4?=
 =?utf-8?B?dGU3dVo3N1o2MTQrTEIvdCtVUmQwQjFGQjcvekc4VU5nMWFqRFpaeUUrSUgy?=
 =?utf-8?B?TDdreEo1bGRoNG04cDRneUtYY1VKeXlEdHU4TUNvTkI3M09iU0pJV29kWDRZ?=
 =?utf-8?B?ZENtNnRpR0FjMmI5ZWRhY1lGVTFsK2V2WUVpYmdkMDFwRHU1K3haUmgvK0o0?=
 =?utf-8?B?SndQdkFrWWdjRnlaMHNWa0xmZkdZd1prSDNsRHNoY2txUzU1d3BHZ2JSM3hl?=
 =?utf-8?B?TklqSGZ4L0U2emdXcUJBNVVFbG04RXQ1a0NIRWQ2bDRWbE1jNEZjNStiWmVn?=
 =?utf-8?B?MDNKZ3FYa3JnWHRoVldWUDhSV2NzcVd4SUpuOXBYS0F5bk10M1hUVW5UaEU1?=
 =?utf-8?B?NHV0NzRIY05yNVRFdlBQRnE4RWNJa05iTTJXVEFEN1BuQVFRNk41Z3RIZEpY?=
 =?utf-8?B?YjRIYmlSYWo4bGZnOS85UGc2cFdDdGMvdERqRXVQSTZTb3dwUGFxbnBiK25k?=
 =?utf-8?B?ZkZPOVlWWDhNV1k3Ly9kQlVKaEF3RXBQeFlpbjRtaXNGS1hKc3pTLyszbEQy?=
 =?utf-8?B?WGFISVFjKzdHeSt6VGI4dU9ERDFtZ0g4UDdSVk1qb0ZlNVYyVWtnRGNWVmV0?=
 =?utf-8?B?Sm5JdHpvNUdNd09RWXFtYkJaWVJ4OUZTTDlMcnB1SVkwTVdkKzQ5N2tnMVdQ?=
 =?utf-8?B?WmFyYThHeXFUTjhtbHk3V0pKL3F2REt4VllFNElDRTRta25Ka3E5SXQzNXlq?=
 =?utf-8?B?b3hmY2JlVkk1K0o5cTZRRmd1Vm84QlFyalQvSUZZRWRldGU5ZTZZbExkMjhF?=
 =?utf-8?B?dVFFQVFSYmdqSHV6QVNnSmRDUW1QL1FXN1dhQlhWUGN3U0Z0UVFFaDhncU45?=
 =?utf-8?B?L1VRMG13QjcyWmEzU3lJRE5ucERTcVNUZDFLK1dRUE1WNUpTVjRKL3gyNHNl?=
 =?utf-8?B?b0ZnMXdYLzRoS09PM2oyQW5aVEtrcGF3T2o0YzkreXl1eVN3U2FSUEliWXhI?=
 =?utf-8?B?YTdleGpWQXIwaFJJUzlIZlZIeVVYYkQxemc4L1VHNXJqeTBhaGxPdEVpWFR6?=
 =?utf-8?B?R2Q4WjZORFkrZTd3aG5DUlhGd3dJSlVkUWRDaUJ2SGF5VjBhRVVqdWljMCtR?=
 =?utf-8?B?dmpXc0xXUnJHeFdGd3lvbUUxUWluRXFPSzRtVjFWT0tZdHltRFg5aGVBNlgy?=
 =?utf-8?B?NUVWKzJZdjFYVWRVRjllSWhIU3RkTldOOHRIUEJQNmljaFprcTZHZmh5dWZ5?=
 =?utf-8?B?OGhoZS81ZW4ybE9FMmU4MHBCazROR1FHZ2J0ZDMwRGJwVHBPTXlyb0IwYWt5?=
 =?utf-8?B?RHpwVlE1dUFBekV4cHdtUkZqd1hnK0cwcnpHTGVobkZ0T09PZ1VlRHI1V0pP?=
 =?utf-8?B?am1NTHU5VW11dW9qZ1l0WVdVT1Q0TDM4YnR2VDA3TUtnNW1Rb2JhYmJUcmlL?=
 =?utf-8?B?amRJTzNqb1h1WW03bUk5VDNOblRTSytKSCtlLzhhWThLYkJsb2JTZUw0YVAy?=
 =?utf-8?B?K1FoZVk4d3hzR1Rva1MwSWZ3ZXlvTUpHNWxxYVRubmN2TlgwWkEvS2hoNnlL?=
 =?utf-8?B?eGdUWHJkTWhQdE1DVTlOQ0p3emRmT1haVFpOQTd5WHlZVENlOUwwU0ZtamZB?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16F935F7A5CF264482C8B4D4E8B3FDC9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad24b36-488d-4557-137c-08db6cead16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 15:19:59.4750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aR8DT8eYhzWOIXVne7xJnRYVq7oUpL/GHAA05NIbtJNZ43asDztUcK8PCdpPQ2w4A78BVlJdDCfbLoPb8ne9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDA3OjMwIC0wNzAwLCBDaGVueXVhbiBNaSB3cm90ZToNCj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBjeW1pMjBAZnVkYW4uZWR1LmNuLiBMZWFy
biB3aHkgdGhpcw0KPiBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNl
bmRlcklkZW50aWZpY2F0aW9uwqBdDQo+IA0KPiBUaGUgc3Ryc2VwKCkgZnVuY3Rpb24gaW4gcm9v
dF9uZnNfcGFyc2Vfb3B0aW9ucygpIG1heSByZXR1cm4gTlVMTA0KPiBpZiBhcmd1bWVudCAnaW5j
b21pbmcnIGlzIE5VTEwuIFNpbmNlICdpbmNvbWluZycgaGFzIE51bGwgY2hlY2sgaW4NCj4gdGhp
cyBmdW5jdGlvbiwgaXQgaXMgYWxzbyBuZWVkIHRvIGFkZCBOdWxsIGNoZWNrIGZvciByZXR1cm4g
dmFsdWUNCj4gwqBvZiBzdHJzZXAoKS4NCj4gDQo+IEZvdW5kIGJ5IG91ciBzdGF0aWMgYW5hbHlz
aXMgdG9vbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoZW55dWFuIE1pIDxjeW1pMjBAZnVkYW4u
ZWR1LmNuPg0KPiAtLS0NCj4gwqBmcy9uZnMvbmZzcm9vdC5jIHwgMiArLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2ZzL25mcy9uZnNyb290LmMgYi9mcy9uZnMvbmZzcm9vdC5jDQo+IGluZGV4IDYyMDMyOWI3ZTZh
ZS4uNTVjNTk0ZGVkZTlmIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzcm9vdC5jDQo+ICsrKyBi
L2ZzL25mcy9uZnNyb290LmMNCj4gQEAgLTE5OCw3ICsxOTgsNyBAQCBzdGF0aWMgaW50IF9faW5p
dCByb290X25mc19wYXJzZV9vcHRpb25zKGNoYXINCj4gKmluY29taW5nLCBjaGFyICpleHBwYXRo
LA0KPiDCoMKgwqDCoMKgwqDCoMKgICogU2V0IHRoZSBORlMgcmVtb3RlIHBhdGgNCj4gwqDCoMKg
wqDCoMKgwqDCoCAqLw0KPiDCoMKgwqDCoMKgwqDCoCBwID0gc3Ryc2VwKCZpbmNvbWluZywgIiwi
KTsNCj4gLcKgwqDCoMKgwqDCoCBpZiAoKnAgIT0gJ1wwJyAmJiBzdHJjbXAocCwgImRlZmF1bHQi
KSAhPSAwKQ0KPiArwqDCoMKgwqDCoMKgIGlmIChwICE9IE5VTEwgJiYgKnAgIT0gJ1wwJyAmJiBz
dHJjbXAocCwgImRlZmF1bHQiKSAhPSAwKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKHJvb3RfbmZzX2NvcHkoZXhwcGF0aCwgcCwgZXhwcGF0aGxlbikpDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC0xOw0KPiANCg0K
SHVoPyByb290X25mc19wYXJzZV9vcHRpb25zKCkgaXMgY2FsbGVkIGZyb20gZXhhY3RseSB0d28g
Y2FsbHNpdGVzLCBhbmQNCmluIGJvdGggY2FzZXMgJ2luY29taW5nJyBpcyBndWFyYW50ZWVkIHRv
IGJlIG5vbi1OVUxMLg0KDQpOQUNLZWQNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
