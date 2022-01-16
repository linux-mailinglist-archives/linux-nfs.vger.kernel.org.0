Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3619148FCD2
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jan 2022 13:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiAPMoZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 07:44:25 -0500
Received: from mail-eopbgr70110.outbound.protection.outlook.com ([40.107.7.110]:34542
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233195AbiAPMoY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 16 Jan 2022 07:44:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbchAxnjC8m7TKzh/h+ou044DZiAp7lHhzHj7nceLFCYpVEfRppMo1fRcO8dkNRPqmQ3pSWLKnibvE44E1nC5mYi3LPpKKy1yHa/FzbLFHWiyo0WAzII6xIZOuN20sUjLf2XwrVUOP39A175efMu9eCN6voOlFt2Uh4MMEnbIcPCW3BOZ+KRfsWR/n4Q2AsRcKVHl/dMOBpJy8YmGc8/7wmtQB7M34AQ4r/knRm7jOSzTzBLk5pwgIAAzJlw2YiIvNZEkRPPeboH8eeHElgih4VJGdyBTloBbrQm1Ukd446GfwdssR1uTEgRaAQ7EcSmRZTWv4ChYNDYvkwN5XDhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1GlyIh1Eq24j4mzAc66xjV85TnNL4AoncwL52++K14=;
 b=fOq0YEWoP0bUbUhTMPH9Kwq2+gd6KKa7duWDipL75vFleT6VIAk4ndDi9tqKGO3iKEk+rnjsXMeZcpbfiTZuuTAPNv+J4Kh/XuBKoI9n9Fxcxi3BYDqitscwroY+/FHcrwjCGfktUX7AG1DuTIM5/i8PA/E8vsyf9WIEgWshaw3TsTtYjUYD3APyL2myezdueeV7GawWsub184Jddt/D4BUfuNPqMwioN0DdVe7zwR1gzHawVW+rYLlsMNgSslMn6fDngpgrVG1JDWSA0oyR7q0TxRdAF9rGVSRjZCi8GEV9ijfrqmb5wnPUcY20czNTv0MENnb0+Rt/iZiJ8A1YZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1GlyIh1Eq24j4mzAc66xjV85TnNL4AoncwL52++K14=;
 b=e/5azo3NeoztKx59nh4wiKaXVI7bCLfMbkI20wCkL9ovOj0sHmxaV443i2bMv+SqAM0rG2unRoK8b7jVbvIIelzCnjzDFT1OATzFSdSEtJ5QSJ7B72B8t/txCz1SDOlkc1zFV6v4k2tmi05qHvH5zYv3Ldc7jW/dSB6/r8xXZ0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by DBBPR08MB6251.eurprd08.prod.outlook.com (2603:10a6:10:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Sun, 16 Jan
 2022 12:44:22 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 12:44:22 +0000
Subject: Re: [PATCH v3 2/3] nfs4: handle async processing of F_SETLK with
 FL_SLEEP
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, kernel@openvz.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
References: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
 <00d1e0fa-55dd-82a5-2607-70d4552cc7f4@virtuozzo.com>
 <20220103195333.GG21514@fieldses.org>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <7666958f-6215-a8eb-3412-b613158406db@virtuozzo.com>
Date:   Sun, 16 Jan 2022 15:44:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220103195333.GG21514@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0701CA0002.eurprd07.prod.outlook.com
 (2603:10a6:203:51::12) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ebe7a1b-9fe8-4df3-ff80-08d9d8edebb4
X-MS-TrafficTypeDiagnostic: DBBPR08MB6251:EE_
X-Microsoft-Antispam-PRVS: <DBBPR08MB625171137B5A27595B239324AA569@DBBPR08MB6251.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faMLso/X5t7tTl3/Ri8blt/wD5jUN1MtTmv8wn73H0nMwTOYkMSQWuO0UhvNPXWL+RL2AerKKLtIc+XS/M2TmFQt526T/aBnazRL5uccySBOzdJz8W4gFwYi3gJGVjU60T9s8YEOAFVvhezK+3IF2JhRpl+BmOAXMmDFfH6aXoAFsfdYTECg9IvkVjZ+l0h+oKhlcn1g7PYSVbrya9hFb1p1nxxS+Ez/t0IOQ9qUyskPVTv/461WBkyC5xSUKL1WQtQg25MfzDIwe4/nXuwkCabtBF77TvlVNvoTk4PLIdOfu6nYJcGCKSo8Dm5/T7pANjRDSxKFO2TI351m2QJCBOC9BzBI66uEUWpkdT+5gvzcrsV1U4zQWYa8VnhHZzFYKytX5mGy0L/zhCHtxeEmXyCYRsOCek+3dfZnteiB+YfimtdkaQMFGODuB5QqGOaaSlWKkhg0u+8f3/rAlQME2YhnKuROgYJTOTqDm3NVTOfiRXrwfcYQDpXtjahF0giVzNwQvafB7ZbTBhp50JxWr7g84L8HubkJPtEE/2c9FZ0855csSdtwhRvui1PcB/9ZZ6FSr1yyyYAxNGbBYpVT155QlQ2fbco5Zsj32nxb7QRvnWfccsxmbnKp9pdk+sU3mKwphQexhiKX5+zYDX4xpBXvZcaIf8Jsb7QJQhbtT48hr201U5XbGQ3iSdotMFVnaoDISYYsfo/GlYgk2pVhHv9C7DxyZr3YySC55He6JG4kf/BTPXmvVWoUVxEX1f794/q5izSAlVfaFKp9dtrXU6kSO8cuPysoLEIrvbLt8tZbOqa6IqFmONo76/DsuU6RY+jRxWtyl9L/UZBdV2HGPzHH2a1KUDEWDbvws++1D3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(38100700002)(36756003)(316002)(66556008)(66476007)(38350700002)(52116002)(508600001)(53546011)(31686004)(186003)(2906002)(6506007)(6512007)(8936002)(54906003)(4326008)(26005)(83380400001)(86362001)(8676002)(6486002)(2616005)(5660300002)(31696002)(6916009)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0hhcFZ4OUVkbDhOSHE3czFzMkZFcVRyWWVtV0NiQUEyWGRKckdFN2NFZWdq?=
 =?utf-8?B?K0VLWTRoMitQTG9QdEx6NW4xSzRVK3dxaStyZEpaM2FxbHJvMGsxckRqdjNO?=
 =?utf-8?B?dWs5MjBrMDIxbzMvRzVXUUp1d29HZGsrd050Ky90Qm9HekorMVZORDR5akFj?=
 =?utf-8?B?SFlQMWQzV2RpNkR5OWQwR2oxUEZyQ05WTGlrTE5kZ2pQZDlPUmxoNWJRTWl4?=
 =?utf-8?B?SHh6YkI5bWFuK2J0eUpOUjNVVUxLM0doMGlXb3RRMHZ2bjdEL0lUdXFnekJV?=
 =?utf-8?B?QW8xNEpvQXJad0FKbzNpWXJmMEhUY1NiZVhLUjZ3emV2RzYvZHkzK0hXMlVy?=
 =?utf-8?B?cHdxYmxHTXZpb2haRnhOdzIzeU9WK2lRMUdqWklDTW9NNjQ2Qkk0RlJlT21V?=
 =?utf-8?B?bG5UWCtrV2d3MjBXUi9LSWdiMTdjbnlyMlFMQm5aSjhlNVBFL2Y5RkowWkVv?=
 =?utf-8?B?V1Nyc3crRlNRNVR1dFRBNk4rdUIxVnFIU1JubUhqbHhRSzRnVWtDbGFCaWFx?=
 =?utf-8?B?aHpmcXd1TGxBZERTWXVkWHczd1dCcXBWeVd1YlZHR05ybWgyVEZ3azhQWDBV?=
 =?utf-8?B?NnBuZDF6c05GZHNPMW80YVh2VjMvVkViK3JkMGZkRERRMXZ4QlhIc0pWc1Uy?=
 =?utf-8?B?RzlqSGZSWEtNUUp1ZTBMWmVqdktYMVBMY2tZeVFObGdCdXg4V0dyYmtuUlRZ?=
 =?utf-8?B?Q0JvNWF0a2tmai9ZN05TbE1Rb2IxR2JmRm1oUi8rUUdkNDFnNk8yVVRMTU8r?=
 =?utf-8?B?UGFMNk9NcGZzLzRxeWYxUU5JTTljTk9SME40T1hYRTdDRDNSS25JV01MMHlE?=
 =?utf-8?B?TW83S0g5K2RKaFlUVGNaR0tJRlgzVjFHcDIrQ1l2TW02b25QTERSaVNNWjRs?=
 =?utf-8?B?elhZbjdsOTJWR1hNL3M0MGVJYVVvMVpRL3VYSE5Hc2hXMGRLbzlqRUFiQi9M?=
 =?utf-8?B?YTFXZWJ0L09oWGFBRUsvbEVkcnZub2RZM09MU2MzS25Qc2FKQXBadmd0WFJE?=
 =?utf-8?B?NFBTb0hWYkVyK3dmM3poaVhRRW1BbTRkdndxdkc0c21tREVzck45a2VBNzRV?=
 =?utf-8?B?U3Q0SVJjbGFNOHQydnV1OHQ5YWU2RGNUR0VQeGtkZ1Y1ODJxR3dxWW1pUWt5?=
 =?utf-8?B?YVZrdjF3MjhuY3MvT1NjR2Vxa0dvTzlMR2M0NWQwQ1J2QUxabUIvU1hJd2pK?=
 =?utf-8?B?b3RNdTdMMkdmb20yZWtuTEtUTzNxV0xjczZJYlFobzdTNy8wdCtPaldOdUN4?=
 =?utf-8?B?dmtMTEtJMEYvQ2F1YnZPLzZYbmhWNEJEVzBDblFEdmpmWklJWWg0OHFpbklQ?=
 =?utf-8?B?aXVjOW5IUmx6RFpHem9IczJIUU9jVU9TWDZEWGxnUlFMKzh0OUU1bFdYYlg4?=
 =?utf-8?B?U01PS0g4clljSVloazRJQ1JER3Q2eE9rdVlUZmk5cVI3VTVhaFpML3krSDg4?=
 =?utf-8?B?cWFKdDhyYldKRW5tSndYM3N1TWJPUkZRZm9QOUt0WE5QdFFKc0FEK1dBdm9O?=
 =?utf-8?B?YTQ4eVB0SVp3SW5qa0xOaTJsTEYwODV6ZkZqODBxNGx2eU9qRjhyZnovWkw1?=
 =?utf-8?B?RUtldUFFcU9Ka1JmeW5rU1lzZmhFeW1IYUxGV3lEWmQ5Y2NIMFJ5UjdIR2lS?=
 =?utf-8?B?MW5tMzlkOGp5UmpzTkVCdFBDQlFkRW9jQ2cwdnNWZXpXbTBSN0NweUtwNEJS?=
 =?utf-8?B?a0xTMFNhV3M2YWJGSUt3SXErc3hYYWo0KzNNaG1sU3AyT0g1QzR0dHhwUjhN?=
 =?utf-8?B?ZTZkWkR6MG1PU3VuUjFPd1pkc2lXQnlDd1VOeWN4emRjZVdTZUEwSlhqMG5k?=
 =?utf-8?B?aUZQeVo1Z2Vock5xZ09FejBOeVMrOUJQNkpCWkxLMHRhRU40emViTDRkTnJY?=
 =?utf-8?B?WnFQQ3FFOXVGcHN4R3Y5WEtiNGIzaTZtOFhRZm9jMmpCRFljTDhaMUkyZ3Z5?=
 =?utf-8?B?RkRXTTNRVDFkWkpYdWRXRkxzVFg2aGZkM2l6WjVSV01jTDlTZnRvZ1M3eGcw?=
 =?utf-8?B?RkU0czVqcjg3SWttdGplS3d2ZEV5eU91aElPV3g0b1pmaHczUkYxem40aWxz?=
 =?utf-8?B?Qm9vQVVyOGk2T29BYXlIWFgzbnY5eFJldkR1MFptWXVtcVdjWnIrTVVVREFH?=
 =?utf-8?B?RndmWC94MGNMYTFab0Z2ZDdnSWROUUp5V01PUmJld3h4b1RFRGN2alR3TnMy?=
 =?utf-8?Q?nT2E9AqYrCiGzN6BCmn8lOw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebe7a1b-9fe8-4df3-ff80-08d9d8edebb4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 12:44:22.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nC0I6ROyjJI384UNLA9UGe3bRcj0HKZl1ltpaHTj4i6csp0S5gvFvGPtySHitHN0MLI8Z2NYFXfiQG7OcpougQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6251
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 03.01.2022 22:53, J. Bruce Fields wrote:
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
> But this on its own isn't enough for the client to support asynchronous
> blocking locks, right?  Don't we also need the logic that calls knfsd's
> lm_notify when it gets a CB_NOTIFY_LOCK from the server?

No, I think this should be enough.
We are here a nfs client,
we can get F_SETLK with FL_SLEEP from nfsd only (i.e. in re-export case)
we need to avoid blocking if lock is already taken, 
so we need to call locks_lock_inode_wait without FL_SLEEP,
then we submit _sleeping_ request to NFS server (i.e. set )data->arg.block = 1)
and waiting for reply from server.

Here we rely that server will NOT block on such request too, so our reply wel not be blocked too.
Under "block" I mean that handler can sleep or process request for a very long time 
but it will NOT BE BLOCKED if lock is taken already, it WILL NOT WAIT when lock will be released,
it just return some error in this case.

I think it is correct.
Do you think I am wrong or maybe I missed something? 

Thank you,
	Vasily Averin

However I noticed now that past is incorrect, 
temporally dropped FL_SLEEP should be restored back in _nfs4_proc_setlk before _nfs4_do_setlk() call.
I'll fix it in next version of this patch-set.

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

