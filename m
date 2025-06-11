Return-Path: <linux-nfs+bounces-12327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B131AD5EC6
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 21:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845C31BC1685
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jun 2025 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F5129B226;
	Wed, 11 Jun 2025 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="ssU3KQNe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A4278774
	for <linux-nfs@vger.kernel.org>; Wed, 11 Jun 2025 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668724; cv=none; b=oUOMqHDUA69OkNapRK0CjZKLLluU6jfFwfoeAZkMO9NNspSCwH8DYUE3WdSiyFDt3ci2UZaankjL3eSbRgvj0Tb0C4ujomLDl6EjQm6Ux8LxLvBzYV5OFYsnpKW2DtlYmECv5cc+xVKRzJIGL106NCx1d6aRkKz8Rm/fMMzs2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668724; c=relaxed/simple;
	bh=1eacTEzFuKU/QCLoMNFUx9adZT3ri5aEptCBJeFczmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUqq3XSncLo4mjm28RS6uzzPq1NHF23qvBM62nSPIRl93EJwdOcFbby/e7AwMbZB/YA4KynYMTSvsVJy+OcN00cfe/t+qLVPHkoTb0sN7KTyUZc/OwZcEZPAi7e9DuV3UQybYia4JrP9ddHw5ElBkshPdsgaeJSL8GeUvseVpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=ssU3KQNe; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Date: Wed, 11 Jun 2025 15:05:20 -0400
From: Nikhil Jha <njha@janestreet.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 	Olga Kornievskaia <okorniev@redhat.com>,
 	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 	"David S. Miller" <davem@davemloft.net>,
 	Eric Dumazet <edumazet@google.com>,
 	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 	Simon Horman <horms@kernel.org>,
 	Steven Rostedt <rostedt@goodmis.org>,
 	Masami Hiramatsu <mhiramat@kernel.org>,
 	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix gss seqno handling to be more rfc-compliant
Message-ID: <20250611A1905207b67479b.njha@janestreet.com>
References: <20250319-rfc2203-seqnum-cache-v2-0-2c98b859f2dd@janestreet.com>
  <d78576c1-d743-4ec2-bf8c-d87603460ac1@oracle.com>
  <20250611A18503192e946d6.njha@janestreet.com>
  <81cd5e1e-218d-4e24-b127-c8d1757e4d99@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81cd5e1e-218d-4e24-b127-c8d1757e4d99@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1749668720;
  bh=TwBEfFFd7f2nQPQET57nFnHM2aPp4dA96MYxki19d+Q=;
  h=Date:From:To:Cc:Subject:References:In-Reply-To;
  b=ssU3KQNeguS8m7tmod/gMHjHRPy9SkIXKPiPaM/C9s0lvkpU5bahDlpA0HQsVUVBF
  d++foJeXUhaOigaAc9L/JdW3ccztM2DEIEIKGlE8eYO9axp76tWnSWRbITM2E8/kKk
  tUZ5LX2EPip0FrziAbOkl9/M2qBrZzRGyvpSWcOiDYWrQkC+WB84H/a3PGnpHfZ+hk
  8EG0xhaZmTSvBQWGbfuhwcmlWDLZ12+IAlkRUCfDSdQJprkhx+OwVPFrLvy+PK2THo
  wEs0nlMICyNmvUVTI17KqB2iEQRRHrDemIoCysY7bf3pTmlYxJD419uhbP11Q/9n16
  6ivBLrZEOx3uw==

On Wed, Jun 11, 2025 at 02:54:09PM -0400, Chuck Lever wrote:
> On 6/11/25 2:50 PM, Nikhil Jha wrote:
> > On Thu, Mar 20, 2025 at 09:16:15AM -0400, Chuck Lever wrote:
> >> On 3/19/25 1:02 PM, Nikhil Jha via B4 Relay wrote:
> >>> When the client retransmits an operation (for example, because the
> >>> server is slow to respond), a new GSS sequence number is associated with
> >>> the XID. In the current kernel code the original sequence number is
> >>> discarded. Subsequently, if a response to the original request is
> >>> received there will be a GSS sequence number mismatch. A mismatch will
> >>> trigger another retransmit, possibly repeating the cycle, and after some
> >>> number of failed retries EACCES is returned.
> >>>
> >>> RFC2203, section 5.3.3.1 suggests a possible solution... “cache the
> >>> RPCSEC_GSS sequence number of each request it sends” and "compute the
> >>> checksum of each sequence number in the cache to try to match the
> >>> checksum in the reply's verifier." This is what FreeBSD’s implementation
> >>> does (rpc_gss_validate in sys/rpc/rpcsec_gss/rpcsec_gss.c).
> >>>
> >>> However, even with this cache, retransmits directly caused by a seqno
> >>> mismatch can still cause a bad message interleaving that results in this
> >>> bug. The RFC already suggests ignoring incorrect seqnos on the server
> >>> side, and this seems symmetric, so this patchset also applies that
> >>> behavior to the client.
> >>>
> >>> These two patches are *not* dependent on each other. I tested them by
> >>> delaying packets with a Python script hooked up to NFQUEUE. If it would
> >>> be helpful I can send this script along as well.
> >>>
> >>> Signed-off-by: Nikhil Jha <njha@janestreet.com>
> >>> ---
> >>> Changes since v1:
> >>>  * Maintain the invariant that the first seqno is always first in
> >>>    rq_seqnos, so that it doesn't need to be stored twice.
> >>>  * Minor formatting, and resending with proper mailing-list headers so the
> >>>    patches are easier to work with.
> >>>
> >>> ---
> >>> Nikhil Jha (2):
> >>>       sunrpc: implement rfc2203 rpcsec_gss seqnum cache
> >>>       sunrpc: don't immediately retransmit on seqno miss
> >>>
> >>>  include/linux/sunrpc/xprt.h    | 17 +++++++++++-
> >>>  include/trace/events/rpcgss.h  |  4 +--
> >>>  include/trace/events/sunrpc.h  |  2 +-
> >>>  net/sunrpc/auth_gss/auth_gss.c | 59 ++++++++++++++++++++++++++----------------
> >>>  net/sunrpc/clnt.c              |  9 +++++--
> >>>  net/sunrpc/xprt.c              |  3 ++-
> >>>  6 files changed, 64 insertions(+), 30 deletions(-)
> >>> ---
> >>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> >>> change-id: 20250314-rfc2203-seqnum-cache-52389d14f567
> >>>
> >>> Best regards,
> >>
> >> This seems like a sensible thing to do to me.
> >>
> >> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> -- 
> >> Chuck Lever
> > 
> > Hi,
> > 
> > We've been running this patch for a while now and noticed a (very silly
> > in hindsight) bug.
> > 
> > maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i], seq, p, len);
> > 
> > needs to be
> > 
> > maj_stat = gss_validate_seqno_mic(ctx, task->tk_rqstp->rq_seqnos[i++], seq, p, len);
> > 
> > Or the kernel gets stuck in a loop when you have more than two retries.
> > I can resend this patch but I noticed it's already made its way into
> > quite a few trees. Should this be a separate patch instead?
> 
> The course of action depends on what trees you found the patch in.
> 
> 
> -- 
> Chuck Lever

It shows up here, so I think it's in v6.16-rc1 already.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.16-rc1&id=08d6ee6d8a10aef958c2af16bb121070290ed589

- Nikhil



