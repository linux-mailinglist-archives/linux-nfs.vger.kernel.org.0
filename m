Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75245A670
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 16:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhKWPXV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 10:23:21 -0500
Received: from mail-vi1eur05on2113.outbound.protection.outlook.com ([40.107.21.113]:62190
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238390AbhKWPXU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Nov 2021 10:23:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+2z7Mili8tXP14bX2Gef1OGzmsh8FxFEF4p0NlW+wsc1BIeft+BP3tEYIKF03CUm/5ldsPjz71Fxpqfb6fdLKkN6c+dnQtQ03QnvkdkPC7w8q2gX+WoatROQrLIxpwuPbqbj96SoPDVhv4nu4qqbqhW1/hAsdqdSsZIBlvNVnsKnaGNrtbQjxcjCwLGO8bEAQOkkWFzo50QOQ6pZb0WgYzpYq42QjkrGWITevA0IwdsKkH1xUB5CgJ/vuZEq9vpF5iozspxkWgoozo3UYvTu0ZPWJ+C9JsZnw2NuXT2NhjhImBqFZ7jq5y8LX61gxUkasLZizFIJrMK8qTOlLFN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAEev+69dRwL5NSw+lThH9beqZMdKUFEQwUXJxFE8QI=;
 b=IIganXPOkrMaDbTJfy/ixe+W9DjYAom++af40J5184ihGhr4A6xoSq2+OsCD9LA/7k0JPI/u5QFHaBd3wQ8LaT6teZuzThyGiZq1G4iLvuaFNevmQ22L47KLnn/Jxg47jGxuOdvSF4yB8Smo0NAF0PXzXzP74rX83Rvc2N6Ufx0I5rtAB2tti3l0ya6k/u+p4orxqmd3ikW7POB/l+oxAJjBpHR8YGHP6zpI+8P9ubjR3YTl7mwjrMnE8VNs48I6AELzBsOACQSUe4C4oKAoHeMrikm+gm290DvrQqY9D5Hc0iBIs97N9QkX7vfd/QQbKejMRZ8a21PJVf/3/6wFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAEev+69dRwL5NSw+lThH9beqZMdKUFEQwUXJxFE8QI=;
 b=OiyFEQn2nIBR3Pc2mf4i0IRjH46knLfT7MqsM3H0RyC1EXTIqNntS2DdXRJNMjsfimIHBpBlBLiwPbCsSi/EtyzxKz0945PY0EATogWllzNW16elfkc+KfuO/GqXqwT0jT18UlkP3Ww/9+kYHz4kUCO/Hd8Wz3sM5HcMdeXdaL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB6613.eurprd08.prod.outlook.com (2603:10a6:20b:339::21)
 by AS8PR08MB6964.eurprd08.prod.outlook.com (2603:10a6:20b:349::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 15:20:10 +0000
Received: from AS8PR08MB6613.eurprd08.prod.outlook.com
 ([fe80::948b:9007:a3a4:7d90]) by AS8PR08MB6613.eurprd08.prod.outlook.com
 ([fe80::948b:9007:a3a4:7d90%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 15:20:10 +0000
Subject: Re: [PATCH] nfsd: don't put blocked locks on LRU until after
 vfs_lock_file returns
To:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Cc:     chuck.lever@oracle.com, bfields@fieldses.org
References: <20211123122223.69236-1-jlayton@kernel.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <d3f68639-3f07-dbf7-9a4d-984fdd7bd62f@virtuozzo.com>
Date:   Tue, 23 Nov 2021 18:20:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211123122223.69236-1-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::34) To AS8PR08MB6613.eurprd08.prod.outlook.com
 (2603:10a6:20b:339::21)
MIME-Version: 1.0
Received: from [172.29.1.17] (130.117.225.5) by AS8PR04CA0089.eurprd04.prod.outlook.com (2603:10a6:20b:313::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 23 Nov 2021 15:20:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54606636-2350-4195-3ec4-08d9ae94bd26
X-MS-TrafficTypeDiagnostic: AS8PR08MB6964:
X-Microsoft-Antispam-PRVS: <AS8PR08MB69641EBB6C8D6171BB6B6310AA609@AS8PR08MB6964.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lAp3Hzn/4XRMu6pAfGz1W2u3JGmSUThZ9RydMU1Mb6Aa+98SWg1LzZC60AmAcHCSQN3yThyYMXXldDeMoXNahSqfs0h3L82qDqC3UECrW4aOQ3rCB8ZhrHaj+7CdcHIdR8f3mWUbh5u6rYjatwKXlDd6PmvRkGmjNy13Up8z2LdYdm69k4qgmI7v7TzvWzrb882afQixwxjWRQWFG7jn8uhyivUtgp55BCaajfutTAKSWQDEk8N+TojbTZW8zuyujuYt6gsv/Fiq5LbqAY5vfHgxrRcGczmRK2j/yFN40EeQeLW2/g3gLTz+O4x9qxJg4RQMb9gQ/za6fugwJe0N35z6O3lL6K4iokuuUbgJbTHq/ecJ2omPJEJiqcfGLImSw53rfsveLkC9vcem2ZHJ0hbmSFG9wPXqT8WGWqiWo40FjqwMBYhjYb4EleiwZZXckqluBCsyAMDw7acI4/IUKRt7FEaZlBggB6XtTaEbg0hQoSFSgPvjLYnY2SvmmZD9atDcAOdNWdYyll6NY1DxqB7RbcalkAdsvSoZwY8qmNsaO+r9kc7IEUQZcmiaGoSdOBC1UDIauU3i3TsGDAfTVjc/j5Bo/hG2PGZDF7mW1K5F1jdZflbw5Hl/Fa3kGp1plcrvSL/ogXaCp6ddYbj7W9YUTpiz/eEgIu/FhdUFREdeiqbmNau0hbLUs8IxTiLu8x7Nx+S4w6lai4/pXLHJ1kk6QUHe9spWul2pQXCQydhJ5LKu9DkfYVvgNZPUdAKJDsTOHPaMIkcisDf8ps92iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6613.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66946007)(38350700002)(31696002)(956004)(26005)(186003)(2616005)(508600001)(36756003)(38100700002)(5660300002)(4326008)(86362001)(2906002)(66476007)(66556008)(83380400001)(53546011)(31686004)(16576012)(6486002)(15650500001)(52116002)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzFrSDdlV2FoOEVHb01oQlUvd1dLSlI5QmJ4cVpqMVpaWEhMUVp3eVgwbWJW?=
 =?utf-8?B?MWFQV3FXL1VySWtYSDdJa2xXdGQ3OVZ5NlpCd1RvNUlhdDd6RExxWWM2ZHVv?=
 =?utf-8?B?bkR5QXBMK1RwZjFPUGFVeHN4TGNpeUZ0S3BoOVRCVU9VS2prUUtRdVRQUU9k?=
 =?utf-8?B?RFhqZkZieEpaMFRtL1l4cXJLejVLSW9WTCtuWW9HeHhDU05pRVNlWlpmU3VI?=
 =?utf-8?B?RG9oQ1k0T0lyVXdhOEtRSWk4bFovUU90Ny9NZXRVTnBmdDltNkRqSTlWR3hF?=
 =?utf-8?B?TkhVQXJHbmY0SlB0M3RUYnRPcWZ6azkwUHA5OFdmUW9PNlpxTnNIc0dsU2Na?=
 =?utf-8?B?bHptdmJjRy9KR0l0UjU1ME5US05vSmNsS2pZWVlJc2NaazNtc25WQ0htT0NU?=
 =?utf-8?B?MTUzUmc5amxhbUcveCtqTU51L1hIUEc0MFJydjREdElBMDlUNGd6QnlVeUVJ?=
 =?utf-8?B?cHpLanJYQ3RkM3VrSlB5UFBxeGpvZlI3QWlhWUx4OXQrR3IxWVFjK0d2VmZa?=
 =?utf-8?B?R1gzR1pJMEpaYkxSY0hzZG5aQml5R2pYV0UrMUxDaGJGMndzL0RsOHJSTUY1?=
 =?utf-8?B?MCtmWURNSDhDM3o2V3F1V2tKWHFlNExCcDBaSmYvL1BBSjhWdGdPb1JJMUZM?=
 =?utf-8?B?ZW13RG5RZzU0TVdkMDdZQUhlWEZLUHZ1NGJ6SFhmYUVnTEg5M2M2SEw1UHZU?=
 =?utf-8?B?SUN0Q2JEZXllRHNEeFM0T0V6RjhNdnc4QXRHZFgrRUtMY0g4ajd4TFFUU2ty?=
 =?utf-8?B?OXFGRmR3dm5SQmNWdWxvZUVVYTMwTjRkSXQwQ1pSVWQ2TUg0WG1sd2ZGZDFL?=
 =?utf-8?B?V1FFamxjN3FpdkJaVWdKb3Z1TXMwd2R1bk4yVU9vdXlnWjFmaU5DdjMzWDRj?=
 =?utf-8?B?VUwvSDV2bDQzU2crWVFXb2NZWEVrY3ZjcGRoa3F5ZTFmcHFieE81OExYZWJw?=
 =?utf-8?B?Z1A1eFArNXNWSmErZ2ZmTllGTVZCaERsNEllN2F2WjB0cGYrc3I3dlB0V1Rr?=
 =?utf-8?B?eXljSXF0VmdXWWoreTZMY1NpbzVmb2VmTzBFNTMzdTkwL1FSNllXVzc5SWRq?=
 =?utf-8?B?NnByT1Iwd3NXUWxEQ3JsclZNdDRJY0laNHVFZWxac0JLcjQ2NU1GS2NWSmxG?=
 =?utf-8?B?NEkwQ015c1YzU1FqZ1d6WnBXK3dRTVNWU00wSElyMkVjWWttNGJrYVFoYWJa?=
 =?utf-8?B?cFBJd1dSVm8xNzNaN081dTZuZWloaXZ1RFNKd1BodTFETXFKYWJ3eUNtMXdF?=
 =?utf-8?B?K3IwMjFlcGdwb3cxdWd4bUYxUVVCc0JKLzRMenVqem40K1B6YlpEb1lpR2VK?=
 =?utf-8?B?eVp3N0p5eVFuV2RONHZjK1NUS0I0MDkxT3ZRUmlyVGhRaThCaDZnRFFhSU8w?=
 =?utf-8?B?WFFPSkdTZ3RwZjJ0UXJzYnNMVWJuSEJHRzl1aUQ3a1NCc1hyVFBoa0J5TkM4?=
 =?utf-8?B?V2NhdmhPa2xxdFN0ZUN2dmNxWko0OUJ5S1pCNWxpSWF3eTVVMkpqdjFvMVNh?=
 =?utf-8?B?dksxS01OZ3pEbXFERlJjZG1pZWh6MUhOMVlXWHFBY0VheDB2N25USUlYYjc1?=
 =?utf-8?B?T1plWXpqM0xYc3dXNW9zUlBETS9YRXdUd0VFdW41VmNHeXJWcTdqV0daMElZ?=
 =?utf-8?B?L2Z2elpoWTM2eTlWR1NoYUhmQ0x2N2FEb3d3MHFxZ0kvSk1WRUgxRDd0NWhF?=
 =?utf-8?B?b1RaV1RmTmNYMk1MeEdHR1kwR1BsU0U4VHBvdXA0YVJUOXpZYVhGd0VNOVFr?=
 =?utf-8?B?ZkRncElxRlcvRnpIYmVpY2NrRzRRQStQUXg1NzZYS2F3M3RxaFlhZDMza2pm?=
 =?utf-8?B?YkZOMUZsbUN6cWR4RExSWnJUajUvYk9Qb1I0VCt1Wk1OY1Mxa2k5WWE4eVBU?=
 =?utf-8?B?d2FMcXJBRlAxNVkzYURlRm1RbEc5NnVzZE93TERZR3VYd3RXdHZ2SVlOcTJD?=
 =?utf-8?B?SXg3RjdCQklFSzdHQUVmRjBmSWd6NnplTVVsV2xmdTBlRGhxMkFaSHROcWJB?=
 =?utf-8?B?QkVFWkNWZnVwelFjYWM3QVNVUDhnTFBaWXpwcU1OZTlKTjBCaHRxVWwzMzJP?=
 =?utf-8?B?ZHQyNWFZSFkwa1RwNDlKbks1K1I5TkxGTmtBVFNLZnZJNFZDcWxxYWowdXdK?=
 =?utf-8?B?QmEzS2dPRm40TXdQeWtpZ3Z1Y3RvcHBISHlEcGlWejdyakpXa1daL2hOcXg2?=
 =?utf-8?Q?ACjmXW2PhwszV63yhY7MUJA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54606636-2350-4195-3ec4-08d9ae94bd26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6613.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 15:20:10.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkHcTODOgJc3cqPV1IgStLwd2jnWyh2iFtUNX2xa6YNqPD4ZgoO1bd2KfdNkKAMFjiA53td+xQ4H4UZNNPYHiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6964
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23.11.2021 15:22, Jeff Layton wrote:
> Vasily reported a case where vfs_lock_file took a very long time to
> return (longer than a lease period). The laundromat eventually ran and
> reaped the thing and when the vfs_lock_file returned, it ended up
> accessing freed memory.
> 
> Don't put entries onto the LRU until vfs_lock_file returns.

Cc: stable@vger.kernel.org
Fixes: 7919d0a27f1e "nfsd: add a LRU list for blocked locks"

> Reported-by: Vasily Averin <vvs@virtuozzo.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Vasily Averin <vvs@virtuozzo.com>

> ---
>  fs/nfsd/nfs4state.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index bfad94c70b84..8cfef84b9355 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6966,10 +6966,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	}
>  
>  	if (fl_flags & FL_SLEEP) {
> -		nbl->nbl_time = ktime_get_boottime_seconds();
>  		spin_lock(&nn->blocked_locks_lock);
>  		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
> -		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
>  		spin_unlock(&nn->blocked_locks_lock);
>  	}
>  
> @@ -6982,6 +6980,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  			nn->somebody_reclaimed = true;
>  		break;
>  	case FILE_LOCK_DEFERRED:
> +		nbl->nbl_time = ktime_get_boottime_seconds();
> +		spin_lock(&nn->blocked_locks_lock);
> +		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
> +		spin_unlock(&nn->blocked_locks_lock);
>  		nbl = NULL;
>  		fallthrough;
>  	case -EAGAIN:		/* conflock holds conflicting lock */
> 

