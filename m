Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF748FE6F
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Jan 2022 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiAPS2j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Jan 2022 13:28:39 -0500
Received: from mail-eopbgr80091.outbound.protection.outlook.com ([40.107.8.91]:21156
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232456AbiAPS2j (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 16 Jan 2022 13:28:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7hTv19BsqlzVwhwe7h2qScikLlFc/dlT9wXzK1TN2NSeI1XYb6oYW+e4DaWchOtgFmgvGw5wzP2Qp87mgDTwyZ+/XT0F5tJU5EgfeNXCSs8TusgOlDakuD8EUkL7rTTX4Wn3XwAuKHvRGiLhyT5WDLBxH+l5ZF3JnzVnUIHszcfpAf1Rl416SsyI26EtaQSxpgI5KZWsGUPEbS5/VxfiFMKlAlsyR7G1tEXcnm4lirpnJSk4NJZNSaL98n/xEroNEXUfeNrU7Uk67k94ANMzPCr5i7ir1xR1NzbA+ME433ofQQJt7958XHVd9RGgwAR4JuLFLe/i5YFq5785KA8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRGX8MEBVt962xugs+wF2kwn9yRRNkX8MRAk59n7vA4=;
 b=XFtpH8b8GCk2EJmmy3hGLIVEOY4hoiOj6JeZw2rnd185G1LjM0ahbAx5g+dZ54Q4h8FdThQUa9/rgrAVTodipojAvTWxr66TT1WXnnE/wUpjN1PmeSmfMg07Q44v1Y0C+queE3REtHtT1Go75kNBq6XNM7uHtGEn0hSwXLJ30CWfBxE89DLIuUJY0KiS6QVOdsw6KfIRUTuEwjrSK35oYHk92/g2Db9WChUt9ViewN3jrMSjnFWXFXu9tapC2gPBliDDIieVfVMxXwT07GKA4BnWwVxokRacXUjX7ZsKaYTG4DjhIxkZI0aY626L4poIlpvt38fqbOgV0ICxPlR5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRGX8MEBVt962xugs+wF2kwn9yRRNkX8MRAk59n7vA4=;
 b=ZwStzIrkaSS8miatR+6FstlIXcZ3PATcdEkqalPd3/zMyy1f+/4LKCcjP57gEKX71u2HRVEXoD115ir4UvfnrduRhf8jKzj4Isnvn/Rf9yqFpqF/TisRz39Rd9+2bkMK2Bn7ZuoJvTj4ZXTeLxE6kQgYZUPJagof8s9wa3/unU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com (2603:10a6:20b:281::21)
 by PA4PR08MB5917.eurprd08.prod.outlook.com (2603:10a6:102:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Sun, 16 Jan
 2022 18:28:35 +0000
Received: from AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f]) by AM9PR08MB6241.eurprd08.prod.outlook.com
 ([fe80::f9ca:fe00:10da:a62f%5]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 18:28:35 +0000
Subject: Re: [PATCH v3 2/3] nfs4: handle async processing of F_SETLK with
 FL_SLEEP
From:   Vasily Averin <vvs@virtuozzo.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>, kernel@openvz.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
References: <1f354cec-d2d6-ddf5-56e0-325c10fe26ee@virtuozzo.com>
 <00d1e0fa-55dd-82a5-2607-70d4552cc7f4@virtuozzo.com>
 <20220103195333.GG21514@fieldses.org>
 <7666958f-6215-a8eb-3412-b613158406db@virtuozzo.com>
Message-ID: <bb20d9ba-b529-c3ff-004d-75df74c0f9e6@virtuozzo.com>
Date:   Sun, 16 Jan 2022 21:28:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <7666958f-6215-a8eb-3412-b613158406db@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::26) To AM9PR08MB6241.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a63b1657-dc67-4d29-8b59-08d9d91e01f3
X-MS-TrafficTypeDiagnostic: PA4PR08MB5917:EE_
X-Microsoft-Antispam-PRVS: <PA4PR08MB59176794A840F3BEC0086770AA569@PA4PR08MB5917.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eAttfl2uguwvIJIWV23txHiT2zUxp3sTNJXhHPgV00bGnsgi4T/ykNzrWmuTsrf0uLSwIniZiIFoAP8p03wCl3bI6YcijcPGLqjY3s2BaWg1ltouvvmXYT3LE22cAmbuGX0GgIuuuEe1yAOqSA6ID90MozhKQnFnGnntliKCB2CSv0OQp9B/PYetQIXtZcqBOvFdK/B6xb82Sap1AwDCtbEp0p35nOX75QN5/m87twyzThvoEwbt0iwoy/m3emC/B7q+DDZxlrAdPRUYDwPA6E9i97f4pQ4jlXnM90gngnkEwvOUx+oG4oJfV5fCmhkH4Kv6zrhisv8srfOV0xPhdiJx9JqF+sEKKFJyLukLLYqk4dJD+92YscCZSBQnmbu0xlkj4S4x3dl81wOM0SmKd0fJI9baPj2bZwID2LYPn0J3ZtZaNYHzOjcMMZIHzEGzB+4Lapj9gc42KEIGMDiW9pu67SsyYsw31JTT8KzjnYR+olyglgfXA8ispetNxaxZq5uBGnO88vxmP/lyvxPvChQxHLNwZbrRuzwZYKfxZu+4IdQM4ITWDvZhsfN2g91/OIaEZlkJZtf/WdZedIr9DeucSor5h28gaKhkE/wflI0Ul9v0ZZurs1phJqR0s9IGeB7K8N0RkC/H25MzscPQtH4k2IaYAUnVAb0RU9n32RwPOx0zYOWZEYHKEN9IWfxUcr2CUoo8QlrZBD6OtLi8JQy3kygrb4Rm9sLN1WzBLdL1VgFugYA1wco+LRxxln3DtWyVjaS0okygoinFfBRhCPRWDh5yZDy92aHW2z1E8Rb1VXbfL/o9CIs7nJJGBiMm/qZgbbIXwP2xHCi2jUmwUPzNbjrvI2G96TRKNTmBuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6241.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(52116002)(26005)(6916009)(66476007)(66946007)(2906002)(36756003)(31686004)(86362001)(31696002)(53546011)(6506007)(2616005)(6486002)(66556008)(38350700002)(83380400001)(8936002)(966005)(4326008)(38100700002)(8676002)(5660300002)(316002)(54906003)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFsSDQzbk9vODhNczFtVU5jeXFLMnRCY09ndmhoMFlrczk0TnpRcXdXMEww?=
 =?utf-8?B?d3ZOQ0czSi9kbTAzNTBBbnJ2bmtVTENMQit0aWFxL01TUS9PaW5IUXlvMkxj?=
 =?utf-8?B?QnoyUVM3MHV2V1d1bm1VbFg1Z0UrWFRnWlIzZkt2Y1YzSHREa3pYTmhkcXdN?=
 =?utf-8?B?VkVDMVBubC9TNENkejdVUTR3aGRGSnhtYnYrWDNvT0hNK2lUYUVWVDhrRjc5?=
 =?utf-8?B?TmdpOFRyc2k5YnA0Q3Y4QzFqYzllQytFQ2ovd0E4NFJGdFlmVGM5aXRWMGl5?=
 =?utf-8?B?NjAySlkrVkhkZVJkSnUzQUdCSzg2ZGpqSzBBR2UxOUJJTS8vUktZQldicmdu?=
 =?utf-8?B?ZGRiSWQrREJma0ZNOHI2MzlBK293ZFI1WHl1OGs5czlvaHBDQkg0d3RmZlFY?=
 =?utf-8?B?b2ZnRkxSNWtyTTE4V2tOcjlyYTdpdy9Ua3FhMkcweU44S0JUSm9ydS9lWDlv?=
 =?utf-8?B?TUpHMzJibVh1bjBHWkZuV3dJK1AxUmo5c2pIRW55OVhLVmNJMEI4Smd3dGtX?=
 =?utf-8?B?dkVKdlNIQlVxNFVxR3pWMDFhUzRmYWlmRlJWWVJpVEdhWnphekFQN2Jtakhq?=
 =?utf-8?B?QUNkaXBtcVlZUUR5dkdvTTFORXhmRWFRRnJYRjFNL0tFZzJ6VDhGek1jSEUx?=
 =?utf-8?B?RkZ6MjIyZkVwSFBJMWMxVXJFTVRScEpFU3FPTmhvREdUTTBpRDdHeDdVQ1Q2?=
 =?utf-8?B?Zm1ZQXhYdVFPZ3JhQnlCQWh5TERIT3NXTXNjUWxCMHMveldPU2VlNDdmakkv?=
 =?utf-8?B?bXFwV2NTOFF5MGpSSUp1TXhheXZDcjJ3U2paMlpQcG5LRklqdENVbUEyRE1C?=
 =?utf-8?B?WThzSE1QLzVlVkxNNytaQXdzYkZ1Y2l3Qjc1SW1tMnduclNMYTNGcUlGZTlz?=
 =?utf-8?B?Um5PNDBaL0IrUEY5RHU2TDR1dEl0dkY3VG8yYlJaOVhPaGR0S0dhRW5KeVdG?=
 =?utf-8?B?MHpsMlI1OFQwTHpxSEZRY1B6ck15WUVPd3k2Q1RFWEkxbXNvNkxOWFd1K1VL?=
 =?utf-8?B?MFJ1TVp0cUZMOENZQzFYSGlFTHJuMHVXa3hIbGJnNUVNeGxLV2k3dW5RT3JQ?=
 =?utf-8?B?OVlnVFYrMFpLTTlJb2VDZ1hkUms1ZWV4YXR4ODQwMzRHWmJOUm5FOUVxalBi?=
 =?utf-8?B?Q0pkaFg2S3NUUTluUTU3R0RtRGJtWW9mcjFzdTFiaFdWVnVtUXkwU3FnSmda?=
 =?utf-8?B?cndnbHF3dG0remhtdGptQUg2dHpQb1hENnZEV2t2SlVNNHg3bkNMaEtSL1Ra?=
 =?utf-8?B?cXMvTG9oMnRWWVlNMDB3cGJ4elE0cmk1aGhsbWY3aWpiL3NXZ0ZHdGJNMkdV?=
 =?utf-8?B?KzIzek8rd1haMzN5eEFCK2NlNkxNdi9NTDhxd1V5T3oySWdBU1A2KzA3WFBW?=
 =?utf-8?B?YzRnT0I5eVpzbDF3akg0YVFhckI0UHV0TW1KQmNDN1VLKzZNY0tnbDFON0pl?=
 =?utf-8?B?R25hVWJnbDM1Rm9BamxTMGN0TGFvbzA1dW9RRzVMNG9zN0ZUYVpQemt1c2F2?=
 =?utf-8?B?dm1OSDVoM3gydTYxQk83LzFTcGpQT0J2TjRES3ZjbjNuOUJrRDBXWHRldmpt?=
 =?utf-8?B?WUlRZi9nUGdoNzBEeHpVM1RiYzRLeURTYkQwcGZQa1NTbDkvc2c3VTdsVE9n?=
 =?utf-8?B?NUpRTFVrblhyaktGdHZTVTNuaVY4aWlXOGhJbTE5NDlyOWtGTzhBV0xWU0sv?=
 =?utf-8?B?UUhRbm9MK1lVOFNDanhNOU9pV0czWmtYM3c3dm1TdjcrRUJNeUoyb0NwYmx5?=
 =?utf-8?B?RTQyNGE5bUk2cTExR1ZoV3ZWZk9tSitBcHNkNUtUTE85dzlVdzBGSlc3OVFN?=
 =?utf-8?B?VkJJYk9XMEhDREx2VW9DZEVVSzZEZjUvUWFIdnJiREdUbVlMKzdlTGNtU0Rz?=
 =?utf-8?B?R0hHOStsci9KRHl3dk1zZmJ3MTd1VlFrRGxkTHB0eGEyd2xrWnRmYVNiTmV4?=
 =?utf-8?B?Q1pkbm85RHBMVkxQK3BHRUdiendYZGZIaXRiNEo1YU9wd0YyYmxCb2E2OFBI?=
 =?utf-8?B?eklubHIydkhwZ2pFTnllbGxYSkhQaUJFVXcrb3I2TFd3WEdGOXozUEw1bVJW?=
 =?utf-8?B?T2NCYUtyN0w4UmlINklkWndCUGFBbi9zbmdINnpDdlhWeWxtaGlJZElTeXZ6?=
 =?utf-8?B?K0ZJZXljZTVhZWhsSkFxY2Z5bTY2aVJNc3Y3NnowMGZERUdJdy93RXphcklI?=
 =?utf-8?Q?K2aBUvcujKFbLr58wT9xP9g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63b1657-dc67-4d29-8b59-08d9d91e01f3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6241.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 18:28:35.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRjlLsCRruqG8rmecPobbF/POtQeRVcBNIuIoXTxdJ8SnjjXN4WBca44LsnSdNSaNc5L+x5Ioq0grV9NdsoaJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5917
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16.01.2022 15:44, Vasily Averin wrote:
> On 03.01.2022 22:53, J. Bruce Fields wrote:
>> On Wed, Dec 29, 2021 at 11:24:43AM +0300, Vasily Averin wrote:
>>> nfsd and lockd use F_SETLK cmd with the FL_SLEEP flag set to request
>>> asynchronous processing of blocking locks.
>>>
>>> Currently nfs4 use locks_lock_inode_wait() function which is blocked
>>> for such requests. To handle them correctly FL_SLEEP flag should be
>>> temporarily reset before executing the locks_lock_inode_wait() function.
>>>
>>> Additionally block flag is forced to set, to translate blocking lock to
>>> remote nfs server, expecting it supports async processing of the blocking
>>> locks too.
>>
>> But this on its own isn't enough for the client to support asynchronous
>> blocking locks, right?  Don't we also need the logic that calls knfsd's
>> lm_notify when it gets a CB_NOTIFY_LOCK from the server?
> 
> No, I think this should be enough.
> We are here a nfs client,
> we can get F_SETLK with FL_SLEEP from nfsd only (i.e. in re-export case)
> we need to avoid blocking if lock is already taken, 
> so we need to call locks_lock_inode_wait without FL_SLEEP,
> then we submit _sleeping_ request to NFS server (i.e. set )data->arg.block = 1)
> and waiting for reply from server.
> 
> Here we rely that server will NOT block on such request too, so our reply wel not be blocked too.

Now I think this assumption is wrong.
We cannot guarantee that NFS server will process our sleeping request asynchronously.
yes, new version of knfsd will do it.
however there are a lot of other NFS servers, that can process this request synchronously and wait till locked fail will be unlocked.

All we can do here is just drop FL_SLEEP and handle incoming async request (F_SETLK with FL_SLEEP) like a regular non-blocking F_SETLK.
Thank you,
	Vasily Averin

> Under "block" I mean that handler can sleep or process request for a very long time 
> but it will NOT BE BLOCKED if lock is taken already, it WILL NOT WAIT when lock will be released,
> it just return some error in this case.
> 
> I think it is correct.
> Do you think I am wrong or maybe I missed something? 
> 
> Thank you,
> 	Vasily Averin
> 
> However I noticed now that past is incorrect, 
> temporally dropped FL_SLEEP should be restored back in _nfs4_proc_setlk before _nfs4_do_setlk() call.
> I'll fix it in next version of this patch-set.
> 
>>> https://bugzilla.kernel.org/show_bug.cgi?id=215383
>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>>> ---
>>>  fs/nfs/nfs4proc.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index ee3bc79f6ca3..9b1380c4223c 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -7094,7 +7094,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
>>>  			recovery_type == NFS_LOCK_NEW ? GFP_KERNEL : GFP_NOFS);
>>>  	if (data == NULL)
>>>  		return -ENOMEM;
>>> -	if (IS_SETLKW(cmd))
>>> +	if (IS_SETLKW(cmd) || (fl->fl_flags & FL_SLEEP))
>>>  		data->arg.block = 1;
>>>  	nfs4_init_sequence(&data->arg.seq_args, &data->res.seq_res, 1,
>>>  				recovery_type > NFS_LOCK_NEW);
>>> @@ -7200,6 +7200,9 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
>>>  	int status;
>>>  
>>>  	request->fl_flags |= FL_ACCESS;
>>> +	if (((fl_flags & FL_SLEEP_POSIX) == FL_SLEEP_POSIX) && IS_SETLK(cmd))
>>> +		request->fl_flags &= ~FL_SLEEP;
>>> +
>>>  	status = locks_lock_inode_wait(state->inode, request);
>>>  	if (status < 0)
>>>  		goto out;
>>> -- 
>>> 2.25.1
> 

