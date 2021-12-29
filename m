Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E04810E7
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Dec 2021 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbhL2IYs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Dec 2021 03:24:48 -0500
Received: from mail-eopbgr50094.outbound.protection.outlook.com ([40.107.5.94]:28135
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231653AbhL2IYq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Dec 2021 03:24:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxjyDccW6K6Vs8Dbs9n7HOILfThlcgFbUKruZmE6hsCboO4QyNeX7eZsVu5Qt53wt7JPOQv5dEPsynCWjji+ru8sec8EC7Na3C3YeEoczgkZEBisOYQfgweNI/ggIj7+bqRaISMhzMJvDNXiS8QzGDMoa4aoEasrEH/bQinn7xbh+Hal/1REiVgJ+27bNJCwJl9U+M1/GYaT4dg06ouh4Zs+iTs9Fb4XVI5++k2sBRjFh9Yp5n8tRFZA+gK1CEhQ1dh4mnNN71FvABaxW800uA5/06lBLfkLNYTsEMsoTTQze5I1Hd2LA3FTc9mb1MoTQjDcsbfcyOI/szvSJ5IyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI9A9SXUZjM2CR3SuatyKczrZlbAmBOJRVxTv4oVq8U=;
 b=SSNQNK1LBBIGubFiASnrm/29M1zNcwIXCiWeJp0GrutWhPjS7r3rcQWem2oJtUamb/fpAdnoZMwxVw2QCCIEtokIq3K3JDoK005qwohzG6SDPKeshKMwE3jV3Q7GFzwMpQZ322a7NHQP7l58U6s8Sk+gPiELlQGNG1v21Gt/SkYQyoz7YdUL657VHAStFW/vNRe8cBSpEgQYarWgLtKoTOAWNJ+eqmD4c1Nivc6WSKkvbBVJ8CHgeEjjN7ffqIzWqbBLo5KT/wrqFdZbZhEk+E2vW0OgYezprPmLfvPBoOkJbCCX/IowVZ9qQfbmdW1A3JAJ/LzYqlk+MRr8ZUIZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI9A9SXUZjM2CR3SuatyKczrZlbAmBOJRVxTv4oVq8U=;
 b=nq2zU+E9RBOVcYWzkgNW/T4Rd9FuMlnBZ97xxrv8afahb0hZrW+fDRsRoYTyhrVgm69lbZKglHTPDYDvvnGHjHMAn3aXaojcYL7rA0vhBCFrlYdRTKAGnwuQWu9IpJq5A5v7O9Hr9HUFSY6xQ3cqAbo6mLwhNFgl4wOQCHPQZLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM0PR08MB2964.eurprd08.prod.outlook.com (2603:10a6:208:5d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 08:24:44 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%4]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 08:24:44 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v3 2/3] nfs4: handle async processing of F_SETLK with FL_SLEEP
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     kernel@openvz.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
Message-ID: <00d1e0fa-55dd-82a5-2607-70d4552cc7f4@virtuozzo.com>
Date:   Wed, 29 Dec 2021 11:24:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0077.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::24) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 335ad032-8c13-42b0-d944-08d9caa4aaf6
X-MS-TrafficTypeDiagnostic: AM0PR08MB2964:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB2964F76C1D76EF25940EF075AA449@AM0PR08MB2964.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76/Mct/1TfBjbdXovd9dkoSHnc55zExDXe+2juG7LLUdNoVMzBMyyiAD+StrpzFmGFg4D1Kd2YcenDr5zmAgGbyCOX8FunTylrhVx/DILfW2B+C6BiP6/O2akOsq+NrTVbBIaPMoYYtI6Tx/G+ghaFNVvNFD2AmvOkgq9QdoZxJvm1d/XlWIqwX0EO8ob2pqLBV2Md6zaO2ofuyWgQRoIxwVkfxBXW6hRjxnsFAp0HnYBbTtKlx5YSFZa4Ka53f3BdQJL9qjdu79hmLZQb9qXrukmruQhcOhImFSdkByTCVAZWkzyQMwWwl+VgMJzhnwBTF7Iuep1x/rZga6Cjah5WB0pWNHp3aO/AKb2lzWJLvE9isquCjP1JZDkWVaU/8KlLpd4+z5CZOggzUZiDNyyWJgJtSzxLaX1SVelTfRkLufYnMNW6O121xlcOonwa7AIy7dLE3L5AP7V4wjLSx3/b6PXr8MVJNCj/Q+Yp3vt3PaMhhYwgXxZQdQ4aSYZ9Y9bQuW0lGWiC4sP1c7pQ5cEUL059CKpoZJFHEBfgUQ9rAFhS7Jye7EOoFlcV9Dt+B6ykBgQdqRvDKuB2RQ6YUExSiR4fpQT9DDkCG35UKaqRdaKA8zUYxIZfbWI26UARQcMBmInZod1tUK42J391hiJOZZE+9EHxgK48wUfA0H1BwuMqAb3vx0IJhxFi1nReVE9k8Gc6ahghVQXhojsQHPjy/CRQJg4OdMwbaQId5yNkba1mYuhLc5c0C7cIYCUGS1eBRpvZIlvDTukrHOFslXpWaOrY/LYBamyGVc714igPEpFYZB0tk+awxhKJHTn9h+SlH4ExAtuLGMSqSDdnweHxsHCczhzDelwLec6EWxdu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(2616005)(8936002)(6486002)(31696002)(2906002)(8676002)(6506007)(5660300002)(4326008)(86362001)(110136005)(83380400001)(66476007)(52116002)(66946007)(26005)(508600001)(966005)(66556008)(31686004)(36756003)(316002)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wml2QlI4azNZaVF5d2Z6YUlKcW0yVzRjTzY0TU5CYnhGV2M3UTNZRTRjRTM3?=
 =?utf-8?B?aW55OFE2cy9tVm5iUjNLZVBUdlBsZWtKazB0enRFTlp2WjRnTUxnVUYxZnhr?=
 =?utf-8?B?SXg1U0tvZ2drTnZibjh5THo3bytaVXFQVXZwWkdpUCs0WElYREpQK0gzcVFO?=
 =?utf-8?B?WWVaMWxHVmU0U1RvcWN0dVVWNmIzZDZaekY0TGdFYUIvVmFGN1BaOE9oM0ZM?=
 =?utf-8?B?Z1FTL01ZUHIxbVFCNzI2REhrbXB3RCsrZlRhaXZzSkRLS0NKR2hDNlF3Y1la?=
 =?utf-8?B?Y1Jpa3R2bGtWRHpKNXFJRElDOVhkVGFyNnE3SXhuRzE2VWx1YnUyLzYxSThn?=
 =?utf-8?B?QnNNR1hmODFFWldibmg5R3NEQmdDeHdVVTBRYW1WTnJ5LytaWk9ZeVArYWhG?=
 =?utf-8?B?YXhxNnFJVlNucEpVTGFQU0JlRjR0WklhQm9SNXQrd0pZVlhLOGFkbk5relRM?=
 =?utf-8?B?S3V5TmMrNjFoYXVWR1FQVjRHeHIwTk1aalg0SURCaENMc0Z1S2diYml1OWtD?=
 =?utf-8?B?MDAzWkNreXRvMXNUVmhHdm9KUEcxZ1ZEN2d6dHp6aFYzaU93cEdVbHVEejFn?=
 =?utf-8?B?NlY3OHRHbjFldkY5Y2pDM2dzdTZqbjNWUlpiWE54aW9URFBQcXlJMmpUYmRN?=
 =?utf-8?B?NWhDNy9ES0pnWEV3UjdRb01QcWE1LzlnclNoMzQ3WjVpdHllUGpwd1RzdC9z?=
 =?utf-8?B?dzh0T3VwejJuQW5JYzEzcldOT1FIditmbG00YjBSang5WTBWaE9lWTcwNDdy?=
 =?utf-8?B?ZEdCTWVWRmVML2VUWGpFdlE3SjBjMHJEOXpxQUtWU2J1ckFNcG9sMDd4S3lL?=
 =?utf-8?B?ME9wQjdjeGhQS2J5WTdyeVRRQ0xReTBVOUtXRUsvMVFlZHhIVEZXdm1Sd3Yw?=
 =?utf-8?B?MGRXa0tFYTFkM2N4YVFUVVhDcy8zOUl1K0FiQjVYR1J0Ni9kRFh4STFJS3ov?=
 =?utf-8?B?eHdYSlFvYmdKNmZQT3VKUE9zRU1IYjV5em5JcTdVN2NPNWVvb1pNdTVZY0E2?=
 =?utf-8?B?WUN3WGFlL0lHcWVsc0o0Q2lrUWlLTU8vVmxHMmh4enNZU3gxRm91QUdEOVNi?=
 =?utf-8?B?WnFQeW5GNGhNSEFjcFo0NVJHcDZiRjd1ek82V1FLYWcvUXYwSk9lUHZXSEZY?=
 =?utf-8?B?emVQNjZEOWg2YW94OFAvTkwxejhSdW9SVjdTSWEwcXNEL3QyTGF2ZE1PSmVr?=
 =?utf-8?B?TDJsekZaWXorczBSeUM3eXNWYVhSYW5PdzNWaGdBVzBxdkorZmtlWllLT1Ro?=
 =?utf-8?B?QjFEV3M5QmZJL3RoVm1kRW5RczBYZE1yMnFrbDFYQS90bytpVmZ4S0treDJq?=
 =?utf-8?B?R014YUhQU3ZlcWsyWGV0UGtXSXovR1d0TVpiTm42YmNxUFJyTmVEZ3FhV0Fo?=
 =?utf-8?B?TXNTOGZlZVkxbHdibllyQW9lTnpXVGRlTXBHcjRRUkYzS3JpVVVGa1ZMSkVX?=
 =?utf-8?B?WXZ1WXoxcGg2SlFZUVJjK0thK3hXWFdTUklySWFGUHdxbXBaSlg2Wno2U0Nm?=
 =?utf-8?B?d1dDRGVsOEJnRjJDeTNDdlJKVXdtdVJFbUNnUFdDTXdFOWJvbVAzMU5VVERh?=
 =?utf-8?B?eUpyWXIxSjZjbDl6OUFMdGV2OTVDQXNMRy9ReXpmejVzSGc1RkFvSU55dHQw?=
 =?utf-8?B?elNjMW1Bdy9oY0Z4UUh4aGpDYWMxc25LVFhEdnRUZit1d3hSa2RRQlpDVmNn?=
 =?utf-8?B?TFJyRUp1cGVhekdHOGgxVkpYNjJuS1JPeTBXejNKZklRVnFBaXlZcXUvbEVP?=
 =?utf-8?B?V3JxRUE4QXZqMXNXN1dOZWtjYzFqb2RaMWJhaWs5YVlPdzZlYURPdWYrNXFV?=
 =?utf-8?B?NUlyMXhWeDh3MGpPUzhRaHkvL2J1ZTlQYjJBeUlqSVJENlV0cTJmdy9xZzNu?=
 =?utf-8?B?R0haOE9jdU4wN0lmQWNrcm5ta1RHOGtuay9HYTU2YkpRVHpYNGE1T3dtZk40?=
 =?utf-8?B?RUlCKzlkdGNHemxoZG5iOUVCd0laQlBhMTBTbnh0NVZEalJEVEc1MkgyampL?=
 =?utf-8?B?eEw0bFM4S25PQUgzN3BsSFlRbTNmTzV0RnBPVVpHQ25DdFlDOGpkNUNReDRt?=
 =?utf-8?B?TlJ6by9HemZvc09icU5iVkNwRmZSSkprOGRnT3JZOElQR0xHQ0UxMGFJZ0ZH?=
 =?utf-8?B?aWQxTDliRWo0dFBzTmJ6SnB6NkRTdDExbjl0cHFrSDBleEg3bitPNGNsZXYy?=
 =?utf-8?Q?LzYXm2UzJgOKZrvw22UyeaU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335ad032-8c13-42b0-d944-08d9caa4aaf6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 08:24:44.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Od7vNk/x8AC4qbmW8wVG3tA/RvTYT8LJOtMbyZ5GCZZMdTfLO5d3QVaC2p9cLBNkVxCoVIqWoN6S0hG+tw23ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2964
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
asynchronous processing of blocking locks.

Currently nfs4 use locks_lock_inode_wait() function which is blocked
for such requests. To handle them correctly FL_SLEEP flag should be
temporarily reset before executing the locks_lock_inode_wait() function.

Additionally block flag is forced to set, to translate blocking lock to
remote nfs server, expecting it supports async processing of the blocking
locks too.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/nfs/nfs4proc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ee3bc79f6ca3..9b1380c4223c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7094,7 +7094,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 			recovery_type == NFS_LOCK_NEW ? GFP_KERNEL : GFP_NOFS);
 	if (data == NULL)
 		return -ENOMEM;
-	if (IS_SETLKW(cmd))
+	if (IS_SETLKW(cmd) || (fl->fl_flags & FL_SLEEP))
 		data->arg.block = 1;
 	nfs4_init_sequence(&data->arg.seq_args, &data->res.seq_res, 1,
 				recovery_type > NFS_LOCK_NEW);
@@ -7200,6 +7200,9 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	int status;
 
 	request->fl_flags |= FL_ACCESS;
+	if (((fl_flags & FL_SLEEP_POSIX) == FL_SLEEP_POSIX) && IS_SETLK(cmd))
+		request->fl_flags &= ~FL_SLEEP;
+
 	status = locks_lock_inode_wait(state->inode, request);
 	if (status < 0)
 		goto out;
-- 
2.25.1

