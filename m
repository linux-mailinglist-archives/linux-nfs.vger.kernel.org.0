Return-Path: <linux-nfs+bounces-13112-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F577B0796B
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 17:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089EE16657C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F5B1DE892;
	Wed, 16 Jul 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNUv1aGA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B286E2C1A2
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679169; cv=none; b=aZ0+hWSQZmN84/g9zjcvUOh07f1BKK6Y0UxuXFZXM9GlEWpEVabQeFQqZ8m1gYrx3mBiQ7aqXD9vGP1IqZan+DaDO8le6rG5r86mzi0fqFPzALhC0NSuc1utGkvaG+kOdRY7kk9fnmfQ9Ii1aWozWkd9pL7dE6OBO2m7tWDJOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679169; c=relaxed/simple;
	bh=O4IZQln+35YXdXPwbzc6vVJkgrGXyVw7jdG70GKCeBA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMP5qib+wFuNOBW1hZ+PcSwjO4J3FpI1bVlHq+XAg5KzJanVGHqfKH/d+sjHXDEXLfLWcJD3qhuZS1EituTeUXKr2/KDQ56+Cj5mCcDcC1wrxSB+huI77ufxlYzNVUzYqn/SXpjb2MVVzljdhYZRqA+BdIX/D9o0AhyECznb0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNUv1aGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4278C4CEE7;
	Wed, 16 Jul 2025 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679169;
	bh=O4IZQln+35YXdXPwbzc6vVJkgrGXyVw7jdG70GKCeBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rNUv1aGAOaWT0wTCcM9MA7D/HByZ3S/4O1xwa2b5Wx7R+M6UKRxMfenUMbgVHMdiY
	 Hg8JAfgCZ25bQGJ1iJTlmPd0+9wJIld0/Iv7/rDxJqUDw3SkxbvhKaqouCSLQxptJ1
	 siL52Ds1UnQKcA/83tw6fBCGPCgxkk3352E/eLy8yo0VFTRUoqWcJUIEZssnktt7MI
	 T7qSek4G76zhWJ6F2C5cD67LNCVILRvIrqcVvsaNm1nf9dvjsb630Z72cw9duSTn7b
	 lCkc8eZmpvCzAEMz6aSYFhEdICB0x0EOR3FGGDvH31jGeIaWrouUcCWaxos7dDCP/3
	 I52Dv0/zlfvXQ==
Message-ID: <593804825ffbeb1e7f60224bd208f4401d3e1223.camel@kernel.org>
Subject: Re: [PATCH 3/3] NFS/localio: nfs_uuid_put() fix the wake up after
 unlinking the file
From: Trond Myklebust <trondmy@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Mike Snitzer
	 <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Date: Wed, 16 Jul 2025 08:19:27 -0700
In-Reply-To: <175264242036.2234665.5415540733180170207@noble.neil.brown.name>
References: <>, <ca1e6690006c4bbb4d62d0f2f340c1fb68191402.camel@kernel.org>
	 <175264242036.2234665.5415540733180170207@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 15:07 +1000, NeilBrown wrote:
> On Wed, 16 Jul 2025, Trond Myklebust wrote:
> > On Wed, 2025-07-16 at 11:31 +1000, NeilBrown wrote:
> > > On Wed, 16 Jul 2025, Trond Myklebust wrote:
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > >=20
> > > > After setting nfl->nfs_uuid to NULL, dereferences of nfl should
> > > > be
> > > > avoided, since there are no further guarantees that the memory
> > > > is
> > > > still
> > > > allocated.
> > >=20
> > > nfl is not being dereferenced here.=C2=A0 The difference between usin=
g
> > > "nfl"
> > > and "&nfl->nfs_uuid" as the event variable is simply some address
> > > arithmetic.=C2=A0 As long as both are the same it doesn't matter whic=
h
> > > is
> > > used.
> > >=20
> > >=20
> > > > Also change the wake_up_var_locked() to be a regular
> > > > wake_up_var(),
> > > > since nfs_close_local_fh() cannot retake the nfs_uuid->lock
> > > > after
> > > > dropping it.
> > >=20
> > > The point of wake_up_var_locked() is to document why
> > > wake_up_var() is
> > > safe.=C2=A0 In general you need a barrier between an assignment and a
> > > wake_up_var().=C2=A0 I would like to eventually remove all
> > > wake_up_var()
> > > calls, replacing them with other calls which document why the
> > > wakeup
> > > is
> > > safe (e.g.=C2=A0 store_release_wake_up(), atomic_dec_and_wake_up()).=
=C2=A0
> > > In
> > > this
> > > case it is safe because both the waker and the waiter hold the
> > > same
> > > spinlock.=C2=A0 I would like that documentation to remain.
> >=20
> >=20
> > The documentation is wrong. The waiter and waker do not both hold
> > the
> > spin lock.
>=20
> True.=C2=A0 In that case it would make sense to use
> store_release_wake_up()
> in nfs_uuid_put().=C2=A0 Though that doesn't have the right rcu
> annotations....
> I think=20
> =C2=A0=C2=A0=C2=A0 store_release_wake_up(&nfl->nfs_uuid, RCU_INITIALIZER(=
NULL));
> would be correct.
>=20
> >=20
> > nfs_close_local_fh() calls wait_var_event() after it has dropped
> > the
> > nfs_uuid->lock, and it has no guarantee that nfs_uuid still exists
> > after that is the case.
> > In order to guarantee that, it would have to go through the whole
> > rcu_dereference(nfl->nfs_uuid) rhumba from beginning of the call
> > again.
> >=20
> > The point of the rcu_assign_pointer() is therefore to add the
> > barrier
> > that is missing before the call to wake_up_var().
>=20
> rcu_assign_pointer()s add a barrier before the assignment.=C2=A0
> wake_up_var()
> requires a barrier after the assignment.
> In fact, when the val is NULL, rcu_assign_pointer() doesn't even
> include
> that barrier - it acts exactly like RCU_INIT_POINTER() - interesting.
>=20

Fair enough. I have a v2 of this patchset that Mike is testing out, and
that should fix this issue as well as the ones raised by the second
patch. I'll post once he is satisfied.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

