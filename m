Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74123497AC5
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 09:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbiAXIzJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 03:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbiAXIzJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 03:55:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B347C06173B;
        Mon, 24 Jan 2022 00:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vEv9ZVm4FRM2sWGecomArAPFZr2kyAtBIJ0fxjajhKA=; b=H520EeGELfNL68TKhbR92ln0dj
        XKvss8VcBEDNoQ8IRsEHC5Wwef5wjYXkCSmd9tPqTyDiUbXXXjcDXRcWvQjsAFzzDMTFN4mMGjmIf
        SUsKICrwuxD1wFtrjEGhufCiem0oB15dmWprRtT6QOTfvKiR8zrvt6DYpBcQSLmbiggt/CdKWlynh
        9uR7RpkH9ZF+99bWbuYig7PgQkrSgajZptg0FHNc/7GAsS4/eSsqPxNOPhXKk6/K06V+V6Z6uZNL6
        5tEqauSzJYFpARpTU4iOgzctaXwD0I4VQ5ddz4A1dpELojqG4BxTGYlVJz18fx3Y7Sh2kAuXgYHMl
        EnfgFUHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBv7u-002gVx-V2; Mon, 24 Jan 2022 08:55:02 +0000
Date:   Mon, 24 Jan 2022 00:55:02 -0800
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
Subject: Re: [PATCH 10/23] MM: submit multipage write for SWP_FS_OPS
 swap-space
Message-ID: <Ye5pZpeiVmCFpgXw@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611279.26253.12350012848236496937.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611279.26253.12350012848236496937.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> swap_writepage() is given one page at a time, but may be called repeatedly
> in succession.
> For block-device swapspace, the blk_plug functionality allows the
> multiple pages to be combined together at lower layers.
> That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
> only active when CONFIG_BLOCK=y.  Consequently all swap reads over NFS
> are single page reads.
> 
> With this patch we pass a pointer-to-pointer via the wbc.
> swap_writepage can store state between calls - much like the pointer
> passed explicitly to swap_readpage.  After calling swap_writepage() some
> number of times, the state will be passed to swap_write_unplug() which
> can submit the combined request.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/writeback.h |    7 +++
>  mm/page_io.c              |  103 +++++++++++++++++++++++++++++----------------
>  mm/swap.h                 |    1 
>  mm/vmscan.c               |    9 +++-
>  4 files changed, 82 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index fec248ab1fec..6dcaa0639c0d 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -80,6 +80,13 @@ struct writeback_control {
>  
>  	unsigned punt_to_cgroup:1;	/* cgrp punting, see __REQ_CGROUP_PUNT */
>  
> +	/* To enable batching of swap writes to non-block-device backends,
> +	 * "plug" can be set point to a 'struct swap_iocb *'.  When all swap
> +	 * writes have been submitted, if with swap_iocb is not NULL,
> +	 * swap_write_unplug() should be called.
> +	 */
> +	struct swap_iocb **plug;

Mayb plug isn't really the best name for something swap-specific in this
generic structure?

Also the above does not fit the normal kernel comment style with an
otherwise empty

	/*

line.

> +	for (p = 0; p < sio->pages; p++) {
> +		struct page *page = sio->bvec[p].bv_page;
> +
> +		if (ret != 0 && ret != PAGE_SIZE * sio->pages) {
> +			/*
> +			 * In the case of swap-over-nfs, this can be a
> +			 * temporary failure if the system has limited
> +			 * memory for allocating transmit buffers.
> +			 * Mark the page dirty and avoid
> +			 * folio_rotate_reclaimable but rate-limit the
> +			 * messages but do not flag PageError like
> +			 * the normal direct-to-bio case as it could
> +			 * be temporary.
> +			 */
> +			set_page_dirty(page);
> +			ClearPageReclaim(page);
> +			pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
> +					   ret, page_file_offset(page));
> +		} else
> +			count_vm_event(PSWPOUT);

I'd rather check for the error condition ones and have separate loops
forthe success vs error cases instead of checking the condition again
and again.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
