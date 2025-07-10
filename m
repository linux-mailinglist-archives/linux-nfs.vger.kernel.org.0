Return-Path: <linux-nfs+bounces-12969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26133AFFAEF
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 09:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099A14E7DC1
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 07:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D53288512;
	Thu, 10 Jul 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfLnXFOy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE1227EB9
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132776; cv=none; b=Y0aOKQhNPpRwmRST/RipNn4/UYxl5esKN/FCRFnBvULHFqyYN3Nleln790UcV3miiiwzw+2gDPmDWCEw6ZphxTdUHh07JA+6GCarPavSJsF4819Hn9ZPcXb8kPK0wRaXpASZZrcyiwMZtmtILHXYtNzoqDe1QYOxbIHnB3NNWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132776; c=relaxed/simple;
	bh=qGPmS772EKrRnmCDTYrkdurlEKkSAXM7x9BAs9fC7YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGxic7Y78vHA2GACnDt+KIu6WHL8BeuzO0cDJr+6cfywxwNvAI/WlFIStQjIPB0fmPz/9korb38aZpDw+t8VzIf5YftnoiGZtrDY7UWravYNhuxnlSotCKu+hZPXQZbJJelwoM0hFn3pHic764ZPXe5DUm6hsR0y3vD/M/1D63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfLnXFOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0B2C4CEF4;
	Thu, 10 Jul 2025 07:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132776;
	bh=qGPmS772EKrRnmCDTYrkdurlEKkSAXM7x9BAs9fC7YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfLnXFOy5oB6D+YRC5LXVp4DjavFQw04/UijHSA5R899PtGsuaLww87gLzM21oPEo
	 kzhxAbecN0Gqu2pNu0Ah9/HDWGtRpQG9eBnfDJemHnZ5ZnlaCK3x7xFBeJ2USDt9TO
	 C5SrVkTJ0VXMxdUCuUoIhqx5r2ymLhtWeBbFOVLkdSiNTjKrf4TVFnBIoFNivIv2CS
	 DNdMzxseLl5ZoVM9e0TSqSZeelBj74dZQ9S2ARwkvAG6a2kxcDBbFvNERLqu98Lyd1
	 1zq5/pVclBoUXIpDZicu0KWOuNUCeEsuv+sORIu8q4/Et2e8KQNHI0NMjyKIEW5gdL
	 DbG3qdgKkhvuQ==
Date: Thu, 10 Jul 2025 03:32:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@hammerspace.com>
Subject: Re: [RFC PATCH 5/6] nfs/localio: refactor iocb initialization
Message-ID: <aG9splp24KjMMZES@kernel.org>
References: <20250708162047.65017-1-snitzer@kernel.org>
 <20250708162047.65017-6-snitzer@kernel.org>
 <aG9qd8hwXpUlaqTS@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG9qd8hwXpUlaqTS@infradead.org>

On Thu, Jul 10, 2025 at 12:23:35AM -0700, Christoph Hellwig wrote:
> > +	// FIXME: would do well to allocate memory based on NUMA node.
> > +	iocb->bvec = kmalloc_array(hdr->page_array.npages,
> > +				   sizeof(struct bio_vec), flags);
> 
> I don't think that's a "FIXME".  Either do it or leave it, but given
> that memory is allocated on the local node by default I can't see why
> that would be useful here for a short lived allocation. 

Yeah, meant to remove that FIXME.. will do for v3.

