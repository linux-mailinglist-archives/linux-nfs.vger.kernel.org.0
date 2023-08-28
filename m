Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FDB78B745
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Aug 2023 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjH1SgJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 14:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjH1Sf7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 14:35:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2139.outbound.protection.outlook.com [40.107.93.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9B2B0
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 11:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN4hOMfH0tqMy/YezUu9iVrS76jsLswurSq6fvNSEbJ7YBB/Mn8WkZVTjdH9ECCM6EfkLInHLVERoDHqk1MusfkJ+hmU39oASLm4Imh2E3b8zg6nxfnraApZLQ1OdnuDd4xrI2CuowWRSHSfYslYj2ANpasw3WuLqfRQVmM9zg+6Fa0YEVHqCMgzDZHRtDlON7TKg5enZP4QUNZcrKT05/yoKEJ0Dt3BQpnIXLOUO5p4EPd6DEw+X+Pl3/ueUYZIJh285esuhUH74PNOKonwuFnh4eVjIQvrsrsN5sKC18IvFDmTmxmH+FcA5b8aVRwOB+/W9Ba60HsKDW79uJtajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V0YAetyn4yxAHEyGKgMoC61pSjPR7rswopvg4KxdTI=;
 b=PEFrFOj0BW3vFOjgplK7Jq2/xHxV6xVRn6yB5NglnmKS32Teiw3yp+ytiMaAYybXdX1iUAFZZRrt0j235gzxdrDjqh93SO3SaWr16HP4ZLrJ8ZF7Pn0mwQiuPBTxgiEjXLyZmiKL+ks2bsCWOlUHJjiF8DZyGiY1Kq2De6/UkM8Kw6mdfNj9D35k+nG21wdPxMFj5Zg5jkonfG/9E6sdcCz2Uue/QMNppeF6mn3dNAIeF04K4OWWX1T38iPbjs3Ff8gKcZu0TgX8k2qnKLwFeWZiOr6XFX3I9sMkiOgyF/U4zu0pq1YVIYohE4yDw1iAtVouavHhKIzgndViFVX+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V0YAetyn4yxAHEyGKgMoC61pSjPR7rswopvg4KxdTI=;
 b=LOad61TKZcYHE6y8m0JTyMHhrT6WwiAEQicuP5qo7mt4yJJiktSnHS6aDbTPntezrylur9k31mGsTNzpYO9toUK4bSMV/qyFkf65Ahfjsag25+cwMiU4MrZoqbEoNUg1gLmrXvA8lBDQ+Zda5I1KQG/9T++uLURiL/oeix9q/XQ=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 MW4PR13MB5412.namprd13.prod.outlook.com (2603:10b6:303:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 18:35:53 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::82b2:bd16:9045:2d44]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::82b2:bd16:9045:2d44%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 18:35:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "anna@kernel.org" <anna@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: race between handshake and socket close
Thread-Topic: race between handshake and socket close
Thread-Index: AQHZ2dnR3Sj9MZMTRk2NlPmocHRLo7AACTsA
Date:   Mon, 28 Aug 2023 18:35:53 +0000
Message-ID: <1efbc83394dcc890b83526224e9077430e53604b.camel@hammerspace.com>
References: <7B346EC6-E1AE-4C8A-A205-92068D5104D4@oracle.com>
In-Reply-To: <7B346EC6-E1AE-4C8A-A205-92068D5104D4@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|MW4PR13MB5412:EE_
x-ms-office365-filtering-correlation-id: 197c4c9d-9195-47a5-2f20-08dba7f59c46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +wyl/LVzO7Ck354KF6I4BFHsEgLZJQLS+47xbIvOS+Re4659U6p1wRsDBwvK9mLRs0PyjELUhtrdIfF7gTcZowcmWfFMn6/PFUaMYE3L5xmmIceDkw+mkpHMUwRNo4c6dEYxXsoyrc+0iwYwOgy/NN5HeT7I3wXGsiJ3e4z6VxOnpODT12LsP6040jeTCIQ7OJBzefYFzPIbBqTIUihs+N5XSmMhw8PPOs99ANqOeEZkT0HN8UNnSibI1M5InJHtwdjDU9AKGo/b9M1Qtjj1rzcxZzv18TyysSA8wixfuJjPBrJeZ1yJO2arFpzP5Yr5aye2k7oXJz833Rutg0UBi6JHtMM10M3CmjvdzloHEFS1SJv1cMZzqPHjl0NLvNQTBydO39Bh+xqOYZUZttWiZ33YAZl5/5nc4THNIrpE/CtWXfxB8yVKCHvpqkTOyKNaQZWUA/ymI8VkAureA8IA8uSrRqPC5U0iHU6nnA9GX1ksD0/yuA8odrux/XBNsuQemeqZHQ7TI1U+hkHExmJX8jm2nGuLJS7SJEjD6Sme4SqjShjMwd0tvM7O6kgTZhsZsFBDFjFpCOUnQOe5JubiX3TdZwlkvMAdUPTqKhZx7Yz9fLj6UNeEh2vKcG2rFbUcVk5Ybby6ybYd7bO5t1xKeLHdRodp6s8f3PzujZtTFtgPPfG5+tGxjao/azf+ANRkJJt+5sFlVLREn07CPIuECw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39840400004)(136003)(451199024)(186009)(1800799009)(71200400001)(6506007)(6512007)(6486002)(83380400001)(478600001)(2616005)(2906002)(26005)(64756008)(6916009)(316002)(54906003)(66446008)(66476007)(66556008)(66946007)(41300700001)(76116006)(91956017)(5660300002)(8936002)(4326008)(8676002)(36756003)(40140700001)(38070700005)(38100700002)(86362001)(122000001)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkY1cVE3Z041ZjZObUVNTGZTczdidjVoUGFHQXgzQVRVT0drTkc1TldtU25n?=
 =?utf-8?B?TnZjc2NJWHNjRjFpbFJ0VStGbmJyWkVhei9HWFVKR3RjcS9mMlRIN1Jackh0?=
 =?utf-8?B?QVZ6UVFnUXJDWTNQSlJHZDFhVnhSZ2FmZjNKalhXWVkyRzk1ZEpHZVREWmpn?=
 =?utf-8?B?S1QvdXhYMk04cDFjQXZaenVXOUFxdEN4TWxtcW8zdEwzd1FGZktRcTRTWHNy?=
 =?utf-8?B?eXFnR0owQnhHSC9UbVgyV0x6UXUwanJ5VktDNjl5aWZzSlN3aFJqcU9KdWVu?=
 =?utf-8?B?U3JFWEptN2U3cFZVMXViNFQvdVJSZGhjZ1FNKzdlSWF2eWdiVFp0R09vTHdJ?=
 =?utf-8?B?WGl4NEdPNmdNSXV2dG1XZWlrWFkwSDZ4c1JHbkQzL0N4aWFzUGpIcThrTkxu?=
 =?utf-8?B?RXJmYWhCTnlkWmllN1VxckxpL2lVditBOVJTZ2VRUDNWUWpLcGkxK1NucStq?=
 =?utf-8?B?MW1Qa3VEN0NrbGFreklWOTA2VzlVajBPdm51emJCeG1EUVl0d2VnNUtqSktI?=
 =?utf-8?B?K1lEQ0EzQnpXdWNyYmFZb3lFcDVVdFlPOHExbkhnLy9YSWlYOEJEaEsvR09C?=
 =?utf-8?B?SndBa0pSMzhxbndhUmd0Z3V3eEJ0VE9Gak9nQVZOcU11dGdCRTlIbXVtSisx?=
 =?utf-8?B?VDdPTTFlMlVWUlV2ODdKOTAzdDRmQ3dBVUVka3N2ZVd1ZVBST2lvN0V4Vmo3?=
 =?utf-8?B?VnZtWEpUL1FEeHQyQldhTUpUTFcySmNIN0wzVW03a3hiMjVnam5jNFlyUU9o?=
 =?utf-8?B?NHc0WnBZeGpUNWU2aEVLOHpsRFpzVklEUUJGZENKQytPSTIwNU00eGZvWWZO?=
 =?utf-8?B?VzlReEduZmRvajZTYXV6bkc0Y011a3BSdEhGdDl0RGoydkRIR1VXWERuMlFh?=
 =?utf-8?B?VVpoSVlKTjllYjdqS0JNS3VycWZnVVNsVGVlN3RyTFVjM3NUM09iWW81VWg4?=
 =?utf-8?B?QWJURGV5S0V6cmlrZytaak14aHJCM0FaZ05mRnB5VXpkQk92bjJWYjU4cEpO?=
 =?utf-8?B?WXVmajg1dU1nNHRtaCtpNWY3amM3cWRqS3BKcjhYYUJMS2pHQ0NmWHNBeVN5?=
 =?utf-8?B?U0tRclVySEQxd1ZyODNrVzRsUXVGSnM4VEY2MGRwU2gzeTZoNFloeXZVZE8z?=
 =?utf-8?B?dkZoQkRvU1hWeW53SkJ5TDBFYUl2aGsyZjd2WW1EU2dKQmhCd3NBTGM4NWtL?=
 =?utf-8?B?WDZBYzNqZi9qRGZZNExwMjh4dVUrK3Q2T2VidWhFODloYS9jRUVwQkdmTnVr?=
 =?utf-8?B?ZTBkem1wMURTUUtUb01SV2NCT0FUQUM1R0x6OFZuS1JBNDdyRExKQlZpVFRW?=
 =?utf-8?B?OHhrSDF6aXBFWEZScWhHL0UrUDVoU0Jsajd6c0ZEWHhaQ3RiNzV1UUhhTXF4?=
 =?utf-8?B?cU1ycnpqbUtnMmIvUTR3S0FUbDk0S1NVZXdKYW1uQjJVQzZQOFZVTW1Icnl1?=
 =?utf-8?B?NVRGZWZlU0lBd0ZZQzU0RVhQcWEzS0Nydm0yRWo3bVpyb1V3NGVpZW80RWE3?=
 =?utf-8?B?TVNSWDJxYW5IdFd5UjdtV2pQalZ3WWtqNHQ5WktGOVNVWkRTdGtick5ZWkN4?=
 =?utf-8?B?V1d4aTJpbmRQUkI2MXJiNTljbDRoMGVFc1VyNmRWRVZ4R0hHR3FDNUJVc0Ju?=
 =?utf-8?B?YlYreVdoTWVDQkNmMnkwSWFsa3o5M1BTcjJFUU9BVjVWMit5dmRFWjFXelBZ?=
 =?utf-8?B?T1ovZHJCUzVvQU5SQjRmcEFuRW5oWHlBT3RjN1c5clAzMWhUNUdNRjMrMGZG?=
 =?utf-8?B?OEIwR01ia2hpMjAzV2NMMG1ETUZWZFJGNm5VNXVxN1oreFdlLzIwVUhQU0Iv?=
 =?utf-8?B?UzRMemRFWUIyYmY0SFMxVFhCWXdIZHVHbi9ZMHNKZE1wRTdHQlpFdW5EOXNq?=
 =?utf-8?B?VzlZVHZzV01Xd0YrYk5yV2hXaG15ekVDTW00eEg1Q1FOOHlMVlgwRkpLUmlU?=
 =?utf-8?B?RlZKMjdTY1A3dGlyam9VK29PaVVFRlhPSk9wWElOYnQyZWNzQ05jT3NpVEdT?=
 =?utf-8?B?WXNDQTdFNUFMSXJmdkNuclZxTXF1NXVPRU9lVnY1Nk1RbTY1U0ptY2J3Tkpr?=
 =?utf-8?B?clhST0NTbWRjYUpQSjJhNTk4L2dXbkhPcVVnYUh3WjM0dEs3dmswdXF6akVp?=
 =?utf-8?B?S2tDcHlOdTBxUExld2JJWmRUWlZUcmh0bHRGa005K1FjK0ZNZkVSMGtJWjly?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F5CABC0FD161C4CBFC8526B4361FFED@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197c4c9d-9195-47a5-2f20-08dba7f59c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 18:35:53.3390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTFt1ytFPu30qyPLfEdd1rdXO9qZukIqh7e8YGhqhTqfC3r0SHgzYChM+23nha8N1gNmqb85qnC5xLybWJnPcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5412
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTI4IGF0IDE4OjAyICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IEhpIC0NCj4gDQo+IEFubmEgaGFzIGlkZW50aWZpZWQgYSB3aW5kb3cgZHVyaW5nIGEgaGFu
ZHNoYWtlIHdoZXJlIGEgc29ja2V0DQo+IGNsb3NlIHdpbGwgdHJpZ2dlciBhIGNyYXNoLiBUaGlz
IGNvdWxkIGJlIGEgY29tbW9uIHNjZW5hcmlvIGZvcg0KPiBhIHJlamVjdGVkIGhhbmRzaGFrZS4N
Cj4gDQo+IMKgwqDCoMKgwqDCoMKgwqDCoCA8aWRsZT4tMMKgwqDCoMKgIFswMDNdwqAgNTQwNS40
NjY2NjE6IHJwY19zb2NrZXRfc3RhdGVfY2hhbmdlOg0KPiBzb2NrZXQ6WzU5MjY2XSBzcmNhZGRy
PTE5Mi4xNjguMTIyLjE2Njo4MzMNCj4gZHN0YWRkcj0xOTIuMTY4LjEyMi4xMDA6MjA0OSBzdGF0
ZT0yIChDT05ORUNUSU5HKSBza19zdGF0ZT04DQo+IChDTE9TRV9XQUlUKQ0KPiDCoMKgwqDCoMKg
wqDCoMKgwqAgPGlkbGU+LTDCoMKgwqDCoCBbMDAzXcKgIDU0MDUuNDY2NjY1OiB4c19kYXRhX3Jl
YWR5OsKgwqDCoMKgwqDCoMKgDQo+IHBlZXI9WzE5Mi4xNjguMTIyLjEwMF06MjA0OQ0KPiDCoMKg
wqDCoMKgwqDCoMKgwqAgPGlkbGU+LTDCoMKgwqDCoCBbMDAzXcKgIDU0MDUuNDY2NjY4OiBycGNf
c29ja2V0X3N0YXRlX2NoYW5nZToNCj4gc29ja2V0Ols1OTI2Nl0gc3JjYWRkcj0xOTIuMTY4LjEy
Mi4xNjY6ODMzDQo+IGRzdGFkZHI9MTkyLjE2OC4xMjIuMTAwOjIwNDkgc3RhdGU9MiAoQ09OTkVD
VElORykgc2tfc3RhdGU9NyAoQ0xPU0UpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoCA8aWRsZT4tMMKg
wqDCoMKgIFswMDNdwqAgNTQwNS40NjY2Njk6IHJwY19zb2NrZXRfZXJyb3I6wqDCoMKgwqANCj4g
ZXJyb3I9LTMyIHNvY2tldDpbNTkyNjZdIHNyY2FkZHI9MTkyLjE2OC4xMjIuMTY2OjgzMw0KPiBk
c3RhZGRyPTE5Mi4xNjguMTIyLjEwMDoyMDQ5IHN0YXRlPTIgKENPTk5FQ1RJTkcpIHNrX3N0YXRl
PTcgKENMT1NFKQ0KPiDCoMKgwqAga3dvcmtlci91ODoyLTIzNjfCoCBbMDAxXcKgIDU0MDUuNDY2
Nzg2OiB4cHJ0X2Rpc2Nvbm5lY3RfZm9yY2U6DQo+IHBlZXI9WzE5Mi4xNjguMTIyLjEwMF06MjA0
OSBzdGF0ZT1CT1VORA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0bHNoZC02MDA1wqAgWzAwMl3C
oCA1NDA1LjQ2Njc4NjogaGFuZHNoYWtlX2NtZF9kb25lOsKgwqANCj4gcmVxPTB4ZmZmZjllOGE0
M2M3ZDAwMCBzaz0weGZmZmY5ZThhNDJlMmYxYzAgZmQ9Ng0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB0bHNoZC02MDA1wqAgWzAwMl3CoCA1NDA1LjQ2Njc4NjogaGFuZHNoYWtlX2NvbXBsZXRlOsKg
wqANCj4gcmVxPTB4ZmZmZjllOGE0M2M3ZDAwMCBzaz0weGZmZmY5ZThhNDJlMmYxYzAgc3RhdHVz
PTEzDQo+IMKgwqDCoCBrd29ya2VyL3U4OjItMjM2N8KgIFswMDFdwqAgNTQwNS40NjY3ODk6IHhw
cnRfZGlzY29ubmVjdF9hdXRvOg0KPiBwZWVyPVsxOTIuMTY4LjEyMi4xMDBdOjIwNDkgc3RhdGU9
TE9DS0VEfENMT1NFX1dBSVR8Qk9VTkQNCj4gwqDCoMKgIGt3b3JrZXIvdTg6Mi0yMzY3wqAgWzAw
MV3CoCA1NDA1LjQ2Njc5MDogZnVuY3Rpb246wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+IHhz
X3Jlc2V0X3RyYW5zcG9ydA0KPiDCoMKgwqAga3dvcmtlci91ODoyLTIzNjfCoCBbMDAxXcKgIDU0
MDUuNDY2Nzk0OiBrZXJuZWxfc3RhY2s6wqDCoMKgwqDCoMKgwqDCoA0KPiA8c3RhY2sgdHJhY2Ug
Pg0KPiA9PiBmdHJhY2VfdHJhbXBvbGluZSAoZmZmZmZmZmZjMGMzNDA5YikNCj4gPT4geHNfcmVz
ZXRfdHJhbnNwb3J0IChmZmZmZmZmZmMwODE0MjI1KQ0KPiA9PiB4c190Y3Bfc2h1dGRvd24gKGZm
ZmZmZmZmYzA4MTZiM2UpDQo+ID0+IHhwcnRfYXV0b2Nsb3NlIChmZmZmZmZmZmMwODExNzk5KQ0K
PiA9PiBwcm9jZXNzX29uZV93b3JrIChmZmZmZmZmZmE2YWUyNzc3KQ0KPiA9PiB3b3JrZXJfdGhy
ZWFkIChmZmZmZmZmZmE2YWUyZDY3KQ0KPiA9PiBrdGhyZWFkIChmZmZmZmZmZmE2YWU5M2U3KQ0K
PiA9PiByZXRfZnJvbV9mb3JrIChmZmZmZmZmZmE2YTQyNGY3KQ0KPiA9PiByZXRfZnJvbV9mb3Jr
X2FzbSAoZmZmZmZmZmZhNmEwM2FlYikNCj4gwqDCoMKgIGt3b3JrZXIvdTg6Mi0yMzY3wqAgWzAw
MV3CoCA1NDA1LjQ2Njc5NTogaGFuZHNoYWtlX2NhbmNlbF9idXN5Og0KPiByZXE9MHhmZmZmOWU4
YTQzYzdkMDAwIHNrPTB4ZmZmZjllOGE0MmUyZjFjMA0KPiDCoMKgwqAga3dvcmtlci91ODoyLTIz
NjfCoCBbMDAxXcKgIDU0MDUuNDY2Nzk1OiBycGNfc29ja2V0X3N0YXRlX2NoYW5nZToNCj4gc29j
a2V0Ols1OTI2Nl0gc3JjYWRkcj0xOTIuMTY4LjEyMi4xNjY6ODMzDQo+IGRzdGFkZHI9MTkyLjE2
OC4xMjIuMTAwOjIwNDkgc3RhdGU9NCAoRElTQ09OTkVDVElORykgc2tfc3RhdGU9Nw0KPiAoQ0xP
U0UpDQo+IMKgwqDCoCBrd29ya2VyL3U4OjItMjM2N8KgIFswMDFdwqAgNTQwNS40NjY3OTc6IHJw
Y19zb2NrZXRfY2xvc2U6wqDCoMKgwqANCj4gc29ja2V0Ols1OTI2Nl0gc3JjYWRkcj0xOTIuMTY4
LjEyMi4xNjY6ODMzDQo+IGRzdGFkZHI9MTkyLjE2OC4xMjIuMTAwOjIwNDkgc3RhdGU9NCAoRElT
Q09OTkVDVElORykgc2tfc3RhdGU9Nw0KPiAoQ0xPU0UpDQo+IMKgwqDCoCBrd29ya2VyL3U4OjIt
MjM2N8KgIFswMDFdwqAgNTQwNS40NjY3OTc6IHhwcnRfZGlzY29ubmVjdF9kb25lOg0KPiBwZWVy
PVsxOTIuMTY4LjEyMi4xMDBdOjIwNDkgc3RhdGU9TE9DS0VEfEJPVU5EDQo+IMKgwqDCoCBrd29y
a2VyL3U4OjItMjM2N8KgIFswMDFdwqAgNTQwNS40NjY3OTg6IHhwcnRfcmVsZWFzZV94cHJ0OsKg
wqDCoA0KPiB0YXNrOmZmZmZmZmZmQGZmZmZmZmZmIHNuZF90YXNrOmZmZmZmZmZmDQo+IMKgwqDC
oCBrd29ya2VyL3U4OjctMjQwN8KgIFswMDBdwqAgNTQwNS40NjY4MDQ6IGJwcmludDrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+IHhzX3RjcF90bHNfZmluaXNoX2Nvbm5lY3Rpbmc6IHhz
X3RjcF90bHNfZmluaXNoX2Nvbm5lY3RpbmcoaGFuZHNoYWtlDQo+IHN0YXR1cz0wKTogc29jayBp
cyBOVUxMISENCj4gDQo+IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBhYm91dCBob3cgdG8g
c2FmZWx5IHByZXZlbnQgLT5jbG9zZQ0KPiBmcm9tIGZpcmluZyBvbiB0aGUgbG93ZXIgdHJhbnNw
b3J0IGR1cmluZyBhIFRMUyBoYW5kc2hha2U/DQo+IA0KDQpTaG91bGRuJ3Qgc29tZXRoaW5nIGJl
IGhvbGRpbmcgYSByZWZlcmVuY2UgdG8gdGhlIHVwcGVyIHRyYW5zcG9ydA0KYWNyb3NzIHRoYXQg
Y2FsbCB0byBzZXR1cCB0aGUgbG93ZXIgdHJhbnNwb3J0IGNvbm5lY3Rpb24/DQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
