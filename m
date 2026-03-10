Return-Path: <linux-nfs+bounces-19999-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHGCAStfsGloigIAu9opvQ
	(envelope-from <linux-nfs+bounces-19999-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 19:12:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC8256368
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 19:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E2B31FEC2E
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2026 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9C3D8121;
	Tue, 10 Mar 2026 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAJMjWdM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A33D6CBC
	for <linux-nfs@vger.kernel.org>; Tue, 10 Mar 2026 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166234; cv=none; b=QpM7n0+CDcAe11P0p/wobk6kJaq8PYdl5U8/EoTKyNNNUBlmFm1Ym9pqKw53FknKF3V11If5R53ErAFJzqzWknjLr3d2lb58dzvg7xUoY4cdL+1w2jo+eEQWFqnBvDdTbi6Qy3SqYE+2jBxw5aLovwo//j8aVzf526pcGgU8h90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166234; c=relaxed/simple;
	bh=BmH67XWYdPtmy9IG4Be2KysRrW4+yoJcDqXVqDrT7KM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAZD32mR84XDQK88Sk4XQwBA0jS/U5BOuJUqhBGzbGEXA10oJKcCmNzG21qhg357ffS7jUe4PgRJuZR1FgmQxjzc+3yVVnP5EXgEloZ9SNFSfayjXyZpvGo0Qqnuv/L+0dS05/txC3PL+PJ+/80BisKDqWzcAu595tVIVyagIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAJMjWdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A445DC19423;
	Tue, 10 Mar 2026 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773166234;
	bh=BmH67XWYdPtmy9IG4Be2KysRrW4+yoJcDqXVqDrT7KM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EAJMjWdMgqblIwuC/ZcI612h0AyB66iYxpoZRaXCm6N3upM3UBz1n3OTuselLI7po
	 IyVTuWijr+++CBxdbYOf9i1tlrFE2kRRKX8/yeqOXTuCLhpADHbFUAdmGTLVOcxcSv
	 ehDuVj/W/tXyRk0Gza/5NQXaB/6UHTIMJbJRLtlYvpNRf+ky15djgtp04d8QXyFvPy
	 QwqnbMNkHzmFulil6HBAmhyYQn4RtbrjDFpE3Gwb9Ca6PGkQ6ytecar4/NgYJnyXJS
	 wTsXj5PgoOMtVVKYuz1BlS4OOlwEWWWr3lJiogpjU/YS3TJGnCwipe0cQPhjgV6yYj
	 ATQQDnk51r48Q==
Message-ID: <62a4f9b39151023c9afe4c7a8a0e7570d49147c4.camel@kernel.org>
Subject: Re: [PATCH v2 2/6] SUNRPC: Allocate a separate Reply page array
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 10 Mar 2026 14:10:31 -0400
In-Reply-To: <20260226144739.193129-3-cel@kernel.org>
References: <20260226144739.193129-1-cel@kernel.org>
	 <20260226144739.193129-3-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 26BC8256368
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19999-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 09:47 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> struct svc_rqst uses a single dynamically-allocated page array
> (rq_pages) for both the incoming RPC Call message and the outgoing
> RPC Reply message. rq_respages is a sliding pointer into rq_pages
> that each transport receive path must compute based on how many
> pages the Call consumed. This boundary tracking is a source of
> confusion and bugs, and prevents an RPC transaction from having
> both a large Call and a large Reply simultaneously.
>=20
> Allocate rq_respages as its own page array, eliminating the boundary
> arithmetic. This decouples Call and Reply buffer lifetimes,
> following the precedent set by rq_bvec (a separate dynamically-
> allocated array for I/O vectors).
>=20
> Each svc_rqst now pins twice as many pages as before. For a server
> running 16 threads with a 1MB maximum payload, the additional cost
> is roughly 16MB of pinned memory. The new dynamic svc thread count
> facility keeps this overhead minimal on an idle server. A subsequent
> patch in this series limits per-request repopulation to only the
> pages released during the previous RPC, avoiding a full-array scan
> on each call to svc_alloc_arg().
>=20
> Note: We've considered several alternatives to maintaining a full
> second array. Each alternative reintroduces either boundary logic
> complexity or I/O-path allocation pressure.
>=20
> rq_next_page is initialized in svc_alloc_arg() and svc_process()
> during Reply construction, and in svc_rdma_recvfrom() as a
> precaution on error paths. Transport receive paths no longer compute
> it from the Call size.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h              | 47 ++++++++++++-------------
>  net/sunrpc/svc.c                        | 29 ++++++++++++---
>  net/sunrpc/svc_xprt.c                   | 36 +++++++++++++------
>  net/sunrpc/svcsock.c                    |  6 ----
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 15 +++-----
>  5 files changed, 77 insertions(+), 56 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 4dc14c7a711b..3559de664f64 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -134,25 +134,24 @@ enum {
>  extern u32 svc_max_payload(const struct svc_rqst *rqstp);
> =20
>  /*
> - * RPC Requests and replies are stored in one or more pages.
> - * We maintain an array of pages for each server thread.
> - * Requests are copied into these pages as they arrive.  Remaining
> - * pages are available to write the reply into.
> + * RPC Call and Reply messages each have their own page array.
> + * rq_pages holds the incoming Call message; rq_respages holds
> + * the outgoing Reply message. Both arrays are sized to
> + * svc_serv_maxpages() entries and are allocated dynamically.
>   *
> - * Pages are sent using ->sendmsg with MSG_SPLICE_PAGES so each server t=
hread
> - * needs to allocate more to replace those used in sending.  To help kee=
p track
> - * of these pages we have a receive list where all pages initialy live, =
and a
> - * send list where pages are moved to when there are to be part of a rep=
ly.
> + * Pages are sent using ->sendmsg with MSG_SPLICE_PAGES so each
> + * server thread needs to allocate more to replace those used in
> + * sending.
>   *
> - * We use xdr_buf for holding responses as it fits well with NFS
> - * read responses (that have a header, and some data pages, and possibly
> - * a tail) and means we can share some client side routines.
> + * xdr_buf holds responses; the structure fits NFS read responses
> + * (header, data pages, optional tail) and enables sharing of
> + * client-side routines.
>   *
> - * The xdr_buf.head kvec always points to the first page in the rq_*page=
s
> - * list.  The xdr_buf.pages pointer points to the second page on that
> - * list.  xdr_buf.tail points to the end of the first page.
> - * This assumes that the non-page part of an rpc reply will fit
> - * in a page - NFSd ensures this.  lockd also has no trouble.
> + * The xdr_buf.head kvec always points to the first page in the
> + * rq_*pages list. The xdr_buf.pages pointer points to the second
> + * page on that list. xdr_buf.tail points to the end of the first
> + * page. This assumes that the non-page part of an rpc reply will
> + * fit in a page - NFSd ensures this. lockd also has no trouble.
>   */
> =20
>  /**
> @@ -162,10 +161,10 @@ extern u32 svc_max_payload(const struct svc_rqst *r=
qstp);
>   * Returns a count of pages or vectors that can hold the maximum
>   * size RPC message for @serv.
>   *
> - * Each request/reply pair can have at most one "payload", plus two
> - * pages, one for the request, and one for the reply.
> - * nfsd_splice_actor() might need an extra page when a READ payload
> - * is not page-aligned.
> + * Each page array can hold at most one payload plus two
> + * overhead pages (one for the RPC header, one for tail data).

This is worded a little awkwardly. It sounds sort of like you can only
have a single payload page. Maybe:

"Each page array can hold a set of pages for the payload, plus two
overhead pages..."

> + * nfsd_splice_actor() might need an extra page when a READ
> + * payload is not page-aligned.
>   */
>  static inline unsigned long svc_serv_maxpages(const struct svc_serv *ser=
v)
>  {
> @@ -201,11 +200,11 @@ struct svc_rqst {
>  	struct xdr_stream	rq_res_stream;
>  	struct folio		*rq_scratch_folio;
>  	struct xdr_buf		rq_res;
> -	unsigned long		rq_maxpages;	/* num of entries in rq_pages */
> -	struct page *		*rq_pages;
> -	struct page *		*rq_respages;	/* points into rq_pages */
> +	unsigned long		rq_maxpages;	/* entries per page array */
> +	struct page *		*rq_pages;	/* Call buffer pages */
> +	struct page *		*rq_respages;	/* Reply buffer pages */
>  	struct page *		*rq_next_page; /* next reply page to use */
> -	struct page *		*rq_page_end;  /* one past the last page */
> +	struct page *		*rq_page_end;  /* one past the last reply page */
> =20
>  	struct folio_batch	rq_fbatch;
>  	struct bio_vec		*rq_bvec;
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index f7ec02457328..9abef638b1e0 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -638,13 +638,23 @@ svc_init_buffer(struct svc_rqst *rqstp, const struc=
t svc_serv *serv, int node)
>  {
>  	rqstp->rq_maxpages =3D svc_serv_maxpages(serv);
> =20
> -	/* rq_pages' last entry is NULL for historical reasons. */
> +	/* +1 for a NULL sentinel readable by nfsd_splice_actor() */
>  	rqstp->rq_pages =3D kcalloc_node(rqstp->rq_maxpages + 1,
>  				       sizeof(struct page *),
>  				       GFP_KERNEL, node);
>  	if (!rqstp->rq_pages)
>  		return false;
> =20
> +	/* +1 for a NULL sentinel at rq_page_end (see svc_rqst_replace_page) */
> +	rqstp->rq_respages =3D kcalloc_node(rqstp->rq_maxpages + 1,
> +					  sizeof(struct page *),
> +					  GFP_KERNEL, node);
> +	if (!rqstp->rq_respages) {
> +		kfree(rqstp->rq_pages);
> +		rqstp->rq_pages =3D NULL;
> +		return false;
> +	}
> +
>  	return true;
>  }
> =20
> @@ -656,10 +666,19 @@ svc_release_buffer(struct svc_rqst *rqstp)
>  {
>  	unsigned long i;
> =20
> -	for (i =3D 0; i < rqstp->rq_maxpages; i++)
> -		if (rqstp->rq_pages[i])
> -			put_page(rqstp->rq_pages[i]);
> -	kfree(rqstp->rq_pages);
> +	if (rqstp->rq_pages) {
> +		for (i =3D 0; i < rqstp->rq_maxpages; i++)
> +			if (rqstp->rq_pages[i])
> +				put_page(rqstp->rq_pages[i]);
> +		kfree(rqstp->rq_pages);
> +	}
> +
> +	if (rqstp->rq_respages) {
> +		for (i =3D 0; i < rqstp->rq_maxpages; i++)
> +			if (rqstp->rq_respages[i])
> +				put_page(rqstp->rq_respages[i]);
> +		kfree(rqstp->rq_respages);
> +	}
>  }
> =20
>  static void
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 56a663b8939f..e027765f4307 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -650,14 +650,13 @@ static void svc_check_conn_limits(struct svc_serv *=
serv)
>  	}
>  }
> =20
> -static bool svc_alloc_arg(struct svc_rqst *rqstp)
> +static bool svc_fill_pages(struct svc_rqst *rqstp, struct page **pages,
> +			   unsigned long npages)
>  {
> -	struct xdr_buf *arg =3D &rqstp->rq_arg;
> -	unsigned long pages, filled, ret;
> +	unsigned long filled, ret;
> =20
> -	pages =3D rqstp->rq_maxpages;
> -	for (filled =3D 0; filled < pages; filled =3D ret) {
> -		ret =3D alloc_pages_bulk(GFP_KERNEL, pages, rqstp->rq_pages);
> +	for (filled =3D 0; filled < npages; filled =3D ret) {
> +		ret =3D alloc_pages_bulk(GFP_KERNEL, npages, pages);
>  		if (ret > filled)
>  			/* Made progress, don't sleep yet */
>  			continue;
> @@ -667,11 +666,29 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
>  			set_current_state(TASK_RUNNING);
>  			return false;
>  		}
> -		trace_svc_alloc_arg_err(pages, ret);
> +		trace_svc_alloc_arg_err(npages, ret);
>  		memalloc_retry_wait(GFP_KERNEL);
>  	}
> -	rqstp->rq_page_end =3D &rqstp->rq_pages[pages];
> -	rqstp->rq_pages[pages] =3D NULL; /* this might be seen in nfsd_splice_a=
ctor() */
> +	return true;
> +}
> +
> +static bool svc_alloc_arg(struct svc_rqst *rqstp)
> +{
> +	struct xdr_buf *arg =3D &rqstp->rq_arg;
> +	unsigned long pages;
> +
> +	pages =3D rqstp->rq_maxpages;
> +
> +	if (!svc_fill_pages(rqstp, rqstp->rq_pages, pages))
> +		return false;
> +	if (!svc_fill_pages(rqstp, rqstp->rq_respages, pages))
> +		return false;
> +	rqstp->rq_next_page =3D rqstp->rq_respages;
> +	rqstp->rq_page_end =3D &rqstp->rq_respages[pages];
> +	/* svc_rqst_replace_page() dereferences *rq_next_page even
> +	 * at rq_page_end; NULL prevents releasing a garbage page.
> +	 */
> +	rqstp->rq_page_end[0] =3D NULL;
> =20
>  	/* Make arg->head point to first page and arg->pages point to rest */
>  	arg->head[0].iov_base =3D page_address(rqstp->rq_pages[0]);
> @@ -1277,7 +1294,6 @@ static noinline int svc_deferred_recv(struct svc_rq=
st *rqstp)
>  	rqstp->rq_addrlen     =3D dr->addrlen;
>  	/* Save off transport header len in case we get deferred again */
>  	rqstp->rq_daddr       =3D dr->daddr;
> -	rqstp->rq_respages    =3D rqstp->rq_pages;
>  	rqstp->rq_xprt_ctxt   =3D dr->xprt_ctxt;
> =20
>  	dr->xprt_ctxt =3D NULL;
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index f28c6076f7e8..c86f28f720f7 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -351,8 +351,6 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqst=
p, size_t buflen,
> =20
>  	for (i =3D 0, t =3D 0; t < buflen; i++, t +=3D PAGE_SIZE)
>  		bvec_set_page(&bvec[i], rqstp->rq_pages[i], PAGE_SIZE, 0);
> -	rqstp->rq_respages =3D &rqstp->rq_pages[i];
> -	rqstp->rq_next_page =3D rqstp->rq_respages + 1;
> =20
>  	iov_iter_bvec(&msg.msg_iter, ITER_DEST, bvec, i, buflen);
>  	if (seek) {
> @@ -677,13 +675,9 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
>  	if (len <=3D rqstp->rq_arg.head[0].iov_len) {
>  		rqstp->rq_arg.head[0].iov_len =3D len;
>  		rqstp->rq_arg.page_len =3D 0;
> -		rqstp->rq_respages =3D rqstp->rq_pages+1;
>  	} else {
>  		rqstp->rq_arg.page_len =3D len - rqstp->rq_arg.head[0].iov_len;
> -		rqstp->rq_respages =3D rqstp->rq_pages + 1 +
> -			DIV_ROUND_UP(rqstp->rq_arg.page_len, PAGE_SIZE);
>  	}
> -	rqstp->rq_next_page =3D rqstp->rq_respages+1;
> =20
>  	if (serv->sv_stats)
>  		serv->sv_stats->netudpcnt++;
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdm=
a/svc_rdma_recvfrom.c
> index e7e4a39ca6c6..3081a37a5896 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -861,18 +861,12 @@ static noinline void svc_rdma_read_complete(struct =
svc_rqst *rqstp,
>  	unsigned int i;
> =20
>  	/* Transfer the Read chunk pages into @rqstp.rq_pages, replacing
> -	 * the rq_pages that were already allocated for this rqstp.
> +	 * the receive buffer pages already allocated for this rqstp.
>  	 */
> -	release_pages(rqstp->rq_respages, ctxt->rc_page_count);
> +	release_pages(rqstp->rq_pages, ctxt->rc_page_count);
>  	for (i =3D 0; i < ctxt->rc_page_count; i++)
>  		rqstp->rq_pages[i] =3D ctxt->rc_pages[i];
> =20
> -	/* Update @rqstp's result send buffer to start after the
> -	 * last page in the RDMA Read payload.
> -	 */
> -	rqstp->rq_respages =3D &rqstp->rq_pages[ctxt->rc_page_count];
> -	rqstp->rq_next_page =3D rqstp->rq_respages + 1;
> -
>  	/* Prevent svc_rdma_recv_ctxt_put() from releasing the
>  	 * pages in ctxt::rc_pages a second time.
>  	 */
> @@ -931,10 +925,9 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
>  	struct svc_rdma_recv_ctxt *ctxt;
>  	int ret;
> =20
> -	/* Prevent svc_xprt_release() from releasing pages in rq_pages
> -	 * when returning 0 or an error.
> +	/* Precaution: a zero page count on error return causes
> +	 * svc_rqst_release_pages() to release nothing.
>  	 */
> -	rqstp->rq_respages =3D rqstp->rq_pages;
>  	rqstp->rq_next_page =3D rqstp->rq_respages;
> =20
>  	rqstp->rq_xprt_ctxt =3D NULL;

The rest looks good to me though:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

