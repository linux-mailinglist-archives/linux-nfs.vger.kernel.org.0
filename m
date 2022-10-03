Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE9E5F2FB8
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJCLeM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 07:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJCLeM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 07:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EB13ECFC
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 04:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE4D61024
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 11:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F8AC433C1;
        Mon,  3 Oct 2022 11:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664796849;
        bh=EyW5kEyj4REtAQNh0qJMVFPWibIcbI/ferIIPc0HaX0=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=rkjdMI2QBu+47kej7OJgg++t4Dab2TEDIPUAa1sOYvAUUtcKD8skCYs6zuDAKkZgG
         lZqm+/y1thAaRJEUKUDhb6fAcXAV+GBCL4W3OdwQzrD1cAT3Rvt4P4wTpB3OQohFTn
         IoMTz1/iW91Echrv7yrkZuHNbJ2mKNl9QemFRAEmxOh0N3txCzvarIG1uZgAJXrzsR
         d8GOWb2cTiggS1l8rfItHWiH+Ecbz0O1OeGZZD09yF7guiku7nbW0SSxcvi3nsEhkJ
         oL0NNfMh4AcBguKYhKjQOTONWTmuwuqjssfo3Flypm341Ouo9Js2S8OJFkhOIv9QN6
         OnGSEOEFTkVDw==
Message-ID: <f38b7fe087b1dd296bf7a5b693e685936ebecada.camel@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Hold rcu_read_lock while getting refs
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 03 Oct 2022 07:34:07 -0400
In-Reply-To: <166463917715.10124.3789034969503323129.stgit@bazille.1015granger.net>
References: <166463917715.10124.3789034969503323129.stgit@bazille.1015granger.net>
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

On Sat, 2022-10-01 at 11:48 -0400, Chuck Lever wrote:
> nfsd_file is RCU-freed, so it's possible that one could be found
> that's in the process of being freed and the memory recycled. Ensure
> we hold the rcu_read_lock while attempting to get a reference on the
> object.
>=20
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |   34 +++++++++++-----------------------
>  fs/nfsd/trace.h     |   27 ---------------------------
>  2 files changed, 11 insertions(+), 50 deletions(-)
>=20
> This is what I was thinking... Compile-tested only.
>=20
>=20

Looks reasonable. I had something pretty similar that I'll send along in
a bit.

> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index be152e3e3a80..6e17f74fb29f 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1056,10 +1056,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> =20
>  retry:
>  	/* Avoid allocation if the item is already in cache */
> -	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> -				    nfsd_file_rhash_params);
> +	rcu_read_lock();
> +	nf =3D rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
> +			       nfsd_file_rhash_params);
>  	if (nf)
>  		nf =3D nfsd_file_get(nf);
> +	rcu_read_unlock();
>  	if (nf)
>  		goto wait_for_construction;
> =20
> @@ -1069,21 +1071,14 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>  		goto out_status;
>  	}
> =20
> -	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
> -					      &key, &new->nf_rhash,
> -					      nfsd_file_rhash_params);
> -	if (!nf) {
> -		nf =3D new;
> -		goto open_file;
> -	}
> -	if (IS_ERR(nf))
> -		goto insert_err;
> -	nf =3D nfsd_file_get(nf);
> -	if (nf =3D=3D NULL) {
> -		nf =3D new;
> -		goto open_file;
> +	if (rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
> +					 &key, &new->nf_rhash,
> +					 nfsd_file_rhash_params)) {
> +		nfsd_file_slab_free(&new->nf_rcu);
> +		goto retry;

This can return other errors besides -EEXIST. I'm not sure we want to
goto retry on those others.

>  	}
> -	nfsd_file_slab_free(&new->nf_rcu);
> +	nf =3D new;
> +	goto open_file;
> =20
>  wait_for_construction:
>  	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> @@ -1143,13 +1138,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
>  	smp_mb__after_atomic();
>  	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>  	goto out;
> -
> -insert_err:
> -	nfsd_file_slab_free(&new->nf_rcu);
> -	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, PTR_ERR(nf));
> -	nf =3D NULL;
> -	status =3D nfserr_jukebox;
> -	goto out_status;
>  }
> =20
>  /**
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 06a96e955bd0..c15467b2e8d9 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -954,33 +954,6 @@ TRACE_EVENT(nfsd_file_create,
>  	)
>  );
> =20
> -TRACE_EVENT(nfsd_file_insert_err,
> -	TP_PROTO(
> -		const struct svc_rqst *rqstp,
> -		const struct inode *inode,
> -		unsigned int may_flags,
> -		long error
> -	),
> -	TP_ARGS(rqstp, inode, may_flags, error),
> -	TP_STRUCT__entry(
> -		__field(u32, xid)
> -		__field(const void *, inode)
> -		__field(unsigned long, may_flags)
> -		__field(long, error)
> -	),
> -	TP_fast_assign(
> -		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> -		__entry->inode =3D inode;
> -		__entry->may_flags =3D may_flags;
> -		__entry->error =3D error;
> -	),
> -	TP_printk("xid=3D0x%x inode=3D%p may_flags=3D%s error=3D%ld",
> -		__entry->xid, __entry->inode,
> -		show_nfsd_may_flags(__entry->may_flags),
> -		__entry->error
> -	)
> -);
> -
>  TRACE_EVENT(nfsd_file_cons_err,
>  	TP_PROTO(
>  		const struct svc_rqst *rqstp,
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
