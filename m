Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439FD32C689
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbhCDA3K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:10 -0500
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:45666 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243249AbhCCLrK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 06:47:10 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id C0533C4A8B
        for <linux-nfs@vger.kernel.org>; Wed,  3 Mar 2021 09:18:28 +0000 (GMT)
Received: (qmail 8195 invoked from network); 3 Mar 2021 09:18:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Mar 2021 09:18:28 -0000
Date:   Wed, 3 Mar 2021 09:18:25 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Net <netdev@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-NFS <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] net: page_pool: refactor dma_map into own function
 page_pool_dma_map
Message-ID: <20210303091825.GO3697@techsingularity.net>
References: <20210301161200.18852-1-mgorman@techsingularity.net>
 <20210301161200.18852-5-mgorman@techsingularity.net>
 <YD6IosORkdRN9B2x@enceladus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YD6IosORkdRN9B2x@enceladus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 02, 2021 at 08:49:06PM +0200, Ilias Apalodimas wrote:
> Hi Mel,
> 
> Can you please CC me in future revisions. I almost missed that!
> 

Will do.

> On Mon, Mar 01, 2021 at 04:11:59PM +0000, Mel Gorman wrote:
> > From: Jesper Dangaard Brouer <brouer@redhat.com>
> > 
> > In preparation for next patch, move the dma mapping into its own
> > function, as this will make it easier to follow the changes.
> > 
> > V2: make page_pool_dma_map return boolean (Ilias)
> > 
> 
> [...]
> 
> > @@ -211,30 +234,14 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
> >  	if (!page)
> >  		return NULL;
> >  
> > -	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
> > -		goto skip_dma_map;
> > -
> > -	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
> > -	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
> > -	 * into page private data (i.e 32bit cpu with 64bit DMA caps)
> > -	 * This mapping is kept for lifetime of page, until leaving pool.
> > -	 */
> > -	dma = dma_map_page_attrs(pool->p.dev, page, 0,
> > -				 (PAGE_SIZE << pool->p.order),
> > -				 pool->p.dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> > -	if (dma_mapping_error(pool->p.dev, dma)) {
> > +	if (pp_flags & PP_FLAG_DMA_MAP &&
> 
> Nit pick but can we have if ((pp_flags & PP_FLAG_DMA_MAP) && ...
> 

Done.

> [...]
>
> > 
> 
> Otherwise 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org> 

Thanks. I'll wait for other review feedback before sending a V2.

-- 
Mel Gorman
SUSE Labs
