Return-Path: <linux-nfs+bounces-13878-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E6B32C9A
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Aug 2025 01:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B66B3B3CDE
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Aug 2025 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB8A1D5CD4;
	Sat, 23 Aug 2025 23:57:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD9192B7D
	for <linux-nfs@vger.kernel.org>; Sat, 23 Aug 2025 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755993448; cv=none; b=Q9BBSpydrVZNhnetJAEZGEo5OimRdsPAIxD4vL9+Kqu5ODdl688xo7MRmkUP4rQBaehqBgu/nPrEWBsw2w1VkVV603e67zSqEWYbOt+RJwyIidemX/aofcsZKN6yivYaQoUMnzCKCNUhGu9iAMXEKoYVqG9pWzn8c1EPn+jh3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755993448; c=relaxed/simple;
	bh=uN0FK4J6jo/5Twimcd3XdBskGOV0cr/I1S6vnE6nxeQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jK37+v2f+5rlgdCvk9DuvMNdE4nQzeH8pY1CvCiQKbJbX3pm8n3wa905z95Hs8sX72nsy/0JwY9aSkFm5Bryr7ZbQhCDspnRQhx58ui54z3V0S31Jvkyheld833DqwHrd+FOMkMI8axxTyDfB+YC0M9UWPiB808p+OrO2h/tEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upy6r-006z5j-20;
	Sat, 23 Aug 2025 23:57:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, jlayton@kernel.org,
 linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Subject: Re: [RFC PATCH 1/1] nfsd: delay re-registering of listeners after
 listener removal
In-reply-to: <86c49f0f-1ba7-414b-b4a2-5c470614b0bc@oracle.com>
References: <>, <86c49f0f-1ba7-414b-b4a2-5c470614b0bc@oracle.com>
Date: Sun, 24 Aug 2025 09:57:22 +1000
Message-id: <175599344250.2234665.2672261349217032658@noble.neil.brown.name>

On Sat, 23 Aug 2025, Chuck Lever wrote:
> On 8/21/25 5:01 PM, Chuck Lever wrote:
> > On 8/21/25 4:43 PM, Olga Kornievskaia wrote:
> >> This patch tries to address the following failure:
> >> nfsdctl threads 0
> >> nfsdctl listener +rdma::20049
> >> nfsdctl listener +tcp::2049
> >> nfsdctl listener -tcp::2049
> >> nfsdctl: Error: Cannot assign requested address
> >>
> >> The reason for the failure is due to the fact that socket cleanup only
> >> happens in __svc_rdma_free() which is a deferred work triggers when an
> >> rdma transport is destroyed. To remove a listener nfsdctl is forced to
> >> first remove all transports via svc_xprt_destroy_all() and then re-add
> >> the ones that are left. Due to the fact that there isn't a way to
> >> delete a particular entry from a list where permanent sockets are
> >> stored.
> > 
> > The issue is specifically with llist, which does not permit the
> > deletion of any entry other than the first on the list.
> > 
> > 
> >> Going back to the deferred work done in __svc_rdma_free(), the
> >> work might not get to run before nfsd_nl_listener_set_doit() creates
> >> the new transports. As a result, it finds that something is still
> >> listening of the rdma port and rdma_bind_addr() fails.
> >>
> >> Proposed solution is to add a delay after svc_xprt_destroy_all() to
> >> allow for the deferred work to run.
> >>
> >> --- Is the chosen value of 1s enough to ensure socket goes away?
> >> I can't guarantee that.
> > 
> > Adding a sleep and hoping it works is ... not a proper fix. The
> > msleep() in svc_xprt_destroy_all() is part of a polling loop,
> > and it is only waiting for the xprt lists to become empty. You're
> > not polling here (ie, checking for completion before sleeping).
> > 
> > 
> >> --- Alternatives that i can think of:
> >> (1) to go back to listener removal approach that added removal of
> >> entry to the llist api. That would not require a removal of all
> >> transport causing this problem to occur. Earlier it was preferred
> >> not to change llist api.
> >> (2) some method of checking that all deferred work occuring in
> >> svc_xprt_destroy_all() completed.
> > 
> > Jeff (and perhaps Lorenzo) need to go back to the original reasons why
> > this was done and rework it. I think we were avoiding holding the
> > nfsd mutex in here?
> > 
> > Complete shutdown of a transport always involve some deferred
> > activity, and there's a reference count involved as well. I can't
> > see how the current destroy/re-insert mechanism can be made reliable.
> 
> One thought is that instead of using svc_xprt_destroy_all(), can we
> simply call svc_xprt_close() on the target transport?
> 
> The question about what to wait for to ensure the transport is gone
> is a different problem: the memory backing the svc_xprt will be
> freed, so we can't, say, "wait on bit" on one of the transport
> flags.

The standard solution would be to store a pointer to a completion in the
svc_xprt which, if not NULL, is completed before the memory is freed.
Then have the waiter set that to an on-stack completion before
triggering the shutdown.  Then wait_for_completion().

NeilBrown

