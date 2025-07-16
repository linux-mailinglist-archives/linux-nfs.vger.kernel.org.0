Return-Path: <linux-nfs+bounces-13099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F19AB06C91
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 06:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B895417E33F
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 04:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B427511F;
	Wed, 16 Jul 2025 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0i+AaiA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EDC273807
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752639444; cv=none; b=BNLHZ9Yh4M9oAVg4wr7RQaREYLN8RJP/YljLuLWLl9EWbdhdPRJqFjDsByu9aW1nRyOLc/cbelAam96pp5o8BNW8LldXHp1C4/M2QsTE0856vJQfgZu/MNZAhSNaRAGYiE+EGo7T9cVBULyRhlAy9aLCtsmoAgjyHDuVDQjZfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752639444; c=relaxed/simple;
	bh=+ggEc5Ud7708Tb55jFoh1vgkil4M0pandbxrBzGcKtc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1e0yg1AuMQWYV/E2yKa5HqWwUbd5IVOzQpw0OTMJnyR9UZkcw/p5i9fqBPlslGWBpvLD59LD34eq+INd/+GDyXzYgai5VwJDQt6gfj0zCImsQ3GEAlLoyBi4UDP7gxeqR2xD8Gh6atftekiY0y3NA7vSAHzh4M7yortB8DHtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0i+AaiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6949C4CEF0;
	Wed, 16 Jul 2025 04:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752639443;
	bh=+ggEc5Ud7708Tb55jFoh1vgkil4M0pandbxrBzGcKtc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U0i+AaiAnzNALuPTKs4ZSz3cHfeJpkyNkB7rSxxQtrCJHGVgqOD2vk2jfzCk8HzwM
	 rlIvesacM8zmMqbtWkebR3NKPCAtdKXLuMzHC7Gy4Aj/qtqJulidUeUuKtWUDeAaj6
	 dmSeFgPGt1j1Ss0HjWOCOT7PhvMdP8scfqpKqfRvawCi4bxHPu9vGkfrSYc/y9/CoD
	 fD/l2fhyuVrMEKA/qTwoZgCpIPDphzBOFNp/AKZFdohCmTDpInTZMVaJ0g+UsF8rU+
	 CXVZzn9Qe4qDjAy16mVYg/2qZ6jgLx8VJdoM+LXz31LSHHRKqqy+7BOJ4zerhQx9hg
	 XO+9/Kqpkt1VA==
Message-ID: <ca1e6690006c4bbb4d62d0f2f340c1fb68191402.camel@kernel.org>
Subject: Re: [PATCH 3/3] NFS/localio: nfs_uuid_put() fix the wake up after
 unlinking the file
From: Trond Myklebust <trondmy@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Mike Snitzer
	 <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Date: Tue, 15 Jul 2025 21:17:21 -0700
In-Reply-To: <175262948827.2234665.1891349021754495573@noble.neil.brown.name>
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>
	,  =?utf-8?q?=3C2d9b6631ff2256320208250fbec9bc6e0918377e=2E1752618161=2Egit=2E?= =?utf-8?q?trond=2Emyklebust=40hammerspace=2Ecom=3E?= <175262948827.2234665.1891349021754495573@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 11:31 +1000, NeilBrown wrote:
> On Wed, 16 Jul 2025, Trond Myklebust wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >=20
> > After setting nfl->nfs_uuid to NULL, dereferences of nfl should be
> > avoided, since there are no further guarantees that the memory is
> > still
> > allocated.
>=20
> nfl is not being dereferenced here.=C2=A0 The difference between using
> "nfl"
> and "&nfl->nfs_uuid" as the event variable is simply some address
> arithmetic.=C2=A0 As long as both are the same it doesn't matter which is
> used.
>=20
>=20
> > Also change the wake_up_var_locked() to be a regular wake_up_var(),
> > since nfs_close_local_fh() cannot retake the nfs_uuid->lock after
> > dropping it.
>=20
> The point of wake_up_var_locked() is to document why wake_up_var() is
> safe.=C2=A0 In general you need a barrier between an assignment and a
> wake_up_var().=C2=A0 I would like to eventually remove all wake_up_var()
> calls, replacing them with other calls which document why the wakeup
> is
> safe (e.g.=C2=A0 store_release_wake_up(), atomic_dec_and_wake_up()).=C2=
=A0 In
> this
> case it is safe because both the waker and the waiter hold the same
> spinlock.=C2=A0 I would like that documentation to remain.


The documentation is wrong. The waiter and waker do not both hold the
spin lock.

nfs_close_local_fh() calls wait_var_event() after it has dropped the
nfs_uuid->lock, and it has no guarantee that nfs_uuid still exists
after that is the case.
In order to guarantee that, it would have to go through the whole
rcu_dereference(nfl->nfs_uuid) rhumba from beginning of the call again.

The point of the rcu_assign_pointer() is therefore to add the barrier
that is missing before the call to wake_up_var().

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

