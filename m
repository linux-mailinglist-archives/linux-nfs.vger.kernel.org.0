Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84CC75D0D6
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGURqe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 13:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGURqd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 13:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EB430D4
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 10:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF61C61D6D
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 17:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339ABC433C7;
        Fri, 21 Jul 2023 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689961591;
        bh=xNpSAvq4xm8u45grRMGvwSCH3lbrP0MpP85uUXYkv1s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HopmFE4n7uUw0TKg1b62MVnSFFvDh3xJUX6PB/M6CCRLQPTfA06Gs6YJL6tf7c46K
         eoLQB85vKL6s7JD90IpYwC5obhnDrfRHVabCVrj8Ii8+reNksCcosz3Gj/5Ewx5LwE
         VYSPCAPj1Os9vJ+cq2gfULsqFa51IaR/MgZU+SwMzA9/CbyWHS5theEYIWhFRbWc96
         YtKq5R34EuWu6edWAJa/n4TojpGk/z7DIAQLmDf1d1KXroVjxRfqCP1oTW7P9Pk1s2
         mYcgfQ1Y3Hf+rfE5gJuWiglT3K0O4ijUxEoF1GvcPF9DBD4TPa36RJXKCIEEZPjjmp
         be+7AMqzFke4A==
Message-ID: <fc5c5e0bcfa7110282106c3319af6a0b5a63b221.camel@kernel.org>
Subject: Re: [RFC v6.5-rc2 3/3] fs: lockd: introduce safe async lock op
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>, chuck.lever@oracle.com
Cc:     neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, teigland@redhat.com,
        cluster-devel@redhat.com, agruenba@redhat.com
Date:   Fri, 21 Jul 2023 13:46:28 -0400
In-Reply-To: <20230720125806.1385279-3-aahringo@redhat.com>
References: <20230720125806.1385279-1-aahringo@redhat.com>
         <20230720125806.1385279-3-aahringo@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-07-20 at 08:58 -0400, Alexander Aring wrote:
> This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
> on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LOCK
> export flag to signal that the "own ->lock" implementation supports
> async lock requests. The only main user is DLM that is used by GFS2 and
> OCFS2 filesystem. Those implement their own lock() implementation and
> return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
> ("nfs: block notification on fs with its own ->lock") the DLM
> implementation were never updated. This patch should prepare for DLM
> to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
> plock implementation regarding to it.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/lockd/svclock.c       |  5 ++---
>  fs/nfsd/nfs4state.c      | 11 ++++++++---
>  include/linux/exportfs.h |  1 +
>  3 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 62ef27a69a9e..54a67bd33843 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -483,9 +483,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>  	    struct nlm_host *host, struct nlm_lock *lock, int wait,
>  	    struct nlm_cookie *cookie, int reclaim)
>  {
> -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  	struct inode		*inode =3D nlmsvc_file_inode(file);
> -#endif
>  	struct nlm_block	*block =3D NULL;
>  	int			error;
>  	int			mode;
> @@ -499,7 +497,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *=
file,
>  				(long long)lock->fl.fl_end,
>  				wait);
> =20
> -	if (nlmsvc_file_file(file)->f_op->lock) {
> +	if (!(inode->i_sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC_LOCK) &&
> +	    nlmsvc_file_file(file)->f_op->lock) {
>  		async_block =3D wait;
>  		wait =3D 0;
>  	}
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6e61fa3acaf1..efcea229d640 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7432,6 +7432,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  	struct nfsd4_blocked_lock *nbl =3D NULL;
>  	struct file_lock *file_lock =3D NULL;
>  	struct file_lock *conflock =3D NULL;
> +	struct super_block *sb;
>  	__be32 status =3D 0;
>  	int lkflg;
>  	int err;
> @@ -7453,6 +7454,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  		dprintk("NFSD: nfsd4_lock: permission denied!\n");
>  		return status;
>  	}
> +	sb =3D cstate->current_fh.fh_dentry->d_sb;
> =20
>  	if (lock->lk_is_new) {
>  		if (nfsd4_has_session(cstate))
> @@ -7504,7 +7506,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  	fp =3D lock_stp->st_stid.sc_file;
>  	switch (lock->lk_type) {
>  		case NFS4_READW_LT:
> -			if (nfsd4_has_session(cstate))
> +			if (sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC_LOCK &&

This will break existing filesystems that don't set the new flag. Maybe
you also need to test for the filesystem's ->lock operation here too?

This might be more nicely expressed in a helper function.

> +			    nfsd4_has_session(cstate))
>  				fl_flags |=3D FL_SLEEP;
>  			fallthrough;
>  		case NFS4_READ_LT:
> @@ -7516,7 +7519,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  			fl_type =3D F_RDLCK;
>  			break;
>  		case NFS4_WRITEW_LT:
> -			if (nfsd4_has_session(cstate))
> +			if (sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC_LOCK &&
> +			    nfsd4_has_session(cstate))
>  				fl_flags |=3D FL_SLEEP;
>  			fallthrough;
>  		case NFS4_WRITE_LT:
> @@ -7544,7 +7548,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  	 * for file locks), so don't attempt blocking lock notifications
>  	 * on those filesystems:
>  	 */
> -	if (nf->nf_file->f_op->lock)
> +	if (!(sb->s_export_op->flags & EXPORT_OP_SAFE_ASYNC_LOCK) &&
> +	    nf->nf_file->f_op->lock)
>  		fl_flags &=3D ~FL_SLEEP;
> =20
>  	nbl =3D find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 11fbd0ee1370..da742abbaf3e 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -224,6 +224,7 @@ struct export_operations {
>  						  atomic attribute updates
>  						*/
>  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close=
 */
> +#define EXPORT_OP_SAFE_ASYNC_LOCK	(0x40) /* fs can do async lock request=
 */
>  	unsigned long	flags;
>  };
> =20

--=20
Jeff Layton <jlayton@kernel.org>
