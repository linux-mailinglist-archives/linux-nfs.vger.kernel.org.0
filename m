Return-Path: <linux-nfs+bounces-15205-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C2BD6BFF
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Oct 2025 01:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02DC64E0428
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 23:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79629ACC3;
	Mon, 13 Oct 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="REceZ9es";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMic/eHg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195E4C81;
	Mon, 13 Oct 2025 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398559; cv=none; b=HP3Wro7qbBdnnx7H0ipPIVxzf3Ex5Hg2Wex9noTRC92ugevmOXh4XLn8L50AlHAVu5dXTY2CV6LN/sCnA9EvJQDs2KJUsNs7vVoDKOm7x8yCeHH8nxXWVtZtMJhyFC+xAFL5X/Xf8IpISrLpek4brbkHgLRYTru33CkG/UNLNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398559; c=relaxed/simple;
	bh=0QuAR0/4AyTBeFlw4CsV3m2ORb3JtGIQ2wHVDqA40+E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AgEBSSIL3OAg0NOtLpO/LgtjjV74e0Zbzbi8esynyiXr9NH1jwYNiJTCkHgEhTGYhglQGMXjD5q34al3g2C7uS5xTKtpy6HZUrN9yDw0q7I+xDW5O6DtgSq720cuhVpEol3D//DxoObuBq3TUvN1r85P2Z7YhcD3sI3P/SLqn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=REceZ9es; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMic/eHg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA432140019B;
	Mon, 13 Oct 2025 19:35:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 19:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760398555; x=1760484955; bh=5jFUauRG3QxpRAq4VW7PTQgcr6CRr0JtmDp
	HVLxYMAI=; b=REceZ9esFp6oAzOBAEHKzlvbEguBqTbJWoDcGtsMMV/WvNTTPvq
	F2Z6734HlH1pHe+tsnUlqr0iwtJv+8BZhnRIGX5VQATdN/hKOBf/B00eMljN4Yhm
	MNFeQYoJQgBoecGWCjg0igtBYcT+RimKe2ViJ6G+BB0TR7ygyyPWAfSu3Ib2LWqB
	AGLVLQvOR+zVDm6QqQykT9zCPLGLHJ8QigM0fCYvj8MseLpFaAiN9HO+6jfdEkRd
	nMXwR6fHApz87m+nRplceHRvoK7bD1y9CxQVs5vqHpP0rKp7flTGMZ6pTV4kVuva
	eY3tZIxwKi/eaejbt7euUHLp1x1BRrsQdpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760398555; x=
	1760484955; bh=5jFUauRG3QxpRAq4VW7PTQgcr6CRr0JtmDpHVLxYMAI=; b=X
	Mic/eHgSPlYkRrsJtHLKSt64svIOq1UXmhb1Mw83Tm3YzvHaEFx7vP5Epb5UAgp3
	kLG4rQujiW1P8j0WFgTH5gvnn44oHGgEPN3AyuAzVzTpoLjsNfuSvaKc5ClFCwlU
	riPbZ7UM7kS71R2ocyFrdejAxfN5DC+OcX8SdCl8GNd4G3IdKpNCF5wNTNu7V1gh
	VYS7xfqcIxOY0CuuDHLqqEM4tjMIhyixt4BPoLq9WpsfBHvWlB9n5e/0e21CjIfv
	pls2yqZ+WmbRqLbIbD1hT/tzIKQSXTLOYL1hwuO6Ho05KBAAi4KSUxwSl4oMmJpd
	ZaWivxL6+9rzjPrndGnng==
X-ME-Sender: <xms:24ztaL1xkSXgDqwovqTq_GB5RW_Qq1RHT9d72V7qHJtWBn4zxmDA5g>
    <xme:24ztaExBBkqiGYo0p79FrLpU05GJaFeNjWv4QElj5z8FPeUMOm7KtAkDvBhQ9XJAM
    NKhTnW7bYFG9_3HOAqyeLk-11fPqTvfc-ycyhp0A4_huCk-3w>
X-ME-Received: <xmr:24ztaEnf5epASJhPF5qLR9mpaEINJPexocwtBRfup-211QZ0dF68_O1KibEDOnNYSg_YGiPZ3FFvpR4ySnav09tJhupjarxTYcatHGvLqEQf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekleekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:24ztaH9KvWnruM0boXE84Q9SQV09Yj9GgyzT8HHirKKaJJ10AFLtzA>
    <xmx:24ztaPqQ3y7kQLViJmtdyGI37qms7SXVmnxlddfwnhxFPCjj9_f6BQ>
    <xmx:24ztaLLyygb1OhDpPDPeRVUmO5-L-SlhKKLAW8NiRr7P7K6M-2PIJw>
    <xmx:24ztaJ0aM3U6nEu4A4Q1nWQYkZjREiTLIA0lOfYK0-8xNkX_gH4fyA>
    <xmx:24ztaB_Y9lV5l1Ny-fQf-LuVmf0kpVdgY0zzN36KUAGcOcJjRb4qSEjW>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 19:35:50 -0400 (EDT)
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
 Re: [PATCH v7] sunrpc: allocate a separate bvec array for socket sends
In-reply-to: <20251013-rq_bvec-v7-1-c032241efd89@kernel.org>
References: <20251013-rq_bvec-v7-1-c032241efd89@kernel.org>
Date: Tue, 14 Oct 2025 10:35:45 +1100
Message-id: <176039854564.1793333.2137462594901890659@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 14 Oct 2025, Jeff Layton wrote:
> svc_tcp_sendmsg() calls xdr_buf_to_bvec() with the second slot of
> rq_bvec as the start, but doesn't reduce the array length by one, which
> could lead to an array overrun. Also, rq_bvec is always rq_maxpages in
> length, which can be too short in some cases, since the TCP record
> marker consumes a slot.
>=20
> Fix both problems by adding a separate bvec array to the svc_sock that
> is specifically for sending. For TCP, make this array one slot longer
> than rq_maxpages, to account for the record marker. For UDP, only
> allocate as large an array as we need since it's limited to 64k of
> payload.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Another update based on Neil's feedback. This version allocates the
> array when the socket is allocated, and fixes the UDP length
> calculation.

Looks good - thanks.

Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown


> ---
> Changes in v7:
> - use RPCSVC_MAXPAYLOAD_UDP instead of assuming max of 64kb
> - Link to v6: https://lore.kernel.org/r/20251013-rq_bvec-v6-1-17982fc64ad2@=
kernel.org
>=20
> Changes in v6:
> - allocate sk_bvec in ->xpo_create
> - fix the array-length calculation for UDP
> - Link to v5: https://lore.kernel.org/r/20251010-rq_bvec-v5-1-44976250199d@=
kernel.org
>=20
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
>  net/sunrpc/svcsock.c           | 55 ++++++++++++++++++++++++++++++++++++--=
----
>  2 files changed, 51 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
> index 963bbe251e52109a902f6b9097b6e9c3c23b1fd8..de37069aba90899be19b1090e6e=
90e509a3cf530 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -26,6 +26,9 @@ struct svc_sock {
>  	void			(*sk_odata)(struct sock *);
>  	void			(*sk_owspace)(struct sock *);
> =20
> +	/* For sends (protected by xpt_mutex) */
> +	struct bio_vec		*sk_bvec;
> +
>  	/* private TCP part */
>  	/* On-the-wire fragment header: */
>  	__be32			sk_marker;
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 0cb9c4d457453b26db29f08985b056c3f8d59447..93de79020a2d859a9c0b9464d79=
4c167531d701d 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -68,6 +68,17 @@
> =20
>  #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
> =20
> +/*
> + * For UDP:
> + * 1 for header page
> + * enough pages for RPCSVC_MAXPAYLOAD_UDP
> + * 1 in case payload is not aligned
> + * 1 for tail page
> + */
> +enum {
> +	SUNRPC_MAX_UDP_SENDPAGES =3D 1 + RPCSVC_MAXPAYLOAD_UDP / PAGE_SIZE + 1 + 1
> +};
> +
>  /* To-do: to avoid tying up an nfsd thread while waiting for a
>   * handshake request, the request could instead be deferred.
>   */
> @@ -740,14 +751,14 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  	if (svc_xprt_is_dead(xprt))
>  		goto out_notconn;
> =20
> -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
> +	count =3D xdr_buf_to_bvec(svsk->sk_bvec, SUNRPC_MAX_UDP_SENDPAGES, xdr);
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
> @@ -1236,19 +1247,19 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, s=
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
> @@ -1393,6 +1404,20 @@ void svc_sock_update_bufs(struct svc_serv *serv)
>  	spin_unlock_bh(&serv->sv_lock);
>  }
> =20
> +static int svc_sock_sendpages(struct svc_serv *serv, struct socket *sock, =
int flags)
> +{
> +	switch (sock->type) {
> +	case SOCK_STREAM:
> +		/* +1 for TCP record marker */
> +		if (flags & SVC_SOCK_TEMPORARY)
> +			return svc_serv_maxpages(serv) + 1;
> +		return 0;
> +	case SOCK_DGRAM:
> +		return SUNRPC_MAX_UDP_SENDPAGES;
> +	}
> +	return -EINVAL;
> +}
> +
>  /*
>   * Initialize socket for RPC use and create svc_sock struct
>   */
> @@ -1403,12 +1428,26 @@ static struct svc_sock *svc_setup_socket(struct svc=
_serv *serv,
>  	struct svc_sock	*svsk;
>  	struct sock	*inet;
>  	int		pmap_register =3D !(flags & SVC_SOCK_ANONYMOUS);
> +	int		sendpages;
>  	unsigned long	pages;
> =20
> +	sendpages =3D svc_sock_sendpages(serv, sock, flags);
> +	if (sendpages < 0)
> +		return ERR_PTR(sendpages);
> +
>  	pages =3D svc_serv_maxpages(serv);
>  	svsk =3D kzalloc(struct_size(svsk, sk_pages, pages), GFP_KERNEL);
>  	if (!svsk)
>  		return ERR_PTR(-ENOMEM);
> +
> +	if (sendpages) {
> +		svsk->sk_bvec =3D kcalloc(sendpages, sizeof(*svsk->sk_bvec), GFP_KERNEL);
> +		if (!svsk->sk_bvec) {
> +			kfree(svsk);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +	}
> +
>  	svsk->sk_maxpages =3D pages;
> =20
>  	inet =3D sock->sk;
> @@ -1420,6 +1459,7 @@ static struct svc_sock *svc_setup_socket(struct svc_s=
erv *serv,
>  				     inet->sk_protocol,
>  				     ntohs(inet_sk(inet)->inet_sport));
>  		if (err < 0) {
> +			kfree(svsk->sk_bvec);
>  			kfree(svsk);
>  			return ERR_PTR(err);
>  		}
> @@ -1637,5 +1677,6 @@ static void svc_sock_free(struct svc_xprt *xprt)
>  		sock_release(sock);
> =20
>  	page_frag_cache_drain(&svsk->sk_frag_cache);
> +	kfree(svsk->sk_bvec);
>  	kfree(svsk);
>  }
>=20
> ---
> base-commit: 05d2192090744b16ce05bd221c459a9357c17525
> change-id: 20251008-rq_bvec-b66afd0fdbbb
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


