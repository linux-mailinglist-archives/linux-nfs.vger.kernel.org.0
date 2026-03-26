Return-Path: <linux-nfs+bounces-20439-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gu/ALubxWnP/wQAu9opvQ
	(envelope-from <linux-nfs+bounces-20439-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 21:48:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 942BC33B8DC
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 21:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDD8330422D8
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBBE37882B;
	Thu, 26 Mar 2026 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYAx/9AK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17C33A711;
	Thu, 26 Mar 2026 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774558127; cv=none; b=K0wTJUBBhkrxEyCWr3nbeRHZl+s/RwrJ7uw+e4D1qyPTYVzFPX4Mdh5egnIbN1OZKsMme1N/n5Zb0ignkZQRiqkNbx8CMYiZwT4HPV6lzcJJWL/JIRq/eII/ms7WtnEb38t4p9pUy4LcZ1UJpJGd6Dv/03PwoW/Ru2L6HKZp1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774558127; c=relaxed/simple;
	bh=dVmfDKAmcYU+P9oPx45dFGp34Xb5aP03iy+0pWfebw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvZqybhfvHyhhDqNE05hjkLGLVTFSgkArENOPAAWtRBUb/LZ1ZWXgTvUdd+5TB7B2XK1yZ1ctUsDDPovuqcLHbTNqlEdFIO6rumNEMeYMMnUpDLzCaVCwjN3v7n7X2FCtsKtU3Owdlr0RKisQN/GwRe3Rq4/Q1FkS4bRtR0eGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYAx/9AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227B9C116C6;
	Thu, 26 Mar 2026 20:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774558127;
	bh=dVmfDKAmcYU+P9oPx45dFGp34Xb5aP03iy+0pWfebw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYAx/9AK3xIoE4JHnYUZa0Okdzzv0luEebEXaaAB5aAnujI50/gpmXZv+qkyOdq9A
	 oM2ziJh/kRhRQMbW25/XeqRRglGTp9SMryWvR7y0y6xO+b0XDqBPejdCwJc+Z3RYvT
	 4icZSLqZU6zT08t0OGCdAkYNXEhpJzomZBrkawGNJqOtUvFpJJwts+xH5W8mlbAzV1
	 9fTYea+ogw+rb7mKxjMCki0DOu8KBfhM1P+Uj/JtCmy5U9UrgCDtGdF2E85ruMd6La
	 CztljhxfeKW/6x+2ubjlGiT3OyIBN2Aj9k+FKtFR0yqIxi5cKm5Uu/okD9HB85LqWj
	 EV0cGwVMtFydw==
Date: Thu, 26 Mar 2026 16:48:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: A comparison of the new nfsd iomodes (and an experimental one)
Message-ID: <acWbrlvt_dUB9X3R@kernel.org>
References: <4ebbd194ccfb3bcea6225d926b4c9f339e21c813.camel@kernel.org>
 <d453add6-ed23-4d61-af95-d80133b0e456@oracle.com>
 <33582a86daf135336f6bc0d5260d8de0501abadd.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33582a86daf135336f6bc0d5260d8de0501abadd.camel@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20439-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,markdownpastebin.com:url]
X-Rspamd-Queue-Id: 942BC33B8DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 12:35:15PM -0400, Jeff Layton wrote:
> On Thu, 2026-03-26 at 11:30 -0400, Chuck Lever wrote:
> > On 3/26/26 11:23 AM, Jeff Layton wrote:
> > > I've been doing some benchmarking of the new nfsd iomodes, using
> > > different fio-based workloads.
> > > 
> > > The results have been interesting, but one thing that stands out is
> > > that RWF_DONTCACHE is absolutely terrible for streaming write
> > > workloads. That prompted me to experiment with a new iomode that added
> > > some optimizations (DONTCACHE_LAZY).
> > > 
> > > The results along with Claude's analysis are here:
> > > 
> > >     https://markdownpastebin.com/?id=387375d00b5443b3a2e37d58a062331f
> > > 
> > > He gets a bit out over his skis on the upstream plan, but tl;dr is that
> > > DONTCACHE_LAZY (which is DONTCACHE with some optimizations) outperforms
> > > the other write iomodes.
> > 
> > The analysis of the write modes seems plausible. I'm interested to hear
> > what Mike and Jens have to say about that.

Thanks for doing your testing and the summary, but I cannot help but
feel like your test isn't coming close to realizing the O_DIRECT
benefits over buffered that were covered in the past, e.g.:
https://www.youtube.com/watch?v=tpPFDu9Nuuw

Can Claude be made to watch a youtube video, summarize what it learned
and then adapt its test-plan accordingly? ;)

Your bandwidth for 1MB sequential IO of 793 MB/s for O_DIRECT and
4,952 MB/s for buffered and dontcache is considerably less than the 72
GB/s offered in Jon's testbed.  Your testing isn't exposing the
bottlenecks (contention) of the MM subsystem for buffered IO... not
yet put my finger on _why_ that is.

In Jon Flynn's testing he was using a working set of 312.5% of
available server memory, and the single client test system was using
fio with multiple threads and sync IO to write to 16 different mounts
(one per NVMe of the NFS server) with nconnect=16 and RDMA.

Raw performance of a single NVMe in Jon's testbed was over 14 GB/s --
he has the ability to drive 16 NVMe in his single NFS server.  So an
order of magnitude more capable backend storage in Jon's NFS server.

Big concern is your testing isn't exposing MM bottlenecks of buffered
IO... given that, its not really providing useful results to compare
with O_DIRECT.

Putting that aside, yes DONTCACHE as-is really isn't helpful.. your
lazy variant seems much more useful.

> > One thing I'd like to hear more about is why Claude felt that disabling
> > splice read was beneficial. My own benchmarking in that area has shown
> > that splice read is always a win over not using splice.
> > 
> 
> Good catch. That turns out to be a mistake in Claude's writeup.
> 
> The test scripts left splice reads enabled for buffered reads, and the
> results in the analysis reflect that. I (and it) have no idea why it
> would recommend disabling them, when the testing all left them enabled
> for buffered reads.

Claude had to have picked up on the mutual exclusion with splice_read
for both NFSD_IO_DONTCACHE and NFSD_IO_DIRECT io modes.  So
splice_read is implicity disabled when testing NFSD_IO_DONTCACHE
(which is buffered IO).

Mike

