Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596DF4CEBD1
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Mar 2022 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiCFOGC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 09:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiCFOGB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 09:06:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2131.outbound.protection.outlook.com [40.107.220.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F3740A13;
        Sun,  6 Mar 2022 06:05:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKtq/vTY5uqEiX54YTO3CXlOQoIkmS4S0KrEWKVR/7oOrzkKGUbEQu5E7xGjO77lNEN/GJfZaTGv+FnWuI4m3J2hxV2fQ93kw+YDCNhswmJgwVEnDr5SrGbhdSim7wUR8Yvkb2Z6BG/sKpGAzobDq81VnDI2LHBDnLBs1SSFv5xqjWMeCcKDGizL3gRCv18XEXPJAj9YgMuFJAG3Ojm1tYxsVMteb06CW9oNWXyhmI+Ay8W4KqZ7HNGr7AghiMThEB4tR5SHnABJiQT3lJQ9BZTUFxnYXcIs4YgH9MbjVZocvMrUNBEgN7j42qm8s38JgMbxiNyi0N3hkP/y/GXA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK492WafI5hXu2uKeyRbD39wjOefyMQR36dBhlIvY8I=;
 b=lEYyvaBfRrTcAEn+yJs4yf6T3CiIfOiYX0fmQQXriJdTvq03GG/KdWUrBRNMz32rcNFMFVCgw7iLP0F75R9HyXtJlMmDnluj25W21cOnLOH51ZQxwDLAm65+UUM+mvBsryzLj6Bn7iJ0bHMeMKIsWo9/Mryydp3crOAdeiRFbJN7+/GU5yXF20n6uWfnc0OEFypgVc88ZP6DMUbCUf1BlzP4PAKJbfQCsGLqK64rOJq8MBKLF4iKgImqJ9SRQjP6S0GLCj6fAjG2LTPsGX+/BpaNKnMLEq5U0HrnsO17CnAU3HDGSkNCybVB5kyNbsiTYvTfbXq47837NIO82Hs+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK492WafI5hXu2uKeyRbD39wjOefyMQR36dBhlIvY8I=;
 b=Y78fIgDN4n78dazG5V+Y51ADqn67HwA6Umle8j4HC+PrxDEjtU2fstlTByoYjN0nsymAQjuzEJN2aSM9WfAtXjR9f5sMNkNB/TnUnWpZvE5pU6fKnnT9odSksnjIRYTUKOQd7UtNqNdWFJtpwznpOG7iP/ncF6TqMANwTaguTHw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by SN4PR13MB5373.namprd13.prod.outlook.com (2603:10b6:806:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8; Sun, 6 Mar
 2022 14:04:59 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%7]) with mapi id 15.20.5061.017; Sun, 6 Mar 2022
 14:04:59 +0000
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
Thread-Index: AQHYMIz4ntebXgxsJ0GgUhvxvI+AhayxAgAAgAC4igCAAKqugA==
Date:   Sun, 6 Mar 2022 14:04:58 +0000
Message-ID: <eab4bbb565a50bd09c2dbd3522177237fde2fad9.camel@hammerspace.com>
References: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
         <20220305124636.2002383-2-chenxiaosong2@huawei.com>
         <ca81e90788eabbf6b5df5db7ea407199a6a3aa04.camel@hammerspace.com>
         <5666cb64-c9e4-0549-6ddb-cfc877c9c071@huawei.com>
In-Reply-To: <5666cb64-c9e4-0549-6ddb-cfc877c9c071@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bb126c4-2775-49c8-bc2b-08d9ff7a4cdb
x-ms-traffictypediagnostic: SN4PR13MB5373:EE_
x-microsoft-antispam-prvs: <SN4PR13MB5373AA9062BC18A073988632B8079@SN4PR13MB5373.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ge0D6HmSFprsuUl9ROSpEGUpVO+wubmww+wpoHJrMuawWs5FW1GhRUHpJZaN7aj9eapG5aa3FJVSj619rG7mfN4t25xBU86d/86ochwSHod7yiDH/SEiA22illK7khIlO+N6jYwBrCtHKJXfL28VlfEnvDhw/IVeffZxekhpUidwYXa6Io5axjuQdDdyNGCbsd0iTGTesKhQ0aPfZE4NAeo1taGvSMXFAKdhRbIcKPzg2vD6PFWn4CLYfEdPNMcgEI4YMrjJ05uJlGImS3M4cyWEn4coGvyYkEE0k7mdCdmsERHTmXzJ1iiZTXMUYlGjwazpIjt3G6mJ2S6aZybMfQJi6YSNVCj69hL3J2Ejj1KE039y7bqLpKaw15ZvyvtEXinFxyZ4bD8jP1cY2l9mSs1UX4iFmMkq0GMC51mfuyuvCgqLrMw+Ez+0L3Uo7lwkDEgay/03fQSVz1CQng5tfqcyNZFaq/hwZttne88gr859AaZ1X551SED7+fpKFrKrYh0NH68imUOi4BR1YfAeI5hHghPjYTqNAmBwyBK1inuwILasSpiaFoK/8trp5Y+V2cXvdXV4gtTG/IR20YNcTpppHYn6Gk7mQuLAoLORDWOqs3emVUqd62mpZXSvYt4NeWiaY4ISJXZywJXtT57nV3qIGkJ61HZ8J1h1SqPmE5Vq244sYFbZepzjzUpiZEeM7fBWMoeqj2qKOFlheWhxcDMZeORSwPUmOq3H3I2AxiflEBuwrTfRLpimhGqZ/mfX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(66446008)(6486002)(38100700002)(38070700005)(26005)(186003)(2616005)(83380400001)(71200400001)(6512007)(6506007)(8676002)(8936002)(66946007)(66556008)(4326008)(122000001)(66476007)(508600001)(2906002)(5660300002)(86362001)(64756008)(54906003)(76116006)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTBwMW5RbmxmNkZpUGVEMmJKeldqakh6b0dNeHhNcTA3RTcxbTczMzBObDdl?=
 =?utf-8?B?L1dQWEJ0UlRFTWFRckpMem5VQkwxV3RtT2pmOWNOZ2g1TGVuMjRWZ1ZLbW43?=
 =?utf-8?B?SEcyUEVHU2dmcGtIVlFFOXV2RVh3N2dvZjVkckNYQitYVVh6WGlhYTdOWHha?=
 =?utf-8?B?NUVWOHJteG1qc2ZCVkM3VU1OT1Z3dEJ6QWxkZGg2K0wrYitVQ2Urd3FWSWJH?=
 =?utf-8?B?WGdDc3hwTmRQQ1JhQ3BFQ0krM2xuT2ZHSzF1dDY2VS8rSzFkcDQyQklraS9R?=
 =?utf-8?B?TDhKVnUyMjdPc0haUWt3MXh2MUthTC85L0tBZENaQVNYbnlLb3JyTHFhNStE?=
 =?utf-8?B?Rnk4ZkphWVN0bW9UMERGWWRncXdiSncyYldVSEtXdFlrWnFuT0s3WDdjRyt5?=
 =?utf-8?B?ZlFDY1lGY2RUL21NUWtLNnNTN1NVbHp4S1A0RzB0TWUvVjJiM2FqTDg2VW9D?=
 =?utf-8?B?ck1NQUNWWEJ6QkRrQmw2a0dFd1N1RWUwR0k5MjZKK1BGVms0ZWlWT0twZGRo?=
 =?utf-8?B?ejhOVW9ZOHpzdlZLYTVSSmdQeU4yWHlNK3diNUxuN3ZGUjdudW9WN1NTbDFD?=
 =?utf-8?B?TnpIM1laUER6ZG14VE8ybEYzNWNaRTNOdTEwTlFvM3NhUHplMjkvZjRvSW95?=
 =?utf-8?B?eDg3clQ5UmxZZmNRL0d2YmdPcW1abmw5U3RDWW4vWjFBeUVPWU9ydDhnVzZV?=
 =?utf-8?B?QkE2VExPV2RKUzFncVhMcVpvdmR3L2c4MW5HSS94ZnpPVVJtSWFXOFV6clho?=
 =?utf-8?B?Y1lpRUNyZFFQcW01UVRwYm9lQ1RnOVljaklrMlR6cnNrMUF4VDk5ZVd0aDBB?=
 =?utf-8?B?TFZnZTJCRjYrU2lFY1RkU0JtTjFpTE9kRzM0eVQ3ZEFUUjVPVG1HQzNDaHEy?=
 =?utf-8?B?RVRvQ3hHQmt1akV0Z0hUU1MvWjA2eHJqZ2xpVXZyNjAxNk45OWIxUDB2ZXJN?=
 =?utf-8?B?VVBVZi9KcTdZd1pPWjZQMmRoVzViZkcxRDhjRGR4aE15ZS85b0F5ZmYvY2dt?=
 =?utf-8?B?bElxSnN2eUo0M2RibGhXeS95ckJaUTVZRnpJdmYvRUw5Y1pJOExrVWxwbFlU?=
 =?utf-8?B?cWVyQ3dKNm1hbExuUmlML1k2RHhsOFRLZFBvVkpraFYzQXc1Wk56aXdBQWp0?=
 =?utf-8?B?QVgvVzlPRllpMTE4UzJnRzZKR3ZmTlJZWnptQUs0S1VMRVhqUkRUcGVkeVpT?=
 =?utf-8?B?WUU3eWJhQ0FscnY0OC93N3EyQVZDQ3dTdUFhekYzK0p0eUNMcDJRSGQvVU50?=
 =?utf-8?B?NjJ1WWhQTUVoM2JYSGRzd1BJRjVpQmV5YXhwTmRldFg2bW8xUXZEdW1BS2lR?=
 =?utf-8?B?Zy9pYXNRSFc2T2xqaEdHcmlmcm9GNjRNNldiVkV2RWQ2bUxBR3lac1hWTlJC?=
 =?utf-8?B?TW5MMW8vUnU3RVUwcTd6ZWpwTHRCbm9XWFdIRk12elZKSWliL2RzNE4rMEZo?=
 =?utf-8?B?MEpkZXdVT1lzaTV3TUVkMFVNNzB0UWJSSm1EU0xXeHhmcmIrOXZidlFuY3M5?=
 =?utf-8?B?cE93Ri93d1pvRGY2eDBod0c5VnJjYTFhZ0VHbDlWL2RWWlR3VHJjT012Z1pY?=
 =?utf-8?B?VmRyOUcwTUFRN2dHelpZcVgrcjcxcGdHSkorRUNydERLZmVJZ1dSNEtyZGM4?=
 =?utf-8?B?S1IrRElwR05HTFNvdDJqUWp3akl0M1NPNTl1U1E3bjNYYjFxZGtEblJmUHh4?=
 =?utf-8?B?MmZGWHBmMG9JTzYrUHlIQmhYeWszNmR3dzcwVU83d0tBd1lyOGFtVDRmL1dI?=
 =?utf-8?B?ZWxOKzNRZWw2Y3BPL29VTytxQW1YNVJheGZlYXVSZnRLTW5QWHJ6RnBHUmhU?=
 =?utf-8?B?MzNKcUVxMmZBTUVaUkRQMlRpWUNmZ2pVM0xpc25CYmNVSTg5eHNjK0x1bW91?=
 =?utf-8?B?RlZFZkJsMHdaRlhTVy83OWZJbjNpRHQ4cDRxWG96VXVRZC93S2xHTEgzbm9J?=
 =?utf-8?B?ZHo5V25jT1R2NHJYdDBDN3FrdGdtZzZTTkZRZERUWG13ZFJqaUU5Si9EN0FC?=
 =?utf-8?B?Z3lGOXBTa0RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6F0C9F8CAF8FF45A4FF183D3B6B7A81@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb126c4-2775-49c8-bc2b-08d9ff7a4cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2022 14:04:58.9103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5v3XdwsQf2ke54zQ9kmJOLXHVjDPH/0HNqbNTL/wtdFruckgdp5NOvBZPJol/mrPNku9wfgR/I+lmLw3wBksqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5373
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIyLTAzLTA2IGF0IDExOjU0ICswODAwLCBjaGVueGlhb3NvbmcgKEEpIHdyb3Rl
Ogo+IEl0IHdvdWxkIGJlIG1vcmUgY2xlYXIgaWYgSSB1cGRhdGUgdGhlIHJlcHJvZHVjZXIgbGlr
ZSB0aGlzOgo+IAo+IMKgwqDCoMKgwqDCoMKgwqAgbmZzIHNlcnZlcsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqAgbmZzIGNsaWVudAo+IMKgIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
PiAtCj4gwqAgIyBObyBzcGFjZSBsZWZ0IG9uIHNlcnZlcsKgwqDCoMKgwqDCoMKgwqAgfAo+IMKg
IGZhbGxvY2F0ZSAtbCAxMDBHIC9zZXJ2ZXIvbm9zcGFjZSB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IG1v
dW50IC10IG5mcyAkbmZzX3NlcnZlcl9pcDovCj4gL21udAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCAjIEV4cGVjdGVkIGVycm9yCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IGRkIGlmPS9k
ZXYvemVybyBvZj0vbW50L2ZpbGUKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
IyBSZWxlYXNlIHNwYWNlIG9uIG1vdW50cG9pbnQKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgcm0gL21udC9u
b3NwYWNlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8ICMgVW5leHBlY3RlZCBl
cnJvcgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBkZCBpZj0vZGV2L3plcm8gb2Y9L21udC9maWxlCj4gCj4g
VGhlIFVuZXhwZWN0ZWQgZXJyb3IgKE5vIHNwYWNlIGxlZnQgb24gZGV2aWNlKSB3aGVuIGRvaW5n
IHNlY29uZAo+IGBkZGAsIAo+IGlzIGZyb20gdW5jb25zdW1lZCB3cml0ZWJhY2sgZXJyb3IgYWZ0
ZXIgY2xvc2UoKSB0aGUgZmlsZSB3aGVuIGRvaW5nIAo+IGZpcnN0IGBkZGAuIFRoZXJlIGlzIGVu
b3VnaCBzcGFjZSB3aGVuIGRvaW5nIHNlY29uZCBgZGRgLCB3ZSBzaG91bGQKPiBub3QgCj4gcmVw
b3J0IHRoZSBub3NwYWNlIGVycm9yLgo+IAo+IFdlIHNob3VsZCByZXBvcnQgYW5kIGNvbnN1bWUg
dGhlIHdyaXRlYmFjayBlcnJvciB3aGVuIHVzZXJzcGFjZSBjYWxsIAo+IGNsb3NlKCktPmZsdXNo
KCksIHRoZSB3cml0ZWJhY2sgZXJyb3Igc2hvdWxkIG5vdCBiZSBsZWZ0IGZvciBuZXh0Cj4gb3Bl
bigpLgo+IAo+IEN1cnJlbnRseSwgZnN5bmMoKSB3aWxsIGNvbnN1bWUgdGhlIHdyaXRlYmFjayBl
cnJvciB3aGlsZSBjYWxsaW5nIAo+IGZpbGVfY2hlY2tfYW5kX2FkdmFuY2Vfd2JfZXJyKCksIGNs
b3NlKCktPmZsdXNoKCkgc2hvdWxkIGFsc28gY29uc3VtZQo+IHRoZSB3cml0ZWJhY2sgZXJyb3Iu
CgpOby4gVGhhdCdzIG5vdCBwYXJ0IG9mIHRoZSBBUEkgb2YgYW55IG90aGVyIGZpbGVzeXN0ZW0u
IFdoeSBzaG91bGQgd2UKbWFrZSBhbiBleGNlcHRpb24gZm9yIE5GUz8KClRoZSBwcm9ibGVtIGhl
cmUgc2VlbXMgdG8gYmUgdGhlIHdheSB0aGF0IGZpbGVtYXBfc2FtcGxlX3diX2VycigpIGlzCmRl
ZmluZWQsIGFuZCBob3cgaXQgaW5pdGlhbGlzZXMgZi0+Zl93Yl9lcnIgaW4gdGhlIGZ1bmN0aW9u
CmRvX2RlbnRyeV9vcGVuKCkuIEl0IGlzIGRlc2lnbmVkIHRvIGRvIGV4YWN0bHkgd2hhdCB5b3Ug
c2VlIGFib3ZlLgoKCgotLSAKVHJvbmQgTXlrbGVidXN0CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRh
aW5lciwgSGFtbWVyc3BhY2UKdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQoKCg==
