Return-Path: <linux-nfs+bounces-19104-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /pBqEBKdm2kk3gMAu9opvQ
	(envelope-from <linux-nfs+bounces-19104-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 01:19:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAB8170E9E
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 01:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 965E6300861E
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4895CDF1;
	Mon, 23 Feb 2026 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="aWd6IaxB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TiBzg2aF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8AA55
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771805963; cv=none; b=XhFj2aZAOXxafz66sgj53xWz7A4sCC8lXzmIn8xjilOz3iBH0VEnMAA+h2NLpzMNByMwI0UYvfmSh0FuRnklJs3N/5VKUvTpeV4z1huBLhdBRVMTTfSeg05qeNmoocZCxOa6KwUwKwSzH6VTWykkJOhRwQeFhbJL6l7GBHt+6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771805963; c=relaxed/simple;
	bh=mMmB6/X9IbUYesWDx0XD8IHcRj0k7IlIEefOot2YnhU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GdyfaX+R7kVmD3UsMmUy0XfmZ7i+jaM2hx+K6YvWmD4XokDexxl+i0VHaV4hxBH43uWAsplnlK2+kpa6jOn/aHApFWoazJHnXlBcr5BV7G7+bmFxhlA5M0uWdmfgjd4HYGj6MYV/9TxNI7AqmhnU/8i58HeEw/4NV6G92JqOXL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aWd6IaxB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TiBzg2aF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1190EEC03A2;
	Sun, 22 Feb 2026 19:19:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 22 Feb 2026 19:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1771805961; x=1771892361; bh=OoRpuLtH1yWaNzAAQ1EnxkBUjew49O2F9BL
	yHvFtTUo=; b=aWd6IaxBykyCor2BdlDbCMBtYR4/PyqinKpd5Ej9J9L5yWu9FrV
	JdgEHbjHw49ia6bCkxu8UqWQw7szdFP2mslfBN9836xdvFmZfKuG6sGv3YLi/LBg
	Q5Cg2DrPTafvGlLn/0CAY0f4B/diF4lJgc53HrX+Gy2X4IZo10fhRt0RpqvINRhn
	MUQzjTpfs73AEuDEPxNQqhykBHt70dgnTaxNJL0tadIGjVlomklZkMElV6Pkso3z
	E11YHq3SeaQ/2G4y+MROLBTrLYCKlZ358PXVtZoOoZrWwOgfhFQjNU8QXws9n0x2
	u1Dy4YpXvf+R5txFinzn7mWAhayi8iQw5oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771805961; x=
	1771892361; bh=OoRpuLtH1yWaNzAAQ1EnxkBUjew49O2F9BLyHvFtTUo=; b=T
	iBzg2aFJfga6OkHIL97pZpHUYs32noGTlfXcc+lcOjcEoFH50Rq8YBhwz8V0V8Cl
	0rP8/6Hg7OfYEM/IZA/aS7pDLZxK0SMzTk+kkY7wUiB05FA+yZTIFM0UFGufs/0H
	8CtI7S3HOul6o+kxu+5RkRqZG8YjQSLrWMzT9VhUe+wLaN/qTQZWbz8olfBesuWp
	aKVu8sTtv5BImdl16urhOe61nf+Wj7KdWpwKS1l+VUIZYi7hkF1WeTQ9c7lpSiBz
	BiZXMzOFpPPzTD1qI01lYR6aVoPVDBElSK1i6EsfxU0U7yxpT/UsSMtHC5dMGGSI
	RhlCm8kEEohWNJacyKHHA==
X-ME-Sender: <xms:CJ2baRj0sGtdJ2UIuqfhqGwEMWtYsErv1m1j_08gWW90N3KxhR6HAw>
    <xme:CJ2baYSCk6r4FxF4-FBNksda6NEs-XSB55-lEaOcx5Kmus1iGz0AGFLeF5OS_KR2K
    7aF7XrzOFuvgP4CLZsUZ_ux7OejH-ryCxW7TNyCwoCPJvVw>
X-ME-Received: <xmr:CJ2baTUGBd3F9-utYLLlS5WOYSWCXlWEdc4BdPJigw-P_v152PZinSBDe9Ifhp8B6xiQo661IpIs63Y-Lp2vWNBvtSerXE-s3j9fJRPmVgtR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehjeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:CJ2bacSwQtzZCy00j7p97IEOdCIR9FCeovSFNkdIeBW7vLTS9RBvLQ>
    <xmx:CJ2badkvmucqbXZD95IlTv8XlZAMlig5Sm2locXqw2R1ZbA9kFKo8A>
    <xmx:CJ2baS61_L-HkBKrsvz7-NEXaDlbPJgb_-6-IN_U2RbOwovROJbjRA>
    <xmx:CJ2baTjUoieu0w6CXTVxuxCmuffTg_gUhLvFiJChj5w7wKac-l2LXQ>
    <xmx:CZ2baT-1pwDJsCLq6E831A4nhixyoGRUMEdRWVpaXzC8X6WYvZnXuQ-K>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 19:19:18 -0500 (EST)
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
Subject: Re: [RFC PATCH 5/6] sunrpc: Track consumed rq_pages entries
In-reply-to: <20260222162002.10613-6-cel@kernel.org>
References: <20260222162002.10613-1-cel@kernel.org>,
 <20260222162002.10613-6-cel@kernel.org>
Date: Mon, 23 Feb 2026 11:19:16 +1100
Message-id: <177180595664.8396.277410977915016045@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19104-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,messagingengine.com:dkim,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FAB8170E9E
X-Rspamd-Action: no action

On Mon, 23 Feb 2026, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Transports that consume pages from the rq_pages array --
> svc_tcp_save_pages() for TCP fragment reassembly and
> svc_rdma_clear_rqst_pages() for RDMA Read I/O -- NULL
> the consumed entries starting at rq_pages[0]. A new
> rq_pages_nfree field in struct svc_rqst records the
> count of entries consumed.

Maybe I'm confused, but isn't it rq_respages which might get consumed.
rq_pages - containing the request - doesn't .... does it?

Thanks
NeilBrown


>=20
> svc_alloc_arg() uses rq_pages_nfree to refill only
> the consumed entries rather than scanning the full
> rq_pages array. In steady state, the transport consume
> path NULLs a handful of entries per RPC, so the
> allocator visits only those entries instead of the
> full ~259 slots (for 1MB messages).
>=20
> svc_init_buffer() initializes rq_pages_nfree to
> rq_maxpages so that the first svc_alloc_arg() call
> populates every entry.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h        |  8 ++++++++
>  net/sunrpc/svc.c                  |  1 +
>  net/sunrpc/svc_xprt.c             | 11 ++++++++---
>  net/sunrpc/svcsock.c              |  1 +
>  net/sunrpc/xprtrdma/svc_rdma_rw.c |  1 +
>  5 files changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index b1fb728724f5..bb2029e396db 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -143,6 +143,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqst=
p);
>   * server thread needs to allocate more to replace those used in
>   * sending.
>   *
> + * Transport page-consumption contract:
> + *
> + * Transports that consume rq_pages entries (for TCP fragment
> + * reassembly or RDMA Read I/O) NULL entries starting at
> + * rq_pages[0] and set rq_pages_nfree to the count of entries
> + * consumed. svc_alloc_arg() refills only that many entries.
> + *
>   * xdr_buf holds responses; the structure fits NFS read responses
>   * (header, data pages, optional tail) and enables sharing of
>   * client-side routines.
> @@ -201,6 +208,7 @@ struct svc_rqst {
>  	struct folio		*rq_scratch_folio;
>  	struct xdr_buf		rq_res;
>  	unsigned long		rq_maxpages;	/* entries per page array */
> +	unsigned long		rq_pages_nfree;		/* NULL rq_pages to refill */
>  	struct page *		*rq_pages;
>  	struct page *		*rq_respages;	/* Reply buffer pages */
>  	struct page *		*rq_next_page; /* next reply page to use */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 620de9abedbb..a8c26634ecf1 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -654,6 +654,7 @@ svc_init_buffer(struct svc_rqst *rqstp, const struct sv=
c_serv *serv, int node)
>  		return false;
>  	}
> =20
> +	rqstp->rq_pages_nfree =3D rqstp->rq_maxpages;
>  	return true;
>  }
> =20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index cd38f09c1803..9d8f6adcfe1f 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -675,12 +675,17 @@ static bool svc_fill_pages(struct svc_rqst *rqstp, st=
ruct page **pages,
>  static bool svc_alloc_arg(struct svc_rqst *rqstp)
>  {
>  	struct xdr_buf *arg =3D &rqstp->rq_arg;
> -	unsigned long pages;
> +	unsigned long pages, nfree;
> =20
>  	pages =3D rqstp->rq_maxpages;
> =20
> -	if (!svc_fill_pages(rqstp, rqstp->rq_pages, pages))
> -		return false;
> +	nfree =3D rqstp->rq_pages_nfree;
> +	if (nfree) {
> +		if (!svc_fill_pages(rqstp, rqstp->rq_pages, nfree))
> +			return false;
> +		rqstp->rq_pages_nfree =3D 0;
> +	}
> +
>  	if (!svc_fill_pages(rqstp, rqstp->rq_respages, pages))
>  		return false;
>  	rqstp->rq_next_page =3D rqstp->rq_respages;
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 10a298f440cc..f9140ac8ed99 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1009,6 +1009,7 @@ static void svc_tcp_save_pages(struct svc_sock *svsk,=
 struct svc_rqst *rqstp)
>  		svsk->sk_pages[i] =3D rqstp->rq_pages[i];
>  		rqstp->rq_pages[i] =3D NULL;
>  	}
> +	rqstp->rq_pages_nfree =3D npages;
>  }
> =20
>  static void svc_tcp_clear_pages(struct svc_sock *svsk)
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rd=
ma_rw.c
> index 4ec2f9ae06aa..cf4a1762b629 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -1107,6 +1107,7 @@ static void svc_rdma_clear_rqst_pages(struct svc_rqst=
 *rqstp,
>  		head->rc_pages[i] =3D rqstp->rq_pages[i];
>  		rqstp->rq_pages[i] =3D NULL;
>  	}
> +	rqstp->rq_pages_nfree =3D head->rc_page_count;
>  }
> =20
>  /**
> --=20
> 2.53.0
>=20
>=20
>=20


