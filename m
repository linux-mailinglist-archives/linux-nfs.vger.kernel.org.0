Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC34C682E17
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 14:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjAaNgh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 08:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjAaNgg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 08:36:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B3023C76
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 05:36:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F9A061517
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 13:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473DBC433EF;
        Tue, 31 Jan 2023 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675172189;
        bh=wSDQ2d7c2wJ1C01CeJJimgGKcmYd4HCE6N6KmejUA0M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GGHfMp7GdUx+Ep8DyWn2oJidCI7LZo/HnwDHdi7fMXmPnuYhHMzy+noTWdD9FYy0H
         0epGdSNohAPypLCR0rutcAGDwvqy/lnAAuBz/5vCWpkxwqwKDt1W/qta42N/faE/ZW
         Y3dKl57gaxXlB5aSPpe3vrB1gCLcTjY3gNrsl3/8PBzxGTzenmIbW5RRz4NrdVBQwY
         1xX2I9+fJ54LjINe88EvD9OhhbgaQPkY7h1yt/xU6w45OMIm4o8VjPrsqBRXJlBNyg
         uO9BWxXHp5bUqFed0pSsdov70qtcHXO8nrEqJ6FVl4ZnXdXY74dqg1VjJO7Y/Wwrrf
         OtkS4Haf2pJVg==
Message-ID: <3a2684bf63a044bf2a9f349c28b2b2ea5b9e1016.camel@kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: fix problems with cleanup on errors in
 nfsd4_copy
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
Date:   Tue, 31 Jan 2023 08:36:27 -0500
In-Reply-To: <1674967461-1366-1-git-send-email-dai.ngo@oracle.com>
References: <1674967461-1366-1-git-send-email-dai.ngo@oracle.com>
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

On Sat, 2023-01-28 at 20:44 -0800, Dai Ngo wrote:
> When nfsd4_copy fails to allocate memory for async_copy->cp_src, or
> nfs4_init_copy_state fails, it calls cleanup_async_copy to do the
> cleanup for the async_copy which causes page fault since async_copy
> is not yet initialized.
>=20
> This patch rearranges the order of initializing the fields in
> async_copy and adds checks in cleanup_async_copy to skip un-initialized
> fields.
>=20
> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> Fixes: 87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c  | 12 ++++++++----
>  fs/nfsd/nfs4state.c |  5 +++--
>  2 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 57f791899de3..0754b38d3a43 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1687,9 +1687,12 @@ static void cleanup_async_copy(struct nfsd4_copy *=
copy)
>  {
>  	nfs4_free_copy_state(copy);
>  	release_copy_files(copy);
> -	spin_lock(&copy->cp_clp->async_lock);
> -	list_del(&copy->copies);
> -	spin_unlock(&copy->cp_clp->async_lock);
> +	if (copy->cp_clp) {
> +		spin_lock(&copy->cp_clp->async_lock);
> +		if (!list_empty(&copy->copies))
> +			list_del(&copy->copies);

Can we make this a list_del_init? If cleanup_async_copy were called on
this twice, then the second time could end up corrupting the
async_copies list. The cost difference is negligible here.

> +		spin_unlock(&copy->cp_clp->async_lock);
> +	}
>  	nfs4_put_copy(copy);
>  }
> =20
> @@ -1786,12 +1789,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  		async_copy =3D kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
>  		if (!async_copy)
>  			goto out_err;
> +		INIT_LIST_HEAD(&async_copy->copies);
> +		refcount_set(&async_copy->refcount, 1);
>  		async_copy->cp_src =3D kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL=
);
>  		if (!async_copy->cp_src)
>  			goto out_err;
>  		if (!nfs4_init_copy_state(nn, copy))
>  			goto out_err;
> -		refcount_set(&async_copy->refcount, 1);
>  		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
>  			sizeof(copy->cp_res.cb_stateid));
>  		dup_copy_fields(copy, async_copy);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ace02fd0d590..c39e43742dd6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -975,7 +975,6 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, co=
py_stateid_t *stid,
> =20
>  	stid->cs_stid.si_opaque.so_clid.cl_boot =3D (u32)nn->boot_time;
>  	stid->cs_stid.si_opaque.so_clid.cl_id =3D nn->s2s_cp_cl_id;
> -	stid->cs_type =3D cs_type;
> =20
>  	idr_preload(GFP_KERNEL);
>  	spin_lock(&nn->s2s_cp_lock);
> @@ -986,6 +985,7 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, co=
py_stateid_t *stid,
>  	idr_preload_end();
>  	if (new_id < 0)
>  		return 0;
> +	stid->cs_type =3D cs_type;
>  	return 1;
>  }
> =20
> @@ -1019,7 +1019,8 @@ void nfs4_free_copy_state(struct nfsd4_copy *copy)
>  {
>  	struct nfsd_net *nn;
> =20
> -	WARN_ON_ONCE(copy->cp_stateid.cs_type !=3D NFS4_COPY_STID);
> +	if (copy->cp_stateid.cs_type !=3D NFS4_COPY_STID)
> +		return;

It's probably fine to keep the WARN_ON_ONCE here. You're testing the
condition anyway so you can do:

    if (WARN_ON_ONCE(copy->cp_stateid.cs_type !=3D NFS4_COPY_STID))


>  	nn =3D net_generic(copy->cp_clp->net, nfsd_net_id);
>  	spin_lock(&nn->s2s_cp_lock);
>  	idr_remove(&nn->s2s_cp_stateids,

--=20
Jeff Layton <jlayton@kernel.org>
