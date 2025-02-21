Return-Path: <linux-nfs+bounces-10266-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFCDA3F913
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9F1189F4E4
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF4B1E87B;
	Fri, 21 Feb 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcQzrMIN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191971CA9C
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152162; cv=none; b=PK6bIDlQK0L9H9r9+b7WwXPJX/jRViZztPuVe60Rmimb6j9hUxFx2878jckmQ3QSK+XHNQYqYX5nh0NGnpMBFmU1X+XQjhBh/M9p44cZPAS8gx5YTUZPUTfTX+hGbLwMq9WwBgBWdezHJzIixMk3EFEVVTJSgZTxzHuiBXz9cXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152162; c=relaxed/simple;
	bh=0NiiSacs1Hu5N4VF2Eof8pfYTln94oTtroBmLZXXGF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il8S/6HRSrhmdZpsmgiCiEOJhHXJ9Oh+Enj9jRBETyo6Mq8S405b69Aw/DbAj9gK3MrgqIKwPTa1LjzaFnrbyA/nk7L+0WcyHIiiYulfRua62h5eecNxC+4FP3MqjhSIijJu1rGi6gujJtS/9vfXsghyua12DUQjUjxgxsCrYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcQzrMIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571F3C4CED6;
	Fri, 21 Feb 2025 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152161;
	bh=0NiiSacs1Hu5N4VF2Eof8pfYTln94oTtroBmLZXXGF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcQzrMINSZ/dlzIStD0RsFUdI/CouuoOrPpE3o4eTNg8SpUkEa/iz9AbNi7zawe4I
	 yJSufEb3m2lbfxOcA5venmuixcq9dkfFyhd7GLGXqS8Nd4p9LTu9JZCf6mBLvsM/Ai
	 9vTN5EX3biIiTJYq1EomCdGalIEFrKDbYNzR8Qq7XqwnmKPsCOE11HNq7BQWHsZiZ9
	 v4nWk3M8WgoOpVNcjROnjm2GDOG5cYvRAhwUyp6YsBkMt7bdjGDk72O5ikPKKEqSFa
	 cga4Rl72IhXOdqDeiQ/BUD+YvjjZet0Vtb3IDqsys1jLsVdv0Md1oCy+AB++u26+Bp
	 5zCEWsyX7mEXg==
Date: Fri, 21 Feb 2025 10:36:00 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	axboe@kernel.dk
Subject: Re: nfsd: add the ability to enable use of RWF_DONTCACHE for all
 nfsd IO
Message-ID: <Z7idYDSHD_hcLL9b@kernel.org>
References: <20250220171205.12092-1-snitzer@kernel.org>
 <ce92e5f6-d7cb-47ef-ad96-d334212a51f1@oracle.com>
 <Z7iVdHcnGveg-gbg@kernel.org>
 <b101b927807cc30ce284d6be9aca5cbb92da8f94.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b101b927807cc30ce284d6be9aca5cbb92da8f94.camel@kernel.org>

On Fri, Feb 21, 2025 at 10:25:03AM -0500, Jeff Layton wrote:
> On Fri, 2025-02-21 at 10:02 -0500, Mike Snitzer wrote:
> > On Thu, Feb 20, 2025 at 01:17:42PM -0500, Chuck Lever wrote:
> > > [ Adding NFSD reviewers ... ]
> > > 
> > > On 2/20/25 12:12 PM, Mike Snitzer wrote:
> > > > Add nfsd 'nfsd_dontcache' modparam so that "Any data read or written
> > > > by nfsd will be removed from the page cache upon completion."
> > > > 
> > > > nfsd_dontcache is disabled by default.  It may be enabled with:
> > > >   echo Y > /sys/module/nfsd/parameters/nfsd_dontcache
> > > 
> > > A per-export setting like an export option would be nicer. Also, does
> > > it make sense to make it a separate control for READ and one for WRITE?
> > > My trick knee suggests caching read results is still going to add
> > > significant value, but write, not so much.
> > 
> > My intent was to make 6.14's DONTCACHE feature able to be tested in
> > the context of nfsd in a no-frills way.  I realize adding the
> > nfsd_dontcache knob skews toward too raw, lacks polish.  But I'm
> > inclined to expose such course-grained opt-in knobs to encourage
> > others' discovery (and answers to some of the questions you pose
> > below).  I also hope to enlist all NFSD reviewers' help in
> > categorizing/documenting where DONTCACHE helps/hurts. ;)
> > 
> > And I agree that ultimately per-export control is needed.  I'll take
> > the time to implement that, hopeful to have something more suitable in
> > time for LSF.
> > 
> 
> Would it make more sense to hook DONTCACHE up to the IO_ADVISE
> operation in RFC7862? IO_ADVISE4_NOREUSE sounds like it has similar
> meaning? That would give the clients a way to do this on a per-open
> basis.

Just thinking aloud here but: Using a DONTCACHE scalpel on a per open
basis quite likely wouldn't provide the required page reclaim relief
if the server is being hammered with normal buffered IO.  Sure that
particular DONTCACHE IO wouldn't contribute to the problem but it
would still be impacted by those not opting to use DONTCACHE on entry
to the server due to needing pages for its DONTCACHE buffered IO.

> > > However, to add any such administrative control, I'd like to see some
> > > performance numbers. I think we need to enumerate the cases (I/O types)
> > > that are most interesting to examine: small memory NFS servers; lots of
> > > small unaligned I/O; server-side CPU per byte; storage interrupt rates;
> > > any others?
> > > 
> > > And let's see some user/admin documentation (eg when should this setting
> > > be enabled? when would it be contra-indicated?)
> > > 
> > > The same arguments that applied to Cedric's request to make maximum RPC
> > > size a tunable setting apply here. Do we want to carry a manual setting
> > > for this mechanism for a long time, or do we expect that the setting can
> > > become automatic/uninteresting after a period of experimentation?
> > > 
> > > * It might be argued that putting these experimental tunables under /sys
> > >   eliminates the support longevity question, since there aren't strict
> > >   rules about removing files under /sys.
> 
> Isn't /sys covered by the same ABI guarantees? I know debugfs isn't,
> but I'm not sure about /sys.

Only if you add them to the ABI docs as supported (at least that is my
experience relative to various block limits knobs, etc).  But yeah,
invariably that invites a cat and mouse game of users using the knob
and then complaining loudly if/when it goes away.

Mike

