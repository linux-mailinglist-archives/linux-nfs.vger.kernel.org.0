Return-Path: <linux-nfs+bounces-13098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF12B06C73
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 05:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C6C7AB012
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 03:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCEC1E766F;
	Wed, 16 Jul 2025 03:51:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E21F4CB6
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637915; cv=none; b=RNgv3wB06P3WfmKhOXLL1bNysDwrhxIuCcwgwII1j7j3qUXv09qmpMfXSf1B4Gukrustj2bPN0GG7bPXEe+s9orJ55x/XOoLxGbWYsxKzIWz5c4bS7xYEyLCMuYlZVJtDc4OlSftsJ7umEYQSot3f18wPx5sqqHdTTOiYZaJ5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637915; c=relaxed/simple;
	bh=gNSGTf8XI+HNI2kLWHXVsChrjavg67btEGW4LQ9zOV0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=m//EKLVoJL2TjJWv/IxbSuW4b6+dAC0qdZDDDS5IWC1CU3I5XdzBbldoYT6bdHYcDwJwVRIXFPaKkaH9OhoUA2ycPpLWIRxv5ElA8uOdBN8pqEki5PhpwYQ66JSMBdVjLg98DhJ7nHsJbyg1kM8KccteogjE/95ZMQa2usB2gXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubtBN-002B1a-4U;
	Wed, 16 Jul 2025 03:51:50 +0000
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
Subject: Re: [PATCH 2/3] NFS/localio: nfs_uuid_put() fix the wait for file
 unlink events
In-reply-to: <95aa4d502e6614cd589baec518e597faaa37c5fa.camel@kernel.org>
References: <>, <95aa4d502e6614cd589baec518e597faaa37c5fa.camel@kernel.org>
Date: Wed, 16 Jul 2025 13:51:50 +1000
Message-id: <175263791059.2234665.5915802301120815518@noble.neil.brown.name>

On Wed, 16 Jul 2025, Trond Myklebust wrote:
> On Wed, 2025-07-16 at 11:22 +1000, NeilBrown wrote:
> > On Wed, 16 Jul 2025, Trond Myklebust wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > No reference to nfl is held when waiting in nfs_uuid_put(), so not
> > > only
> > > must the event condition check if the first entry in the list has
> > > changed, it must also check if the nfl->nfs_uuid field is still
> > > NULL,
> > > in case the old entry was replaced.
> > 
> > As no reference is held to nfl, it cannot be safe to check if
> > nfl->nfs_uuid is still NULL.  It could be freed and the memory reused
> > for anything.
> 
> It is quite safe.
> 
> The test first checks if the nfs_uuid->files list first entry still
> points to 'nfl'. Then it checks the value of nfl->nfs_uuid.
> 
> All this happens while the nfs_uuid->lock is held.

Ok, agreed.  It is safe.

> 
> > 
> > At this point, with nfs_uuid->net set to NULL, nothing can be added
> > to
> > nfs_uuid->files.  Things can only be removed.
> 
> There is nothing in either nfs_open_local_fh() or nfs_uuid_add_file()
> that stops anyone from adding a new entry to nfs_uuid->files in the
> case where nfs_uuid->net is NULL.

nfs_open_local_fh() starts:
	rcu_read_lock();
	net = rcu_dereference(uuid->net);
	if (!net || !nfs_to->nfsd_net_try_get(net)) {
		rcu_read_unlock();
		return ERR_PTR(-ENXIO);
	}
	rcu_read_unlock();

so if uuid->net is NULL, it will return and not add to the list.
Of course there could be races with nfs_put_uuid() called after that
check. The nfsd_net_try_get(net) check is supposed to handle that case.

But I cannot convince myself that it does.  In particular expkey_flush()
calls nfsd_file_cache_purge() which calls
nfs_localio_invalidate_clients().  This can happen when
nfsd_net_try_get() will succeed.

So I agree that things could get added to the nfs_uuid->list after ->net
has been set to NULL, but that is a bug.  nfs_uuid_put() shouldn't be
checking for that.

I don't think nfsd_file_cache_purge() should be invalidating the clients
in this case - just the files that the clients have open so they are
forced to re-open.

I'm not sure how best to resolve this at present.

Thanks,
NeilBrown

> 
> If that was the intention, then I agree that this patch is wrong, but
> not for the reasons you listed.
> 
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
> 


