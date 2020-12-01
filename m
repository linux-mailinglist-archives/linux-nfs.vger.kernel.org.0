Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF932CAC75
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgLATgD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 14:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgLATgC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Dec 2020 14:36:02 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C79BC0613CF
        for <linux-nfs@vger.kernel.org>; Tue,  1 Dec 2020 11:35:22 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 6ACA66F4C; Tue,  1 Dec 2020 14:35:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 6ACA66F4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606851321;
        bh=HdfEiqoqIWrkD6sTbxXSghI4Vj54xV5bGEjidZoUduo=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=WZZ3Nj11R0tOle0JCoZczjl6/GU33Bysn3qtelDZOxqtzVM4/LtUCAe+VRLYcdPHL
         wV194fufijGNIrkYZYGmF9uoK+x0BWkaSGXrQn9dhF4vRGaxA0v29v5k9gftxLW5a5
         54/Mar1F3aalNtR4SHUgGdgsPk2+VQGYE6b/pHhc=
Date:   Tue, 1 Dec 2020 14:35:21 -0500
To:     trondmy@kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: Record NFSv4 pre/post-op attributes as
 non-atomic
Message-ID: <20201201193521.GA21355@fieldses.org>
References: <20201201041427.756749-1-trondmy@kernel.org>
 <20201201041427.756749-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201041427.756749-2-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 30, 2020 at 11:14:27PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> For the case of NFSv4, specify to the client that the the pre/post-op
> attributes were not recorded atomically with the main operation.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/export.c          | 3 ++-
>  fs/nfsd/nfsfh.c          | 4 ++++
>  fs/nfsd/nfsfh.h          | 5 +++++
>  fs/nfsd/xdr4.h           | 2 +-
>  include/linux/exportfs.h | 3 +++
>  5 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index 48b879cfe6e3..7412bb164fa7 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -172,5 +172,6 @@ const struct export_operations nfs_export_ops = {
>  	.fh_to_dentry = nfs_fh_to_dentry,
>  	.get_parent = nfs_get_parent,
>  	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
> -		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS,
> +		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
> +		EXPORT_OP_NOATOMIC_ATTR,

So I still don't understand why we need a new flag for this.

Before you said it was because a filesystem might want to turn off the
v4 atomic flag but still return v3 post-wcc attributes.

But it seems that a) we have no example of a filesystem that wants to do
that, b) it would violate the protocol anyway.

Is that right?

If so, then let's just stick to one flag for both.

--b.

>  };
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index e80a7525561d..66f2ef67792a 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -301,6 +301,10 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
>  	fhp->fh_export = exp;
>  
>  	switch (rqstp->rq_vers) {
> +	case 4:
> +		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
> +			fhp->fh_no_atomic_attr = true;
> +		break;
>  	case 3:
>  		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
>  			fhp->fh_no_wcc = true;
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 347d10aa6265..cb20c2cd3469 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -36,6 +36,11 @@ typedef struct svc_fh {
>  	bool			fh_locked;	/* inode locked by us */
>  	bool			fh_want_write;	/* remount protection taken */
>  	bool			fh_no_wcc;	/* no wcc data needed */
> +	bool			fh_no_atomic_attr;
> +						/*
> +						 * wcc data is not atomic with
> +						 * operation
> +						 */
>  	int			fh_flags;	/* FH flags */
>  #ifdef CONFIG_NFSD_V3
>  	bool			fh_post_saved;	/* post-op attrs saved */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index b4556e86e97c..a60ff5ce1a37 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -748,7 +748,7 @@ static inline void
>  set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
>  {
>  	BUG_ON(!fhp->fh_pre_saved);
> -	cinfo->atomic = (u32)fhp->fh_post_saved;
> +	cinfo->atomic = (u32)(fhp->fh_post_saved && !fhp->fh_no_atomic_attr);
>  
>  	cinfo->before_change = fhp->fh_pre_change;
>  	cinfo->after_change = fhp->fh_post_change;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index d93e8a6737bb..9f4d4bcbf251 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -217,6 +217,9 @@ struct export_operations {
>  #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
>  #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
>  #define EXPORT_OP_REMOTE_FS		(0x8) /* Filesystem is remote */
> +#define EXPORT_OP_NOATOMIC_ATTR		(0x10) /* Filesystem cannot supply
> +						  atomic attribute updates
> +						*/
>  	unsigned long	flags;
>  };
>  
> -- 
> 2.28.0
