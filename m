Return-Path: <linux-nfs+bounces-19103-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMUAOjScm2nI3QMAu9opvQ
	(envelope-from <linux-nfs+bounces-19103-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 01:15:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09223170E94
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 01:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D373D300622C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 00:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608533985;
	Mon, 23 Feb 2026 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eD+ErROk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="utI/wn6q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7779CD
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 00:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771805742; cv=none; b=c83SjDwi4WCB+5qrh7l1AHYy9NqHY4qmtz3Kes+DoNLb6QiQT43Wa5aXIWHewrBAanU0xpi3o5Fe7bB4ti4JvQmqaLsyTMZMCAeqFpWqoNw894vSK5FbO7VMr5aahOfu8w+jqnm2CQO37jix2Gs9E1GbZC0SrBK539UGaS6Ulds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771805742; c=relaxed/simple;
	bh=xVgIDe17MaTjYRAYGXkhlaZVKRxhBwy5PcGXYYHyWpE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=cRMPGSCjkEHx3heT+1unUm3q672cO7KVSxOKm3Q8QYAzvqrVUt+woGV6EG13X3koK4N9Kz5EX7Du1cvDZYdLWPK2I8bN8OSYdZSb909vPmc/BMatsCIFP6pJ6pFm+hRp6QrWZtSrpNhLchrcNwZYTrXMueIFf8EqZPsNQ0MvSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eD+ErROk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=utI/wn6q; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF60F1400043;
	Sun, 22 Feb 2026 19:15:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 22 Feb 2026 19:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771805738; x=1771892138; bh=9UbdpucYTpiKpXg21ZliqI+3aQNFDVOQmRd
	7kTYIZT8=; b=eD+ErROkZDkBOskJIYV4Ve7Cp2bfIC3FADMFs/LpvAmXJk4bERO
	FYs2m9sc6zKRnG1pbUIMq+sUW5MkyviN6qlXLT2x5/NK5/ZSfBQEIvDpX6sMdsgD
	8uNMFXc4M/UjisQyhecBOr4B0EHT2nboxDLFdPKHEQKJ1KhooDq6lghb1H6aLJbr
	smGjdcU6N+WC4EZbfEgUY4unPyOaw1+6PmhZB5021DOUaZl547pSwVf43ZHZLBwZ
	f2VwclkfPs9t0lScnoG40vx6DhaUxZHSO+ZdxuC+RDOUScVFin56T6YAg60/KsgX
	zCSlPu/p6wQ7hEv9S3Dg1bv1gYUoR8VRzVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771805738; x=
	1771892138; bh=9UbdpucYTpiKpXg21ZliqI+3aQNFDVOQmRd7kTYIZT8=; b=u
	tI/wn6qBpyq8kmiEQQoJXsSlle6biSG/gGuMEBVeytiUqeTay9rA2dLr99ckWY2V
	OXg33WfTa4kNI0JKM83t1Qs8ExWlYOyIExmTw+dFoeBSpwDYlb1luDsbvRl7cckj
	wVJw1vYh/M5lF+0ssClp6BvaeuMIeCydhf0XsUB46fPjlKld9cox/4j8l0bH3vXq
	KdilzFV7mL3wq8kUkX+GTgiHWc7qX2khV5tpA1fmQaUc+PYHIBrnZ8VP3TtObjiL
	BKiZzX3joQHPxvfZtsQ9yxLAqVjSDX1Hhg4Yu+tR7T83QSc0oL0Rdo+DZWH57WbQ
	j9m/QuWcqX/MJn8oLO/0Q==
X-ME-Sender: <xms:Kpybad-NqpKbR0ixY8221L7r_-hgHUx-6NLx8hQZxGRsCd--J0xWog>
    <xme:KpybaT_GdticHE7qxbfHo7-IubT4iF28tNOOXyv3mmF3t1eyGS9z-kpprF8im5g1U
    _Id3QEV9AbJAvBOIYahtqUJxqX2wY4ToZNDvEs2p23J4kL4AA>
X-ME-Received: <xmr:KpybadTeBjAT5mgHUUmbWuzTEiKbI44iHy9T3neqfmXI5HhYRdQ7lRlCBqhkoSoknHO2qDv44I6wmgGa52yj_8sqUJfMvs-L8ivCDkgT8GYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    gvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KpybaXfGPnGBinaEAVmAQzVf4icdvqZTF-9B6VzRWFLdIFofMxDXlw>
    <xmx:KpybaRA_cg3Ufo4DHRcVg88M9TAGWUiEKddrYXnEkNDLGC8M3r43Fg>
    <xmx:KpybaZmZWrP9Gzf9x3UxvofKpcrkFHUslsPMa8liyMWrNNDp596xcA>
    <xmx:Kpybacc3eX6A5U2htNVUj4Ae1YaRQiORTV4_ngx0y22IxtCvF40EVA>
    <xmx:KpybabrQQwNnaIPcv59pUQk9HGOIlBbmxgIV-ou5FcYqRETd86mVIfO->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 19:15:35 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 2/6] sunrpc: Allocate a separate Reply page array
In-reply-to: <20260222162002.10613-3-cel@kernel.org>
References: <20260222162002.10613-1-cel@kernel.org>,
 <20260222162002.10613-3-cel@kernel.org>
Date: Mon, 23 Feb 2026 11:15:17 +1100
Message-id: <177180571733.8396.6283139237611600966@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19103-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,messagingengine.com:dkim,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09223170E94
X-Rspamd-Action: no action

On Mon, 23 Feb 2026, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> struct svc_rqst uses a single dynamically-allocated page array
> (rq_pages) for both the incoming RPC Call message and the
> outgoing RPC Reply message. rq_respages is a sliding pointer
> into rq_pages that each transport receive path must compute
> based on how many pages the Call consumed. This boundary
> tracking is a source of confusion and bugs, and prevents an
> RPC transaction from having both a large Call and a large
> Reply simultaneously.
>=20
> Allocate rq_respages as its own page array, eliminating the
> boundary arithmetic. This decouples Call and Reply buffer
> lifetimes, following the precedent set by rq_bvec (a separate
> dynamically-allocated array for I/O vectors).
>=20
> rq_next_page is initialized in svc_alloc_arg() and
> svc_process() during Reply construction, and in
> svc_rdma_recvfrom() as a precaution on error paths.
> Transport receive paths no longer compute it from the
> Call size.

I do like that you have split the one array in two - it is certainly
conceptually cleaner.

I don't like that you now allocate twice as many pages.  This could have
a significant impact on a smaller server, and should at least be
highlighted in the commit description.

For NFSv3, this is complete waste.
For NFSv4 we do have the option is returning NFS4ERR_RESOURCE for ops
that we cannot reply to.
So could we allocate reply pages on demand, either stealing them from
the end of the request buffer, to using kmalloc when request buffer has
no spare?

More comments below..


>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h              | 43 ++++++++++++-------------
>  net/sunrpc/svc.c                        | 27 +++++++++++++---
>  net/sunrpc/svc_xprt.c                   | 36 +++++++++++++++------
>  net/sunrpc/svcsock.c                    |  6 ----
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 15 +++------
>  5 files changed, 73 insertions(+), 54 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 4dc14c7a711b..b1fb728724f5 100644
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
> - * Pages are sent using ->sendmsg with MSG_SPLICE_PAGES so each server thr=
ead
> - * needs to allocate more to replace those used in sending.  To help keep =
track
> - * of these pages we have a receive list where all pages initialy live, an=
d a
> - * send list where pages are moved to when there are to be part of a reply.
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
> - * The xdr_buf.head kvec always points to the first page in the rq_*pages
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
> @@ -162,10 +161,10 @@ extern u32 svc_max_payload(const struct svc_rqst *rqs=
tp);
>   * Returns a count of pages or vectors that can hold the maximum
>   * size RPC message for @serv.
>   *
> - * Each request/reply pair can have at most one "payload", plus two
> - * pages, one for the request, and one for the reply.
> - * nfsd_splice_actor() might need an extra page when a READ payload
> - * is not page-aligned.
> + * Each page array can hold at most one payload plus two
> + * overhead pages (one for the RPC header, one for tail data).
> + * nfsd_splice_actor() might need an extra page when a READ
> + * payload is not page-aligned.
>   */
>  static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
>  {
> @@ -201,9 +200,9 @@ struct svc_rqst {
>  	struct xdr_stream	rq_res_stream;
>  	struct folio		*rq_scratch_folio;
>  	struct xdr_buf		rq_res;
> -	unsigned long		rq_maxpages;	/* num of entries in rq_pages */
> +	unsigned long		rq_maxpages;	/* entries per page array */
>  	struct page *		*rq_pages;

Should we now document above as /* Request buffer pages */ ??
Maybe even rename it to rq_reqpages ???

> -	struct page *		*rq_respages;	/* points into rq_pages */
> +	struct page *		*rq_respages;	/* Reply buffer pages */
>  	struct page *		*rq_next_page; /* next reply page to use */
>  	struct page *		*rq_page_end;  /* one past the last page */

"one past the last request page" or "... last page in rq_respages".

> =20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 05ba4040a24a..f850a2af90c2 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -639,13 +639,21 @@ svc_init_buffer(struct svc_rqst *rqstp, const struct =
svc_serv *serv, int node)
>  {
>  	rqstp->rq_maxpages =3D svc_serv_maxpages(serv);
> =20
> -	/* rq_pages' last entry is NULL for historical reasons. */
>  	rqstp->rq_pages =3D kcalloc_node(rqstp->rq_maxpages + 1,

You've removed the comment justifying the "+ 1" but you haven't removed
the "+ 1" !!

>  				       sizeof(struct page *),
>  				       GFP_KERNEL, node);
>  	if (!rqstp->rq_pages)
>  		return false;
> =20
> +	rqstp->rq_respages =3D kcalloc_node(rqstp->rq_maxpages + 1,
> +					  sizeof(struct page *),
> +					  GFP_KERNEL, node);

Please justify this +1 - or remove it.

> +	if (!rqstp->rq_respages) {
> +		kfree(rqstp->rq_pages);
> +		rqstp->rq_pages =3D NULL;
> +		return false;

If I we writing this I would:

 rq_pages =3D kcalloc
 rq_respages =3D kcalloc
 if (!rq_page || !rq_respage) {
     kfree(rq_pages)
     kfree(rq_respages)
     rq_page =3D NULL
     rq_respages =3D NULL
     return false;
 }

But you might reasonably prefer your version.


> +	}
> +
>  	return true;
>  }
> =20
> @@ -657,10 +665,19 @@ svc_release_buffer(struct svc_rqst *rqstp)
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
> index 56a663b8939f..cd38f09c1803 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -650,14 +650,13 @@ static void svc_check_conn_limits(struct svc_serv *se=
rv)
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
> -	rqstp->rq_pages[pages] =3D NULL; /* this might be seen in nfsd_splice_act=
or() */
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
> +	rqstp->rq_respages[pages] =3D NULL;

Would
        rqstp->rq_page_end[0] =3D NULL;
be a clearer match for the comment?

Thanks,
NeilBrown


> =20
>  	/* Make arg->head point to first page and arg->pages point to rest */
>  	arg->head[0].iov_base =3D page_address(rqstp->rq_pages[0]);
> @@ -1277,7 +1294,6 @@ static noinline int svc_deferred_recv(struct svc_rqst=
 *rqstp)
>  	rqstp->rq_addrlen     =3D dr->addrlen;
>  	/* Save off transport header len in case we get deferred again */
>  	rqstp->rq_daddr       =3D dr->daddr;
> -	rqstp->rq_respages    =3D rqstp->rq_pages;
>  	rqstp->rq_xprt_ctxt   =3D dr->xprt_ctxt;
> =20
>  	dr->xprt_ctxt =3D NULL;
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index d61cd9b40491..10a298f440cc 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -351,8 +351,6 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp,=
 size_t buflen,
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
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/=
svc_rdma_recvfrom.c
> index e7e4a39ca6c6..3081a37a5896 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
> @@ -861,18 +861,12 @@ static noinline void svc_rdma_read_complete(struct sv=
c_rqst *rqstp,
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
> --=20
> 2.53.0
>=20
>=20


