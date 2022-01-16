Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64EC48FCB6
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jan 2022 13:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiAPMZs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 07:25:48 -0500
Received: from mail-am6eur05on2128.outbound.protection.outlook.com ([40.107.22.128]:40160
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230117AbiAPMZs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 16 Jan 2022 07:25:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnG9dpXM6W8yHl9sPGP39nvz5s7AntO9ktjghUTS/86KDYCFRiUmgYFl2aL9CCsEDLIq3f8gmpQhbrI0iSxFttW8z9O57botqyJsu8BLT7WCa4IHLwQhmPazx0f2rQq+7LEcU80gkg2Hugbbjb4AFyxSCFgv5QmGW57CRx6IvDEvx8S0n2xWPnBv1sjqCy9A8GJxLEEFjiQuI9fL3i2dU46KjY0YSI1XKmufK9mZn2p8EkEOpJczdrYzuacsRfT4c1BbZ0Qkam0+il1Rxb2H8xMMPjBliavPsYBkmqwwqgNnsn/3JPyxR8PQOVSKodqfWMfXdizPKfUd3HNA6Tg6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP2XgHmUwKjvysdgfOVYOroon6zM8QoTsYQQDn88Wdk=;
 b=CVHQcW6TJussNO8HcKGN0Xk1Qe5RyfWNJhmuFKld2IsxQJjozsP2fTlMUM6mZAH4GBYu+49f7ehDQdZKPgxeMAa+CJ0Bend09HPgO+z5ahubC+0VlyiKipTvhIrrP/WJ8SIiNC4C1SIwXfzXEvkza/X122fq40LBOukaZVjQWZt72ThmcSqyj2HgodY8X6Hw6Jd1yPVFQvgj/Yr2tiMcRcv5EbE8gs+9wx6VWhPlhCqAWnswWi1bANY90DbolyRv534oz0FZGsnxmaIe41wx0DNuGyFNF/xPXlaxXjEXs2kBcMhoHGkCCpL4NywEJ7U6Td2+W4PM6dELzixHAL5rcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP2XgHmUwKjvysdgfOVYOroon6zM8QoTsYQQDn88Wdk=;
 b=K+55VFgKZi9p+FJ5y5rUObxT1YvxGNU7i0KT4mNgHqDavp5Agte9vUHDw0O0fSZVkSNqZEHX71yCEO+FsIzyGdoJqRyhDh9NMqQohmSW5VWeqyahB4E49ysE5jz+UK2k4WMOM4bzyLq39R3tl/7Fz/BPtP3yKB2ell0ZIBCZvb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by PAXPR08MB6335.eurprd08.prod.outlook.com (2603:10a6:102:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Sun, 16 Jan
 2022 12:25:45 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 12:25:45 +0000
Subject: Re: [PATCH v3 2/3] nfs4: handle async processing of F_SETLK with
 FL_SLEEP
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, kernel@openvz.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
References: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
 <00d1e0fa-55dd-82a5-2607-70d4552cc7f4@virtuozzo.com>
 <20220103194012.GF21514@fieldses.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <b332a1dd-f96d-2d83-80ca-67058eeaa1af@virtuozzo.com>
Date:   Sun, 16 Jan 2022 15:25:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220103194012.GF21514@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0061.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::38) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7b068b6-de1c-44fd-45da-08d9d8eb51c2
X-MS-TrafficTypeDiagnostic: PAXPR08MB6335:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB633549CC559E014731FB6633AA569@PAXPR08MB6335.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZOfq/K+iAnrt6StjeDGBsuxjB2Sbb78y45D++Au/mHjXNvyP0Kz3KIHpJtsSPaF5hMvzbzGq51DxTWEeluGdFc+ix/BAgdiR2jW611x4DyAKi7CS5sZwbpTNgau7hH6niknLVtYHE6dGwRku9LS1IMyV1e4LFciJGQ1MMxf4HnZV0kE3hMczVLNjf5FV2EmQCb0jn0fcCQ97+DEfsuQLyYyUgkxYx3N59kcuIi1jD+reF0zzo0RhJDs6npVa4+cuXMhf/5jqv0NPSgyvwQjgF/F4WP4UgYUqtO6HAsRi41bHzaiLHc5I7IcXN8RQF1SboHHAwSdksS+kZoVCW9iw8w2AHv8XRrgwYvdadFT07bkE6etb4t38IaHrCrTZwj5LO8JTclouPBn8O3j1f8CjdtnWScuiqgx8d+yvfypT/vRU7/CWukP4jZIebCyTWKJBiJmBTufMNz+4c+x7mMHJtGChMMmqOeYoCWvAKnJi7mtGOrcYBd1v36yKsknhtgH+QsamC8xLopaPxVgfkUB0wR+GOQRoTuum8xBXo1/awepoKPRbW63zXExKRCgVogmy9u+MqlWMNTe0gUHiTFDRffOvlMCS9EqF8J7fYHQ0sx3dwiNsUobi6cLXDj0UcJqgrhVAkctMqQCX5SBeGiMqvW8WTsgdtsSiL7y4mZrPHb8auMMV3LachdZP4r0Z5q8PpJL7UeKzMuOiQzMHgDMQYXS6zf+Xgaesol8wcJ8CuYfAVu8I7OsRK3AyvQkDPR3zRFlEACAsNkh21yq3csx1/LtAq48hu4IkRX9ATiUyJkl62HzZu4g02DiwoEh1B/iYNFLg3CYHpJvjD7OcXY90vpy9dl9ZRzlBITaFhhXc1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(316002)(8936002)(508600001)(53546011)(6506007)(8676002)(6512007)(86362001)(6916009)(2906002)(966005)(6486002)(31686004)(26005)(83380400001)(52116002)(38100700002)(38350700002)(66476007)(66556008)(66946007)(186003)(31696002)(36756003)(4326008)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGpkMUJacWhTSVFjdmRMcUZMRlRWSmg5RW9oR0FmQjBEdkxxd2lUNWVWODIz?=
 =?utf-8?B?cGgwQUVEK1RsSWE2aEI3SUpHMml3N3FKVm1kdWJkSGphSTV2TktrcmE2MEpr?=
 =?utf-8?B?Nngva2ttSm12NGxlREVxaGdnSFh1Um05NEdtanlnQ2RPZ1ZKZjB2SHd0cTNo?=
 =?utf-8?B?NlAwblRQZ1dtS29WdFJLUE9ka0x2R2x2dEljdDJhbUhWY3ZVbEdhV0x1TUxG?=
 =?utf-8?B?RWlPa3FkZHVRNEdKMzdqN0orK1JwQWpIY3p5R3graWl6Vyt3ZTF1WWRKWjNQ?=
 =?utf-8?B?S1VpN1FMcWQrSUNHZTNhVTVGZlltdFdqWlNBVE95N0d1MDA5YWlaZStpc1BZ?=
 =?utf-8?B?MEVQRElESER5VCtVYkxZaWJJajVYZ3hIcVhyOExBV2ZrajZEMmkvanhTUWE3?=
 =?utf-8?B?aDlpZkozL0VxcGNXNjdXOWRVejdsenJ6UnR1TkFUMDN0K2RMTkRwRmJXNVQ1?=
 =?utf-8?B?MDdtZk1SWTYzWUgrUDdVenBLdE11ZXc1NW5ja2syd1psZnorR2tvRkxPYW50?=
 =?utf-8?B?bUtkOXpCc0JyWDhsNUNIYUZSV2FsMU1HZ3FRbjNqY2pyVXFFZkwrNUs4VFg2?=
 =?utf-8?B?L01oeTY1N3VYR3ltSnFyOUdaV3RMOWFsVUw2NU5mV01rZHhDOWU2ZlVYWk1C?=
 =?utf-8?B?UVlVMFBMdzBMRHpUZ1dkS2F4QlJKUnpYNVVxdWp3c3RZcFI0bVUzSktESGlr?=
 =?utf-8?B?RGtyV3dIK3MxWXo5T3RyS1orSENlekMxZkRxNXhCMnpQMzgzNCs3QVlsVE12?=
 =?utf-8?B?WDM5Mk9NdDM2TWN5WEpFYkNxQWFpUFA1N0s4bUhRU1JMZjJFVDJqNFZZa1BB?=
 =?utf-8?B?djhuVzFzbEZ5dUg5RWF1ekw4R0VKU09vOXhiZ3orY2RVZkZITjlYdzdvaFE0?=
 =?utf-8?B?SzhTZE02WU5NNGp6YmJjbGlZYW1qL2FldXVEQlpQR2pFNi9pOWdVeUlQQnpG?=
 =?utf-8?B?TUFhVU5TaVhTNldidXFIOGNmMUI2VE05NmJwejdzTFZjMHU0MzhxUGs2cmd2?=
 =?utf-8?B?OVhNOHNXTWFERnpJOTBsZ0dWQmI2Sk00Nnc0SDFiaERNM0hnK1M2emNxRENP?=
 =?utf-8?B?THRMR1pveUFsL2x6N1lRQmQ3bW5JUDJ4YWUrbzJacXgyVDZpZForQXMwcFlJ?=
 =?utf-8?B?QkFmRjhnZ2IzQlIyVEhvMlgrN0pVaWZSc2V3M1ZYakdCVjh3dUxiKzZhcTRz?=
 =?utf-8?B?c0l5MDk3NzJEMFJUTXkwZVlzUHRNdWhUUkViYlI4WHBtWXA0Ull2OURVYzkz?=
 =?utf-8?B?TUd0NDhLWkpxb2lqZFpGa1lmVittWVloV01RVGdCYnh4WmFjMWUwakd1bEMv?=
 =?utf-8?B?R2Z3QWpYRm1YemlmL3hpc0Q5blQ2bkFKYnorSVpXUWF5ZkpDbThxUWhOTkpK?=
 =?utf-8?B?MG5hUWxUUjZ6cTZySlpHWVErVE5leU1yemVwNUpsR0M5SXBHV1pMamtWVktR?=
 =?utf-8?B?WlEvbi8vWDY5Nno4MngwSlFLa1l1OWRmUUtnU0J2U0M4d2p3WnpIakN1eUxq?=
 =?utf-8?B?VnlxZTlYQW83QzNNSDMybVAvbGhpVUtyTjZ6cWpqSVIxemZkYVV3SDdkVmpv?=
 =?utf-8?B?MkhQR3g0NXR2dWtzOHZlbkYyUnNaaTMvQVVpN3dnY3FzanFjeWtjUzVRdDBv?=
 =?utf-8?B?dVQwVWwwQ1ljWnZ6MVMvSHhtVnVJVW9JRk13dTZjTU1icHZoOXpBTm9Gall2?=
 =?utf-8?B?N3c1eXQvVDlLQkVaWCtZSWhVT2ZydFFwRUg3a2RKQ1lUZVkxMGRFNmJ2QTVs?=
 =?utf-8?B?RG9XNy9iUGxHMTV1cEMzVk4vTHp3TXVSUk9VakxKbFd1N0lIOVZnOHFncUZr?=
 =?utf-8?B?T1dEYk52VkNISSsxUXI2MTRleG5LSEdhYjJMQXAxSlBlempRY3VKYVNCSzhx?=
 =?utf-8?B?a2NweWZWdDRzMnVZbUlCVFljUm81dGZYQkprSWxnM01OQ1NaZlRTWXVoMVRi?=
 =?utf-8?B?bWRSZkcwS3FqVlg5WGVkQ3BDQTdDM3F5a24vR1o4d1o5VGZad2dnVDhMZVh4?=
 =?utf-8?B?Y0Jtd3lERWh3Z1UwdmVVTURmQi80T3VoL2pJWWp1NXhQTjM1MnFCdEluTzRD?=
 =?utf-8?B?MlN2bUtMK09CUys0b2lSTm1Hd0NadjF0dFVaVEpxK2VhK3RCekZlQjNzTXRk?=
 =?utf-8?B?dEs4bjFPZGFOUXJPVGphMUJXaC92N2JUMklWUVNpcktEeVhxeHhuSWsxbHBN?=
 =?utf-8?Q?g+Gg5RAuUQbOuXJVwhw6nEc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b068b6-de1c-44fd-45da-08d9d8eb51c2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 12:25:45.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8qA6MNI+348vOgGwHM7KLprs4kHv/55dtMoIbOAWTid8qDTHd++RmzyjBC14yHtvCanI575QqU3BjKpa87BZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6335
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 03.01.2022 22:40, J. Bruce Fields wrote:
> On Wed, Dec 29, 2021 at 11:24:43AM +0300, Vasily Averin wrote:
>> nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
>> asynchronous processing of blocking locks.
>>
>> Currently nfs4 use locks_lock_inode_wait() function which is blocked
>> for such requests. To handle them correctly FL_SLEEP flag should be
>> temporarily reset before executing the locks_lock_inode_wait() function.
>>
>> Additionally block flag is forced to set, to translate blocking lock to
>> remote nfs server, expecting it supports async processing of the blocking
>> locks too.
> 
> Seems like an improvement, but is there some way to make this more
> straightforward by just calling a function that doesn't sleep in the
> first place?  (posix_lock_inode(), maybe?)

There are few problems:
1) posix_lock_inode() is static in fs/locks.c
2) exported posix_lock_file() used posix_lock_inode() inside requires file pointer,
and I do not understand how to get it.
3) _nfs4_do_setlk() is called from do_setlk and handles flocks too, 
therefore any posix-only calls requires additional checks or branches.

On the other hand all that is required to handle F_SETLK with FL_SLEEP correctly :
to avoid blocking on exiting lock. We can reach this goal here by drop of FL_SLEEP flag
before locks_lock_inode_wait() execution.

Thank you,
	Vasily Averin

PS I'm worry for a long delay with answer,
in Russia we have long holidays after New Year,
then I dealt with urgent tasks accumulated over the holidays
then I forgot the context of this patch and 
I was need to spend some time to re-member the details.

>> https://bugzilla.kernel.org/show_bug.cgi?id=215383
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  fs/nfs/nfs4proc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index ee3bc79f6ca3..9b1380c4223c 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -7094,7 +7094,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
>>  			recovery_type == NFS_LOCK_NEW ? GFP_KERNEL : GFP_NOFS);
>>  	if (data == NULL)
>>  		return -ENOMEM;
>> -	if (IS_SETLKW(cmd))
>> +	if (IS_SETLKW(cmd) || (fl->fl_flags & FL_SLEEP))
>>  		data->arg.block = 1;
>>  	nfs4_init_sequence(&data->arg.seq_args, &data->res.seq_res, 1,
>>  				recovery_type > NFS_LOCK_NEW);
>> @@ -7200,6 +7200,9 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
>>  	int status;
>>  
>>  	request->fl_flags |= FL_ACCESS;
>> +	if (((fl_flags & FL_SLEEP_POSIX) == FL_SLEEP_POSIX) && IS_SETLK(cmd))
>> +		request->fl_flags &= ~FL_SLEEP;
>> +
>>  	status = locks_lock_inode_wait(state->inode, request);
>>  	if (status < 0)
>>  		goto out;
>> -- 
>> 2.25.1

