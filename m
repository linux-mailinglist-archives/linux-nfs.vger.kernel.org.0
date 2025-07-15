Return-Path: <linux-nfs+bounces-13070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE05B055A7
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 10:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9EC4A7BD0
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA126E143;
	Tue, 15 Jul 2025 08:58:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC020F088
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569931; cv=none; b=cKDh6P5Fp+3Y7fOU305mxLfDBk1+wlMvoPCE/ZttyMt4d81C5Ir+tNieqK+y6fGzlzokJi3+0D5ijsCp0ujLuxXUyXcdhbx6zBjLmDTYAS3h2rmOP8koYE9qqv2sNXgqbo1WNvW1wBIChsju3kDMtQnYC2nNVg/OLHnKzpN4Jeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569931; c=relaxed/simple;
	bh=K3EhulxDrAP6YPyjvmiBMinhhVVH3raxevdqIfFTXZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUReyypGlNzLdPyArp/XjmhpZYHOw6wPWVljAnRMvDyzqCqSdFj22MEGzprSSmowAkPHxoDuJ7ZrAcQEvBh2XmBFAVgYIu8l9mNR5rDnluaPZ6xQtrYDTUO2YpHlmxhaFhnZMtqo1xorz1F9HTG4DK5pkr5PkPl+9KAfBzUKdDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D45E68AFE; Tue, 15 Jul 2025 10:58:45 +0200 (CEST)
Date: Tue, 15 Jul 2025 10:58:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/4] NFS: use a hash table for delegation lookup
Message-ID: <20250715085844.GA21655@lst.de>
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

I tried that, but it crashes because the usual mount process goes
through nfs_clone_server, which then doesn't set up the hash table.

I think the best idea is to pass the version to nfs_allocate_server
and just make this code conditional, but I'm open to other suggestions.


