Return-Path: <linux-nfs+bounces-15118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E4BCC97E
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 12:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D46724E1B8A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688FD28466D;
	Fri, 10 Oct 2025 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="xszJsjbv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B3fGNoVJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E33BA3F;
	Fri, 10 Oct 2025 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093280; cv=none; b=lbnpjyznpT78G5IrHt4Oskqdr83c8vYR0pQXPOQQPt11HacICqZyWJo95Oq7hoMxmaiIaCWa/h9H8uI1aAH77dLV8tKwITaT294c8Wq3wbRiGFe07rBHjlDxrEuzpTqcjGvRt229HzGNF+3bYG1XmpJpbX+Ibpn+enem+x1AsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093280; c=relaxed/simple;
	bh=phKAygcCHq5E5DNocoYzByqQdzOTV1jDLrVnQWjgKFc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rsPGpPYwYCHgn5as1/bU1+idagW1tV/AVGBYYMySodBT2/FJHHAdSeD5sE9L3UqvUyZwSqzw6CWa+l2MiodzOQxMHi615UwOb7pz2TWV7iocF6nTAIglNc3HeNy8OzBb/LaJ6DQ6rZUfVF3sfagv98op5ytbpKQ+8OTHBO2SQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=xszJsjbv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B3fGNoVJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A43E2140002F;
	Fri, 10 Oct 2025 06:47:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Oct 2025 06:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760093276; x=1760179676; bh=LExDmiF7iRBPhdv/4uvxxSe04Ic7f+Yd8wI
	CU190Iac=; b=xszJsjbvdIirmw0tyngHbK53+w9lsE+9jnUSSz1KcaZvmdHWKyk
	oWZAXI9fcj99QBqW3zREItFucaG88UKZ35GU6+srBww+Vnt9Vvw6TUvHnSEIVBeX
	2cCY6eWBq+/qJoDkaWq3Z8tVA28rWKNBSXhOAm4YFOIXJSypvLaqZb4RDc1u8ezm
	kfO1y2J4mbExW2QBeJqwwY/x2UucxLxbqXz7JLB0nHE413bQxyL8wCd5J1O+gI9h
	GZhv2kV2przHerhD4ukIoxwajKRNynlxkz+N/+J5z0dbdTTBkZT149ZyKCOwxK2C
	xlR+m4wQ5KtUvGxV9riK+vI3N6LdF1e+4iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760093276; x=
	1760179676; bh=LExDmiF7iRBPhdv/4uvxxSe04Ic7f+Yd8wICU190Iac=; b=B
	3fGNoVJsJARCfYuhSaSJ5jofIBOJTWoiBzXzL4EG4xBbx6VG7pFz9Z7eJ5LmnucZ
	t4xb2cbynY9cfLcp/qgGm17Q5Bf8F0+Q2pneimISMaw7s9txBIp4dw9PoEr0k2pe
	Qbl9yLS9bjN/u487X1nmVaZnzE3QRhRYfIVAafU8MOLPOEaFS0yQWio4eL58Xxxs
	zc9FLoPfpyigSIrB72JUrZNnQ/ABA6UzzIFWdbVT/51WXXjMQzHUrKcOTnFUpO/c
	VWJr6YpEUN7IH3O2e7mHJ+OtA/cNod9u6Cy6PR4l8NoxGTP6grkNkZ8P3Ug+3xNQ
	X0e4AKtBHT/UMzsKjsyzw==
X-ME-Sender: <xms:XOToaNa1xZ5bIlRtFvOwsZoPFOy1c7xeskrpVLFC2LuxQZ4AQ8Npow>
    <xme:XOToaPG1gU9T2Vou-q2FFnWIuaL8ZwBHCjh01v1jnss5Gke-Eb1zRh3Nc4z2inchl
    -XlXiiRl_1KANvoyUVDRtIp9a92s1B-DMTgLBWgPkpJLF2TcQ>
X-ME-Received: <xmr:XOToaIrHXslwBpeOjG5Zmgf6ziWgNFnGAk4sqZ5KxsuBqgqunfuIpGlzTzlFr5W4dZ7SDHXb6Lk72afxNgwP6ZOtwTxfYIE7GS3mHV8ixQq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekkeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:XOToaCyUzj3OGBkGL7qzV8womnybPiS9oQsXmQx2g-G5ozrfLsy1yA>
    <xmx:XOToaKNd6fMeXBAGBHlGGI0333Qg0xZRjN17bjlViU2VkZAPqkN4Ig>
    <xmx:XOToaKfsovNA4hFNLDWP1MeV1hjko-LC-75iJGusO-wIPTcuMgwLcA>
    <xmx:XOToaO6lljvBLiP95pHOZQPVqN9kjU6DSYwT9b8dlV0-BMCubM-mKg>
    <xmx:XOToaLwAv_xHOB9NHNnwEe8PVIaE78JER5r_tTOmaZ-gKPyOjeRj19YX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 06:47:50 -0400 (EDT)
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
In-reply-to: <8cbef9511c8b70dfcf7cdaa9a620f931ab170faa.camel@kernel.org>
References: <>, <>,
 <74e20200de3d113c0bced1380c0ce99a569c2892.camel@kernel.org>,
 <176005502018.1793333.5043420085151021396@noble.neil.brown.name>,
 <8cbef9511c8b70dfcf7cdaa9a620f931ab170faa.camel@kernel.org>
Date: Fri, 10 Oct 2025 21:47:42 +1100
Message-id: <176009326228.1793333.8127990928981202919@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 10 Oct 2025, Jeff Layton wrote:
> On Fri, 2025-10-10 at 11:10 +1100, NeilBrown wrote:
> > On Thu, 09 Oct 2025, Jeff Layton wrote:
> > > On Thu, 2025-10-09 at 08:51 +1100, NeilBrown wrote:
> > > > On Thu, 09 Oct 2025, Jeff Layton wrote:
> > > > > We've seen some occurrences of messages like this in dmesg on some =
knfsd
> > > > > servers:
> > > > >=20
> > > > >     xdr_buf_to_bvec: bio_vec array overflow
> > > > >=20
> > > > > Usually followed by messages like this that indicate a short send (=
note
> > > > > that this message is from an older kernel and the amount that it re=
ports
> > > > > attempting to send is short by 4 bytes):
> > > > >=20
> > > > >     rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - sh=
utting down socket
> > > > >=20
> > > > > svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP re=
cord
> > > > > marker. If the send is an unaligned READ call though, then there ma=
y not
> > > > > be enough slots in the rq_bvec array in some cases.
> > > > >=20
> > > > > Add a slot to the rq_bvec array, and fix up the array lengths in the
> > > > > callers that care.
> > > > >=20
> > > > > Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single=
 sock_sendmsg() call")
> > > > > Tested-by: Brandon Adams <brandona@meta.com>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/nfsd/vfs.c        | 6 +++---
> > > > >  net/sunrpc/svc.c     | 3 ++-
> > > > >  net/sunrpc/svcsock.c | 4 ++--
> > > > >  3 files changed, 7 insertions(+), 6 deletions(-)
> > > >=20
> > > > I can't say that I'm liking this patch.
> > > >=20
> > > > There are 11 place where (in nfsd-testing recently) where
> > > > rq_maxpages is used (as opposed to declared or assigned).
> > > >=20
> > > > 3 in nfsd/vfs.c
> > > > 4 in sunrpc/svc.c
> > > > 1 in sunrpc/svc_xprt.c
> > > > 2 in sunrpc/svcsock.c
> > > > 1 in xprtrdma/svc_rdma_rc.c
> > > >=20
> > > > Your patch changes six of those to add 1.  I guess the others aren't
> > > > "callers that care".  It would help to have it clearly stated why, or
> > > > why not, a caller might care.
> > > >=20
> > > > But also, what does "rq_maxpages" even mean now?
> > > > The comment in svc.h still says "num of entries in rq_pages"
> > > > which is certainly no longer the case.
> > > > But if it was the case, we should have called it "rq_numpages"
> > > > or similar.
> > > > But maybe it wasn't meant to be the number of pages in the array,
> > > > maybe it was meant to be the maximum number of pages is a request
> > > > or a reply.....
> > > > No - that is sv_max_mesg, to which we add 2 and 1.
> > > > So I could ask "why not just add another 1 in svc_serv_maxpages()?"
> > > > Would the callers that might not care be harmed if rq_maxpages were
> > > > one larger than it is?
> > > >=20
> > > > It seems to me that rq_maxpages is rather confused and the bug you ha=
ve
> > > > found which requires this patch is some evidence to that confusion.  =
We
> > > > should fix the confusion, not just the bug.
> > > >=20
> > > > So simple question to cut through my waffle:
> > > > Would this:
> > > > -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
> > > > +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
> > > >=20
> > > > fix the problem.  If not, why not?  If so, can we just do this?
> > > > then look at renaming rq_maxpages to rq_numpages and audit all the us=
es
> > > > (and maybe you have already audited...).
> > > >=20
> > >=20
> > > I get the objection. I'm not crazy about all of the adjustments either.
> > >=20
> > > rq_maxpages is used to size two fields in the rqstp: rq_pages and
> > > rq_bvec. It turns out that they both want rq_maxpages + 1 slots. The
> > > rq_pages array needs the extra slot for a NULL terminator, and rq_bvec
> > > needs it for the TCP record marker.
> >=20
> > Somehow the above para helped a lot for me to understand what the issue
> > is here - thanks.
> >=20
> > rq_bvec is used for two quite separate purposes.
> >=20
> > nfsd/vfs.c uses it to assemble read/write requests to send to the
> > filesystem.
> > sunrpc/svcsock.c uses to assemble send/recv requests to send to the
> > network.
> >=20
> > It might help me if this were documented clearly in svc.h as I seem to
> > have had to discover several times now :-(
> >=20
> > Should these even use the same rq_bvec?  I guess it makes sense to share
> > but we should be cautious about letting the needs of one side infect the
> > code of the other side.
> >=20
> > So if we increase the size of rq_bvec to meet the needs of svcsock.c, do
> > we need to make *any* code changes to vfs.c?  I doubt it.
> >=20
> > It bothers me a little bit that svc_tcp_sendmsg() needs to allocate a
> > frag.  But given that it does, could it also allocate a larger bvec if
> > rq_bvec isn't big enough?
> >=20
> > Or should svc_tcp_recvfrom() allocate the frag and make sure the bvec is
> > big enough ......
> > Or svc_alloc_arg() could check with each active transport for any
> > preallocation requirements...
> > Or svc_create_socket() could update some "bvec_size" field in svc_serv
> > which svc_alloc_arg() could check an possibly realloc rq_bvec.
> >=20
> > I'm rambling a bit here.  I agree with Chuck (and you) that it would be
> > nice if this need for a larger bvec were kept local to svcsock code if
> > possible.
> >=20
> > But I'm fairly confident that the current problem doesn't justify any
> > changes to vfs.c.  svc.c probably needs to somehow be involved in
> > rq_bvec being bigger and svcsock.c certainly needs to be able to make
> > use of the extra space, but that seems to be all that is required.
> >=20
>=20
> I sent a v3 patch which adds a separate rq_bvec_len field and uses that
> in the places where the code is iterating over the rq_bvec. That does
> change places in vfs.c, but I think it makes the code clearer. Are you
> OK with that version?

Hmmm....  yes, I think so.  The bug itself doesn't really need vfs.c to
be changed.  But the deeper bug is that rq_maxpages is being overloaded
to mean multiple things and you are separating rq_bvec_len out from that
meaning, and consistent using rq_bvec_len whenever the length of the
rq_bvec is needed.  So in that sense vfs.c does need changed.

The commit comment could be improved though.  I'll reply separately.

Thanks,
NeilBrown

