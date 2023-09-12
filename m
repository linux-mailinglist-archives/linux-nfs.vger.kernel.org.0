Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D9979CEEF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjILKyz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 06:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjILKyw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 06:54:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E65D9F
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 03:54:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C4FC433C8;
        Tue, 12 Sep 2023 10:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694516088;
        bh=jFA/6CM4YbOaAE/4WIzSRizhif4oSAPm6gl0T3zPzh8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mpglQpCUBASXnVMH8nI1lF7i6xWsRNVAYUYonRvS9Hmn72jWuYbazUp/M5u0Oh541
         xxjwsnELdeqpVltaYkeHXL8ndYfENMo6+aYT8b1Orv/IfqCh0LGL9w7vy9M0FUKMw5
         BHsko3N3wDs+9N4MleqMuoyfetIxuMQkNprXt5eTwFI43jZh5w68V92Ix7zZG2tgXh
         o0UcCrqLnCf93oY/o9KMzji4apSmy3efd7x0bOtjyRTOIxsCBXD9qy7QDNV/tgWqBP
         SP/eZe7TMXpKcSmVQt0KjUsHHWX0Oek4KfqWMenkkCsBkz+hDTXJZtSbK8eU/agjfk
         yh6eCv/A3v0JQ==
Message-ID: <22559864b4afa6dc7fa477fa98cfeca707092b94.camel@kernel.org>
Subject: Re: [PATCH] nfsd: Don't reset the write verifier on a commit EAGAIN
From:   Jeff Layton <jlayton@kernel.org>
To:     trondmy@gmail.com, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 Sep 2023 06:54:46 -0400
In-Reply-To: <20230911184357.11739-1-trond.myklebust@hammerspace.com>
References: <20230911184357.11739-1-trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-09-11 at 14:43 -0400, trondmy@gmail.com wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> If fsync() is returning EAGAIN, then we can assume that the filesystem
> being exported is something like NFS with the 'softerr' mount option
> enabled, and that it is just asking us to replay the fsync() operation
> at a later date.
> If we see an ESTALE, then ditto: the file is gone, so there is no danger
> of losing the error.
> For those cases, do not reset the write verifier.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/vfs.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 98fa4fd0556d..31daf9f63572 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -337,6 +337,20 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *f=
hp, const char *name,
>  	return err;
>  }
> =20
> +static void
> +commit_reset_write_verifier(struct nfsd_net *nn, struct svc_rqst *rqstp,
> +			    int err)
> +{
> +	switch (err) {
> +	case -EAGAIN:
> +	case -ESTALE:
> +		break;
> +	default:
> +		nfsd_reset_write_verifier(nn);
> +		trace_nfsd_writeverf_reset(nn, rqstp, err);
> +	}
> +}
> +
>  /*
>   * Commit metadata changes to stable storage.
>   */
> @@ -647,8 +661,7 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
>  					&nfsd4_get_cstate(rqstp)->current_fh,
>  					dst_pos,
>  					count, status);
> -			nfsd_reset_write_verifier(nn);
> -			trace_nfsd_writeverf_reset(nn, rqstp, status);
> +			commit_reset_write_verifier(nn, rqstp, status);
>  			ret =3D nfserrno(status);
>  		}
>  	}
> @@ -1170,8 +1183,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_f=
h *fhp, struct nfsd_file *nf,
>  	host_err =3D vfs_iter_write(file, &iter, &pos, flags);
>  	file_end_write(file);
>  	if (host_err < 0) {
> -		nfsd_reset_write_verifier(nn);
> -		trace_nfsd_writeverf_reset(nn, rqstp, host_err);
> +		commit_reset_write_verifier(nn, rqstp, host_err);
>  		goto out_nfserr;
>  	}
>  	*cnt =3D host_err;
> @@ -1183,10 +1195,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_=
fh *fhp, struct nfsd_file *nf,
> =20
>  	if (stable && use_wgather) {
>  		host_err =3D wait_for_concurrent_writes(file);
> -		if (host_err < 0) {
> -			nfsd_reset_write_verifier(nn);
> -			trace_nfsd_writeverf_reset(nn, rqstp, host_err);
> -		}
> +		if (host_err < 0)
> +			commit_reset_write_verifier(nn, rqstp, host_err);
>  	}
> =20
>  out_nfserr:
> @@ -1329,8 +1339,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *=
fhp, struct nfsd_file *nf,
>  			err =3D nfserr_notsupp;
>  			break;
>  		default:
> -			nfsd_reset_write_verifier(nn);
> -			trace_nfsd_writeverf_reset(nn, rqstp, err2);
> +			commit_reset_write_verifier(nn, rqstp, err2);
>  			err =3D nfserrno(err2);
>  		}
>  	} else

Reviewed-by: Jeff Layton <jlayton@kernel.org>
