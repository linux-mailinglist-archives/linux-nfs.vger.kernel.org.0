Return-Path: <linux-nfs+bounces-16234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA281C48708
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 770C44E3BA0
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Nov 2025 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBA2E6CB5;
	Mon, 10 Nov 2025 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMzsJhfD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EDE29D281
	for <linux-nfs@vger.kernel.org>; Mon, 10 Nov 2025 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797462; cv=none; b=Bx33VltDEl+Z8/MM5NXUSCQ7aaexo/eZ8TmWvJfr9f5FlZhgfh6sRKDw07zvawGV9TAqJIu62+Iwga/Y+CwH9yKtbfPF4Dsjys8GR5oNWfoJXRReS6Inxbm9FSi79yp7317LlpD3X+L+OX4On3mJ0kCcJQAxSD9s3fmHF+F0g1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797462; c=relaxed/simple;
	bh=oqBAPL5BwQ2HDF800QYDMEOysjocvnkHmt3Wp7C85g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Hng+AnP9tFpY+MaUu/YN6ZhWD0ul0iP/TQKo9c4ped+8gRLxEW3BM7RBmEQxr9AxLIxWzZ/xjF0JvY2IT7LEX8l0vwP6qhC+MlqblURbEB43lIOqajM8OzdvnMlCdQjjU8oMNTVfg6yJdSv+mFEWr3Ro5cIR+87ovCmGy+S/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMzsJhfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290A9C113D0;
	Mon, 10 Nov 2025 17:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762797462;
	bh=oqBAPL5BwQ2HDF800QYDMEOysjocvnkHmt3Wp7C85g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMzsJhfDU0u1UzS9CxlMpkNGgbnyH+/iNW9esWpJaoHsRmrAh/wn6IoJYAPurbtxw
	 Bvo0mBRKJzNM5C0z638A3ig/+MpjY6vm0Y8G15AD7MIrgqFB0bN93FYK1Ucnr283Vr
	 o8dyixSgDqhAMgBEVURbfT0T4BY6Quxv9l1yweuaZfDRBw1KHw5x+rqTyczu4orQCZ
	 eixyPM8PBpiD8lV6JX+J9fWakDLjCVC+VsjkW1r1WgTzAsD71jwmlDHraamsQBFp8C
	 pjKrHdCU52psddZo0Tey7MIaM0UOAQKS80dUIGdKUti1gLyOkCnZCJBtZGcOhXTOJy
	 w93T19SbLVGyg==
Date: Mon, 10 Nov 2025 12:57:41 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@ownmail.net>, Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aRInlX7ZO9SmdMhO@kernel.org>
References: <aQ4Sr5M9dk2jGS0D@infradead.org>
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
 <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
 <aQ5xkjIzf6uU_zLa@kernel.org>
 <176255894778.634289.2265909350991291087@noble.neil.brown.name>
 <aQ6kkd74pj2aUd8b@kernel.org>
 <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b024928-e078-4414-a062-bbeedfeea5d9@oracle.com>

On Mon, Nov 10, 2025 at 11:41:09AM -0500, Chuck Lever wrote:
> On 11/7/25 9:01 PM, Mike Snitzer wrote:
> > Q: Case 2 uses DONTCACHE, so case 1 should too right?
> > 
> > A: NO. There is legit benefit to having case 1 use cached buffered IO
> > when issuing its 2 subpage IOs; and that benefit doesn't cause harm> because order-0 page management is not causing the MM problems that
> > NFSD_IO_DIRECT sets out to avoid (whereas higher order cached buffered
> > IO is exactly what both DONTCACHE and NFSD_IO_DIRECT aim to avoid.
> > Otherwise MM spins and spins trying to find adequate free pages,
> > cannot so does dirty writeback and reclaim which causes kswapd and
> > kcompactd to burn cpu, etc).
> 
> Paraphrasing: Each unaligned end (case 1) is always smaller than a page,
> thus it will stick with order-0 allocations (if that byte range is not
> already in the page cache), allocations that are, practically speaking,
> reliable.
> 
> However it might be a stretch to claim that an order-0 allocation
> /never/ drives memory reclaim.

That's fair.

> It still comes down to "it's faster and generally not harmful... and
> clients have to issue WRITEs that are arbitrarily aligned, so let's help
> them out."
> 
> What we still don't know is exactly what the extra cost of setting
> DONTCACHE is, even on small writes. Maybe DONTCACHE should be cleared
> for /all/ segments that are smaller than a page?

I think so.  Might be Jens has thoughts on this (now cc'd)?

> Sidebar: I resist calling such writes poorly formed or misaligned, as
> there seems to be a little (unintended) moralism in those terms. Clients
> must write only what data has changed. Aligning the payload byte ranges
> (using RMW) is incredibly inefficient. So those writes are just as
> correct and valid as writes that are optimally aligned.
> 
> When I hear "poorly formed" write, I think of an NFS WRITE that has
> invalid arguments or corrupted XDR.

Very useful sidebar point.

NFSD is just trying to accommodate IO it has no choice but to service
from the NFS clients.

> > Let's please not get hung up of intent of O_DIRECT because
> > NFSD_IO_DIRECT achieves that intent very well
> 
> I think we need to have a clear idea what that intent is, because it
> is explicitly referenced in a code comment as the rationale for setting
> DONTCACHE.

Sure, the duality of:
DONTCACHE being useful for large buffered IO
  versus
DONTCACHE being detrimental for subpage IO.

That duality just means using DONTCACHE isn't a silver bullet for when
we need to fallback to buffered IO (but our overall intent is to avoid
page cache contention).

> It might be better to replace that comment with a reason for
> using DONTCACHE that does not mention "the intent of using DIRECT".
> Something like:
> 
>  * Mark the I/O buffer as evict-able to reduce memory contention.

Sure, that'd work.

I'm really reassured by how well you understand all this Chuck.

Restating for benefit of others (Jens in particular):

My point was that even with the case where an IO is split into 3
segments (1: subpage head 2: DIO-aligned middle 3: subpage tail) the
intent of O_DIRECT (avoiding caching buffered IO's page cache use) is
met as best we can (ideally IO is aligned so there are no subpage
end segments).

The other extreme this NFSD_IO_DIRECT mode must handle is the entire
IO doesn't have any segment that is DIO-aligned, so it must be issued
with buffered IO but we want to do so without opening us up to memory
contention, DONTCACHE gives us the best option for those IOs.

Mike

