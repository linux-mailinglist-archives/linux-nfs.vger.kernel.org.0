Return-Path: <linux-nfs+bounces-15117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3500BCC868
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D2519E63D1
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Oct 2025 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B92EFDA5;
	Fri, 10 Oct 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQeFW2zZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744812EDD6F;
	Fri, 10 Oct 2025 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091919; cv=none; b=otFzdiCy9jsZsLk6SKC+fbRyf+NnFgVuqjuSHzttyICUq1JiVINTkw7/bNyYhsuwAI8YgoMeopik46KvMXYw0tjZKl2dD96dze30DuBD2pn999f66yl+D8FJZEsrSFXl/HCKWlJ+cT/41ITvPqrbvlxAXWTap6UCkdny9hM3JSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091919; c=relaxed/simple;
	bh=MNkwg/xATN/ldK/6IBPyXEvWq0KrI+2Prr5kdlfm4ds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5LETIQwxmvy21y+3PLCH0hBBQVFgn+Q6h5gPB04nMyBWF7OhXR/CXgaNFcbOT6HEbnKbTURz1Rvpt84v6psQvLBcnVmWZ1NxSLId3clNa5JI1tggWai31RZEoUBXqnzzv03IsoHpS6GRkb8NJsyxK4b1P63yMXA9ODAgJX/L2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQeFW2zZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2C9C4CEF1;
	Fri, 10 Oct 2025 10:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760091919;
	bh=MNkwg/xATN/ldK/6IBPyXEvWq0KrI+2Prr5kdlfm4ds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FQeFW2zZKWA4H8Y6oIBrY7cpWydjGZQcUZLu3Up/FA3TFdv3FkaWGWvxzZixX6XSj
	 WtX7w+GjtGsE9NMGbgDFJoDSc7hpgGU3zCs1sgZRsTtTfvy2MTEnUTDWplXw5p1nSW
	 ICpF3wLu8EwpRmRdbCJBa9EXbaxLlUy7psF53dyzEnaWC3k+9g9wD/y0MuylHdz9La
	 5cpOpl+FAb6OUyVb1I9dtsZMoMQThIinLjusW7MVtI+lAR0wjAbnmM/nnHaPc/6XJ2
	 eFFhvgQ+Fc3k0NBIR0oiyNlFqtLGPy7Jv5zZHvnK8GJHGlhMdZgKSZt0J15grbAo1H
	 h5a2Nd8qXusCg==
Message-ID: <8cbef9511c8b70dfcf7cdaa9a620f931ab170faa.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP
 record marker
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia	
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>,  Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>, David Howells
 <dhowells@redhat.com>, Brandon Adams <brandona@meta.com>, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 10 Oct 2025 06:25:16 -0400
In-Reply-To: <176005502018.1793333.5043420085151021396@noble.neil.brown.name>
References: <>, <74e20200de3d113c0bced1380c0ce99a569c2892.camel@kernel.org>
	 <176005502018.1793333.5043420085151021396@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 11:10 +1100, NeilBrown wrote:
> On Thu, 09 Oct 2025, Jeff Layton wrote:
> > On Thu, 2025-10-09 at 08:51 +1100, NeilBrown wrote:
> > > On Thu, 09 Oct 2025, Jeff Layton wrote:
> > > > We've seen some occurrences of messages like this in dmesg on some =
knfsd
> > > > servers:
> > > >=20
> > > >     xdr_buf_to_bvec: bio_vec array overflow
> > > >=20
> > > > Usually followed by messages like this that indicate a short send (=
note
> > > > that this message is from an older kernel and the amount that it re=
ports
> > > > attempting to send is short by 4 bytes):
> > > >=20
> > > >     rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - sh=
utting down socket
> > > >=20
> > > > svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP re=
cord
> > > > marker. If the send is an unaligned READ call though, then there ma=
y not
> > > > be enough slots in the rq_bvec array in some cases.
> > > >=20
> > > > Add a slot to the rq_bvec array, and fix up the array lengths in th=
e
> > > > callers that care.
> > > >=20
> > > > Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single=
 sock_sendmsg() call")
> > > > Tested-by: Brandon Adams <brandona@meta.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/nfsd/vfs.c        | 6 +++---
> > > >  net/sunrpc/svc.c     | 3 ++-
> > > >  net/sunrpc/svcsock.c | 4 ++--
> > > >  3 files changed, 7 insertions(+), 6 deletions(-)
> > >=20
> > > I can't say that I'm liking this patch.
> > >=20
> > > There are 11 place where (in nfsd-testing recently) where
> > > rq_maxpages is used (as opposed to declared or assigned).
> > >=20
> > > 3 in nfsd/vfs.c
> > > 4 in sunrpc/svc.c
> > > 1 in sunrpc/svc_xprt.c
> > > 2 in sunrpc/svcsock.c
> > > 1 in xprtrdma/svc_rdma_rc.c
> > >=20
> > > Your patch changes six of those to add 1.  I guess the others aren't
> > > "callers that care".  It would help to have it clearly stated why, or
> > > why not, a caller might care.
> > >=20
> > > But also, what does "rq_maxpages" even mean now?
> > > The comment in svc.h still says "num of entries in rq_pages"
> > > which is certainly no longer the case.
> > > But if it was the case, we should have called it "rq_numpages"
> > > or similar.
> > > But maybe it wasn't meant to be the number of pages in the array,
> > > maybe it was meant to be the maximum number of pages is a request
> > > or a reply.....
> > > No - that is sv_max_mesg, to which we add 2 and 1.
> > > So I could ask "why not just add another 1 in svc_serv_maxpages()?"
> > > Would the callers that might not care be harmed if rq_maxpages were
> > > one larger than it is?
> > >=20
> > > It seems to me that rq_maxpages is rather confused and the bug you ha=
ve
> > > found which requires this patch is some evidence to that confusion.  =
We
> > > should fix the confusion, not just the bug.
> > >=20
> > > So simple question to cut through my waffle:
> > > Would this:
> > > -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
> > > +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
> > >=20
> > > fix the problem.  If not, why not?  If so, can we just do this?
> > > then look at renaming rq_maxpages to rq_numpages and audit all the us=
es
> > > (and maybe you have already audited...).
> > >=20
> >=20
> > I get the objection. I'm not crazy about all of the adjustments either.
> >=20
> > rq_maxpages is used to size two fields in the rqstp: rq_pages and
> > rq_bvec. It turns out that they both want rq_maxpages + 1 slots. The
> > rq_pages array needs the extra slot for a NULL terminator, and rq_bvec
> > needs it for the TCP record marker.
>=20
> Somehow the above para helped a lot for me to understand what the issue
> is here - thanks.
>=20
> rq_bvec is used for two quite separate purposes.
>=20
> nfsd/vfs.c uses it to assemble read/write requests to send to the
> filesystem.
> sunrpc/svcsock.c uses to assemble send/recv requests to send to the
> network.
>=20
> It might help me if this were documented clearly in svc.h as I seem to
> have had to discover several times now :-(
>=20
> Should these even use the same rq_bvec?  I guess it makes sense to share
> but we should be cautious about letting the needs of one side infect the
> code of the other side.
>=20
> So if we increase the size of rq_bvec to meet the needs of svcsock.c, do
> we need to make *any* code changes to vfs.c?  I doubt it.
>=20
> It bothers me a little bit that svc_tcp_sendmsg() needs to allocate a
> frag.  But given that it does, could it also allocate a larger bvec if
> rq_bvec isn't big enough?
>=20
> Or should svc_tcp_recvfrom() allocate the frag and make sure the bvec is
> big enough ......
> Or svc_alloc_arg() could check with each active transport for any
> preallocation requirements...
> Or svc_create_socket() could update some "bvec_size" field in svc_serv
> which svc_alloc_arg() could check an possibly realloc rq_bvec.
>=20
> I'm rambling a bit here.  I agree with Chuck (and you) that it would be
> nice if this need for a larger bvec were kept local to svcsock code if
> possible.
>=20
> But I'm fairly confident that the current problem doesn't justify any
> changes to vfs.c.  svc.c probably needs to somehow be involved in
> rq_bvec being bigger and svcsock.c certainly needs to be able to make
> use of the extra space, but that seems to be all that is required.
>=20

I sent a v3 patch which adds a separate rq_bvec_len field and uses that
in the places where the code is iterating over the rq_bvec. That does
change places in vfs.c, but I think it makes the code clearer. Are you
OK with that version?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>

