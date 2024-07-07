Return-Path: <linux-nfs+bounces-4690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD85B929634
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 02:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB01C2040D
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 00:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35277EDC;
	Sun,  7 Jul 2024 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhVwior+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA71A55
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jul 2024 00:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312968; cv=none; b=WbmR8tPlqPG8q3qcDs6HQpJ7VNMh1q+35/i0x7JRQh5V7kAGb7k9cB+UURShI+wjL2P5cLAUkaLhUUFbh71qLZfG7S/HRNd9N9F7lygTF3URP4SbVj8NrQXaeCXcmLgg3zqxlrxXRucKbA7BmrQWTrwa2KREzn2lsRvYIsYOyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312968; c=relaxed/simple;
	bh=eQxvqdrV49NCX8kvv8x0GuP85KL9WRdU7fvwWbvZq78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZGDHGDae9+IqkX+ZOM4OXMj4XecVUWQ+8OyGGRgDRXWBUJgk29XVfTJBCcztGJxbxcb5pZYucyfhw9Idl/5yIwnd8kONXS/bjC7g4C3nlvoJ0eL0x6S7ji+ffh7jaAzY7SX19x5Wx0ey8LIIBgOdcUeTOtjKypdhBcmtqV1uis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhVwior+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44610C2BD10;
	Sun,  7 Jul 2024 00:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720312967;
	bh=eQxvqdrV49NCX8kvv8x0GuP85KL9WRdU7fvwWbvZq78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhVwior+4zrxko/zaynWICYj0T+Zm/T18Gr5ysStSM9ZVKLh7I+e2GamBcnjlXCWf
	 ka1F2EAqBXS46PgOoSuBytlpL7nVRDvNaC0Uqu2WLEsyLb6cuWnuka03CDTkf52aAE
	 0ENkdTst2L56LqgkawA1VOawTX06tC1nic6JBFTswa15owKqu1Uxhj16YmnarqZ7AO
	 95YcYmnm+JnwxCiERzjp6CZJTg/i5BYzcRrOPzLN1zkroRco3gdY28/AsBJfl9bxD9
	 DH2OL1K/z7y8dqty2UYkFsNpMvLKrBCWGOXVJkjBVelMe7eZwOILYf769431yPru4B
	 M1YRZPNbPxJRw==
Date: Sat, 6 Jul 2024 20:42:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <Zonkhsx6M_y03lfL@kernel.org>
References: <ZoY6e-BmRJFLkziG@infradead.org>
 <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
 <ZogAEqYvJaYLVyKj@kernel.org>
 <ZogAtVfeqXv3jgAv@infradead.org>
 <ZogFBqv0z7Rnh4_p@kernel.org>
 <990C712E-99B0-4227-B67D-0DBAA2B2B72E@oracle.com>
 <ZojBAC3XYIee9wN2@kernel.org>
 <0BF11705-597B-404F-88F9-D4BCB7AC9937@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0BF11705-597B-404F-88F9-D4BCB7AC9937@oracle.com>

Chuck,

I think we can both agree there is no real benefit to us trading
punches and looking like fools more than we already have.

I say that not to impugn you or your position, but we look foolish.

I will pull my punches entirely (I really am, I could blow up
everything and that'll really be career limiting, heh).  My aim is to
say my peace in this reply and hopefully we can set this unfortunate
exchange to one side. 

I'll learn what I can from it, maybe you will, maybe others will...

On Sat, Jul 06, 2024 at 04:58:50PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 5, 2024, at 11:58 PM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > 
> > Hi Chuck,
> > 
> > I'm out-gunned with this good-cop/bad-cop dynamic.  I was replying to
> > Christoph.  Who has taken to feign incapable of understanding localio
> > yet is perfectly OK with flexing like he is an authority on the topic.
> 
> Well let's try a reality test.

Perception is reality, so your reality is different than mine.

Neil, Christoph and yourself all took my last "Who has taken to feign"
sentence above as some ad-hominem attack.  It wasn't, Christoph was
acting like the localio code incomprehensible for effect.
 
> Christoph has authored an IETF RFC on pNFS. He's also contributed
> the pNFS SCSI (and now NVMe) implementation in the Linux server
> and client. He seems to know the code well enough to offer an
> informed opinion.

I am _not_ questioning (and _never_ have questioned) Christoph's
extensive contributions, experience or intelligence.

I am calling out that Christoph didn't actually review the localio
code but proceeded to make extreme baseless negative judgments of it.

And you've glossed over that entirely and made it about "Christoph is
Christoph, who are you again?". Well aware who he is but I'm saying
baseless negative judgments are also a very regular occurrence from
him when he decides he just wants to blow up what I am doing (could be
he has done this to others, I have no idea).  It isn't about the
technical details in the moment he does this, if he says it it must be
true, the aim is taint my work.  Sad because I thought that dynamic
died when I finally relented in our feud over NVMe vs DM multipath
that spanned 2018 to 2021)

But damnit, it is happening all over again, now in the context of
localio. And you're buying it because he is parroting your concerns
about "why can't pNFS be used instead!?"

Neil won't get an answer after having called Christoph out on this
(unless Christoph now wants to try to make a liar out of me by
fabricating something well after his moment to do so has passed):
https://marc.info/?l=linux-nfs&m=172021727813076&w=2

If Christoph could arrest his propensity to do harm where it not
warranted I'd take every single technical critical feedback very
seriously and adjust the code as needed.  When it is about the code,
_actually_ about the code.. Christoph rules.

He knows this, happy to say it (again): I respect his technical
ability, etc.  I do _not_ respect him making blanket statements about 
code without saying _why_ he arrived at his judgment.

<snip many words from me answering "why NFSv3?">

> > Hammerspace would like to get all its Linux kernel NFS innovation
> > upstream.  And I'm trying to do that.  localio is my first task and
> > I've been working on it with focus for the past 2 months since joining
> > Hammerspace.  But you basically know all this, I said all of it to you
> > at LSF.
> > 
> > So if you know all these things (I _know_ you do), why are you
> > treating me in this way?  I feel like I'm caught in the middle of some
> > much bigger divide than anything I've been involved with, caused or
> > made privy to.
> 
> Yes, NFS is larger (much larger) and much older than the
> Linux implementation of it. I'm sorry your new colleagues
> have not seen fit to help you fit yourself into this
> picture.

See a non-sequitur that takes shots at Hammerspace isn't professional.

Over the numerous iterations of localio there have been a handful of
times you have taken to name drop "Hammerspace" with a negative
connotation, simmering with contempt.  Like I and others should feel
shame by association.

They haven't done anything wrong here.  Trond hasn't done anything
wrong here.  Whatever you grievance with Hammerspace, when interacting
with me please know I don't have any context for it.  It is immaterial
to me and I don't need to know.  If/when you have individual technical
problems with something Hammerspace is doing let's just work it
through without it needing to be this awkward elephant.

> > Guess the messenger gets shot sometimes.
> 
> This is exactly the problem: your attitude of victimhood.

Statements like that show you're going out of your way to make an
enemy of me with no _real_ basis.  But let me be clear: I have
absolutely been a victim of bullying and serious psychological attacks
over this past week, particularly repeat gaslighting by both you and
Christoph.  That you're so unaware of how you have spun a false
narrative and are now tag-teaming with Christoph to attack me further
has been apparent for all to see. Hopefully linux-nfs is low traffic ;)

You have obviously formed an unfavorable opinion of me, apparent
turning point was my v11 patch header and ensuing negative exchange. I
own being too pushy when seeking progress on localio v11's inclusion
for 6.11; I apologized for that.

Hopefully we can actually get past all of this.

> You act like our questions are personal attacks on you.

No, I act like your personal attacks are personal attacks.  Questions
and technical issues are always fair game.  I pushed back on _one_
of your NFSD requirements (tracepoints), sorry if that was some
indication that I'm a malcontent.. but I'm not.  I can have a
technical opinion though.  SO I may make them known at times.

> Answering "I don't know" or "I need to think about it" or
> "Let me ask someone" or "Can you explain that further" is
> perfectly fine. Acknowledging the areas where you need to
> learn more is a quintessential part of being a professional
> software engineer.

I'm not afraid to admit when I don't know something (I've said it to
you when we met at LSF).  I'm in no way an expert in NFS, you are.  I
respect your command of NFS and welcome learning from you (like I have
to this point and hope to in the future).

> ---
> 
> I have no strong feelings one way or another about flexfiles.
> 
> And, I remain a full-throated advocate of the NFSv3 support
> in the Linux NFS stack.
> 
> If you get an impression from me, come talk to me first
> to confirm it. Don't go talk to your colleagues; in
> particular don't talk to the ones who like to spread a lot
> of weird ideas about me. You're getting bad information.

I haven't ever heard from anyone at Hammerspace about you.  And I
haven't sought insight about you either.  AFAIK you aren't on anyone's
mind within Hammerspace (other than me given I'm actively dealing with
this unfortunate situation). 

> ---
> 
> Our question isn't "Why NFSv3?" It's: Can your design
> document explain in detail how the one existing application
> (the data mover) will use and benefit from loopback
> acceleration? It needs to explain why the data mover
> does not use possibly more suitable solutions like
> NFSv4.2 COPY. Why are we going to the effort of adding
> this side car instead of using facilities that are
> already available?
> 
> We're not asking for a one sentence email. A one sentence
> email is not "a response in simple terms". It is a petulant
> dismissal of our request for more info.

Well I in no way intended it to be petulant.  I was trying to reduce
the attack surface.  And if you'd trust me at my word that'd go a long
way.

Try to take a step back and trust me when I tell you something.
You're welcome to unfulfilled by an answer and seek clarity, but I
promise you I'm not evasive or leaving information on the floor when
I answer questions.  If I don't know something I seek the details out.

But you and Christoph are making a simple line of development
(localio) into some referendum on design choices in layers you have no
charter to concern yourself with (Hammerspace's data movers). You
still cannot accept that localio is devoid of pNFS use case
requirements (as required by Hammerspace) but still see fit to
reengineer the feature in terms of pNFS.

Hammerspace simply wants to optimize an NFS client on a host
connecting to an NFSD running in a container on the same host.  It is
doing that in service to its distributed namespace that it is hosting
in disparate NFSD instances.  But the "data movers" are a sideband
remapping/reshaping/rebalancing service.  Completely disjoint from the
distribute pNFS namespace that the primary (flexfiles) clients are
accessing.

> We're asking for a real problem statement and use case,
> in detail, in the design document, not in email.
> 
> (Go read the requests in this thread again. Honest, that's
> all we're asking for).

I'll consult with Trond to try to see how he suggests appeasing your
request more than I already have.  But you really are departing
heavily from the narrow scope that localio covers.

> ---
> 
> But finally: We've asked repeatedly for very typical
> changes and answers, and though sometimes we're met
> with a positive response, other times we get a defensive
> response, or "I don't feel like it" or "that's busy work"
> or "you're wasting my time." That doesn't sound like the
> spirit of co-operation that I would like to see from a
> regular contributor, nor do I expect it from someone who
> is also a Linux kernel maintainer who really ought to
> know better.

Projecting attributes and actions onto me doesn't make them true. I
haven't done or said most of the things you just asserted there.

I pushed back on tracepoints, but in the end I removed all the
dprintk()s from the NFSD code.

> So heed Christoph's excellent advice: go eat a Snickers.
> Calm down. Breathe. None of the rest of us are anywhere
> near as upset about this as you are right now.

Your words say otherwise, they have become quite negatively charged to
harm in the last week, but please let's just move on.  I'm serious, no
lasting harm done from my vantage point, I can move on if you can.

Thanks,
Mike

