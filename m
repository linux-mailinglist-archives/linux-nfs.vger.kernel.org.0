Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FDE6A0A68
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 14:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjBWNXD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 08:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjBWNXC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 08:23:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFD51CF7E
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 05:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9f0p+svq0NN2yn3y6m7ZCtSUTEBvll1v/PBnDcyty54=; b=mZS8hr06Wy0SxXYoAsUwbad7bs
        L6ffOsTuxnao7+6vXw3EVu3meWLrtcq03TXXfOAPN3IjeA+aanQubGciJzsFLiMjrdJlbWrZ7Lfsf
        g1z9WJaYvv6ZiJb4+5AT4zSNsnP3BxmItCkRNzbrSYM+LDthEm/GhCMvy5Zoiyv0Jh7OWPXewIdkZ
        mhFGlY7OesXK9kcRHWYOmh/bLChty1LxjyUQS52tJBZT9nqmhgoN8hZCP07HvKsc5/QI2GLDwkO0i
        dILc7/sd4vRpgqANt7N9dYOTlCYeuQHKW5bJBWvLhJo/DvglFpcsSivTcne/tisLiMY7/ZPvIbHNa
        hUo8IV+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVBYk-00EONT-QO; Thu, 23 Feb 2023 13:22:54 +0000
Date:   Thu, 23 Feb 2023 13:22:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     trondmy@kernel.org
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v2 18/18] NFS: Remove unnecessary check in
 nfs_read_folio()
Message-ID: <Y/dorq8Elh4Mxg2g@casper.infradead.org>
References: <20230119213351.443388-10-trondmy@kernel.org>
 <20230119213351.443388-11-trondmy@kernel.org>
 <20230119213351.443388-12-trondmy@kernel.org>
 <20230119213351.443388-13-trondmy@kernel.org>
 <20230119213351.443388-14-trondmy@kernel.org>
 <20230119213351.443388-15-trondmy@kernel.org>
 <20230119213351.443388-16-trondmy@kernel.org>
 <20230119213351.443388-17-trondmy@kernel.org>
 <20230119213351.443388-18-trondmy@kernel.org>
 <20230119213351.443388-19-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119213351.443388-19-trondmy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 19, 2023 at 04:33:51PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> All the callers are expected to supply a valid struct file argument, so
> there is no need for the NULL check.

Ummm.  Not sure that's true.  Look at this path:

mapping_read_folio_gfp(mapping, index, gfp)
do_read_cache_folio(mapping, index, NULL, NULL, gfp)
filemap_read_folio(NULL, mapping->a_ops->read_folio, folio)

It could well be that nobody does this to an NFS file!  The places where
I see this called tend to be filesystems doing it to block devices,
or filesystems doing it to their own files (eg reading a journal file
or quota file)

But I'm suspicious of static match tools claiming it can't ever happen,
and I'd like more details please.  I can't find the original report.
Also, it would have been nice to be cc'd on the folio conversion patches.

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/read.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index bf4154f9b48c..c380cff4108e 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -355,13 +355,7 @@ int nfs_read_folio(struct file *file, struct folio *folio)
>  	if (NFS_STALE(inode))
>  		goto out_unlock;
>  
> -	if (file == NULL) {
> -		ret = -EBADF;
> -		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
> -		if (desc.ctx == NULL)
> -			goto out_unlock;
> -	} else
> -		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
> +	desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
>  
>  	xchg(&desc.ctx->error, 0);
>  	nfs_pageio_init_read(&desc.pgio, inode, false,
> -- 
> 2.39.0
> 
