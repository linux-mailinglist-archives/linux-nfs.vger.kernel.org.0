Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E982C8E5D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 20:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgK3Trg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 14:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgK3Trg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 14:47:36 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04237C0613D2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 11:46:56 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5C0336F4A; Mon, 30 Nov 2020 14:46:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5C0336F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1606765615;
        bh=TGlVQ/ct8vGupystHx32X+YyTSvufqqKSPrKF5Y2qO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kc5jp8hbritEmhoZXatKV0j7KoJz2/CF7eas0pb62fJDU4NuhqBMuYTnNaKln/grm
         CJgHkuvGF49mm5Z3egTknzb4kuwi3zQsOLVSdll1ukDzcRVQqCfjt1BbIDTozzWdXd
         I75gKQtr7wmEgT8liomCeuCHzN/bgfSlGTeOnkRE=
Date:   Mon, 30 Nov 2020 14:46:55 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH 1/5] nfsd: only call inode_query_iversion in the
 I_VERSION case
Message-ID: <20201130194655.GA17322@fieldses.org>
References: <1606765137-17257-1-git-send-email-bfields@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606765137-17257-1-git-send-email-bfields@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch fixes the bug Daire saw.  The rest is a replacement for the
series I sent before, except that I haven't included the last few
patches, which will need review from other filesystem people.

--b.

On Mon, Nov 30, 2020 at 02:38:53PM -0500, J. Bruce Fields wrote:
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
>  fs/nfsd/nfs3xdr.c |  5 ++---
>  fs/nfsd/nfs4xdr.c |  6 +-----
>  fs/nfsd/nfsfh.h   | 14 ++++++++++----
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 2277f83da250..dfbf390ff40c 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -291,14 +291,13 @@ void fill_post_wcc(struct svc_fh *fhp)
>  		printk("nfsd: inode locked twice during operation.\n");
>  
>  	err = fh_getattr(fhp, &fhp->fh_post_attr);
> -	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
> -						     d_inode(fhp->fh_dentry));
>  	if (err) {
>  		fhp->fh_post_saved = false;
> -		/* Grab the ctime anyway - set_change_info might use it */
>  		fhp->fh_post_attr.ctime = d_inode(fhp->fh_dentry)->i_ctime;
>  	} else
>  		fhp->fh_post_saved = true;
> +	fhp->fh_post_change = nfsd4_change_attribute(&fhp->fh_post_attr,
> +						     d_inode(fhp->fh_dentry));
>  }
>  
>  /*
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 833a2c64dfe8..56fd5f6d5c44 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2298,12 +2298,8 @@ static __be32 *encode_change(__be32 *p, struct kstat *stat, struct inode *inode,
>  	if (exp->ex_flags & NFSEXP_V4ROOT) {
>  		*p++ = cpu_to_be32(convert_to_wallclock(exp->cd->flush_time));
>  		*p++ = 0;
> -	} else if (IS_I_VERSION(inode)) {
> +	} else
>  		p = xdr_encode_hyper(p, nfsd4_change_attribute(stat, inode));
> -	} else {
> -		*p++ = cpu_to_be32(stat->ctime.tv_sec);
> -		*p++ = cpu_to_be32(stat->ctime.tv_nsec);
> -	}
>  	return p;
>  }
>  
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 56cfbc361561..3faf5974fa4e 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -261,10 +261,16 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
>  {
>  	u64 chattr;
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
> +		chattr = cpu_to_be32(stat->ctime.tv_sec);
> +		chattr <<= 32;
> +		chattr += cpu_to_be32(stat->ctime.tv_nsec);
> +	}
>  	return chattr;
>  }
>  
> -- 
> 2.28.0
