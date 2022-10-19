Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227AC604364
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 13:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiJSLg7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 07:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiJSLgi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 07:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22846264D
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 04:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77411617F2
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 10:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A24FC433D7;
        Wed, 19 Oct 2022 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666176492;
        bh=aT3bRe20trXKAxg6G9nCSs9nZx1I2eKZai4mOg30Ym4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WZtzdfv+OMhQBZbKxD9R8zuxq3+hMl9hzMpRernmsCK/TRDYGuDQoX/6kcVsgtQ6f
         pdU/jh9NSrtECvqjYICEvJXAqOuCLeFF9EihZuUW/XkrWBwaQHPgBXg4cNbEgqy2qo
         uNrkOa75lsVWA9WfptN4vDo1wDPh20ebB4ZlTsPBftU/RXNKGxRmAaNnpCyiLmJxgI
         CIEZ0h1ciaIiNXwUXmBpJPKZP+LPsfgJdDH3fPXb32+m9r1jgG+5PrDpES+WEwL1gk
         XIgzTxRfWJ5uMTTv+kPFFvSjAUtJWt63dadNTwwDTZQLzaHV3ue0MNO/AYjXOZXHbv
         48yNhA30eJR9Q==
Message-ID: <92900300ed0a95cca20803a1dcefe42720ccbd02.camel@kernel.org>
Subject: Re: [PATCH v4 1/7] NFSD: Pass the target nfsd_file to nfsd_commit()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Wed, 19 Oct 2022 06:48:10 -0400
In-Reply-To: <166612310541.1291.15561800269068549060.stgit@manet.1015granger.net>
References: <166612295223.1291.11761205673682408148.stgit@manet.1015granger.net>
         <166612310541.1291.15561800269068549060.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-10-18 at 15:58 -0400, Chuck Lever wrote:
> In a moment I'm going to introduce separate nfsd_file types, one of
> which is garbage-collected; the other, not. The garbage-collected
> variety is to be used by NFSv2 and v3, and the non-garbage-collected
> variety is to be used by NFSv4.
>=20
> nfsd_commit() is invoked by both NFSv3 and NFSv4 consumers. We want
> nfsd_commit() to find and use the correct variety of cached
> nfsd_file object for the NFS version that is in use.
>=20
> This is a refactoring change. No behavior change is expected.
>=20
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c |   10 +++++++++-
>  fs/nfsd/nfs4proc.c |   11 ++++++++++-
>  fs/nfsd/vfs.c      |   15 ++++-----------
>  fs/nfsd/vfs.h      |    3 ++-
>  4 files changed, 25 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index a41cca619338..d12823371857 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -13,6 +13,7 @@
>  #include "cache.h"
>  #include "xdr3.h"
>  #include "vfs.h"
> +#include "filecache.h"
> =20
>  #define NFSDDBG_FACILITY		NFSDDBG_PROC
> =20
> @@ -770,6 +771,7 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>  {
>  	struct nfsd3_commitargs *argp =3D rqstp->rq_argp;
>  	struct nfsd3_commitres *resp =3D rqstp->rq_resp;
> +	struct nfsd_file *nf;
> =20
>  	dprintk("nfsd: COMMIT(3)   %s %u@%Lu\n",
>  				SVCFH_fmt(&argp->fh),
> @@ -777,8 +779,14 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
>  				(unsigned long long) argp->offset);
> =20
>  	fh_copy(&resp->fh, &argp->fh);
> -	resp->status =3D nfsd_commit(rqstp, &resp->fh, argp->offset,
> +	resp->status =3D nfsd_file_acquire(rqstp, &resp->fh, NFSD_MAY_WRITE |
> +					 NFSD_MAY_NOT_BREAK_LEASE, &nf);
> +	if (resp->status)
> +		goto out;
> +	resp->status =3D nfsd_commit(rqstp, &resp->fh, nf, argp->offset,
>  				   argp->count, resp->verf);
> +	nfsd_file_put(nf);
> +out:
>  	return rpc_success;
>  }
> =20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index a72ab97f77ef..d0d976f847ca 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -739,10 +739,19 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  	     union nfsd4_op_u *u)
>  {
>  	struct nfsd4_commit *commit =3D &u->commit;
> +	struct nfsd_file *nf;
> +	__be32 status;
> =20
> -	return nfsd_commit(rqstp, &cstate->current_fh, commit->co_offset,
> +	status =3D nfsd_file_acquire(rqstp, &cstate->current_fh, NFSD_MAY_WRITE=
 |
> +				   NFSD_MAY_NOT_BREAK_LEASE, &nf);
> +	if (status !=3D nfs_ok)
> +		return status;
> +
> +	status =3D nfsd_commit(rqstp, &cstate->current_fh, nf, commit->co_offse=
t,
>  			     commit->co_count,
>  			     (__be32 *)commit->co_verf.data);
> +	nfsd_file_put(nf);
> +	return status;
>  }
> =20
>  static __be32
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index fc17b0ac8729..44f210ba17cc 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1108,6 +1108,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *f=
hp, loff_t offset,
>   * nfsd_commit - Commit pending writes to stable storage
>   * @rqstp: RPC request being processed
>   * @fhp: NFS filehandle
> + * @nf: target file
>   * @offset: raw offset from beginning of file
>   * @count: raw count of bytes to sync
>   * @verf: filled in with the server's current write verifier
> @@ -1124,19 +1125,13 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh =
*fhp, loff_t offset,
>   *   An nfsstat value in network byte order.
>   */
>  __be32
> -nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
> -	    u32 count, __be32 *verf)
> +nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file=
 *nf,
> +	    u64 offset, u32 count, __be32 *verf)
>  {
> +	__be32			err =3D nfs_ok;
>  	u64			maxbytes;
>  	loff_t			start, end;
>  	struct nfsd_net		*nn;
> -	struct nfsd_file	*nf;
> -	__be32			err;
> -
> -	err =3D nfsd_file_acquire(rqstp, fhp,
> -			NFSD_MAY_WRITE|NFSD_MAY_NOT_BREAK_LEASE, &nf);
> -	if (err)
> -		goto out;
> =20
>  	/*
>  	 * Convert the client-provided (offset, count) range to a
> @@ -1177,8 +1172,6 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *=
fhp, u64 offset,
>  	} else
>  		nfsd_copy_write_verifier(verf, nn);
> =20
> -	nfsd_file_put(nf);
> -out:
>  	return err;
>  }
> =20
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index c95cd414b4bb..04dfd80570f0 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -88,7 +88,8 @@ __be32		nfsd_access(struct svc_rqst *, struct svc_fh *,=
 u32 *, u32 *);
>  __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct svc_fh *resfhp, struct nfsd_attrs *iap);
>  __be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
> -				u64 offset, u32 count, __be32 *verf);
> +				struct nfsd_file *nf, u64 offset, u32 count,
> +				__be32 *verf);
>  #ifdef CONFIG_NFSD_V4
>  __be32		nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			    char *name, void **bufp, int *lenp);
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
