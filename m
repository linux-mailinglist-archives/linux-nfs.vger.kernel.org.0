Return-Path: <linux-nfs+bounces-9749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FBEA21EEF
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EBE3A2BDD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D713BAE4;
	Wed, 29 Jan 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b="BIK4jxrv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from poldevia.fieldses.org (poldevia.fieldses.org [172.234.196.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B032114;
	Wed, 29 Jan 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.234.196.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160493; cv=none; b=dNwSZD8L+gqSQUU1U7MpZ1rcKmRIGRj4VTc8cvRTjN+K8bPerXjsigiKuTjJTDJ2xqS7efg+YtZ5auoCJWDtoFGMeoJT1jIvUQiqxy5unVMZacNtc/aVXcWxwps4xnmcvxdBqttcIMUpeZa8p5X/sZIs+ey1FFpXLtvpkcSuMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160493; c=relaxed/simple;
	bh=InilnIIqPsn1BvAXcMCkzJ/P6lD+zdr2beX4XiaaVyU=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=fAz5NqWDA50H7/1m3SPGs3Kne7H3uP8A5CWPQWEhHIXvoa8ocQ9SVvG59cI01zvVVGQcGGqgMekw9gzcqCgRu3Dx7dyKMMIiMVqAdgHOLiNDBoukufAZx37YIiuVKPLYrFLUuS17gc3AghUxsveHw/tSgUOOeeAdrcxQ+xEKrd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org; spf=pass smtp.mailfrom=fieldses.org; dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b=BIK4jxrv; arc=none smtp.client-ip=172.234.196.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fieldses.org
Received: by poldevia.fieldses.org (Postfix, from userid 2815)
	id 8C41EFA2E6; Wed, 29 Jan 2025 09:21:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poldevia.fieldses.org 8C41EFA2E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
	s=default; t=1738160484;
	bh=shRzsgi3gQKnbPzbZgB5NeUwlmnFXOOpuhWvRJiVhpw=;
	h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
	b=BIK4jxrvebPkrGnm3FZB1WO1hTucfS5xeYKMqNez++ro6LrVmr4eV9Ttt4xOSFZ13
	 Di913ha/TYhhzJQZ+km9DT26mPftWdlgHpXjEso5TRbSNakWVOvWJcTKzcqkJWFiwL
	 iXSF6XGucd2hPWq3vy60CJSnl9ba9PVGLkuf/Ojc=
Date: Wed, 29 Jan 2025 09:21:24 -0500
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
Message-ID: <Z5o5ZBaYgrmrNseU@poldevia.fieldses.org>
References: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129-nfsd-6-14-v2-0-2700c92f3e44@kernel.org>
From: "J. Bruce Fields" <bfields@fieldses.org>

On Wed, Jan 29, 2025 at 08:39:53AM -0500, Jeff Layton wrote:
> While looking over the CB_SEQUENCE error handling, I discovered that
> callbacks don't hold a reference to a session, and the
> clp->cl_cb_session could easily change between request and response.
> If that happens at an inopportune time, there could be UAFs or weird
> slot/sequence handling problems.

Nobody should place too much faith in my understanding of how any of
this works at this point, but....  My vague memory is that a lot of
things are serialized simply by being run only on the cl_callback_wq.
Modifying clp->cl_cb_session is such a thing.

--b.

> This series changes the nfsd4_session to be RCU-freed, and then adds a
> new method of session refcounting that is compatible with the old.
> nfsd4_callback RPCs will now hold a lightweight reference to the session
> in addition to the slot. Then, all of the callback handling is switched
> to use that session instead of dereferencing clp->cb_cb_session.
> I've also reworked the error handling in nfsd4_cb_sequence_done()
> based on review comments, and lifted the v4.0 handing out of that
> function.
> 
> This passes pynfs, nfstests, and fstests for me, but I'm not sure how
> much any of that stresses the backchannel's error handling.
> 
> These should probably go in via Chuck's tree, but the last patch touches
> some NFS cnd sunrpc client code, so it'd be good to have R-b's or A-b's
> from Trond and/or Anna on that one.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v2:
> - make nfsd4_session be RCU-freed
> - change code to keep reference to session over callback RPCs
> - rework error handling in nfsd4_cb_sequence_done()
> - move NFSv4.0 handling out of nfsd4_cb_sequence_done()
> - Link to v1: https://lore.kernel.org/r/20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org
> 
> ---
> Jeff Layton (7):
>       nfsd: add routines to get/put session references for callbacks
>       nfsd: make clp->cl_cb_session be an RCU managed pointer
>       nfsd: add a cb_ses pointer to nfsd4_callback and use it instead of clp->cb_cb_session
>       nfsd: overhaul CB_SEQUENCE error handling
>       nfsd: remove unneeded forward declaration of nfsd4_mark_cb_fault()
>       nfsd: lift NFSv4.0 handling out of nfsd4_cb_sequence_done()
>       sunrpc: make rpc_restart_call() and rpc_restart_call_prepare() void return
> 
>  fs/nfs/nfs4proc.c           |  12 ++-
>  fs/nfsd/nfs4callback.c      | 212 ++++++++++++++++++++++++++++++++------------
>  fs/nfsd/nfs4state.c         |  43 ++++++++-
>  fs/nfsd/state.h             |   6 +-
>  fs/nfsd/trace.h             |   6 +-
>  include/linux/sunrpc/clnt.h |   4 +-
>  net/sunrpc/clnt.c           |   7 +-
>  7 files changed, 210 insertions(+), 80 deletions(-)
> ---
> base-commit: a05af3c6103b703d1d38d8180b3ebbe0a03c2f07
> change-id: 20250123-nfsd-6-14-b0797e385dc0
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>

