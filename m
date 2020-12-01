Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FE62CA884
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Dec 2020 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLAQoO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Dec 2020 11:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLAQoN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Dec 2020 11:44:13 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F7820758;
        Tue,  1 Dec 2020 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841012;
        bh=Km+WM9tA4MWrdRukSNY/Rw0La/ntq5vA+VkrebH6SBM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F/KEM9POqeRZ9rdRPFnpfkjrZCdRY9z0LNefPBLXBT/D2DUMYK3uIQwOsRbkWwjKB
         Txy0SPYIh5ZktFPtE1gr5xurIDV3SP1xbuWKSLdwEVKVw7X3M7E5YJytwXWmo1/YBi
         BuD8g5P9wzeMhst4/vW+16mIg41Vksgen3lTe26c=
Message-ID: <01bad6aa8aa05bb9bafd010575866125f89c5f08.camel@kernel.org>
Subject: Re: [PATCH 1/5] nfsd: only call inode_query_iversion in the
 I_VERSION case
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Date:   Tue, 01 Dec 2020 11:43:31 -0500
In-Reply-To: <1606776378-22381-1-git-send-email-bfields@fieldses.org>
References: <1606776378-22381-1-git-send-email-bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2020-11-30 at 17:46 -0500, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> inode_query_iversion() can modify i_version.  Depending on the exported
> filesystem, that may not be safe.  For example, if you're re-exporting
> NFS, NFS stores the server's change attribute in i_version and does not
> expect it to be modified locally.  This has been observed causing
> unnecessary cache invalidations.
> 
> The way a filesystem indicates that it's OK to call
> inode_query_iverson() is by setting SB_I_VERSION.
> 
> So, move the I_VERSION check out of encode_change(), where it's used
> only in FATTR responses, to nfsd4_changeattr(), which is also called for
> pre- and post- operation attributes.
> 
> (Note we could also pull the NFSEXP_V4ROOT case into
> nfsd4_change_attribute as well.  That would actually be a no-op, since
> pre/post attrs are only used for metadata-modifying operations, and
> V4ROOT exports are read-only.  But we might make the change in the
> future just for simplicity.)
> 
> Reported-by: Daire Byrne <daire@dneg.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfsd/nfs3xdr.c |  5 ++---
>  fs/nfsd/nfs4xdr.c |  6 +-----
>  fs/nfsd/nfsfh.h   | 14 ++++++++++----
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 2277f83da250..dfbf390ff40c 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -291,14 +291,13 @@ void fill_post_wcc(struct svc_fh *fhp)
>  		printk("nfsd: inode locked twice during operation.\n");
>  
> 
> 
> 
>  	err = fh_getattr(fhp, &fhp->fh_post_attr);
> -	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
> -						     d_inode(fhp->fh_dentry));
>  	if (err) {
>  		fhp->fh_post_saved = false;
> -		/* Grab the ctime anyway - set_change_info might use it */
>  		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
>  	} else
>  		fhp->fh_post_saved = true;
> +	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
> +						     d_inode(fhp->fh_dentry));
>  }
>  
> 
> 
> 
>  /*
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 833a2c64dfe8..56fd5f6d5c44 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2298,12 +2298,8 @@ static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
>  	if (exp->ex_flags & NFSEXP_V4ROOT) {
>  		*p++ = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
>  		*p++ = 0;
> -	} else if (IS_I_VERSION(inode)) {
> +	} else
>  		p = xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode));
> -	} else {
> -		*p++ = cpu_to_be32(stat->ctime.tv_sec);
> -		*p++ = cpu_to_be32(stat->ctime.tv_nsec);
> -	}
>  	return p;
>  }
>  
> 
> 
> 
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 56cfbc361561..39d764b129fa 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -261,10 +261,16 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
>  {
>  	u64 chattr;
>  
> 
> 
> 
> -	chattr =  stat->ctime.tv_sec;
> -	chattr <<= 30;
> -	chattr += stat->ctime.tv_nsec;
> -	chattr += inode_query_iversion(inode);
> +	if (IS_I_VERSION(inode)) {
> +		chattr =  stat->ctime.tv_sec;
> +		chattr <<= 30;
> +		chattr += stat->ctime.tv_nsec;
> +		chattr += inode_query_iversion(inode);
> +	} else {
> +		chattr = stat->ctime.tv_sec;
> +		chattr <<= 32;

Might be nice to annotate the shifts above and maybe make them named
constants. I'm not sure where those values come from, tbh.

> +		chattr += stat->ctime.tv_nsec;
> +	}
>  	return chattr;
>  }
>  
> 
> 
> 


Other than some very minor nits, the set itself looks great.

Are you planning to follow up with the series to add the fetch_iversion
op, or have you decided not to do that for now?

Reviewed-by: Jeff Layton <jlayton@kernel.org>

