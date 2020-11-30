Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FF92C91DE
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 00:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgK3XAd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 18:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgK3XAc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 18:00:32 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEB5C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:59:52 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4D02A6F4A; Mon, 30 Nov 2020 17:59:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4D02A6F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606777192;
        bh=evfue1jjt99o+2WoIwGghVfU4aZqjvonCix4bay7t+s=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ZYa9lVODpcB0O7bjZ4o7GtjGxV2jXMgY83wRLcdYfpb7X2iyFktsYuy28c14s7anV
         s4FhaCNeRcrmD+5OMZNIbo37temJIZqBRYQ8h5RBdtqX3GvNFHlBkCwFIFlX87vPM6
         Jy6F1CrGDJpxN0n9fRqE4EVEt1nUR+bnJmrsoY58=
Date:   Mon, 30 Nov 2020 17:59:52 -0500
To:     trondmy@kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/6] nfsd: allow filesystems to opt out of subtree
 checking
Message-ID: <20201130225952.GB22446@fieldses.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130212455.254469-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130212455.254469-3-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Makes sense to me, thanks.--b.

On Mon, Nov 30, 2020 at 04:24:51PM -0500, trondmy@kernel.org wrote:
> From: Jeff Layton <jeff.layton@primarydata.com>
> 
> When we start allowing NFS to be reexported, then we have some problems
> when it comes to subtree checking. In principle, we could allow it, but
> it would mean encoding parent info in the filehandles and there may not
> be enough space for that in a NFSv3 filehandle.
> 
> To enforce this at export upcall time, we add a new export_ops flag
> that declares the filesystem ineligible for subtree checking.
> 
> Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  Documentation/filesystems/nfs/exporting.rst | 14 +++++++++++++-
>  fs/nfs/export.c                             |  2 +-
>  fs/nfsd/export.c                            |  6 ++++++
>  include/linux/exportfs.h                    |  1 +
>  4 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
> index a3e3805833d1..960be64446cb 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -176,7 +176,7 @@ contains a "flags" field that allows the filesystem to communicate to nfsd
>  that it may want to do things differently when dealing with it. The
>  following flags are defined:
>  
> -  EXPORT_OP_NOWCC
> +  EXPORT_OP_NOWCC - disable NFSv3 WCC attributes on this filesystem
>      RFC 1813 recommends that servers always send weak cache consistency
>      (WCC) data to the client after each operation. The server should
>      atomically collect attributes about the inode, do an operation on it,
> @@ -190,3 +190,15 @@ following flags are defined:
>      this on filesystems that have an expensive ->getattr inode operation,
>      or when atomicity between pre and post operation attribute collection
>      is impossible to guarantee.
> +
> +  EXPORT_OP_NOSUBTREECHK - disallow subtree checking on this fs
> +    Many NFS operations deal with filehandles, which the server must then
> +    vet to ensure that they live inside of an exported tree. When the
> +    export consists of an entire filesystem, this is trivial. nfsd can just
> +    ensure that the filehandle live on the filesystem. When only part of a
> +    filesystem is exported however, then nfsd must walk the ancestors of the
> +    inode to ensure that it's within an exported subtree. This is an
> +    expensive operation and not all filesystems can support it properly.
> +    This flag exempts the filesystem from subtree checking and causes
> +    exportfs to get back an error if it tries to enable subtree checking
> +    on it.
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 8f4c528865c5..b9ba306bf912 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -171,5 +171,5 @@ const struct export_operations nfs_export_ops = {
>  	.encode_fh = nfs_encode_fh,
>  	.fh_to_dentry = nfs_fh_to_dentry,
>  	.get_parent = nfs_get_parent,
> -	.flags = EXPORT_OP_NOWCC,
> +	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK,
>  };
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 21e404e7cb68..81e7bb12aca6 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -408,6 +408,12 @@ static int check_export(struct inode *inode, int *flags, unsigned char *uuid)
>  		return -EINVAL;
>  	}
>  
> +	if (inode->i_sb->s_export_op->flags & EXPORT_OP_NOSUBTREECHK &&
> +	    !(*flags & NFSEXP_NOSUBTREECHECK)) {
> +		dprintk("%s: %s does not support subtree checking!\n",
> +			__func__, inode->i_sb->s_type->name);
> +		return -EINVAL;
> +	}
>  	return 0;
>  
>  }
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index e7de0103a32e..2fcbab0f6b61 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -214,6 +214,7 @@ struct export_operations {
>  	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
>  			     int nr_iomaps, struct iattr *iattr);
>  #define	EXPORT_OP_NOWCC		(0x1)	/* Don't collect wcc data for NFSv3 replies */
> +#define	EXPORT_OP_NOSUBTREECHK	(0x2)	/* Subtree checking is not supported! */
>  	unsigned long	flags;
>  };
>  
> -- 
> 2.28.0
