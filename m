Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6385A2BBF1D
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 14:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgKUNAe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 08:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbgKUNAd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 21 Nov 2020 08:00:33 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5771217A0;
        Sat, 21 Nov 2020 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605963632;
        bh=bWO4512rrwQksK0Rvo197S83Z8f0AoILWgXDmivlrV4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rcb4uvhe6Kx3DPlF3dU2gkn8SeGGCSRmVm6JxtlNpe/nDVZun/LjR3NtE8lZ5PeKo
         bKHKBdGyIJ22edC3AZVzlukekMT9SPxxbh6IidiIqr3IgQiyH5v9eeIp43BINEiFdZ
         G27VXIvr2CZWLMz7leO7LRFJvrw7F0Cr1ysObE4U=
Message-ID: <8462cb90445a8553d0667e6ca59fbb42835ad9a9.camel@kernel.org>
Subject: Re: [PATCH 6/8] nfsd: move change attribute generation to filesystem
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Date:   Sat, 21 Nov 2020 08:00:30 -0500
In-Reply-To: <1605911960-12516-6-git-send-email-bfields@redhat.com>
References: <20201120223831.GB7705@fieldses.org>
         <1605911960-12516-1-git-send-email-bfields@redhat.com>
         <1605911960-12516-6-git-send-email-bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2020-11-20 at 17:39 -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> After this, only filesystems lacking change attribute support will leave
> the fetch_iversion export op NULL.
> 
> This seems cleaner to me, and will allow some minor optimizations in the
> nfsd code.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/btrfs/export.c        |  2 ++
>  fs/ext4/super.c          |  9 +++++++++
>  fs/nfsd/nfs4xdr.c        |  2 +-
>  fs/nfsd/nfsfh.h          | 25 +++----------------------
>  fs/nfsd/xdr4.h           |  4 +++-
>  fs/xfs/xfs_export.c      |  2 ++
>  include/linux/iversion.h | 26 ++++++++++++++++++++++++++
>  7 files changed, 46 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
> index 1a8d419d9e1f..ece32440999a 100644
> --- a/fs/btrfs/export.c
> +++ b/fs/btrfs/export.c
> @@ -7,6 +7,7 @@
>  #include "btrfs_inode.h"
>  #include "print-tree.h"
>  #include "export.h"
> +#include <linux/iversion.h>
>  
> 
>  #define BTRFS_FID_SIZE_NON_CONNECTABLE (offsetof(struct btrfs_fid, \
>  						 parent_objectid) / 4)
> @@ -279,4 +280,5 @@ const struct export_operations btrfs_export_ops = {
>  	.fh_to_parent	= btrfs_fh_to_parent,
>  	.get_parent	= btrfs_get_parent,
>  	.get_name	= btrfs_get_name,
> +	.fetch_iversion	= generic_fetch_iversion,
>  };
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ef4734b40e2a..a4f48273d435 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1685,11 +1685,20 @@ static const struct super_operations ext4_sops = {
>  	.bdev_try_to_free_page = bdev_try_to_free_page,
>  };
>  
> 
> +static u64 ext4_fetch_iversion(struct inode *inode)
> +{
> +	if (IS_I_VERSION(inode))
> +		return generic_fetch_iversion(inode);
> +	else
> +		return time_to_chattr(&inode->i_ctime);
> +}
> +
>  static const struct export_operations ext4_export_ops = {
>  	.fh_to_dentry = ext4_fh_to_dentry,
>  	.fh_to_parent = ext4_fh_to_parent,
>  	.get_parent = ext4_get_parent,
>  	.commit_metadata = ext4_nfs_commit_metadata,
> +	.fetch_iversion = ext4_fetch_iversion,
>  };
>  
> 
>  enum {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 18c912930947..182190684792 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3187,7 +3187,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  		p = xdr_reserve_space(xdr, 4);
>  		if (!p)
>  			goto out_resource;
> -		if (IS_I_VERSION(d_inode(dentry)))
> +		if (IS_I_VERSION(d_inode(dentry))
>  			*p++ = cpu_to_be32(NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR);
>  		else
>  			*p++ = cpu_to_be32(NFS4_CHANGE_TYPE_IS_TIME_METADATA);
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 2656a3464c6c..ac3e309d7339 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -46,8 +46,8 @@ typedef struct svc_fh {
>  	struct timespec64	fh_pre_mtime;	/* mtime before oper */
>  	struct timespec64	fh_pre_ctime;	/* ctime before oper */
>  	/*
> -	 * pre-op nfsv4 change attr: note must check IS_I_VERSION(inode)
> -	 *  to find out if it is valid.
> +	 * pre-op nfsv4 change attr: note must check for fetch_iversion
> +	 * op to find out if it is valid.
>  	 */
>  	u64			fh_pre_change;
>  
> 
> @@ -246,31 +246,12 @@ fh_clear_wcc(struct svc_fh *fhp)
>  	fhp->fh_pre_saved = false;
>  }
>  
> 
> -/*
> - * We could use i_version alone as the change attribute.  However,
> - * i_version can go backwards after a reboot.  On its own that doesn't
> - * necessarily cause a problem, but if i_version goes backwards and then
> - * is incremented again it could reuse a value that was previously used
> - * before boot, and a client who queried the two values might
> - * incorrectly assume nothing changed.
> - *
> - * By using both ctime and the i_version counter we guarantee that as
> - * long as time doesn't go backwards we never reuse an old value.
> - */
>  static inline u64 nfsd4_change_attribute(struct kstat *stat,
>  					 struct inode *inode)
>  {
>  	if (inode->i_sb->s_export_op->fetch_iversion)
>  		return inode->i_sb->s_export_op->fetch_iversion(inode);
> -	else if (IS_I_VERSION(inode)) {
> -		u64 chattr;
> -
> -		chattr =  stat->ctime.tv_sec;
> -		chattr <<= 30;
> -		chattr += stat->ctime.tv_nsec;
> -		chattr += inode_query_iversion(inode);
> -		return chattr;
> -	} else
> +	else
>  		return time_to_chattr(&stat->ctime);
>  }
>  
> 
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 9c2d942d055d..f0c8fbe704a2 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -761,10 +761,12 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op);
>  static inline void
>  set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
>  {
> +	struct inode *inode = d_inode(fhp->fh_dentry);
> +
>  	BUG_ON(!fhp->fh_pre_saved);
>  	cinfo->atomic = (u32)fhp->fh_post_saved;
>  
> 
> -	if (IS_I_VERSION(d_inode(fhp->fh_dentry))) {
> +	if (inode->i_sb->s_export_op->fetch_iversion) {
>  		cinfo->before_change = fhp->fh_pre_change;
>  		cinfo->after_change = fhp->fh_post_change;
>  	} else {
> diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
> index 465fd9e048d4..b950fac3d7df 100644
> --- a/fs/xfs/xfs_export.c
> +++ b/fs/xfs/xfs_export.c
> @@ -16,6 +16,7 @@
>  #include "xfs_inode_item.h"
>  #include "xfs_icache.h"
>  #include "xfs_pnfs.h"
> +#include <linux/iversion.h>
>  
> 
>  /*
>   * Note that we only accept fileids which are long enough rather than allow
> @@ -234,4 +235,5 @@ const struct export_operations xfs_export_operations = {
>  	.map_blocks		= xfs_fs_map_blocks,
>  	.commit_blocks		= xfs_fs_commit_blocks,
>  #endif
> +	.fetch_iversion		= generic_fetch_iversion,
>  };
> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index 3bfebde5a1a6..ded74523c8a6 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -328,6 +328,32 @@ inode_query_iversion(struct inode *inode)
>  	return cur >> I_VERSION_QUERIED_SHIFT;
>  }
>  
> 
> +/*
> + * We could use i_version alone as the NFSv4 change attribute.  However,
> + * i_version can go backwards after a reboot.  On its own that doesn't
> + * necessarily cause a problem, but if i_version goes backwards and then
> + * is incremented again it could reuse a value that was previously used
> + * before boot, and a client who queried the two values might
> + * incorrectly assume nothing changed.
> + *
> + * By using both ctime and the i_version counter we guarantee that as
> + * long as time doesn't go backwards we never reuse an old value.
> + *
> + * A filesystem that has an on-disk boot counter or similar might prefer
> + * to use that to avoid the risk of the change attribute going backwards
> + * if system time is set backwards.
> + */
> +static inline u64 generic_fetch_iversion(struct inode *inode)
> +{
> +	u64 chattr;
> +
> +	chattr =  inode->i_ctime.tv_sec;
> +	chattr <<= 30;
> +	chattr += inode->i_ctime.tv_nsec;
> +	chattr += inode_query_iversion(inode);
> +	return chattr;
> +}
> +
>  /*
>   * For filesystems without any sort of change attribute, the best we can
>   * do is fake one up from the ctime:

One more nit: 

We probably don't want anyone using this on filesystems that don't set
SB_I_VERSION. It might be a good idea to add something like:

    WARN_ON_ONCE(!IS_I_VERSION(inode));

To this function, to catch anyone trying to do it.
-- 
Jeff Layton <jlayton@kernel.org>

