Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8D47BC00
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 09:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhLUInW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 03:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhLUInW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 03:43:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D43CC061574;
        Tue, 21 Dec 2021 00:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DYR2S5ewk4HUFUjd2HbH/xwOxwzvreGNjIN9pC8vplc=; b=MTEMVoOLUCV3oj51jPjYvc8ECh
        TQg2seoX0W/DIVBzQBkbhHcJFOnhA1Mn+TqGFRv26H5S7qjois4MqVShBC56jMuC8D8Jaz10SdytD
        GIJkAXuXWKSIb8XEg7D2v8FCpoXYn+IyhwbLQKjufnTgD63t0Y7zovpg7JNkGmS3E4mq0kkZHan+l
        Ek9nMP1ZVgEkFlb7UKygAuSl+s+/XvbIlUMmVJz+QO4vQRremO27cC33IjTFz52YlfV9gbX2jTijo
        JJ4xsu2HZmP2LVDTBwhgPk1FpocYBX+1I6NHCyKq8ThqUNDQ8oweHA7vbQrAGWvwoi30LY7sOLCdp
        g9Dlh2qQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzaju-005xrI-BI; Tue, 21 Dec 2021 08:43:18 +0000
Date:   Tue, 21 Dec 2021 00:43:18 -0800
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
Subject: Re: [PATCH 05/18] MM: reclaim mustn't enter FS for SWP_FS_OPS
 swap-space
Message-ID: <YcGTpjkJwhTZyUOE@infradead.org>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
 <163969850295.20885.4255989535187500085.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850295.20885.4255989535187500085.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 10:48:22AM +1100, NeilBrown wrote:
> +static bool test_may_enter_fs(struct page *page, gfp_t gfp_mask)
> +{
> +	if (gfp_mask & __GFP_FS)
> +		return true;
> +	if (!PageSwapCache(page) || !(gfp_mask & __GFP_IO))
> +		return false;
> +	/* We can "enter_fs" for swap-cache with only __GFP_IO
> +	 * providing this isn't SWP_FS_OPS.
> +	 * ->flags can be updated non-atomicially (scan_swap_map_slots),
> +	 * but that will never affect SWP_FS_OPS, so the data_race
> +	 * is safe.
> +	 */
> +	return !data_race(page_swap_info(page)->flags & SWP_FS_OPS);

Nit: the normal kernel comment style uses an empty

	/*

line to start the comment.

> @@ -1514,8 +1529,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  		if (!sc->may_unmap && page_mapped(page))
>  			goto keep_locked;
>  
> -		may_enter_fs = (sc->gfp_mask & __GFP_FS) ||
> -			(PageSwapCache(page) && (sc->gfp_mask & __GFP_IO));
> +		may_enter_fs = test_may_enter_fs(page, sc->gfp_mask);
>  
>  		/*
>  		 * The number of dirty pages determines if a node is marked
> @@ -1683,7 +1697,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  						goto activate_locked_split;
>  				}
>  
> -				may_enter_fs = true;
> +				may_enter_fs = test_may_enter_fs(page,
> +								 sc->gfp_mask);

Now that may_enter_fs is always reset using test_may_enter_fs, do we
even need the local variable?
