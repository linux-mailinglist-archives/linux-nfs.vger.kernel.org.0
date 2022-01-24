Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75F497961
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 08:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiAXH1U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 02:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241713AbiAXH1T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 02:27:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A5CC06173B;
        Sun, 23 Jan 2022 23:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j+tH6nHEGujTdaJ2n2+WPQs1USsQeUND+saT792MFaY=; b=H7V5NazfCuRpqJD2ZyOZ7qzuHy
        phksDlX5d097UBUrD3C1Pc6dIaRL3blyFjQPUDWBN+o/HC71o4JBUKo7iAAMn/o8aEi+348M3Nejt
        E5wozVTblU1Pe3bYYemVEiPRnWcySUIZ0lV0P2v2Q5v8GBPEVldsLBIHplO15aFkVZW3A9HigYQdN
        4N8Ay0SrPRCyI2LM78tG36kXrIo1MH7gXgQ5PQwNDMdhx8TKW+Z3ewo7bZ0v4e6bUr08YHlCvZJyH
        H+hTD30ZWqXFATKQzOw4W6DLQKlOzAUweV6IfVc7fGfuauV3SpslRqZ+WBCB7ijsYUg95RBlZEH61
        vq1P7G8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBtkq-002U44-LS; Mon, 24 Jan 2022 07:27:08 +0000
Date:   Sun, 23 Jan 2022 23:27:08 -0800
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
Subject: Re: [PATCH 02/23] MM: extend block-plugging to cover all swap reads
 with read-ahead
Message-ID: <Ye5UzEzvN8WWMNBn@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611274.26253.13900771841681128440.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611274.26253.13900771841681128440.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> Code that does swap read-ahead uses blk_start_plug() and
> blk_finish_plug() to allow lower levels to combine multiple read-ahead
> pages into a single request, but calls blk_finish_plug() *before*
> submitting the original (non-ahead) read request.
> This missed an opportunity to combine read requests.
> 
> This patch moves the blk_finish_plug to *after* all the reads.
> This will likely combine the primary read with some of the "ahead"
> reads, and that may slightly increase the latency of that read, but it
> should more than make up for this by making more efficient use of the
> storage path.
> 
> The patch mostly makes the code look more consistent.  Performance
> change is unlikely to be noticeable.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> Fixes-no-auto-backport: 3fb5c298b04e ("swap: allow swap readahead to be merged")

Is this really a thing?
