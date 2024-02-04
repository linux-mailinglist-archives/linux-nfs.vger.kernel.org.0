Return-Path: <linux-nfs+bounces-1747-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA456848ACA
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 04:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0AA283709
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Feb 2024 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD44439;
	Sun,  4 Feb 2024 03:19:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A51C0F;
	Sun,  4 Feb 2024 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707016754; cv=none; b=cpTPGng0+DQ3EH1K1Qewh1jDnNvVVGom3bFlBRPiGLmM2oMYAnXvv9hIRIHceSOQ+DTKOxDfZbvgM3OAkvtaJbPGOdvKKtjywf26y+Ry84X40RWCOH0bQPd3p6HbH0+I26hhZTQ7OkzPLow7HlEEPoID9eHMG35nwQKSX37n08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707016754; c=relaxed/simple;
	bh=ghSEsjw9CFMjsPbWUeHy4zP8WG0sWJdqIOdIFjT4SHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gigjOEizqg6/Rq08nntdMlnmdSukSLQ8NmqlMAVaGuY6I6qbIA9DSbDJOIt+eF5I2uWmBBd2R+O/Q0Y+uckpoluCK2Gtq18jbIYVmznTIZasKWfnfqpFjWdXetaL7/Glb0tdlz4FOjWTh5kp6M/7/0hj4z9rT2FLmoOwcHsd80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 91906f1cf5674cd18880d18cec116c50-20240204
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5c421b5b-2ecf-4dc6-afdb-00148a5d42c0,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:5c421b5b-2ecf-4dc6-afdb-00148a5d42c0,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:36391780-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240202221341IMS52CKR,BulkQuantity:15,Recheck:0,SF:66|38|24|17|19|44|
	64|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_OBB,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI
X-UUID: 91906f1cf5674cd18880d18cec116c50-20240204
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 959944311; Sun, 04 Feb 2024 11:19:03 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 08E1EE000EBC;
	Sun,  4 Feb 2024 11:19:03 +0800 (CST)
X-ns-mid: postfix-65BF0226-922626287
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3090AE000EBC;
	Sun,  4 Feb 2024 11:19:01 +0800 (CST)
Message-ID: <09185acc-85f5-4cd3-a268-b6497e340cd9@kylinos.cn>
Date: Sun, 4 Feb 2024 11:19:00 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: Simplify the allocation of slab caches in
 nfsd_drc_slab_create
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>
Cc: chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240201081935.200031-1-chentao@kylinos.cn>
 <94F7DA15-6D4C-4205-9A23-E4593A4A2312@redhat.com>
 <2a9a533ad2341096ef4ffd3533a652ad8fdae2fe.camel@kernel.org>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <2a9a533ad2341096ef4ffd3533a652ad8fdae2fe.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you to all the guys who responded to my emails.

On 2024/2/2 22:24, Jeff Layton wrote:
> On Fri, 2024-02-02 at 09:13 -0500, Benjamin Coddington wrote:
>> On 1 Feb 2024, at 3:19, Kunwu Chan wrote:
>>
>>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>>> to simplify the creation of SLAB caches.
>>> Make the code cleaner and more readable.
>>>
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>> ---
>>>   fs/nfsd/nfscache.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
>>> index 5c1a4a0aa605..64ce0cc22197 100644
>>> --- a/fs/nfsd/nfscache.c
>>> +++ b/fs/nfsd/nfscache.c
>>> @@ -166,8 +166,7 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, struct nfsd_cacherep *rp,
>>>
>>>   int nfsd_drc_slab_create(void)
>>>   {
>>> -	drc_slab = kmem_cache_create("nfsd_drc",
>>> -				sizeof(struct nfsd_cacherep), 0, 0, NULL);
>>> +	drc_slab = KMEM_CACHE(nfsd_cacherep, 0);
>>>   	return drc_slab ? 0: -ENOMEM;
>>>   }
>>>
>>> -- 
>>> 2.39.2
>>
>> I don't agree that the code is cleaner or more readable like this.  I really
>> dislike having to parse through the extra "simplification" to see what's
>> actually being called and sent.
>>
>> Just my .02 worth.
>>
>> Ben
>>
> 
Everyone has a different opinion. From newcomers like me, a simple code 
is more important than checking all the args of a call function to 
understand what it does.
Too many default arguments can cost us a lot of time that could be spent 
understanding the main logic of the module code, rather than wasting it 
on a single line of calls.

> This will also result in a behavioral change. The "nfsd_drc" string is
> lost with the above macro and (I think) the new name will be
> "nfsd_cacherep". I'm not necessarily opposed to that, as I don't think
> anything depends on the old name, but it should at least be noted in the
> changelog.
Thanks i'll update my v2 patch with a new commit msg to show the name 
change.

> 
-- 
Thanks,
   Kunwu


