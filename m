Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74564480571
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Dec 2021 02:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhL1BAH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 20:00:07 -0500
Received: from mail-am6eur05on2138.outbound.protection.outlook.com ([40.107.22.138]:36256
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234271AbhL1BAH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Dec 2021 20:00:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4JvwsNswhw5WdOs7D04kQ1gZgPhPac0N2aE192aImiliCJuCBWYsXBETqorq3dvBfFPoCt71gSJGo0yAll3ksnT7PWBZVK9f63tQ5LNWB0DICHbfHtgzYC5fDfIL5hszWhTaPdZi83BRWpMqlmG5helnOXSJXVlS52XP1ag/wdLpsOZVpz9TXhNLLeY7IQuYz/9l10p52KCaUag4uoEczyWuyZr4FmJJAkc/pQbj0fIIC/rh1L231Zl3Na9hMQIv02StFVLCAawkoTkvhBusUv5QkLuOjjiFl9K0O/kywZcDSmgczNrRUy9tdhrR08GQzwWPJN3DZEFf9kVUDI7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBdDdMrwg+bnPhZhIgVBgJUgS56T9RfafXEfKuSHWTo=;
 b=TFc/S6bNTsgtYJjOJ2B8HRqzQXE1RYjcrK6Zi5zwvUqrenIbz/pTGIPfbIbKFg2FcEv6heOD45/bwMyBXS7LSf84owE2vGoMtBsZCFUNj1KdgV3y6CwWrCBvToR+Huu79Z2KF+KTMkkMiiLSSSNv542UrYbx8rxrOuw88Z0nRoG1NxGa1S7AhNCRJ6gzMWR4H6Hun28fdOFHC+eKUWuqDOyjSg+kHdPqu/McDMdcR8bGPaFL8ZFQXbELW2vCSu1gGgftDQOVmhGh7s96QJzZtv71T5nkB8tQu7jbzSmierGFf1vuhhmUISqzM5SZcR6Y2Qr62DA2Q/xd59Rmj1yRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBdDdMrwg+bnPhZhIgVBgJUgS56T9RfafXEfKuSHWTo=;
 b=hpmPrUPzMKdrXH65x1lJ6Owsmz3hmaXXR7uN4G6JQX3EAw2ZPdP9yeEkMt8WxYguSeBRkI4Uz5u1I64x9fmNIyCKykMm4cgWJJGUeOOdBNlYZ2QhDFWVQLDyVhD+RP9U/LizGmVZzpxaMqR40GWjHc8kM7d5zRIlE9z9mbzlUaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by AM9PR08MB6754.eurprd08.prod.outlook.com (2603:10a6:20b:304::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Tue, 28 Dec
 2021 01:00:04 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 01:00:03 +0000
Subject: Re: [PATCH v2] nfs: local_lock: handle async processing of F_SETLK
 with FL_SLEEP
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     kernel@openvz.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202112272042.Xlz50x0x-lkp@intel.com>
 <3e5d6777-9365-c853-071f-3e9fc4df922c@virtuozzo.com>
Message-ID: <2305d90b-d1b2-6924-7d93-b29848eeb92e@virtuozzo.com>
Date:   Tue, 28 Dec 2021 04:00:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <3e5d6777-9365-c853-071f-3e9fc4df922c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::28) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f95a30ed-c036-4307-131b-08d9c99d61c0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6754:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB67541E4F7BD6F3060D19A615AA439@AM9PR08MB6754.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 493g8wxAPvIsda+u3Hy6OUy48w+YhYu0Y9LMHxJreR1JGcCh4bB4Uy495W2wpcsk26fIwcpBd4LYL6KDW6CTk4NFIzfeFUnGOWxZD0UHsZjxi7Zgho8AwLP6GteFRC2/BtgYZTDuAXIMogHDYWD49uhzAnANaSQxaMPlDCG1URiRygWnB+sDSMyDgbsUFOd+GwKwCvu+v0OOjOlPQzjS1FHUBQ7URp0dKNwdNeDRk89zb2WfSxfSUeEdZYvJVwnc8ZO5ZPhUhsh2e0yTNXj10Ohw2XIsD9f9ElFcyiDjJSpxna6qmBjc1dPHGCZy4jCUEcmb9LTnMePtIN1/eOLx6ZIOTAILDpJv6K9WzWjKuLz4Vx0EK+0OznOsjk6gR7JelF3b/vv6c6mWc09mehhuAYfz/3t9U56cKDBghcJhOoNV9XT4JKlMzHBnayfnm6+XwVLvC14It63L8lIX+1+W1UKi9LGUFhKC+iRSh0Y9Sy8KD1Tqgmt4tbqTt233242sCXReKNO9MbqF6+jgL9mSwRpOqQ+0SiF0xhHae6CX/P7CrKTuGkBA+P1SBz869XvzFgOS0las7D7YwQhFlhMfKD+9aUxe+p1el53uOlyjOyGXcQ8zzE/6+UYBTHjFkEwLz7Go8bvF+azkxraQ5iaYSifCsRfXlfgz3RseHRdtTRyPcwmf6xHGGiH8sCeX3amQXhB0PRyizH4Kbyg6bEihmvxTG8V9PnnkhMHZTmgu1fdQ/Ut5vvdlkCvBsRWuFxL4+/Wv6wylIpw3582yPXgd/mttPpVLbpJPyLwvaUKs4y8pX53FF2+MrYFxNXOzcZO/hVkq8bbC/U5G6RpqU5l/lWGXfsFtrZdBQ1ChnXZGrng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(8676002)(966005)(86362001)(186003)(6512007)(508600001)(36756003)(53546011)(26005)(6506007)(31696002)(66476007)(66946007)(6486002)(66556008)(83380400001)(5660300002)(2906002)(52116002)(31686004)(110136005)(4326008)(38350700002)(38100700002)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdYWnFoOUF0VmVWVVhIbHlBSUF5aENCYTNtbGJ3TC9ieDVISmJiZWEzcWNG?=
 =?utf-8?B?OTBtSzNGWUx3VlBOWTMycW1kcndTRkwycGNZOWwzM29QTEQ5MEhuTE5LeVRF?=
 =?utf-8?B?WnlUTmNQcGpaTXVOcVNuZ1VJVVZHaVRNcHdmL3ZjcnJQL3pNbGNFaUNJdGZw?=
 =?utf-8?B?b1YzcEZ5VU8ycVIyUHZSY2taYWZXUm5zREdzRXpudXd4dFpXMUZoT0FtRWNk?=
 =?utf-8?B?TXFhZkhvYUFyMkpJVnQ3ZG9WejMxVzk2eEhPYTZKZ0hoZTJndEc5QUFXYmI2?=
 =?utf-8?B?a291aEQ1bU8wdDBxcGRDdkk3MFZtLzhhQ01WYVBzREhqWWxjYVNiam45aEVr?=
 =?utf-8?B?R0xYK3A1MVorNzJPd2g1RnhPdHVCTGp0eG5mSG1KZE15WUdUTzVvdVNnazdF?=
 =?utf-8?B?eGUrSG1xc3NNL2Jud3BSNWhsS2k1R1E3YVI5azRIYlZRMW9EU21WNDBNK3V5?=
 =?utf-8?B?OG02K2JJanlnR24wS0QzVEFrZGhrMFljRCtoWUZIOFAvQVl2YWpqSG9JNmhB?=
 =?utf-8?B?WkJVaXhKL0cyUGZYNi8xMENxMjBkNWNvWGp5Y0JkU0xEbml5aWxSTmhaTDRP?=
 =?utf-8?B?ZThlcFVmWmRvTzdDazFSQy9hcGIwa2RXSlFpWmVXVkdsNFNRQzhzRXpYaWd4?=
 =?utf-8?B?bGliQTMxZXhHWndRVWtKM25QdE4zTWVwSFlhREpFdE9Cem9hZXhWOG0zSDNn?=
 =?utf-8?B?cWhZSEU5MGJLb0ZuZFhqeUhSWlNweWNCZHJleHNBTnAvZW5xTmpCMm43R1hW?=
 =?utf-8?B?MXQvM1hMK21rSkJnMVJHelVJZnpMdi9kSTdWa3g1SHpYRURqU3l2enoyQ093?=
 =?utf-8?B?dnROckp4dm1MNlFQa3BNN1UzVklqZkFHUjJMNVpkaHYya1dicVpnSHZUUm5x?=
 =?utf-8?B?ZnRUU2Y4eDZ5ejhRaTN6Znd0RU9RWG9TelE1azRTSVJaRzkvR1lkQ3pJWTBk?=
 =?utf-8?B?TDRIejVjRm9nbk9JNW9YcCtDcGZZVGZNQ3lmSUsvS1FRakk0ZitYdURTUzN2?=
 =?utf-8?B?Mkh5WEY1clY3N1dMdXgzYkZ2emtvZVkzdS9SUkJVOXIveGpZd2NiZitjVW91?=
 =?utf-8?B?YkI4ci9TMTJaclBiQmpMREJPR3ZtUVJNdkVDeDhBWDlnUmxZZkFSdFA5QW0v?=
 =?utf-8?B?Y3BMaVcxYUdyRGF1blYxQ2dQcG1zcUtJMjVUdFROSndsd204eXJIbEdwVmRB?=
 =?utf-8?B?aW84cTJIT0FnV0RLb0Nmd05ZVG12MlhHcmM2cmF1bzBYaU9LZ29aSzJFVXlp?=
 =?utf-8?B?aW0yODFxbEFiemkxWGZWQ3UzMkdFclN0Q2dGRTRNY1ZLQkdSQUd1a3E3dStV?=
 =?utf-8?B?Rk1GVk9aZ08xMlFMN0MrK0kyL1N6TWpLbzVNWldZWkJHaEJMRWEzY0pOR0tP?=
 =?utf-8?B?SmZoMDNYN2dudzIxMStFQldqTVNSeTM5QVZPaDBHMjVsQWptbCt0VmcrMnc3?=
 =?utf-8?B?ZTJyZlRmRWpvVjRhYXIzSHZ4cW05RnBvam9iZUE3LzQ5WVpPancraWEvMHd0?=
 =?utf-8?B?QkpwOW1oWlVRS3dNdC9tdnM0L2JJcTlvc0hERmR2WGs2a0g5SFBZTXluRlVm?=
 =?utf-8?B?TDJsVnhEOFQ3OG0yMTZoUUlHMnFYOFFuTXphVkNraksyeU9oOW52WFdhWGFw?=
 =?utf-8?B?TnhrWmxVNHBsYXVyMi8yRGNUdmxxdjB2SHBkd0JkYWdNbXFMWXlyYjRBM1E2?=
 =?utf-8?B?ODFhRGZGVDYybHhocEFiUUozc0J1c1h0Rzl4NXNvTFcrbCtyZ1BWRldSWGJU?=
 =?utf-8?B?YU4vSEZWZkFxaHpwdVNvMWE3ZWMvUnRVTUwxZVh4NmJWbmQrdElkckplZnpX?=
 =?utf-8?B?dlQveDN2SUVBbE9YRDk1L3NSdWJ1RWMxT1ZROGpRYmFQZGJjN0tQYURlZVBt?=
 =?utf-8?B?aGJuQnUvckM0clBOUnZCNnQ4LzM4cVZCRnA0WTlMWWl0UTVGQVdLNE5wYm0r?=
 =?utf-8?B?Rnc3ZkdKS2ZpNGsybU1ZVHVkS0FueG5Ia2V5L2paaU9WdUtvL1cvcXJLMEZU?=
 =?utf-8?B?ZmdZczJIOFMxenBRVEJDdUJiUWZwdmh4a05GaDE0cUYrMEFYR0syS0FWMEFh?=
 =?utf-8?B?dkdtT2Q4dFVsM0o2OVE2UDgvRmR1eWdUYVIxbXYwampkUlV0clJ3QzNJUzUr?=
 =?utf-8?B?L21oVVg0N05kZE5qSTBNczNRVU12Mm03eGZCSnZ5UE5Da1p1c2NmWUJGc09W?=
 =?utf-8?Q?sthfM0vh5t1GRN6RI1Bd9o0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95a30ed-c036-4307-131b-08d9c99d61c0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 01:00:03.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lajGKY9/kJV2+ki3xD0zJJCtGOUpGri1KuwjaRxw9fLOcX7cO5a+GPe1rL1riDKOmY7VJuQbDFPRljw75YLHww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6754
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Patch is wrong,
I missed that FL_FLOCK are handled here too.

On 27.12.2021 18:50, Vasily Averin wrote:
> nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
> asynchronous processing of blocking locks.
> 
> Currently nfs mounted with 'local_lock' option use locks_lock_file_wait()
> function blocked on such requests.
> 
> To handle such requests properly, non-blocking posix_file_lock()
> function should be used instead.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=215383
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
> v2: fixed 'fl_flags && FL_SLEEP' => 'fl_flags & FL_SLEEP'
> ---
>  fs/nfs/file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 24e7dccce355..38e1821cff5d 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -769,9 +769,11 @@ do_setlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
>  	 */
>  	if (!is_local)
>  		status = NFS_PROTO(inode)->lock(filp, cmd, fl);
> +	else if ((fl->fl_flags & FL_SLEEP) && IS_SETLK(cmd))
> +		status = posix_lock_file(filp, fl, NULL);
>  	else
>  		status = locks_lock_file_wait(filp, fl);
> -	if (status < 0)
> +	if (status)
>  		goto out;
>  
>  	/*
> 

