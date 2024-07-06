Return-Path: <linux-nfs+bounces-4669-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A448A92909F
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 05:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC761F2224C
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 03:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D40FBE8;
	Sat,  6 Jul 2024 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT3iTzKs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC54F9E4
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720238338; cv=none; b=nP1OFu6fvdl6bQDyPpnMCy02VAQPTg3ynfbXVHO6q34L5DSme0sNAdGaAEibHNUiAyxcPC4diohJh7DrMeIVrw6b0uFnkkUCmjPGzRWZKKaBNzdwv4bo9YKnlwaepP/B2E8CN0Q6ikfERMVMNrhWWzRQ+/2LPJTPb7Zoy471bpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720238338; c=relaxed/simple;
	bh=EwXzVhcPnQqK4+W1zYMC81N9YvgWKvtI+J62bSqDQ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UExZpP8pksWDM8ZTmz7QYRR7M/6xTZJ/IKwGfg4ujPMsHsXhnyTuLKMq+QIeXmC4Jg8zgkjnyIWiVgfYfFLsVZGvXJsahoDogiku1cK2K0zQkWo02sE36NYvqfMejjXuMwM8sxLCNeVxlv0KJNKlH0nRq808QtKEAmnH40dBiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT3iTzKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96774C2BD10;
	Sat,  6 Jul 2024 03:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720238337;
	bh=EwXzVhcPnQqK4+W1zYMC81N9YvgWKvtI+J62bSqDQ7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jT3iTzKsQB4l5rjoUcZq8Okd1zpZ12hTVt0Ie9Nf11ciBxRK52ST0ygFpZjHgJdla
	 lRKae0aLi1pvFW+07VscgEXWPJijfAhRTwFknai9CXjMRtwcte2Fmvx9hBmFnvs8MX
	 bYVDrLT4RXyExpR1z6ZveV02hIu+y/dAfB3ws6/jbiDWkQqx77awrcFALaI+dCq1+b
	 SgHqwaak9CiyhSJNdwb5A8IzK8ARqzvmHuldWrT5pfQOlaogopxNw5xq4PoU23gW0e
	 5WfT1m3zHCxB7PY7wsAkr5VlrDGva9xDhUL9VzujgtHy5iXg5+rH+B+oR9c3+nsCp1
	 Vy09HoFvMY9VA==
Date: Fri, 5 Jul 2024 23:58:56 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZojBAC3XYIee9wN2@kernel.org>
References: <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org>
 <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
 <ZogAEqYvJaYLVyKj@kernel.org>
 <ZogAtVfeqXv3jgAv@infradead.org>
 <ZogFBqv0z7Rnh4_p@kernel.org>
 <990C712E-99B0-4227-B67D-0DBAA2B2B72E@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <990C712E-99B0-4227-B67D-0DBAA2B2B72E@oracle.com>

On Fri, Jul 05, 2024 at 02:59:31PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 5, 2024, at 10:36 AM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > On Fri, Jul 05, 2024 at 07:18:29AM -0700, Christoph Hellwig wrote:
> >> On Fri, Jul 05, 2024 at 10:15:46AM -0400, Mike Snitzer wrote:
> >>> NFSv3 is needed because NFSv3 is used to initiate IO to NFSv3 knfsd on
> >>> the same host.
> >> 
> >> That doesn't really bring is any further.  Why is it required?
> >> 
> >> I think we'll just need to stop this discussion until we have reasonable
> >> documentation of the use cases and assumptions, because without that
> >> we'll get hund up in dead loops.
> > 
> > It _really_ isn't material to the core capability that localio provides.
> > localio supporting NFSv3 is beneficial for NFSv3 users (NFSv3 in
> > containers).
> > 
> > Hammerspace needs localio to work with NFSv3 to assist with its "data
> > movers" that run on the host (using nfs and nfsd).
> > 
> > Please just remove yourself from the conversation if you cannot make
> > sense of this.  If you'd like to be involved, put the work in to
> > understand the code and be professional.
> 
> Sorry, I can't make sense of this either, and I find the
> personal attack here completely inappropriate (and a bit
> hypocritical, to be honest).

Hi Chuck,

I'm out-gunned with this good-cop/bad-cop dynamic.  I was replying to
Christoph.  Who has taken to feign incapable of understanding localio
yet is perfectly OK with flexing like he is an authority on the topic.

He rallied to your Nacked-By with his chest puffed up and has
proceeded to baselessly shit-talk (did you miss his emails while we
slept last night?).  Yes, let's condone and encourage more of that!?
No, I won't abide such toxicity.  But thankfully Neil has since called
for him to stop.  Alas...

Earlier today I answered the question about "why NFSv3?" in simple
terms.  You and Christoph rejected it.  I'm _not_ being evassive.
There isn't a lot to it: "More efficient NFS in containers" _is_ the
answer.

But hopefully this email settles "why NFSv3?".  If not, please help me
(or others) further your understanding by reframing your NFSv3 concern
in terms other than "why NFSv3?".  Getting a bit like having to answer
"why is water wet?"

Why NFSv3?
----------

The localio feature improves IO performance when using NFSv3 and NFSv4
with containers.  Hammerspace has immediate need for the NFSv3
support, because its "data movers" use NFSv3, but NFSv4 support is
expected to be useful in the future.

Just because Hammerspace is very invested in pNFS doesn't mean all
aspects are framed in terms of it.

General statement:
------------------

I wrote maybe ~30% of the entire localio code as it stands at "v11"
and that was focused primarily on adding NFSv4 support and developing
the localio protocol, hooking it into NFS's client initialization and
teardown along with the server (and vice-versa, nfsd lifetime due to
container applications: tearing down nfsd in container while nfs
client actively connected from host).  Neil helped refine the localio
protocol part, and he has also looked critically at many aspects and
has a great list of improvements that are needed.  Jeff provided
top-notch review of my initial use of SRCU and later the percpu refcnt
for interlocking with the client and server.

My point: others wrote the majority of localio (years ago).  I'm just
trying to shepherd it upstream in an acceptable form.  And yes,
localio supporting both NFSv3 and NFSv4 is important to me,
Hammerspace and anyone who'd like more efficient IO with both NFSv3
and NFSv4 in containers.

Answering "Why NFSv3?" with questions:
--------------------------------------

1) Why wasn't general NFS localio bypass controversial 3 weeks ago?
Instead (given all inputs, NFSv3 support requirement being one of
them) the use of a "localio protocol" got broad consensus and buyin
from you, Jeff, and Neil.

I _thought_ we all agreed localio was a worthwhile _auxilliary_
addition to Linux's NFS client and server (to give them awareness of
each other through nfs_common) regardless of NFS protocol version.
That is why I registered a localio RPC program number with IANA (at
your suggestion, you were cc'd when I applied for it, and you are
named on IANA.org along with Trond and myself for the program number
IANA assigned):
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
come to understand from you and Christoph that the lack of flexfiles
support in NFSD helps fuel dislike for flexfiles.  That's a lot for me
to unpack, and pretty far removed from "why NFSv3?", so I'd need more
context than I have if Hammerspace's use of flexfiles is what is
fueling your challenge of localio's NFSv3 support.

...

Reiterating and then expanding on my email above:

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

I _hope_ I've now answered "why NFSv3?" clearly.

> I have nothing else to contribute that you won't either
> dismiss or treat as a personal attack, so I can't continue
> this conversation.

That isn't even a little bit fair... but not taking the bait.

Neil has been wonderful to work with and I look forward to all future
work with him (localio and beyond).  I am not trying to do anything
out of line with this feature.  I am and have been actively working 
with you, Neil and Jeff for over a month now.  I've adapted and
learned, _with_ your and others' help, to the best of my ability.

I'm trying here, maybe you could say "I'm trying too hard".  Well I
just started a new job with Hammerspace after working for Red Hat for
the past 15 years (much of my time spent as the upstream Linux DM
maintainer -- but you know this).  I am a capable engineer and I've
proposed the upstreaming of a localio feature that would do well to
land upstream.  I've done so in a proficient way all things
considered, always happy to learn new things and improve.  I need to
work with you.  Hopefully well, and hopefully I can earn your respect,
please just know I'm merely trying to improve NFS.

Hammerspace would like to get all its Linux kernel NFS innovation
upstream.  And I'm trying to do that.  localio is my first task and
I've been working on it with focus for the past 2 months since joining
Hammerspace.  But you basically know all this, I said all of it to you
at LSF.

So if you know all these things (I _know_ you do), why are you
treating me in this way?  I feel like I'm caught in the middle of some
much bigger divide than anything I've been involved with, caused or
made privy to.

Guess the messenger gets shot sometimes.

Mike

