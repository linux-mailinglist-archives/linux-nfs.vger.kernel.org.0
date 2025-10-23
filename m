Return-Path: <linux-nfs+bounces-15577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EEC0384C
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 23:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 917304EB570
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 21:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCD129993D;
	Thu, 23 Oct 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxxCVovZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E1296BD0
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254611; cv=none; b=IH7JpXtA5OmiE/dtvcaV79zf9xviSm79f5lUXVS7RLOuGXn1aO4aEDgM30a4ADSLKG1wNnwyGVY//WzpnQQor2uo8NcWHZjofa1ztd7oWZCDTlCZX//xyejymormXSwtYK7NRzKfqVaDO/7THqwPxw3se43MtDoXELkl3LAGCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254611; c=relaxed/simple;
	bh=y5EtIkDpxFvAklR9v/Fbk7tPCLJ48lLfpluETzihw/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNYbZfwAiqbj8Cjh17oQ+ma+IR+R7hBwMWKufw21XtFVtfFfnzCYVIDZTwKzMMP6GGXnno3itc12kapjS+DpJbJQgs8wx5A1c5jxDnKps1lA25d89eTNHfr7U64Se7opARDbmsNS+D4hrbX/+3LdTnaLL6WhmGJR4I4x5E45muU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxxCVovZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52E9C4CEFF;
	Thu, 23 Oct 2025 21:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761254611;
	bh=y5EtIkDpxFvAklR9v/Fbk7tPCLJ48lLfpluETzihw/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxxCVovZQlFQ97CXyiVekWjWFMcLzP5pFJR5M6NpNcYQnzUhCkC8kM6YTPgySt2q2
	 ntpDGp3e+adjgdZaBC9wTbUuzgd6EYXRQvFbdWOnCk/nBjFbDy+9sNiBBUGX0zn56p
	 Wt+3oA6Z+UL2Rtztd6O2oGLccyPGXFioYHi/L8w88CaPdfPIVJoIAZhMVsYeZSNo97
	 y507bHzYLLAbvU87lFKxCjcZqFCix8uoY3jdcjJP0/OeIfhrPSHxPJ5S5zECOBQWdp
	 E0yi/8Dak/5aBPPEv8c51QAx+73r6QTfiFRtrcoGT29FWiNeJsAVhl0WxXBLBh8u1Q
	 opnkvANhm/VkQ==
Date: Thu, 23 Oct 2025 17:23:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, Tom Talpey <tom@talpey.com>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>
Subject: Re: [PATCH v6 4/5] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPqc0TPxVHRwq3og@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-5-cel@kernel.org>
 <33ee6dda-6b10-4a85-9346-5fc1bc6f2731@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ee6dda-6b10-4a85-9346-5fc1bc6f2731@kernel.org>

On Thu, Oct 23, 2025 at 03:37:36PM -0400, Chuck Lever wrote:
> On 10/22/25 3:22 PM, Chuck Lever wrote:
> > +struct nfsd_write_dio {
> > +	ssize_t	start_len;	/* Length for misaligned first extent */
> > +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> > +	ssize_t	end_len;	/* Length for misaligned last extent */
> > +};
> > +
> > +static bool
> > +nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
> > +			   struct nfsd_file *nf,
> > +			   struct nfsd_write_dio *write_dio)
> > +{
> > +	const u32 dio_blocksize = nf->nf_dio_offset_align;
> > +	loff_t start_end, orig_end, middle_end;
> > +
> > +	if (unlikely(dio_blocksize > PAGE_SIZE || len < dio_blocksize))
> > +		return false;
> > +
> > +	start_end = round_up(offset, dio_blocksize);
> > +	orig_end = offset + len;
> > +	middle_end = round_down(orig_end, dio_blocksize);
> > +
> > +	write_dio->start_len = start_end - offset;
> > +	write_dio->middle_len = middle_end - start_end;
> > +	write_dio->end_len = orig_end - middle_end;
> > +
> > +	return true;
> > +}
> > +
> > +static bool
> > +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
> > +			   unsigned int len_mask)
> > +{
> > +	const struct bio_vec *bvec = i->bvec;
> > +	size_t skip = i->iov_offset;
> > +	size_t size = i->count;
> > +
> > +	if (size & len_mask)
> > +		return false;
> > +	do {
> > +		size_t len = bvec->bv_len;
> > +
> > +		if (len > size)
> > +			len = size;
> > +		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> > +			return false;
> > +		bvec++;
> > +		size -= len;
> > +		skip = 0;
> > +	} while (size);
> > +
> > +	return true;
> > +}
> > +
> 
> Hey Mike, I'm trying to understand when nfsd_is_write_dio_possible()
> would return true but nfsd_iov_iter_aligned_bvec() on the middle segment
> would return false.

It is always due to memory alignment (addr_mask check), never due to
logical alignment (len_mask check).

So we could remove the len_mask arg and the 'if (size & len_mask)'
check from nfsd_iov_iter_aligned_bvec

