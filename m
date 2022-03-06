Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0424CEC03
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Mar 2022 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiCFPJI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Mar 2022 10:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCFPJH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Mar 2022 10:09:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5813727164;
        Sun,  6 Mar 2022 07:08:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFUZFxLrkcq9+rEiABnofTLtyA+ZcBncT+NjmRf/qRkNS3FKNTFOJNoRp6SpIF1hQlfOO20fjOllFOiZaQkPiQaP6tReYwc4xVJT87Uvx03sSh5dXxlt8JRHhYLm0Y27ZfroOqHHg199lS5gXeyQ+DJoFFpLhwP1WIUC0l7S4Y6XI5m9fmdDY9PCphRaGmj48+xBQ3ViAl/OEXkL+Dwn9f8QAgjlVoJJhUp6HPeVxKLrIqawuuydckgNKR40UNBDt4Mhb+yMODfTGOoR2sjBHfPY8yOWkErGLzXB71ViN9dUrYhiJ10z0Q/fR/RaMo7n73FttD+wlNq3T8qRkIrOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLwIGx0iqvIPLNLFmI2ZaSj6bMNsfODQNSxtPxCociE=;
 b=jEkzPM3HWaRIRCNUnYnVyz9Om9uzzh1pxX8FAYzMP+PBZQF1ugpqNlyNxuI7J61RfXUs/qtdah0Wn6pRHVo3z44jCRX9QPBzWVg9Ru9q3Iw7u1BzIG60SFxTAseb8HM/pkPn7Yv042JgAsJBdkgWubZy462s7Mv3VyJzqZOkO7V9kjsTjZeb2gYApJ3RCg9z0+o9k66l4ZwCBcwJJoiR1OG/ZPHZ6px4zpYZFmMbvHVYsRO2Nq/kNdPEZZINy5w0s766TaiOJwCKcVACpPYo9qRPjZl+UNtzM2lXGKkSIv2jWM4XUi5eUt0D4BOy6UZLtJAYAD84Ow8L8DCcx8IUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLwIGx0iqvIPLNLFmI2ZaSj6bMNsfODQNSxtPxCociE=;
 b=ZaCef+xR7+Pu0a0qvghBNpZ8lHUtc9h3p9OhzwBNF8WcuaaXlf5D+qLsuq//rI1X3grcpRxPekLglIuzpTSVWaoxH+J69bgH2hU5v0H0fPF4PJBTNWL6gXvLAS3BuqATlkN8GH+CsWpUneGgS9amfwbqFLDL5sEPY1VJNfueQJo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3655.namprd13.prod.outlook.com (2603:10b6:610:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.6; Sun, 6 Mar
 2022 15:08:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::70cc:dd9c:25b:4f3f%7]) with mapi id 15.20.5061.017; Sun, 6 Mar 2022
 15:08:06 +0000
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
Thread-Index: AQHYMIz4ntebXgxsJ0GgUhvxvI+AhayxAgAAgAC4igCAAKqugIAAEaIA
Date:   Sun, 6 Mar 2022 15:08:05 +0000
Message-ID: <037054f5ac2cd13e59db14b12f4ab430f1ddef5d.camel@hammerspace.com>
References: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
         <20220305124636.2002383-2-chenxiaosong2@huawei.com>
         <ca81e90788eabbf6b5df5db7ea407199a6a3aa04.camel@hammerspace.com>
         <5666cb64-c9e4-0549-6ddb-cfc877c9c071@huawei.com>
         <eab4bbb565a50bd09c2dbd3522177237fde2fad9.camel@hammerspace.com>
In-Reply-To: <eab4bbb565a50bd09c2dbd3522177237fde2fad9.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92c680f5-9ea6-48a8-207b-08d9ff831e16
x-ms-traffictypediagnostic: CH2PR13MB3655:EE_
x-microsoft-antispam-prvs: <CH2PR13MB3655A3D15132372E9F4C8DB8B8079@CH2PR13MB3655.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p4ex6eZTEqWCiG7mPmtLKar3h3UteiwBlXqBPLtxznOhtJL8psOTezDMmCpqrai0SpqghZQVdfob7H1BFP58iHWCTXEj90rzZNkwnP8cnj3y0jxnT7Vr60ziAIyrf2+jpEaCTdxnM0+bueZwdWEHCmkeChSlkNZTlrnx9yDo3iEDjUvJG1FCnIs8jgiydGLEWIKBKg/ocxYQaTC5vZUkAuAbgq4XIBCUJiV1lFFolB3Kh9FhmdsdM1Q0CbVxiw5zJUwg3ssMUMD4rRu9NrKxhEzcXcXikNGKJpIve/pOnTR5P1diJSRwN9LeQ/s2UYts87CCBnElQ2nVKFBB03qoOw6qcOX8nlLDohsXocKnvcGnel6RxmdIcmrB4iC5YCSUMHugQVHKR812T9xnjVIhZYxD17suhTzahsNkIkwePue87URO86TER8kywj8MqdUckh+/TfXo/D6zpoY664Qa7jc4MmHcDxlurs90NsDDaqU+97SShhOzkztEzYkBcyRQWtd5iWGrJo1z4RL67/0m63r1T3Rv/ytWwjzuJQCF6c8Ba9HEHKvEBsiNzcAL8XvrUJymbVWxruT0xwUwEveVjybwHJGMCoCrQTrvDs7qNUODh97i2Uht/4Pv6KADkRXxVbthbmGQXny4gxJatIBXHypRFfpn3X9qu+J68MeKDBMJVrzGePABZ6MdED/7cbMOi9gO95zUk3tt46cX68SXEYsN22KHnY+5rEohfKI4RcIdwFhrODANN8tVkSXs7K0q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(66446008)(64756008)(76116006)(5660300002)(6506007)(8936002)(4326008)(8676002)(122000001)(86362001)(2616005)(186003)(6512007)(508600001)(26005)(71200400001)(36756003)(316002)(110136005)(54906003)(83380400001)(2906002)(38100700002)(38070700005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0xDWEpqTC9vcW0vSk5kalpQU2xQZUQ2djhpSTBCWHJCMWVVWkNWMEVYN0No?=
 =?utf-8?B?UHh6M3JWb0VlVFRpbDB1YTF0dk91NzZqOXRUYlp1bmNMU1hFUFJqUC9Yc3Jr?=
 =?utf-8?B?MXUrd2hjakpRcjEwemR6VDJ3Z0ZtdlplN3N5cGRWaURISW94UXdaOXBTWnpi?=
 =?utf-8?B?cGo5MVZHdmJDRXV2TEM0Si9NOEF2V1BUT0gzNC9OZjdmWnBLQTFxNm5sZHdj?=
 =?utf-8?B?V2EwczJzVFAxdjhDa0swd3o0TW5reUhBYlhneFNCSGdjaTlNVVpWbXJVSGFr?=
 =?utf-8?B?ZE5OSGJyTXFLWkNncEZvcURyVi9ndS81STIrUmUxbVRBZXMvTUVKZ2JmWHl5?=
 =?utf-8?B?VVJMN3MyRFRFYkJCSmoyeXhtZHpDREdsUlB1UkhTbi9oWStQa0NOekJyYnlu?=
 =?utf-8?B?SlJvUlZvVGVtM1VvZDZGbnBMbjZ5ejNyN2ZyTHppdUw5TXlIczhDWFRJSng3?=
 =?utf-8?B?TTUyYmwxTVpQMGx5ZmxaSW9Lbm9xek1KMis1MnhLVHF3MS9LMVhzak1xR2J3?=
 =?utf-8?B?ajAxVDJCQk9hU09Tc2JIcXZPUm5FVGszdm5lV05XNFJ0Tjd3UFNpV29FWXBm?=
 =?utf-8?B?dzBpSVNpUWR2aXdid1pJdHdrQW1YTFQ0RzNFN2hsY3JXMVFHZkVCVzZKUEFK?=
 =?utf-8?B?bENXU3FMeEpxYzlERmF0QVh2MzQ5YW1BTjdqcTRvWTdoMzdYeFdDMzdSY29Z?=
 =?utf-8?B?ckMxZHRaQmdBdzVOQk0rcTFVREpWazJ3OXNZUEJmV0k5MjQ2MXNlTGlkeDdh?=
 =?utf-8?B?aXVpakJPTFlUTnEwUEVJUlhLOWNaUHBaUmN6ZElNc0RwUGZjVHA0QXl5MG1z?=
 =?utf-8?B?SHY3R0lnc0JNSVRUMUlWaWgwQ0pLREV2VFZZcE9MNkNkM2g0Ukd1NVZicTNY?=
 =?utf-8?B?cHRQZ2pvN3NCRlFsRzlKUk4zWWN4eUt0M3hWSXIwWm9wRm9TOVJpQjNNN2Jn?=
 =?utf-8?B?NVV0bDEyZGhtRTlzREoxSG5SWTRqSklheUNGcWxJSmpSS3VlNDBiMDBzWFBa?=
 =?utf-8?B?OWN0NjZXL0JmaUsxR1hVeDB2TFJjSTJlZzZWS2c0eUtGK3NFblRLK0FGOGEw?=
 =?utf-8?B?bnlhSndTU2lEWWpFWDZJRC9UVXkxSEJJd3o2R0JhSWZCQWtDT1IveGNrMVUx?=
 =?utf-8?B?SjN4elJrWEYxNlV0UHhDRDRsa3MzN21iVnlpSkU3NWM3ZVczU1NaQWtaa2pn?=
 =?utf-8?B?Q2Jqa2NNRmhHemtlU1JING9JMUpxK043blFveGp0cVh5OWIwTDhvcS9mOEdH?=
 =?utf-8?B?ZmgzQm9HOXlydDN2WHZBU0xUZ0xkNlZpTHI4TXZGeVdXeWlwTndON3ZWWXBM?=
 =?utf-8?B?bm1wVXRiSTlaSWYraFhoZkRLcDM3eEI1VW1nOXgxRlo2a3JEVDd1YWR6dDFD?=
 =?utf-8?B?Q09ZL1BSbGgzaVVUOFAvMGRmL2NYUkJITDJDSFZHYUFGcjgxekFyU1BmS0RL?=
 =?utf-8?B?T2hiR1V3SUlLVWN6RHpodWZPM3hRRURDdjdEY0ozaHR0ZEdqREVZanA0RjUy?=
 =?utf-8?B?L21PS09aZklubjR0LytQS1BZZTRhbDFGcUhTM2V0OUtkaG1jZTI1UnNUdEI1?=
 =?utf-8?B?ZWM0blFBV0tDZG91bTNRUUhTVStES0VtNFgzWHVNS3p1ZkhiTktUTGV3ODBM?=
 =?utf-8?B?ZkNGZEVGT00vN3RiTlJQK2NQK2lFT0VMVURGWWtRK0s5bFVFcGN6L2VYQk9W?=
 =?utf-8?B?U296cHp1VHZWUWwybEU4THJlMlNuTU5BdXVnZ2I4TGE4RzIrdWJScGxuNmF3?=
 =?utf-8?B?SVRoUHR2NExkOEY4VVBLK3RuQ09GblRVMjZNbUZBdzBabVBvNnVSSUE2NnRh?=
 =?utf-8?B?UFhjU3ZWZFJCZjVhbGxucXV4QXNBQXc4M0RCalNVRWJ2a3JqM2o4L3NKTmFE?=
 =?utf-8?B?bXQ3RFlURGNzaTBhOGJlYnZpb3RGWXRucDZoS2oyc0VmRFBMNVpWOXBpMzcr?=
 =?utf-8?B?THI4azN5eGkraWVDRG1VMlRpcnc2ZkZaUC9SNlRHeHpuMWVqa2dON0kxUngw?=
 =?utf-8?B?YjV5QThYSFp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A823A39E9970B4A815D62A8408DF736@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c680f5-9ea6-48a8-207b-08d9ff831e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2022 15:08:05.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNQS2kVkHDKZPZb6uIYafTnXy2BeH2eFVXtWJiuig5NCLCSu+0C1kfGr+N2xIewsGkF1P0+YvhEUSgs32eSksw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIyLTAzLTA2IGF0IDA5OjA0IC0wNTAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
Cj4gT24gU3VuLCAyMDIyLTAzLTA2IGF0IDExOjU0ICswODAwLCBjaGVueGlhb3NvbmcgKEEpIHdy
b3RlOgo+ID4gSXQgd291bGQgYmUgbW9yZSBjbGVhciBpZiBJIHVwZGF0ZSB0aGUgcmVwcm9kdWNl
ciBsaWtlIHRoaXM6Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqAgbmZzIHNlcnZlcsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqAgbmZzIGNsaWVudAo+ID4gwqAg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPiA+IC0tCj4gPiAtCj4gPiDCoCAjIE5vIHNwYWNlIGxlZnQgb24gc2VydmVywqDC
oMKgwqDCoMKgwqDCoCB8Cj4gPiDCoCBmYWxsb2NhdGUgLWwgMTAwRyAvc2VydmVyL25vc3BhY2Ug
fAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IG1vdW50IC10IG5mcyAkbmZzX3NlcnZlcl9pcDovCj4gPiAv
bW50Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAjIEV4cGVjdGVkIGVy
cm9yCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgZGQgaWY9L2Rldi96ZXJvIG9mPS9tbnQvZmlsZQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgIyBSZWxlYXNlIHNwYWNlIG9uIG1v
dW50cG9pbnQKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBybSAvbW50L25vc3BhY2UKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8ICMgVW5leHBlY3RlZCBlcnJvcgo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IGRkIGlmPS9kZXYvemVybyBvZj0vbW50L2ZpbGUKPiA+IAo+ID4gVGhlIFVuZXhw
ZWN0ZWQgZXJyb3IgKE5vIHNwYWNlIGxlZnQgb24gZGV2aWNlKSB3aGVuIGRvaW5nIHNlY29uZAo+
ID4gYGRkYCwgCj4gPiBpcyBmcm9tIHVuY29uc3VtZWQgd3JpdGViYWNrIGVycm9yIGFmdGVyIGNs
b3NlKCkgdGhlIGZpbGUgd2hlbgo+ID4gZG9pbmcgCj4gPiBmaXJzdCBgZGRgLiBUaGVyZSBpcyBl
bm91Z2ggc3BhY2Ugd2hlbiBkb2luZyBzZWNvbmQgYGRkYCwgd2Ugc2hvdWxkCj4gPiBub3QgCj4g
PiByZXBvcnQgdGhlIG5vc3BhY2UgZXJyb3IuCj4gPiAKPiA+IFdlIHNob3VsZCByZXBvcnQgYW5k
IGNvbnN1bWUgdGhlIHdyaXRlYmFjayBlcnJvciB3aGVuIHVzZXJzcGFjZQo+ID4gY2FsbCAKPiA+
IGNsb3NlKCktPmZsdXNoKCksIHRoZSB3cml0ZWJhY2sgZXJyb3Igc2hvdWxkIG5vdCBiZSBsZWZ0
IGZvciBuZXh0Cj4gPiBvcGVuKCkuCj4gPiAKPiA+IEN1cnJlbnRseSwgZnN5bmMoKSB3aWxsIGNv
bnN1bWUgdGhlIHdyaXRlYmFjayBlcnJvciB3aGlsZSBjYWxsaW5nIAo+ID4gZmlsZV9jaGVja19h
bmRfYWR2YW5jZV93Yl9lcnIoKSwgY2xvc2UoKS0+Zmx1c2goKSBzaG91bGQgYWxzbwo+ID4gY29u
c3VtZQo+ID4gdGhlIHdyaXRlYmFjayBlcnJvci4KPiAKPiBOby4gVGhhdCdzIG5vdCBwYXJ0IG9m
IHRoZSBBUEkgb2YgYW55IG90aGVyIGZpbGVzeXN0ZW0uIFdoeSBzaG91bGQgd2UKPiBtYWtlIGFu
IGV4Y2VwdGlvbiBmb3IgTkZTPwo+IAo+IFRoZSBwcm9ibGVtIGhlcmUgc2VlbXMgdG8gYmUgdGhl
IHdheSB0aGF0IGZpbGVtYXBfc2FtcGxlX3diX2VycigpIGlzCj4gZGVmaW5lZCwgYW5kIGhvdyBp
dCBpbml0aWFsaXNlcyBmLT5mX3diX2VyciBpbiB0aGUgZnVuY3Rpb24KPiBkb19kZW50cnlfb3Bl
bigpLiBJdCBpcyBkZXNpZ25lZCB0byBkbyBleGFjdGx5IHdoYXQgeW91IHNlZSBhYm92ZS4KPiAK
Ckp1c3QgdG8gY2xhcmlmeSBhIGxpdHRsZS4KCkkgZG9uJ3Qgc2VlIGEgbmVlZCB0byBjb25zdW1l
IHRoZSB3cml0ZWJhY2sgZXJyb3JzIG9uIGNsb3NlKCksIHVubGVzcwpvdGhlciBmaWxlc3lzdGVt
cyBkbyB0aGUgc2FtZS4gSWYgdGhlIGludGVudGlvbiBpcyB0aGF0IGZzeW5jKCkgc2hvdWxkCnNl
ZSBfYWxsXyBlcnJvcnMgdGhhdCBoYXZlbid0IGFscmVhZHkgYmVlbiBzZWVuLCB0aGVuIE5GUyBz
aG91bGQgZm9sbG93CnRoZSBzYW1lIHNlbWFudGljcyBhcyBhbGwgdGhlIG90aGVyIGZpbGVzeXN0
ZW1zLgoKSG93ZXZlciwgaWYgdGhhdCBpcyB0aGUgY2FzZSAoaS5lLiBpZiB0aGUgc2VtYW50aWNz
IGZvcgpmaWxlbWFwX3NhbXBsZV93Yl9lcnIoKSBhcmUgZGVsaWJlcmF0ZSwgYW5kIHRoZSBpbnRl
bnRpb24gaXMgdGhhdApvcGVuKCkgc2hvdWxkIGJlaGF2ZSBhcyBpdCBkb2VzIHRvZGF5KSB0aGVu
IHdlIHNob3VsZCBmaXggdGhlIHZhcmlvdXMKaW5zdGFuY2VzIG9mIGZpbGVtYXBfc2FtcGxlX3di
X2VycigpIC8gZmlsZW1hcF9jaGVja193Yl9lcnIoKSBpbiB0aGUKTkZTIGFuZCBuZnNkIGNvZGUg
dG8gaWdub3JlIHRoZSBvbGQgZXJyb3JzLiBUaGVpciBpbnRlbnRpb24gaXMKZGVmaW5pdGVseSB0
byBvbmx5IHJlcG9ydCBlcnJvcnMgdGhhdCBvY2N1ciBpbiB0aGUgdGltZWZyYW1lIGJldHdlZW4K
dGhlIHR3byBjYWxscy4KCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
