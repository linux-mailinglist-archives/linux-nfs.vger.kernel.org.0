Return-Path: <linux-nfs+bounces-13100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE91EB06CF2
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 07:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCECF3A8CDB
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 05:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C481DB95E;
	Wed, 16 Jul 2025 05:07:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285541D90DD
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642425; cv=none; b=k12u8vMAdntDJpDlol4KBDvS0/09WQLFAVLzTQPv/ZTF+rBdiWi1AyhmYEb4H7/xK6vOxFOojVcau6wK9u84WubnpeJpni/kXCWd+vlruAvVQOPPlGvdc/qansmf7kPJko23HOd5wCBCiPPZCOH083uYNyomxxZ1NHtmzI0S3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642425; c=relaxed/simple;
	bh=RwNTTdRLFtrWt3JkzRUFDLS/fyBYL2DAkpaMZaYNCtI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BkjmCEHnIxwZv3n6PPA5WjmwTxYkk0Y2plFMRtteiLVjpL8h9ayFGjrbyN8gYA2xZYhkNa2E48Uk+KGo37xOL29Q5XMCM7bnvL+IGPKkxiqdxsAuEhdxoM8ey3w8fZrn/7rYugxdz4eLwuA2MB+kC6iry5l7O+aA6l4oR9YUbnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubuM6-002BG8-Sp;
	Wed, 16 Jul 2025 05:07:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Trond Myklebust" <trondmy@kernel.org>
Cc: "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/3] NFS/localio: nfs_uuid_put() fix the wake up after
 unlinking the file
In-reply-to: <ca1e6690006c4bbb4d62d0f2f340c1fb68191402.camel@kernel.org>
References: <>, <ca1e6690006c4bbb4d62d0f2f340c1fb68191402.camel@kernel.org>
Date: Wed, 16 Jul 2025 15:07:00 +1000
Message-id: <175264242036.2234665.5415540733180170207@noble.neil.brown.name>

On Wed, 16 Jul 2025, Trond Myklebust wrote:
> On Wed, 2025-07-16 at 11:31 +1000, NeilBrown wrote:
> > On Wed, 16 Jul 2025, Trond Myklebust wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > After setting nfl->nfs_uuid to NULL, dereferences of nfl should be
> > > avoided, since there are no further guarantees that the memory is
> > > still
> > > allocated.
> > 
> > nfl is not being dereferenced here.  The difference between using
> > "nfl"
> > and "&nfl->nfs_uuid" as the event variable is simply some address
> > arithmetic.  As long as both are the same it doesn't matter which is
> > used.
> > 
> > 
> > > Also change the wake_up_var_locked() to be a regular wake_up_var(),
> > > since nfs_close_local_fh() cannot retake the nfs_uuid->lock after
> > > dropping it.
> > 
> > The point of wake_up_var_locked() is to document why wake_up_var() is
> > safe.  In general you need a barrier between an assignment and a
> > wake_up_var().  I would like to eventually remove all wake_up_var()
> > calls, replacing them with other calls which document why the wakeup
> > is
> > safe (e.g.  store_release_wake_up(), atomic_dec_and_wake_up()).  In
> > this
> > case it is safe because both the waker and the waiter hold the same
> > spinlock.  I would like that documentation to remain.
> 
> 
> The documentation is wrong. The waiter and waker do not both hold the
> spin lock.

True.  In that case it would make sense to use store_release_wake_up()
in nfs_uuid_put().  Though that doesn't have the right rcu
annotations....
I think 
    store_release_wake_up(&nfl->nfs_uuid, RCU_INITIALIZER(NULL));
would be correct.

> 
> nfs_close_local_fh() calls wait_var_event() after it has dropped the
> nfs_uuid->lock, and it has no guarantee that nfs_uuid still exists
> after that is the case.
> In order to guarantee that, it would have to go through the whole
> rcu_dereference(nfl->nfs_uuid) rhumba from beginning of the call again.
> 
> The point of the rcu_assign_pointer() is therefore to add the barrier
> that is missing before the call to wake_up_var().

rcu_assign_pointer()s add a barrier before the assignment.  wake_up_var()
requires a barrier after the assignment.
In fact, when the val is NULL, rcu_assign_pointer() doesn't even include
that barrier - it acts exactly like RCU_INIT_POINTER() - interesting.

Thanks,
NeilBrown

> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
> 


