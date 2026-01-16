Return-Path: <linux-nfs+bounces-18010-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56305D32F81
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 993013026FE7
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789253358C4;
	Fri, 16 Jan 2026 14:50:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06B1E0E08;
	Fri, 16 Jan 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575035; cv=none; b=VuNyLqc00hFBB0V3H77m4zSSKBFNrKf7WLwNYzAF/A01q8HuNyn1a2FAX0/X82u7kOKhqUcNtETwsxtYg94uW/B2J0sg6nYc7PNJnNQSstQ+9YOiaY86KlVFvaXu6xTdvWvipfjI05THazaXA5C/hqYLzVh0qamaMK2bZzjScs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575035; c=relaxed/simple;
	bh=mrLSeVNh0K/R8D82Y1DY0cCYiI3uCZBfVUewqmXhQfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/57VDXVmPaYQuuK7ZV0GX1Lz0toYjTlHZZY4goTeCgvWb/LzqYp0ToOgKQbfWjPqqsOS6bBcdyccxovipgAQ9apMvd3qMXvRUskO4pstHkUuxfvSr4GMfxUd6Qm41CM1B4ILLv0BqGvgqO2E6g6firHj5MBaZlUyeL2CX8FPdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F018B227AB0; Fri, 16 Jan 2026 15:50:27 +0100 (CET)
Date: Fri, 16 Jan 2026 15:50:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 3/4] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260116145027.GA16842@lst.de>
References: <20260114143948.3946615-1-cel@kernel.org> <20260114143948.3946615-4-cel@kernel.org> <20260116114236.GG14359@unreal>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116114236.GG14359@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 16, 2026 at 01:42:36PM +0200, Leon Romanovsky wrote:
> On Wed, Jan 14, 2026 at 09:39:47AM -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > The bvec-based RDMA API currently returns -EOPNOTSUPP when Memory
> > Region registration is required. This prevents iWARP devices from
> > using the bvec path, since iWARP requires MR registration for RDMA
> > READ operations. The force_mr debug parameter is also unusable with
> > bvec input.
> 
> I am not very familiar with iWARP. Do you know why we need a special
> case here? Is there a reason we cannot avoid using scatterlists for
> iWARP as well, now or in the future?

iWarp must use MRs for the destination of RDMA READ operations, but the
core RW code can also optionally use it for other things.  So to support
that natively here we'd need a bvec-based version of ib_map_mr_sg.  Which
would be really nice to have for the storage host drivers anyway, but
until then the scatterlist emulation here can do.  And implementing it
might take a while, as ib_map_mr_sg is a very thin wrapper around a call
into the low-level driver.

