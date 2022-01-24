Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3ED8497ABD
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 09:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiAXIwu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jan 2022 03:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiAXIwu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jan 2022 03:52:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D70EC06173B;
        Mon, 24 Jan 2022 00:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WvCY12wHxPzG4OETwKwaljrTU1izZxdh7HCBu8mC+yI=; b=Q74tALB3CgO83ke5RywzEcvejB
        /pe9pswNd/EjHS9XIdzGTo366i9HaDsqng0Enj1wbklRO4o5tk6pfrSSj1fJyBa9W5NacnnEwPu5f
        5trKrx2aAEvPn7VImxWoagVeoxbZjd+Ctb5u+Pl75Nwq28p7AVC+RNG9sEBOpldoT0at0cowrz5Wn
        HrYFUP/97HF39o51YTzJ80pvGswYvxcgME8DeizzlGB2VTKajB1ushjDx10QF5ZbT4hUshVsI2zIA
        6uNwVam/Px1Dw2edWSbp5ccJRFcwXm/eDxnLIrKcx1Pr8bUpd2QEZl03COb/RmYxOiNLFbd7b3WaZ
        bsfgHqbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBv5i-002fpo-HJ; Mon, 24 Jan 2022 08:52:46 +0000
Date:   Mon, 24 Jan 2022 00:52:46 -0800
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
Subject: Re: [PATCH 09/23] MM: submit multipage reads for SWP_FS_OPS
 swap-space
Message-ID: <Ye5o3tPRudSBTVe2@infradead.org>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
 <164299611278.26253.14950274629759580371.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164299611278.26253.14950274629759580371.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:48:32PM +1100, NeilBrown wrote:
> swap_readpage() is given one page at a time, but maybe called repeatedly
> in succession.
> For block-device swapspace, the blk_plug functionality allows the
> multiple pages to be combined together at lower layers.
> That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
> only active when CONFIG_BLOCK=y.  Consequently all swap reads over NFS
> are single page reads.
> 
> With this patch we pass in a pointer-to-pointer when swap_readpage can
> store state between calls - much like the effect of blk_plug.  After
> calling swap_readpage() some number of times, the state will be passed
> to swap_read_unplug() which can submit the combined request.
> 
> Some caller currently call blk_finish_plug() *before* the final call to
> swap_readpage(), so the last page cannot be included.  This patch moves
> blk_finish_plug() to after the last call, and calls swap_read_unplug()
> there too.

Buildbot complais that we might need a forward declaration of
struct swap_iocb, but otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
