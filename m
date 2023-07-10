Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E6874D73B
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGJNRV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 09:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJNRV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 09:17:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7B9D
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 06:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF4DB60DED
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 13:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD324C433C7;
        Mon, 10 Jul 2023 13:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688995039;
        bh=9hRyMLUqX1CcBwZRBl7veiTRJ77kkvU9rnd4oAzVkSo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dGwEaFjSOiaOhepviUXMnjG2H7bJJn4Ia0Qpx/EcHLe3vxYYS46CWCRH5dhP7iVBs
         QrkdwOEVDEb2yv6o3SK4UCepbc98Rmf/X2v0uDfcgXa+x6qhuIC97Cb1ykWlG44aXU
         m8xb09v2+80D8zx9LZuerBaBChjBKY0Atf1r9xloZyK5pVAPDE3177a+ZEprMAcezi
         3GcrUquc8cqe/eWO2xibh1nYJxNQBLX3UuZaK3yUNEm3miMMPp1TvrhZFfGpYaoRbM
         Uu1zl88/V640Fx9amRgjZ1QRYDPshuE5thHpjtJH+oyB216eqAKG7x79FGvW3H8DJe
         utDX/f2K6HECw==
Message-ID: <b4ff381078043073675181668b819be36e29bdf1.camel@kernel.org>
Subject: Re: [PATCH v1 5/6] NFSD: Remove svc_rqst::rq_cacherep
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 10 Jul 2023 09:17:17 -0400
In-Reply-To: <168891754187.3964.10104099550029601077.stgit@manet.1015granger.net>
References: <168891733570.3964.15456501153247760888.stgit@manet.1015granger.net>
         <168891754187.3964.10104099550029601077.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-07-09 at 11:45 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Over time I'd like to see NFS-specific fields moved out of struct
> svc_rqst, which is an RPC layer object. These fields are layering
> violations.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/cache.h            |    6 ++++--
>  fs/nfsd/nfscache.c         |   11 ++++++-----
>  fs/nfsd/nfssvc.c           |   10 ++++++----
>  include/linux/sunrpc/svc.h |    1 -
>  4 files changed, 16 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
> index 4c9b87850ab1..27610b071880 100644
> --- a/fs/nfsd/cache.h
> +++ b/fs/nfsd/cache.h
> @@ -84,8 +84,10 @@ int	nfsd_net_reply_cache_init(struct nfsd_net *nn);
>  void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
>  int	nfsd_reply_cache_init(struct nfsd_net *);
>  void	nfsd_reply_cache_shutdown(struct nfsd_net *);
> -int	nfsd_cache_lookup(struct svc_rqst *);
> -void	nfsd_cache_update(struct svc_rqst *, int, __be32 *);
> +int	nfsd_cache_lookup(struct svc_rqst *rqstp,
> +			  struct svc_cacherep **cacherep);
> +void	nfsd_cache_update(struct svc_rqst *rqstp, struct svc_cacherep *rp,
> +			  int cachetype, __be32 *statp);
>  int	nfsd_reply_cache_stats_show(struct seq_file *m, void *v);
> =20
>  #endif /* NFSCACHE_H */
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index c08078ac9284..9bdcd73206c9 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -464,6 +464,7 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct s=
vc_cacherep *key,
>  /**
>   * nfsd_cache_lookup - Find an entry in the duplicate reply cache
>   * @rqstp: Incoming Call to find
> + * @cacherep: OUT: DRC entry for this request
>   *
>   * Try to find an entry matching the current call in the cache. When non=
e
>   * is found, we try to grab the oldest expired entry off the LRU list. I=
f
> @@ -476,7 +477,7 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct s=
vc_cacherep *key,
>   *   %RC_REPLY: Reply from cache
>   *   %RC_DROPIT: Do not process the request further
>   */
> -int nfsd_cache_lookup(struct svc_rqst *rqstp)
> +int nfsd_cache_lookup(struct svc_rqst *rqstp, struct svc_cacherep **cach=
erep)
>  {
>  	struct nfsd_net		*nn;
>  	struct svc_cacherep	*rp, *found;
> @@ -487,7 +488,6 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
>  	LIST_HEAD(dispose);
>  	int rtn =3D RC_DOIT;
> =20
> -	rqstp->rq_cacherep =3D NULL;
>  	if (type =3D=3D RC_NOCACHE) {
>  		nfsd_stats_rc_nocache_inc();
>  		goto out;
> @@ -509,7 +509,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
>  	found =3D nfsd_cache_insert(b, rp, nn);
>  	if (found !=3D rp)
>  		goto found_entry;
> -	rqstp->rq_cacherep =3D rp;
> +	*cacherep =3D rp;
>  	rp->c_state =3D RC_INPROG;
>  	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
>  	spin_unlock(&b->cache_lock);
> @@ -567,6 +567,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
>  /**
>   * nfsd_cache_update - Update an entry in the duplicate reply cache.
>   * @rqstp: svc_rqst with a finished Reply
> + * @rp: IN: DRC entry for this request
>   * @cachetype: which cache to update
>   * @statp: pointer to Reply's NFS status code, or NULL
>   *
> @@ -584,10 +585,10 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
>   * nfsd failed to encode a reply that otherwise would have been cached.
>   * In this case, nfsd_cache_update is called with statp =3D=3D NULL.
>   */
> -void nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *st=
atp)
> +void nfsd_cache_update(struct svc_rqst *rqstp, struct svc_cacherep *rp,
> +		       int cachetype, __be32 *statp)
>  {
>  	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> -	struct svc_cacherep *rp =3D rqstp->rq_cacherep;
>  	struct kvec	*resv =3D &rqstp->rq_res.head[0], *cachv;
>  	struct nfsd_drc_bucket *b;
>  	int		len;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index d42b2a40c93c..64ac70990019 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1045,6 +1045,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  {
>  	const struct svc_procedure *proc =3D rqstp->rq_procinfo;
>  	__be32 *statp =3D rqstp->rq_accept_statp;
> +	struct svc_cacherep *rp;
> =20
>  	/*
>  	 * Give the xdr decoder a chance to change this if it wants
> @@ -1055,7 +1056,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
>  		goto out_decode_err;
> =20
> -	switch (nfsd_cache_lookup(rqstp)) {
> +	rp =3D NULL;
> +	switch (nfsd_cache_lookup(rqstp, &rp)) {
>  	case RC_DOIT:
>  		break;
>  	case RC_REPLY:
> @@ -1071,7 +1073,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>  		goto out_encode_err;
> =20
> -	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
> +	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
>  out_cached_reply:
>  	return 1;
> =20
> @@ -1081,13 +1083,13 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	return 1;
> =20
>  out_update_drop:
> -	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
> +	nfsd_cache_update(rqstp, rp, RC_NOCACHE, NULL);
>  out_dropit:
>  	return 0;
> =20
>  out_encode_err:
>  	trace_nfsd_cant_encode_err(rqstp);
> -	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
> +	nfsd_cache_update(rqstp, rp, RC_NOCACHE, NULL);
>  	*statp =3D rpc_system_err;
>  	return 1;
>  }
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 6669f3eb9ed4..604ca45af429 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -268,7 +268,6 @@ struct svc_rqst {
>  	/* Catering to nfsd */
>  	struct auth_domain *	rq_client;	/* RPC peer info */
>  	struct auth_domain *	rq_gssclient;	/* "gss/"-style peer info */
> -	struct svc_cacherep *	rq_cacherep;	/* cache info */
>  	struct task_struct	*rq_task;	/* service thread */
>  	struct net		*rq_bc_net;	/* pointer to backchannel's
>  						 * net namespace
>=20
>=20

Nice cleanup! One less layering violation.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
