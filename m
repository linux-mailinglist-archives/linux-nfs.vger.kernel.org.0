Return-Path: <linux-nfs+bounces-21907-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A0/H166E2r/FAcAu9opvQ
	(envelope-from <linux-nfs+bounces-21907-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 04:56:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B25C57AA
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 04:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DCE83009B31
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 02:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474812D1303;
	Mon, 25 May 2026 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q//9YEFE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB42C375A;
	Mon, 25 May 2026 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779677775; cv=none; b=I5WfuaZ+oVCREixnoRe6jOOXV7a/DINDgmI4H2MHxvcZ6oPbiQGDoTw/KUsVieYnrMAHlvXmM73YKzPcMHTfA3+LnLWFykEz3b5VnHhyuRcrI+VZXTRQ/2PgWVLAoJ1v6NHRVyI8No90cf09y+uVsbhpTDJz8yY1Qr0kjUKYQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779677775; c=relaxed/simple;
	bh=i7jqF7KB60rAj2AodsD9VTYn7Kz2HqOFrxwajLcDu48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIqaMcAtkfUU3tPMKGRzUMGH/t9onAOdxjGoWPkubZwVofAQ5WYN1WD1QF4r+V4o6yVqhJLzsoX0YoDPf7xZe9kNNdCXqL2hjvptlcnWYD7Z4R4R4+J6MLxIBSdP8vwL5NGGFZ4odirXXTdT9h9ynPM5uIbeRB7+FFfSuqvaRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q//9YEFE; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779677768; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uKSeg2Nza4neRSzanFebtUm6bwcAHZPjsw3+MJtuG0c=;
	b=q//9YEFEH8b+fCC/C8Kuas4QyBxwuuj/03udbzWbkC+LVfvrYtfxT6siAQd+jr+l7tF046Ajl2mjD/HNR6R8S/RurZ54sUsGc1c8sdUz5PcRLFkmWe7Lm2F1r8u8HvBHq3Z/Y6SCygvwCoeqsmMbxYPRWzkIVGIllayfdXfMe98=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X3Ty9G._1779677440;
Received: from 30.221.145.59(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X3Ty9G._1779677440 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 May 2026 10:50:42 +0800
Message-ID: <a5756f39-31c8-4e8b-939f-f498726c7d8a@linux.alibaba.com>
Date: Mon, 25 May 2026 10:50:40 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] ocfs2/dlm: replace __get_free_page() with kmalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 akpm <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-3-275e36a83f0e@kernel.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20260523-b4-fs-v1-3-275e36a83f0e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21907-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joseph.qi@linux.alibaba.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2B3B25C57AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/24/26 1:54 AM, Mike Rapoport (Microsoft) wrote:
> A few places in ocsfs2 allocate temporary buffers with __get_free_page() or
> get_zeroed_page().
> 
> kmalloc() is a better API for such use and it also provides better
> scalability and more debugging possibilities.
> 
> Replace use of __get_free_page() and get_zeroed_page() with kmalloc() and
> kzalloc() respectively.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/dlm/dlmdebug.c    | 24 +++++++++---------------
>  fs/ocfs2/dlm/dlmdomain.c   |  8 +++++---
>  fs/ocfs2/dlm/dlmmaster.c   |  5 ++---
>  fs/ocfs2/dlm/dlmrecovery.c |  4 ++--
>  4 files changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
> index fe4fdd09bae3..6ca8b3b68eef 100644
> --- a/fs/ocfs2/dlm/dlmdebug.c
> +++ b/fs/ocfs2/dlm/dlmdebug.c
> @@ -260,10 +260,10 @@ void dlm_print_one_mle(struct dlm_master_list_entry *mle)
>  {
>  	char *buf;
>  
> -	buf = (char *) get_zeroed_page(GFP_ATOMIC);
> +	buf = kzalloc(PAGE_SIZE, GFP_ATOMIC);
>  	if (buf) {
>  		dump_mle(mle, buf, PAGE_SIZE - 1);
> -		free_page((unsigned long)buf);
> +		kfree(buf);
>  	}
>  }
>  
> @@ -280,7 +280,7 @@ static struct dentry *dlm_debugfs_root;
>  /* begin - utils funcs */
>  static int debug_release(struct inode *inode, struct file *file)
>  {
> -	free_page((unsigned long)file->private_data);
> +	kfree(file->private_data);
>  	return 0;
>  }
>  
> @@ -327,17 +327,15 @@ static int debug_purgelist_open(struct inode *inode, struct file *file)
>  	struct dlm_ctxt *dlm = inode->i_private;
>  	char *buf = NULL;
>  
> -	buf = (char *) get_zeroed_page(GFP_NOFS);
> +	buf = kzalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!buf)
> -		goto bail;
> +		return -ENOMEM;
>  
>  	i_size_write(inode, debug_purgelist_print(dlm, buf, PAGE_SIZE - 1));
>  
>  	file->private_data = buf;
>  
>  	return 0;
> -bail:
> -	return -ENOMEM;
>  }
>  
>  static const struct file_operations debug_purgelist_fops = {
> @@ -384,17 +382,15 @@ static int debug_mle_open(struct inode *inode, struct file *file)
>  	struct dlm_ctxt *dlm = inode->i_private;
>  	char *buf = NULL;
>  
> -	buf = (char *) get_zeroed_page(GFP_NOFS);
> +	buf = kzalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!buf)
> -		goto bail;
> +		return -ENOMEM;
>  
>  	i_size_write(inode, debug_mle_print(dlm, buf, PAGE_SIZE - 1));
>  
>  	file->private_data = buf;
>  
>  	return 0;
> -bail:
> -	return -ENOMEM;
>  }
>  
>  static const struct file_operations debug_mle_fops = {
> @@ -775,17 +771,15 @@ static int debug_state_open(struct inode *inode, struct file *file)
>  	struct dlm_ctxt *dlm = inode->i_private;
>  	char *buf = NULL;
>  
> -	buf = (char *) get_zeroed_page(GFP_NOFS);
> +	buf = kzalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!buf)
> -		goto bail;
> +		return -ENOMEM;
>  
>  	i_size_write(inode, debug_state_print(dlm, buf, PAGE_SIZE - 1));
>  
>  	file->private_data = buf;
>  
>  	return 0;
> -bail:
> -	return -ENOMEM;
>  }
>  
>  static const struct file_operations debug_state_fops = {
> diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
> index dc9da9133c8e..97bb9400e24b 100644
> --- a/fs/ocfs2/dlm/dlmdomain.c
> +++ b/fs/ocfs2/dlm/dlmdomain.c
> @@ -63,7 +63,7 @@ static inline void byte_copymap(u8 dmap[], unsigned long smap[],
>  static void dlm_free_pagevec(void **vec, int pages)
>  {
>  	while (pages--)
> -		free_page((unsigned long)vec[pages]);
> +		kfree(vec[pages]);
>  	kfree(vec);
>  }
>  
> @@ -75,9 +75,11 @@ static void **dlm_alloc_pagevec(int pages)
>  	if (!vec)
>  		return NULL;
>  
> -	for (i = 0; i < pages; i++)
> -		if (!(vec[i] = (void *)__get_free_page(GFP_KERNEL)))
> +	for (i = 0; i < pages; i++) {
> +		vec[i] = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +		if (!vec[i])
>  			goto out_free;
> +	}
>  
>  	mlog(0, "Allocated DLM hash pagevec; %d pages (%lu expected), %lu buckets per page\n",
>  	     pages, (unsigned long)DLM_HASH_PAGES,
> diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
> index 93eff38fdadd..aee3b4c56dcc 100644
> --- a/fs/ocfs2/dlm/dlmmaster.c
> +++ b/fs/ocfs2/dlm/dlmmaster.c
> @@ -2548,7 +2548,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
>  
>  	/* preallocate up front. if this fails, abort */
>  	ret = -ENOMEM;
> -	mres = (struct dlm_migratable_lockres *) __get_free_page(GFP_NOFS);
> +	mres = kmalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!mres) {
>  		mlog_errno(ret);
>  		goto leave;
> @@ -2725,8 +2725,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
>  	if (wake)
>  		wake_up(&res->wq);
>  
> -	if (mres)
> -		free_page((unsigned long)mres);
> +	kfree(mres);
>  
>  	dlm_put(dlm);
>  
> diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
> index 128872bd945d..9b97bf73df22 100644
> --- a/fs/ocfs2/dlm/dlmrecovery.c
> +++ b/fs/ocfs2/dlm/dlmrecovery.c
> @@ -837,7 +837,7 @@ int dlm_request_all_locks_handler(struct o2net_msg *msg, u32 len, void *data,
>  	}
>  
>  	/* this will get freed by dlm_request_all_locks_worker */
> -	buf = (char *) __get_free_page(GFP_NOFS);
> +	buf = kmalloc(PAGE_SIZE, GFP_NOFS);
>  	if (!buf) {
>  		kfree(item);
>  		dlm_put(dlm);
> @@ -933,7 +933,7 @@ static void dlm_request_all_locks_worker(struct dlm_work_item *item, void *data)
>  		}
>  	}
>  leave:
> -	free_page((unsigned long)data);
> +	kfree(data);
>  }
>  
>  
> 


