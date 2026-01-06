Return-Path: <linux-nfs+bounces-17462-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548BCF6A3C
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 05:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC9E73004E03
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 04:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481921F1932;
	Tue,  6 Jan 2026 04:11:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B5335BA;
	Tue,  6 Jan 2026 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767672677; cv=none; b=QVLuBvMDKD92WFfvY1vY0UKAF2xacTHYtg75KQXEVyZtWKz8epy2p6q8zIdpbSq+ABVEHR1hrG8OIivP+O+TQKmHv73VakllyMD1IX/ofTNTiyXAdPi86xItSKMykNx1KEhwlUt3fwktfZ3JrJpTYw2MMbsTRHyYhYQh+oJUoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767672677; c=relaxed/simple;
	bh=YeiWODd/DTDW4NUqvZDz6rDojPwOPTLFJdZavxni+oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkpeQQUw73q9rgj39rvdr7128XOBt/RZiUsdWv6CWQjhp26kpBJGg8QI38wrzGglZo5M3l88YJ+U+nxfcG4nqFKQ59soEb8SMhBQPJWwWmMY639fVjQ0J+MRs+pFy5kVYKYXf+DTfZ2iC35l3ser5JshGgTMDe2asy/q169bBFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dld4S19VPzKHMP0;
	Tue,  6 Jan 2026 12:10:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5D8B740597;
	Tue,  6 Jan 2026 12:11:11 +0800 (CST)
Received: from [10.174.176.236] (unknown [10.174.176.236])
	by APP4 (Coremail) with SMTP id gCh0CgAHZ_dei1xp3OovCw--.62709S3;
	Tue, 06 Jan 2026 12:11:11 +0800 (CST)
Message-ID: <fcfbf7c0-f65f-4bf8-a702-4dafc9c094c9@huaweicloud.com>
Date: Tue, 6 Jan 2026 12:11:10 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] NFSv4.1: slot table draining + memory reclaim can
 deadlock state manager creation
To: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, kolga@netapp.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
 lilingfeng3@huawei.com, zhangjian496@huawei.com
References: <20251230071744.9762-1-wangzhaolong@huaweicloud.com>
 <de47c214bf6c85735db8e74d630e05b4e9bbf767.camel@kernel.org>
From: Wang Zhaolong <wangzhaolong@huaweicloud.com>
In-Reply-To: <de47c214bf6c85735db8e74d630e05b4e9bbf767.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHZ_dei1xp3OovCw--.62709S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF13tF1UGFWkXFyrWr43Awb_yoW7Cr48pF
	ZxGrsxJr4kJr4xWrnxZF4jvw1F93y8Gw47JFWxWa1SyanxZw1DKFyjkw10yFWUJrZ7WayI
	gF4jyFyUua4Yv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UG-e
	OUUUUU=
X-CM-SenderInfo: pzdqw6xkdrz0tqj6x35dzhxuhorxvhhfrp/

Hi Trond,

Thanks a lot for taking the time to look into this and for the patch proposal.

> 
> I think we need to treat nfs_release_folio() as being different from
> nfs_wb_folio() altogether. There are too many different ways in which
> waiting on I/O can cause deadlocks, including waiting on the writeback
> to complete. My suggestion is therefore that we just make this simple,
> and see it as a hint that we should kick off either writeback or a
> commit, but not that we should be waiting for it to complete.
> So how about the following?
> 

I agree with the overall direction.Avoiding any synchronous waits from
->release_folio() makes a lot of sense

> 8<------------------------------------------------------------------
>  From 3533434037066b610d50e7bd36f3525ace296928 Mon Sep 17 00:00:00 2001
> Message-ID: <3533434037066b610d50e7bd36f3525ace296928.1767204181.git.trond.myklebust@hammerspace.com>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Wed, 31 Dec 2025 11:42:31 -0500
> Subject: [PATCH] NFS: Fix a deadlock involving nfs_release_folio()
> 
> Wang Zhaolong reports a deadlock involving NFSv4.1 state recovery
> waiting on kthreadd, which is attempting to reclaim memory by calling
> nfs_release_folio(). The latter cannot make progress due to state
> recovery being needed.
> 
> It seems that the only safe thing to do here is to kick off a writeback
> of the folio, without waiting for completion, or else kicking off an
> asynchronous commit.
> 
> Reported-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
> Fixes: 96780ca55e3c ("NFS: fix up nfs_release_folio() to try to release the page")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>   fs/nfs/file.c          |  3 ++-
>   fs/nfs/nfstrace.h      |  3 +++
>   fs/nfs/write.c         | 32 ++++++++++++++++++++++++++++++++
>   include/linux/nfs_fs.h |  1 +
>   4 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index d020aab40c64..d1c138a416cf 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -511,7 +511,8 @@ static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
>   		if ((current_gfp_context(gfp) & GFP_KERNEL) != GFP_KERNEL ||
>   		    current_is_kswapd() || current_is_kcompactd())
>   			return false;
> -		if (nfs_wb_folio(folio->mapping->host, folio) < 0)
> +		if (nfs_wb_folio_reclaim(folio->mapping->host, folio) < 0 ||
> +		    folio_test_private(folio))
>   			return false;
>   	}
>   	return nfs_fscache_release_folio(folio, gfp);
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 6ce55e8e6b67..9f9ce4a565ea 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -1062,6 +1062,9 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
>   DEFINE_NFS_FOLIO_EVENT(nfs_aop_readpage);
>   DEFINE_NFS_FOLIO_EVENT_DONE(nfs_aop_readpage_done);
>   
> +DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio_reclaim);
> +DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_reclaim_done);
> +
>   DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio);
>   DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_done);
>   
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 336c510f3750..5de9ec6c72a2 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -2024,6 +2024,38 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
>   	return ret;
>   }
>   
> +/**
> + * nfs_wb_folio_reclaim - Write back all requests on one page
> + * @inode: pointer to page
> + * @folio: pointer to folio
> + *
> + * Assumes that the folio has been locked by the caller
> + */
> +int nfs_wb_folio_reclaim(struct inode *inode, struct folio *folio)
> +{
> +	loff_t range_start = folio_pos(folio);
> +	size_t len = folio_size(folio);
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_ALL,
> +		.nr_to_write = 0,
> +		.range_start = range_start,
> +		.range_end = range_start + len - 1,
> +		.for_sync = 1,
> +	};
> +	int ret;

One small thing: in nfs_wb_folio_reclaim(), the else
nfs_commit_inode(inode, 0); branch seems to return an
uninitialized ret (unless I missed something).

> +
> +	if (folio_test_writeback(folio))
> +		return -EBUSY;
> +	if (folio_clear_dirty_for_io(folio)) {
> +		trace_nfs_writeback_folio_reclaim(inode, range_start, len);
> +		ret = nfs_writepage_locked(folio, &wbc);
> +		trace_nfs_writeback_folio_reclaim_done(inode, range_start, len,
> +						       ret);
> +	} else
> +		nfs_commit_inode(inode, 0);

Maybe init ret = 0, or return the value from
nfs_commit_inode() for tracing.

> +	return ret;
> +}
> +
>   /**
>    * nfs_wb_folio - Write back all requests on one page
>    * @inode: pointer to page
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index a6624edb7226..8dd79a3f3d66 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -637,6 +637,7 @@ extern int  nfs_update_folio(struct file *file, struct folio *folio,
>   extern int nfs_sync_inode(struct inode *inode);
>   extern int nfs_wb_all(struct inode *inode);
>   extern int nfs_wb_folio(struct inode *inode, struct folio *folio);
> +extern int nfs_wb_folio_reclaim(struct inode *inode, struct folio *folio);
>   int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio);
>   extern int  nfs_commit_inode(struct inode *, int);
>   extern struct nfs_commit_data *nfs_commitdata_alloc(void);

Happy to test this with my reproducer once you post it.

Thanks,
Wang Zhaolong


