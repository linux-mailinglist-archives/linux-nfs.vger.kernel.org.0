Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B04810E5
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Dec 2021 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbhL2IYm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Dec 2021 03:24:42 -0500
Received: from mail-eopbgr50130.outbound.protection.outlook.com ([40.107.5.130]:45952
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231653AbhL2IYl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Dec 2021 03:24:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVAnlxaUZNXRGr3QJiV637DliS7wZRjz4BR0cbAhyRnrnC5B4TUbahCVINqFzIgduM+LtVYU3zzh73mlQGkJiJmgAKOWojAz0/JBcLPCcqw38d1WKtcP3j5ii/b4xsl5XCwOEQBvBPsB9YtgYOlImKsXvUjTZ/LSltyk+ic2AenmBw8Bm+xf9hNBBJHfluuyKY8t5pRUefTwPkkcvQNoU6NphzAS62A/M/aUoaEm/ro4XqZblBcvXKJrWpuMYGu1tisOmuL5PNBpQZMjvOdsq7j4ORpoFa/7OwAsQgC2YnChVfFou3jfk89TXx0Fp/d0aS2mTqPIh11MnCL+gs5j3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzMWvOPyUAHy4GiWCDlNHmEhx62/dykQ+DN1qasB4W4=;
 b=lo0dw/okhLfTAAy+iSZSYguL5GdaHbUswVJL/bHkePPOZe6j0QiJz+EJjLIpyfwBo4hr7WaTCo2wMv8eo8HoOCSjvkYWfL4/1y+rn2EpNk04yaXLW42i+zUvHtyXe67kyp9JCffsr7LLWKqNssNjHMXKqS4oRmT81wtpMYC/cj28DU4fLLdWZo2VmNooFwvQnVF7kLmwvCB1inmlUOS7yll4a+gjvSUmXzz/QZiWnc7TdX1V9/C53kC0sHsnsPq/CioETGw9eTON4+WzvG+/OlQg601R42SM+oqV4LvGkb2LjFZalqHDlFKUCedzLP5doGUN9wxhY++18d0JHknhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzMWvOPyUAHy4GiWCDlNHmEhx62/dykQ+DN1qasB4W4=;
 b=Ceqsqy4IBHJXZegtqUOWswIDwjZgDvFKKmap+Suyua/+ULn3CS+rbxz/NGi0iyRlN5gZ6ZnY72JmnOS3EqV3S3VaVOcn6ZjBV2obfcuZR1m1mAupsKqc2tAbQ13l3P1YjylivcRjInK8XM5FKy8TbP40AZCZZPtlrit0I11Y3k0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM0PR08MB2964.eurprd08.prod.outlook.com (2603:10a6:208:5d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Wed, 29 Dec
 2021 08:24:36 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%4]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 08:24:36 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v3 1/3] nfs: local_lock: handle async processing of F_SETLK
 with FL_SLEEP
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     kernel@openvz.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
Message-ID: <84ddf570-a315-566e-3386-df14da52f9ff@virtuozzo.com>
Date:   Wed, 29 Dec 2021 11:24:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0075.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::23) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff8a001-5d7d-4ae8-6560-08d9caa4a5e9
X-MS-TrafficTypeDiagnostic: AM0PR08MB2964:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB29644F91474DF6B483AAAB53AA449@AM0PR08MB2964.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LthyPwaGYQQobdZemwWwgVNyP+7miy7gX/JKHvlmxuS1pgZtgt+F3kO/pnWh0Ddgirp7IZ2C01hYgrgGWVyoScfhiPiTd5KG/vuVB464mwZxY/oNDWuMxS49YDhXQpD+h3leaIJsL9QVvIiW5g7XcFtdTvpTM4+fcPLjQQDAPy4LsTtr0nwGOrVcuEO6t9jg5OKKwcicS9A8WkFdT4p74ZMPliLnVaRMdlt6AdJb0kacOEGWECaWnXV3mOS3RuxtK+4RRMeOZl43YyiekaqTkQbSVvsziDnbZPypJUkKVCRoawEWa8l27EOxEhEN21Au0znxn8m4T3qlBHIJzX+Mzfw5Po+3XZ8ipg4olgHYhsFFaHoNGv91NYrFo4XLSLEyniE4c2H9An6AXhhDO+8ewsCdlKQNh03QJEmaqUUXXybs4d9mVlttBU4i2cZdVDxHf0H7645Y6qvFp/QcASy6PVN11S9TzEFxCrFrEqDYG6/zh1gLj24G2pO8GvLhmJyOlOPyev6YL2LOdO9Gyj5DKiyY8zyYkSJTqqa7NN/N4rV0ogGpx04p3LBSlXWgKuPaxMqd1uV/Oz4Nim4Iw++iHMsoHTVKCWzSC8dsAFhhgO3kDjaME5c82guarTSYktol0Ki8ZquW4m5C86lJrMuaDjCGNRAJLm1ZyJIjSPQuNrROnDCVjqrcTUlG0N7lPkVvcFD5xU9uFiUUlWsOrhwzA02GQ6O8zBtoEY6yViFut+m9+SPBnBt0XrwXEZa1cwgHQlhmU5LvmtPWATLHmMw+Xb0qQt4DFDNtgDG+Jjum7q9ahWekdLrvIKZi5pvRn04UXcj1eXTcGscE5M129OnRe22P75HN/F/CNW5pwM/hgJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(2616005)(8936002)(6486002)(31696002)(2906002)(8676002)(6506007)(5660300002)(4326008)(86362001)(110136005)(83380400001)(66476007)(52116002)(66946007)(26005)(508600001)(966005)(66556008)(31686004)(36756003)(316002)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUdpcGxvQzdSbHlYaXdIOVFoQmJyQWNYcmZic3dCK2FYY1VDbWFwQldUZUt6?=
 =?utf-8?B?bmhteE5hREZnc1V6SXI1YS9PbnpNbVFXcUMwR0NmY2dUMlNubXdBR1Q1QW5O?=
 =?utf-8?B?eHYzUk9POVhsUmtmZGZjYmhNV0hCdjh2b2pudTE1TGtaRG9Udjcvb0lmeXd6?=
 =?utf-8?B?bDBneTlOQmJNUnBjTnlmbm92TEptd1hBQ3lFclUrb1d2aDVIN0pPZE1wTEhy?=
 =?utf-8?B?WDB5RHZaT1dTRWo2Yi9nZHZZUE14TUxOMUZRNkpja2tra0c5cmlkNFcwQTRY?=
 =?utf-8?B?am1WSEtMcHZBZ0EwaldhdG4yQ1VZOHRwcm05b2tjQytXZ09pUmNjTFVoS3ZP?=
 =?utf-8?B?NCsySUpEcDB6ZUJqNldpc0I3bjFqU2RYT0U3ZXVXZkpJVUtlWlFNZy9acXhq?=
 =?utf-8?B?cHhEOGd5dzNGV2RQUkg3TFZmanQ3MllkSTBXcG9aQWM4R3FEd1FHT2dDZm5U?=
 =?utf-8?B?bXRpTlR6OXdVR3d3a2FwMXRzVGpxZUtGVzZobGFkUFQ2UXBwVlN5MXBJMjlv?=
 =?utf-8?B?QmN3ekFzamV0Z1padVBJL3l2cVFDQ3U0NXRqblFrbElFb3JHVGNDcnFXTHVV?=
 =?utf-8?B?MkczWU5XQ1dXeWFpNzcyNDVGckVuN0V5MG10MjlyT2gyMmFKdUVJRDJFKzlR?=
 =?utf-8?B?VDlxV3U0d0dKeW42UDN0NHc4ZXptM2E0R0h3dndlcEpEaWtIUXRhaGdZKzcy?=
 =?utf-8?B?WHowMGREZlVOQmFrbVJYbUkzbWxzdFhmd0xzK2lNT01sWWRGbzl6NkhyUnhC?=
 =?utf-8?B?SkdYSkJacGliZThTeGdNTUdEMm50Z09jK1BhNWwvV25WWXlEWm44aTN1Nzl3?=
 =?utf-8?B?WnBFMDZ5R2RiOUVQNWtVeFM3enk0RVJsUnkrMzVhZ05aRGdWdHBBMW5QTURT?=
 =?utf-8?B?eXZ6SnMxL1J5YnBMa29nNlBPL3dTbFQyU3BEWFVtdzUyaGp0Vk5oY0dHL3ZF?=
 =?utf-8?B?dno2VEQyZVBsN0FuVGpRNVhvOERkYWt0cUNjTy95WVk0bDJTNEk0eU13NG95?=
 =?utf-8?B?YTNJK1d6dldUWU0vVHMwcVgrcktKQ0N4UU93djVhVGRYYnROWExuYnhleHNj?=
 =?utf-8?B?SE9mT2l0RW12RFhzVUFBTWt1QmZEanZpUE1USnBUYU9QaWRnRS9JL2tub3BM?=
 =?utf-8?B?VVBxSmxqZm55THNPSkJBaEQ4S2pkM2xmdkNibnFVZ0pWeTZ4YkcwcFU5cXoy?=
 =?utf-8?B?SnRBUkFmdzUvQytrSEZmWGdXSmNIcXIwWkVBYmJ4V3dJdERteUVLOTBUUWdU?=
 =?utf-8?B?WWU3L2tkTHlDZ1ZCNFRFQ1F0dU9zNjcwRDNPaWtKUVVtNjk0ZEVmMUZFWEps?=
 =?utf-8?B?eVI3dW9IV3RMV2ZSNkpVWjNhd2lDSWdJSU9yMFkzYTVMemRBS1ZSQnNldGpL?=
 =?utf-8?B?bWs4VkdmT0ZZQlByZ2h1djZXY1FIZkdDODh0UGIvR3gyZDA5Q2ZGSElnTHRR?=
 =?utf-8?B?MXpUZHIvSWF0cDhnZitLeHpxa1IydEFPNVJSQ2JrcDJjUDRKeUluVWZpQTVr?=
 =?utf-8?B?SEZDR1h6cWV5MFNSR2RWQ0lTTVRGZmh5ek1XVEdET2U2VStYNStmR3ZGaFIr?=
 =?utf-8?B?ZExISjJlRHJzVmRCUGIzQUk3NmI4SHZDbnJUUzdicjZsWGlUeWZYZVBBMXA0?=
 =?utf-8?B?RmZPNGRMdEtjMTFTMGdHbFJjRnEyMThOamxKWS9lUFpBUC9hZXRaMHphR0Jo?=
 =?utf-8?B?UEZKUm1tUE0ycGhaRksyTTVla0ZBZ012RFdZbEhlK1poam9yakhHemZad25E?=
 =?utf-8?B?WlNpZGNubzhldTVWQ1dnN1hJVEVVMm9LSTE2TWJEeTE3RmszaGhTWXFaV1RH?=
 =?utf-8?B?NFIvVFRrMCtaUUJTajA5UE9mYi9mYXE5MGQwNzRLUDA2TVRvd091cFlCdlp1?=
 =?utf-8?B?U2RVYmRTVHg3SWZ5UXRBYkVNZW1MRllHTFhCR0dlZENrdE5IR3RGSnpzTWU0?=
 =?utf-8?B?MXE1TEVXZCszYkpNUnR1eklQMVV3ZFpOTjhSSFFSU01HVEdub1lxVU1xd0Zx?=
 =?utf-8?B?TlhiTnJYRWkxTDh2Wm1vSmFRQzBhZGhJTDY3Q1ltY2JlbTJDNGtNazVqRVB3?=
 =?utf-8?B?V3NlcmFEamRsNUlNT0MrbmRGbDREQVBhdWY2WGg5S0V1YkdZTjdpb3RZUUJS?=
 =?utf-8?B?bmRsSDlKZ2JjNXIvVWhLRTRtai9tNU1sR1FYR2ZvQlBXVFdGQzJXTHErQ3FV?=
 =?utf-8?Q?L/+GCavTPZxjpbfPebiuXyQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff8a001-5d7d-4ae8-6560-08d9caa4a5e9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 08:24:36.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN4kOsVqxr7waqcqvW9Zk51O6AT9r5YIk+JGp/V1rUgYKK2/f1EVR280kNS0QJQWJmBz9bQnqzIBQ+LIaNNKQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2964
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd and lockd use F_SETLK cmd with FL_SLEEP and FL_POSIX flags set
to request asynchronous processing of blocking locks.

Currently nfs mounted with 'local_lock' option use locks_lock_file_wait()
function which is blocked for such requests. To handle them correctly
non-blocking posix_file_lock() function should be used instead.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/nfs/file.c      | 5 ++++-
 include/linux/fs.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 24e7dccce355..83cf42cabe41 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -753,6 +753,7 @@ static int
 do_setlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 {
 	struct inode *inode = filp->f_mapping->host;
+	unsigned int flags = fl->fl_flags;
 	int status;
 
 	/*
@@ -769,9 +770,11 @@ do_setlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 	 */
 	if (!is_local)
 		status = NFS_PROTO(inode)->lock(filp, cmd, fl);
+	else if (((flags & FL_SLEEP_POSIX) == FL_SLEEP_POSIX) && IS_SETLK(cmd))
+		status = posix_lock_file(filp, fl, NULL);
 	else
 		status = locks_lock_file_wait(filp, fl);
-	if (status < 0)
+	if (status)
 		goto out;
 
 	/*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..8b6e9332b39f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1042,6 +1042,7 @@ static inline struct file *get_file(struct file *f)
 #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
+#define FL_SLEEP_POSIX (FL_POSIX | FL_SLEEP)
 
 /*
  * Special return value from posix_lock_file() and vfs_lock_file() for
-- 
2.25.1

