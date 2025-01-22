Return-Path: <linux-nfs+bounces-9457-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C108BA18CC8
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 08:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590F03A6E37
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 07:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB5154420;
	Wed, 22 Jan 2025 07:31:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F91607AC;
	Wed, 22 Jan 2025 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737531097; cv=none; b=knuFvOUprTYXemnVegZS93gBqXTnepUsRxP6FEdl08P+gPfADQd02zoA+a8IBgWcioA6o0t1emfQXgp7/d2RyOXaGuVPe2deWBmkGTN+9t3vDeAQK3Jhp48pc6GB5s4hgcmTyRGQsaTtfspryzZ0T6w/UZS3NYdXbRYgNHbBezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737531097; c=relaxed/simple;
	bh=LIiOTgjKWhFz77PF2e0k/N4zN1NuQj5EeDMOhMZzZTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VuJrXB3Ynb53iuo7ok5rVZeIUd5OrkZ60FDGPTXAYsg3E5VYn+6C327Mkl8sy4YodRM90OGKi98Xc64cevH5F7FCnsoC+aYvf/HDA6wbgS30JbQaHy4yLS0CHy71KQKDsbzA2nMJjuKJPo2HEHLW6P6U7dSuY/dV2ZouNZShZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YdG1Y21vLzmZ92;
	Wed, 22 Jan 2025 15:29:53 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 27E571403D2;
	Wed, 22 Jan 2025 15:31:32 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Jan 2025 15:31:31 +0800
Message-ID: <b90d5ba2-69a6-4373-8aea-16eff78a3419@huawei.com>
Date: Wed, 22 Jan 2025 15:31:30 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<lilingfeng@huaweicloud.com>
References: <> <6fb21e60487273864136b4912951b5a4fb5b3ae0.camel@kernel.org>
 <173750853452.22054.17347206263008180503@noble.neil.brown.name>
 <173751770796.22054.11065694028641211869@noble.neil.brown.name>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <173751770796.22054.11065694028641211869@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/1/22 11:48, NeilBrown 写道:
> On Wed, 22 Jan 2025, NeilBrown wrote:
>> On Wed, 22 Jan 2025, Jeff Layton wrote:
>>> To be clear, I think we need to drop e57420be100ab from your nfsd-
>>> testing branch. The race I identified above is quite likely to occur
>>> and could lead to leaks.
>>>
>>> If Li Lingfeng doesn't propose a patch, I'll spin one up tomorrow. I
>>> think the RCU approach is safe.
>> I'm not convinced this is the right approach.
>> I cannot see how nfsd_file_put() can race with unhashing.  If it cannot
>> then we can simply unconditionally call nfsd_file_schedule_laundrette().
>>
>> Can describe how the race can happen - if indeed it can.
> I thought I should explore this more and explain what I think actually
> happens ...
>
> Certainly nfsd_file_unhash() might race with nfsd_file_put().  At this
> point in nfsd_file_put() we have the only reference but a hash lookup
> could gain another reference and the immediately unhash it.
> nfsd_file_queue_for_close() can do this.  There might be other paths.
>
> But why does this mean we need to remove it from the lru and free it
> immediately?  If we leave it on the lru it will be freed in a couple of
> seconds.
>
> The reason might be nfsd_file_close_inode_sync().  This needs to close
> files before returning.
> But if nfsd_file_close_inode_sync() is called while some other thread
> holds a reference to the file and might want to call nfsd_file_put(),
> then it isn't going to succeed anyway so any race here doesn't make any
> difference.
>
> So I think the following might be the best fix
Agree.
I ignored the trace point in nfsd_file_lru_add(), this one looks better.
And I have tested it.

Thanks.

>
> ???
>
> Thanks,
> NeilBrown
>
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index fcd751cb7c76..773788a50e56 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -322,10 +322,13 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>   static bool nfsd_file_lru_add(struct nfsd_file *nf)
>   {
>   	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> +	rcu_read_lock();
>   	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
>   		trace_nfsd_file_lru_add(nf);
> +		rcu_read_unlock();
>   		return true;
>   	}
> +	rcu_read_unlock();
>   	return false;
>   }
>   
> @@ -371,19 +374,8 @@ nfsd_file_put(struct nfsd_file *nf)
>   
>   		/* Try to add it to the LRU.  If that fails, decrement. */
>   		if (nfsd_file_lru_add(nf)) {
> -			/* If it's still hashed, we're done */
> -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -				nfsd_file_schedule_laundrette();
> -				return;
> -			}
> -
> -			/*
> -			 * We're racing with unhashing, so try to remove it from
> -			 * the LRU. If removal fails, then someone else already
> -			 * has our reference.
> -			 */
> -			if (!nfsd_file_lru_remove(nf))
> -				return;
> +			nfsd_file_schedule_laundrette();
> +			return;
>   		}
>   	}
>   	if (refcount_dec_and_test(&nf->nf_ref))
>
>

