Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6DF5F6B2E
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Oct 2022 18:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJFQFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Oct 2022 12:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiJFQFi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Oct 2022 12:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CB54CA34
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 09:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6210661A0C
        for <linux-nfs@vger.kernel.org>; Thu,  6 Oct 2022 16:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738FFC433C1;
        Thu,  6 Oct 2022 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665072330;
        bh=EeI+ajX9PrcVRzmVETMNu/xDOTpc1ysPP8s/eACVNJE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ClcNhs5R/uJo3+6c7GkGFGb7hrNHAt62zcuwQb+GtsjhNkWjqthYzYsMGVw6KBcOe
         e+Y95clPADXkea13nmGATHUQ0gAj3sKf2f0Zixt6kpTpk72wIlat5zB6uSYVvAe+vN
         mWQon/xWUdzNqddfhFGzCV/QD/eodZicNROjOeqvtTYAkxVAJQaJLYQquy2037nsdU
         ambKKGOZjj6n8BroVMPBlWXk+gZH5AT/ajpNfSRp9CNcukan9wLmdHT5NB3p9xnd5t
         gmwG+rdh+vyij44wRoaRBaoregych9iSEK+HN59coTleSEjKvb9Xf8pJj5w0TGDQjU
         w9Dr5QbNDdZxQ==
Message-ID: <82827bf5e90d761e1eb263603d729199e3401cd7.camel@kernel.org>
Subject: Re: [PATCH RFC 8/9] NFSD: Clean up nfs4_preprocess_stateid_op()
 call sites
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Thu, 06 Oct 2022 12:05:29 -0400
In-Reply-To: <166498178682.1527.2423899374993202065.stgit@manet.1015granger.net>
References: <166497916751.1527.11190362197003358927.stgit@manet.1015granger.net>
         <166498178682.1527.2423899374993202065.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-10-05 at 10:56 -0400, Chuck Lever wrote:
> Remove the lame-duck dprintk()s around nfs4_preprocess_stateid_op()
> call sites.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c |   31 +++++++------------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d0d976f847ca..42b81e88ea14 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -951,12 +951,7 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
>  	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_f=
h,
>  					&read->rd_stateid, RD_STATE,
>  					&read->rd_nf, NULL);
> -	if (status) {
> -		dprintk("NFSD: nfsd4_read: couldn't process stateid!\n");
> -		goto out;
> -	}
> -	status =3D nfs_ok;
> -out:
> +
>  	read->rd_rqstp =3D rqstp;
>  	read->rd_fhp =3D &cstate->current_fh;
>  	return status;
> @@ -1125,10 +1120,8 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>  		status =3D nfs4_preprocess_stateid_op(rqstp, cstate,
>  				&cstate->current_fh, &setattr->sa_stateid,
>  				WR_STATE, NULL, NULL);
> -		if (status) {
> -			dprintk("NFSD: nfsd4_setattr: couldn't process stateid!\n");
> +		if (status)
>  			return status;
> -		}
>  	}
>  	err =3D fh_want_write(&cstate->current_fh);
>  	if (err)
> @@ -1176,10 +1169,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  			       write->wr_offset, cnt);
>  	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_f=
h,
>  						stateid, WR_STATE, &nf, NULL);
> -	if (status) {
> -		dprintk("NFSD: nfsd4_write: couldn't process stateid!\n");
> +	if (status)
>  		return status;
> -	}
> =20
>  	write->wr_how_written =3D write->wr_stable_how;
> =20
> @@ -1210,17 +1201,13 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> =20
>  	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->save_fh,
>  					    src_stateid, RD_STATE, src, NULL);
> -	if (status) {
> -		dprintk("NFSD: %s: couldn't process src stateid!\n", __func__);
> +	if (status)
>  		goto out;
> -	}
> =20
>  	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_f=
h,
>  					    dst_stateid, WR_STATE, dst, NULL);
> -	if (status) {
> -		dprintk("NFSD: %s: couldn't process dst stateid!\n", __func__);
> +	if (status)
>  		goto out_put_src;
> -	}
> =20
>  	/* fix up for NFS-specific error code */
>  	if (!S_ISREG(file_inode((*src)->nf_file)->i_mode) ||
> @@ -1955,10 +1942,8 @@ nfsd4_fallocate(struct svc_rqst *rqstp, struct nfs=
d4_compound_state *cstate,
>  	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_f=
h,
>  					    &fallocate->falloc_stateid,
>  					    WR_STATE, &nf, NULL);
> -	if (status !=3D nfs_ok) {
> -		dprintk("NFSD: nfsd4_fallocate: couldn't process stateid!\n");
> +	if (status !=3D nfs_ok)
>  		return status;
> -	}
> =20
>  	status =3D nfsd4_vfs_fallocate(rqstp, &cstate->current_fh, nf->nf_file,
>  				     fallocate->falloc_offset,
> @@ -2014,10 +1999,8 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_f=
h,
>  					    &seek->seek_stateid,
>  					    RD_STATE, &nf, NULL);
> -	if (status) {
> -		dprintk("NFSD: nfsd4_seek: couldn't process stateid!\n");
> +	if (status)
>  		return status;
> -	}
> =20
>  	switch (seek->seek_whence) {
>  	case NFS4_CONTENT_DATA:
>=20
>=20

I agree that these are not particularly helpful. It might be a good idea
to add a conditional tracepoint in nfs4_preprocess_stateid_op though,
for when it returns an error, but I don't care enough to stand in the
way of this decluttering.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
