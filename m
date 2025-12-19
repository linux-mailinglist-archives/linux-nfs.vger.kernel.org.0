Return-Path: <linux-nfs+bounces-17226-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208BCCE80F
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 06:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA380300A55A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 05:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DF4222584;
	Fri, 19 Dec 2025 05:21:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1781F17E8
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766121697; cv=none; b=TH7hS80B4wiu7SMOiSwGHJbTS7WJVow1nlS/tok70EvtDZrQkqzABviQ/bFCpYbmp8RuHf5el9L1N0cF7ZVXY7LOiIbXm0nB59lp8VJvIp2sOmaNUQhf+tmhCUi2XfOWfcRtD3cW1/uuZjPTDYw2DQDtv3p48vsl5YfZ08mPAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766121697; c=relaxed/simple;
	bh=sItjMJ5cSWIutoL5vTzfF2BvZIonjTLHsPIWPL571Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj4a6ceYXed+l5DBvMt4QlqwB4WO5AUiAYSEqaPVxpibCGurHGz2g5w9b+y417AiaV/AbRDhjRUAhFXXhVKbzifkvTK7GMsUABV41TZ2keM9zuq+gs7yqJBNnhpfFQf6gOE/7lEVKBubbHFuF8AC43tU4QE20TBNEVDkt38pbWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2DBB227A88; Fri, 19 Dec 2025 06:21:24 +0100 (CET)
Date: Fri, 19 Dec 2025 06:21:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 23/24] NFS: return delegations from the end of a LRU
 when over the watermark
Message-ID: <20251219052124.GA29411@lst.de>
References: <20251218055633.1532159-1-hch@lst.de> <20251218055633.1532159-24-hch@lst.de> <13891f50-73a1-40ee-aaa2-373dba3886e6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13891f50-73a1-40ee-aaa2-373dba3886e6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 18, 2025 at 05:02:26PM -0500, Anna Schumaker wrote:
> > Pass over referenced delegations during the first pass to give delegations
> > that aren't in active used by frequently used for stat() or similar another
> > chance to not be instantly reclaimed.  This scheme works the same as the
> > referenced flags in the VFS inode and dentry caches.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I'm seeing fstests hang on generic/013 after applying this patch and running
> with NFS v4.0. Other versions of NFS still seem to work just fine. Have you
> seen anything like this in your testing?

I have to admit I completely ignored NFSv4.0 as usual.  I can reproduce
the hang, but oddly enough not when running the test standalone, but only
as part of at least a quick xfstests run.  Looking into it now.


