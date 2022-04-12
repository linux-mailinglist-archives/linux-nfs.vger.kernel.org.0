Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BB04FE3C1
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiDLO3t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344261AbiDLO3s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 10:29:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2130.outbound.protection.outlook.com [40.107.236.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A98154BE7;
        Tue, 12 Apr 2022 07:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+kP4L4fcciJGlioWrRXtf2hp9W7doQrFThWHgrvlRlz3dxwJvlJqkAL1Hb5A2jrT+vAJiks2Vr3NcDi7HXyVJllbPk7BaKtq3zTkIgWGF9jGBxJqIgHGR1+yTPw0WGJtqH5Db1cdrxkzOGZo5HZ39H35hAxc28GWLnoq0JQ5tITtTFAQ1BUUkc0ythVmDl81XhQ2v+6+NP0I87CnV4bUuED7FayjjV0Q3urXSaFKnzIT1R21SbQPv1NeDqykD0dY6TJMZS4rH70SyG6Wx9y9v5uNnTE5hbjdp18/IQ0B9SSbTqTwbYYCwyFKqQaaLIljR/B3sn4GOcZ6KiQ+YQtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEHsfkeawuAhSCFTv4AwFpaStSje9MfVbT/7r9+phUQ=;
 b=l4FaNB22PrJistBwk10JwXpZQ03bOlLukWLvw7t5NiFlI9jncevT198/Z22t9vfI+bAQnokA4/Z2dG1lPIuwoT27P1xa4qzhaERbk71HgZfi48SyillWG2vuphhVXfp5xzUe05IgiasTdkun7pD749ixfT0PLXZFphN2WfdcIc9pLMwXl+uRK0OuFQ7qtj5ts28vFns1xC++OP5PgEcNgPoBmUL2k29EiRlIkzE5Fi4M305l1oXjnq3xgVs4pqm1zYgIWKKi4RfeVbiFaayPYUv/s9jwO1riNcRyfay4uGwtoK548buitvmYL4G2AFqyx5bS4rrhF44WX/vqEU4hkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEHsfkeawuAhSCFTv4AwFpaStSje9MfVbT/7r9+phUQ=;
 b=HUnMXd+qEtPsK+R+UxY7O92xYKPrBuDx8aNx1BHmjGuBYqWu/2NQQ8rogtXDQiuaGlS89wxmcbUImV75/7rLIXDTQEkLav2AI63AwW4u3y/s5kwF/SbQZomU6U3maFZ9cXjmxR9TRwNJmLwnXSewZJBjwUdtGnTjCpV/pBREfUM=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY5PR13MB3604.namprd13.prod.outlook.com (2603:10b6:a03:1a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 14:27:24 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::c0b:4fda:5713:9006%6]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 14:27:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna@kernel.org" <anna@kernel.org>,
        "chenxiaosong2@huawei.com" <chenxiaosong2@huawei.com>,
        "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH -next 1/2] nfs: nfs{,4}_file_flush should consume
 writeback error
Thread-Topic: [PATCH -next 1/2] nfs: nfs{,4}_file_flush should consume
 writeback error
Thread-Index: AQHYMIz4ntebXgxsJ0GgUhvxvI+AhayxAgAAgAC4igCAAKqugIAAEaIAgDoPigCAAAKeAIAABLWAgAAEBwA=
Date:   Tue, 12 Apr 2022 14:27:23 +0000
Message-ID: <9fc83915a24d7b65d743910dd0f0e5f3d0373596.camel@hammerspace.com>
References: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
         <20220305124636.2002383-2-chenxiaosong2@huawei.com>
         <ca81e90788eabbf6b5df5db7ea407199a6a3aa04.camel@hammerspace.com>
         <5666cb64-c9e4-0549-6ddb-cfc877c9c071@huawei.com>
         <eab4bbb565a50bd09c2dbd3522177237fde2fad9.camel@hammerspace.com>
         <037054f5ac2cd13e59db14b12f4ab430f1ddef5d.camel@hammerspace.com>
         <4a8e21fb-d8bf-5428-67e5-41c47529e641@huawei.com>
         <0528423f710cd612262666b1533763943c717273.camel@hammerspace.com>
         <ccd017a4-31f1-297f-b2e2-e71eb16f1159@huawei.com>
In-Reply-To: <ccd017a4-31f1-297f-b2e2-e71eb16f1159@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3635a3c8-a93b-4691-d87f-08da1c908fd8
x-ms-traffictypediagnostic: BY5PR13MB3604:EE_
x-microsoft-antispam-prvs: <BY5PR13MB36047C8E744825DAF74112DBB8ED9@BY5PR13MB3604.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iBcyH2EYmvowgYg+FcqYX8KGHfiwf9Ocf3W4a7GmN1kn1xDjAP3/7S6AkX+UBzFKxi7rpKpaJhs3pqZ9oNtNIgikvdQu8ANP9bFuzggS1PQCsJQ0/2djiecNzbqhIGqKSIPqHfAqRxqVaxKnmlcBUPpH2tWg1kBsc4mMdLfd7sDseWYdrUN0BNHNlaUOUPOtzgGDHgzwlEmOZiuCrH16oNoK+WBy3LRpIOLzQROqX9BSk0t8gt1IXRRBxfm+fl7UBFhhzsk9GdxIjdIlw1gWty5QYz7vYzpmsNATRSUGqnohMPdI35hJDshwVVhFoZ9zYfD7C/1OozBMZOh7ZclNhqwtDPaAlNSx0EUcr1Rw587bBP6SS3cFRGe8Hm2g86lJi57Ozn6xsbP7uxw4R/Vt642UzsQEoMVqDEEukldjg66hIWoMs3E5Qkz+SV8w6V1bsME5ZeCd/HyYXbQj1RPGIgf8h1ATbmYEFKOAgE2b/o49tKwC6pMnBqhtl+U0MiivPL9oJwWh7ayyNDfRNU3mbSPHL2feUaUmhnydQhtI2wJCnhrUxHpUuQW7nu2e+Yu4/1IYoLcJZiMavNxmSa4+ZV7wejEAl6Km0dgkjt+cHxY6wEgLY5SC1cwh5ecNMtCtwQbp1fXkXwvdf2mFuNG/SA93zC0YjwiBzs8bhmo/3ueTvoqlH2+lryZ/Q/MuHF+qhTXDO8/hiOAti+Qqh7LMPoWeoSX/wuwp/hFK5r0b5THsXYhN+9qFtesQ0A67HOPo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(316002)(26005)(76116006)(66946007)(66476007)(6506007)(38100700002)(83380400001)(36756003)(54906003)(38070700005)(110136005)(2906002)(66446008)(66556008)(122000001)(86362001)(4326008)(8676002)(5660300002)(6486002)(2616005)(6512007)(8936002)(64756008)(71200400001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlV4MC9scHNZanVSWVNOamlsYWtjWDFkTzdNcWJFc3ZGQWV0L3FKTk9Na24x?=
 =?utf-8?B?akllc3JPMG1qdVg2Y1hXdXRxcTZVSzlpdmJnV0kzM1BWUFJySzBsbmdIb2xk?=
 =?utf-8?B?elAva2lDTmYrcE1rNWNPVlFnS2YwN1AvSitHTTdMR2xvVlZqQVdHU2hmL3pz?=
 =?utf-8?B?YjN2STJNbzB2VXBEVkwrK0RXdElGUnZpQlZpQUV4Z0ZNdURpUm5OMGxHVTdX?=
 =?utf-8?B?TXFWU3lpc0dwTmt3NUdjQXBiY05nVGcvWTg5Z0JCTHg4UDRUSnhlMVgxb016?=
 =?utf-8?B?QkJ2ZEdYR01KSHNqdzY1UDhkQnkwaFA5WHJnc29qREZuM1kvdmZCNkczMURF?=
 =?utf-8?B?ellXbzR0K2VLUGxRTkdFT0J2YmRoR1NKemhsSEdZdGVwRG11SHVVN1BKY1g4?=
 =?utf-8?B?TWtoSEVKeUhOaGx3UEJLM1ZHdVdVb2NJN0xDUjZvNmNtV3ZhaGdFLzAxcmVK?=
 =?utf-8?B?Q05GWG5RQjgrZjc1TGFDcmJaa2w3N08wMW1sMldZendpVU9KVWxNOWR5NWhE?=
 =?utf-8?B?VHl4dWRXWUFxVWcyU2tEcm02YlNHWER6Vk53NFhZeGlLUnkvUHZnME8zRldO?=
 =?utf-8?B?VkxqMjh0UXVYT1IvUDNSTGdxWFN5YTBFVjkvOHo1ZUNndUpqRmFlNk9LOE9I?=
 =?utf-8?B?bkdIYnZNREJUdlEyak96MXgvSldWVUJwSVJpWU9BeVFNK1RuT255clZkS2lR?=
 =?utf-8?B?L09BQnh4TlluZG8yK3J3Wkdld1VOZHVyUzQ2Uk96WGpUbVkzNTVERFhESzNh?=
 =?utf-8?B?b1VRcDBjSTVweFZJdHk5SkxoUVB6MzBDMWN3dFBnT1NzanVYSmhOd3E2Qit5?=
 =?utf-8?B?UnpCTkNCTEZVRWxOUzI1RlhiSWZGcGZkbzVZMXpaWnB1NXBMaGp0MENSam5w?=
 =?utf-8?B?MHRaTHpNZkNVZzMrcndPVVlHQXBVZnArd0pPMHNVVFliVWpkTEpuRVlWUHBP?=
 =?utf-8?B?OXJpcFRjV3pvTmJ5SHhrcDUxWDc5YjVVVlNDNFVId1BJUDhna0RRWkViUk02?=
 =?utf-8?B?ZzZMOFE3KzJ4U3BDM1hyUjJVTWFUdmwwVjI2NHNIN2Y4cE9Vck5vWlN6NVhl?=
 =?utf-8?B?dSs1di9zd1JRQ0JPdk5QaE41WHYxcmR2L0hqbGdFMEVNSkMvQkRBWWdLRllS?=
 =?utf-8?B?M2ZvQUNLdnhMcGVoQmFONlMrWVd3QWc2T0c0Qm9PTThlRkhQWno0RWV6NWt0?=
 =?utf-8?B?OStvZVhwWGlheGJmVVFOQkZBU2dBL3RvWXRvK05BaEdSbXZxYnpmcTliTVZz?=
 =?utf-8?B?N085NVJVQVJEMXpVcjZCdy85bW5rUGpIMzN4YkdTSXB1Y0xLcFRMM3pRczlF?=
 =?utf-8?B?cFNSRWgrQ0JQOVAzTkJSZmZPSEdvWGRKa2Jac3lYVTBTNGk4RWdUbGtOcW54?=
 =?utf-8?B?eDRkVUEvcFgvd2pzS3kzRVFWVlNhVjYzZ1pJektid1NRYVByc3ZrbGtGNHE3?=
 =?utf-8?B?RTBSeVJCaW9YNkN0dC9ldkVSWXk4dUFjZlhCT3lqSW9OU2N4ejlFOWlyZ2t4?=
 =?utf-8?B?blBpdm9OSnJrVHlUVE1OSGVYQXdGdkdBUHZpeVRYcmxyOWN6YmgzTjBiQ09K?=
 =?utf-8?B?NG5Ob2ovV1NJR3VySWJlRHNzTTBFL2RuUWdaRjV4SVlpcDUveS9vY0hkSHRv?=
 =?utf-8?B?V2JrM3g5aHZQN0FtazVoNnlnMGUxVFpSV1JHb2puZmZOVWc3YThtcUp0THNw?=
 =?utf-8?B?TlhDQ2JRUmNrd2hMVGI5UTc3RkhzaU52bldlWEpKdVJIWEJBY3RsT2tXWFk3?=
 =?utf-8?B?eDBNOVdhZ0VaMG1USFgxMytaVHVSMFVsSDdFS2hQd3BCczhGQmJnTTFIV0JN?=
 =?utf-8?B?cVptZVNPWENvN0pxNU5vbkNKT3VJYjRpaUhoNldINzB1YTg5UXc3T2VCaFpi?=
 =?utf-8?B?TnE1bXVjb2owbk5ZUkY3R3pDeitMRWk0WkV1ZGpFLzYwa216M3pKVnVSejdF?=
 =?utf-8?B?N3BEaUhTc281NjlMMzg4ck9ia1NJZGVqWkRsSGNxQkFYcDBWaTA5QUd6a0dM?=
 =?utf-8?B?cWhJR2t5K1M1aEFPRTQ5WE81VFVXR0RaSGU2bU1SZWlpZjluZDhUdjhXS0ti?=
 =?utf-8?B?ZGFEeUxkTkY4R2pxWXBXbkJ6NGlFaFI3NFFCNC81YithbzBhUEJSelgxZmlD?=
 =?utf-8?B?QzArQmpSenBnZHl5UEg1bzJaR3VFMzhJMXlZdTJxNzQrYjMvVWlCR3VwMEtY?=
 =?utf-8?B?cXlobXJRUHgwOFRGQ0dvUk0zMUF5a3RzT0ZhL2FBaXRDN0tlbHlScnppNzBT?=
 =?utf-8?B?VzhKSHhubnlaOUQrNXJVWXZQMytVZTN0WWgvdkJuZDRUQVdrVnlRT0hBbGRY?=
 =?utf-8?B?VlVKT0hRNzNVcVRTUWNIZ0lrYUhPS0NqZjFsN0FDRXpoaWo4M1NrV3lLRTBT?=
 =?utf-8?Q?15d9KvBL0LgYsY/Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1D76B45BF5FF845B83F0A5C37CB436C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3635a3c8-a93b-4691-d87f-08da1c908fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 14:27:23.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtpIaSTx7SMlAofpVcv/b5889CmmAZdj9sZ4ww+kIJHuRo32t7hZ5tdMc4jXjXHokCUaSkMmRDjCrNJsGRg53Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTEyIGF0IDIyOjEyICswODAwLCBjaGVueGlhb3NvbmcgKEEpIHdyb3Rl
Og0KPiDlnKggMjAyMi80LzEyIDIxOjU2LCBUcm9uZCBNeWtsZWJ1c3Qg5YaZ6YGTOg0KPiA+IE9u
IFR1ZSwgMjAyMi0wNC0xMiBhdCAyMTo0NiArMDgwMCwgY2hlbnhpYW9zb25nIChBKSB3cm90ZToN
Cj4gPiA+IA0KPiA+ID4gT3RoZXIgZmlsZXN5c3RlbSB3aWxsIF9ub3RfIGNsZWFyIHdyaXRlYmFj
ayBlcnJvciBvbiBjbG9zZSgpLg0KPiA+ID4gQW5kIG90aGVyIGZpbGVzeXN0ZW0gd2lsbCBfbm90
XyBjbGVhciB3cml0ZWJhY2sgZXJyb3Igb24gYXN5bmMNCj4gPiA+IHdyaXRlKCkgdG9vLg0KPiA+
ID4gDQo+ID4gPiBPdGhlciBmaWxlc3lzdGVtIF9vbmx5XyBjbGVhciB3cml0ZWJhY2sgZXJyb3Ig
b24gZnN5bmMoKSBvciBzeW5jDQo+ID4gPiB3cml0ZSgpLg0KPiA+ID4gDQo+ID4gDQo+ID4gWWVz
LiBXZSBtaWdodCBldmVuIGNvbnNpZGVyIG5vdCByZXBvcnRpbmcgd3JpdGViYWNrIGVycm9ycyBh
dCBhbGwNCj4gPiBpbg0KPiA+IGNsb3NlKCksIHNpbmNlIG1vc3QgZGV2ZWxvcGVycyBkb24ndCBj
aGVjayBpdC4gV2UgY2VydGFpbmx5IGRvbid0DQo+ID4gd2FudA0KPiA+IHRvIGNsZWFyIHRob3Nl
IGVycm9ycyB0aGVyZSBiZWNhdXNlIHRoZSBtYW5wYWdlcyBkb24ndCBkb2N1bWVudA0KPiA+IHRo
YXQgYXMNCj4gPiBiZWluZyB0aGUgY2FzZS4NCj4gPiANCj4gPiA+IFNob3VsZCBORlMgZm9sbG93
IHRoZSBzYW1lIHNlbWFudGljcyBhcyBhbGwgdGhlIG90aGVyDQo+ID4gPiBmaWxlc3lzdGVtcz8N
Cj4gPiANCj4gPiBJdCBuZWVkcyB0byBmb2xsb3cgdGhlIHNlbWFudGljcyBkZXNjcmliZWQgaW4g
dGhlIG1hbnBhZ2UgZm9yDQo+ID4gd3JpdGUoMikNCj4gPiBhbmQgZnN5bmMoMikgYXMgY2xvc2Vs
eSBhcyBwb3NzaWJsZSwgeWVzLiBUaGF0IGRvY3VtZW50YXRpb24gaXMNCj4gPiBzdXBwb3NlZCB0
byBiZSBub3JtYXRpdmUgZm9yIGFwcGxpY2F0aW9uIGRldmVsb3BlcnMuDQo+ID4gDQo+ID4gV2Ug
d29uJ3QgZ3VhcmFudGVlIHRvIGltbWVkaWF0ZWx5IHJlcG9ydCBFTk9TUEMgbGlrZSBvdGhlcg0K
PiA+IGZpbGVzeXN0ZW1zDQo+ID4gZG8gKGJlY2F1c2UgdGhhdCB3b3VsZCByZXF1aXJlIHVzIHRv
IG9ubHkgc3VwcG9ydCBzeW5jaHJvbm91cw0KPiA+IHdyaXRlcyksDQo+ID4gaG93ZXZlciB0aGF0
IGJlaGF2aW91ciBpcyBhbHJlYWR5IGRvY3VtZW50ZWQgaW4gdGhlIG1hbnBhZ2UuDQo+ID4gDQo+
ID4gV2UgbWF5IGFsc28gcmVwb3J0IHNvbWUgZXJyb3JzIHRoYXQgYXJlIG5vdCBkb2N1bWVudGVk
IGluIHRoZQ0KPiA+IG1hbnBhZ2UNCj4gPiAoZS5nLiBFQUNDRVMgb3IgRVJPRlMpIHNpbXBseSBi
ZWNhdXNlIHRob3NlIGVycm9ycyBjYW5ub3QgYWx3YXlzIGJlDQo+ID4gcmVwb3J0ZWQgYXQgb3Bl
bigpIHRpbWUsIGFzIHdvdWxkIGJlIHRoZSBjYXNlIGZvciBhIGxvY2FsDQo+ID4gZmlsZXN5c3Rl
bS4NCj4gPiBUaGF0J3MganVzdCBob3cgdGhlIE5GUyBwcm90b2NvbCB3b3JrcyAocGFydGljdWxh
cmx5IGZvciB0aGUgY2FzZQ0KPiA+IG9mDQo+ID4gdGhlIHN0YXRlbGVzcyBORlN2MyBwcm90b2Nv
bCkuDQo+ID4gDQo+IA0KPiBBZnRlciBtZXJnaW5nIHlvdXIgcGF0Y2hzZXQsIE5GUyB3aWxsIGNs
ZWFyIHdiIGVycm9yIG9uIGFzeW5jDQo+IHdyaXRlKCksIA0KPiBpcyB0aGlzIHJlYXNvbmFibGU/
DQo+IA0KDQpJdCB3aWxsIGNsZWFyIEVOT1NQQywgRURRVU9UIGFuZCBFRkJJRy4gSXQgc2hvdWxk
IG5vdCBjbGVhciBvdGhlcg0KZXJyb3JzIHRoYXQgYXJlIG5vdCBzdXBwb3NlZCB0byBiZSByZXBv
cnRlZCBieSB3cml0ZSgpLg0KDQo+IEFuZCBtb3JlIGltcG9ydGFudGx5LCB3ZSBjYW4gbm90IGRl
dGVjdCBuZXcgZXJyb3IgYnkgdXNpbmcgDQo+IGZpbGVtYXBfc2FtcGxlX3diX2VycigpL2ZpbGVt
YXBfc2FtcGxlX3diX2VycigpIHdoaWxlDQo+IG5mc193Yl9hbGwoKSxqdXN0IA0KPiBhcyBJIGRl
c2NyaWJlZDoNCj4gDQo+IGBgYGMNCj4gwqDCoCBzaW5jZSA9IGZpbGVtYXBfc2FtcGxlX3diX2Vy
cigpID0gMA0KPiDCoMKgwqDCoCBlcnJzZXFfc2FtcGxlDQo+IMKgwqDCoMKgwqDCoCBpZiAoIShv
bGQgJiBFUlJTRVFfU0VFTikpIC8vIG5vYm9keSBzZWUgdGhlIGVycm9yDQo+IMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIDA7DQo+IMKgwqAgbmZzX3diX2FsbCAvLyBubyBuZXcgZXJyb3INCj4gwqDC
oCBlcnJvciA9IGZpbGVtYXBfY2hlY2tfd2JfZXJyKC4uLiwgc2luY2UpICE9IDAgLy8gdW5leHBl
Y3RlZCBlcnJvcg0KPiBgYGANCg0KDQpBcyBJIGtlZXAgcmVwZWF0aW5nLCB0aGF0IGlzIF9kb2N1
bWVudGVkIGJlaGF2aW91cl8hDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
