Return-Path: <linux-nfs+bounces-11492-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E300FAAC676
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85977BD7E8
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9242280327;
	Tue,  6 May 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hBuKsVtu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEB28031F;
	Tue,  6 May 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538462; cv=none; b=XYLgThjIC7cDhT2yTmb7hH2OrRbXllowKvH4/Is4J6pdvWyFot7e4o3UAaumxXoAiKmTioHA4Y32QfnIJINRfq33olhxaoD4hoX02aioAj1CQjQ9vpzp5l/CTflAdagondoRXJPaw/F0tBtZYpY2Hy2MzsMbro0UFEzNa5taWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538462; c=relaxed/simple;
	bh=LESk2txvr2n0dj8ebiCbsJaFOczDIfF5jmSmI96qSCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IESbZQvYgLodcdy85sZWhudohx7+rjO7rp7nAkwpfxyCf6wAxtKETmNTdY/YUQVBvae34Ufro5+dofTPvv+iYe595psjhljgWFXyCLwORoO35oJL9RF0F4zWpY4UI7yohsZ+m9iHPNt7A8kiKVjyDlHq3rxNLOTIF4SS26LsK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hBuKsVtu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YsIQ0d1HWaf3dYrChUjxa0ZRWIJORHyjFp6yuxrCqQ0=; b=hBuKsVtuIVKNZShhiyeUHJ2rGC
	Y90sYJOzNmkrpb6FaFb3yWnl5hKF3uA8sggBLU301YFDb2pgWcxC5J3bjYMvrBYKpU2pxlUq5ypwN
	bPE+JRt71HDd98IXK+GwQaZh+3HF5hLwcuco1YWzUhr3yMGK4N/13i4bsZ/Kgrb1mPxuCv2t40fcj
	B85mcHY9Lr7NFfK9rdlEhNw6EHRBAw0+p/0hepVio74hYnPz/sleKLcvjkytyUeQiUXEb9sMLeP9Q
	afKdbmlFXulQNZbk5d7F3XN6BbZ7tYUZXppknC8bMkJj6aWi6KBbSZx3pDuyIA2QJ4AZLBOno5f9p
	3V6bVhmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIR9-0000000C8pX-1e2b;
	Tue, 06 May 2025 13:34:19 +0000
Date: Tue, 6 May 2025 06:34:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 14/14] SUNRPC: Bump the maximum payload size for the
 server
Message-ID: <aBoP249KZ5G9hU81@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-15-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428193702.5186-15-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 28, 2025 at 03:37:02PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Increase the maximum server-side RPC payload to 4MB. The default
> remains at 1MB.
> 
> To adjust the operational maximum, shut down the NFS server. Then
> echo a new value into:
> 
>   /proc/fs/nfsd/max_block_size
> 
> And restart the NFS server.

Are you going to wire this up to a config file in nfs-utils that
gets set before the daemon starts?  Because otherwise this is a
pretty horrible user interface.


