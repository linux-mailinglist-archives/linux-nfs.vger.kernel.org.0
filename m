Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E9C47BBFA
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 09:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhLUIkV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 03:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhLUIkU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 03:40:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAD7C061574;
        Tue, 21 Dec 2021 00:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xTgGXdRhk/J8c5C+wjN+pamdHhw1k/IjmQ+O8umcpLE=; b=mAHY6xQJXk3yN9gApc5WYAdWv4
        MBpKl0uCLHdpaf8B7I/j+exPfGWQaKiLTXcG40qXoRa5d8ix1WwYHRSOpvKM/UxCxNfJoG009ov9x
        F/U5byv2l1OhEQVXkMWYTfOW4n/M+r657oJdcidD4al3A6OPaDJI3I3a5rSU/9yeywi5GbhoOllJf
        1V2D5Vz18htUWvrnR8cvWjpJJpITTKPvIYAqRaNnmMFgFp6/WGXjcs/Z/aKU2KcWurDntil7ZrBbR
        CxQGQyGygnzPpTqIsSsngvtVbK2f5MXxjF+XHPnJZRulRJ3UJ2/ucg7IOpIahZrhCNNHWww0dQ0Vx
        ootWzaDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzagy-005xZe-Tp; Tue, 21 Dec 2021 08:40:16 +0000
Date:   Tue, 21 Dec 2021 00:40:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] MM: use ->swap_rw for reads from SWP_FS_OPS
 swap-space
Message-ID: <YcGS8IMk4li9qYHC@infradead.org>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
 <163969850289.20885.1044395970457169316.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850289.20885.1044395970457169316.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> +int sio_pool_init(void)
> +{
> +	if (!sio_pool)
> +		sio_pool = mempool_create_kmalloc_pool(
> +			SWAP_CLUSTER_MAX, sizeof(struct swap_iocb));

I can't see anything serializing access here, so we'll need a lock or
cmpxchg dance.

> +	if (sio_pool)
> +		return 0;
> +	else
> +		return -ENOMEM;

Nit: This would flow much nicer as:

	if (!sio_pool)
		return -ENOMEM;
	return 0;

>  int swap_readpage(struct page *page, bool synchronous)
>  {
>  	struct bio *bio;
> @@ -378,13 +412,25 @@ int swap_readpage(struct page *page, bool synchronous)
>  	}
>  
>  	if (data_race(sis->flags & SWP_FS_OPS)) {
> -		//struct file *swap_file = sis->swap_file;
> -		//struct address_space *mapping = swap_file->f_mapping;

This should not be left by the previous patch.  In fact I suspect the
part of the previous patch that adds ->swap_rw should probably be folded
into this patch.

> +		struct file *swap_file = sis->swap_file;
> +		struct address_space *mapping = swap_file->f_mapping;
> +		struct iov_iter from;
> +		struct swap_iocb *sio;
> +		loff_t pos = page_file_offset(page);
> +
> +		sio = mempool_alloc(sio_pool, GFP_KERNEL);
> +		init_sync_kiocb(&sio->iocb, swap_file);
> +		sio->iocb.ki_pos = pos;
> +		sio->iocb.ki_complete = sio_read_complete;
> +		sio->bvec.bv_page = page;
> +		sio->bvec.bv_len = PAGE_SIZE;
> +		sio->bvec.bv_offset = 0;
> +
> +		iov_iter_bvec(&from, READ, &sio->bvec, 1, PAGE_SIZE);
> +		ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
> +		if (ret != -EIOCBQUEUED)
> +			sio_read_complete(&sio->iocb, ret);
>  
>  		goto out;

I'd be tempted to split the SWP_FS_OPS into a helper to keep the
code tidy.
