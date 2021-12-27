Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DAA47FBE8
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 11:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhL0Kpt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 05:45:49 -0500
Received: from mail-eopbgr80117.outbound.protection.outlook.com ([40.107.8.117]:1701
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236198AbhL0Kps (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Dec 2021 05:45:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHCDOjATKEHhjeIXkwW++O9lxJVHVShlXXosWknNURBpQrmVG4UiI9xk823tdlu72zFkQhpQcRUZcN0jQOokCtw6LpckeIh4Bu6sJKP0oPjppkht9Ey5uvSVRJ6POiU3h8gv7PTT9/TmcoSU4rcw8vnbqjIfNkkuYGpwfMXcSz03rSEVmybsURVdqTWyM9dugwyUdjpiYuEmPlRdbmej3LUBF+se2jhGz3xFhIirA20j8/fTG+MFqzexXH+9KhdIkv7/KMZaGy/mM4LrLqVdScbu5vTf+yEHv2mxYo2xSy555A4b2lQlUSY2EOHhtvJymTB8eUbcdz7RNRlenykucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekK6Y/8cVnUdLKtW9Rw6iwP8haapycKjhmqvbrLdjW0=;
 b=fSWDzAdHEQe/9stIm01+Fk1JcHy4P3xdADbXjKmlURG8DR85RIPr2DHIsRXTEm1mH5mhYk8G3tjtoZPaqfaXeQ04kN7s3TT2FJOlXHvvaKthMd5df6UErYjszCITBeXcRNk1lpYK8fV1vkLZpWdmIlg6/fsE3sDWFc7DsHK25Qg/cEST3683ClECs307ymfoVTUDvrjUIyMzoSUgSiEw/6fGE/odV719etZMxrre+el5WHB9Yoq52S4SmV+DtKebqG9aIoq7fiOxB7ekUNXeBccObKgKRHYsEe39YznxikWVpnt+zVp8+o87O5ERt/OwkRptOzDJ8BgNt2Nx8oojSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekK6Y/8cVnUdLKtW9Rw6iwP8haapycKjhmqvbrLdjW0=;
 b=rKhL8xt4j28/mcnycVxq7C1uJaIzLiYkGXi1kCUS9Drc31mbMrAFY5E9yVMhvQ2ySkKu5GJAz114vB4FEL93scNMibeVd1dbTWAFAQUoBDktLvll3T5SxN+2tocUMjIhCinmn4BjilzpWYhE4WSyj91+HGqGW4cwiluvBzZrZGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM0PR08MB3554.eurprd08.prod.outlook.com (2603:10a6:208:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Mon, 27 Dec
 2021 10:45:46 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 10:45:46 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] nfs4: handle async processing of F_SETLK with FL_SLEEP
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     kernel@openvz.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <3a2c6cb9-abe7-ab32-b11c-d78621361555@virtuozzo.com>
Date:   Mon, 27 Dec 2021 13:45:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::27) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14dcb62f-9c9d-4c14-73d3-08d9c9260a28
X-MS-TrafficTypeDiagnostic: AM0PR08MB3554:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB35543C97F03133FB8A1BE310AA429@AM0PR08MB3554.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z81RkCGiV0agoGpBOUcL2u0KXn8PVk78FFV33WxAwp5gWI7zE4PmXrJtYZWzZD1NwSS5pz/2eIK0h9cZzqVRfzzPiOSXHViAeAczWbI1GP+onJgT01mDfZyO32ete4NkndVTz6enSzoZ+zSk4/XT7uMEcwTL9zdWJO+EIqtOUQmc+gUGY9izVgM1RO1L6n3EzBil4/6Od8Z4F4ZS1Ld+ABUyjYNWhcQBqdnECwlVJ2tV7xqGHCZ/xaMEq0OgrT0HUXIvb17TpgejDqLaApTEHXsqe8si4gqhgUQLwU5pNjj+B/FoRovRTiHgqjD3/L3u/AOau3RmCo+d5XIZeEB768Igad72KszO+/mRb+HlSm4EEdtUiI9SP4rEME6bxSsrje4ZoGLik2hG1CEr+rfjlA+6h/w2mLc399GgrQ/3Kh8ffqUGsVAtOGW7pJ3be9Hz/ssRHqlDbfjxVaghGul1+OOzS/xcVA679ojs7qTIrzinWVAqeJlhtiwvl4oeKuxGqV9DaTDrGYOVm4SJiN0R2P6U1sCIamd/HEZf+tOf0k8yCXCXsA/3chnHnAuToazNVD4M+uw/4CZw+VXmDLc+5fBEMg7nIt4LFqUSsekXF/dChjuic2qiau2mcDhMaTMnYMmMofyYcx/CDjWjIk2ug3gIukEYV8M4QSpYx3G+U1mxcZQH1bgrpOF8FFvZamiBm/XWC2tsKzg19UQ4YDLXMaKnqYGlQEdxuH7gJO5wznhc9Bp0cvqR6jyvTj5PzEKZOMMgj0TQ8/Fd9e8n+HimskQDyxVbYFm9Uz/Ews7/sRmVjhUIPI3oyLZe7UPhLsleFDh9HaaBjqhth/pK6f91fV6nxEwbgJ60RBQz1y3QK6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(186003)(5660300002)(6512007)(36756003)(4326008)(508600001)(26005)(966005)(52116002)(316002)(8936002)(2906002)(2616005)(8676002)(110136005)(38350700002)(86362001)(38100700002)(66476007)(31686004)(66946007)(6486002)(66556008)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlU4NkdrTjhydjU5eXFpVU5SbGVVK3lESE8wQzB0bUxuUWlpTXF2RWgxaTZi?=
 =?utf-8?B?djlLV1ZmUWI0VDlzV2owRStmVGQzMy9DcFN5OFJPdDI3TnM2QkIzZE9FZmgy?=
 =?utf-8?B?OUpTNVc0Wlk4b01hYXdZYzZJKzJKd2RSODZuSWRPUWlyZDlPOGFxZHk3VUVy?=
 =?utf-8?B?d2U2b0hjT3ErN0toQVFjNy9jNEJkSkdtT0RHRXVReW5ZMTMvamcvNDJrV1Rl?=
 =?utf-8?B?cmNlV0hkdkdYZkJNK3NiRVViMk1GSXptMEJVZTFrQmZwVnlWdlBvZnMvdGFy?=
 =?utf-8?B?WmNsb0FiRmJxOWJlL1hxdVZiQi9wUkw5UHlaempXaG1EbTExTDVnbzRjSkFn?=
 =?utf-8?B?a2lXVHVRaERodEZjODM0VXA2Y3l1c015ZmoyZ3BpMlNKRnFwdUVkMmQxMlFo?=
 =?utf-8?B?RDZBSUlZYWFIS05YWTJFb1RZeUIrdlhuQmRYL1FPb2NqN1psVWJiZFVFTkYv?=
 =?utf-8?B?aTV5Wm55eDBrOTJ1SHBmcFBFbzlJRlpzb05HK3V1c3phM1U4ajBRNkdpY3dL?=
 =?utf-8?B?eW5sRm40ZVJPK3k0V2hXWVJJZ0RJS1Jid01ESWQ4cVlVd1grSFJDSDE0K3Jn?=
 =?utf-8?B?Mjd6ZTBMRHpkMi9iTVZ6VDJKcnRFTEt5RjhwRG9rZ3RNZFdiaXZ6TEgvSHgv?=
 =?utf-8?B?Q1o5TnlRZ044d0NFVUhGYlhNWHF2M2dlSzViZndzamxPaDBxY1B6WUh1djFP?=
 =?utf-8?B?VXJPZTc0aFg5S0EwOFVITUthdzRJSFh5ZC9qZm96YTc5NVJKeWxsL0ZRQjd6?=
 =?utf-8?B?NS94SllTMm9pbFVZRHcrWHRRelFmNDYrdjdaQjVUanNSanhHc3Rxb3pTenBz?=
 =?utf-8?B?WlN1dHdtaU95Ti9DWi9RTEJrRzIxVVJyYzRjdnhqUjM2MGZxMFdianNwQVBx?=
 =?utf-8?B?ckJnZGlLSk54TE80VjNnUkhxWWhGSzFzeWF0TC9rbmgxeHl5VWhSc01iYWFl?=
 =?utf-8?B?WWJHRDllQUdTSCtwZ0VjZlFmeXFwYUw3czdKM2lRZGJHa3lUSkZ0aXExZGpW?=
 =?utf-8?B?Wm4zQ3I1UndCWWw1WVM2cGxCYzB1OWNESVg2YW9EaGhadERUTDcrU3FjVVZL?=
 =?utf-8?B?dmpGa2NUZHdnZVFTL0c0QW5RRWhJSWpkMWxaMWE4L0VaUC9TazhaZDFDNzBP?=
 =?utf-8?B?MkdlMVNFdzFhNHpCQmQ1NGw1bjZzWUZmT3ZQNFMwMFVjVW5VSVVTeW0zMS84?=
 =?utf-8?B?NWYxalV1Q0FCRmNxTXZLTXZXZVBpS2pOVkNSUTBEeEg1V2pZVjB1ckJpREJG?=
 =?utf-8?B?TEFIVHJ1TTh3Y2NUeFBDN21KMGwvY0d4dDQvQ1ErS09zZktSWmZYVlJwdUIw?=
 =?utf-8?B?S0U5ZkRVcUNqNjZNNmgvOHRNSnlxR0ZtMEllRHB4MERJMjJSN1hUVXg5Qm85?=
 =?utf-8?B?d1NJc0QyMDF2RWpEVjRlOUcrUjRMQ3Rsb2xZUXk4M2R4WEpBY3lvTWdTVWpT?=
 =?utf-8?B?WHBuSE41YTZTMGdqTWk2V2pRMnVKK25qQ3NzRnY4T2xFM1FlS09BaTFwa0Ey?=
 =?utf-8?B?cGJuRkFYd1dTdHFYZE4vK1h3dE5oUVFIYjJYNkRpK0loSExSNjg1eE5hK3VL?=
 =?utf-8?B?TlNCZEFMVTNWaUxUT2RDa2FISWJ1N0NrNVk5MlA0bkVwaVQ0QVRreFpNRFBO?=
 =?utf-8?B?ckNMZ1Q0MVcweGRVZHJ2Y2ZxdFpXTlhyOC9xcW45NXFGdlFpaEpJRkVreUpG?=
 =?utf-8?B?Ymp5V2VjM2xWSEIvaldPamxDdGN4QmU1TWMwM0JSbmk4OEVJZmkrbisyZzVx?=
 =?utf-8?B?blN1MlZ0WkJJWGNwKzZPM3dsZ2hHRERrWld4enNWQVFFZHgrWUI1dWM5MHhY?=
 =?utf-8?B?QUVpOHRDZzYvNVJFS3lYTk0rN1BTTFFWaTdxRUlMd1dDUEt3OHpPdm8wOEJI?=
 =?utf-8?B?NWRjR0V3d0ZQZy9Yei9ScmFQcVFiQmVLcUlCOTBJY0l2ekRsWGtIeXBjbkNo?=
 =?utf-8?B?dmM4M25QWCs0WjZqY0VEMU9oTFh4K20walFpWm1JNGdZKzIvbFd0emY2YnNC?=
 =?utf-8?B?WDNkWDd2UTgwb0draWVWWTlOMFZOZkdIK2c1WXBqTVpDd202RlgxZUNXQnlr?=
 =?utf-8?B?RkpMeWo4aVdsVmlMRUlNZmVnQXBGZzB0TmxhVTlUUjJoeW85UmRUNC8zN2Fr?=
 =?utf-8?B?TFY3L085QnRUR1JVVEtsendoNkFjbUdsVHpGUVppdTB5Mmd1NFRTZHIwZ0pW?=
 =?utf-8?Q?4PCrbgw7no0DrPPu+rewmSs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dcb62f-9c9d-4c14-73d3-08d9c9260a28
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 10:45:46.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47LnjIuoFP1L8g6wTm1PswB7KHt1WGUBmBMsPanLNmNViHnq7g4z5tCL9OtaWQ5rEmge88Gr4j9eVWeS0mFn7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3554
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
asynchronous processing of blocking locks.

Currently nfs4 use locks_lock_inode_wait() function blocked on such requests.
To handle such requests properly, non-blocking posix_file_lock()
function should be used instead.

https://bugzilla.kernel.org/show_bug.cgi?id=215383
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
VvS: I'm not sure that request->fl_file points to the same state->inode
used in locks_lock_inode_wait(). If it is not, posix_lock_inode() can be
used here, but this function is static currently and should be exported first.
---
 fs/nfs/nfs4proc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ee3bc79f6ca3..54431b296c85 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7200,8 +7200,11 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	int status;
 
 	request->fl_flags |= FL_ACCESS;
-	status = locks_lock_inode_wait(state->inode, request);
-	if (status < 0)
+	if ((request->fl_flags && FL_SLEEP) && IS_SETLK(cmd))
+		status = posix_lock_file(request->fl_file, request, NULL);
+	else
+		status = locks_lock_inode_wait(state->inode, request);
+	if (status)
 		goto out;
 	mutex_lock(&sp->so_delegreturn_mutex);
 	down_read(&nfsi->rwsem);
-- 
2.25.1

