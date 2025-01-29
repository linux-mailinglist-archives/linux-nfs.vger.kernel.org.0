Return-Path: <linux-nfs+bounces-9753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2957AA21F61
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB7C1884F4C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64511CB9EA;
	Wed, 29 Jan 2025 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b="VI5+XA01"
X-Original-To: linux-nfs@vger.kernel.org
Received: from poldevia.fieldses.org (poldevia.fieldses.org [172.234.196.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B71B6CEF;
	Wed, 29 Jan 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.234.196.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161631; cv=none; b=RTFkhWtYQ6i53v+EYEo2XgGqGf8xuhcC+F/WGkESKa983Ucy7PLflkJ1Zy7+F7Qd80kDosLYbaANY02ty7Tq2wpLn1YSFIt/edl6ddQVB7pTB1R2P+kNcnbWP8nv3L7i4lHsK/ulnTWPvYOBQZgFkLtQL1u5rLZAqls/KfmK3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161631; c=relaxed/simple;
	bh=+83DUlsnanyyjr3z+hykUcZ2eDSz/8sgNu58MTdSztc=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=qjCaa6KYnkYeDn4sezR8Z/NXKgRp9gCMBxEbuag07QhUUkk5iSZdgGgpVuWozTWAUVOmg0CKguZrqQ6h/hUsICRTJXxBw34Zgz8OXhXgSUCIN7N+no9CyRp8hLgrxQ7tmpR+nWk3K7wc2E9lD3Dy4DeMG+Z6ZW2Zjz9YNos0d4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org; spf=pass smtp.mailfrom=fieldses.org; dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b=VI5+XA01; arc=none smtp.client-ip=172.234.196.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fieldses.org
Received: by poldevia.fieldses.org (Postfix, from userid 2815)
	id 15B03FA2E6; Wed, 29 Jan 2025 09:40:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poldevia.fieldses.org 15B03FA2E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
	s=default; t=1738161629;
	bh=6ZG+0X0A+EGSAVmhODSWNuezh9nLvk7ahA4X+kzi/Dg=;
	h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
	b=VI5+XA01IL2/i8B2G6kL/QS1jbvLUbBcpnEdjR9Cb1zNlqSWmftc2VOqbXH7VLwp4
	 GJJjpa9iOqf13Seu9EYTLxVnsuYncifNBKJy+1gI5a90KpKijDq+s879hRjDCk2dMr
	 SAvljNENLyQHwiUUZI2hKfaUykiZrBKlpYbSAvvM=
Date: Wed, 29 Jan 2025 09:40:29 -0500
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Kinglong Mee <kinglongmee@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] nfsd: CB_SEQUENCE error handling fixes and
 cleanups
Message-ID: <Z5o93QZJ35z8Zkyh@poldevia.fieldses.org>
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
 <Z5o5ZBaYgrmrNseU@poldevia.fieldses.org>
 <5760673a9adc597c1b235dd6a1670ed801d2feb1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5760673a9adc597c1b235dd6a1670ed801d2feb1.camel@kernel.org>
From: "J. Bruce Fields" <bfields@fieldses.org>

On Wed, Jan 29, 2025 at 09:27:02AM -0500, Jeff Layton wrote:
> On Wed, 2025-01-29 at 09:21 -0500, J. Bruce Fields wrote:
> > On Wed, Jan 29, 2025 at 08:39:53AM -0500, Jeff Layton wrote:
> > > While looking over the CB_SEQUENCE error handling, I discovered that
> > > callbacks don't hold a reference to a session, and the
> > > clp->cl_cb_session could easily change between request and response.
> > > If that happens at an inopportune time, there could be UAFs or weird
> > > slot/sequence handling problems.
> > 
> > Nobody should place too much faith in my understanding of how any of
> > this works at this point, but....  My vague memory is that a lot of
> > things are serialized simply by being run only on the cl_callback_wq.
> > Modifying clp->cl_cb_session is such a thing.
> 
> It is, but that doesn't save us here. The workqueue is just there to
> submit jobs to the RPC client. Once that happens they are run via
> rpciod's workqueue (and in parallel with one another since they're
> async RPC calls).
> 
> So, it's possible that while we're waiting for a response from one
> callback, another is submitted, and that workqueue job changes the
> clp->cl_cb_session.

I think it calls rpc_shutdown_client() before changing
clp->cl_cb_session.

(Though I'm not sure whether rpc_shutdown_client guarantees that all rpc
processing for the client is completed before returning?)

--b.

> 
> Thanks for taking a look, Bruce!
> 
> > 
> > > This series changes the nfsd4_session to be RCU-freed, and then adds a
> > > new method of session refcounting that is compatible with the old.
> > > nfsd4_callback RPCs will now hold a lightweight reference to the session
> > > in addition to the slot. Then, all of the callback handling is switched
> > > to use that session instead of dereferencing clp->cb_cb_session.
> > > I've also reworked the error handling in nfsd4_cb_sequence_done()
> > > based on review comments, and lifted the v4.0 handing out of that
> > > function.
> > > 
> > > This passes pynfs, nfstests, and fstests for me, but I'm not sure how
> > > much any of that stresses the backchannel's error handling.
> > > 
> > > These should probably go in via Chuck's tree, but the last patch touches
> > > some NFS cnd sunrpc client code, so it'd be good to have R-b's or A-b's
> > > from Trond and/or Anna on that one.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > Changes in v2:
> > > - make nfsd4_session be RCU-freed
> > > - change code to keep reference to session over callback RPCs
> > > - rework error handling in nfsd4_cb_sequence_done()
> > > - move NFSv4.0 handling out of nfsd4_cb_sequence_done()
> > > - Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org
> > > 
> > > ---
> > > Jeff Layton (7):
> > >       nfsd: add routines to get/put session references for callbacks
> > >       nfsd: make clp->cl_cb_session be an RCU managed pointer
> > >       nfsd: add a cb_ses pointer to nfsd4_callback and use it instead of clp->cb_cb_session
> > >       nfsd: overhaul CB_SEQUENCE error handling
> > >       nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
> > >       nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
> > >       sunrpc: make rpc_restart_call() and rpc_restart_call_prepare() void return
> > > 
> > >  fs/nfs/nfs4proc.c           |  12 ++-
> > >  fs/nfsd/nfs4callback.c      | 212 ++++++++++++++++++++++++++++++++------------
> > >  fs/nfsd/nfs4state.c         |  43 ++++++++-
> > >  fs/nfsd/state.h             |   6 +-
> > >  fs/nfsd/trace.h             |   6 +-
> > >  include/linux/sunrpc/clnt.h |   4 +-
> > >  net/sunrpc/clnt.c           |   7 +-
> > >  7 files changed, 210 insertions(+), 80 deletions(-)
> > > ---
> > > base-commit: a05af3c6103b703d1d38d8180b3ebbe0a03c2f07
> > > change-id: 20250123-nfsd-6-14-b0797e385dc0
> > > 
> > > Best regards,
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

