Return-Path: <linux-nfs+bounces-11552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58ECAAD870
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109311732C6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9026221555;
	Wed,  7 May 2025 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nv13UPvp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A727221540;
	Wed,  7 May 2025 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603635; cv=none; b=txqMbkNRnWowF48HW6dldViCbwLsN6+Y2IWnVgMPiICn6z6jA4i6KaEC6oMo1JUIZ66b7cB1JYxxdJHEAg8xP7DxGeGZbokmVfF3P21AVTQI9zuHik+1EOp57Q4gpD9lHl+pUfVfZeKXkTtwPv4i+2UIsP5psfO5Tz1kTihzA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603635; c=relaxed/simple;
	bh=xIx6DXjIQNUGtrDQRfx5o5FXn7OCNA9KQlR89iYsqck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncIqJ/IShWffrEDClf3AUM01BNfrCQk6BFsvWWDU42FrFdYEYM/lxxy9V5dxIEmiA09gGhahLxhIMjA2U80QHV0hRQ7sOu1asB1SQ4Joqs2NFPiY6q1IXXwkT8eUhYqFqouuAn91AXBAwe7d3/HfLYsNaPKIUuPo6lUoj5rQE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nv13UPvp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IqBz2cHs2gtCdWK/N60eyK0HLigO7vk7Kt6becAjKUU=; b=Nv13UPvpBrf0ghSXOLZx7z7xbM
	M/CbgwRNqJpew5CKbVYpl4GnXPo8vLiDzHPTht9Y7LDt0p93axzY+U6bCcW/AU2WSjLlJeofz2X07
	efK9K3dZXYfLI0DBkJjttBD6LL1u0ty0CR4KLhHjwHPYrKvTY/Futs+vgoi5mzql1A7BCkc3FqSBZ
	rNUaWbm46ooU+gfR7nuhO6iQrP68UsJKSCIlpTx0qvp59KW+Mec/Wi1SxVd/1xUGvFXoZWPgtks7c
	6oQgOft8wYC5P/RoWx8FYUf96f/h1VLIEBJRJxgD3hQrtxQc51m7Ik43LmuFs2+Jikg/bKZySzyRD
	/NAwS7AA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZOK-0000000EZQe-1t6j;
	Wed, 07 May 2025 07:40:32 +0000
Date: Wed, 7 May 2025 00:40:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 08/14] svcrdma: Adjust the number of entries in
 svc_rdma_recv_ctxt::rc_pages
Message-ID: <aBsOcINI4LfejZjP@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-9-cel@kernel.org>
 <aBoPGNyGg0YPenm4@infradead.org>
 <72c3106e-4c2e-41f5-b8bd-3053ebb51f37@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72c3106e-4c2e-41f5-b8bd-3053ebb51f37@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 11:20:44AM -0400, Chuck Lever wrote:
> 1. svcrdma issues RDMA Read WRs from an svc_rqst thread context. It
>    pulls the Read sink pages out of the svc_rqst's rq_pages[] array, and
>    then svc_alloc_arg() refills the rq_pages[] array before the thread
>    returns to the thread pool
> 
> 2. When the RDMA Read completes, it is picked up by an svc_rqst thread.
>    svcrdma frees the pages in the thread's rq_pages[] array, and
>    replaces them with the Read's sink pages.

...

> One idea would be for NFSD to maintain a pool of these pages. But I'm
> not convinced that we could invent anything that's less latent than the
> generic bulk page allocator: release_pages() and alloc_bulk_pages().

I think the main issue is the completion thread, which first allocates
and then frees the pages.  If you instead just have a container for
the pages (or any other future context state) you avoid that.  I.e.
lifting the concept of a receive context from the rdma transport
to common code.

