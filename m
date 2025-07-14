Return-Path: <linux-nfs+bounces-13046-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED6B03FAF
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 15:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38AF4A3780
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6825EFBC;
	Mon, 14 Jul 2025 13:18:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0125DB12
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499130; cv=none; b=gsYpZk+4R/cQkXOgs6sdN7THH1WgvuK7unKXI4F7QWS1ZK0k9MJSUZpKWjXPTW1HtkSUOshZtL1FVYIh1qFeNUGRQUFoQiv/JFHcDn52WuBFMRbRbbrYR9NmAf+NdF6XE6s806bXbCb0E94Rr0S7BByIrK/Ay9kNa76f+ecV9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499130; c=relaxed/simple;
	bh=GE/KTmRQv6lkBbgNl1iIM1N96o2umNpMv54NVQqxWa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb4WNO98fy2ZI+Y/rUwCXlKEOWH+RL8jkMmBPEktHBeI5SxVHEfT3D4tzaDWgLEjnPDpWdLDgYgmv1ivxH3axb/JDcqrMJKr9F4S35N2F3+Fw0MgTShLTXRYZK2xh73b9/pty13+qoUl5rRGJkkbMT1sS2Db166VXirnrzn/pwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D8A8B227A88; Mon, 14 Jul 2025 15:18:44 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:18:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/4] NFS: use a hash table for delegation lookup
Message-ID: <20250714131844.GA9138@lst.de>
References: <20250714111651.1565055-1-hch@lst.de> <20250714111651.1565055-5-hch@lst.de> <fe1eccd60b2eff90f763aca232875d13643083fd.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1eccd60b2eff90f763aca232875d13643083fd.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 09:14:27AM -0400, Jeff Layton wrote:
> > +	delegation_buckets = roundup_pow_of_two(nfs_delegation_watermark / 16);
> > +	server->delegation_hash_mask = delegation_buckets - 1;
> > +	server->delegation_hash_table = kmalloc_array(delegation_buckets,
> > +			sizeof(*server->delegation_hash_table), GFP_KERNEL);
> > +	if (!server->delegation_hash_table)
> > +		goto out_free_server;
> > +	for (i = 0; i < delegation_buckets; i++)
> > +		INIT_HLIST_HEAD(&server->delegation_hash_table[i]);
> > +
> 
> This is going to get created for any mount, even v3 ones. It might be
> better to only bother with this for v4 mounts. Maybe do this in
> nfs4_server_common_setup() instead?

Yeah, good idea.

> Also, I wonder if you'd be better off using the rhashtable
> infrastructure instead of adding a fixed-size one? The number of
> delegations in flight is very workload-dependent, so a resizeable
> hashtable may be a better option.

I did try that first.  But the rhashtable expects the hash key to
be embedded into the structure that has the rhash_head embedded into
it, while delegations use the file handle embeded into the inode as
the key.  So we'd have to bloat the deleations with a key copy for
that.


