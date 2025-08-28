Return-Path: <linux-nfs+bounces-13944-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3648CB3AA55
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 20:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA7AA00909
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 18:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F696278E41;
	Thu, 28 Aug 2025 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azwhoj1f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30C26B2A6
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407156; cv=none; b=SNAmHI8yNaeZVOH7YwI1mk0+nAHsKrAWpI9bStAlax0PbVG874lbF7YRvyPlXEYCrWg/gd6o7GYuan/4pg8mztYp3G0/egcvz+08SiBkfMUxA4XIi+udi5Ps/PlAxl8MVpfzM2qEmgrFVxhN6m0cDGfCPHfl39MaTJ1yBp4HJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407156; c=relaxed/simple;
	bh=yrlGmVr+cDXuc/cWnJ/KjnnuXrkT+ydo7EMWlLr6LEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUe5axAXoU6sRICr+Zf6PsV3jFgNM3wePpHfttLQF650TjAPhSK7pzE7c6ExwhYyfOavkUDya/f8wuudKhj7dIZ4a0idwSDImtHY4HnRwt2L4TxFOSSsq8LxWK6V0dUn2XpHgNGJlRciIu+yvzTOkbP8dpF8NxXGpSNom8fLmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azwhoj1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366A5C4CEED;
	Thu, 28 Aug 2025 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756407155;
	bh=yrlGmVr+cDXuc/cWnJ/KjnnuXrkT+ydo7EMWlLr6LEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azwhoj1fQR8cS5Sd1Q/zlkfD5V6bNm+dcLnpFC8wkx7FTqBpnowTAyQ8ziW47oKPd
	 w3JDEnq8LrRZ1oyPn2sP/wIBEZun8hjqwaCchBS+IQYPQdOyFogjm99UNF6MevXhPj
	 55bFvLuKHo19YqkhKWZgrgwMHBMjEPytwNUJ3kc19EZoKQ0OImTTatWlcijv5feFIe
	 3C/AjgyRw0TsAncaDgl/sW8qJNAQjNNfjKl+6QwpVe49+Jqp/xoWoxEHLU9steCB82
	 uk27BgE0ylXkVkIsdybY9KDYFyKmPO/XHQ5CcPbSObhpi6HofATKyVM0P7NuvWDRUK
	 43vXr2XojmENw==
Date: Thu, 28 Aug 2025 14:52:34 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 5/7] NFSD: issue READs using O_DIRECT even if IO is
 misaligned
Message-ID: <aLClcl08x4JJ1UJu@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
 <20250826185718.5593-6-snitzer@kernel.org>
 <f7aee927-e4fc-44da-a2b6-7fd90f90d90e@oracle.com>
 <aK9fZR7pQxrosEfW@kernel.org>
 <6f5516a5-1954-4f77-8a07-dacba1fb570c@oracle.com>
 <aK-Reg6g8ccscwMu@kernel.org>
 <09eca412-b6e3-4011-b7dd-3a452eae6489@oracle.com>
 <aLAOsGUIvONZvfX7@kernel.org>
 <ba414445-a31b-4f37-9520-94a0fbbbba55@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba414445-a31b-4f37-9520-94a0fbbbba55@oracle.com>

On Thu, Aug 28, 2025 at 10:53:49AM -0400, Chuck Lever wrote:
> On 8/28/25 4:09 AM, Mike Snitzer wrote:
> > On Wed, Aug 27, 2025 at 09:57:39PM -0400, Chuck Lever wrote:
> >> On 8/27/25 7:15 PM, Mike Snitzer wrote:
> >>> On Wed, Aug 27, 2025 at 04:56:08PM -0400, Chuck Lever wrote:
> >>>> On 8/27/25 3:41 PM, Mike Snitzer wrote:
> >>>>> Is your suggestion to, rather than allocate a disjoint single page,
> >>>>> borrow the extra page from the end of rq_pages? Just map it into the
> >>>>> bvec instead of my extra page?
> >>>>
> >>>> Yes, the extra page needs to come from rq_pages. But I don't see why it
> >>>> should come from the /end/ of rq_pages.
> >>>>
> >>>> - Extend the start of the byte range back to make it align with the
> >>>>   file's DIO alignment constraint
> >>>>
> >>>> - Extend the end of the byte range forward to make it align with the
> >>>>   file's DIO alignment constraint
> >>>
> >>> nfsd_analyze_read_dio() does that (start_extra and end_extra).
> >>>
> >>>> - Fill in the sink buffer's bvec using pages from rq_pages, as usual
> >>>>
> >>>> - When the I/O is complete, adjust the offset in the first bvec entry
> >>>>   forward by setting a non-zero page offset, and adjust the returned
> >>>>   count downward to match the requested byte count from the client
> >>>
> >>> Tried it long ago, such bvec manipulation only works when not using
> >>> RDMA.  When the memory is remote, twiddling a local bvec isn't going
> >>> to ensure the correct pages have the correct data upon return to the
> >>> client.
> >>>
> >>> RDMA is why the pages must be used in-place, and RDMA is also why
> >>> the extra page needed by this patch (for use as throwaway front-pad
> >>> for expanded misaligned DIO READ) must either be allocated _or_
> >>> hopefully it can be from rq_pages (after the end of the client
> >>> requested READ payload).
> >>>
> >>> Or am I wrong and simply need to keep learning about NFSD's IO path?
> >>
> >> You're wrong, not to put a fine point on it.
> > 
> > You didn't even understand me.. but firmly believe I'm wrong?
> > 
> >> There's nothing I can think of in the RDMA or RPC/RDMA protocols that
> >> mandates that the first page offset must always be zero. Moving data
> >> at one address on the server to an entirely different address and
> >> alignment on the client is exactly what RDMA is supposed to do.
> >>
> >> It sounds like an implementation omission because the server's upper
> >> layers have never needed it before now. If TCP already handles it, I'm
> >> guessing it's going to be straightforward to fix.
> > 
> > I never said that first page offset must be zero.  I said that I
> > already did what you suggested and it didn't work with RDMA.  This is
> > recall of too many months ago now, but: the client will see the
> > correct READ payload _except_ IIRC it is offset by whatever front-pad
> > was added to expand the misaligned DIO; no matter whether
> > rqstp->rq_bvec updated when IO completes.
> > 
> > But I'll revisit it again.
> 
> For the record, this email thread is the very first time I've heard that
> you tried the simple approach and that it worked with TCP and not with
> RDMA. I wish I had known that a while ago.

Likewise, but the story is all in the patch header and the code tells
the story too. Hence your finding it with closer review (thanks for
that BTW!). I agree something is off so I'm happy to work it further.

I have iterated on quite a few aspects to this patch 5. Christoph had
suggestion for using memmove in nfsd_complete_misaligned_read_dio.
You had the feedback that required ensuring the lightest touch
relative to branching so that buffered IO mode remain as fast as
possible.

Looking forward to tackling this RDMA-specific weirdness now.

> >>>>> NFSD using DIO is optional. I thought the point was to get it as an
> >>>>> available option so that _others_ could experiment and help categorize
> >>>>> the benefits/pitfalls further?
> >>>>
> >>>> Yes, that is the point. But such experiments lose value if there is no
> >>>> data collection plan to go with them.
> >>>
> >>> Each user runs something they care about performing well and they
> >>> measure the result.
> >>
> >> That assumes the user will continue to use the debug interfaces, and
> >> the particular implementation you've proposed, for the rest of time.
> >> And that's not my plan at all.
> >>
> >> If we, in the community, cannot reproduce that result, or cannot
> >> understand what has been measured, or the measurement misses part or
> >> most of the picture, of what value is that for us to decide whether and
> >> how to proceed with promoting the mechanism from debug feature to
> >> something with a long-term support lifetime and a documented ABI-stable
> >> user interface?
> > 
> > I'll work to put a finer point on how to reproduce and enumerate the
> > things to look for (representative flamegraphs showing the issue,
> > which I already did at last Bakeathon).

note ^ (referenced below)

> > But I have repeatedly offered that the pathological worst case is
> > client doing sequential write IO of a file that is 3-4x larger than
> > the NFS server's system memory.
> > 
> > Large memory systems with 8 or more NVMe devices, fast networks that
> > allow for huge data ingest capabilities.  These are the platforms that
> > showcase MM's dirty writeback limitions when large sequential IO is
> > initiated from the NFS client and its able to overrun the NFS server.
> > 
> > In addition, in general DIO requires significantly less memory and
> > CPU; so platforms that have more limited resources (and may have
> > historically struggled) could have a new lease on life if they switch
> > NFSD from buffered to DIO mode.
> > 
> >>> Literally the same thing as has been done for anything in Linux since
> >>> it all started.  Nothing unicorn or bespoke here.
> >>
> >> So let me ask this another way: What do we need users to measure to give
> >> us good quality information about the page cache behavior and system
> >> thrashing behavior you reported?
> > 
> > IO throughput, CPU and memory usage should be monitored over time.
> 
> My point is users need a recipe for what to monitor, ie clear specific
> instructions, and that recipe needs to be applied the same way by every
> experimenter (because, as I say below, we too are collecting data about
> the user's experience with this feature).
> 
> Can you provide a few specific instructions that experimenters can
> follow on how to monitor and report these metrics? Simply copy-paste
> what you and your test team have been using to observe system behavior.

Yes, I understood and understand. I did commit to preparing and
providing what is needed (see "note ^" above). Not a problem.

I will be working with Hammerspace QA and other engineers as needed to
produce as tight a reproducer as possible.

> >> For example: I can enable direct I/O on NFSD, but my workload is mostly
> >> one or two clients doing kernel builds. The latency of NFS READs goes
> >> up, but since a kernel build is not I/O bound and the client page caches
> >> hide most of the increase, there is very little to show a measured
> >> change.
> >>
> >> So how should I assess and report the impact of NFSD doing direct I/O?
> > 
> > Your underwhelming usage isn't what this patchset is meant to help.
> 
> Again, my point is, how are users who try the debug option going to
> know that their workload is or is not of interest? We're not
> providing such documentation. Users are just going to turn this on and
> try it.
> 
> But consider that one of our options is to make direct I/O the default.
> We need to know how smaller workloads might be impacted by this new
> default. The maintainers are part of this experiment as much as
> potential users are. We need to collect data to understand how to make
> this work part of the first world administrative API.

I'm not opposed to anyone trying any workload.  You're really wanting
to impose a structure and guidance, and I think that is a noble goal
and will serve us well toward avoiding a myriad of issues.  If nothing
else it should help others understand the benefits/pitfalls.

To that end I'm happy to work on adding proper Documentation/

> >> See -- users are not the only ones who are involved in this experiment;
> >> and they will need guidance because we're not providing any
> >> documentation for this feature.
> > 
> > Users are not created equal.  Major companies like Oracle and Meta
> > _should_ be aware of NFSD's problems with buffered IO.  They have
> > internal and external stakeholders that are power users.
> > 
> > Jeff, does Meta ever see NFSD struggle to consistently use NVMe
> > devices?  Lumpy performance?  Full-blown IO stalls?  Lots of NFSD
> > threads hung in D state?
> 
> I have no idea why you think I don't understand those facts, but you are
> still missing my point. NFSD maintainers are part of this experimental
> set up as much as users are. We need good information to decide how to
> shape this feature going forward. Let's build a plan to get that
> information.

If you understand, which I have no doubt, then your repeat basic
questions were simply trying to impress upon me the info others
need. You need it too, but more to help mobilize and manage others'
time and to help build a program around this feature. I mean, that's
my understanding now. It makes sense.

> >>>> If you would rather make this drive-by, then you'll have to realize
> >>>> that you are requesting more than simple review from us. You'll have
> >>>> to be content with the pace at which us overloaded maintainers can get
> >>>> to the work.
> >>>
> >>> I think I just experienced the mailing-list equivalent of the Detroit
> >>> definition of "drive-by".  Good/bad news: you're a terrible shot.
> >>
> >> The term "drive-by contribution" has a well-understood meaning in the
> >> kernel community. If you are unfamiliar with it, I invite you to review
> >> the mailing list archives. As always, no-one is shooting at you. If
> >> anything, the drive-by contribution is aimed at me.
> > 
> > It is a blatant miscategorization here. That you just doubled down
> > on it having relevance in this instance is flagrantly wrong.
> 
> First of all, "drive-by contribution" is not meant to be pejorative.
> It is what it is: someone throws you a patch and then goes away. It is
> a fact of life for open source maintainers.

Please know I know what "drive-by contribution" is.  It isn't
applicable here.  That I need to say that repeatedly is strange.
I haven't gone anywhere and won't be.

I have worked _hard_ on both NFSD DIRECT and NFS DIRECT. More work is
needed on both.

BREAKING NEWS:  NFSD DIRECT is my top priority, I just received
approval from Hammerspace management for it to be my continued primary
focus.

> I'm simply trying to get a sense of your commitment to finishing this
> work and staying with it going forward. You keep telling me "well I have
> other things to do." What do you think that indicates to a busy
> maintainer? That you will be around to finish the feature? Or rather
> that your employer is going to yank you onto other projects, leaving us
> stuck with the work of finishing it?

You have my full attention and I will put my focus on:
1) closing the initial code out strong so you and Jeff are happy to merge
2) pushing forward wherever community feedback and desire takes us in
   the future.

I have a deep sense of drive and commitment and this line of
development is important to me (and Hammerspace!).

> You have rejected one or more reasonable review comments and maintainer
> requests. That doesn't convince me you are willing to collaborate with
> us on maintaining the feature.

I am really not fighting/spitting at all in what follows until the end
of this email, I'm trying to preserve what little reputation I have
left, say my peace _but_ arrest any further strife for us both.

I think if you were to review _all_ the exchanges relative to this
NFSD DIRECT work (v1 through v8 patchset postings and associated
review and my responses to it all) you'd find I have been nothing but
driven to understand and then address all feedback and move the code
forward as rapidly as possible.

It has been collaborative and rewarding, and I appreciate everyone who
has helped move this work forward.

Then the wheels fell off yesterday and now some revisionist history is
creeping in, we cannot have that.  Distracts everyone and takes away
from all the good work we've done.

We are both intense. My intensity will be spent on worthwhile efforts,
not fighting needlessly.

> My biggest concern here is how much more work maintaining NFSD will be
> once this change goes in. It's a major feature and a significant change.
> It will require a lot of code massage in the short- and medium-term,
> just as a start.
> 
> Maybe I'm assuming that you, as a kernel maintainer yourself, already
> understand that this mind set and this calculus is part of my email replies.

It is nice that you acknowledge I am also a Linux subsystem maintainer
(but thankfully Mikulas is able to do the heavy lifting for DM now).
Yes, I know very well all the variables and concerns that must be
considered and this NFSD DIRECT line of work is just one of many
efforts for you.

> So, I'm being frank. I'm not trying to offend or belittle.

You can be frank without zooming out 50K feet and making general
attacks on my work, character or aptitude/understanding.

Those attacks happened in response to my asking for help, short of
that I asked if patch 5 could be merged with future work item(s)
attached.

From https://lore.kernel.org/linux-nfs/aK9fZR7pQxrosEfW@kernel.org/
"All said, this patchset is very important to me, I don't want it to
miss v6.18 -- I'm still "in it to win it" but it feels like I do need
your or others' help to pull this off.

And/or is it possible to accept this initial implementation with
mutual understanding that we must revisit your concern about my
allocating an extra page for the misaligned DIO READ path?"

I didn't say those things as some power move to push for NFSD DIRECT
going in before "ready". But this is the second time you have reacted
very hostile in response to merge readiness (first LOCALIO and now
this) and that makes it a pattern. One that I have no interest in
seeing repeat...

To that end, I will refrain from raising questions about when code
might be merged or planning around it. I'll maintain focus on doing
the work asked for and let the rest sort itself out.

My Genuine apologies that I hit a nerve yesterday. It wasn't intended,
but I now "get it": in particular I can infer you took my "I cannot be
a one man show on all this. I welcome more help from anyone
interested." as me being a hostile contributor. I _had_ competing work
and didn't account for NFSD DIRECT needing quite so much immediate
work, so I shared how exposed I was (albeit without enough care and
context). I certainly didn't intend to minimize yours and others'
helpful review feedback, etc. I regret putting that email's closing
statement like I did.

> > Whatever compells you to belittle me and my contributions, just know
> > it is extremely hard to take. Highly unproductive and unprofessional.
>
> I can't control how you understand my emails. If you choose to be
> offended even though I'm trying to have an honest discussion, there's
> nothing I can do about it.
> 
> I can't control /if/ you understand my emails. I'm repeating myself
> quite a bit here because a lot of what I say sails past you. You read
> things into what I say that I don't intend, and you miss a lot of what
> I did intend. There's nothing I can do about that either.

But you are consciously putting to words judgments that would cut any
software engineer to their core.

Stands to reason that some ownership of your condescending and
belittling remarks is needed if you would like to avoid negative
reactions.

If you aren't even aware you are saying things that land in those
buckets... anyway, not my place to say more.

> I can't control your unproductive and unprofessional behavior. You keep
> rejecting valid review comments and maintainer requests with comments
> like "I don't feel like it" and "your reason for wanting this change is
> invalid" and "you are wasting my time". Again, this suggests to me that
> maintaining this feature will be a lot more work than it could be, and
> that is an ongoing concern.

All of what you said in this ^ above section is carry-over from when
LOCALIO was approaching "ready".  I thought we buried those hatchets
and "are good" but clearly what they say about first impressions is
undeniable -- I had one chance and I left a bad one with you, all I
can do is rectify it with my future actions.

Fact is, none of your old judgments/findings from LOCALIO are
actually applicable for this NFSD DIRECT case. That you brought them
forward as if they are applicable now genuinely saddens me.

The one thing Jeff asked for, that we all agree would be better, is
that if the debugfs interface used string-based controls rather than
integer.  That is quite a lift given it requires engaging gregkh and
others, one that I don't feel I can pull off given other work items
(especially so now with things covered as required above). But I
didn't reject the good idea; I looked into it and found debugfs
doesn't support strings, adding that capability cannot be a priority
if it comes with an opportunity cost of getting NFSD DIRECT polished
(bit of a catch-22 but alas). Not sure if that leaves you wanting, you
may think the incremental debugfs improvement basic but it is a
context switch I cannot afford to take. Jeff is now OK with the
debugfs interfaces as-is, hopefully they're tolerable for you too.

> If there's something that offends you, the professional response on your
> part is to point that out to me in the moment rather than trying to spit
> back. Because most likely, I wasn't intending to offend at all. If you
> keep that in mind while reading my emails, you might have an easier time
> of it.

OK. This was all unfortunate, _but_ I appreciate you taking the time
to work through it with me and provide your insights.

Hopefully we have a lasting understanding now and we can get back to
what we do best.

Mike

ps. sorry for the noise linux-nfs!

