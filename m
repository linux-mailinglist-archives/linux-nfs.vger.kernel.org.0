Return-Path: <linux-nfs+bounces-15115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E85BCB42F
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 02:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099B83A61EC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 00:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B926AC3;
	Fri, 10 Oct 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="FBfD7cRI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wcw6eCbq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47641BC2A;
	Fri, 10 Oct 2025 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760055031; cv=none; b=G1K3J4+K0/v4tDXGBVkCl1lHt2jKwb9mHhOgG39ycLDweZCeMVplce+W+Vv7TE+vqTpyTz9htK3oVJJGF5sCrbz5rivEM0f16uJscKFQewy55X/4kbxAFjxYXO7hh9HRYddRY4s7Cij2/ex16RxGSns1jdAYEAsQ2S1GS+DqS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760055031; c=relaxed/simple;
	bh=ILO6mk9xMKJYjMG/ztxFdn243CQQZsFxR9A7pMa3iwc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FAxzi2gcIhu1HryTL4WSzXnSEV8L/gBKNOPAAH9Lze1kLjPI60PG5GZjcZdIz1Lqic+40MABR5q0o5Wq0HiSb96SqomtafPIeVP+7Tuo5r1VwXv4d7LZ7hkzstWb2TJD7oCBaQH2hZOnmnB8j0upXXeqjSBCZLT+EQ/31FonuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FBfD7cRI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wcw6eCbq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 64E167A00CB;
	Thu,  9 Oct 2025 20:10:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 20:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760055027; x=1760141427; bh=/rIslGpp5X3plNPgeuvixOqik8qIg2/1lu+
	r9KnPNNk=; b=FBfD7cRIM1eMUe95Z5kDH9R0/Ygf1UlqsF0h6/84z0tPPGGk2Aq
	hj1rjguWebbFmGSY7Nxs0JIyZK0JVcdX7YMcgdFzOv+zlLvlfa51T7+qVzhVdyrG
	bKzbhNBUKG0QoEBe24MeEl+B4oxlBBHwJqPx/fjSEI74J5B/IByq+xW0VZ7vHY+E
	P3Nb9nVkGeHcOsC4MRBNkRU7PhSErEHiRsWe9QNKL83PJ65/iDfDwkVfjO/6dy2t
	IwDjETer/xEoaNBHXDUv3qFqCkB673Ux2kREhciFy5KUOGyut2OdyGiWyNHnmHBO
	473P2aHpjqNB8EnwgXcuedd2/yJasc30nDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760055027; x=
	1760141427; bh=/rIslGpp5X3plNPgeuvixOqik8qIg2/1lu+r9KnPNNk=; b=w
	cw6eCbqJYh9MCL0OqaikZgHysUoJyOpQXzqZu5yLENOElTnfPJxc/AfdjjMWxK3b
	xJVWP0XW91r2lywXYLDY1j+tyxSKCqO3wKSr1+/yjCXZ4MNJNnrPkjAJWbsFwiCc
	ropRJtG8QpvUlUO3I2XA8xyMWh+KE4uom1b6AbmlJt+gTJgZP+MgrjhgMa1Qo8OQ
	Xw13KxqRmJcfv/+nUhxbhSKYDZ7NhqtDsb17YKvcHitSX7v2dk7QAe6VJGYBC6qG
	jL6AJeQRJC+XcGv7Yv+ytA3bLpsVEo1wOR8u6gmr6GDJJn/XB9y8HRsv1wv/h4TR
	RXS7cQU/l8eUge8KjBtDg==
X-ME-Sender: <xms:8k7oaMjUbHWpGYmiTIY1-IcFIdhHwSeAitTti-zrSf4WQijstmeoFA>
    <xme:8k7oaF_HGpvL7bMvFw_hwEZ0-mmlwh63uO-rJYrtuzv94EkHZAHfzw1C7Lwkd5TmN
    K_IQwvslmSX9uFc-pdJKnzwq5Ep-37PNvMnIcPRBRjTV4sG7Q>
X-ME-Received: <xmr:8k7oaEZDxyXL3wK54UvjqlORWCl7rEfbgvb5ACqqc-Op66NRWs5w_gbOB8HfdKyfm-gzYnCGQEkVNefvsk1eM8FNhUt074lBviWs3HVMH9TP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejheekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8k7oaLtSUoL55rnpdiH74yDJBxZYQlaar0S3RkP-0-UnYbJO1bCogA>
    <xmx:8k7oaAneupu_bVCTfnygf1qNWM5Xik-g1gMEBlkqhI1EwL8LASOebw>
    <xmx:8k7oaLxenfkQjnj-FdY43vvZzdSAMVOKd6fpRCNnRlaYv3H0nyMlYA>
    <xmx:8k7oaEzaT8uGbhdLbpaUmNlgvlPwfwq0QQsxTfOIyQXbHQgfHU6EBw>
    <xmx:807oaG1VOBx_ZBpLtGc-EbOP6FmkkvNEhMQTeGkfmfvJKe8EreNNNdy8>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 20:10:22 -0400 (EDT)
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
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP record marker
In-reply-to: <74e20200de3d113c0bced1380c0ce99a569c2892.camel@kernel.org>
References: <>, <74e20200de3d113c0bced1380c0ce99a569c2892.camel@kernel.org>
Date: Fri, 10 Oct 2025 11:10:20 +1100
Message-id: <176005502018.1793333.5043420085151021396@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 09 Oct 2025, Jeff Layton wrote:
> On Thu, 2025-10-09 at 08:51 +1100, NeilBrown wrote:
> > On Thu, 09 Oct 2025, Jeff Layton wrote:
> > > We've seen some occurrences of messages like this in dmesg on some knfsd
> > > servers:
> > >=20
> > >     xdr_buf_to_bvec: bio_vec array overflow
> > >=20
> > > Usually followed by messages like this that indicate a short send (note
> > > that this message is from an older kernel and the amount that it reports
> > > attempting to send is short by 4 bytes):
> > >=20
> > >     rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - shutti=
ng down socket
> > >=20
> > > svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP record
> > > marker. If the send is an unaligned READ call though, then there may not
> > > be enough slots in the rq_bvec array in some cases.
> > >=20
> > > Add a slot to the rq_bvec array, and fix up the array lengths in the
> > > callers that care.
> > >=20
> > > Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single soc=
k_sendmsg() call")
> > > Tested-by: Brandon Adams <brandona@meta.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/vfs.c        | 6 +++---
> > >  net/sunrpc/svc.c     | 3 ++-
> > >  net/sunrpc/svcsock.c | 4 ++--
> > >  3 files changed, 7 insertions(+), 6 deletions(-)
> >=20
> > I can't say that I'm liking this patch.
> >=20
> > There are 11 place where (in nfsd-testing recently) where
> > rq_maxpages is used (as opposed to declared or assigned).
> >=20
> > 3 in nfsd/vfs.c
> > 4 in sunrpc/svc.c
> > 1 in sunrpc/svc_xprt.c
> > 2 in sunrpc/svcsock.c
> > 1 in xprtrdma/svc_rdma_rc.c
> >=20
> > Your patch changes six of those to add 1.  I guess the others aren't
> > "callers that care".  It would help to have it clearly stated why, or
> > why not, a caller might care.
> >=20
> > But also, what does "rq_maxpages" even mean now?
> > The comment in svc.h still says "num of entries in rq_pages"
> > which is certainly no longer the case.
> > But if it was the case, we should have called it "rq_numpages"
> > or similar.
> > But maybe it wasn't meant to be the number of pages in the array,
> > maybe it was meant to be the maximum number of pages is a request
> > or a reply.....
> > No - that is sv_max_mesg, to which we add 2 and 1.
> > So I could ask "why not just add another 1 in svc_serv_maxpages()?"
> > Would the callers that might not care be harmed if rq_maxpages were
> > one larger than it is?
> >=20
> > It seems to me that rq_maxpages is rather confused and the bug you have
> > found which requires this patch is some evidence to that confusion.  We
> > should fix the confusion, not just the bug.
> >=20
> > So simple question to cut through my waffle:
> > Would this:
> > -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
> > +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
> >=20
> > fix the problem.  If not, why not?  If so, can we just do this?
> > then look at renaming rq_maxpages to rq_numpages and audit all the uses
> > (and maybe you have already audited...).
> >=20
>=20
> I get the objection. I'm not crazy about all of the adjustments either.
>=20
> rq_maxpages is used to size two fields in the rqstp: rq_pages and
> rq_bvec. It turns out that they both want rq_maxpages + 1 slots. The
> rq_pages array needs the extra slot for a NULL terminator, and rq_bvec
> needs it for the TCP record marker.

Somehow the above para helped a lot for me to understand what the issue
is here - thanks.

rq_bvec is used for two quite separate purposes.

nfsd/vfs.c uses it to assemble read/write requests to send to the
filesystem.
sunrpc/svcsock.c uses to assemble send/recv requests to send to the
network.

It might help me if this were documented clearly in svc.h as I seem to
have had to discover several times now :-(

Should these even use the same rq_bvec?  I guess it makes sense to share
but we should be cautious about letting the needs of one side infect the
code of the other side.

So if we increase the size of rq_bvec to meet the needs of svcsock.c, do
we need to make *any* code changes to vfs.c?  I doubt it.

It bothers me a little bit that svc_tcp_sendmsg() needs to allocate a
frag.  But given that it does, could it also allocate a larger bvec if
rq_bvec isn't big enough?

Or should svc_tcp_recvfrom() allocate the frag and make sure the bvec is
big enough ......
Or svc_alloc_arg() could check with each active transport for any
preallocation requirements...
Or svc_create_socket() could update some "bvec_size" field in svc_serv
which svc_alloc_arg() could check an possibly realloc rq_bvec.

I'm rambling a bit here.  I agree with Chuck (and you) that it would be
nice if this need for a larger bvec were kept local to svcsock code if
possible.

But I'm fairly confident that the current problem doesn't justify any
changes to vfs.c.  svc.c probably needs to somehow be involved in
rq_bvec being bigger and svcsock.c certainly needs to be able to make
use of the extra space, but that seems to be all that is required.

Thanks,
NeilBrown


>=20
> The RPC code mostly ignores the last slot in rq_pages array after it's
> allocated, but we need rq_bvec to treat it like any other slot, hence
> the adjustment here.
>=20
> I looked at just doing what you suggest first. It would fix it, but at
> the expense of keeping an extra page per nfsd thread. We could couple
> your suggested fix with just not allocating that last rq_pages slot,
> but we end up having to adjust more places than this change does. Also,
> at that point, rq_maxpages is not _really_ the max number of pages.
>=20
> Maybe what we need to do is move to a separate length field for
> rq_bvec? We have some existing holes in svc_rqst that could hold one
> and that would make the code more clear. I'll respin this and see how
> that looks.
>=20
> Thanks for the review!
>=20
> >=20
> >=20
> > >=20
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index 77f6879c2e063fa79865100bbc2d1e64eb332f42..c4e9300d657cf7fdba23f2f=
4e4bdaad9cd99d1a3 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -1111,7 +1111,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> > > =20
> > >  	v =3D 0;
> > >  	total =3D dio_end - dio_start;
> > > -	while (total && v < rqstp->rq_maxpages &&
> > > +	while (total && v < rqstp->rq_maxpages + 1 &&
> > >  	       rqstp->rq_next_page < rqstp->rq_page_end) {
> > >  		len =3D min_t(size_t, total, PAGE_SIZE);
> > >  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> > > @@ -1200,7 +1200,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, str=
uct svc_fh *fhp,
> > > =20
> > >  	v =3D 0;
> > >  	total =3D *count;
> > > -	while (total && v < rqstp->rq_maxpages &&
> > > +	while (total && v < rqstp->rq_maxpages + 1 &&
> > >  	       rqstp->rq_next_page < rqstp->rq_page_end) {
> > >  		len =3D min_t(size_t, total, PAGE_SIZE - base);
> > >  		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> > > @@ -1318,7 +1318,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
> > >  	if (stable && !fhp->fh_use_wgather)
> > >  		kiocb.ki_flags |=3D IOCB_DSYNC;
> > > =20
> > > -	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload=
);
> > > +	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages + 1, pay=
load);
> > >  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > >  	since =3D READ_ONCE(file->f_wb_err);
> > >  	if (verf)
> > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > index 4704dce7284eccc9e2bc64cf22947666facfa86a..919263a0c04e3f1afa60741=
4bc1893ba02206e38 100644
> > > --- a/net/sunrpc/svc.c
> > > +++ b/net/sunrpc/svc.c
> > > @@ -706,7 +706,8 @@ svc_prepare_thread(struct svc_serv *serv, struct sv=
c_pool *pool, int node)
> > >  	if (!svc_init_buffer(rqstp, serv, node))
> > >  		goto out_enomem;
> > > =20
> > > -	rqstp->rq_bvec =3D kcalloc_node(rqstp->rq_maxpages,
> > > +	/* +1 for the TCP record marker */
> > > +	rqstp->rq_bvec =3D kcalloc_node(rqstp->rq_maxpages + 1,
> > >  				      sizeof(struct bio_vec),
> > >  				      GFP_KERNEL, node);
> > >  	if (!rqstp->rq_bvec)
> > > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > > index 377fcaaaa061463fc5c85fc09c7a8eab5e06af77..5f8bb11b686bcd7302b9447=
6490ba9b1b9ddc06a 100644
> > > --- a/net/sunrpc/svcsock.c
> > > +++ b/net/sunrpc/svcsock.c
> > > @@ -740,7 +740,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
> > >  	if (svc_xprt_is_dead(xprt))
> > >  		goto out_notconn;
> > > =20
> > > -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
> > > +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages + 1, xdr=
);
> > > =20
> > >  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> > >  		      count, rqstp->rq_res.len);
> > > @@ -1244,7 +1244,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk,=
 struct svc_rqst *rqstp,
> > >  	memcpy(buf, &marker, sizeof(marker));
> > >  	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
> > > =20
> > > -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages - 1,
> > > +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages,
> > >  				&rqstp->rq_res);
> > > =20
> > >  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> > >=20
> > > --=20
> > > 2.51.0
> > >=20
> > >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


