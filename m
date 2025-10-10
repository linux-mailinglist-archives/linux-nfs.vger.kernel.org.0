Return-Path: <linux-nfs+bounces-15119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA2BCC9DE
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368B219E23B4
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D1285CB3;
	Fri, 10 Oct 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="H+LZkkCr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GfssZ31I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A30225A5B;
	Fri, 10 Oct 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093691; cv=none; b=gKTnXCRh2vcG0ujDJKEcXoAKfCn7PFMqrJ1MB+EALzzxYEw7DGzJbL5BTfDfvq+TJiXBjMpfhIjaxwTVXayS7q8RrD8hAG05EXkbgEzOLdftxrtYXTVbM2qjGuXfiC/SY+WSAw9/Br7aBAgJKfIrsgjbdm0TxYmStSmBOT+GXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093691; c=relaxed/simple;
	bh=PznYaXdLlhqjNPQ/D33Qb4oof/R/K3lCXgiB3PyJwiY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PT8drelZdHoyThOzSy45O/5XcTMhh+almFOotlYmeS+E/Wx2If2lGpe2P5jTWONE6jNmN0VDSB+TRn1exi8AMiRzrJ/VudpljUQT2tYzMZzEwA2gVDf6Q6QpAsfxKMWcEC8lkO1j5qU2wB4pxtuL04yVY2SgEC5Ty/q4Ghi3f3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=H+LZkkCr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GfssZ31I; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A8AE140012E;
	Fri, 10 Oct 2025 06:54:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Oct 2025 06:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760093686; x=1760180086; bh=ZaF0nEr18+OpoiLR6XW1SusBgEo8i+hrGKM
	y+cl1dPY=; b=H+LZkkCrlDaVg2L8UveFChGJkXImdVEQpJlH6GzKgVFQhnBFI1E
	B5kMCBLiG2WzNUdaRGax4LYVuESIe3d+fzpQInK1KDRAnHMAo18E9CBiYUGpL2JX
	kT1Z2PoTQdXk9TVRlJEoWqS6gw2Y8vp3Ax5VdSRnE6XVGdQO/NgBjqhuujeLdaC/
	S2ckCTgiiiQ7Yx3lWHocJugzVGqOBDWr05lBbm2GGSigJ8AWyHQ+HGOKiNOUkY+j
	HpyHcbtKBO25IZM6h2dL3eRSy5ZFZEgCHUhzSKL2pMZEz6SRAGidK27B/IiUi9g2
	tiN+qcvNLaGZ38rmmizefu/xwUuztfD7hnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760093686; x=
	1760180086; bh=ZaF0nEr18+OpoiLR6XW1SusBgEo8i+hrGKMy+cl1dPY=; b=G
	fssZ31Id1+bRz9NEPZQiZuKbl/bXEeH1uPtuNx2GaH0IjxdRvDEIrIgOK4SWMH7a
	Cj0QJjJXM9rZ5wVa/R0v/5Oqi7POnoLfRjYHC8nwWcmj9EYOn4WwxGBQeCkbJxyi
	fROj7TQ0XQLRNrX8cDIezb8/1sRYtbZ9d/ko/lLZXLhvbk++gAKGxnPxTFnpDvBo
	tyQkj3y+A0Y5ah+J/iOKvr7SkOGIGCLKK6q9VnxLLajpf8OJkchnTG3BwvbAKgj7
	CplfBQ2UozB9Kqb8gCY5GbCxDNrUblCDhjWSZWPQrB1A+flSOmIcLuDU46DyLQzz
	tKkq5cMwdzjKRunVJo/eQ==
X-ME-Sender: <xms:9eXoaENAQOMC-q6vv2qr_apZZ2zcRiwX3RSHPBdQG3IGqE_jS2Hshg>
    <xme:9eXoaL4MFBCHsNlzn_gz7TjetuSk24roMbgXBKdbwPdbDQLSSWskSDgVUMyt81Cf9
    u006k51JaC18IMufYba1c3BRFG0EjWPtmhBeVy8tFzPxkGrUwU>
X-ME-Received: <xmr:9eXoaLkm0T30MiQKUVlYQE-RGONhh4oUgUUZfE60s5J4-T45p2fRg_EXmy_E0vdQRAiCwXoFzXuF0dq0PKrlos9kun82TdlbbsPp4uXpuxrF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepughhohifvghllhhssehrvgguhhgrthdrtghomhdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghird
    hnghhosehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:9eXoaLJ85QhCh_kNuFUZMHSzQg1Nq-X5L-6BewdltiiudQiRmO7w8Q>
    <xmx:9eXoaDSmywGEWVmG8EIM4GwY0nNU6FFCfbdje5nZ_SMazjTCPxyCIw>
    <xmx:9eXoaAs7PVQVWRPjfBQoJe145CxLAcPtphU4HXL9KXq_imZcLFmbYw>
    <xmx:9eXoaO-hI5x1tihU9RUWN1BlwcRYtBTQtd2vYFdgglN3AvZidpcwrw>
    <xmx:9uXoaNygBZYqyhwqGu9Sa4mxzovp6semU5zccB6wHMObBTPIyzXtBfW7>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 06:54:41 -0400 (EDT)
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
 Re: [PATCH v3 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP record marker
In-reply-to: <20251009-rq_bvec-v3-2-57181360b9cb@kernel.org>
References: <20251009-rq_bvec-v3-0-57181360b9cb@kernel.org>,
 <20251009-rq_bvec-v3-2-57181360b9cb@kernel.org>
Date: Fri, 10 Oct 2025 21:54:39 +1100
Message-id: <176009367950.1793333.10338134521377665575@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 10 Oct 2025, Jeff Layton wrote:
> We've seen some occurrences of messages like this in dmesg on some knfsd
> servers:
>=20
>     xdr_buf_to_bvec: bio_vec array overflow
>=20
> Usually followed by messages like this that indicate a short send (note
> that this message is from an older kernel and the amount that it reports
> attempting to send is short by 4 bytes):
>=20
>     rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - shutting d=
own socket
>=20
> svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP record
> marker. If the send is an unaligned READ call though, then there may not
> be enough slots in the rq_bvec array in some cases.
>=20
> Add a rqstp->rq_bvec_len field and use that to keep track of the length
> of rq_bvec. Use that in place of rq_maxpages where it's iterating over
> the bvec.

The above never says that the patch increases the size of rq_bvec, which
is important for actually fixing the bug.

This patch does two things:

 1/ introduce ->rq_bvec_len which records the length of rq_bvec, and use
    it where ever that length is needed, rather than assuming it is
    rq_maxpages.
 2/ increase ->rq_bvec_len by 1 as svc_tcp_sendmsg needs an extra slot
    to send the record header.

You could conceivably make it two patches, but I don't think that is
necessary.  It *is* necessary to make it clear that these two distinct
though related changes are happening.

With something like that added to the commit message:

  Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>=20
> Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_se=
ndmsg() call")
> Tested-by: Brandon Adams <brandona@meta.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c              | 6 +++---
>  include/linux/sunrpc/svc.h | 1 +
>  net/sunrpc/svc.c           | 4 +++-
>  net/sunrpc/svcsock.c       | 4 ++--
>  4 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 77f6879c2e063fa79865100bbc2d1e64eb332f42..6c7224570d2dadae21876e0069e=
0b2e0551af0fa 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1111,7 +1111,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> =20
>  	v =3D 0;
>  	total =3D dio_end - dio_start;
> -	while (total && v < rqstp->rq_maxpages &&
> +	while (total && v < rqstp->rq_bvec_len &&
>  	       rqstp->rq_next_page < rqstp->rq_page_end) {
>  		len =3D min_t(size_t, total, PAGE_SIZE);
>  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> @@ -1200,7 +1200,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> =20
>  	v =3D 0;
>  	total =3D *count;
> -	while (total && v < rqstp->rq_maxpages &&
> +	while (total && v < rqstp->rq_bvec_len &&
>  	       rqstp->rq_next_page < rqstp->rq_page_end) {
>  		len =3D min_t(size_t, total, PAGE_SIZE - base);
>  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> @@ -1318,7 +1318,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>  	if (stable && !fhp->fh_use_wgather)
>  		kiocb.ki_flags |=3D IOCB_DSYNC;
> =20
> -	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> +	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_bvec_len, payload);
>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>  	since =3D READ_ONCE(file->f_wb_err);
>  	if (verf)
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 5506d20857c318774cd223272d4b0022cc19ffb8..0ee1f411860e55d5e0131c29766=
540f673193d5f 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -206,6 +206,7 @@ struct svc_rqst {
> =20
>  	struct folio_batch	rq_fbatch;
>  	struct bio_vec		*rq_bvec;
> +	u32			rq_bvec_len;
> =20
>  	__be32			rq_xid;		/* transmission id */
>  	u32			rq_prog;	/* program number */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 4704dce7284eccc9e2bc64cf22947666facfa86a..a6bdd83fba77b13f973da66a1ba=
c00050ae922fe 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -706,7 +706,9 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_po=
ol *pool, int node)
>  	if (!svc_init_buffer(rqstp, serv, node))
>  		goto out_enomem;
> =20
> -	rqstp->rq_bvec =3D kcalloc_node(rqstp->rq_maxpages,
> +	/* +1 for the TCP record marker */
> +	rqstp->rq_bvec_len =3D rqstp->rq_maxpages + 1;
> +	rqstp->rq_bvec =3D kcalloc_node(rqstp->rq_bvec_len,
>  				      sizeof(struct bio_vec),
>  				      GFP_KERNEL, node);
>  	if (!rqstp->rq_bvec)
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 377fcaaaa061463fc5c85fc09c7a8eab5e06af77..2075ddec250b3fdb36becca4a53=
f1c0536f8634a 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -740,7 +740,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  	if (svc_xprt_is_dead(xprt))
>  		goto out_notconn;
> =20
> -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
> +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_bvec_len, xdr);
> =20
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
>  		      count, rqstp->rq_res.len);
> @@ -1244,7 +1244,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, str=
uct svc_rqst *rqstp,
>  	memcpy(buf, &marker, sizeof(marker));
>  	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
> =20
> -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages - 1,
> +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_bvec_len - 1,
>  				&rqstp->rq_res);
> =20
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
>=20
> --=20
> 2.51.0
>=20
>=20


