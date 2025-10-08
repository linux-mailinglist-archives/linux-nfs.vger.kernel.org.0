Return-Path: <linux-nfs+bounces-15075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68040BC6B53
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 23:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E007734960A
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 21:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1582C11E6;
	Wed,  8 Oct 2025 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="firdlSEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RfKzIlxO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E72C11E2;
	Wed,  8 Oct 2025 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960295; cv=none; b=tL4iOSEfupje4ZKAOfSn7Lx2/8cvbhCvsxhffx1PxVNl5UAz1j0STTgkBk3R+nCVJVcNbWIfiwbvNI+dLKY9MeVXnfWW4OJjnkFJX0Q3cA7pXqdFCEs6ZH33HVuVUJToVudsDHuK2SncSMkY1WjDKVpm00UUhot034PuDg8bulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960295; c=relaxed/simple;
	bh=JgqxLekimCzzWFk3XbrVmtAd7ZdS+CuNlCW4JmfAqdw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XMoHk+VUBZc4kgPgxfJJhi9UvqTIixQ3uOcgFZfltYqWdSwkjOeHaeBgmurfoTfQgxvNesPULk+IhMpqwta5pWGA1HB9HC5/3uUzgVHbOVCVOFyAemq72GQVxCM8pU+48ZU7Zv+5+d/LH4C+VskpyVMyxG90yOmnv6bn+3+JY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=firdlSEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RfKzIlxO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A310EC0277;
	Wed,  8 Oct 2025 17:51:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Oct 2025 17:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759960292; x=1760046692; bh=C0UcEy3s3N2N9VtG1+Jnhg5QL7Pw7mUWAVt
	NL/r+tns=; b=firdlSEl1lJ1EiPM5L2/ZkuqpF5ThgZtm0FSw1A+tUd3na36Bl1
	UR7M5VlZ9nd25jwTzZEdOVgwLslhtuGZ/Y467N/jVsv9FxJ+ShpKwWvbQ4xWuoUI
	cEigsu48uFD3Wk26iX3ztLSZWk1fsNaFTrqknJs/6FBp0e5qTn9INlcYB5TT9M/+
	CzJ+BnOcgLsM6kpKu6hIddEuCsa7/en66bbqsOm/D9tGErN46QJoc5NwroIeV+1O
	z+2UeXMYCQsGqZlqGjKG9tqwWK+2ECD9ICxvWjh5ojE21M5R4YGswu3KKLgW753l
	ugx9Cd58pSyBG1GRXRwiaRqxmqox6M6Zdvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759960292; x=
	1760046692; bh=C0UcEy3s3N2N9VtG1+Jnhg5QL7Pw7mUWAVtNL/r+tns=; b=R
	fKzIlxOAVBysbwi5SChR5LCRxQ26oHbsGMwWGif1A7W0AqeQe8nHVkGHwTL6aZ6I
	NsWeXlouQ+TsXZhtWL311O51rYzZRlu/dZnLLb6WVblb7MfG7jQielZ9cgb6VcdO
	WUL8yvfwXY6677KLGTokbZFppD4Vj8T8USbSadGxxtJ6KJpxlSV0EimmR953FDfA
	PexaRE6ckx+YfMVy7o2oif2iZhmJExBQmqCschJOLiuYDfcpqjn7Phd7HKwzlPqN
	sXALziBDeqIUMAEAOKptK0+xrqJAoKbCoCjSKWTzl5WWIdDmEQtn9qdq0PTOCCqn
	rieYFMXGkG2c4b6+e17wQ==
X-ME-Sender: <xms:49zmaLu5eS2K2uMUU33QpvaQSLXTxxgVGQ7C-TurGlmHS_REmrT1FQ>
    <xme:49zmaHIcw_pS0phYfgLSxximpbq3WeAxSM__ZCRCsiln6KZ71iAx2tkumMUtSdTCO
    lg346fvD1x-voqJUHVzUpB4iiB4UdBY9Tp6aa3lpzXnMyVkgQ>
X-ME-Received: <xmr:49zmaHdSO9MHCxZMBUF63VpQmtrQU4CXOdmt1AfkKUOCACDorGSeF6x9ya42e6nvyyx1_-wDyIoz47p93HYhFzmURDIaKVzGKT4E3mTXVhTH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeggedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:49zmaBWpAi5xlqhOuMSNiC7OUh1TzrAj3_xk9Y0xC_60cL2c7bQJcQ>
    <xmx:49zmaNiaq1lGopw1IcQa_AKiBFq9sBegkmzOZgKy8CiAfClLHc6JPA>
    <xmx:49zmaDiaMC2PJHS33FkeB43W7aqkBwxiQ00wRRNSKnfc1YlR0pmwqQ>
    <xmx:49zmaKvShcZKtmk7f2a2s6fZZ7lV663qa6ve0tBd8tAvBSm1KcFnLQ>
    <xmx:5NzmaE3QOdiAALtKxgQaqOLH_NX3sY-yKKsDACA9NIbwoQdaJhuIug5M>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 17:51:27 -0400 (EDT)
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
 Re: [PATCH v2 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP record marker
In-reply-to: <20251008-rq_bvec-v2-2-823c0a85a27c@kernel.org>
References: <20251008-rq_bvec-v2-0-823c0a85a27c@kernel.org>,
 <20251008-rq_bvec-v2-2-823c0a85a27c@kernel.org>
Date: Thu, 09 Oct 2025 08:51:25 +1100
Message-id: <175996028564.1793333.11431539077389693375@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 09 Oct 2025, Jeff Layton wrote:
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
> Add a slot to the rq_bvec array, and fix up the array lengths in the
> callers that care.
>=20
> Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_se=
ndmsg() call")
> Tested-by: Brandon Adams <brandona@meta.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c        | 6 +++---
>  net/sunrpc/svc.c     | 3 ++-
>  net/sunrpc/svcsock.c | 4 ++--
>  3 files changed, 7 insertions(+), 6 deletions(-)

I can't say that I'm liking this patch.

There are 11 place where (in nfsd-testing recently) where
rq_maxpages is used (as opposed to declared or assigned).

3 in nfsd/vfs.c
4 in sunrpc/svc.c
1 in sunrpc/svc_xprt.c
2 in sunrpc/svcsock.c
1 in xprtrdma/svc_rdma_rc.c

Your patch changes six of those to add 1.  I guess the others aren't
"callers that care".  It would help to have it clearly stated why, or
why not, a caller might care.

But also, what does "rq_maxpages" even mean now?
The comment in svc.h still says "num of entries in rq_pages"
which is certainly no longer the case.
But if it was the case, we should have called it "rq_numpages"
or similar.
But maybe it wasn't meant to be the number of pages in the array,
maybe it was meant to be the maximum number of pages is a request
or a reply.....
No - that is sv_max_mesg, to which we add 2 and 1.
So I could ask "why not just add another 1 in svc_serv_maxpages()?"
Would the callers that might not care be harmed if rq_maxpages were
one larger than it is?

It seems to me that rq_maxpages is rather confused and the bug you have
found which requires this patch is some evidence to that confusion.  We
should fix the confusion, not just the bug.

So simple question to cut through my waffle:
Would this:
-	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
+	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;

fix the problem.  If not, why not?  If so, can we just do this?
then look at renaming rq_maxpages to rq_numpages and audit all the uses
(and maybe you have already audited...).

Thanks,
NeilBrown


>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 77f6879c2e063fa79865100bbc2d1e64eb332f42..c4e9300d657cf7fdba23f2f4e4b=
daad9cd99d1a3 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1111,7 +1111,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> =20
>  	v =3D 0;
>  	total =3D dio_end - dio_start;
> -	while (total && v < rqstp->rq_maxpages &&
> +	while (total && v < rqstp->rq_maxpages + 1 &&
>  	       rqstp->rq_next_page < rqstp->rq_page_end) {
>  		len =3D min_t(size_t, total, PAGE_SIZE);
>  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> @@ -1200,7 +1200,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> =20
>  	v =3D 0;
>  	total =3D *count;
> -	while (total && v < rqstp->rq_maxpages &&
> +	while (total && v < rqstp->rq_maxpages + 1 &&
>  	       rqstp->rq_next_page < rqstp->rq_page_end) {
>  		len =3D min_t(size_t, total, PAGE_SIZE - base);
>  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> @@ -1318,7 +1318,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh =
*fhp,
>  	if (stable && !fhp->fh_use_wgather)
>  		kiocb.ki_flags |=3D IOCB_DSYNC;
> =20
> -	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> +	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages + 1, payload=
);
>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>  	since =3D READ_ONCE(file->f_wb_err);
>  	if (verf)
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 4704dce7284eccc9e2bc64cf22947666facfa86a..919263a0c04e3f1afa607414bc1=
893ba02206e38 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -706,7 +706,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_po=
ol *pool, int node)
>  	if (!svc_init_buffer(rqstp, serv, node))
>  		goto out_enomem;
> =20
> -	rqstp->rq_bvec =3D kcalloc_node(rqstp->rq_maxpages,
> +	/* +1 for the TCP record marker */
> +	rqstp->rq_bvec =3D kcalloc_node(rqstp->rq_maxpages + 1,
>  				      sizeof(struct bio_vec),
>  				      GFP_KERNEL, node);
>  	if (!rqstp->rq_bvec)
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 377fcaaaa061463fc5c85fc09c7a8eab5e06af77..5f8bb11b686bcd7302b94476490=
ba9b1b9ddc06a 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -740,7 +740,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
>  	if (svc_xprt_is_dead(xprt))
>  		goto out_notconn;
> =20
> -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
> +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages + 1, xdr);
> =20
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
>  		      count, rqstp->rq_res.len);
> @@ -1244,7 +1244,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, str=
uct svc_rqst *rqstp,
>  	memcpy(buf, &marker, sizeof(marker));
>  	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
> =20
> -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages - 1,
> +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages,
>  				&rqstp->rq_res);
> =20
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
>=20
> --=20
> 2.51.0
>=20
>=20


