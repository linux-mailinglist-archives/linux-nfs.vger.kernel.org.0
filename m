Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7294E2B5F3C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Nov 2020 13:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgKQMex (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Nov 2020 07:34:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbgKQMew (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Nov 2020 07:34:52 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3FE2222A;
        Tue, 17 Nov 2020 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605616491;
        bh=iS9GV9Cm9kwqAKjF6x0u0cd0DWfISJIFCU0ryhWZvMQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=1puc4zw1IAvhJM5A6Fc59JLPcxzETfB6JZEciQP3/4bxPUuxNGk7n1Yd6uOsqV0ak
         8+sf6yP2L9bFiVQdmrIfBc4aQT9Kpn4SYPEtaYfCQUvFdIIVjnvYfc+giMrtLf98Cr
         rB5dZPaDaixR/JefIJHFbisQMZ4nc9IyowTw7578=
Message-ID: <a5704a8f7a6ebdfa60d4fa996a4d9ebaacc7daaf.camel@kernel.org>
Subject: Re: [PATCH 2/4] nfsd: pre/post attr is using wrong change attribute
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Date:   Tue, 17 Nov 2020 07:34:49 -0500
In-Reply-To: <1605583086-19869-2-git-send-email-bfields@redhat.com>
References: <20201117031601.GB10526@fieldses.org>
         <1605583086-19869-1-git-send-email-bfields@redhat.com>
         <1605583086-19869-2-git-send-email-bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-11-16 at 22:18 -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> fill_{pre/post}_attr are unconditionally using i_version even when the
> underlying filesystem doesn't have proper support for i_version.
> 
> Move the code that chooses which i_version to use to the common
> nfsd4_change_attribute().
> 
> The NFSEXP_V4ROOT case probably doesn't matter (the pseudoroot
> filesystem is usually read-only and unlikely to see operations with pre
> and post change attributes), but let's put it in the same place anyway
> for consistency.
> 
> Fixes: c654b8a9cba6 ("nfsd: support ext4 i_version")
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfsd/nfs4xdr.c | 11 +----------
>  fs/nfsd/nfsfh.c   | 11 +++++++----
>  fs/nfsd/nfsfh.h   | 23 -----------------------
>  fs/nfsd/vfs.c     | 32 ++++++++++++++++++++++++++++++++
>  fs/nfsd/vfs.h     |  3 +++
>  5 files changed, 43 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 833a2c64dfe8..6806207b6d18 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2295,16 +2295,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
>  static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
>  			     struct svc_export *exp)
>  {
> -	if (exp->ex_flags & NFSEXP_V4ROOT) {
> -		*p++ = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
> -		*p++ = 0;
> -	} else if (IS_I_VERSION(inode)) {
> -		p = xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode));
> -	} else {
> -		*p++ = cpu_to_be32(stat->ctime.tv_sec);
> -		*p++ = cpu_to_be32(stat->ctime.tv_nsec);
> -	}
> -	return p;
> +	return xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode, exp));
>  }
>  
> 
> 
> 
>  /*
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index b3b4e8809aa9..4fbe1413e767 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -719,6 +719,7 @@ void fill_pre_wcc(struct svc_fh *fhp)
>  {
>  	struct inode    *inode;
>  	struct kstat	stat;
> +	struct svc_export *exp = fhp->fh_export;
>  	__be32 err;
>  
> 
> 
> 
>  	if (fhp->fh_pre_saved)
> @@ -736,7 +737,7 @@ void fill_pre_wcc(struct svc_fh *fhp)
>  	fhp->fh_pre_mtime = stat.mtime;
>  	fhp->fh_pre_ctime = stat.ctime;
>  	fhp->fh_pre_size  = stat.size;
> -	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
> +	fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode, exp);
>  	fhp->fh_pre_saved = true;
>  }
>  
> 
> 
> 
> @@ -746,17 +747,19 @@ void fill_pre_wcc(struct svc_fh *fhp)
>  void fill_post_wcc(struct svc_fh *fhp)
>  {
>  	__be32 err;
> +	struct inode *inode = d_inode(fhp->fh_dentry);
> +	struct svc_export *exp = fhp->fh_export;
>  
> 
> 
> 
>  	if (fhp->fh_post_saved)
>  		printk("nfsd: inode locked twice during operation.\n");
>  
> 
> 
> 
>  	err = fh_getattr(fhp, &fhp->fh_post_attr);
> -	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
> -						     d_inode(fhp->fh_dentry));
> +	fhp->fh_post_change =
> +			nfsd4_change_attribute(&fhp->fh_post_attr, inode, exp);
>  	if (err) {
>  		fhp->fh_post_saved = false;
>  		/* Grab the ctime anyway - set_change_info might use it */
> -		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
> +		fhp->fh_post_attr.ctime = inode->i_ctime;
>  	} else
>  		fhp->fh_post_saved = true;
>  }
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 56cfbc361561..547aef9b3265 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -245,29 +245,6 @@ fh_clear_wcc(struct svc_fh *fhp)
>  	fhp->fh_pre_saved = false;
>  }
>  
> 
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
> -static inline u64 nfsd4_change_attribute(struct kstat *stat,
> -					 struct inode *inode)
> -{
> -	u64 chattr;
> -
> -	chattr =  stat->ctime.tv_sec;
> -	chattr <<= 30;
> -	chattr += stat->ctime.tv_nsec;
> -	chattr += inode_query_iversion(inode);
> -	return chattr;
> -}
> -
>  extern void fill_pre_wcc(struct svc_fh *fhp);
>  extern void fill_post_wcc(struct svc_fh *fhp);
>  #else
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 1ecaceebee13..2c71b02dd1fe 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2390,3 +2390,35 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
>  
> 
> 
> 
>  	return err? nfserrno(err) : 0;
>  }
> +
> +/*
> + * We could use i_version alone as the change attribute.  However,
> + * i_version can go backwards after a reboot.  On its own that doesn't
> + * necessarily cause a problem, but if i_version goes backwards and then
> + * is incremented again it could reuse a value that was previously used
> + * before boot, and a client who queried the two values might
> + * incorrectly assume nothing changed.
> + *
> + * By using both ctime and the i_version counter we guarantee that as
> + * long as time doesn't go backwards we never reuse an old value.
> + */
> +u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode,
> +					 struct svc_export *exp)
> +{
> +	u64 chattr;
> +
> +	if (exp->ex_flags & NFSEXP_V4ROOT) {
> +		chattr = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
> +		chattr <<= 32;
> +	} else if (IS_I_VERSION(inode)) {
> +		chattr = stat->ctime.tv_sec;
> +		chattr <<= 30;
> +		chattr += stat->ctime.tv_nsec;
> +		chattr += inode_query_iversion(inode);
> +	} else {
> +		chattr = stat->ctime.tv_sec;
> +		chattr <<= 32;
> +		chattr += stat->ctime.tv_nsec;
> +	}
> +	return chattr;
> +}


I don't think I described what I was thinking well. Let me try again...

There should be no need to change the code in iversion.h -- I think we
can do this in a way that's confined to just nfsd/export code.

What I would suggest is to have nfsd4_change_attribute call the
fetch_iversion op if it exists, instead of checking IS_I_VERSION and
doing the stuff in that block. If fetch_iversion is NULL, then just use
the ctime.

Then, you just need to make sure that the filesystems' export_ops have
an appropriate fetch_iversion vector. xfs, ext4 and btrfs can just call
inode_query_iversion, and NFS and Ceph can call inode_peek_iversion_raw.
The rest of the filesystems can leave fetch_iversion as NULL (since we
don't want to use it on them).

> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index a2442ebe5acf..26ed15256340 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -132,6 +132,9 @@ __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
>  __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
>  				struct dentry *, int);
>  
> 
> 
> 
> +u64		nfsd4_change_attribute(struct kstat *stat, struct inode *inode,
> +				struct svc_export *exp);
> +
>  static inline int fh_want_write(struct svc_fh *fh)
>  {
>  	int ret;

-- 
Jeff Layton <jlayton@kernel.org>

