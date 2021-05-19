Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2231538989B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 23:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhESVd5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 17:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESVd5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 May 2021 17:33:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A33C06175F
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 14:32:37 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 29C9464E8; Wed, 19 May 2021 17:32:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 29C9464E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1621459956;
        bh=HWbzhv9i3P37jhkoG6H7SO5nBlTADmZQFZ9qbtWGzwI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=SvMjojGnqaqJqXPqXFc1ocnAiNuJm2vfJ7Uh2qWYhVSoxjcOxfHmnsiRgIuCC5ffO
         zpZUGZmsEiBpsrTExdh4rpeN/Xt3DLFK6JZI6Gf6rlX7QQH61A0rtWbmupU6w54J6j
         IrohqDHJR9Yta2z1zZN8QSb/ztMJ6v4bfk1GIjKk=
Date:   Wed, 19 May 2021 17:32:36 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] NFSD add vfs_fsync after async copy is done
Message-ID: <20210519213236.GD19450@fieldses.org>
References: <20210519184827.5460-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519184827.5460-1-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 19, 2021 at 02:48:27PM -0400, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Currently, the server does all copies as NFS_UNSTABLE. For synchronous
> copies linux client will append a COMMIT to the COPY compound but for
> async copies it does not (because COMMIT needs to be done after all
> bytes are copied and not as a reply to the COPY operation).
> 
> However, in order to save the client doing a COMMIT as a separate
> rpc, the server can reply back with NFS_FILE_SYNC copy. This patch
> proposed to add vfs_fsync() call at the end of the async copy.
> 
> --- v2: moved the committed argument into the nfsd4_copy structure

Makes sense to me, thanks.  Applying if nobody sees an objection.--b.

> 
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfsd/nfs4proc.c | 14 +++++++++++++-
>  fs/nfsd/xdr4.h     |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f4ce93d7f26e..dc7ac4b39eff 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1375,7 +1375,8 @@ static const struct nfsd4_callback_ops nfsd4_cb_offload_ops = {
>  
>  static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
>  {
> -	copy->cp_res.wr_stable_how = NFS_UNSTABLE;
> +	copy->cp_res.wr_stable_how =
> +		copy->committed ? NFS_FILE_SYNC : NFS_UNSTABLE;
>  	copy->cp_synchronous = sync;
>  	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
>  }
> @@ -1386,6 +1387,7 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
>  	u64 bytes_total = copy->cp_count;
>  	u64 src_pos = copy->cp_src_pos;
>  	u64 dst_pos = copy->cp_dst_pos;
> +	__be32 status;
>  
>  	/* See RFC 7862 p.67: */
>  	if (bytes_total == 0)
> @@ -1403,6 +1405,16 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
>  		src_pos += bytes_copied;
>  		dst_pos += bytes_copied;
>  	} while (bytes_total > 0 && !copy->cp_synchronous);
> +	/* for a non-zero asynchronous copy do a commit of data */
> +	if (!copy->cp_synchronous && copy->cp_res.wr_bytes_written > 0) {
> +		down_write(&copy->nf_dst->nf_rwsem);
> +		status = vfs_fsync_range(copy->nf_dst->nf_file,
> +					 copy->cp_dst_pos,
> +					 copy->cp_res.wr_bytes_written, 0);
> +		up_write(&copy->nf_dst->nf_rwsem);
> +		if (!status)
> +			copy->committed = true;
> +	}
>  	return bytes_copied;
>  }
>  
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index a7c425254fee..3e4052e3bd50 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -567,6 +567,7 @@ struct nfsd4_copy {
>  	struct vfsmount		*ss_mnt;
>  	struct nfs_fh		c_fh;
>  	nfs4_stateid		stateid;
> +	bool			committed;
>  };
>  
>  struct nfsd4_seek {
> -- 
> 2.27.0
