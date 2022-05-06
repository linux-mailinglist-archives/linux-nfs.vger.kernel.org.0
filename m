Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14A951DFF5
	for <lists+linux-nfs@lfdr.de>; Fri,  6 May 2022 22:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392639AbiEFUNQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 May 2022 16:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiEFUNQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 May 2022 16:13:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2109.outbound.protection.outlook.com [40.107.244.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3AD62135;
        Fri,  6 May 2022 13:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+9Zr7rc7M7+92/HtIH0x3jOUT26Ek/DCMhbYGrcZr4W1BuSBKz57RehqxkjkHFC1fc3BTkw0BunUE2b8UGZlzAwPZTzX0bXA0r7yZmVxrdbMTHauXb/E/WHxKVPPqMYrKtt/utWCpFUETadRM4H1xIliP/AxdgPNwujhNLDhuCjQP6gEBoDksEebyOtAonDBN0/Fum5vBG2cBfFmSnagvamtvVOwbDHfH64yk38V2ncyGIdf/65VisDpfTAhz0YgL7v9mSOQF4pqrq7V9aMqhxk1zCpO2HCMhZItpcpKBE03sBhZWp0y831pNxiI9HHW6b52l98HWn9yj0dh5Oyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcIebFUK57ySPjcpKD5ex7h4mQNUs5e0DuVklGyoyvU=;
 b=KFDHhLP4q8xhpwgRtBtkcjmO/Ceee4ErNRw6QjHYgo/7oZop9TgmpSUuFBGk8xvxFPBmlrTOduvARIxyXkK2dy6KwBok8Zd07wFPlr9yJULdLGdRIDY/thvFXxeF/9KftYpd3l+PIijp8IZ4di7+rMIpaa8rwmB0K+XAv74jIbblPEH2ohSLCAf1TJBfpYJNcPTG72U4U+335GqHOqb/EZeTeTr3EPkjxn/BSKJk0Rh5ZGliowr4BswAtrhuKnp31MBJH6iR7Kp0hbUtJ4dPRwbG2sTxZ7xJkimZFEpilEZ1VnxsQCBQQFiwoAF1sf8f5ADS1OIl4+C+rrM+DAgVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcIebFUK57ySPjcpKD5ex7h4mQNUs5e0DuVklGyoyvU=;
 b=Ek7Yu1wii6pH9LyL6PxVs8bFXOcuRyrb45zrOMn0nw6YIHlSBkJK2JSI4OiJ0Ki5XZ0EVlrJ+N9Lf+TXeNYEr2ivOuGyabCALoqGgovhBS9DhCyI9zGoXva7CqneQWdRrXtYItC9FOkJ3AB8oiuQRsZ0v32ij/wkVLHeoKldGzg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MN2PR13MB4133.namprd13.prod.outlook.com (2603:10b6:208:26b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.14; Fri, 6 May
 2022 20:09:29 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::694a:6bf0:4537:f3e5%5]) with mapi id 15.20.5227.014; Fri, 6 May 2022
 20:09:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client fixes for 5.18
Thread-Topic: [GIT PULL] Please pull NFS client fixes for 5.18
Thread-Index: AQHYYYUxycHl4UNcHE6ailYq3qDWyg==
Date:   Fri, 6 May 2022 20:09:29 +0000
Message-ID: <cdd6481d128894041e6251218a309ae9cfa15f0b.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfb45edb-d1bc-40ab-977c-08da2f9c53c7
x-ms-traffictypediagnostic: MN2PR13MB4133:EE_
x-microsoft-antispam-prvs: <MN2PR13MB41332DAAC822EC89BB062D3DB8C59@MN2PR13MB4133.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IHs5ecswGmUw3SclCnm3pzC31lVhQvrVXdNMsF4kGpWO5fFg9Fb8DhgKnir+tWdNNQ3vczHyXqUM+JkvRB54zDreT4DyLJMXoCXzv40XxwL/XKXQE+YcYGyzmUo/bQ8sjC/qQHvviOBEeAV5+ZyPw3dC4Mpo+SgWaIp6nQLpkLyczN1yfAa3JDgYtSA+qXzjHFIqi9CjyGsTYOlA5aeb1G7516AlirL/ByJUKVlt93DXxzfLtTzYeUtrMqt1lp1xLMJq5djcA/wjRkzx5VScGD4zzro4IeErm9zuL+FdrqAqE7A6MUEQmEXVDULUtwT6OOH+3NSI6ceg/cj2HoIrF2S7YFy05m+K+H9gyggForHibWvR4CUTawOERaT9Gd5l2zGQlP2YGrzUkzIPIRNuKg6+wgZUnJCQ2GQV/G8wKgPXyuZqKttB7v+EA8N2cqQpRv7Q69IGKUh5WEzPQq76B7D+gFvsdmWTZn3w/qd8HFxSivLQXnLlyF1NA2MZXDf5ME1/lI4sC7mhSbCFIZHNFh9k9TV0vuFEgZI7BUQnvOtUOJAcCRblv3tozkP1KhQlJdXejN2lvAlH/SsPlddEYvZSgtCVzv6XUc8xw+HqOpIJc1WohMdHeKwMq6xq45pG4HOgareSl7IYH4T8fywg8cMaLkAWCnO/JtMuNeO/l6hUjoAlh3VQQze9gQwgLZtzihO0QxoI7qlYVmLX7n6Rvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(366004)(39840400004)(346002)(376002)(6486002)(71200400001)(8936002)(508600001)(38070700005)(38100700002)(66556008)(122000001)(186003)(66446008)(86362001)(6506007)(26005)(2616005)(83380400001)(6512007)(2906002)(5660300002)(36756003)(4326008)(6916009)(54906003)(8676002)(76116006)(66946007)(64756008)(66476007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE93VE8rdEliSTVtekJqU2U5dERDQ3lJNmNQZGY5TWNMMHNQeEZXaDlCRHVp?=
 =?utf-8?B?T3ROaGFkNnN2NEthaUp2c3E5WWZZeWY4VTN1a3VlZStEbjNqT3QyM2FPQWZu?=
 =?utf-8?B?R1NNNE1BaHNPNDVxc3lKbVVudnhjQTN2ejF6dFVGVEpxNWZjNzU4NzBpTWNG?=
 =?utf-8?B?NmdjL0ViTVo2dTB0UStGaEZVbFZlY3piSjhCcjdYOGc2bmlIYlB4N09mYkpZ?=
 =?utf-8?B?SmpEbzhydnR4citYTUxqUkgybWJPbG5tOTh3NGp4TXFtOFBOdFBmRk92bDN4?=
 =?utf-8?B?RHd3aitVMVBxUlhoSlYzdEZYMklXcDhiTUZ1YXJ5cTN2YlE3OVMzeXhiNFo4?=
 =?utf-8?B?emNDNy84cG5hdzk1bDNjWWUvZkZJQUdaVXFkV1N3UVFhK1J1SS9mY3dMdEhi?=
 =?utf-8?B?a1V3SlNreHdkME52eWZ2dHFnN1IxTHZ6UTJNNEpzeFJBSnVwZlllR1d6Q2Rw?=
 =?utf-8?B?U09HN04rZlJkVDR0QTNkRVRQSEVENlpkY2pDRVh3L3BtZ3BISVZIOFpELzA4?=
 =?utf-8?B?dlpxRHZJRE5pZlFCVDZGUmpSUkFiV0Y2VUJnTWkvNzZWRXF3dlBJUzhIWWJV?=
 =?utf-8?B?b0xBQ2pHeitMcktPdmNDemtuaWhRQXBJbWovcFZDb1hHWE9aMFJsc2lGbkNC?=
 =?utf-8?B?SWFkR3Z3QU4rSk1MVjdqWjE4R3NzdlFHd1hDS241WEdramxackJ0cWQ1SWRn?=
 =?utf-8?B?bENGb3pkNS9HOStWUE1XRjllWUZzUlQ2TWYzc0luT1dWdDhiVlJvV3pkQmZ4?=
 =?utf-8?B?bmtiNnlyYWkwb3JMYVgwRjFQSU5NcHNvYlAwK0NkZnBWRkJKQ3N5ZGMzMm5O?=
 =?utf-8?B?Z2dxQ0Q1dldhZ2lVZHBUU0gvTjZYUDhIYkdqQ2VxTjJFSytrZXdISDVNRXQ0?=
 =?utf-8?B?UzNWdHRzaDdCMnpJd1FnSEp1ZUd3UTB6aTAvNDcyY0prcmNmSGUwN005bkFI?=
 =?utf-8?B?UjRoM2ltc1VKaGZEQmdoZnVLWW9saXd5MDdVL3drSmtDU0g4c3cxQXRsbnB3?=
 =?utf-8?B?cE8xYUdBTEtINlhveDRLZFpJQWR5bll1T0RNd1FwOGZndlhHMzdCYU5OQm5W?=
 =?utf-8?B?SHNXREdnaW5rY1JhWU9IR01XVHRkd1BpcFIvUUdsak1rV01FSDhUTEg4dnQ0?=
 =?utf-8?B?bGhJcWVaa0ZOam5nUDBQR3ZUSk5pNVROSFVvZS9nd0hMNGh0ZUh5OEJaRVc5?=
 =?utf-8?B?bjRHOTFoSnpTZzhKUCswbDdBZXFCeENCOE5McjM5Sm9nbjA1b0tIOGkrbEp6?=
 =?utf-8?B?QU5QeUtVRUV4SXJBYmpscGE4R0JJUTRCeDhla1YzTDFhaHlUOXR4eEh5eHc3?=
 =?utf-8?B?L21lVmRvMDVnK1hxTWEvR0VrRkVqMFRRVjViOVhoZ0xEZEc4MFdnTHZzN1VS?=
 =?utf-8?B?YmlDdXdDclNTTVM0Z0ZzVzJWUEZiUC95VEpZSy8vQlVsaGxaNE5vMzFnK005?=
 =?utf-8?B?Ty96NXZ6ZHkveXlLYXRlaitRcmtBa1lsaFVlT3BJTWVuSFBIRDZDYWE1V0Ry?=
 =?utf-8?B?VFZXaEF6bW4zZHhXWmJpT2JNN0o1NWEvWlNWSDViL1VlK1g0M1pxQVNzZUZ4?=
 =?utf-8?B?VXYvUFFIQXAyeVhIdHVObnd1d1oxWHNabGoxRTNxajR6QTFXNmhXdkRPRHNk?=
 =?utf-8?B?SUVUbU5zMHppam8rQnNORnAwRkpXY0FDMXc1U3pKaDlXMkYvSGI2eWJjeHpp?=
 =?utf-8?B?bzJNcFVueHdzK05adkc1cGtROHZpSWdLZjNtUk1LRU1BZVo4SldjampqZG8x?=
 =?utf-8?B?bHc3bmsrSTVLazdrdnR4VEdFSVJCZVpiLzQ2ZW42UUl0Q284d2dSQ084M2xB?=
 =?utf-8?B?RnFPRjhxS0h5SzRkbktDK1ZWTWJScGIxRzdKaGZpbDZEMm56TC8xTWt4UHhS?=
 =?utf-8?B?ZXplNGhKVURKMFpWbTYralBreUd6b1ZiZktHWDJneWR0bGMyUHdzVXB5cUNn?=
 =?utf-8?B?QnIyOS9VWjY4RVVxRjFEaUYvbWJ4L1V4TGpub1BZTy9sZC9ReEt1cTNtTXF1?=
 =?utf-8?B?NmRnNFNRZ2FlMGsrdXowR3BtZDZHS2ZyQ21nNXI0ZDNRWHE2WXlROUxuQTIy?=
 =?utf-8?B?VGdKRWZBQmRwUlBwTnRKMnlMMEtYWmJLcXFXd0wrU3FRT1QxbmtpL1pzQThq?=
 =?utf-8?B?NVNTQ2tBNitaS0lVcUMrZ05TdlY2SnlCT0x0OGlvSHlGYnNIcUtBRlQzVlJh?=
 =?utf-8?B?ZDZ1ZFNCMTJqVnloSVBNb05qblMzQ1BTdGxVRGIwSXZCTit6VFVXMXJ5c1Iw?=
 =?utf-8?B?OXBmWmRvbmFRRlFBUUJKTGZlcGJUVjN0bDZ0MUtQY3h4eTNFQVoybDQwb0Vj?=
 =?utf-8?B?clNhdC9yUW9SK1ExdVMyL1h4RTdScWE5MnBldHNLQVYxTm0zRjFucW8zS1dL?=
 =?utf-8?Q?dmfYu2y0l4wzonRc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A91B82A847355F498EDD749A3555DB01@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb45edb-d1bc-40ab-977c-08da2f9c53c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 20:09:29.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3gUMmBANZHYb690ne8co6mkwVF7n3KSwo1SqWPmveuge+usEA8HngIIcvEToG2hxldEy5c05F4UgvU2zXHOmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYjJkMjI5ZDRk
ZGIxN2RiNTQxMDk4YjgzNTI0ZDkwMTI1N2U5Mzg0NToNCg0KICBMaW51eCA1LjE4LXJjMyAoMjAy
Mi0wNC0xNyAxMzo1NzozMSAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9s
aW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci01LjE4LTMNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFu
Z2VzIHVwIHRvIGEzZDA1NjJkNGRjMDM5YmNhMzk0NDVlMWNkZGRlNzk1MTY2MmUxN2Q6DQoNCiAg
UmV2ZXJ0ICJTVU5SUEM6IGF0dGVtcHQgQUZfTE9DQUwgY29ubmVjdCBvbiBzZXR1cCIgKDIwMjIt
MDQtMjkgMjA6Mzg6MjcgLTA0MDApDQoNCkNoZWVycywNCiAgVHJvbmQNCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTkZT
IGNsaWVudCBidWdmaXhlcyBmb3IgTGludXggNS4xOA0KDQpIaWdobGlnaHRzIGluY2x1ZGU6DQoN
ClN0YWJsZSBmaXhlczoNCi0gRml4IGEgc29ja2V0IGxlYWsgd2hlbiBzZXR0aW5nIHVwIGFuIEFG
X0xPQ0FMIFJQQyBjbGllbnQNCi0gRW5zdXJlIHRoYXQga25mc2QgY29ubmVjdHMgdG8gdGhlIGdz
cy1wcm94eSBkYWVtb24gb24gc2V0dXANCg0KQnVnZml4ZXM6DQotIEZpeCBhIHJlZmNvdW50IGxl
YWsgd2hlbiBtaWdyYXRpbmcgYSB0YXNrIG9mZiBhbiBvZmZsaW5lZCB0cmFuc3BvcnQNCi0gRG9u
J3QgZ3JhdHVpdG91c2x5IGludmFsaWRhdGUgaW5vZGUgYXR0cmlidXRlcyBvbiBkZWxlZ2F0aW9u
IHJldHVybg0KLSBEb24ndCBsZWFrIHNvY2tldHMgaW4geHNfbG9jYWxfY29ubmVjdCgpDQotIEVu
c3VyZSB0aW1lbHkgY2xvc2Ugb2YgZGlzY29ubmVjdGVkIEFGX0xPQ0FMIHNvY2tldHMNCg0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KT2xnYSBLb3JuaWV2c2thaWEgKDEpOg0KICAgICAgU1VOUlBDIHJlbGVhc2UgdGhlIHRy
YW5zcG9ydCBvZiBhIHJlbG9jYXRlZCB0YXNrIHdpdGggYW4gYXNzaWduZWQgdHJhbnNwb3J0DQoN
ClRyb25kIE15a2xlYnVzdCAoNSk6DQogICAgICBORlN2NDogRG9uJ3QgaW52YWxpZGF0ZSBpbm9k
ZSBhdHRyaWJ1dGVzIG9uIGRlbGVnYXRpb24gcmV0dXJuDQogICAgICBTVU5SUEM6IERvbid0IGxl
YWsgc29ja2V0cyBpbiB4c19sb2NhbF9jb25uZWN0KCkNCiAgICAgIFNVTlJQQzogRW5zdXJlIHRp
bWVseSBjbG9zZSBvZiBkaXNjb25uZWN0ZWQgQUZfTE9DQUwgc29ja2V0cw0KICAgICAgU1VOUlBD
OiBFbnN1cmUgZ3NzLXByb3h5IGNvbm5lY3RzIG9uIHNldHVwDQogICAgICBSZXZlcnQgIlNVTlJQ
QzogYXR0ZW1wdCBBRl9MT0NBTCBjb25uZWN0IG9uIHNldHVwIg0KDQogZnMvbmZzL25mczRwcm9j
LmMgICAgICAgICAgICAgICAgICAgIHwgMTIgKysrKysrKysrKystDQogaW5jbHVkZS9saW51eC9z
dW5ycGMvY2xudC5oICAgICAgICAgIHwgIDEgKw0KIG5ldC9zdW5ycGMvYXV0aF9nc3MvZ3NzX3Jw
Y191cGNhbGwuYyB8ICAyICstDQogbmV0L3N1bnJwYy9jbG50LmMgICAgICAgICAgICAgICAgICAg
IHwgMTQgKysrKysrKysrKy0tLS0NCiBuZXQvc3VucnBjL3hwcnRzb2NrLmMgICAgICAgICAgICAg
ICAgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KIDUgZmlsZXMgY2hh
bmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
