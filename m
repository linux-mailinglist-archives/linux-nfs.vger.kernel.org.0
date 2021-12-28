Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B8480573
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Dec 2021 02:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhL1BEg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 20:04:36 -0500
Received: from mail-am6eur05on2103.outbound.protection.outlook.com ([40.107.22.103]:55904
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234281AbhL1BEf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Dec 2021 20:04:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihmUo0AqlIKe/9Jybrow1aiSUUtt+yEgp6LNYVK3wDjlfd2felS7zEib6oThLWsdWDwbZ9/dUt8nNOAjaA7kNOE9Ani8ad13u8Lg7Gt24K6KDVf2LyENLdzsFjDgjYw2nyoahqMZKEvpjKtFfJ7jau2J6WdoEW/Ziewl2gUkoBngVhdRBVFDVmUoelOnYrFQMErY/wXjbcXYp2wvCCfCnCDtkK9snBy+00aHEFkq+o9JOPQd8tPvT52EUpRWMsiUK6r30oMHd9r1BxIxIRWn1RSGwSg1IEfrT5Ta594T9SQaLzAiwcmMUcDWNJI9Zlij2bjs9WJogh5Mc2oin1lKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSODbdyefvli/Vkww/h851DGk1d+UtGAl0FBZ6FsIBw=;
 b=YMpaDvGA6KwUciLyEUwGvC78GA7Kwc5P/SXtBCn08EVGT3s8Vo2+52LVlZ3sE3qUkU65KKP/5toxZEeCBBmSUNxh9b2wgdl4c/Xh2URuQzvFlYmnBdzRBnmzfbvSZPXgmEDju/+BkZ4sdrztvLbnW9mndY5I8FdEuRXrTqYZJyhxPSuPTvYV4qVyGMB6qwoJamdjxNgt9jFo8a9PHKVulB0kA8o0vgOMjNJk2pBfIw7f2PMzCojYI6VrYZFCuqtvCenS9icwUhJMEBpctGljWbRBr6midOROIQdbYIZLmQTdySHmMJd7mdRZR7AaRHnwDTHr9lbGgyPSzJVUvxRwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSODbdyefvli/Vkww/h851DGk1d+UtGAl0FBZ6FsIBw=;
 b=khytdUqMmvRIloz3wo6GUJ5ZhlvIAPou+tT1ce5IZyPE5NlqWgZDU6aLND6QSqxm07Djr/DGSmgXJJzr89MUc11xlqYp1QcIanXH2OMZDbKvCsGWt0hdSdtGZhT7S6W9487xGcQybDgtYTnAL1pqW4AKNnI2zCrWr8TGvbBDNJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM0PR08MB3652.eurprd08.prod.outlook.com (2603:10a6:208:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Tue, 28 Dec
 2021 01:04:30 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 01:04:30 +0000
Subject: Re: [PATCH v2] nfs4: handle async processing of F_SETLK with FL_SLEEP
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     kernel@openvz.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3a2c6cb9-abe7-ab32-b11c-d78621361555@virtuozzo.com>
 <c2ef5a47-85b2-3a98-020f-766f153a65d0@virtuozzo.com>
Message-ID: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
Date:   Tue, 28 Dec 2021 04:04:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <c2ef5a47-85b2-3a98-020f-766f153a65d0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0054.eurprd06.prod.outlook.com
 (2603:10a6:206::19) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 419833f2-0332-44a4-1131-08d9c99e0078
X-MS-TrafficTypeDiagnostic: AM0PR08MB3652:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB36526E3C2361CC61EE0B9CDEAA439@AM0PR08MB3652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6BWhlBOyGgWTgwTDDC1nPj0VqavRBi86Gz7q/m1R7KVjbcoVLYR3S2LkfHuSgGvlA6tcVQ1zfMnSIpD4uVdYGP6HHKHNIT7W6NtZT9ZhztJdvyS17yU+EP+t3bQgGki8iJp63As8wtfB6lqzBvuvCyTUPeyamHP6Igd88uFT176a6RGLmj3lJ6vmN0SaHkdjm2oy7114MkU0EfNeo9aRpxa3oC25ArQjDAC929P4M4TOZ2Qu11FvPH9Hll4EBqgDLliZ3jCIOm7BTMdZ8lgkgj+Mqj1TzHl4WtYTrYNBCgc4nPcK/1Pa0vCDYEuy39s8rKrNk00GhCEp5HUH2gPqVazyIOGbk4B5WJmzgnlb3zWJCWuECxMfoG2yFKwpuTTgsVWxUwXTC1RNGQsktwQuIG2mfsxlZZSKEkJ4IV7rcTdeSjxpSimYpZHxzuRS6DQEsrw4o5td3XkTuMeGaBG2e3WNE976vajfXN3UYnkQaNhQoTckdzRi5xnahpq76YBp01I7oGatLz6p3Cx7mznZ1Ck80DRAm+Ji+5MWHx9Sh5kKw7e5mo+gmywJ6nkikYJyzL0nSTj6RFyR7P1phNcSelixr6Rl522ioodkIP2pWvrNUL9ZBZk2qIG5+g1Ak0cVXBJi/Cb0RoBTmDirDskW4o4LuRp3QrcniRoH6h3irO2X0cDQc6YnplgovLZS0YlJsqFMmWpxZ8UQzj02NHK8Z+nP1bfQcX0LVU9o4DZf3EOa5/xTUgr4ZLsvBGLxVF5bPfEaXAlwTz8AJ2/rxU6LBe2DXJ14dGVEWB9rdGw0uSG36/DTnVVVMeEoUsQNPZD9ey2mThBNVv4o2HSSoXF8TLYkElXiYXxW0zb7oOfAj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(316002)(110136005)(186003)(6506007)(38350700002)(66556008)(38100700002)(66476007)(508600001)(5660300002)(66946007)(31686004)(52116002)(2906002)(26005)(31696002)(6486002)(86362001)(6512007)(4326008)(83380400001)(36756003)(8676002)(53546011)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEhPdHdWVHVKSE0zc0U3TzV0VUR3K3JuZFZjaXZGYWpLR2dCcjdYWDJRajJz?=
 =?utf-8?B?a1NuYklrdkJXOEZRbVFUUWZvYzZkcXJOL2NTRkhhN3V5R2YzZVlrRVdtSkgw?=
 =?utf-8?B?UFFRMXZJTy9wVTFJL0M2NWpxQVZ5eFhSa2YxbzZuT1UvK0V5NkpZSHBEWXcx?=
 =?utf-8?B?V3o0Z3ZTbEg1RjlMS0NoN3Q3OE5TWHZwOXhlS3dmTDZuZjNnNG41NjhaQTA0?=
 =?utf-8?B?NUdBaDFIQ3dqVDFPWlhockxBT3ZYUjRyMnphSnVNaU42dUg3UDZTbTVzbDVn?=
 =?utf-8?B?ZVgydE55M2w1ZHRacnVZa1loZHNUeXJXYWZEbXVIQVN3Ymc4NTFES3JiSmpi?=
 =?utf-8?B?SHg1RzcwWkhjVE84bkgxeGlqdEUycGJDK3F1OUdpOWZRMkljeVN1VEtNbVNh?=
 =?utf-8?B?cDlEUFNyQU9uVlVTR3pRMDN0N1RJTHV0NzFmaUNRUkpKVjAvRkYvb2NoYlBM?=
 =?utf-8?B?TmtKUEY2cVIxQ0VVdDBuSVI0ckdiVytqNWtPdm5MWXJzaXhuVVowRUUwUnJ5?=
 =?utf-8?B?ZnVablRTdTFiSVJHQmxNTmJSMzcwSFNaU2VaejRVUW81TnU3UEZSL1NlNXhy?=
 =?utf-8?B?NmthZkpIK25POHRFK3V5V2JoODZURGxlK21RTFlXbnNURmtyTnVlRlI3TE9C?=
 =?utf-8?B?OEFqckZ3N3p6S1Y2Vnkwb1RvenpLaXFuazh3RmZVWmhtcWlrNFFXMDVSSjFa?=
 =?utf-8?B?dE5lRkJubnF2MSt3RFVIRitSNHZPV1QxUDhBV0N0Uy9hZmN6WkxTYXg4bHVj?=
 =?utf-8?B?YXNDWjg1MEsrYUpoUVhEZ3JLOU04eXdRN1I5VkFUa2N6RmtWeUxldmtDL0hJ?=
 =?utf-8?B?TzhZbmZSZm1QT2psekpXdTdCTmhGdlJnVzBGUVVuN0YyYllPWTdzWHZ2M0VL?=
 =?utf-8?B?Zm9YdFJMS1A3QktHeG5wSjl3N1Qva1Q2TDN4Zk51cldENlJYYjJBNGh0cmlq?=
 =?utf-8?B?WU1CYUFaUDFuMmk3OHYvYmxjUFlla0ljMWhMNjBFeExmS3ZGSXI5VzZUdHNE?=
 =?utf-8?B?d1ZqSVVHYUNBV3ZzUzJmdUpZMzNuWlNaMkhFZEt4dE5rM0x0OHBxT050ZUFl?=
 =?utf-8?B?cFRsS0hiVENhUWcxdGVIZDlZdGdETU51VVZTZFA4UzhFaU1vaWpIN21yb3Nx?=
 =?utf-8?B?SlpQVm5KakJsdUl1dkRoZCtzdHlRY1ZmWWZWVWJZY1Q4Vy83NGZjcExaV3k5?=
 =?utf-8?B?cm8vNHEyRHIvS2hrK0F5NzYzaUtQYmdyak5RK2VvdS85R3JmWVNrczZGb2dv?=
 =?utf-8?B?dkM3UDF2bFZid216dFY5bXdJMnJtQ1ptWDZBMVdZK1l2OXl3ai9tQXllSHgy?=
 =?utf-8?B?Z2EwNm9VS0UxMGJTeEwxTnhaTy9GZjZiSWNGWHdoMCtlSjF3YUdlUkVRTmgz?=
 =?utf-8?B?bHNFU3UvMS9VM0xDcTdyVTRCNmZoUVMvSEZyTjBIekFhY2VlQ09xdUQybS84?=
 =?utf-8?B?cTd6NVNrRUZNdUdlWE1jMUhnVDVWMTFYVnJCL2EzOTNkcHNxanBJb014bUR5?=
 =?utf-8?B?aVZOb1pHSmNRNlhCZFMvQUo5MWFJanhLbmJyOTZoTnIvS0x4MnVNdmdraU9S?=
 =?utf-8?B?ZDJZVHo5QUlPZTNzbFBGZU81ZGtxRkV0emhoUVNBcXNJUE5ENjFtTWNBa0xP?=
 =?utf-8?B?OWwvUk00YzlHRDE2WGFqYWE3RlFITS82bHUwMDNSRTNKZUd0UjF0azFQMDJE?=
 =?utf-8?B?OURZNTNzUzVZOVFCRStyeWhwUnhpRXdvY1BaTGZzNytwd0lXTGxXTmhkT3BW?=
 =?utf-8?B?Zm0rdm9pWHdYcDc2aC8rQUx6YzU2WFVlWGV6Z0NlNTRCOFR6MDhHVHJuT0NQ?=
 =?utf-8?B?dVNQbm1YcXBpbzZQcmptdkYrZG9reDhsZko5MU16N3lQd0VKeGZpOTltR0lH?=
 =?utf-8?B?THgreVljTE5kRU5UaWlwUmJLZmoyUHNjQ3l1ZUg1dUJiMVp6K1ZIRkpZUjU0?=
 =?utf-8?B?TGwwTy9rUTBkQVh4elBnQTZOdmR1dXVzVHpmRWh4NDZscnp2SGxrTUhUc3BP?=
 =?utf-8?B?dFlnNkRFaldtMUFqOHNMWlhaOWxxV2psdEpETXUrK0JoTUI1eVhhbkw4aVkr?=
 =?utf-8?B?cDEvNnhLbmZyQzU3a0lhRExXT3h3UWtzOWo2Q1hpYXdHeTNmb0NBYXR5Nzc4?=
 =?utf-8?B?ZjloNkVLMUpzM1JiaitML0ZlMURRcmlaY0dOVC9Rb1E2UlJDNEo2K1g3RTVs?=
 =?utf-8?Q?vHRvW0dGNVyZCWauhQ5m1Vs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419833f2-0332-44a4-1131-08d9c99e0078
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 01:04:30.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7ks5+gbbpntppot+PgNPVK6cdUIWO0vo13HTNPZYWJVGitbLLP4MZsJOjFiTitrErMgMEcPtKE2suTLXTDwAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3652
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Patch is wrong,
I missed that FL_FLOCK is handled here too,
moreover locks_lock_inode_wait() is used in nfs_proc_lock and nfs3_proc_locks,
and FL_POSIX request for nfs v2 and v3 can be blocked too.

On 27.12.2021 18:51, Vasily Averin wrote:
> nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
> asynchronous processing of blocking locks.
> 
> Currently nfs4 use locks_lock_inode_wait() function blocked on such requests.
> To handle such requests properly, non-blocking posix_file_lock()
> function should be used instead.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=215383
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
> VvS: I'm not sure that request->fl_file points to the same state->inode
> used in locks_lock_inode_wait(). If it is not, posix_lock_inode() can be
> used here, but this function is static currently and should be exported first.
> 
> v2: fixed 'fl_flags && FL_SLEEP' => 'fl_flags & FL_SLEEP'
> ---
>  fs/nfs/nfs4proc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index ee3bc79f6ca3..f899f4bcdae5 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -7200,8 +7200,11 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
>  	int status;
>  
>  	request->fl_flags |= FL_ACCESS;
> -	status = locks_lock_inode_wait(state->inode, request);
> -	if (status < 0)
> +	if ((request->fl_flags & FL_SLEEP) && IS_SETLK(cmd))
> +		status = posix_lock_file(request->fl_file, request, NULL);
> +	else
> +		status = locks_lock_inode_wait(state->inode, request);
> +	if (status)
>  		goto out;
>  	mutex_lock(&sp->so_delegreturn_mutex);
>  	down_read(&nfsi->rwsem);
> 

