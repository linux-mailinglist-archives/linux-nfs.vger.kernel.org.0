Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A144ADE98
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 17:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiBHQrQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 11:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbiBHQrP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 11:47:15 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2090.outbound.protection.outlook.com [40.107.223.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA85C061576
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 08:47:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0+QW68zklC83I18Dpt3NP4BiSNINqwPRcRwP3fQxwsVrHQbV9o4DS5t94y4DywOiUAAdKcXe855qPXO3UwzwObT0trFVIpRGb/QV6Dkwu8KFAlLPSvYd2GvFzJKfFMZxpQFwhSfpbEt+tTQhoD9ZPC7RzdyqiaU11UhT8IkD//wZ3WQs1p0w5ye+y6F3JOhlrrIM0YgbuuxvfIqYx3XKLsNBt6xc0enUHBpzKqAM9b96DeWRz441Cay6wJgb1L+INIwG3O/A99h8qQKgCJka4DG237LyweldyX96Ba/W0B3GKqcTif2GEpGZtObaxEsJZ7JArfNOczrJFdJhzr04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ6Lm15rmeAfBvCTG7Pk8D8K6151DgDBni/aQk7LNEM=;
 b=SuOKqb0gn6BnMPULpTS+UaKw3jT2oS4BtA21dOUlyAv5rqyF+e9Xt3NpqpFQ7qwFnvQ+qmdGcegVgm6NcA6QHS2RyqOCs2Lyy2hpqUoAFU4K7ommw21zMOQZn95piXkreK5E0MJfb7MEYQUwSijp9BhgPfRoNKS/fYq01LBKVplDe2rKXneB1cU2NBsgkX0JXm2b5aKKGxjlWd6ZpOXtQFbEXXGSWiyRJ8MZl0SpNxsA4GYgkgR+48TYrEyZ+Ho45ZKO5L1fjF0Gax4MCbq8e4dEIaZu+Aub0kHbYNZsx8ObyffS50HnDH4rehAc3eT+bfk8+g8zFCCUfgAzEdclGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ6Lm15rmeAfBvCTG7Pk8D8K6151DgDBni/aQk7LNEM=;
 b=ViUNo6YwBbeb+/eeZkX/iwCRLSH71TjkUkQQz47AHQGcpGu3eAC78Ogs2FiKMB+tB0YN9QXUxlISHy3uYyTYVg24ZlhbfW/NnztNhaQkHHqjtecJh7wRcJHgHc8qmB+19kkuAF7fsfpQv1rGnlfBYM7YqNEfqWqy9JCGNmvD/VU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CY4PR13MB1672.namprd13.prod.outlook.com (2603:10b6:903:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 16:47:09 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::21ea:8eb5:7891:7743%6]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 16:47:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: v4 clientid uniquifiers in containers/namespaces
Thread-Topic: v4 clientid uniquifiers in containers/namespaces
Thread-Index: AQHYGqGY+wEK6KvlxECYW5WP2WwW2KyFReGAgAAYO4CAAsQQAIAAHRgAgAA//4CAAEjXgIAAwaaAgABYAQA=
Date:   Tue, 8 Feb 2022 16:47:09 +0000
Message-ID: <573bd3329d0dc2f73986d4c2cf3060c0298ac970.camel@hammerspace.com>
References: <6CEC5101-0512-4082-81F8-BDFEC5B6DF3A@redhat.com>
         <6ac83db82e838d9d4e1ac10cb13e43c5c12b2660.camel@hammerspace.com>
         <439C77F9-D5AD-4388-B954-3B413C1DF0E2@redhat.com>
         <596C2475-76AA-4616-919C-9C22B6658CA7@redhat.com>
         <DB8B60C8-B772-4604-A841-47F789723D5D@oracle.com>
         <b192022ce73ea690a117d7710b492e83be99df31.camel@hammerspace.com>
         <43990B9C-013C-4E77-AADA-F274ACBE4757@oracle.com>
         <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
In-Reply-To: <8CCCD806-A467-432C-B7FF-9E83981533EF@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40fc3f5c-1c7f-4afe-5ae2-08d9eb22a5e9
x-ms-traffictypediagnostic: CY4PR13MB1672:EE_
x-microsoft-antispam-prvs: <CY4PR13MB1672110AFD496990185245A9B82D9@CY4PR13MB1672.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TzyKE3cZFE+RboSt8TXwnL/J+eK7CQ3rGbCn4tnazBkF19Nj14+hS168BdfLSclqZhNjgBbu8DMpSeOEDrKqOMU38T6shSwYiWq9SBWXStQ//klhNIGMIzwanDl0aUm5iZL05X4J9j5xIPDSO884AroENuohTily2Ck+HLn85kdJX6kbu6pIeJI9QvpH34QicVTQIKcvIz7tVOTQPXt5LuQmyQt06+Pd6Oc3wRxT8DCn8HvysXEbpCwqSdESNa7/tj/kNu67s0C7fQrRIa1JTVZ+XdZDqGFK7KHYK3SUmn4ZvsKjWY+rqkI0TXfFTZ5XpZsUMLAfzU3ube8Y4DSSGRhyS/XVhFa6366+NxOkirixUk6K0YTB0fSXiUSPkG9N3rTW4uwQYwBFrbawFPogKOmo2wNPayZhc6TpFH0S8+uGqmcbdyOtxgT5h8M5B801v8/O4VtTjHEYQAjTQXto/qgSFfecS+luQePcpGyW+w5o55EHYzFtxv5VzuYloPU14YSwGYCJ6HdvnV513zHsVIQG/yEmPS+Zz/W9xaGo7kCNoxYM9fDWH/H6G7aEfW6hoT2pghGrrLPSljg4FbWqeq83miiS+PJmw3Y5jMqMJgAKW6Y6/RBT//skUWc3wa71e8PwfBvUN0ZHa+BdWnXmRBtVv134aLHkEqtkaMazCAuLO/Yd1cRGHKu2SLQXx9frEQaB5gBFKOj/fa8SmZqDQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(71200400001)(2616005)(6486002)(26005)(186003)(66946007)(4744005)(86362001)(8936002)(2906002)(38070700005)(122000001)(38100700002)(110136005)(76116006)(316002)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(6512007)(508600001)(83380400001)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG1EeWYrZTBkTElHNE1jZTN0MkhaMlFhUVB5YnRXdVFqSUl4QzV3aEYwMkZI?=
 =?utf-8?B?b2NRNEdlMVlYR0xnQzNySDloTE1hUzFEWXNiSXNEWEQwcndrcHIrWGUzVTNX?=
 =?utf-8?B?ZFN3UWQ4ZDAwVVFjUFdudVFVRlQvaVhqRmxjcWlqWVFCeUhDN0laeEtmWita?=
 =?utf-8?B?Njg0WUVQTnFvZ3psVGVzM3lkOVRHOFJFVElOMGF2aE1lMWQvK2kzcFJvR2Z0?=
 =?utf-8?B?UVc5azYxbHJwcTJLaTNjZlowSFRET0VEUVA1MjBMUUQwSnNRbnlpU2NUZ3lC?=
 =?utf-8?B?M2YyQlc4MmM0RHBydW81WldnMG45ZjNTZDJSMHV3cVhGRmplR21obmtsU056?=
 =?utf-8?B?d015aWt2NlBHZWFUdFpBWmFLc2RMRXAwU3ppcE5pVUQ4Mk5ydWZobThFekx2?=
 =?utf-8?B?MDBmV05OY2xtWE1WU2V3NkJWNDJCSWVSRC9GZVZnQ0tkVUp1QjA5QjdseVh2?=
 =?utf-8?B?MjArNGcrUUJFVVkzZ3ZDeEh1eU5TVUt2L2NTN09ZaldDa1l2RXBkNENiRk1P?=
 =?utf-8?B?WWxqUTA4dnBPTU16NzdFbVc5bzdrNlFvK0pTM0ptOUZwQ3pjbkN4NXBydkls?=
 =?utf-8?B?VERXL2VjMXpIR0ZDVUh0M092aHh4UWJ1N3J2bm96M2E5Z3BGWDcwdjBSUnNl?=
 =?utf-8?B?ZjNRa0dacUVGMlgvb0JqRFcyYmJQSzRlbVpCN2VDRk5QWjNFTUFoZjdUY2Fs?=
 =?utf-8?B?WlNqL0FyOWdPc1RwUWdDRXVCVElXcFl4YjEreHlMdzFJSnM1bUtQek5Nb3BU?=
 =?utf-8?B?QTNRSEhQS1NaQThDMWZLcG9DM2tlNHI2NnE0Y0IxbGNwTVFWSVNKWktIdTRS?=
 =?utf-8?B?THB0ZlgySmFITERkc1l5a3RzdEt5dlNKQWcwZFdQZFhMNEErSlgrRWl5ekRh?=
 =?utf-8?B?MVlxL3h4ajVYMEZTM0ZVbGVmRjBseDI0ZW5NVmt2NXl1a20wY3NxbmU2a1Jj?=
 =?utf-8?B?dlAyaVc5T3A5R2VvZStiZHl5Qk9vRmdHWnNXNGRaU21DMzBzdXJDSWRBYWNv?=
 =?utf-8?B?N29oYVdTQXhoVGMrNGx1VEhQQ1RMWGNyYnlQOGwyRHVKRnlsdExIcHZqL0wr?=
 =?utf-8?B?cHdNL0tSSE5nSHU5S21NamhTTXRRMkFDTGh6RDVTQnNHN2MzS3JrQjNSUmxu?=
 =?utf-8?B?d0o1VXRodjdEejA1TjJKT2JRZ0REQ1ZsSDBvTXpiNk9Jcm84OGZuQnhqZHFi?=
 =?utf-8?B?MlNaZUdvSCs3SVFHQnZ6MzYwRHluRWQ4ODZOdWs5dlZNTWM2WG5KZEVNN00y?=
 =?utf-8?B?STRmRFFUU25qTnlrZG53M0FGSHhqQmE2aTVoSTlwbVN2ZWl5TUczWUE3TGVY?=
 =?utf-8?B?M3VYNCthZGZVYU05M0hRMFVHakJsL0FVbVVQaXVlYU8yMS9KMU1sb25aTVUx?=
 =?utf-8?B?VUw4aTN0Z3pCVWNRd3Z3TUlkQXNWNWFuNWdNams5UEc5WThRYnRlWVBmWDMx?=
 =?utf-8?B?YVFKRGpFeU5WSU9Qb0JMaXp2REpCRU9CbzBZeHRHaC8yVU0zcnJZZUUrNFlP?=
 =?utf-8?B?aDJTVnMzdXEwcFNkOExkRjVwbko0azgwaEUxMUcwVHBJOTlhMGk0a1VrWnNz?=
 =?utf-8?B?SVpUQ2FWQVNkU0JrNXcxNkJGcm01dHdiVnFGemJ0UmlnTmdhZGZ1RU80bnl4?=
 =?utf-8?B?Q1pSTXBXbyswNHVNN0F1ZURnUyszcStkRDJqMG9OeUFVcllFZnBQTzNSY2g4?=
 =?utf-8?B?V09HT2RCVC81TnMrdm1MdnA5YXE4OWRmZi9tS2JQaVVKV2xSMk5LelgrMGEr?=
 =?utf-8?B?NGNjUWJGcUgxQmEyVUg0cWhiL0lCa0NOWUpiR3BkOGl4ejhMWWVSUnBwSUlP?=
 =?utf-8?B?N0czNnRValFId3hlRUt5U2QxazRyamJGc1dJS3FGM2UveXZNQ0RlbVI5WjFq?=
 =?utf-8?B?TXZNQzJ2WmJnRVNFVzB3T3p2eVphSnd4TkthMWhQU3ZnVDFlZm9rOEtPY2tz?=
 =?utf-8?B?cjA0ZVJqM0Foang3cXBYSmV5LzRYbTdYKzMycnh4R0o1YnJxeGdNWkVoQzA3?=
 =?utf-8?B?SXNGN094bWMvTlk5bHc0KzVBbXEvMjBkNUoyRCtIb2trMWFTeE9nR1BkN09h?=
 =?utf-8?B?Z2E2TStZdnQwcmNKTC9SNGI5RW9RMW1ZeHYrVk42M2NUSlNTb1JWa1g0a1hF?=
 =?utf-8?B?bldqY3FJOThRaXNIN3UwMkxwM3FBcDlvQTliWHNGcVRCOEhpUDl5YnRvUVdH?=
 =?utf-8?Q?iPvWBe4/cIbyqjTY7R0tGO0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DA17F95F23CF34287565BA863AA536C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fc3f5c-1c7f-4afe-5ae2-08d9eb22a5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 16:47:09.3634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTXepm825dxfNY+oEfzV6hZGLNAs4LeOQc57BJnCz9DQeY87x91o7cQrvIqCeYgOovNL97FAdxy/9iQMqnwYqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTA4IGF0IDA2OjMyIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiANCj4gVGhlcmUncyBhIGJpdCBvZiBhIGNoaWNrZW4gYW5kIGVnZyBwcm9ibGVtIHdp
dGggMiwgdGhvdWdoLsKgIElmIHRoZQ0KPiBuZnMNCj4gbW9kdWxlIGlzIGxvYWRlZCwgdGhlIGtl
cm5lbCBub3RpZmljYXRpb24gZ2V0cyBzZW50IGFzIHNvb24gYXMgeW91IA0KPiBjcmVhdGUNCj4g
dGhlIG5hbWVzcGFjZS7CoCBJdHMgbm90IGdvaW5nIHRvIHdhaXQgZm9yIHlvdSB0byBtb3ZlIG9y
IGV4ZWMgdWRldg0KPiBpbnRvIA0KPiB0aGF0DQo+IG5ldHdvcmsgbmFtZXNwYWNlLCBhbmQgdGhl
IG5vdGlmaWNhdGlvbiBpcyBsb3N0Lg0KDQoNCldhaXQgYSBtaW51dGUuLi4gSSBtaXNzZWQgdGhp
cyBjb21tZW50IGVhcmxpZXIsIGJ1dCBpdCBkZWZpbml0ZWx5DQpwb2ludHMgdG8gYSBtaXN1bmRl
cnN0YW5kaW5nLg0KDQpUaGUgbm90aWZpY2F0aW9uIGlzIF9ub3RfIHNlbnQgYnkgdGhlIGFjdCBv
ZiBsb2FkaW5nIGEgbW9kdWxlLiBJdCBpcw0Kc2VudCBieSB0aGUgY2FsbCB0byBrb2JqZWN0X3Vl
dmVudCgpIGluIG5mc19uZXRuc19zeXNmc19zZXR1cCgpLiBUaGF0DQphZ2FpbiBpcyBjYWxsZWQg
YXMgcGFydCBvZiBuZnNfbmV0X2luaXQoKSB3aGVuIHRoZSBuZXQgbmFtZXNwYWNlIGdldHMNCmNy
ZWF0ZWQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
