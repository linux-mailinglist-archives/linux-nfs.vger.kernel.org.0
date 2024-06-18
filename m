Return-Path: <linux-nfs+bounces-3993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722D690D981
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49338B3707B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0813DDD6;
	Tue, 18 Jun 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFxXnd3I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EC13DDAB
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727346; cv=none; b=QcAj5QTPvj7rWHsQpINaifNgFDr6y7cLs4W8kvZueWx83/b20S/utreE1n/ZIttfXTWj3kr/Fh5zYXYRHkcRc3c/FgVofMbLOPjGfP5zbFZ61M1ycAByeC+felENi7kkaxeoqcTfAH2ePxFl7h0x6MUIGCzJdjI6rRM+5VZgLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727346; c=relaxed/simple;
	bh=jdDc6dNpJSpygGbs3pjLeX+UNVljsPBdZI3UxH894/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETNVOLkdbjx6qP3SboypSAzL12VSDAqZnJYZkl0gfTZ0Sm8x/EGZwUv801EI7ieG0/CeO16Rcczj2j3eM8ZqE9lwIEEq1eWz4UCOCWr/ZtN9uHVow1jQwkeGsaFedbtQxN0mAMaVLEQpzUMDyw+ZYj0l5/S3yVpGZ+0GfzZqrC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFxXnd3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3698AC3277B;
	Tue, 18 Jun 2024 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727345;
	bh=jdDc6dNpJSpygGbs3pjLeX+UNVljsPBdZI3UxH894/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFxXnd3IvB5ZzionkdwaSApZP/L5kXH40YNNZ17Jvr6MqHxfqkqeHhq8Rm2k2yyil
	 SUYXVeMbCwNokSdtPCLBNt1lzaDdi3yaRHcgI3ehnCXEXzjGxYCOo8sEJOvFwrJR/n
	 +CxE4vTSvgZTxmLwrTTF1MJcFSebgPxaB09/tFVBPwajnpj1VCV8GpH/WzK0suyn+f
	 hehGolQXizSa6cY5JAt1zdcWpC6qwsid5PPGHJrvcGCKG+DEQNU3+o4TNd4lg0aw8e
	 EhOu44jF/ROnZYZI3Qh8E+dJ3zpu1PIt8brFNHcuPucgfueDuG01vsBz419JPRbOJn
	 04lCSjauNBHpQ==
Date: Tue, 18 Jun 2024 12:15:44 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	"snitzer@hammerspace.com" <snitzer@hammerspace.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 00/18] nfs/nfsd: add support for localio
Message-ID: <ZnGysCb8rVpL6f7_@kernel.org>
References: <20240618010917.23385-1-snitzer@kernel.org>
 <ZnGYz8FdBrcF0CMj@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnGYz8FdBrcF0CMj@tissot.1015granger.net>

On Tue, Jun 18, 2024 at 10:25:19AM -0400, Chuck Lever wrote:
> On Mon, Jun 17, 2024 at 09:08:59PM -0400, Mike Snitzer wrote:
> > Hi,
> > 
> > This v4 fixes a few bugs in v3, reorders patches and improves patch
> > headers and code documentation. Please pay particular attention to
> > patches 17 and 18.
> > 
> > If all looks good to others, for v5 I can rebase to the -next trees
> > for nfs and nfsd.
> > 
> > My git tree is here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/
> > 
> > This v4 is both branch nfs-localio-for-6.11 (always tracks latest)
> > and nfs-localio-for-6.11.v4
> > 
> > nfs-localio-for-6.11.v3, nfs-localio-for-6.11.v2 and
> > nfs-localio-for-6.11.v1 are also there.
> > 
> > To see the changes from v3 to v4 please do:
> > git remote add snitzer git://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git
> > git remote update snitzer
> > git diff snitzer/nfs-localio-for-6.11.v3 snitzer/nfs-localio-for-6.11.v4
> > 
> > These changes have proven stable against various test scenarios:
> > 1) client and server both on localhost (for both v3 and v4.2)
> > 2) various permutations of client and server support enablement for
> >    both local and remote client and server.
> > 3) client on host, server within a container (for both v3 and v4.2)
> >    My container testing was in terms of podman managed containers.
> > 4) container stop/restart scenario documented in the last patch
> > 
> > All review and comments are welcome!
> 
> With my NFSD maintainer hat on: I'm concerned about some of the
> long-term maintenance work being added by this series. This is
> more of a concern on the client side, for sure, but, IMO:
> 
> In a perfect world, we would have an RFC for this, and the set
> would come with tests we can add to our release CI framework. I'm
> not holding you to all that, but I would like to see something to
> help me out in the long-run.

I understand.  Thankfully it is quite easy to test with client and
server running on the same host.

The container-based testing (e.g. running client on host, nfsd in
container) is a bit more fiddley/specialized to get setup due to the
nature of all things containers.

> Because this is not part of an Internet standard, this patch set
> needs to come with some architectural documentation like something
> under Documentation/filesystems/nfs.
> 
> It needs to explain the use cases and why this design was chosen.
> It should have a specification for the LOCALIO protocol. It needs
> to explain how to test the facility being added -- basically we
> need to know how /not/ to break this thing as we develop around it.
> I'm also interested to know who, besides Hammerspace, can benefit
> from this facility.
> 
> (This isn't a hard objection, just a request for some help with
> the long-term maintenance burden).

Sure, I'll work on Documentation for v5. These changes help everyone
who might like to run client and server on the same system (and within
containers). That may not be interesting to a lot of people but it
isn't soooo niche.

As for maintenance burden: thankfully these changes are mostly
isolated from the bulk of the rest of the nfs and nfsd code.

The SRCU changes to nfsd less so, but they are largely mechaical and
straight-forward (when I ported to your latest nfsd-next last night,
there was a simple matter of needing to fixup naked nn->nfsd_serv
dereferences that were caught by the compiler due to dereferencing a
void pointer warnings).

Thanks,
Mike

