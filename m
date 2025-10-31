Return-Path: <linux-nfs+bounces-15843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F92C253DF
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42F0C4F571C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA26E210F59;
	Fri, 31 Oct 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="27bnHaV7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A0248F5C
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916761; cv=none; b=C334XMGIyi4qhP8w16wzhK7hl8VFWJv+0Gbvv6A5yM0xZwLoLuikUcnSSPROYgG64LKu3TRH6LB1MOtzfxRg2BjXfgkpQCN4y+Cv6D8Sss/xSDzkcJVXmzs+iL0BTBMm8Umu04fS79ocaZPt08ybfN4iX9znamWy9gX4WjPIa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916761; c=relaxed/simple;
	bh=tU24+N6WI1B0yXIy4CBxIqmZCVU9kJm9p2UySCzPGis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhSoZg5zyr3Hc6ruvAwidBoT5cJVTHL2+xum5Kk6bPjnx2g0B16Q93oxsUlwgSKIzkFDX49RaiVvZtS6Sw8O2eo0LFY+H/QXBWuhqh0nkdn0/Fp3hZhXzsLZOIkP028Bp/Bvaz+xEevWG1oAxhjJily1hq8G5QdWWpGfA+Uklhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=27bnHaV7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NtPH4xhIFbRocfnxwIMkejUa36JQ8OiM3OirhJeORhs=; b=27bnHaV7acAd3heaNsDxpQfF9t
	2PWfZ5joZpw6p86nnx8Le6jqhQGoZJOZQBrc1JrYR1cIsphyjQnFZWNZMYVkcqRrI3wS245393sE4
	XKObosDLpVeraN94dYZ6QvCKk5SEFAC4AhpEGSJkFMjWCeb57eN7Exgw85Lp7OTNzmcrQWPBMOkWk
	L39Lu6E1KYoBlG6T+pbg3bmp5YKFroqllYqArdNEospcMEEy23xXHJRYrw+y8+sVzaMW67xuezoRu
	+nRdhi/0kLtbMfA2gwBYmBpLor1p7hkVSCiozHmAAM4Viwf2kopODennV6yklYBo7GRUwsjiTOrkf
	/JAJBJGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEp2B-000000069Yz-3ber;
	Fri, 31 Oct 2025 13:19:15 +0000
Date: Fri, 31 Oct 2025 06:19:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 09/12] NFSD: Handle both offset and memory alignment
 for direct I/O
Message-ID: <aQS3U0bfw6X3J7J2@infradead.org>
References: <20251027154630.1774-1-cel@kernel.org>
 <20251027154630.1774-10-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027154630.1774-10-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 11:46:27AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Currently, nfsd_is_write_dio_possible() only considers file offset
> alignment (nf_dio_offset_align) when splitting an NFS WRITE request
> into segments. This leaves accounting for memory buffer alignment
> (nf_dio_mem_align) until nfsd_setup_write_dio_iters(). If this
> second check fails, the code falls back to cached I/O entirely,
> wasting the opportunity to use direct I/O for the bulk of the
> request.
> 
> Enhance the logic to find a beginning segment size that satisfies
> both alignment constraints simultaneously. The search algorithm
> starts with the file offset alignment requirement and steps through
> multiples of offset_align, checking memory alignment at each step.
> The search is bounded by lcm(offset_align, mem_align) to ensure that
> it always terminates.

How likely is that going to happen?  After the first bvec the
alignment constrains won't change, so how are we going to succeed
then?


