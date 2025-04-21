Return-Path: <linux-nfs+bounces-11201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC15A950C2
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E471D3B36D9
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC2926462B;
	Mon, 21 Apr 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOz4AUb8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D2D26462E
	for <linux-nfs@vger.kernel.org>; Mon, 21 Apr 2025 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745237992; cv=none; b=Vp4QKC7cUt4XRNkIwsOVByKczUqfTTVypzgm5ElXh8FEVNbvajMKK1Tzo73yxs1HUJ3Is7Rke6cL80aUXVAzSFhaHFgvGzT4QEWEOaC8DELFUZip2esU+t9EobX1bsTU21I2v8gJTdPjVckGoYrvDqhSAnGNaJxEd/CpSPiqYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745237992; c=relaxed/simple;
	bh=3WXQwHetCzvpTvunxuXtwwTlyHhRUHSOawU70PTDMwA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ayP4SnHJb4zpbbeU0AB2vW80C/srqyzH2AYn0Q7fOwf9E0KeXL4k9AZLyzsz0M/n3Afx16cHJVjZ2D2IhYiYURFN0CKFYSiWZh/kTkt2Kb1U9gnOM5lDjXI7sGzNTejzjMaF99+2fAOqMYpldX2rI6DjwpPaX8jHR1EdoiGvnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOz4AUb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4646C4CEE4;
	Mon, 21 Apr 2025 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745237991;
	bh=3WXQwHetCzvpTvunxuXtwwTlyHhRUHSOawU70PTDMwA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VOz4AUb8scDOulPn75K6FAvdflF4o++8DXit9PA4+ssr2I/YZ5sbgekxpQgKVqyuR
	 TcJSiHMCO9/mVa5S7aCn/ba+D9hCC7lwEHsqq251T72PgQuBW87VWLJOBMoFoBLL/z
	 bDwk/BpsRPjCHhRc4HqqA/eC3YEXKJfoMxemkrX7tyiRLoj5L4QaLuo6jbqZ3VE8dy
	 4epKUQyjBgFvIoH8BGmFLaZmQowD1w9jWnbX/hrLcxN4i+kRVmlJz/qZ7oU4FeBHhJ
	 lEIa+n6Qy3L7c8L5xfD+//LMbUl036ul9eNyUzELJutDUbFOjD+TdPU1IUeQdyBFyI
	 pQcuxo+IYc3yw==
Message-ID: <8c89fc483efdb0b5eab660781416cba500e54b64.camel@kernel.org>
Subject: Re: [PATCH v2 03/10] sunrpc: Replace the rq_pages array with
 dynamically-allocated memory
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, NeilBrown <neil@brown.name>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Mon, 21 Apr 2025 08:19:49 -0400
In-Reply-To: <20250419172818.6945-4-cel@kernel.org>
References: <20250419172818.6945-1-cel@kernel.org>
	 <20250419172818.6945-4-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-04-19 at 13:28 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> As a step towards making NFSD's maximum rsize and wsize variable at
> run-time, replace the fixed-size rq_vec[] array in struct svc_rqst
> with a chunk of dynamically-allocated memory.
>=20
> On a system with 8-byte pointers and 4KB pages, pahole reports that
> the rq_pages[] array is 2080 bytes. Replacing it with a single
> pointer reduces the size of struct svc_rqst to just over 9500 bytes.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h        |  3 ++-
>  net/sunrpc/svc.c                  | 34 ++++++++++++++++++-------------
>  net/sunrpc/svc_xprt.c             | 10 +--------
>  net/sunrpc/xprtrdma/svc_rdma_rw.c |  2 +-
>  4 files changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 5b879c31d7b8..96ac12dbb04d 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -200,7 +200,8 @@ struct svc_rqst {
>  	struct xdr_stream	rq_res_stream;
>  	struct page		*rq_scratch_page;
>  	struct xdr_buf		rq_res;
> -	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
> +	unsigned long		rq_maxpages;	/* num of entries in rq_pages */
> +	struct page *		*rq_pages;
>  	struct page *		*rq_respages;	/* points into rq_pages */
>  	struct page *		*rq_next_page; /* next reply page to use */
>  	struct page *		*rq_page_end;  /* one past the last page */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 8ce3e6b3df6a..682e11c9be36 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -636,20 +636,25 @@ svc_destroy(struct svc_serv **servp)
>  EXPORT_SYMBOL_GPL(svc_destroy);
> =20
>  static bool
> -svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
> +svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int=
 node)
>  {
> -	unsigned long pages, ret;
> +	unsigned long ret;
> =20
> -	pages =3D size / PAGE_SIZE + 1; /* extra page as we hold both request a=
nd reply.
> -				       * We assume one is at most one page
> -				       */
> -	WARN_ON_ONCE(pages > RPCSVC_MAXPAGES);
> -	if (pages > RPCSVC_MAXPAGES)
> -		pages =3D RPCSVC_MAXPAGES;
> +	/* Add an extra page, as rq_pages holds both request and reply.
> +	 * We assume one of those is at most one page.
> +	 */
> +	rqstp->rq_maxpages =3D svc_serv_maxpages(serv) + 1;
> =20
> -	ret =3D alloc_pages_bulk_node(GFP_KERNEL, node, pages,
> +	/* rq_pages' last entry is NULL for historical reasons. */
> +	rqstp->rq_pages =3D kcalloc_node(rqstp->rq_maxpages + 1,
> +				       sizeof(struct page *),
> +				       GFP_KERNEL, node);
> +	if (!rqstp->rq_pages)
> +		return false;
> +
> +	ret =3D alloc_pages_bulk_node(GFP_KERNEL, node, rqstp->rq_maxpages,
>  				    rqstp->rq_pages);
> -	return ret =3D=3D pages;
> +	return ret =3D=3D rqstp->rq_maxpages;
>  }
> =20
>  /*
> @@ -658,11 +663,12 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned in=
t size, int node)
>  static void
>  svc_release_buffer(struct svc_rqst *rqstp)
>  {
> -	unsigned int i;
> +	unsigned long i;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(rqstp->rq_pages); i++)
> +	for (i =3D 0; i < rqstp->rq_maxpages; i++)
>  		if (rqstp->rq_pages[i])
>  			put_page(rqstp->rq_pages[i]);
> +	kfree(rqstp->rq_pages);
>  }
> =20
>  static void
> @@ -704,7 +710,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_=
pool *pool, int node)
>  	if (!rqstp->rq_resp)
>  		goto out_enomem;
> =20
> -	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
> +	if (!svc_init_buffer(rqstp, serv, node))
>  		goto out_enomem;
> =20
>  	rqstp->rq_err =3D -EAGAIN; /* No error yet */
> @@ -896,7 +902,7 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
>  bool svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
>  {
>  	struct page **begin =3D rqstp->rq_pages;
> -	struct page **end =3D &rqstp->rq_pages[RPCSVC_MAXPAGES];
> +	struct page **end =3D &rqstp->rq_pages[rqstp->rq_maxpages];
> =20
>  	if (unlikely(rqstp->rq_next_page < begin || rqstp->rq_next_page > end))=
 {
>  		trace_svc_replace_page_err(rqstp);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index ae25405d8bd2..23547ed25269 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -651,18 +651,10 @@ static void svc_check_conn_limits(struct svc_serv *=
serv)
> =20
>  static bool svc_alloc_arg(struct svc_rqst *rqstp)
>  {
> -	struct svc_serv *serv =3D rqstp->rq_server;
>  	struct xdr_buf *arg =3D &rqstp->rq_arg;
>  	unsigned long pages, filled, ret;
> =20
> -	pages =3D (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
> -	if (pages > RPCSVC_MAXPAGES) {
> -		pr_warn_once("svc: warning: pages=3D%lu > RPCSVC_MAXPAGES=3D%lu\n",
> -			     pages, RPCSVC_MAXPAGES);
> -		/* use as many pages as possible */
> -		pages =3D RPCSVC_MAXPAGES;
> -	}
> -
> +	pages =3D rqstp->rq_maxpages;
>  	for (filled =3D 0; filled < pages; filled =3D ret) {
>  		ret =3D alloc_pages_bulk(GFP_KERNEL, pages, rqstp->rq_pages);
>  		if (ret > filled)
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_=
rdma_rw.c
> index 40797114d50a..661b3fe2779f 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -765,7 +765,7 @@ static int svc_rdma_build_read_segment(struct svc_rqs=
t *rqstp,
>  		}
>  		len -=3D seg_len;
> =20
> -		if (len && ((head->rc_curpage + 1) > ARRAY_SIZE(rqstp->rq_pages)))
> +		if (len && ((head->rc_curpage + 1) > rqstp->rq_maxpages))
>  			goto out_overrun;
>  	}
> =20

nit: I'd probably squash 2 and 3 together, but they both look right:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

