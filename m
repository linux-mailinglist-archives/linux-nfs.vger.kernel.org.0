Return-Path: <linux-nfs+bounces-4680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287FB9293AE
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 15:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D0B1F21B86
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 13:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6F58ABF;
	Sat,  6 Jul 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz/NUgJ0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE864C79
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720271145; cv=none; b=J1zLJ/aFVFQ8o4oaw+HvJZNcliFJCE7TZWO/IlkzxSzekx2XkNJPm8sVVB/PTTW8IR+VfmnY+/YtukKtOKfbtKAPgsjU3rJ9n/jOKK+objYHNJwkO3YEBgKQ1AFq6zkooKv9KsWneFLfqIet7L2RbBov26bcGsz/1gQW2pkrKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720271145; c=relaxed/simple;
	bh=jxTqqQfelaFEp//b6PFy66W1k4oZLgc27rO4+MCEFBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1uszY4A2Nq7GDZcJXwq/7GozgdLXXltHuHXZ6stokePtQD/M8bqJh8eKPso1sBOv763gKF0Wsb278r1tmjdJZt9zdbZu2FX9LyIsQqMxY0WRDp1r1na+BC8u4SeEhKRZZ50Y+UU6oTX/7imKUBKCZIOSJBZlwHCzcFqb9p18CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz/NUgJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A76FC2BD10;
	Sat,  6 Jul 2024 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720271145;
	bh=jxTqqQfelaFEp//b6PFy66W1k4oZLgc27rO4+MCEFBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dz/NUgJ0zb2phrCXzOyQpTK/T/pK34wqCwHSqM141VHd8sZHRNxZ0VqsHAfVcLc/E
	 hk7G83Io3SGgTW/ub5PxfxA92piXs6x07p3WBj5OjrL6eQY/XKeyocYVhQ/EU0aFJM
	 vHFP1ZZwkeiDeW1fbRc+iDxMbfOm3G/4cEQGWz7tUiRYl9tt5zU5TqnM30Fs6pcTas
	 zHvJN3nYFAqtCQh6NbGHyVMZMxzBcEwmMLfHKHXsXY1J38HqpwQ7LaHhH+6BiT11mX
	 GVSNJtzGkapT1tKS3zgwSrjiUOXCj5WNiTl1dbYLUCXmb42RmdKxCCM5cios7jlwXY
	 roSVgjf8eXttA==
Date: Sat, 6 Jul 2024 09:05:44 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Dave Chinner <david@fromorbit.com>
Subject: "why NFSv3?" [was: Re: [PATCH v11 00/20] nfs/nfsd: add support for
 localio]
Message-ID: <ZolBKK4O2gA-MiFJ@kernel.org>
References: <>
 <ZojBAC3XYIee9wN2@kernel.org>
 <172024512210.11489.13288458153195942042@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172024512210.11489.13288458153195942042@noble.neil.brown.name>

Earlier yesterday I answered the question about "why NFSv3?" in simple
terms.  Chuck and Christoph rejected it.  I'm _not_ being evassive.
There isn't a lot to it: "More efficient NFS in containers" _is_ the
answer.

But hopefully this email settles "why NFSv3?".  If not, please help me
(or others) further your understanding by reframing your NFSv3 concern
in terms other than "why NFSv3?".

Why NFSv3?
----------

The localio feature improves IO performance when using NFSv3 and NFSv4
with containers.  Hammerspace has immediate need for the NFSv3
support, because its "data movers" use NFSv3, but NFSv4 support is
expected to be useful in the future.

Why not use pNFS?
-----------------

Just because Hammerspace is very invested in pNFS doesn't mean all
aspects are framed in terms of it.

The complexity of a pNFS-based approach to addressing localio makes it
inferior to the proposed solution of an autonomous NFS client and
server rendezvous to allow for network bypass.  There is no need for
pNFS and by not using pNFS the localio feature is accessible for
general NFSv3 and NFSv4 use.

Answering "Why NFSv3?" with questions:
--------------------------------------

1) Why wasn't general NFS localio bypass controversial 3 weeks ago?
Instead (given all inputs, NFSv3 support requirement being one of
them) the use of a "localio protocol" got broad consensus and buyin
from Chuck, Jeff, and Neil.

I _thought_ we all agreed localio was a worthwhile _auxilliary_
addition to Linux's NFS client and server (to give them awareness of
each other through nfs_common) regardless of NFS protocol version.
That is why I registered a localio RPC program number with IANA, at
Chuck's suggestion, see:
https://www.iana.org/assignments/rpc-program-numbers/rpc-program-numbers.txt

$ cat rpc-program-numbers.txt | egrep 'Snitzer|Myklebust|Lever'
   Linux Kernel Organization                  400122         nfslocalio                   [Mike_Snitzer][Trond_Myklebust][Chuck_Lever]
   [Chuck_Lever]           Chuck Lever           mailto:chuck.lever&oracle.com  2024-06-20
   [Mike_Snitzer]          Mike Snitzer          mailto:snitzer&kernel.org      2024-06-20
   [Trond_Myklebust]       Trond Myklebust       mailto:trondmy&hammerspace.com 2024-06-20

2) If we're introducing a general NFS localio bypass feature _and_
NFSv3 is important to the stakeholder proposing the feature _and_
NFSv3 support is easily implemented and supported: then why do you
have such concern about localio supporting NFSv3?

3) Why do you think NFSv3 unworthy?  Is this just a bellweather for
broader opposition to flexfiles (and its encouraging more use of
NFSv3)?  Flexfiles is at the heart of NFSv3 use at Hammerspace.  I've
come to understand from Chuck and Christoph that the lack of flexfiles
support in NFSD helps fuel dislike for flexfiles.  That's a lot for me
to unpack, and pretty far removed from "why NFSv3?", so I'd need more
context than I have if Hammerspace's use of flexfiles is what is
fueling your challenge of localio's NFSv3 support.

...

Reiterating and then expanding on my earlier succinct answer:

  localio supporting NFSv3 is beneficial for NFSv3 users (NFSv3 in
  containers).

  Hammerspace needs localio to work with NFSv3 to assist with its
  "data movers" that run on the host (using nfs [on host] and nfsd
  [within container]).

Now you can ask why _that_ is.. but it really is pretty disjoint from
the simple matter of ensuring localio support both NFSv3 and NFSv4.

I've shared that Hammerspace's "data movers" use NFSv3 currently, in
the future they could use NFSv4 as needed.  Hence the desire to
support localio with both NFSv3 and NFSv4.  [when I picked up the
localio code NFSv4 wasn't even supported yet].

