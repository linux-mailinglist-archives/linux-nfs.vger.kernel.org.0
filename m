Return-Path: <linux-nfs+bounces-17915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84613D25B90
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBE12300673A
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6163B95FB;
	Thu, 15 Jan 2026 16:24:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1523B8BD0
	for <linux-nfs@vger.kernel.org>; Thu, 15 Jan 2026 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494284; cv=none; b=S5qvuDJFXSIPw8DS6dOpuThV3u3iRLdRhjgGnLv7MLc7MHrPgQqNxqpZJptdo4VnAO7nhbVkxWt2hH7Zmteb4vAIXsRwP7I9vmPpvfAhB6/ym+vQJ/YsA0PnGL70nGGXKl+z7S+sCHafMOYbPITtEwApLHR6JwQzsGO/AjA89wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494284; c=relaxed/simple;
	bh=k2NfctyVrJJJ6QZnT+J5JpyaryQFjv7EpNHJQ+IF+uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLE15GLjJzAfE6cqYgWSbsyJ3X+WaVZvpXHLZpS5elxPOExJpC2YUNSJ6aDWtSO8WXMfSWFx9Fbzxkb6ZwYKsjiJ8s1mxt91Qv+owghPo3ebDFdHkJhLo/dCIYUMQ7TxvupkKjSBZMrryDX7XsJlDkSQmrTkt2u1+77PKA2qFOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C9A81227AAA; Thu, 15 Jan 2026 17:24:37 +0100 (CET)
Date: Thu, 15 Jan 2026 17:24:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: add a LRU for delegations
Message-ID: <20260115162437.GA17257@lst.de>
References: <20260107072720.1744129-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107072720.1744129-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Any comments on this series except how to make it more complicated? :)

On Wed, Jan 07, 2026 at 08:26:51AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> currently the NFS client is rather inefficient at managing delegations
> not associated with an open file.  If the number of delegations is above
> the watermark, the delegation for a free file is immediately returned,
> even if delegations that were unused for much longer would be available.
> Also the periodic freeing marks delegations as not referenced for return,
> even if the file was open and thus force the return on close.
> 
> This series reworks the code to introduce an LRU and return the least
> used delegations instead.
> 
> For a workload simulating repeated runs of a python program importing a
> lot of modules, this leads to a 97% reduction of on-the-wire operations,
> and ~40% speedup even for a fast local NFS server.  A reproducer script
> is attached.
> 
> You'll want to make sure the dentry caching fix posted by Anna in reply
> to the 6.19 NFS pull is included for testing, even if the patches apply
> without it.  Note that with this and also with the follow on patches the
> baselines will still crash in some tests, and this series does not fix
> that.
> 
> Changes since v1:
>  - fix the nfsv4.0 hang
> 
> Diffstat:
>  fs/nfs/callback_proc.c    |   13 -
>  fs/nfs/client.c           |    3 
>  fs/nfs/delegation.c       |  544 +++++++++++++++++++++++-----------------------
>  fs/nfs/delegation.h       |    4 
>  fs/nfs/nfs4proc.c         |   82 +++---
>  fs/nfs/nfs4trace.h        |    2 
>  fs/nfs/super.c            |   14 -
>  include/linux/nfs_fs_sb.h |    8 
>  8 files changed, 342 insertions(+), 328 deletions(-)
---end quoted text---

