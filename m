Return-Path: <linux-nfs+bounces-12448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D47AD94E4
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 20:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0014E1BC2B5A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 18:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D8233134;
	Fri, 13 Jun 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE4UsPNt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA282236FC;
	Fri, 13 Jun 2025 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841059; cv=none; b=DDgz67J8HylyEE+xkqaXYx9Zvnl1ZNdaGqUP+fB7Fki2vvkFXItALn9b58ynizsoL1IcSlK33qrVjNUUwvP8ruUWfrcUaTu37zAKsLVstZxvAf/tWJiUT8Q/lvCtQDE4YyYxekRcEiEcwD0JRSZXeHS0QIFSVmmm5KUVyXAEhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841059; c=relaxed/simple;
	bh=yM0YHtJ7BxqfyfLZ1pIJKzDis7Kx2BYqnliwZo6DSg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3CARRROia8jAPYh7z1EVdVWaj+SycJzAr71yBRQu9vlLSC6vSEojZTz2LhE3cpTQb4z2YUpGe4QDRv9WyBnKFjA8iJrSrm5Y69aN+32A3yXvjXwfXEA4ZUSmTBvNBcQhZ6Xrea9+cOffoNPYYOa4+lP+m1IaYGJ/59r8ECTnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE4UsPNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B2AC4CEE3;
	Fri, 13 Jun 2025 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749841058;
	bh=yM0YHtJ7BxqfyfLZ1pIJKzDis7Kx2BYqnliwZo6DSg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OE4UsPNtrb2fx5m0o9Tc94Ho1/loam2DfUZZ4v+joXfL6ubxBS/0kBjxbZZ1EBn2x
	 1HEVNQaP0GyRofvm/QqIzTuTkvzWhjI87nKFl5G29z1dgDbgKsGEEH5AtdOB9/mycO
	 QucTM87AauTa/bfk0GY0pZeuARdCFwa34COOwTefm8uiRxpqt6jyDEnQmG0cIKOpEh
	 9wdAK4ANsyXKw5Y/g6QjCh8ZDRDkOqpqDk8/SH0geD7vSzhiEWukOkPyz+Gc54bwv9
	 H/tOFiiGx7os3tPbhlA96Txoxnz3+zR5Dtiz8etHAyePCvezeC/pqL+ZaGms0HSz3L
	 qWxosvrka8s4Q==
Date: Fri, 13 Jun 2025 14:57:37 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: use threads array as-is in netlink interface
Message-ID: <aEx0ocoWoFkp8oCg@kernel.org>
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
 <20250527-rpc-numa-v1-1-fa1d98e9a900@kernel.org>
 <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d4c4cffe1a35ea831110ce1c7beea649352238.camel@kernel.org>

On Thu, Jun 12, 2025 at 11:57:59AM -0400, Jeff Layton wrote:
> On Tue, 2025-05-27 at 20:12 -0400, Jeff Layton wrote:
> > The old nfsdfs interface for starting a server with multiple pools
> > handles the special case of a single entry array passed down from
> > userland by distributing the threads over every NUMA node.
> > 
> > The netlink control interface however constructs an array of length
> > nfsd_nrpools() and fills any unprovided slots with 0's. This behavior
> > defeats the special casing that the old interface relies on.
> > 
> > Change nfsd_nl_threads_set_doit() to pass down the array from userland
> > as-is.
> > 
> > Fixes: 7f5c330b2620 ("nfsd: allow passing in array of thread counts via netlink")
> > Reported-by: Mike Snitzer <snitzer@kernel.org>
> > Closes: https://lore.kernel.org/linux-nfs/aDC-ftnzhJAlwqwh@kernel.org/
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfsctl.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index ac265d6fde35df4e02b955050f5b0ef22e6e519c..22101e08c3e80350668e94c395058bc228b08e64 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1611,7 +1611,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> >   */
> >  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
> >  {
> > -	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
> > +	int *nthreads, nrpools = 0, i, ret = -EOPNOTSUPP, rem;
> >  	struct net *net = genl_info_net(info);
> >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> >  	const struct nlattr *attr;
> > @@ -1623,12 +1623,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
> >  	/* count number of SERVER_THREADS values */
> >  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> >  		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
> > -			count++;
> > +			nrpools++;
> >  	}
> >  
> >  	mutex_lock(&nfsd_mutex);
> >  
> > -	nrpools = max(count, nfsd_nrpools(net));
> >  	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
> >  	if (!nthreads) {
> >  		ret = -ENOMEM;
> 
> I noticed that this didn't go in to the recent merge window.
> 
> This patch fixes a rather nasty regression when you try to start the
> server on a NUMA-capable box. It all looks like it works, but some RPCs
> get silently dropped on the floor (if they happen to be received into a
> node with no threads). It took me a while to track down the problem
> after Mike reported it.
> 
> Can we go ahead and pull this in and send it to stable?
> 
> Also, did this patch fix the problem for you, Mike?

Hi Jeff,

I saw your other mail asking the same, figured it best to reply to this
thread with the patch.

YES, I just verified this patch fixes the issue I reported.  I didn't
think I was critical path for confirming the fix, and since I had
worked around it (by downgrading nfs-utils from EL10's 2.8.2 to EL9's
2.5.4 it wasn't a super quick thing for me to test.. it became
out-of-sight-out-of-mind...

BTW, Chuck, I think the reason there aren't many/any reports (even
with RHEL10 or Fedora users) is that the user needs to:
1) have a NUMA system
2) explicitly change sunrpc's default for pool_mode from global to pernode.

Anyway:

Tested-by: Mike Snitzer <snitzer@kernel.org>

