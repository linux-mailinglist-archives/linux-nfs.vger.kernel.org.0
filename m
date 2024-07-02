Return-Path: <linux-nfs+bounces-4564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA3924751
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 20:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D5B1F25DF6
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F2D1BB692;
	Tue,  2 Jul 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dbd5Yr0c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAFF15B0FE
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945145; cv=none; b=ljeRLQArk7Dc4r+2+IK5Q8DciSlCQHlvMVhTUEhjKFXOGycAnnOQOjfsPZfJWsFBAUtspushCy1YObduHB0UwRJxglJluw2lOjsJGIqw5Xrt1wYARB9FGGd/feLlnO0nf2IL1E0OEv+thckg1O5OK8fQoHBrxGjtzveAxfXegVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945145; c=relaxed/simple;
	bh=TGKaS8hgDGjTg3iKIeL/LwGGJWg3/8yak8WWARL3OqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvcWW+DP6ro3ZWmMY/Sv1ppi3yWCB2SoCiaYdNJYyLgPaDyRQ8ENV0t0TuFe3sokvFdclqVfADCTe1HpXC6ouXcEZTwwZnNUbFwv/+QzZX8AZ4RtqV74/W6FPWj5gBa3HcK6Khp5CEzMSWW/39akUKoWEdP37LuwzFkSHyI/gA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dbd5Yr0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E86AC4AF0A;
	Tue,  2 Jul 2024 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945144;
	bh=TGKaS8hgDGjTg3iKIeL/LwGGJWg3/8yak8WWARL3OqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dbd5Yr0cH7zTp9SHRMoxG7fcNILHdtrK/9moX81RwaD7I+yp/WGcKUJ0Rj6WcVWZZ
	 S4vKGEu2aTfv9FHDeQ5UpQ0ysgR6GEKqK7/Q/bLEOWJ2mFWNNXMrof3VUgNXZ2cw5P
	 7JbN8EzasdalN8gGBCeIDPOdLp4zeWY327iGdjjOxC+3k37apNAyWPqkd9POU55E69
	 5O8ehtZgJOrz9zWGueEbT8BwjaS9uW+XOjgnveJ6xi5wOMKfV/9NcDreM36M/oYzSc
	 VCqOWPhmu0hYrAoWR3V+6rDhXrtRlJXQ3z/KldLuKBlxbQdK3r+Wslbczvd1Us2tFT
	 sPKf1bo+5tNTw==
Date: Tue, 2 Jul 2024 14:32:23 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>,
	"snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoRHt3ArlhbzqERr@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>

On Tue, Jul 02, 2024 at 06:06:09PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 2, 2024, at 12:28 PM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > Hi,
> > 
> > There seems to be consensus that these changes worthwhile and
> > extensively iterated on.
> 
> I don't see a public consensus about "extensively iterated
> on". The folks you talk to privately might believe that,
> though.
> 
> 
> > I'd very much like these changes to land upstream as-is (unless review
> > teases out some show-stopper).  These changes have been tested fairly
> > extensively (via xfstests) at this point.
> > 
> > Can we now please provide formal review tags and merge these changes
> > through the NFS client tree for 6.11?
> 
> Contributors don't get to determine the kernel release where
> their code lands; maintainers make that decision. You've stated
> your preference, and we are trying to accommodate. But frankly,
> the (server) changes don't stand up to close inspection yet.
> 
> One of the client maintainers has had years to live with this
> work. But the server maintainers had their first look at this
> just a few weeks ago, and this is not the only thing any of us
> have on our plates at the moment. So you need to be patient.
> 
> 
> > FYI:
> > - I do not intend to rebase this series ontop of NeilBrown's partial
> >  exploration of simplifying away the need for a "fake" svc_rqst
> >  (noble goals and happy to help those changes land upstream as an
> >  incremental improvement):
> >  https://marc.info/?l=linux-nfs&m=171980269529965&w=2
> 
> Sorry, rebasing is going to be a requirement.

What?  You're imposing a rebase on completely unfinished and untested
code?  Any idea when Neil will post v2?  Or am I supposed to take his
partial first pass and fix it?

> Again, as with the dprintk stuff, this is code that would get
> reverted or replaced as soon as we merge. We don't knowingly
> merge that kind of code; we fix it first.

Nice rule, except there is merit in tested code landing without it
having to see last minute academic changes.  These aren't dprintk,
these are disruptive changes that aren't fully formed.  If they were
fully formed I wouldn't be resisting them.

> To make it official, for v11 of this series:
> 
>   Nacked-by: Chuck Lever <chuck.lever@oracle.com>

Thanks for that.

> I'll be much more ready to consider an Acked-by: once the
> "fake svc_rqst" code has been replaced.

If Neil completes his work I'll rebase.  But last time I rebased to
his simplification of the localio protocol (to use array and not
lists, nice changes, appreciated but it took serious work on my part
to fold them in): the code immediately BUG_ON()'d in sunrpc trivially.
So please be considerate of my time and the requirement for code to
actually work.

I'm fine with these changes not landing for 6.11 if warranted.  I just
seriously question the arbitrary nature of what constitutes necessary
change to allow inclusion.

> > - In addition, tweaks to use nfsd_file_acquire_gc() instead of
> >  nfsd_file_acquire() aren't a priority.
> 
> The discussion has moved well beyond that now... IIUC the
> preferred approach might be to hold the file open until the
> local app is done with it. However, I'm still not convinced
> there's a benefit to using the NFSD file cache vs. a plain
> dentry_open().

Saving an nfs_file to open_context, etc.  All incremental improvement
(that needs time to stick the landing).

Why do you think it appropriate to cause upheaval on code that has
clearly drawn a line in the sand in terms of established fitness?

Eliding allocation of things and micro-optimizing can come later.  But
I guess I'll just have to agree to disagree with this approach.
Really feels like I'll be forced to keep both pieces when it breaks in
the near-term.

By all means layer on new improvements.  But this fear to establish a
baseline out of fear that we _might_ change it: don't even know where
to begin with that.

> Neil's clean-up might not need add a new nfsd_file_acquire()
> API if we go with plain dentry_open().
> 
> There are still interesting choices to make here before it
> is merged, so IMO the choices around nfsd_file_acquire()
> remain a priority for merge-readiness.

Maybe Neil will post a fully working v12 rebased on his changes.

Mike

