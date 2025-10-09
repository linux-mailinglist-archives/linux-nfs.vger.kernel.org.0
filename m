Return-Path: <linux-nfs+bounces-15079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E55ABC6F85
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 02:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DF93E0952
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 00:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9BCA937;
	Thu,  9 Oct 2025 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzMAUXNy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EBE34BA42;
	Thu,  9 Oct 2025 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759968510; cv=none; b=lYNTUtb7e9WDIkDpuJlJODjLj3ptBM6j5kn6yptyq1tw2wfZp1AL6C67izO8h1AcWo8287oZ/IXeZgBCwPMwuw93XuCBD+mmRk4Aa0soXNzs/07z1pDIcqbnFAVLG3re6NIW/SLVGhpKT17+5kIgsiBXTmmelHkvJwmNjdOkOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759968510; c=relaxed/simple;
	bh=RRZXrNuIw6gLiN1SGAlNvE5ACv0QPD1NDyMhwKATA3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIIz644/ezoCsP1kAAwrd2oAEysaxJ5RkV9RqvHRtQHwoTuPa7kWdhLEZ46tONuM30gBF2xDwnEplA32ylMFqJtjcm14roqdlrZwnZukw5se206WBwF3jfewrnpEwIXSNY7mL/3Rc9QlZC09QXTc+0JhkdH06TaEJ9ZuUC2IfWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzMAUXNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A739C4CEE7;
	Thu,  9 Oct 2025 00:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759968509;
	bh=RRZXrNuIw6gLiN1SGAlNvE5ACv0QPD1NDyMhwKATA3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzMAUXNyzsxWY5WBUGnzCV6B6u4g0Rl/l19ZiSktFaYr64VUJ/A95XPsKlmNamAc6
	 1C0245k3gH8+IxMWrl3ROhu2jZ5W8kO/YSx5s3N0hZqDgrDEAKlP4mTQt56/8is+ET
	 Rsw7BnbXs9yjs2xaYyGjJ94SoXtCziO0R0plqEVFITBLd6Ndt/D/Mk9Dz9/HONT9b8
	 tLFWHMZRC0m9Z2OLl6eVR5H+HEbhypvE2uEtTaK1NQ15Gfbli5PFSqaUxALBXmabV/
	 LZjfY4oOI1fSg1NvFwQ9DEbt5OwuAnwME7lDl81o0xpdTZalmRnc//NwvUNDk61ZF8
	 AvnUKrAcEpTKA==
Date: Wed, 8 Oct 2025 20:08:27 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP
 record marker
Message-ID: <aOb8-3C6y3wV9sIH@kernel.org>
References: <20251008-rq_bvec-v2-0-823c0a85a27c@kernel.org>
 <20251008-rq_bvec-v2-2-823c0a85a27c@kernel.org>
 <175996028564.1793333.11431539077389693375@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175996028564.1793333.11431539077389693375@noble.neil.brown.name>

On Thu, Oct 09, 2025 at 08:51:25AM +1100, NeilBrown wrote:
> On Thu, 09 Oct 2025, Jeff Layton wrote:
> > We've seen some occurrences of messages like this in dmesg on some knfsd
> > servers:
> > 
> >     xdr_buf_to_bvec: bio_vec array overflow
> > 
> > Usually followed by messages like this that indicate a short send (note
> > that this message is from an older kernel and the amount that it reports
> > attempting to send is short by 4 bytes):
> > 
> >     rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - shutting down socket
> > 
> > svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP record
> > marker. If the send is an unaligned READ call though, then there may not
> > be enough slots in the rq_bvec array in some cases.
> > 
> > Add a slot to the rq_bvec array, and fix up the array lengths in the
> > callers that care.
> > 
> > Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call")
> > Tested-by: Brandon Adams <brandona@meta.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/vfs.c        | 6 +++---
> >  net/sunrpc/svc.c     | 3 ++-
> >  net/sunrpc/svcsock.c | 4 ++--
> >  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> I can't say that I'm liking this patch.
> 
> There are 11 place where (in nfsd-testing recently) where
> rq_maxpages is used (as opposed to declared or assigned).
> 
> 3 in nfsd/vfs.c
> 4 in sunrpc/svc.c
> 1 in sunrpc/svc_xprt.c
> 2 in sunrpc/svcsock.c
> 1 in xprtrdma/svc_rdma_rc.c
> 
> Your patch changes six of those to add 1.  I guess the others aren't
> "callers that care".  It would help to have it clearly stated why, or
> why not, a caller might care.
> 
> But also, what does "rq_maxpages" even mean now?
> The comment in svc.h still says "num of entries in rq_pages"
> which is certainly no longer the case.
> But if it was the case, we should have called it "rq_numpages"
> or similar.
> But maybe it wasn't meant to be the number of pages in the array,
> maybe it was meant to be the maximum number of pages is a request
> or a reply.....
> No - that is sv_max_mesg, to which we add 2 and 1.
> So I could ask "why not just add another 1 in svc_serv_maxpages()?"
> Would the callers that might not care be harmed if rq_maxpages were
> one larger than it is?
> 
> It seems to me that rq_maxpages is rather confused and the bug you have
> found which requires this patch is some evidence to that confusion.  We
> should fix the confusion, not just the bug.
> 
> So simple question to cut through my waffle:
> Would this:
> -	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
> +	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
> 
> fix the problem.  If not, why not?  If so, can we just do this?
> then look at renaming rq_maxpages to rq_numpages and audit all the uses
> (and maybe you have already audited...).

Right, I recently wanted to do the same:
https://lore.kernel.org/linux-nfs/20250909233315.80318-2-snitzer@kernel.org/

Certainly cleaner and preferable to me.

Otherwise the +1 sprinkled selectively is really prone to be a problem
for any new users of rq_maxpages.

Mike

