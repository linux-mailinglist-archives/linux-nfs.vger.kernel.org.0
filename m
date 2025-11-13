Return-Path: <linux-nfs+bounces-16364-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F9C5A31A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 22:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2953B4DB0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 21:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C353128D9;
	Thu, 13 Nov 2025 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnWb72yf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C32DC78C
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763070319; cv=none; b=ur5bE125fYhh6U9BkaI5oR8EjQ5ZDuTIHmVa2NhUScSPNSqrc7W+D4GT8nXzJWshaJhOVB8Yi+kjbTUeGLvjiPRYKCv1Oo690HDZuuV0F9O4wvE7Xhxfw2bWb0cZk4xZwdqryNvhYTjvTFucdquwTPzpu1UuTtcxyX2/Kzk4PmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763070319; c=relaxed/simple;
	bh=JCe3aoq8IJg0uGT4Os8dqYD9WwC+PvBw9AF95sD5bak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8vhSQ9jUtrZM1wWIRahrMlJR4u3bX/gfOMdZOq/rIQukd8AQ46KDxNtYQT8FuLyjgb1YWlGzbgMGd+pdKii73o7y7+40b3zabu4JgZ29fZwgLunzegy74CjWqC+VnUDie0UWnugf8h6ZiLYXlNe4ZN0KhsFMUo4kXOO/Skuhc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnWb72yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DF0C4CEFB;
	Thu, 13 Nov 2025 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763070318;
	bh=JCe3aoq8IJg0uGT4Os8dqYD9WwC+PvBw9AF95sD5bak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnWb72yfXFtRRn2Qcsx33In+QqxUKNRLqIVWn3jx6g1cNUOMOJ/EmGrq0zEVXSdaQ
	 RX8BZ30DdVUXh+64Ey4QPslHF0v3F7kSZyK/Q8J3CPYmtPNvkJwVy/e9EmqkSK127E
	 rIfGzY+8EqRdI1wIjIbb5xIL67KSMNwgBcX5+qMIMMf14V/wGx0LVp1XNLnuJRKw52
	 WWrRUvgerKE+x3BN2IfSqp3OHi8pm3NhFwn5opSSlcnPPSLuD7RFbykI8plOQMT0PP
	 EetdsEXKp/sKrtMkfzsSNYAMcrL6u8AvIAC7M7klC2yFfBCkva4owZOkl279ivWp7J
	 DOLdzYpx4kTmA==
Date: Thu, 13 Nov 2025 16:45:17 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, jonathan.flynn@hammerspace.com
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRZRbSUN9_2xFK3Q@kernel.org>
References: <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
 <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
 <aRL5EPMD9VsG1n3D@infradead.org>
 <aRPPikkia5ZVZxJG@kernel.org>
 <aRShjU_Ti7f2Ci7I@infradead.org>
 <aRUUx2c6YNnRYRZ_@kernel.org>
 <aRWTFQZrmNCMfGtp@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRWTFQZrmNCMfGtp@infradead.org>

On Thu, Nov 13, 2025 at 12:13:09AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 12, 2025 at 06:14:15PM -0500, Mike Snitzer wrote:
> > > -	 * Check if direct I/O is feasible for this write request.
> > > -	 * If alignments are not available, the write is too small,
> > > -	 * or no alignment can be found, fall back to buffered I/O.
> > > +	 * If the file system doesn't advertise any alignment requirements,
> > > +	 * don't try to issue direct I/O.  Fall back to uncached buffered
> > > +	 * I/O if possible because we'll assume it is not block based and
> > > +	 * doesn't need read-modify-write cycles.
> > >  	 */
> > 
> > Not sure what is implied by "not block based" in this comment.
> 
> e.g. re-exporting another network file system or tmpfs.
> 
> > > +	/*
> > > +	 * If the I/O is smaller than the larger of the memory and logical
> > > +	 * offset alignment, it is like to require read-modify-write cycles.
> > > +	 * Issue cached buffered I/O.
> > > +	 */
> > 
> > Nit: s/like/likely/ typo.
> 
> Thanks.
> 
> > > +	if (!middle ||
> > > +	    ((prefix || suffix) && middle < PAGE_SIZE * 2))
> > >  		goto no_dio;
> > >  
> > >  	if (prefix)
> > 
> > Expressing this threshold in terms of PAGE_SIZE might be a
> > problem for other archs like ARM (where using 64K the norm for
> > performance).
> 
> True.
> 
> > The "Note:" portion of the above comment might do well to address the
> > goal being to avoid using cached buffered for higher order
> > allocations. You or Chuck may have solid ideas for refining wording.
> 
> Honestly I'm not worried about higher order allocations at all.  Yes,
> they used to be very painful in the past, but if we get them here
> it means the file system supports large folios, which means we're going
> to churn through a lot of them anyway.
> 
> > But so you're aware Jon Flynn (who kindly does the heavy lifting of
> > performance testing for me) agrees with you: larger will likely be
> > beneficial but it'll be hardware dependent.  So I'm going to expose a
> > knob for Jon to try various values so we can see.
> 
> That does sound useful, thanks!
> 
> > Overall this patch looks good.  Would welcome seeing you submit a
> > formal patch.  In parallel I'll work with Jon to get this tested on
> > Hammerspace's performance cluster to confirm all looks good.
> 
> I have no problem fixing up the nits and writing a commit message,
> but I have no time to properly test this.  I'm too busy with my
> own projects and just stealing some time to help with whiteboard
> coding here :)  I'd also be perfectly fine with whoever actually
> brings this across taking full credit.

Think it best to be attributed to you so if you have time to polish
the nits and put a header on it that'd establish a base that can be
tweaked (by Chuck) if needed.

You don't need to worry about testing, we'll get that covered for you
and report back.

