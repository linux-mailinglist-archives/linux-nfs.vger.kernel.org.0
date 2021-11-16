Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21151452CCE
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 09:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhKPIfB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 03:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhKPIfA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 03:35:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2068AC061570;
        Tue, 16 Nov 2021 00:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fiwmf+S4eS/bBuUt94ax6RoYl4bLvkHz0Y7NqOMkkK8=; b=ePoP4KeW6qvLcFkQYEz6yGWYtB
        XYrkDUawFpJc4ANK/rpBwY/OcdHnAMxlZa7YTc3cZyv+Cm38lHNP5h7BCHQ5MYgeWPIqbDGSiUysm
        3s7WK48Kc2fsdBXYcqlndJ/b8fHZ3foNJEjuDwVE/D+ghpy//wu2sVupecCayXRAZ2mk96FJm8NDg
        nvEz/dzeq14Jt2ELJXdpj/nzQ4BhjFSBE6F7nH8Dy1zeatPYQ5ITNQ8HfpQ3laoGY8vrNh9+bqG02
        dv3yU3IyeEmTvaMJbOGALwsd/7gDdTipt5n3oa58TFrcI4Q2R1Bb8fD4Z7F9cLY6OhQKclX/FEQ6B
        Z9pIJb9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmtsl-000jx1-Hf; Tue, 16 Nov 2021 08:31:59 +0000
Date:   Tue, 16 Nov 2021 00:31:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 12/13] MM: use AIO/DIO for reads from SWP_FS_OPS
 swap-space
Message-ID: <YZNsf5yvfb8+SiqB@infradead.org>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
 <163703064458.25805.6777856691611196478.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163703064458.25805.6777856691611196478.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 16, 2021 at 01:44:04PM +1100, NeilBrown wrote:
> When pages a read from SWP_FS_OPS swap-space, the reads are submitted as
> separate reads for each page.  This is generally less efficient than
> larger reads.
> 
> We can use the block-plugging infrastructure to delay submitting the
> read request until multiple contigious pages have been collected.  This
> requires using ->direct_IO to submit the read (as ->readpages isn't
> suitable for swap).

Abusing the block code here seems little ugly.  Also this won't
compile if CONFIG_BLOCK is not set, will it?

What is the problem with just batching up manually?

> +	/* nofs needs as ->direct_IO may take the same mutex it takes for write */

Overly long line.
