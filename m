Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91476836D5
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 20:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjAaTuv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 14:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjAaTuu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 14:50:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C42A984
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 11:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBFD2616C9
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 19:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB3EC433D2;
        Tue, 31 Jan 2023 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675194648;
        bh=ZzWF6Ijhu/kDZt5ErXNUAwWP4roAlpvCTJ+p+SzjC9A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EZc/++v0lQCUp6wxqh5lnDdI1AJSUBhLQKlYkfgKlIgABH+grV83uIwnG3TmQPnyw
         52ZUbej4eOiksXX7TwMWSeCMONL6MSurInFpabmv3emt9J0ycOvXVWlX+swqIQ5rQc
         dX4NnyUZ/MnzivWeLbWLyWel4wSy+1nfpgOoskwN0LsMTUD6QYcEnH1CQcdIMUjg7j
         jdccjpYwBX+kXlYrNgljpVxutTLuFneqsIvZbTDaRt+XQu3M7l+jf4E3BAjgrVkRm5
         yiPONwPdTQ2tT8DDoOStcePhli0wtsYJHnlh0TG32j2irnKGD5o/xX9MDwOlJOjc3b
         jUMJv/h/Bz9qw==
Message-ID: <3f64994e5094ddd46276d3ea18305b6e3d85a353.camel@kernel.org>
Subject: Re: [PATCH v3 1/1] NFSD: fix problems with cleanup on errors in
 nfsd4_copy
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
Date:   Tue, 31 Jan 2023 14:50:46 -0500
In-Reply-To: <1675192349-7908-1-git-send-email-dai.ngo@oracle.com>
References: <1675192349-7908-1-git-send-email-dai.ngo@oracle.com>
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

On Tue, 2023-01-31 at 11:12 -0800, Dai Ngo wrote:
> When nfsd4_copy fails to allocate memory for async_copy->cp_src, or
> nfs4_init_copy_state fails, it calls cleanup_async_copy to do the
> cleanup for the async_copy which causes page fault since async_copy
> is not yet initialized.
>=20
> This patche rearranges the order of initializing the fields in
> async_copy and adds checks in cleanup_async_copy to skip un-initialized
> fields.
>=20
> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> Fixes: 87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> v3: replace list_del with list_del_init
>=20
>  fs/nfsd/nfs4proc.c  | 12 ++++++++----
>  fs/nfsd/nfs4state.c |  5 +++--
>  2 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 57f791899de3..5ae670807449 100644
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
> +			list_del_init(&copy->copies);
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
>  	nn =3D net_generic(copy->cp_clp->net, nfsd_net_id);
>  	spin_lock(&nn->s2s_cp_lock);
>  	idr_remove(&nn->s2s_cp_stateids,

Reviewed-by: Jeff Layton <jlayton@kernel.org>
