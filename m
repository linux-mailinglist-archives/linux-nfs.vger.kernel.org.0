Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE8E10DF26
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2019 21:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfK3UAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 Nov 2019 15:00:03 -0500
Received: from fieldses.org ([173.255.197.46]:44852 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfK3UAC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 30 Nov 2019 15:00:02 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 73E1C89A; Sat, 30 Nov 2019 15:00:02 -0500 (EST)
Date:   Sat, 30 Nov 2019 15:00:02 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: check for EBUSY from vfs_rmdir/vfs_unink.
Message-ID: <20191130200002.GB19460@fieldses.org>
References: <87imn4iu8k.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imn4iu8k.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 28, 2019 at 01:56:43PM +1100, NeilBrown wrote:
> 
> vfs_rmdir and vfs_unlink can return -EBUSY if the
> target is a mountpoint.  This currently gets passed to
> nfserrno() by nfsd_unlink(), and that results in a WARNing,
> which is not user-friendly.
> 
> Possibly the best NFSv4 error is NFS4ERR_FILE_OPEN, because
> there is a sense in which the object is currently in use
> by some other task.  The Linux NFSv4 client will map this
> back to EBUSY, which is an added benefit.
> 
> For NFSv3, the best we can do is probably NFS3ERR_ACCES, which isn't
> true, but is not less true than the other options.

Makes sense to me, thanks.--b.

> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsd.h |  3 ++-
>  fs/nfsd/vfs.c  | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index af2947551e9c..57b93d95fa5c 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -280,7 +280,8 @@ void		nfsd_lockd_shutdown(void);
>  #define nfserr_union_notsupp		cpu_to_be32(NFS4ERR_UNION_NOTSUPP)
>  #define nfserr_offload_denied		cpu_to_be32(NFS4ERR_OFFLOAD_DENIED)
>  #define nfserr_wrong_lfs		cpu_to_be32(NFS4ERR_WRONG_LFS)
> -#define nfserr_badlabel		cpu_to_be32(NFS4ERR_BADLABEL)
> +#define nfserr_badlabel			cpu_to_be32(NFS4ERR_BADLABEL)
> +#define nfserr_file_open		cpu_to_be32(NFS4ERR_FILE_OPEN)
>  
>  /* error codes for internal use */
>  /* if a request fails due to kmalloc failure, it gets dropped.
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index bd0a385df3fc..fa2acb6a3b5c 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1809,7 +1809,17 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>  out_drop_write:
>  	fh_drop_write(fhp);
>  out_nfserr:
> -	err = nfserrno(host_err);
> +	if (host_err == -EBUSY) {
> +		/* name is mounted-on. There is no perfect
> +		 * error status.
> +		 */
> +		if (nfsd_v4client(rqstp))
> +			err = nfserr_file_open;
> +		else
> +			err = nfserr_acces;
> +	} else {
> +		err = nfserrno(host_err);
> +	}
>  out:
>  	return err;
>  }
> -- 
> 2.24.0
> 


