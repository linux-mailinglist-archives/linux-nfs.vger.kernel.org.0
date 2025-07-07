Return-Path: <linux-nfs+bounces-12922-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E19AFBCB5
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 22:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D79516DF0D
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Jul 2025 20:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD02220F5A;
	Mon,  7 Jul 2025 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvzLteeg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC61FBE8B;
	Mon,  7 Jul 2025 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920979; cv=none; b=RlL3shdam0UsvTrnr8iFuZHQaCtPsq7cTCNgvNsYrfRETcC7wPIwY7Pd880TqYNPM9rVQ5/mrYcn+fIYKzUntef11z3x0OpYeO22I+PiNnJTIpUY33xOTysEn00qWy913P6Nv+vY9iUj9gCwXexiZ7J50sqdRJMFyhhKDIW0RQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920979; c=relaxed/simple;
	bh=dhRrfTWj8er4vwalaYURgw32Qgf7G5tjpwUBWOr6Zio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rbSMYTBrj03z+2CS8obH0BwwLHUvs8rk2Kmt8I0FMg7fwHksqQ4vxxN+wHmEhLsQ04IXRkcfmowv2jZ6G6anvVmzdCMtB0mUFPzjH64WRDLcFSdJqFibEyYHnregkB6gIBdjLkQACmXlXM61zpFQveg2XgIS+TUVTq0p2bZMPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvzLteeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75833C4CEE3;
	Mon,  7 Jul 2025 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751920978;
	bh=dhRrfTWj8er4vwalaYURgw32Qgf7G5tjpwUBWOr6Zio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RvzLteegWx6Fc8nPrxM9k0VY6xDuWUQwlbIes83kkQWKEXlEDZOquuNOrnXoJ0tsB
	 PhVaapqpJX/plRmlf4XjSO5N9wQdX9pYq0lzlnx+HKhl88qsxfNdEOq69KK6K0Pl3h
	 C93dKegJ9MUIZh07FiIn9LgjzAsg0iK6JIdrWU6veYVNLcCxo/rNgdLFUvhTq2rRrx
	 wrmTtVKaqY8U5LUbsx+8gw22SYYrkFPjvvFuNOdC+tQdduJC0dB0vdYJ+PG36wld0A
	 NnbPyxdJsQcshkP6ogel0ghLLnA2tbjAzlnD4KretTLLSSGVsDNc3g1d0mazKxfG+g
	 yimELCPyjYPkA==
Message-ID: <11d6227ddd04c64751956d75d0a5065f48b0e3a5.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for
 allocation flags
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Anna Schumaker <anna@kernel.org>, Tejun Heo <tj@kernel.org>, Lai
 Jiangshan	 <jiangshanlai@gmail.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, djeffery@redhat.com, loberman@redhat.com
Date: Mon, 07 Jul 2025 13:42:56 -0700
In-Reply-To: <B3C40644-332F-415A-98A0-875C230A709D@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
	 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
	 <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
	 <B3C40644-332F-415A-98A0-875C230A709D@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 16:12 -0400, Benjamin Coddington wrote:
> On 7 Jul 2025, at 15:25, Trond Myklebust wrote:
>=20
> > On Mon, 2025-07-07 at 14:46 -0400, Benjamin Coddington wrote:
> > > The NFS client writeback paths change which flags are passed to
> > > their
> > > memory allocation calls based on whether the current task is
> > > running
> > > from
> > > within a workqueue or not.=C2=A0 More specifically, it appears that
> > > during
> > > writeback allocations with PF_WQ_WORKER set on current->flags
> > > will
> > > add
> > > __GFP_NORETRY | __GFP_NOWARN.=C2=A0 Presumably this is because nfsiod
> > > can
> > > simply fail quickly and later retry to write back that specific
> > > page
> > > should
> > > the allocation fail.
> > >=20
> > > However, the check for PF_WQ_WORKER is too general because tasks
> > > can
> > > enter NFS
> > > writeback paths from other workqueues.=C2=A0 Specifically, the
> > > loopback
> > > driver
> > > tends to perform writeback into backing files on NFS with
> > > PF_WQ_WORKER set,
> > > and additionally sets PF_MEMALLOC_NOIO.=C2=A0 The combination of
> > > PF_MEMALLOC_NOIO with __GFP_NORETRY can easily result in
> > > allocation
> > > failures and the loopback driver has no retry functionality.=C2=A0 As
> > > a
> > > result,
> > > after commit 0bae835b63c5 ("NFS: Avoid writeback threads getting
> > > stuck in
> > > mempool_alloc()") users are seeing corrupted loop-mounted
> > > filesystems
> > > backed
> > > by image files on NFS.
> > >=20
> > > In a preceding patch, we introduced a function to allow NFS to
> > > detect
> > > if
> > > the task is executing within a specific workqueue.=C2=A0 Here we use
> > > that
> > > helper
> > > to set __GFP_NORETRY | __GFP_NOWARN only if the workqueue is
> > > nfsiod.
> > >=20
> > > Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck
> > > in
> > > mempool_alloc()")
> > > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > > ---
> > > =C2=A0fs/nfs/internal.h | 12 +++++++++++-
> > > =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > > index 69c2c10ee658..173172afa3f5 100644
> > > --- a/fs/nfs/internal.h
> > > +++ b/fs/nfs/internal.h
> > > @@ -12,6 +12,7 @@
> > > =C2=A0#include <linux/nfs_page.h>
> > > =C2=A0#include <linux/nfslocalio.h>
> > > =C2=A0#include <linux/wait_bit.h>
> > > +#include <linux/workqueue.h>
> > > =C2=A0
> > > =C2=A0#define NFS_SB_MASK
> > > (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
> > > =C2=A0
> > > @@ -669,9 +670,18 @@ nfs_write_match_verf(const struct
> > > nfs_writeverf
> > > *verf,
> > > =C2=A0		!nfs_write_verifier_cmp(&req->wb_verf, &verf-
> > > > verifier);
> > > =C2=A0}
> > > =C2=A0
> > > +static inline bool is_nfsiod(void)
> > > +{
> > > +	struct workqueue_struct *current_wq =3D
> > > current_workqueue();
> > > +
> > > +	if (current_wq)
> > > +		return current_wq =3D=3D nfsiod_workqueue;
> > > +	return false;
> > > +}
> > > +
> > > =C2=A0static inline gfp_t nfs_io_gfp_mask(void)
> > > =C2=A0{
> > > -	if (current->flags & PF_WQ_WORKER)
> > > +	if (is_nfsiod())
> > > =C2=A0		return GFP_KERNEL | __GFP_NORETRY |
> > > __GFP_NOWARN;
> > > =C2=A0	return GFP_KERNEL;
> > > =C2=A0}
> >=20
> >=20
> > Instead of trying to identify the nfsiod_workqueue, why not apply
> > current_gfp_context() in order to weed out callers that set
> > PF_MEMALLOC_NOIO and PF_MEMALLOC_NOFS?
> >=20
> > i.e.
> >=20
> >=20
> > static inline gfp_t nfs_io_gfp_mask(void)
> > {
> > 	gfp_t ret =3D current_gfp_context(GFP_KERNEL);
> >=20
> > 	if ((current->flags & PF_WQ_WORKER) && ret =3D=3D GFP_KERNEL)
> > 		ret |=3D __GFP_NORETRY | __GFP_NOWARN;
> > 	return ret;
> > }
>=20
> This would fix the problem we see, but we'll also end up carrying the
> flags
> from the layer above NFS into the client's current allocation
> strategy.
> That seems fragile to part of the original intent - we have static
> known
> flags for NFS' allocation in either context.

Yes, but if the PF_MEMALLOC_NOIO or PF_MEMALLOC_NOFS flags are set, the
memory manager will in any case water those flags down using the same
call to current_gfp_context().

This is really just making sure that we don't set the __GFP_NORETRY
flag in that case, because in a low memory situation that could end up
deadlocking due to being unable to kick off I/O in order to free up
memory.

> On the other hand, perhaps we want to honor those flags if the upper
> layer
> is setting them, because it should have a good reason -- to avoid
> deadlocks.
>=20
> We originally considered your suggested flag-checking approach, but
> went the
> "is_nfsiod" way because that seems like the actual intent of checking
> for
> PF_WQ_WORKER.=C2=A0 The code then clarifies what's actually wanted, and w=
e
> don't
> end up with future problems (what if nfsiod changes its PF_ flags in
> the
> future but the author doesn't know to update this function?)

If that were ever to happen, then we'd be well up the creek and without
a paddle.

Firstly, there is so much VFS work going on in nfsiod (dput(),
path_put(), iput(),....), that we really do not want to encumber it
with any PF_MEMALLOC restrictions.

Secondly, if we were to do so anyway, we definitely would want to
revisit this function, in addition to all those RPC callbacks that
would be affected.

> Do you prefer this approach?=C2=A0 I can send it with your Suggested-by o=
r
> authorship.
>=20
> The other way to fix this might be to create a mempool for nfs_page -
> which
> is the one place that uses nfs_io_gfp_mask() that doesn't fall back
> to a
> mempool.=C2=A0 We haven't tested that.

I think I prefer an approach that is aware of the limitations imposed
by the memory manager rather than one that just worries about which
workqueue we're on.

Note that one of the main differences between rpciod and nfsiod is
precisely the PF_MEMALLOC settings.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

