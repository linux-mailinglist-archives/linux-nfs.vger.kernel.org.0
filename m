Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92570672598
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjARRyq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjARRyp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:54:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124B4DE0A
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:54:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1C47B81E66
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF42C433EF;
        Wed, 18 Jan 2023 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674064478;
        bh=P3+hdFuxKs8cOdds+IoqRIs0g0+EH5HWr6r2nvRh8DU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i0jYTPVwyNdz3uDWngrYrJr5naO4viXyehgCy8M+Y2Ec614k0Dz0Agwpa0V3UoC8K
         5ei80fg8+BpulZq96jx4b2l54F3vcNpNW6BFMdxs6BRw0eLjBaE559jjMOU0xWrCmK
         nsxitbJMu6wvZM3+/cx5KIlOo9ZkTeaHzUmquX2y2bKZCATzzQ7QjeKbLwvLYmId0/
         AHn43t0/bOpqqwdDXZMTJOHMYvTEzMkT0lM/BcZLqhRRxjabapnpvlF5O6B94099wf
         UncafuNPeMTqGAzUkXQTn1UHXbd2kU8vOlutecRcBEYkHaSmrSAIr542YvvV//VmDk
         J67JJt8P1qS2Q==
Message-ID: <951265d3954621086aa00d27c275e1d50d3e9586.camel@kernel.org>
Subject: Re: [PATCH 3/4] nfsd: don't kill nfsd_files because of lease break
 error
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 18 Jan 2023 12:54:36 -0500
In-Reply-To: <20230105121512.21484-4-jlayton@kernel.org>
References: <20230105121512.21484-1-jlayton@kernel.org>
         <20230105121512.21484-4-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-01-05 at 07:15 -0500, Jeff Layton wrote:
> An error from break_lease is non-fatal, so we needn't destroy the
> nfsd_file in that case. Just put the reference like we normally would
> and return the error.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a67b22579c6e..f0ca9501edb2 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1113,7 +1113,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
>  	nf =3D nfsd_file_alloc(&key, may_flags);
>  	if (!nf) {
>  		status =3D nfserr_jukebox;
> -		goto out_status;
> +		goto out;
>  	}
> =20
>  	ret =3D rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
> @@ -1122,13 +1122,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>  	if (likely(ret =3D=3D 0))
>  		goto open_file;
> =20
> -	nfsd_file_slab_free(&nf->nf_rcu);
> -	nf =3D NULL;
>  	if (ret =3D=3D -EEXIST)
>  		goto retry;
>  	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
>  	status =3D nfserr_jukebox;
> -	goto out_status;
> +	goto construction_err;
> =20
>  wait_for_construction:
>  	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> @@ -1138,28 +1136,24 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>  		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
>  		if (!open_retry) {
>  			status =3D nfserr_jukebox;
> -			goto out;
> +			goto construction_err;
>  		}
>  		open_retry =3D false;
> -		if (refcount_dec_and_test(&nf->nf_ref))
> -			nfsd_file_free(nf);
>  		goto retry;
>  	}
> -
>  	this_cpu_inc(nfsd_file_cache_hits);
> =20
>  	status =3D nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_=
flags));
> +	if (status !=3D nfs_ok) {
> +		nfsd_file_put(nf);
> +		nf =3D NULL;
> +	}
> +
>  out:
>  	if (status =3D=3D nfs_ok) {
>  		this_cpu_inc(nfsd_file_acquisitions);
>  		*pnf =3D nf;
> -	} else {
> -		if (refcount_dec_and_test(&nf->nf_ref))
> -			nfsd_file_free(nf);
> -		nf =3D NULL;
>  	}
> -
> -out_status:
>  	put_cred(key.cred);
>  	trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);
>  	return status;
> @@ -1189,6 +1183,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>  	if (status !=3D nfs_ok)
>  		nfsd_file_unhash(nf);
>  	clear_and_wake_up_bit(NFSD_FILE_PENDING, &nf->nf_flags);
> +	if (status =3D=3D nfs_ok)
> +		goto out;
> +
> +construction_err:
> +	if (refcount_dec_and_test(&nf->nf_ref))
> +		nfsd_file_free(nf);
> +	nf =3D NULL;
>  	goto out;
>  }
> =20

Chuck, ping?

You never responded to this patch and I don't see it in your tree. Any
thoughts?
--=20
Jeff Layton <jlayton@kernel.org>
