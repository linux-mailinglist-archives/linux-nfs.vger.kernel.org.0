Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A674D711
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGJNKS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 09:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGJNKQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 09:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B7E51
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 06:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 899D560FF6
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 13:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90635C433C8;
        Mon, 10 Jul 2023 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688994582;
        bh=OAtY3MYFuVxHH1+Xt6ORRX62N1voveGs8six3lHGqTY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bzD/ijxZUX+i0g/zdyPZWjnoZ6jU1tSAXcfoPNH1356/gOLep6tgk8Fk1nmFdrDbv
         C0on351wrYw2Wwp9scwOQRi2PDEvwvo2kLLdS/2w4r5FdvOh81+Ad/31DdB7umcyWO
         3OwLpDlVCEdlsl4AQ5hqpB6GgKoRIGAEVSksMusaaG++cjk1eHYo0bk3T6CuuhQ3Qy
         JnTf8hqJqM1sTGpF3mv6AZJYjoFSn82dzzvsBtsKZa+MGSJrFVmIhG47SlyqxBNsqq
         7l+zJSaKGoJrfcky68eren4x2dHk7SPi6mD0CEX+VS/jNOa7KyQr3aXvoKNK6v4rkH
         7ZV81BdwmIA5g==
Message-ID: <0ad01b423530a0aaef70a847dd82e9fca88daed5.camel@kernel.org>
Subject: Re: [PATCH v1 1/6] NFSD: Refactor nfsd_reply_cache_free_locked()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 10 Jul 2023 09:09:41 -0400
In-Reply-To: <168891751661.3964.5239269567232450425.stgit@manet.1015granger.net>
References: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
         <168891751661.3964.5239269567232450425.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-07-09 at 11:45 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> To reduce contention on the bucket locks, we must avoid calling
> kfree() while each bucket lock is held.
>=20
> Start by refactoring nfsd_reply_cache_free_locked() into a helper
> that removes an entry from the bucket (and must therefore run under
> the lock) and a second helper that frees the entry (which does not
> need to hold the lock).
>=20
> For readability, rename the helpers nfsd_cacherep_<verb>.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfscache.c |   26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index a8eda1c85829..601298b7f75f 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -110,21 +110,32 @@ nfsd_reply_cache_alloc(struct svc_rqst *rqstp, __ws=
um csum,
>  	return rp;
>  }
> =20
> +static void nfsd_cacherep_free(struct svc_cacherep *rp)
> +{
> +	kfree(rp->c_replvec.iov_base);
> +	kmem_cache_free(drc_slab, rp);
> +}
> +
>  static void
> -nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cache=
rep *rp,
> -				struct nfsd_net *nn)
> +nfsd_cacherep_unlink_locked(struct nfsd_net *nn, struct nfsd_drc_bucket =
*b,
> +			    struct svc_cacherep *rp)
>  {
> -	if (rp->c_type =3D=3D RC_REPLBUFF && rp->c_replvec.iov_base) {
> +	if (rp->c_type =3D=3D RC_REPLBUFF && rp->c_replvec.iov_base)
>  		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
> -		kfree(rp->c_replvec.iov_base);
> -	}
>  	if (rp->c_state !=3D RC_UNUSED) {
>  		rb_erase(&rp->c_node, &b->rb_head);
>  		list_del(&rp->c_lru);
>  		atomic_dec(&nn->num_drc_entries);
>  		nfsd_stats_drc_mem_usage_sub(nn, sizeof(*rp));
>  	}
> -	kmem_cache_free(drc_slab, rp);
> +}
> +
> +static void
> +nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cache=
rep *rp,
> +				struct nfsd_net *nn)
> +{
> +	nfsd_cacherep_unlink_locked(nn, b, rp);
> +	nfsd_cacherep_free(rp);
>  }
> =20
>  static void
> @@ -132,8 +143,9 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, stru=
ct svc_cacherep *rp,
>  			struct nfsd_net *nn)
>  {
>  	spin_lock(&b->cache_lock);
> -	nfsd_reply_cache_free_locked(b, rp, nn);
> +	nfsd_cacherep_unlink_locked(nn, b, rp);
>  	spin_unlock(&b->cache_lock);
> +	nfsd_cacherep_free(rp);
>  }
> =20
>  int nfsd_drc_slab_create(void)
>=20
>=20

Seems straightforward. I do question whether this will make any
different for performance, but it's unlikely to hurt anything, and it's
nice to separate the "unlink" and "free" functions.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
