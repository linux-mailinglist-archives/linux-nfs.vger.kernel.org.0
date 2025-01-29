Return-Path: <linux-nfs+bounces-9759-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70443A22036
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBCB168B3D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991F1DEFFC;
	Wed, 29 Jan 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b="nFql7eDn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from poldevia.fieldses.org (poldevia.fieldses.org [172.234.196.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927571DE4ED;
	Wed, 29 Jan 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.234.196.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164358; cv=none; b=B4eVyxZ5R49IlSUG8VwrRX7zUMCO38rzK+scngNLCIz4em2wqk1BXwneCNBMGQCX+eIdbJtEwMK5v6hwhfhnSLF4tWuPMDx7anMYzSIx4hi1KpdURKVtUIJvoypP6YUSaTFHC9r+i5mSj6TjWYL0MkuAawPBqASWJGMzzHloEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164358; c=relaxed/simple;
	bh=F0Iq4R+qWoWrnn/kWR+8Tk8i8D0TZ38ztwwfbjAdFFI=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=SQzSsDMyvxZ4d3R/Yv2P/mT/9GQJtCp07lFqHLq7GRs6wiAoZllR+nddg8DkBHWt/3xkSQXGaGBd0YzCLdi0pyJOnf8ninPiaFY7l4+YuWiOnhiklT1CGRAkJLcYkJOaPnSHc+wqglg7DGwSfoDipJr0n1kdkzVkJWrn+wyy4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org; spf=pass smtp.mailfrom=fieldses.org; dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b=nFql7eDn; arc=none smtp.client-ip=172.234.196.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fieldses.org
Received: by poldevia.fieldses.org (Postfix, from userid 2815)
	id 880EFFA2E6; Wed, 29 Jan 2025 10:25:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poldevia.fieldses.org 880EFFA2E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
	s=default; t=1738164355;
	bh=nc6uVJxfHGYRzyXZabwdUBPPXifpLmaLi1TDVsWoHPc=;
	h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
	b=nFql7eDnnQW1z/cku93w4kRPUjUWzV+ORTGw0TUtmqz3Qc47jCmVssIejiAPFoLr4
	 BJRA1VlGtAMFVh1c5hIxUduK+ZIt1Wxy9tR5UEG0G4HL7pZ9seiHu4v1cT59TXTFfo
	 bPcb4dS87bwaSdPJxaRgpSkQVetRdGyRCT2qX0N0=
Date: Wed, 29 Jan 2025 10:25:55 -0500
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Kinglong Mee <kinglongmee@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] nfsd: CB_SEQUENCE error handling fixes and
 cleanups
Message-ID: <Z5pIg5ejYeBsQ2LB@poldevia.fieldses.org>
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
 <Z5o5ZBaYgrmrNseU@poldevia.fieldses.org>
 <5760673a9adc597c1b235dd6a1670ed801d2feb1.camel@kernel.org>
 <Z5o93QZJ35z8Zkyh@poldevia.fieldses.org>
 <0722b556a8b01ca4f99e5d3ac5285efc666d69ec.camel@kernel.org>
 <91515715-5804-4e94-ae19-67aaaf36e3d3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91515715-5804-4e94-ae19-67aaaf36e3d3@oracle.com>
From: "J. Bruce Fields" <bfields@fieldses.org>

On Wed, Jan 29, 2025 at 10:09:14AM -0500, Chuck Lever wrote:
> On 1/29/25 10:01 AM, Jeff Layton wrote:
> > On Wed, 2025-01-29 at 09:40 -0500, J. Bruce Fields wrote:
> > > On Wed, Jan 29, 2025 at 09:27:02AM -0500, Jeff Layton wrote:
> > > > On Wed, 2025-01-29 at 09:21 -0500, J. Bruce Fields wrote:
> > > > > On Wed, Jan 29, 2025 at 08:39:53AM -0500, Jeff Layton wrote:
> > > > > > While looking over the CB_SEQUENCE error handling, I discovered that
> > > > > > callbacks don't hold a reference to a session, and the
> > > > > > clp->cl_cb_session could easily change between request and response.
> > > > > > If that happens at an inopportune time, there could be UAFs or weird
> > > > > > slot/sequence handling problems.
> > > > > 
> > > > > Nobody should place too much faith in my understanding of how any of
> > > > > this works at this point, but....  My vague memory is that a lot of
> > > > > things are serialized simply by being run only on the cl_callback_wq.
> > > > > Modifying clp->cl_cb_session is such a thing.
> > > > 
> > > > It is, but that doesn't save us here. The workqueue is just there to
> > > > submit jobs to the RPC client. Once that happens they are run via
> > > > rpciod's workqueue (and in parallel with one another since they're
> > > > async RPC calls).
> > > > 
> > > > So, it's possible that while we're waiting for a response from one
> > > > callback, another is submitted, and that workqueue job changes the
> > > > clp->cl_cb_session.
> > > 
> > > I think it calls rpc_shutdown_client() before changing
> > > clp->cl_cb_session.
> > > 
> > 
> > It does, but the cl_cb_session doesn't carry a reference. My worry was
> > that the client could call a DESTROY_SESSION at any time.
> > 
> > Now that I look though, you may be right that that's enough to ensure
> > it because nfsd4_destroy_session() calls nfsd4_probe_callback_sync()
> > before putting the session reference.
> > 
> > Still, that is a lot of reliance on these things happening in a
> > particular order.
> > 
> > > (Though I'm not sure whether rpc_shutdown_client guarantees that all rpc
> > > processing for the client is completed before returning?)
> > > 
> > 
> > FWIW, it does wait for them to be killed:
> > 
> >          while (!list_empty(&clnt->cl_tasks)) {
> >                  rpc_killall_tasks(clnt);
> >                  wait_event_timeout(destroy_wait,
> >                          list_empty(&clnt->cl_tasks), 1*HZ);
> >          }
> > 
> > I'm not crazy about the fact that it does that synchronously in the
> > workqueue job, but I guess not much else can be happening with
> > callbacks until this completes.
> 
> Bruce, note rpc_shutdown_client() can block indefinitely due to
> bugs in NFSD's callback completion handlers. That's one of the
> main reasons this is getting attention right not.

Got it.

I mean, my apologies for that code, I'm not at all attached to the way
it works right now.  But I wonder whether what's mainly needed is some
test writing.

It feels like a lot of subtle code designed to handle cases that
probably aren't much exercised by real clients.

--b.

> > > > > > This series changes the nfsd4_session to be RCU-freed, and then adds a
> > > > > > new method of session refcounting that is compatible with the old.
> > > > > > nfsd4_callback RPCs will now hold a lightweight reference to the session
> > > > > > in addition to the slot. Then, all of the callback handling is switched
> > > > > > to use that session instead of dereferencing clp->cb_cb_session.
> > > > > > I've also reworked the error handling in nfsd4_cb_sequence_done()
> > > > > > based on review comments, and lifted the v4.0 handing out of that
> > > > > > function.
> > > > > > 
> > > > > > This passes pynfs, nfstests, and fstests for me, but I'm not sure how
> > > > > > much any of that stresses the backchannel's error handling.
> > > > > > 
> > > > > > These should probably go in via Chuck's tree, but the last patch touches
> > > > > > some NFS cnd sunrpc client code, so it'd be good to have R-b's or A-b's
> > > > > > from Trond and/or Anna on that one.
> > > > > > 
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - make nfsd4_session be RCU-freed
> > > > > > - change code to keep reference to session over callback RPCs
> > > > > > - rework error handling in nfsd4_cb_sequence_done()
> > > > > > - move NFSv4.0 handling out of nfsd4_cb_sequence_done()
> > > > > > - Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org
> > > > > > 
> > > > > > ---
> > > > > > Jeff Layton (7):
> > > > > >        nfsd: add routines to get/put session references for callbacks
> > > > > >        nfsd: make clp->cl_cb_session be an RCU managed pointer
> > > > > >        nfsd: add a cb_ses pointer to nfsd4_callback and use it instead of clp->cb_cb_session
> > > > > >        nfsd: overhaul CB_SEQUENCE error handling
> > > > > >        nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
> > > > > >        nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
> > > > > >        sunrpc: make rpc_restart_call() and rpc_restart_call_prepare() void return
> > > > > > 
> > > > > >   fs/nfs/nfs4proc.c           |  12 ++-
> > > > > >   fs/nfsd/nfs4callback.c      | 212 ++++++++++++++++++++++++++++++++------------
> > > > > >   fs/nfsd/nfs4state.c         |  43 ++++++++-
> > > > > >   fs/nfsd/state.h             |   6 +-
> > > > > >   fs/nfsd/trace.h             |   6 +-
> > > > > >   include/linux/sunrpc/clnt.h |   4 +-
> > > > > >   net/sunrpc/clnt.c           |   7 +-
> > > > > >   7 files changed, 210 insertions(+), 80 deletions(-)
> > > > > > ---
> > > > > > base-commit: a05af3c6103b703d1d38d8180b3ebbe0a03c2f07
> > > > > > change-id: 20250123-nfsd-6-14-b0797e385dc0
> > > > > > 
> > > > > > Best regards,
> > > > > > -- 
> > > > > > Jeff Layton <jlayton@kernel.org>
> > > > 
> > > > -- 
> > > > Jeff Layton <jlayton@kernel.org>
> > 
> 
> 
> -- 
> Chuck Lever

