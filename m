Return-Path: <linux-nfs+bounces-16204-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B37C41D0A
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 23:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657551899C0A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE331327C;
	Fri,  7 Nov 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgOb9U66"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693E24BBE4
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554260; cv=none; b=VYftU/6pt8kX4CdVvwXOIM1A3BaoVNeL0Tq5Ex3Re1zqzTeR1X0r8uCn297IAQ++fyJqPz2dVeMV/TFrqqS+lYdMjYVEgo9usIrPg6VUV4ftuILYROk+rmFpxeuVjsa9fd/UR0Tl54DcVxgvmwSDc/t+D4QM/gPW6vlJtbgMTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554260; c=relaxed/simple;
	bh=ekONy9Lv/Vda8AgrD7ZXlmg+v1pW6FxqQLsiW3WA2pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QanFMbFJ1ABgDHoTJ3E+4waK7gu8YjQon4YmERj8g2mCtN31FjkbVuwDzEMYZi7TRWqVbDixMZDfBqKAc/D0YfgVzKrEjzqWKgwMfEBLIquQvZQexmBpE387GUBxr64rYhOIJcmEe2sL5d5+LarvcGsalDs1kmaPfZ68Hpdz/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgOb9U66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49176C4AF0D;
	Fri,  7 Nov 2025 22:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762554259;
	bh=ekONy9Lv/Vda8AgrD7ZXlmg+v1pW6FxqQLsiW3WA2pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgOb9U66Sfbc03ymJDoVoSjj0tdRoySMQe//fO0ObwcD92SQMBxK4JYPZs8ubecJ1
	 SOGMgw2x3sklm95MQEWe6yn2RuTs/b2smlnRJBL6e+tvLxH/0f1ao2XBlAQBwEsD/C
	 4VHO/S0OWALQX2wuP3LP/ROU0B9nb0WFVLjXN8+PNdWivCQjihOLFF0vvfDuvdn84a
	 JlnFWfxfYCy+A7aPE3AsDS9M+XMasJdkvdrKQjFa3/9NXmE2uNm2eOSGp+y2nzeeiL
	 6+EvH8gQhImVLcuxmo46LaYx4M3L9O/jMZg8ystC0KUwvv4NKhSTfVuAYOYdvJgzKk
	 1ZMcTtv+dLVQA==
Date: Fri, 7 Nov 2025 17:24:18 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQ5xkjIzf6uU_zLa@kernel.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
 <aQ4Sr5M9dk2jGS0D@infradead.org>
 <82be5f47-77df-423d-a4f3-17f83ddb6636@kernel.org>
 <aQ5Q99Kvw0ZE09Th@kernel.org>
 <fb0d6399-ea74-462a-982a-df232e3f4be9@kernel.org>
 <aQ5SSnW9xUWj9xBi@kernel.org>
 <176255273643.634289.15333032218575182744@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176255273643.634289.15333032218575182744@noble.neil.brown.name>

On Sat, Nov 08, 2025 at 08:58:56AM +1100, NeilBrown wrote:
> On Sat, 08 Nov 2025, Mike Snitzer wrote:
> > On Fri, Nov 07, 2025 at 03:08:11PM -0500, Chuck Lever wrote:
> > > On 11/7/25 3:05 PM, Mike Snitzer wrote:
> > > >> Agreed. The cover letter noted that this is still controversial.
> > > > Only see this, must be missing what you're referring to:
> > > > 
> > > >   Changes since v9:
> > > >   * Unaligned segments no longer use IOCB_DONTCACHE
> > > 
> > > From the v11 cover letter:
> > > 
> > > > One controversy remains: Whether to set DONTCACHE for the unaligned
> > > > segments.
> > 
> > Ha, blind as a bat...
> > 
> > hopefully the rest of my reply helps dispel the controversy
> > 
> 
> Unfortunately I don't think it does.  I don't think it even addresses
> it.
> 
> What Christoph said was:
> 
>    I'd like to sort out the discussion on why to set IOCB_DONTCACHE when
>    nothing is aligned, but not for the non-aligned parts as that is
>    extremely counter-intuitive.
> 
> You gave a lengthy (and probably valid) description on why "not for the
> non-aligned parts" but don't seem to address the "why to set
> IOCB_DONTCACHE when nothing is aligned" bit.

Because if the entire IO is so poorly formed that it cannot be issued
with DIO then at least we can provide the spirit of what was requested
from the admin having cared to enable NFSD_IO_DIRECT.

Those IOs could be quite large.. full WRITE payload.  I have a
reproducer if you'd like it!

Limiting extensive use of caching buffered IO is pretty important if
the admin enabled NFSD_IO_DIRECT.

A misaligned WRITE's non-aligned head and tail are _not_ extensive
amounts of mmeory.  They are at most 2 individial pages.

> I can see Christoph's point.
>
> Can you please explain why all the arguments you have for avoiding
> IOCB_DONTCACHE on the non-aligned head and tail do not equally apply
> when the whole body is assessed as non-aligned.  i.e.  the no_dio label
> in nfsd_write_dio_iters_init().

Sure, hopefully I just did above.

