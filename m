Return-Path: <linux-nfs+bounces-11045-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24DA81710
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 22:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9DA8A3BE5
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Apr 2025 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA013CFB6;
	Tue,  8 Apr 2025 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ1yaPf3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCBB4642D;
	Tue,  8 Apr 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145117; cv=none; b=mogMh4rBSP1Ow/YkqV8xjbXryQY2B9dv6terUxRvQD9d52F2LHPEEKBdXE0Y78MUKH/3d1BnsgQl+AytRuKohLklGavaLn4WF9uq06fPzOzSrDJ4wamkgIK/GCps7irnkPQ4a5Kyl7VU5ho1b8bv8huTf5TDAS/PJZ+zHytVTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145117; c=relaxed/simple;
	bh=c9QrNns8lWQBZAm0oGh5Jp/aaGonP67faSrZGbYCpDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQArssNFgWxAiP6H1DGjS43YliOhR0PzQrInA7//slBiCb4IbK3YSevc4N4NCO/GjYQQ7c6zpcKWuxQK21VoIhn34nxZN8cqv4lJHmzjSUYW/8Tx9e22cH//PbB+zoVjGXjunMYN17nWaTAvGvFqGD5EX3rXqqPSlcslQYVJKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ1yaPf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47972C4CEE5;
	Tue,  8 Apr 2025 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744145116;
	bh=c9QrNns8lWQBZAm0oGh5Jp/aaGonP67faSrZGbYCpDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJ1yaPf3DJGWZnqvqT/ZO9B/BtdzdNft4aevebUPKuzrebtkkLq6w2uTFYd/kurVi
	 CinZx8+cLyqpTOa7lCjZaAZItaCxz357QsS7ch0TroiGaIHj3Q5zrxJJpBsPrkp9ox
	 icp0o8j326SMp100dTbNMPLUw1IIJSmzRHZo1zBIEhWpTiqoefcjOTi/JcxyiVzZO/
	 4MAD+z9ixPuo59NmmPr5hE8WsafWQzD2r+wEtPRbCzodquNjZ/VXept05iQ2U72uzz
	 eM17M9bVsMXqqS1lOHzpI0lFBxGqxMxrjXx0ksrCBf5aOYnValdfg/SHEwxHL7ciQp
	 ZkLUBojhA3LzA==
Date: Tue, 8 Apr 2025 20:45:14 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: add missing selections of CONFIG_CRC32
Message-ID: <20250408204514.GA3142638@google.com>
References: <20250401220221.22040-1-ebiggers@kernel.org>
 <35874d6a-d5bc-4f5f-a62c-c03a6e877588@oracle.com>
 <20250402162940.GB1235@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402162940.GB1235@sol.localdomain>

On Wed, Apr 02, 2025 at 09:29:41AM -0700, Eric Biggers wrote:
> On Wed, Apr 02, 2025 at 09:51:05AM -0400, Chuck Lever wrote:
> > On 4/1/25 6:02 PM, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > nfs.ko, nfsd.ko, and lockd.ko all use crc32_le(), which is available
> > > only when CONFIG_CRC32 is enabled.  But the only NFS kconfig option that
> > > selected CONFIG_CRC32 was CONFIG_NFS_DEBUG, which is client-specific and
> > > did not actually guard the use of crc32_le() even on the client.
> > > 
> > > The code worked around this bug by only actually calling crc32_le() when
> > > CONFIG_CRC32 is built-in, instead hard-coding '0' in other cases.  This
> > > avoided randconfig build errors, and in real kernels the fallback code
> > > was unlikely to be reached since CONFIG_CRC32 is 'default y'.  But, this
> > > really needs to just be done properly, especially now that I'm planning
> > > to update CONFIG_CRC32 to not be 'default y'.
> > 
> > It's interesting that no-one has noticed this before. dprintk is not the
> > only consumer of the FH hash function: NFS/NFSD trace points also use
> > it.
> > 
> > Eric, assuming you would like to carry this patch forward instead of us
> > taking it through one of the NFS client or server trees:
> > 
> > Acked-by: Chuck Lever <chuck.lever@oracle.com>
> > 
> > for the hunks related to nfsd and lockd.
> 
> Please go ahead and take it through one of the NFS trees.  Thanks!
> 

I ended up sending in the removal of 'default y' from CONFIG_CRC32 for 6.15.  So
I recommend that you send this NFS patch in for 6.15 as well, as it's now
slightly more likely that people can end up with CONFIG_CRC32 disabled (though
many other parts of the kernel select it anyway, so it still tends to be
enabled).

- Eric

