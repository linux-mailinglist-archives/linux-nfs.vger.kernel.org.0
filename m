Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017BC6796F2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 12:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjAXLpb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 06:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjAXLp2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 06:45:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7E4402CF
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 03:45:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6434B81183
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 11:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FB1C433EF;
        Tue, 24 Jan 2023 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674560715;
        bh=I9nYWAiHli/CJUh+EA9HquWSXzvk2Q8sLe1SzJuQHg8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jGJoq/EPaMGpMDroSf4gB0ON1RFo44gFw77vYUoImLcET+4QBmndGW/mNG6mwBlbT
         QKc3HWw2qsJCOvYNfadGyxpfuLWk3GIGq2OphqAxEzYu3b4zORU69UEPzdfa9dnr9/
         W91hmdLwj1Iw51/363myrrhFn6V6/rvkJrbRogBCB3BofdL1+hOgUwYDzp6zpX2oIF
         AyHeL+FmrfH6AaTgcSCCumZnI7IX0qN3sZoBRn61Tyc/LVT8h1zK+iDSq7V/LPDsTj
         r57va1DVm0/zvLzoAHBAejRRiMo2ReC21xxdfM2a8Fpjx2qt7+zNWb98wMD58aJsH4
         MoT/IHRTqW+jA==
Message-ID: <a6a220ae0645601eefc0d52ab852ebe37d6dff1c.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix problems with cleanup on errors in
 nfsd4_copy
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
Date:   Tue, 24 Jan 2023 06:45:13 -0500
In-Reply-To: <1674538340-12882-1-git-send-email-dai.ngo@oracle.com>
References: <1674538340-12882-1-git-send-email-dai.ngo@oracle.com>
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

On Mon, 2023-01-23 at 21:32 -0800, Dai Ngo wrote:
> When nfsd4_copy fails to allocate memory for async_copy->cp_src, or
> nfs4_init_copy_state fails, it calls cleanup_async_copy to do the
> cleanup for the async_copy which causes page fault since async_copy
> is not yet initialized.
>=20
> This patche sets async_copy to NULL to skip cleanup_async_copy
> if async_copy is not yet initialized.
>=20
> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> Fixes: 87689df69491 ("NFSD: Shrink size of struct nfsd4_copy")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 3b73e4d342bf..b4e7e18e1761 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1688,7 +1688,8 @@ static void cleanup_async_copy(struct nfsd4_copy *c=
opy)
>  	if (!nfsd4_ssc_is_inter(copy))
>  		nfsd_file_put(copy->nf_src);
>  	spin_lock(&copy->cp_clp->async_lock);
> -	list_del(&copy->copies);
> +	if (!list_empty(&copy->copies))
> +		list_del(&copy->copies);
>  	spin_unlock(&copy->cp_clp->async_lock);
>  	nfs4_put_copy(copy);
>  }
> @@ -1789,9 +1790,15 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  			goto out_err;
>  		async_copy->cp_src =3D kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL=
);
>  		if (!async_copy->cp_src)
> +			goto no_mem;
> +		if (!nfs4_init_copy_state(nn, copy)) {
> +			kfree(async_copy->cp_src);
> +no_mem:
> +			kfree(async_copy);
> +			async_copy =3D NULL;

This seems pretty fragile and the result begins to resemble spaghetti. I
think it'd be cleaner to initialize the list_head and refcount before
you do the allocation of cp_src. Then you can just call
cleanup_async_copy no matter where it fails.

Bear in mind that these are failure codepaths, so we don't need to
optimize for performance here.



>  			goto out_err;
> -		if (!nfs4_init_copy_state(nn, copy))
> -			goto out_err;
> +		}
> +		INIT_LIST_HEAD(&async_copy->copies);
>  		refcount_set(&async_copy->refcount, 1);
>  		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
>  			sizeof(copy->cp_res.cb_stateid));

--=20
Jeff Layton <jlayton@kernel.org>
