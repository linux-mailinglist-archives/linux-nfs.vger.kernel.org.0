Return-Path: <linux-nfs+bounces-12910-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C4AFA337
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Jul 2025 07:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E0017CF61
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Jul 2025 05:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F142B9B9;
	Sun,  6 Jul 2025 05:56:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724F2904
	for <linux-nfs@vger.kernel.org>; Sun,  6 Jul 2025 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751781407; cv=none; b=Vu0mPeKWbrCS/54pVvE6ZuBqPKNO+svobFqKAxrkmcBnutFD1iVgzj3Kyo2Venm/RgRczkM89Vpr8YcwkQlhGVKN7D8G6y53eLLFGiLjbE5Cqta+sw+Bftw1K+7J/wb9Xpf1eFi+fOaWLOS0G32dD3TJ8j3fXZLKLlJzIPtkrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751781407; c=relaxed/simple;
	bh=lraGTd/X4wmMxJFHR7UXJHolMFGGLTvIEz365ze7EfM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SCKcWoJ1RgEYiCDV+naPD0kG3r84CbcphFnRY3ytt50CY0anzipkpeNS31gHwaaRFTuiwpmN5XvI89S4+WMfXJ9AtoMHTS6mJhotVWvyXGDjCOnsv3GL9F31P3w7rns5A5652W6O+4Tm2Z4VW5fllGjihlfYr+S+G98D5mTWOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uYIMY-000RG4-Mi;
	Sun, 06 Jul 2025 05:56:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Li Lingfeng" <lilingfeng3@huawei.com>
Subject: Re: [PATCH 1/2] nfsd: provide locking for v4_end_grace
In-reply-to: <b7f95cbb80beb07dac509ab29ffd23411d1e1a03.camel@kernel.org>
References: <>, <b7f95cbb80beb07dac509ab29ffd23411d1e1a03.camel@kernel.org>
Date: Sun, 06 Jul 2025 15:56:31 +1000
Message-id: <175178139186.565058.4255610939470146301@noble.neil.brown.name>

On Sat, 05 Jul 2025, Jeff Layton wrote:
> On Fri, 2025-07-04 at 17:20 +1000, NeilBrown wrote:
> > Writing to v4_end_grace can race with server shutdown and result in
> > memory being accessed after it was freed - reclaim_str_hashtbl in
> > particular.
> >=20
> > We cannot hold nfsd_mutex across the nfsd4_end_grace() call as that is
> > held while client_tracking_op->init() is called and that can wait for
> > an upcall to nfsdcltrack which can write to v4_end_grace, resulting in a
> > deadlock.
> >=20
> > nfsd4_end_grace() is also called by the landromat work queue and this
> > doesn't require locking as server shutdown will stop the work and wait
> > for it before freeing anything that nfsd4_end_grace() might access.
> >=20
> > However, we must be sure that writing to v4_end_grace doesn't restart
> > the work item after shutdown has already waited for it.  For this we add
> > a new flag protected with a spin_lock, and nn->client_lock is suitable.
> > It is set only while it is safe to make client tracking calls, and
> > v4_end_grace only schedules work while the flag is set and with the
> > spin_lock held.
> >=20
> > So this patch adds an nfsd_net field "client_tracking_active" which is
> > set as described.  Another field "grace_end_forced", is set when
> > v4_end_grace is written.  After this is set, and providing
> > client_tracking_active is set, the laundromat is scheduled.
> > This "grace_end_forced" field bypasses other checks for whether the
> > grace period has finished.
> >=20
> > This resolves a race which can result in use-after-free.
> >=20
> > Reported-and-tested-by: Li Lingfeng <lilingfeng3@huawei.com>
> > Closes: https://lore.kernel.org/linux-nfs/20250513074305.3362209-1-liling=
feng3@huawei.com
> > Fixes: 7f5ef2e900d9 ("nfsd: add a v4_end_grace file to /proc/fs/nfsd")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/netns.h     |  2 ++
> >  fs/nfsd/nfs4state.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
> >  fs/nfsd/nfsctl.c    |  6 +++---
> >  fs/nfsd/state.h     |  2 +-
> >  4 files changed, 49 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 3e2d0fde80a7..fe8338735e7c 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -66,6 +66,8 @@ struct nfsd_net {
> > =20
> >  	struct lock_manager nfsd4_manager;
> >  	bool grace_ended;
> > +	bool grace_end_forced;
> > +	bool client_tracking_active;
>=20
> ISTM that the client_tracking_active bool is set and cleared similarly
> to the nn->client_tracking_ops pointer itself. It _might_ be possible
> to eliminate this bool and just use that pointer instead, though they
> are not exactly cleared at the same time.

Yes it might.
We currently set nn->client_tracking_ops before calling
nn->client_tracking_ops->init(),
and only clear it *after* calling nn->client_tracking_ops->exit().
If the ->init and ->exit functions never need nn->client_tracking_ops
(and I don't think they do) then we could set it after a successful
init, and clear it before calling ->exit.  Then we could use it as the
flag. We would need the exit path to be
  spinlock()
  ops =3D xchg(nn->client_tracking_ops, NULL);
  spinunlock()
  cancel_delayed_work_sync()
  ops->exit()

which is a little less abstraction than I would like, but should be ok.

This might be a useful simplification but I don't think we should try it
before submitting the fix.

Thanks for the suggestion and for the review.

NeilBrown


