Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5806796FA
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 12:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjAXLsa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 06:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjAXLsa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 06:48:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B892B40BDB
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 03:48:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54DB16101A
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 11:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A38C433D2;
        Tue, 24 Jan 2023 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674560907;
        bh=2h+EkRHpGy4sP74haajkRNzUYo1786IMmDRVMt3vWoc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tD0DSxrtnuCBm9XYaNFQOdg2dpP3XdLJKlXOrPAmAHoPKL7d2L58jcqOyjmmRhHZG
         Rz9R2It1g2163dQgLkRmPq7QCKbLV5LNpROujA6Ou90DydMm5o3gfSRfC2mRd1Viyb
         n7J68KzoGdKDFFnk2NvA7MKTZFwjillxDj+TZdp5PeZ6ICVccyURx8NzglnEYWba6g
         oLYzGNLjHJT7/6fphrX8aep06GWh8AGTZSE8wokfJzIQFwAyrTWnqbyu/gYRcQJAUs
         H/mA4YkU2+ifRC8zMDp023XgxKhtAioMb5k9+2uzdjuR0jm1OyBtIbllcZxLx08eWR
         YUTbOVT/CQiDQ==
Message-ID: <d1ec3853d8709843e7e8fd70e463db2ee71b0bcd.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix leak referent count of
 nfsd4_ssc_umount_item in nfsd4_copy
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     aglo@umich.edu, linux-nfs@vger.kernel.org
Date:   Tue, 24 Jan 2023 06:48:25 -0500
In-Reply-To: <1674538453-12998-1-git-send-email-dai.ngo@oracle.com>
References: <1674538453-12998-1-git-send-email-dai.ngo@oracle.com>
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

On Mon, 2023-01-23 at 21:34 -0800, Dai Ngo wrote:
> The reference count of nfsd4_ssc_umount_item is not decremented
> on error conditions. This prevents the laundromat from unmounting
> the vfsmount of the source file.
>=20
> This patch decrements the reference count of nfsd4_ssc_umount_item
> on error.
>=20
> Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-ser=
ver copy completed.")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index b4e7e18e1761..889b603619c3 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1821,13 +1821,17 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>  out:
>  	return status;
>  out_err:
> +	if (nfsd4_ssc_is_inter(copy)) {
> +		/*
> +		 * Source's vfsmount of inter-copy will be unmounted
> +		 * by the laundromat. Use copy instead of async_copy
> +		 * since async_copy->ss_nsui might not be set yet.
> +	 	*/
> +		refcount_dec(&copy->ss_nsui->nsui_refcnt);
> +	}
>  	if (async_copy)
>  		cleanup_async_copy(async_copy);
>  	status =3D nfserrno(-ENOMEM);
> -	/*
> -	 * source's vfsmount of inter-copy will be unmounted
> -	 * by the laundromat
> -	 */
>  	goto out;
>  }
> =20

Looks good.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
