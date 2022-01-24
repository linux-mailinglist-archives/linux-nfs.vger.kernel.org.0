Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0E49796E
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 08:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbiAXH2d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 02:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbiAXH2d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 02:28:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC2C06173D;
        Sun, 23 Jan 2022 23:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YpJARcXKoGZPiJTfBdQDT9/oQ0nkzXZFh+P1EKhj/Rk=; b=1zmEJAk7pautCE8IyG6nZ+P5DN
        jcPS/4+RmkEGX01/KBzzlRLnv4Ujbp7wwgKrSXqfwku67x107dWyRcpSaWDJg2eGf0hDMWfsacXFb
        yRZJcr1xvoDHM7gKnb2AOf5U7uVKNsooqq+S+D5m1p4X/GnRmt2wP472bzUalfgBZNOewWJDqX1jH
        dFw11VZyBegH/EYSd1cXZwJQmpWxfT/clDdLodgbufqdxJ0oj2JFWUbRjBVSFra1KbbS8rFatUTR5
        g9gxfWDSGqJhMgnekdc4tCgIhLhAZNbGLyqmIbdSqYI7fa1kbs32J9dYVoNCQULd88p/VI0M8GdoB
        KM8aRK3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBtm5-002UAu-N6; Mon, 24 Jan 2022 07:28:25 +0000
Date:   Sun, 23 Jan 2022 23:28:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 03/23] MM: drop swap_set_page_dirty
Message-ID: <Ye5VGY7jy+wXk806@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611274.26253.3394253485576079921.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611274.26253.3394253485576079921.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> Pages that are written to swap are owned by the MM subsystem - not any
> filesystem.
> 
> When such a page is passed to a filesystem to be written out to a
> swap-file, the filesystem handles the data, but the page itself does not
> belong to the filesystem.  So calling the filesystem's set_page_dirty
> address_space operation makes no sense.  This is for pages in the given
> address space, and a page to be written to swap does not exist in the
> given address space.
> 
> So drop swap_set_page_dirty() which calls the address-space's
> set_page_dirty, and alway use __set_page_dirty_no_writeback, which is
> appropriate for pages being swapped out.

Yes, this looks sane to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> 
> Fixes-no-auto-backport: 62c230bc1790 ("mm: add support for a filesystem to activate swap files and use direct_IO for writing swap pages")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/swap.h |    1 -
>  mm/page_io.c         |   14 --------------
>  mm/swap_state.c      |    2 +-
>  3 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 3f54a8941c9d..a43929f7033e 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -419,7 +419,6 @@ extern void kswapd_stop(int nid);
>  
>  #ifdef CONFIG_SWAP
>  
> -extern int swap_set_page_dirty(struct page *page);
>  int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
>  		unsigned long nr_pages, sector_t start_block);
>  int generic_swapfile_activate(struct swap_info_struct *, struct file *,
> diff --git a/mm/page_io.c b/mm/page_io.c
> index f8c26092e869..34b12d6f94d7 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -438,17 +438,3 @@ int swap_readpage(struct page *page, bool synchronous)
>  	delayacct_swapin_end();
>  	return ret;
>  }
> -
> -int swap_set_page_dirty(struct page *page)
> -{
> -	struct swap_info_struct *sis = page_swap_info(page);
> -
> -	if (data_race(sis->flags & SWP_FS_OPS)) {
> -		struct address_space *mapping = sis->swap_file->f_mapping;
> -
> -		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
> -		return mapping->a_ops->set_page_dirty(page);
> -	} else {
> -		return __set_page_dirty_no_writeback(page);
> -	}
> -}
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 093ecf864200..d541594be1c3 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -31,7 +31,7 @@
>   */
>  static const struct address_space_operations swap_aops = {
>  	.writepage	= swap_writepage,
> -	.set_page_dirty	= swap_set_page_dirty,
> +	.set_page_dirty	= __set_page_dirty_no_writeback,
>  #ifdef CONFIG_MIGRATION
>  	.migratepage	= migrate_page,
>  #endif
> 
> 
---end quoted text---
