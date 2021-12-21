Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDB947BBEE
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 09:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhLUIeX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 03:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbhLUIeX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 03:34:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0AFC061574;
        Tue, 21 Dec 2021 00:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wXxR6SYYaV50yiBcuWHvs/ZYV9MStEaOVKcAB5B0IYc=; b=31JjlRoTGlsAzO9y1xYYeo8PCa
        1uxLTvHcSOFgoDaNWWXx8N2sKe0uZBytxNJ6Uw3Dwwe2/1Xz8MKdAp880AlfNIFbx5CeQqpir4LhJ
        ZV5wO8HGOGJcprM47XASQH5KEOV3Ba//lObUD7hV09nCp13zu0fnAfVlU/m1k32Sby1Hc8drX1/52
        T9wfUCBfpJV5X+zq6CrqmwE9f32wqlcrL5/hKn9L9/2LHYv3vvZOFnMJ2zN5gXe4HvS46MOugDyeB
        6lejy89eeotvzbKo1CHPxl8V6rAlR1hEbWE2IjlpX1cHFUoQJ9IdVDjAaiti5i0Po6mgVIbcvqDLJ
        y1NzKe0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzab9-005xBS-Li; Tue, 21 Dec 2021 08:34:15 +0000
Date:   Tue, 21 Dec 2021 00:34:15 -0800
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
Subject: Re: [PATCH 01/18] Structural cleanup for filesystem-based swap
Message-ID: <YcGRh+crvndawbT3@infradead.org>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
 <163969850251.20885.10819272484905153807.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850251.20885.10819272484905153807.stgit@noble.brown>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 10:48:22AM +1100, NeilBrown wrote:
> Linux primarily uses IO to block devices for swap, but can send the IO
> requests to a filesystem.  This has only ever worked for NFS, and that
> hasn't worked for a while due to a lack of testing.  This seems like a
> good time for some tidy-up before restoring swap-over-NFS functionality.

The changes look good to me, but I think this needs to be split into
separate, self-contained patches.

> 
> This patch:

Patch 1:

>  - updates the documentation (both copies!) for swap_activate which
>    is woefully out-of-date

Patch 2:

>  - drops the call to the filesystem for ->set_page_dirty().  These
>    pages do not belong to the filesystem, and it has no interest
>    in the dirty status.

Patch 3:


>  - move the responsibility for setting SWP_FS_OPS to ->swap_activate()
>    and also requires it to always call add_swap_extent().  This makes
>    it much easier to find filesystems that require SWP_FS_OPS.

Patch 4:

>  - introduces a new address_space operation "swap_rw" for swap IO.
>    The code currently used ->readpage for reads and ->direct_IO for
>    writes.  The former imposes a limit of one-page-at-a-time, the
>    later means that direct writes and swap writes are encouraged to
>    use the same path.  While similar, swap can often be simpler as
>    it can assume that no allocation is needed, and coherence with the
>    page cache is irrelevant.
