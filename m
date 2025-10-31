Return-Path: <linux-nfs+bounces-15855-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E9C26195
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9512E5634BF
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80C134F461;
	Fri, 31 Oct 2025 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXJGoMp3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D834F27D
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926860; cv=none; b=h++/VvUE0PjzAhTyv6u6xsc3LOBq5VO06bTwcGPsd92VyFde3oOe66krVQEWlF9Y9TEzcy5j5HwkG1JT972TkmFcXMdmZlvPBAkU+pqGuuYlhVdwVPCG94I8PaqekdUnIr+2AOMgMyVIGn/oM8WUvV31+PpQFmKFi6WugOfN5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926860; c=relaxed/simple;
	bh=tvoSBEt2dC11Xsc2adZM1dQiLb9bylaXllf3i5lXf+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm4ROuEKLPEsCSHo6JVsHrAcuaj+rtqXnDywpg2/CLJNutqdnndxb+1wcqhyjXalVkWqS8KvYk+yUhtbEAV/tTGrWB020X6vBn7SesdADfRtq37jJbVDYt+r6Plmyvy/ABPHSvD2qChZoZPkPb+a9qrASBOaah+EUQi2ab6XS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXJGoMp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0671C4CEE7;
	Fri, 31 Oct 2025 16:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761926859;
	bh=tvoSBEt2dC11Xsc2adZM1dQiLb9bylaXllf3i5lXf+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXJGoMp3B/fQRPLn9+eVJOEDmzPuwIPbAIsKPYBfTRGxXKpgS8IkLcR995nellNve
	 ptMGjLHEmpzwjqaYrbVsxlF983EermPsh1M7v5wZjQdF9CK9Lkj6w/opy0NZdK0a4G
	 VRrIxmUPA18x+iB0bxJPPpZ0DlvnzMTmKrHCnKjWYtyNwlbwIj+4fhI9LOU3R7VYaz
	 rQ6jWyWFcOhcOScfUNkeC1UAlGncPC+MtlQzbMm6oVbes2dR8gxAXH0w2CcM55DeJC
	 ngu72AJF2l+P17DaYHoeQiUAygp34z0UZLCWYYJKKlxwUbYEaxiXiHZGRwS9/r+O3x
	 zwh5mI445In1w==
Date: Fri, 31 Oct 2025 12:07:37 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 09/12] NFSD: Handle both offset and memory alignment
 for direct I/O
Message-ID: <aQTeyczWFoERHlpf@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
 <20251027154630.1774-10-cel@kernel.org>
 <aQS3U0bfw6X3J7J2@infradead.org>
 <88535f7a-abc7-4649-a2b4-ba520e9aae0b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88535f7a-abc7-4649-a2b4-ba520e9aae0b@kernel.org>

On Fri, Oct 31, 2025 at 09:21:27AM -0400, Chuck Lever wrote:
> On 10/31/25 9:19 AM, Christoph Hellwig wrote:
> > On Mon, Oct 27, 2025 at 11:46:27AM -0400, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Currently, nfsd_is_write_dio_possible() only considers file offset
> >> alignment (nf_dio_offset_align) when splitting an NFS WRITE request
> >> into segments. This leaves accounting for memory buffer alignment
> >> (nf_dio_mem_align) until nfsd_setup_write_dio_iters(). If this
> >> second check fails, the code falls back to cached I/O entirely,
> >> wasting the opportunity to use direct I/O for the bulk of the
> >> request.
> >>
> >> Enhance the logic to find a beginning segment size that satisfies
> >> both alignment constraints simultaneously. The search algorithm
> >> starts with the file offset alignment requirement and steps through
> >> multiples of offset_align, checking memory alignment at each step.
> >> The search is bounded by lcm(offset_align, mem_align) to ensure that
> >> it always terminates.
> > 
> > How likely is that going to happen?  After the first bvec the
> > alignment constrains won't change, so how are we going to succeed
> > then?
> > 
> 
> I was hoping that this algorithm would improve the likelihood of
> finding a middle segment alignment for NFS WRITE on TCP. I'm not
> entirely sure it has been effective.
> 
> Given the complexity, I'm wondering if I want to keep this one.

I don't think its worth the complexity.  And I don't see how it'd help
make TCP's potentially unaligned buffer, for the NFS WRITE's payload,
able to work within the required ondisk logical offset granularity.

The mlperf_npz_tool.py I provided does a really good job of exposing
this worse case scenario, especially when the NFS client is forced to
use DIO (but even if just using buffered IO it has some issue just
that the NFS client's use of the page cache causes the IO that's sent
over the wire to NFSD to be much larger, so its head and tail of that
large IO are misaligned).  But when the NFS client does use O_DIRECT
each and every 1MB IO is offset in memory such that every single
logical_block_size isn't aligned relative to associated page -- each
spans multiple pages.

