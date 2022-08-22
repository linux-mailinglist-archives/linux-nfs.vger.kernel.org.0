Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367F959C533
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Aug 2022 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiHVRkz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Aug 2022 13:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiHVRk2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Aug 2022 13:40:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2105.outbound.protection.outlook.com [40.107.244.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6F41D32;
        Mon, 22 Aug 2022 10:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmY0pskAXsYIX2E8oWVLRfw4NESzu3ck4n9EO8429U++j7rixglOw0vTNMu+OEW8TPR4MaPkxUyrgUNEgPT63a2DjXVswhluHNMt1J70UFaOJjZkRwXQtm3L1upcn3dxhLlUFr0kh8+MylDIFTAVV7eC8reJoNEopHCVvOG+jP00I42teSZugM6cnc5R/ceAhH0qeAUnNF0f1xsrDlId95DWbq9Kr8UccU7kJ+FAqx/1phgq2I8yTB7iagzCcObU21WoiIphJc56AIGKRqfXxmEq7Mjb6JLJdU11qFzDt4GzfpVNIJYoEqGbBGxfD9wJWdswT4kBjM1tMBUi7LiogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yudIKHJHjsXYgOJqdINAHDLn0I26trScwOLW56WgzZQ=;
 b=goLX6djQouwNIrd9kG6Gy0ImTlwLfsFfgx9b0PpgKQFtNynE3yKXYucE+wNOvRQRvz33pPIsLzUh1cJMNpz31iBY/c25s1wpozyL7X7Fb0iQIsX7FBBV+hnOW+sr8jX0CmRx8ZA0/wkvsjgmfjGSSAiE5qUP8wWYbwDM1ce5J9XrY4y58GgDcQY1Nwgwl7VBeVKqVsHaMUE/bJnMFVR+q6BZwODDFkhQle2vyN4gtZg3QVEdbKJQNjj3owetx1lwtf93BkZbKMAz2n1x4rXANGhogiB/deI/PM1UREQRmhfCnGhWW1YslVN/GZhaiNym+0YjbCqO3pJSJBl5Z4syfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yudIKHJHjsXYgOJqdINAHDLn0I26trScwOLW56WgzZQ=;
 b=OxgfWcd8AE+EoMUv7C9aVYSUVlldBmhcRKDJyedbEn8WT0pTibUCueNIZKsijMvIo4UKRE95piY7TGJaNGWcFuSSjsuaYCYx3JKl0fTkNiIRcI+y8b68RnF8vIrF5oufCeJXEOCJMRkqNxd7Yrp7nPVU/MGXL9+qUDPGSh61K14=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BYAPR13MB2856.namprd13.prod.outlook.com (2603:10b6:a03:f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 22 Aug
 2022 17:40:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5566.014; Mon, 22 Aug 2022
 17:40:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for Linux 6.0
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for Linux 6.0
Thread-Index: AQHYtk4+N/24gzQg2E6+a5mlu7hgYg==
Date:   Mon, 22 Aug 2022 17:40:18 +0000
Message-ID: <b3717e756e8360d0f8ccb70a9b13b4cd9d503a8d.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b776113b-47ee-44f1-8ceb-08da84656165
x-ms-traffictypediagnostic: BYAPR13MB2856:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8RjZwgxhyEAspEXCFMw6C7gimmdJCSEIUR+JNjycDoKtJUpRTUxnLmcPZJCcznaYl4Tw2Hicp6txrXC53vnsF1IDRSATZ2AbC24e5rHBljAjL1E8VJ7gC8OYOI/YeAn0+iqiPi/bOVnOkAraFzJvZt/KM8q6IFxCrrEmvAklEWsoM/MHSbBz6sm6Mxr75kmfgX9NF+8KzxmvJ+1HrtaE0dAIam7/UEUQYVPUqP3sazacX3mJVn9ArZtlgZgb+LADoeoX2IFzfqFN1+Cz9sBE+kJxYpOahngzfGlrjiMc+em+Ol+p/UvKLaanmrrOPK/PofrdYuYbxbgW8aN7pai7H8R+q5BPNQPMDEkkcWiZHQ9Ce5NKoI3CtVA9qU9C4wtrd6Cs4uXdfDIE8EWmKMdQ0iDWWU6NxPOsokmrvPrn23PwC1woWjpByfZptIxg1cKH9FbklqSHsCvJoZIi/ZItnkduul2JP5lJJ1cVvFYlr6NXT5V6AQFR4hHYyPOZSjzcwKdpTpfxga3/o0z4I8G+atPtvZrsl/DYQbC1wSSFtJyDsgzsFZ07q1tijfKyExW3Va4LfFoiizm/Nf2SafUryBNKR8LeUYJR2BAscSW7M3pYRCxDXS6VEnV7KTQlxr1LDHgm5nibWhsfwpVqtIzhW2aq4G5/aQ1x3jaBESXayZtlvc+QUKnt3pyhZe2Is3q/y2bpA+382uIX+XUMD8WmUDFGdvT8YCmfRYdMst5CpLIZXi5oNWkxEcmFdXju3PjJtuzkjUJhr9ydlcfeUCYLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(366004)(136003)(39830400003)(36756003)(26005)(6512007)(6506007)(86362001)(71200400001)(41300700001)(38070700005)(186003)(2616005)(83380400001)(478600001)(6486002)(4326008)(8676002)(66946007)(76116006)(64756008)(66556008)(66476007)(66446008)(54906003)(6916009)(316002)(38100700002)(122000001)(8936002)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckVPN2dPWFNGNGliQ2J5dVlaMXlyRFR5ejBZRTJQNHVJOFlwNE1kR2RNUkNB?=
 =?utf-8?B?ajE4T1lhbG9vcHFzOEtTL2JYaXNQc2dNVGxSL3pBcmVGajVPekdHcmJLb3N4?=
 =?utf-8?B?VDl2ek96TUtUVUlSRmVMTTU0SHVBb0xoWFBDQ3BuQmYveFM2SG1XVHNSK3V0?=
 =?utf-8?B?ZVpOajZPR1g5TG5YMkozcHFOMjYvMHRyN2dVa3hWekdiRHJIMytPSFhFa1hr?=
 =?utf-8?B?OGdvZ1dhdE9Fc1RKemZCUWJlRVc2RE91MGVHNmo5ZHp0N1BhZG9aR3BDSy8x?=
 =?utf-8?B?WlZkNnVZdFV4LzA4RzJBWDdKeEtZZVV2Q1lCRkJFOU1ka2JnbVI3NnlVQ3FW?=
 =?utf-8?B?QnFyYmJweDA1eDlBWnVxaittQkVQdnNtZm1iMGdSNFR5WnZ1cmI5N2N6dkJB?=
 =?utf-8?B?L1lJYU9mOWYwZ1NkOTAxY3FpdGhBYXNhUDc2eTBJeGVqL09hdG94RG9Qbnlr?=
 =?utf-8?B?OVdDbDFqRXI1QXFiUkpabUhqVi9wbzVwZnlWZUNGVENSTGR4czlSaUhBVHBw?=
 =?utf-8?B?M2MyY1B4K2pUUURoMUFELytwYkUvSWNHeTFaMnpRWHY5c3g3aGlXWjAxN2hY?=
 =?utf-8?B?T2swVTczNVhUVk5uRDBwZFJYK1g5US8xQ3ZtWGdYelR6Uk9LaTFwQTRsSmdV?=
 =?utf-8?B?T1o1eDhuU2NIbjQreGhiaWlmY2UzZU42b2xmTXI5NkI5SFBNM3hHcC9ocDY5?=
 =?utf-8?B?SWd6VnB3N2RjK0hrSjZTQjJvenZXSFF3Z3BCTlV0K1Q2bkc1Qkk4bUl0RUZ2?=
 =?utf-8?B?RTBYRVZpN0JTSVdwTEtOaSs4ZU0wbkJqSVNQc2NXUDRDMEdiYm56WEl4M0ph?=
 =?utf-8?B?U3RtZmhKeGsyRDc5OW40M3l1QnIydVExQ0NJZU5hZ3p0UnFLNlgyemsyL2Rn?=
 =?utf-8?B?UGwyOUxMQVBUM1QzYXFMQlBYaEN0R1ZXaUJna0dIZEljYUNJM3kxb2lpMldO?=
 =?utf-8?B?aW9Rc2JIQW44RzVEZHFkL1FuL3lxZ1ppYlhEelNPV3U2Vm5PS3NZcS9QMmpa?=
 =?utf-8?B?SWt3V2I1RjNENHZYU2hJRS9FZnlMcnBOaHVSZ1dlSk9DYWFJbnVzZG9EQXRN?=
 =?utf-8?B?UHVLUWFINHkvVVRhZGVBV1l5bjljLzdBMS9nUVd1WmNMQzdkOE1uR1Z6ZTlJ?=
 =?utf-8?B?bWJQSXlHT1RvVTZ0VW9yOWZPNTRVQWh5aEw5ZnhManpWa2Y3d0U2Snd3WHpz?=
 =?utf-8?B?b0VGMlVteHhzUXdSTlNKM21vUTY2WkYrSVhRcG9vcG5kM1RtYlYxdmtxOENK?=
 =?utf-8?B?NTJtdk9DT0V4TzVBZEh6Y0Y1NEVUYUJ4a1pqTktwUHh3N0RHWjJlODBXNjF3?=
 =?utf-8?B?NU9HZERyM0dpQjlDaVA3Zi95akMrSGhoL3pPSTBCTUR6V2dPZTJkZ0FrSElt?=
 =?utf-8?B?V3VRWjJ6Y0Y0cjd1SDRlNzZTRnZXN3Z4YTZmOWVRNWVoQnNqT2pOUzhhZzV0?=
 =?utf-8?B?cmdjaU1xZXJKaFE5NFlhakthOWd0STc0akwrVFp0WGw3dmY4cXplUzJuWWlG?=
 =?utf-8?B?RitML0NQWnJ6czRHU3hUTEd1aEt2bS9XL0JhS2xkT0R6bnBSVHcrVHpBNC9p?=
 =?utf-8?B?M2dhUUhGZkxGemhEMjhxd0sxRlhOWFpENUFCNG94WXBKY0pqMGpmTVV4UGtN?=
 =?utf-8?B?ZEcwQ210cVhZZEVlRkV6REozbHM2YjBQTHlIa2MwYjA2am8vdE53UzVQUGo2?=
 =?utf-8?B?U0tYdmErWGVWejZOYXJkRFdOUzVVeVFsZUhzdmZGQVpDYlc0RGFvekJvd3FK?=
 =?utf-8?B?UG1jbDZGVnczVnJLYWtMcFgyNzN6NFZ0MHMwc201TTdKQ05tVlFZb0pTRzJr?=
 =?utf-8?B?bTNFRGQwdC83M1puYW42MkFDdmNhekhBeG5SQnZCRkhUU3k3VDZLUU54L2RY?=
 =?utf-8?B?RmVHM0EvcEl0NmVCNjBYS21yV29MM1RlU0UwTVY2eUE0RjhtVVpyUmJvZVZn?=
 =?utf-8?B?UFlrL1hlNEtBamg4QnpRVHhucytaa2tzMFE2OVBvcGQ4M21DYXk0VmQ2Y1Rl?=
 =?utf-8?B?YUFoUWNBQTA2a3M5NmFmZDFhbjN3V2pRU1cxNkVCSFkxZnNROFBVcWxKOXRs?=
 =?utf-8?B?QWljZ3pSYTNTSXhNMXFjYUU2S2VsM2p3U3ZFRW1uSDZwOGVaQzVBaW5sZDlY?=
 =?utf-8?B?UFRvajhiK0ZFMkFCNHJxQ3dDdFVsdXphOXdLbWhCb0JlRi9ZSVFvWWFZMEVX?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <817F7D0CE60DE74594EAF0469C3AC4D8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b776113b-47ee-44f1-8ceb-08da84656165
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 17:40:18.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHMT2MG2wRAO3YmW2+ZIkEflfiGwmyiW4vYB1z41Fs36dIFmhar+MkAW6uExM8rptOlEc00U0KyI0IgPHQHLsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgM2ZhNWNiZGM0
NGRlMTkwZjJjNTYwNWJhN2RiMDE1YWUwZDI2ZjY2ODoNCg0KICBORlM6IEltcHJvdmUgcmVhZHBh
Z2Uvd3JpdGVwYWdlIHRyYWNpbmcgKDIwMjItMDgtMDkgMTQ6MTE6MzQgLTA0MDApDQoNCmFyZSBh
dmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdDovL2dpdC5saW51eC1u
ZnMub3JnL3Byb2plY3RzL3Ryb25kbXkvbGludXgtbmZzLmdpdCB0YWdzL25mcy1mb3ItNS4yMC0y
DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBlZDA2ZmNlMGIwMzRiMmUyNWJkOTM0
MzBmNWM0Y2JiMjgwMzZjYzFhOg0KDQogIFNVTlJQQzogUlBDIGxldmVsIGVycm9ycyBzaG91bGQg
c2V0IHRhc2stPnRrX3JwY19zdGF0dXMgKDIwMjItMDgtMTkgMjA6MzI6MDUgLTA0MDApDQoNClRo
YW5rcywNCiAgVHJvbmQNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTkZTIGNsaWVudCBidWdmaXhlcyBmb3IgTGludXgg
Ni4wDQoNCkhpZ2hsaWdodHMgaW5jbHVkZToNCg0KU3RhYmxlIGZpeGVzDQotIE5GUzogRml4IGFu
b3RoZXIgZnN5bmMoKSBpc3N1ZSBhZnRlciBhIHNlcnZlciByZWJvb3QNCg0KQnVnZml4ZXMNCi0g
TkZTOiB1bmxpbmsvcm1kaXIgc2hvdWxkbid0IGNhbGwgZF9kZWxldGUoKSB0d2ljZSBvbiBFTk9F
TlQNCi0gTkZTOiBGaXggbWlzc2luZyB1bmxvY2sgaW4gbmZzX3VubGluaygpDQotIEFkZCBzYW5p
dHkgY2hlY2tpbmcgb2YgdGhlIGZpbGUgdHlwZSB1c2VkIGJ5IF9fbmZzNDJfc3NjX29wZW4NCi0g
Rml4IGEgY2FzZSB3aGVyZSB3ZSdyZSBmYWlsaW5nIHRvIHNldCB0YXNrLT50a19ycGNfc3RhdHVz
DQoNCkNsZWFudXBzDQotIFJlbW92ZSB0aGUgZmxhZyBORlNfQ09OVEVYVF9SRVNFTkRfV1JJVEVT
IHRoYXQgZ290IG9ic29sZXRlZCBieSB0aGUNCiAgZnN5bmMoKSBmaXgNCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTmVp
bEJyb3duICgxKToNCiAgICAgIE5GUzogdW5saW5rL3JtZGlyIHNob3VsZG4ndCBjYWxsIGRfZGVs
ZXRlKCkgdHdpY2Ugb24gRU5PRU5UDQoNCk9sZ2EgS29ybmlldnNrYWlhICgxKToNCiAgICAgIE5G
U3Y0LjIgZml4IHByb2JsZW1zIHdpdGggX19uZnM0Ml9zc2Nfb3Blbg0KDQpTdW4gS2UgKDEpOg0K
ICAgICAgTkZTOiBGaXggbWlzc2luZyB1bmxvY2sgaW4gbmZzX3VubGluaygpDQoNClRyb25kIE15
a2xlYnVzdCAoNCk6DQogICAgICBORlM6IEZpeCBhbm90aGVyIGZzeW5jKCkgaXNzdWUgYWZ0ZXIg
YSBzZXJ2ZXIgcmVib290DQogICAgICBORlM6IFJlbW92ZSBhIGJvZ3VzIGZsYWcgc2V0dGluZyBp
biBwbmZzX3dyaXRlX2RvbmVfcmVzZW5kX3RvX21kcw0KICAgICAgTkZTOiBDbGVhbnVwIHRvIHJl
bW92ZSB1bnVzZWQgZmxhZyBORlNfQ09OVEVYVF9SRVNFTkRfV1JJVEVTDQogICAgICBTVU5SUEM6
IFJQQyBsZXZlbCBlcnJvcnMgc2hvdWxkIHNldCB0YXNrLT50a19ycGNfc3RhdHVzDQoNCiBmcy9u
ZnMvZGlyLmMgICAgICAgICAgIHwgIDcgKysrKystLQ0KIGZzL25mcy9maWxlLmMgICAgICAgICAg
fCAxNSArKysrKystLS0tLS0tLS0NCiBmcy9uZnMvaW5vZGUuYyAgICAgICAgIHwgIDEgKw0KIGZz
L25mcy9uZnM0ZmlsZS5jICAgICAgfCAgNiArKysrKysNCiBmcy9uZnMvcG5mcy5jICAgICAgICAg
IHwgIDEgLQ0KIGZzL25mcy93cml0ZS5jICAgICAgICAgfCAgNiArKysrLS0NCiBpbmNsdWRlL2xp
bnV4L25mc19mcy5oIHwgIDIgKy0NCiBuZXQvc3VucnBjL2NsbnQuYyAgICAgIHwgIDIgKy0NCiA4
IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
