Return-Path: <linux-nfs+bounces-15141-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784DBCEC3E
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 01:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDB864EBAB4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 23:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C33C283FDD;
	Fri, 10 Oct 2025 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="lbA3hiPj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vf/mX0p6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B509283FDC;
	Fri, 10 Oct 2025 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139506; cv=none; b=P+YfESR//iOfypjKpGarth6x2jJO+QugZfS9j0FuwV5FqEmRs4gnJu1PaHyCRXBZjgVlVP8kefcQGf2dJOFDNfyqbYZc/cLNecE/FGFSBTopSS1h8g0BQwoKoN/qdOpmsptlX2EotrPsrkXAENdDAuQ1OCM7Tc1uWeKOdgOm128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139506; c=relaxed/simple;
	bh=BTOesWQcJ8P+Ph0wyqiZvFXWavhm/19KRxCrFypx2Jk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=I2KWsyYPZlrAY1ovDXtWnatw9rjKh6m498CudIGpCD8Bk478VxgDZVaWeQ+DOuVXDEpPQgfpiS8FEjs+n3OXapLmMytTykb0EmVtgqISx0rYX8R/wI68MAo/x9JT3C/i3op4GjmcNPYBFN/DlT/KnlqRh0mC94GDU2s2abBmVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=lbA3hiPj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vf/mX0p6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B9891400229;
	Fri, 10 Oct 2025 19:38:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 10 Oct 2025 19:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760139500; x=1760225900; bh=Mjtxvxas0/oBEiLx7HwNlf1mmcM2gvlFOtp
	so5vQx5k=; b=lbA3hiPjzDe4Z5flXMZdigsL5pqvYEZy5lyam20t3M7NGmCEW36
	PpxMiou3/DCfrHoYG5a6TJT5M/TCtY6pQF7funfHWaS4BP6ARKT2NykqdGjvP9G6
	qsvwRGoMJmT0Xg36np3S5VVRMZsKcT3fKfUNOp5baYeZdEaQ79xZouTMmKBPT9xD
	PO/oU5ywHXN4rcOPlrgHrfNK+NqMQHGj1oKY1smf8gNIAa9jgfFVIKoRBnw9LL5s
	xqLCfeT08ZzKU1eN7odqysG4w7/xyWGvjFqLBQv/UdQeLxf6U5sUEsLrnnKmhg3W
	FJ/ezXMSiec3hUjDX3xI9UXU3gfKPEtk2mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760139500; x=
	1760225900; bh=Mjtxvxas0/oBEiLx7HwNlf1mmcM2gvlFOtpso5vQx5k=; b=V
	f/mX0p6WPksbRNbHmKO0NGIegaFH4ujzedVpfFnbAyDcPhAyhGAUYEVQsgxoRtoW
	7+gvVJ5a+k5AHlBmEidV5KOsCTykPXVmqsj+i7o8Iwy+A3723KceIkhUbbIP/JYe
	LK2y4y98HNBqfQ6MI1DxnIsZFFxT1Fa9ugennxVz1ijGcBfUmBVCyqFm6x5YC/hc
	67szDQCkaH6p9oAyU/bC/lEabGa6cu+YpfZFUvYeM//FGDW92p6VD5wx/o2jzE+b
	U15mSnDohK1qEcG9sgb+/F3+aeLfFG2F+r8gViRycNOUcF65IP4k/6JPIx7gZvVv
	leDwWcGpf1IZrHSADsjJg==
X-ME-Sender: <xms:6pjpaOXDMgMQ9BCE6Yp-7CTP4vEb2eOx3mSXK_TTcIZBB2cVrUFUFA>
    <xme:6pjpaLik8WH4oqrCFrjVPK8jZoZWLF6eBmjMgkxmUi7OYNFOK7P1eq0mDsU0xM1hh
    ebV0kOlV5ktsD3GM1vRCoS6eqNZ7oGzdRhvS75mdse6Ict9uXg>
X-ME-Received: <xmr:6pjpaCt4LRaPVWwmECl31WZcQckFOjXWXmB3ryEasMxsbOPPod74CpmZ65RePcWpD-WCxuI1QXao7bEJa9an7jTpe6Kwls6s10-_4hJid9zj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlphgvhidr
    tghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    epohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopeguhhhofigvlhhl
    shesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:6pjpaDyWeAp30bRcGMmCP68s8H_mW4rAtphvgO_LACmhYI4cIwnVhA>
    <xmx:6pjpaPaBlw0qvTS1stgcOPumL-y1v1QEWpYPe4q8y7wO6ZxHPm2HYg>
    <xmx:6pjpaKUYUlQrKagvAk9e3F0k2YpXIRxMtNsNtlHopCb719au8XoX_A>
    <xmx:6pjpaIFYFjpgEV9q5jL9KKHABL5wCU-WrKixA9h2EJIxa83UFn0Ofg>
    <xmx:7JjpaAMg8M6TEJC1k751cp-jp-qp2ythcEpQF2X2SQ26ap5_ZObdhXTF>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 19:38:13 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "David Howells" <dhowells@redhat.com>, "Brandon Adams" <brandona@meta.com>,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH v5] sunrpc: allocate a separate bvec array for socket sends
In-reply-to: <20251010-rq_bvec-v5-1-44976250199d@kernel.org>
References: <20251010-rq_bvec-v5-1-44976250199d@kernel.org>
Date: Sat, 11 Oct 2025 10:38:10 +1100
Message-id: <176013949034.1793333.3431602805327357817@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 11 Oct 2025, Jeff Layton wrote:
> svc_tcp_sendmsg() calls xdr_buf_to_bvec() with the second slot of
> rq_bvec as the start, but doesn't reduce the array length by one, which
> could lead to an array overrun. Also, rq_bvec is always rq_maxpages in
> length, which can be too short in some cases, since the TCP record
> marker consumes a slot.
>=20
> Fix both problems by adding a separate bvec array to the svc_sock that
> is specifically for sending. Allocate it when doing the first send on
> the socket, to avoid allocating the array for listener sockets.
>=20
> For TCP, make this array one slot longer than rq_maxpages, to account
> for the record marker. For UDP only allocate as large an array as we
> need since frames are limited to 64k anyway.

I think I like this approach better - thanks.
It is certainly more focussed and makes it cleared where the problem is
that is being fixed.

However I would prefer the allocation happen in ->xpo_create.
For UDP, always allocate the bvec
For TCP, only allocate if SVC_SOCK_TEMPORARY is set.

>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Minor update to the last patch to reduce the size of the array on UDP
> sockets since that transport doesn't need rq_maxpages.
> ---
> Changes in v5:
> - reduce the size of sk_bvec on UDP sockets
> - Link to v4: https://lore.kernel.org/r/20251010-rq_bvec-v4-1-627567f1ce91@=
kernel.org
>=20
> Changes in v4:
> - switch to allocating a separate bvec for sends in the svc_sock
> - Link to v3: https://lore.kernel.org/r/20251009-rq_bvec-v3-0-57181360b9cb@=
kernel.org
>=20
> Changes in v3:
> - Add rq_bvec_len field and use it in appropriate places
> - Link to v2: https://lore.kernel.org/r/20251008-rq_bvec-v2-0-823c0a85a27c@=
kernel.org
>=20
> Changes in v2:
> - Better changelog message for patch #2
> - Link to v1: https://lore.kernel.org/r/20251008-rq_bvec-v1-0-7f23d32d75e5@=
kernel.org
> ---
>  include/linux/sunrpc/svcsock.h |  3 +++
>  net/sunrpc/svcsock.c           | 29 ++++++++++++++++++++++-------
>  2 files changed, 25 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
> index 963bbe251e52109a902f6b9097b6e9c3c23b1fd8..a80a05aba75410b3c4cd7ba1918=
1ead7d40e1fdf 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -26,6 +26,9 @@ struct svc_sock {
>  	void			(*sk_odata)(struct sock *);
>  	void			(*sk_owspace)(struct sock *);
> =20
> +	/* For sends */
> +	struct bio_vec		*sk_bvec;

Protected by xpt_mutex.  You probably don't need to state that, but I
wanted to check it was protected from concurrent access.

> +
>  	/* private TCP part */
>  	/* On-the-wire fragment header: */
>  	__be32			sk_marker;
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 7b90abc5cf0ee1520796b2f38fcb977417009830..0ec1131ffade8d0c66099bfb1fb=
141b22c6e411b 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -730,6 +730,13 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  	unsigned int count;
>  	int err;
> =20
> +	count =3D DIV_ROUND_UP(RPC_MAX_REPHEADER_WITH_AUTH + RPCSVC_MAXPAYLOAD_UD=
P, PAGE_SIZE);
> +	if (!svsk->sk_bvec) {
> +		svsk->sk_bvec =3D kcalloc(count, sizeof(*svsk->sk_bvec), GFP_KERNEL);
> +		if (!svsk->sk_bvec)
> +			return -ENOMEM;
> +	}

1/ I don't think that calculate is correct.  There is no expectation
that the entire reply is consecutive in pages.
There is likely to be:
  - a header.  1 page
  - a payload, which if no aligned could be 64K of pages, but a start
      and end page
  - a tail with padded to round the payload up to 4 bytes.

I think you need a calculation similar to svc_serv_maxpages().

2/ Please don't re-use the "count" variable.  Here is an array size,
  below is it array usage.  The compile can use the same register for
  both variables if that works out.

 =20

> +
>  	svc_udp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
>  	rqstp->rq_xprt_ctxt =3D NULL;
> =20
> @@ -740,14 +747,14 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  	if (svc_xprt_is_dead(xprt))
>  		goto out_notconn;
> =20
> -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
> +	count =3D xdr_buf_to_bvec(svsk->sk_bvec, rqstp->rq_maxpages, xdr);
                                               ^^^^^^^^^^^^^^^^^^
That should be "count".  That would make it clear that "count" was being
overloaded in a possibly confusing way.

Thanks,
NeilBrown


> =20
> -	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> +	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
>  		      count, rqstp->rq_res.len);
>  	err =3D sock_sendmsg(svsk->sk_sock, &msg);
>  	if (err =3D=3D -ECONNREFUSED) {
>  		/* ICMP error on earlier request. */
> -		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> +		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
>  			      count, rqstp->rq_res.len);
>  		err =3D sock_sendmsg(svsk->sk_sock, &msg);
>  	}
> @@ -1235,19 +1242,19 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, s=
truct svc_rqst *rqstp,
>  	int ret;
> =20
>  	/* The stream record marker is copied into a temporary page
> -	 * fragment buffer so that it can be included in rq_bvec.
> +	 * fragment buffer so that it can be included in sk_bvec.
>  	 */
>  	buf =3D page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
>  			      GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
>  	memcpy(buf, &marker, sizeof(marker));
> -	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
> +	bvec_set_virt(svsk->sk_bvec, buf, sizeof(marker));
> =20
> -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages,
> +	count =3D xdr_buf_to_bvec(svsk->sk_bvec + 1, rqstp->rq_maxpages,
>  				&rqstp->rq_res);
> =20
> -	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> +	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_bvec,
>  		      1 + count, sizeof(marker) + rqstp->rq_res.len);
>  	ret =3D sock_sendmsg(svsk->sk_sock, &msg);
>  	page_frag_free(buf);
> @@ -1272,6 +1279,13 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
>  					 (u32)xdr->len);
>  	int sent;
> =20
> +	if (!svsk->sk_bvec) {
> +		/* +1 for TCP record marker */
> +		svsk->sk_bvec =3D kcalloc(rqstp->rq_maxpages + 1, sizeof(*svsk->sk_bvec)=
, GFP_KERNEL);
> +		if (!svsk->sk_bvec)
> +			return -ENOMEM;
> +	}
> +
>  	svc_tcp_release_ctxt(xprt, rqstp->rq_xprt_ctxt);
>  	rqstp->rq_xprt_ctxt =3D NULL;
> =20
> @@ -1636,5 +1650,6 @@ static void svc_sock_free(struct svc_xprt *xprt)
>  		sock_release(sock);
> =20
>  	page_frag_cache_drain(&svsk->sk_frag_cache);
> +	kfree(svsk->sk_bvec);
>  	kfree(svsk);
>  }
>=20
> ---
> base-commit: 177818f176ef904fb18d237d1dbba00c2643aaf2
> change-id: 20251008-rq_bvec-b66afd0fdbbb
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


