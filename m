Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393C27E7FF4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjKJSC7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbjKJSCZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:02:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4159C38E86
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 07:32:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4B7C433C8;
        Fri, 10 Nov 2023 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699630346;
        bh=TEo/0wEMkDH/mhlkGRnTPKZ9Z4UAr1o0zXBlWKlqpBQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XiP6iis/pZRhhehmVVK2aax+KpX0IX1cLCS/dzKsqmkziXjmYo9XctCPI/1ZR70hN
         WcA7IvGOFyUGsZpkv4wusVHxSAnvRRjHMKlARftNglrh11n2+Tr0YgdnV7gjYjgkU9
         M2NMQu1rOWP8cQUb/c4vmf43y82w+bwBpLO+5t5+q9tuD71mThWs2WD6gkl3DzQP7g
         4r08GASswJThnxF9qYkUc99HLrJDybL6XgYnWb2NPp4Yx+b1CCKcd3lfQr3kFOnWSu
         DEzau9xiMHzx9e0vTV5TJaJms4luEY/zGj5SwkSrR0KAZ9QZDKODnjgZXNYkqOvqoL
         J5Tk3OBnSKGNQ==
Message-ID: <efdbd2d53c97d3482f8844ffc5cd9caee577a5f6.camel@kernel.org>
Subject: Re: [PATCH RFC] NFSD: Fix checksum mismatches in the duplicate
 reply cache
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 10 Nov 2023 10:32:24 -0500
In-Reply-To: <169953717421.7448.7269783258225907202.stgit@bazille.1015granger.net>
References: <169953717421.7448.7269783258225907202.stgit@bazille.1015granger.net>
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

On Thu, 2023-11-09 at 08:45 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> nfsd_cache_csum() currently assumes that the server's RPC layer has
> been advancing rq_arg.head[0].iov_base as it decodes an incoming
> request, because that's the way it used to work. On entry, it
> expects that buf->head[0].iov_base points to the start of the NFS
> header, and excludes the already-decoded RPC header.
>=20
> Ever since the RPC layer was converted over to use xdr_stream (in
> v6.3), however, head[0].iov_base now points to the start of the RPC
> header during all processing. It no longer points at the NFS Call
> header when execution arrives at nfsd_cache_csum().
>=20
> In a retransmitted RPC the XID and the NFS header are supposed to
> be the same as the original message, but the contents of the
> retransmitted RPC header can be different. For example, for krb5,
> the GSS sequence number will be different between the two. Thus if
> the RPC header is included in the DRC checksum computation, the
> checksum of the retransmitted message might not match the checksum
> of the original message, even though the NFS part of these messages
> is identical.
>=20
> If the DRC fails to recognize a retransmit, it permits the server to
> execute that RPC Call again. That breaks retransmits of idempotent
> procedures such as RENAME or REMOVE -- the retransmitted RPC Call
> will get a different result.
>=20
> Note that I am not marking this commit with a Fixes: tag:
>=20
>  o The RPC-related commits that broke the DRC are too numerous
>  o The fix should not be automatically backported, as any backport
>    of it needs to be thoroughly tested
>=20
> However, it might be appropriate to consider applying this fix to
> v6.3 and later kernels, if someone can make it fit cleanly and test
> it properly. This patch applies with fuzz to v6.6, but does not
> apply cleanly to earlier kernels.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/cache.h    |    4 ++--
>  fs/nfsd/nfscache.c |   55 +++++++++++++++++++++++++++++++++-------------=
------
>  fs/nfsd/nfssvc.c   |   10 +++++++++
>  3 files changed, 46 insertions(+), 23 deletions(-)
>=20
> This fix is kind of ugly. Looking for comments or suggestions for
> improvement. Two further clean-ups occurred to me:
>=20
>  - Set up a parms struct in nfsd_dispatch() that is passed to
>    nfsd_cache_lookup() and nfsd_cache_update() that carries all
>    of this extraneous garbage
>  - Move nfsd_cache_csum to net/sunrpc/xdr.c since it assumes
>    details about the how the message appears in the xdr_buf
>=20
>=20
> diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
> index 929248c6ca84..4cbe0434cbb8 100644
> --- a/fs/nfsd/cache.h
> +++ b/fs/nfsd/cache.h
> @@ -84,8 +84,8 @@ int	nfsd_net_reply_cache_init(struct nfsd_net *nn);
>  void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
>  int	nfsd_reply_cache_init(struct nfsd_net *);
>  void	nfsd_reply_cache_shutdown(struct nfsd_net *);
> -int	nfsd_cache_lookup(struct svc_rqst *rqstp,
> -			  struct nfsd_cacherep **cacherep);
> +int	nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
> +			  unsigned int len, struct nfsd_cacherep **cacherep);
>  void	nfsd_cache_update(struct svc_rqst *rqstp, struct nfsd_cacherep *rp,
>  			  int cachetype, __be32 *statp);
>  int	nfsd_reply_cache_stats_show(struct seq_file *m, void *v);
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index fd56a52aa5fb..761896c44e77 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -370,32 +370,44 @@ nfsd_reply_cache_scan(struct shrinker *shrink, stru=
ct shrink_control *sc)
>  }
> =20
>  /*
> - * Walk an xdr_buf and get a CRC for at most the first RC_CSUMLEN bytes
> + * Compute a weak checksum of the leading bytes of an NFS procedure
> + * call header. csum_partial() computes a TCP checksum as specified
> + * in RFC 793.
> + *
> + * To avoid assumptions about how the RPC message is laid out in
> + * @buf and what else it might contain (eg, a GSS MIC suffix), the
> + * caller passes the exact location and length of the NFS Call
> + * header.
>   */

Maybe make this a kerneldoc comment?

> -static __wsum
> -nfsd_cache_csum(struct svc_rqst *rqstp)
> +static __wsum nfsd_cache_csum(struct xdr_buf *buf, unsigned int start,
> +			      unsigned int remaining)
>  {
> +	unsigned int base, len;
> +	struct xdr_buf subbuf;
> +	__wsum csum =3D 0;
> +	void *p;
>  	int idx;
> -	unsigned int base;
> -	__wsum csum;
> -	struct xdr_buf *buf =3D &rqstp->rq_arg;
> -	const unsigned char *p =3D buf->head[0].iov_base;
> -	size_t csum_len =3D min_t(size_t, buf->head[0].iov_len + buf->page_len,
> -				RC_CSUMLEN);
> -	size_t len =3D min(buf->head[0].iov_len, csum_len);
> +
> +	if (remaining > RC_CSUMLEN)
> +		remaining =3D RC_CSUMLEN;
> +	if (xdr_buf_subsegment(buf, &subbuf, start, remaining))
> +		return csum;
> =20
>  	/* rq_arg.head first */
> -	csum =3D csum_partial(p, len, 0);
> -	csum_len -=3D len;
> +	if (subbuf.head[0].iov_len) {
> +		len =3D min_t(unsigned int, subbuf.head[0].iov_len, remaining);
> +		csum =3D csum_partial(subbuf.head[0].iov_base, len, csum);
> +		remaining -=3D len;
> +	}
> =20
>  	/* Continue into page array */
> -	idx =3D buf->page_base / PAGE_SIZE;
> -	base =3D buf->page_base & ~PAGE_MASK;
> -	while (csum_len) {
> -		p =3D page_address(buf->pages[idx]) + base;
> -		len =3D min_t(size_t, PAGE_SIZE - base, csum_len);
> +	idx =3D subbuf.page_base / PAGE_SIZE;
> +	base =3D subbuf.page_base & ~PAGE_MASK;
> +	while (remaining) {
> +		p =3D page_address(subbuf.pages[idx]) + base;
> +		len =3D min_t(unsigned int, PAGE_SIZE - base, remaining);
>  		csum =3D csum_partial(p, len, csum);
> -		csum_len -=3D len;
> +		remaining -=3D len;
>  		base =3D 0;
>  		++idx;
>  	}
> @@ -466,6 +478,8 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct n=
fsd_cacherep *key,
>  /**
>   * nfsd_cache_lookup - Find an entry in the duplicate reply cache
>   * @rqstp: Incoming Call to find
> + * @start: location in @rqstp->rq_arg of the NFS Call header
> + * @len: length of NFS Call header in bytes
>   * @cacherep: OUT: DRC entry for this request
>   *
>   * Try to find an entry matching the current call in the cache. When non=
e
> @@ -479,7 +493,8 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct n=
fsd_cacherep *key,
>   *   %RC_REPLY: Reply from cache
>   *   %RC_DROPIT: Do not process the request further
>   */
> -int nfsd_cache_lookup(struct svc_rqst *rqstp, struct nfsd_cacherep **cac=
herep)
> +int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
> +		      unsigned int len, struct nfsd_cacherep **cacherep)
>  {
>  	struct nfsd_net		*nn;
>  	struct nfsd_cacherep	*rp, *found;
> @@ -495,7 +510,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, struct =
nfsd_cacherep **cacherep)
>  		goto out;
>  	}
> =20
> -	csum =3D nfsd_cache_csum(rqstp);
> +	csum =3D nfsd_cache_csum(&rqstp->rq_arg, start, len);
> =20
>  	/*
>  	 * Since the common case is a cache miss followed by an insert,
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index ef126969a7ce..1d6e33c6c4fe 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -980,6 +980,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	const struct svc_procedure *proc =3D rqstp->rq_procinfo;
>  	__be32 *statp =3D rqstp->rq_accept_statp;
>  	struct nfsd_cacherep *rp;
> +	unsigned int start, len;
> =20
>  	/*
>  	 * Give the xdr decoder a chance to change this if it wants
> @@ -987,6 +988,13 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	 */
>  	rqstp->rq_cachetype =3D proc->pc_cachetype;
> =20
> +	/*
> +	 * ->pc_decode advances the argument stream past the NFS
> +	 * Call header, so grab the header's starting location and
> +	 * size now for the call to nfsd_cache_lookup().
> +	 */
> +	start =3D xdr_stream_pos(&rqstp->rq_arg_stream);
> +	len =3D xdr_stream_remaining(&rqstp->rq_arg_stream);
>  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
>  		goto out_decode_err;
> =20
> @@ -1000,7 +1008,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter |=
 1);
> =20
>  	rp =3D NULL;
> -	switch (nfsd_cache_lookup(rqstp, &rp)) {
> +	switch (nfsd_cache_lookup(rqstp, start, len, &rp)) {
>  	case RC_DOIT:
>  		break;
>  	case RC_REPLY:
>=20
>=20

This looks pretty reasonable to me, even if it is a bit ugly. Since the
need is nfsd-specific, passing down these values is preferable to adding
them to struct svc_rqst.
--=20
Jeff Layton <jlayton@kernel.org>
