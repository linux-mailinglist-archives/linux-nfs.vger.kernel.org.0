Return-Path: <linux-nfs+bounces-13058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4765B0468E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 19:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E221A62E6B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F025C80D;
	Mon, 14 Jul 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOOSjnzF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDB24887E
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514419; cv=none; b=X45UvZ6YkMVn7QE7Pg0em+cwzeHzmKccM2YxYIbwyE2srxiOGPh8BiZc6KSCQKVdvJghYuY7bdXPp5kBk4JtyVWjF1bVsmRz1qcZeFYLk/S0neDEAxk+ybduUDw2C7as4Y9JjQkaiBof4yP4ot3PeoRdzMWKC9PBSaAmht7eeMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514419; c=relaxed/simple;
	bh=jO1O3Cx7LnQFLAZ5dri49BbmBy9JcrK0ABz+GxGJEuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrJ8h/heknhIc1u4hvOQS67Cjifcj9FD8Wh6si4a7u+X+IhEImEiQKvhboKXz8boJAz9zUqpO4HWRrQN+CMcbFkYZ9/HjGp0qMxvN5zUC3dMZANpG0U7qkIhBvwp8H6sDiXSwSFlp+apIcHDEBh/KmHtRKekQx2uawUbRjoAWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOOSjnzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8451C4CEED;
	Mon, 14 Jul 2025 17:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752514419;
	bh=jO1O3Cx7LnQFLAZ5dri49BbmBy9JcrK0ABz+GxGJEuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOOSjnzFZofw2LW358ycXfRPOCQNnIQlea/OvNypKNkkLhO4uBCl8bkrYuX0fvb87
	 kYuFkbJPbhO8+U3da+UZXZlBbVfjVy5Z2iX6hamF+a+ESIz9iABKaOaNSiwlMnECeN
	 TQBzBfHK7kXiDZwOndpHvIIDzW9rCeGOaRL0Tla6RczlBieyJZRqRK1rEmC8tNOsHs
	 DMRXo/lh6lqBlK+4JdCfQFJ0Woma3GW2AWTZa0y3tSqjv9xefOUgmuY4XJgLysOl9d
	 3FfPW5RtRQIWXT1peYgqYKFFOwrbTh+icFKVv0AMYbUczXsPCOsq0WhyINPXfr1DLe
	 17ARycdwLAPgw==
Date: Mon, 14 Jul 2025 13:33:37 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 6/8] NFSD: add io_cache_read controls to debugfs
 interface
Message-ID: <aHU_cdF5ifGttENy@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-7-snitzer@kernel.org>
 <aG9wH973C-8W2YWw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG9wH973C-8W2YWw@infradead.org>

On Thu, Jul 10, 2025 at 12:47:43AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 08, 2025 at 12:06:17PM -0400, Mike Snitzer wrote:
> > Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
> > read by NFSD will either be:
> > - cached using page cache (NFSD_IO_BUFFERED=0)
> > - cached but removed from the page cache upon completion
> >   (NFSD_IO_DONTCACHE=1).
> > - not cached (NFSD_IO_DIRECT=2)
> > 
> > io_cache_read is 0 by default.  It may be set by writing to:
> >   /sys/kernel/debug/nfsd/io_cache_read
> > 
> > If NFSD_IO_DONTCACHE is specified using 1, FOP_DONTCACHE must be
> > advertised as supported by the underlying filesystem (e.g. XFS),
> > otherwise all IO flagged with RWF_DONTCACHE will fail with
> > -EOPNOTSUPP.
> > 
> > If NFSD_IO_DIRECT is specified using 2, the IO must be aligned
> > relative to the underlying block device's logical_block_size. Also the
> > memory buffer used to store the read must be aligned relative to the
> > underlying block device's dma_alignment.
> 
> Does this also need some kind of check that direct I/O is supported
> at all by the file system / fops instance?

Long-term: definitely.  Near-term: not going to add it because it'd
have to be checked on a per-IO basis (because this debugfs-based
interface is a global setting so we don't have a specific export to
check at the time the request to use O_DIRECT is made via debugfs).

Once we graduate to having a per-export control interface in NFSD we
can then verify export's underlying filesystem supports O_DIRECT.

Hope this makes sense, thanks.

Mike

