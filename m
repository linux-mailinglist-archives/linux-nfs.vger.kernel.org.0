Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5273C47FBE6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 11:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhL0Kpb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 05:45:31 -0500
Received: from mail-eopbgr80101.outbound.protection.outlook.com ([40.107.8.101]:40007
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232742AbhL0Kpa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Dec 2021 05:45:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSMELQUpO58wzwsPnTZsosp+uwCvW01ZOyTQAeuqW9Pbo9z6+qpEZAfe+HndUIrywpiJKbT9Wo0vXUbTweidOUAUl76tZpzMAXZKPvm9e0CJIMfQBkylxumrvUNZvVeHl/J+LzlMwwLX8xlcJcDTxgdDBrCOpzJ3Qe9Lj0MymCttgKDWfA4kycF0fELeQzGwO3bN367Ixr0BKMdDVN+UBu8eDzTEoJovCKRUDi6wCcAxWVHe63gJ+f1Arf6ctRHDHcFVJ0t6RrWSctOU35NxYIK4Sdpf4P+pOvZAiPNUEUw4z2DPPJmtps2oA5GdkrmSdVEVH3Og4FOAaCDQzAa+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwuVNDnGdJ1GcH41Cb+dIiiiXqbLuMn9P30NH0PFnJU=;
 b=JPsUrnIpggB6w7zPgwDK+yEOaN4m3NtmqW6wcaqlD1AU0TUGwuDtrRfCIEIJOkuig6gz0ElyWQTZF93oB+oAa+/ijAZmfNSUtBEskVyGO5/zFQlRb0FKdWNXv7kvwxMk1pqiQhjZh/D6skbDQU5sl0SV706rvHtvIyLw/X1xT7fV+2RN1Y3yzKKzslmB9vOF8XSjB9laTV0FZETcf+8ITh8uY226/G74SG4k2PbAIB6oPAloVQUGLPcw6y9gcgf8p+xxrlyRXuDXx7xBiepZIkAOZYVgoNxuPs5o33H/N3+iYhmH+O5nC1rDR0HWgeQNqp8bRqvdHIrRZKEfrIYp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwuVNDnGdJ1GcH41Cb+dIiiiXqbLuMn9P30NH0PFnJU=;
 b=H2TOufyr1BPb8BkamVl98cCfOpGh/3dZQvvvU4MEGeJWbxDrJHBr6lqigsihVyzqR+vK0jERMMnIlEdDtqAdVkhnRXVnxKcisAYNvAJViKwm8iFRMfNisdN0P+1S/iWwpz1ocB4+d2ED5HsGdN2NiPhMe+rCWceUH4gk4hBuHYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM0PR08MB3554.eurprd08.prod.outlook.com (2603:10a6:208:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Mon, 27 Dec
 2021 10:45:28 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 10:45:27 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] nfs: local_lock: handle async processing of F_SETLK with
 FL_SLEEP
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     kernel@openvz.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <6613b17b-43bd-07d0-2ca7-1581a39cdf7b@virtuozzo.com>
Date:   Mon, 27 Dec 2021 13:45:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::23) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f5a6d7a-3c17-447e-3324-08d9c925feee
X-MS-TrafficTypeDiagnostic: AM0PR08MB3554:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB35541EB7F5D64A20CC737486AA429@AM0PR08MB3554.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcxXfAJ/zBCxWVz/tz8dnw591puCTZ8kRazA1JDCH3LVjRlJwBudMjqb/hIcIzUnUd45x8iSmYGsQDz1jSiPBEqQS897nDV+NnQw/bJL1sQ9PgJZybyHz+N+JNxAxEmws3YgfTuS1uUrDly9TMRdr57ry7hJ9qapAbYGPOloVGjPrg0Og9owwOdy8srs0fe+zs8aRxSuyFDJCB6kb6SjHiwXZlH5B6HgILxSSqs0FyvpyftE7jRM/qRuelZLzOLlxML5B7LtsJy1a3X2qk4/VYAsCy//DvCv5bPUstoOcj8IETMKLFk021QXd2xueJqht8gbzdaGE8KfFbS/dWxaoYCpnhnBvArUGIGXe7MtfAssHLjbLKCGdsNl0G51BkKJLF3XH+NvG+O6r6yOmgdBJKcVK3kUDshzCUalY7skO2SkpHNbqatbvT/okitaSVCT0FqI/aHw6/qQs2tsmmH6qYrtBcJbFCQAbKyVQxh8L6/95+t0lzU4VCZv7R1qGUwzEqlJe3wgPdebAlJa+D5IO+mn3Yq9o7MDG55lLyThonq5F50gfHKbCfqLBEWWP7YNRj7Mph+5+Zp5pLgjbY2n1AeWU5wIjkGDi0rUZaCgvzJZianNCLpifi84dZKEr3XADRvQxkhC9axJunaT8vImO3OB5GQSq42lUWOePGtrbPDM/nLtSekhcCPD1hLEWZV4vxCbwugkZssSrr0MqOAEP/Ryiwp+dTfLBjGx/KEaI+JCY2wGYHt7dbb2KQXnuVu4Pk5qysaw765gVFZvkPogMimU5PH6g3ziZFcLBXgxstOYnuIInxrur8sIkf/YMN1Nm+QYwqNWm6J52gdM5ZtqD0LwqZdEQYIxpsQJxnQTttM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(6506007)(186003)(5660300002)(6512007)(36756003)(4326008)(508600001)(26005)(966005)(52116002)(316002)(8936002)(2906002)(2616005)(8676002)(110136005)(38350700002)(86362001)(38100700002)(66476007)(31686004)(66946007)(6486002)(66556008)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtMbWk1ZG9lbEJpQit2WnI2UFB0ZXowbjdsdzIvUjY4aWlBQzZ4UGo4MTRQ?=
 =?utf-8?B?eGxDcHRnRUt1RjdyYm5qOWhtNmlGSy9RUFErazg2RE4vM1ZCYlVqbERmVVV5?=
 =?utf-8?B?dW02YkRtUkcreXFtcEgvWEs2Y0hWRE14VjEyVlZtVkR0LzZJK0hHZjhIRysx?=
 =?utf-8?B?NEEvdG9ZM0t5eW1ZNmE0L2I2SXhVYVJuTGZidXNKQThDdk9ZZEdGcW1mRFlT?=
 =?utf-8?B?VWlUWWxBOWt2ckZxSmgwWmFhZnF2UEZUaUh1MDVxNldXRWFtYldHZERWTkwr?=
 =?utf-8?B?dHM1UnVqU2FqMjJoU3dMTnhJTXBFTVV1RENQeERHSWp4Ti9OdUhyOWF3MW0z?=
 =?utf-8?B?K3p1RVZEOGF3TzNkNzNlVWw5d2tuNGswRlV4S2EvdU45QmNWOTRzZHJQRUhS?=
 =?utf-8?B?clR6QVpiM2hjVVNHaTdjTko5bHlraXZMOGxtVWNialQrZUdSakRiRGEwYzg2?=
 =?utf-8?B?Qm9teXpsSEhvSUhBV3liSXEyL3lIYjFzczZNTzJVSEpoZW92cGovbXRmS2sv?=
 =?utf-8?B?bGxqNFY1YzF2RFpqMDVpVnByZTk5cmlQNTg4RUFjS2xlU2VoRzBCUnBBMVZT?=
 =?utf-8?B?U2hRdDdGNUtwOXo5cXNyNTV1N2gxYklxOUpHNHBLa2xuUWQrTVRSZTZPTC9O?=
 =?utf-8?B?SDJ0eSs5bEFjbEFqQitlU1NBTnl0cnNVbVRQbmhtbXdSdWVyc3N6aE1SY0hM?=
 =?utf-8?B?UGRhb0JmRlBqQkZlNXIxNW1rNERaQXRYelRVWE1GM1lVTG5JNzJXWDZCQWJu?=
 =?utf-8?B?U3RRY0x5OW9KV2dJZlBJQjJDT3BoQ1o4N1RkMFRpKzdtOWoyMkpUdU5kU3Q4?=
 =?utf-8?B?cUZxUGJtUFhoeDdFWXFDbE42NThVNk1rUkNublh2Vy9qTE5TU1NFNW9LQ2lw?=
 =?utf-8?B?b2tnVnd5NjF1YTBobmpJRDlpbXhaR1k3cEhvSmRWSHBkOTNYbllzM00wQUpp?=
 =?utf-8?B?Qm04RlNRbVArNUlCTW1QYkZrOTM4M1VVQlh6WmtDYlAybEtuSHlKV2JiK3JK?=
 =?utf-8?B?N205UVk2akxHajlQaGZpWlVqSXZVRXczUEVvRTlEWGNpN3ZhZXJCRWNqRmRR?=
 =?utf-8?B?SngrYVBBdGJaWlJCRXFQSHd5K2NKQ3NHckV6WkpCcDBJVVowQnd2S2lJMjUy?=
 =?utf-8?B?OENUQkpVN2IxQ0xoMmh1SWpXN053dDRmUHY1b3pkZkoyUXF6ZlFkUVB2NVVG?=
 =?utf-8?B?dEpKdXNQUTVxaWQxa3RVOGpVOVo1VG9YZWxybGZwMDBwd1hvSEdnMkFTeFFW?=
 =?utf-8?B?SW1RaXRoWmk0amxnTExiUGw5ZGRTNlNTRjIrSWdYY1Yvb3R5R1UwS3I4Y3FE?=
 =?utf-8?B?a3R5SWxGQW42YUJrajhOaGpyd1pHWFdUTHRYMXZVaUZvUTdwbyttaTZSK291?=
 =?utf-8?B?S2tNd0ZyMURnQVU4b210NGNTR3RIU2pWOVV6YjdZSHRHVy9SSSt0YisrZElw?=
 =?utf-8?B?cGwzRnJWTEc4QzJuUGN5N1hpVjd6NVFwY2ZuajMxdzVHT3FuR2pYZk1ZRDZO?=
 =?utf-8?B?aU45MFZpdlZSeEdyaEdZMkRROFdIYlpxeVBNQlNCUzVZN3ZuVVQ0VE00SlNj?=
 =?utf-8?B?alFybUNtVURqU2F0S25SSUZqSFYwajRiRitzK2hqQ2RtcE0zN25CSGxxRWFR?=
 =?utf-8?B?bzB0ellrZmRRQXczcnlQN1Q2aktraDhBYXI3Z2xhdFBvZnd0Z0FCUzc2alIz?=
 =?utf-8?B?OTlMWlphbHp5Yk84c2ZBZnBuaFlkd3p0REFKQkIrbGZETDFIekJ2aDVkc09L?=
 =?utf-8?B?N21XYWxkdjZrci9BdnQ4MUxZNi9iMWVtQkF0RUVCQlFGdHd6YW5FMlM0ZFc5?=
 =?utf-8?B?bUcralZ2S1ZuSDR5U1pic3gxSTl3M3FVc1JJRkoxeFBaeGVGWjJuYnA3RElS?=
 =?utf-8?B?RXhMOFVZeU9FQ3NsckFkVndWWjF2WFNYeEF5WjJLS2k5Rk1mWTEvYW4xcTh6?=
 =?utf-8?B?YitNNHRUM015RzRPbDcrcXhIUm1scmd0am85KytmUnFHTVQ1Q2RtRXVUbXEr?=
 =?utf-8?B?Wm9lTnFWbUhHbWhjRENjR0RWZU1EaWs4WnEzeXlOWlNXYkx5MVVHcDlrb2p0?=
 =?utf-8?B?b00zOFlJbDRpNkY5aTF5bUZoSndYTS92aThIdzRZb0hTQUJDRzk1ckE2VFpr?=
 =?utf-8?B?dkFVWnNhVE8vbHNNMmJmM1FNN1d6UjVFWEM2UGdzbkhkM2dSRndNREVjMUc3?=
 =?utf-8?Q?iFj2IOl8D7tVRgjVBRjJ8ss=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5a6d7a-3c17-447e-3324-08d9c925feee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 10:45:27.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AY4ssfyJZvKc775qTfKAghFdRbsVj55u80yWClyhx+MMRA+S0XPKQpr0C/03Yh3xFI61S3tBnt8F1QssuXDq/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3554
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
asynchronous processing of blocking locks.

Currently nfs mounted with 'local_lock' option use locks_lock_file_wait()
function blocked on such requests.

To handle such requests properly, non-blocking posix_file_lock()
function should be used instead.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/nfs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 24e7dccce355..c9c974ee2f43 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -769,9 +769,11 @@ do_setlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 	 */
 	if (!is_local)
 		status = NFS_PROTO(inode)->lock(filp, cmd, fl);
+	else if ((fl->fl_flags && FL_SLEEP) && IS_SETLK(cmd))
+		status = posix_lock_file(filp, fl, NULL);
 	else
 		status = locks_lock_file_wait(filp, fl);
-	if (status < 0)
+	if (status)
 		goto out;
 
 	/*
-- 
2.25.1

