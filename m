Return-Path: <linux-nfs+bounces-16051-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B7CC36262
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 15:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCC894EF66A
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EE923645D;
	Wed,  5 Nov 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMQhaqiL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9E23370F
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354083; cv=none; b=mxsprm5vQKYfh/SHYkMF3HVahZq53AJcHhzrxMjXj5PSKJeAhTVTzeiYfjVPSsnJbtXGJ6QUeb3Rejti4gp7/mKS1cs6k+KiPTKzePnPtny8W3QGvK3ozVS7cuRdzlbW0pj9lcRsHMKxzgf4FGqVkQt6tS+UVBxD+dKBH16LHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354083; c=relaxed/simple;
	bh=oO/Pgu+aQO39NBTXFLF2RMkyQS3N9ESgYzry3miIrIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZ5gn7q96oEpqkH096Obk+RdRZuGpwHAMzEVRouE42SN7VsW/Cj/1RUwbayBxV5pEGOPyzm13nbcbOhf4Nc4TCCJ4LIY2yqeHXmyE9L6AAFo6BgFNBDmETsZBe1ydJJfq5tMkTG97H2YFW8/YGc+q44cfgZOMvA2yWtoIXMcalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMQhaqiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB14C4CEF5;
	Wed,  5 Nov 2025 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762354082;
	bh=oO/Pgu+aQO39NBTXFLF2RMkyQS3N9ESgYzry3miIrIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMQhaqiLY0d9KDFDKrNo8fxRE93G/BhOZYEfiS3eEBdNnTtSFz0qga9mhACrEU+di
	 l4UoiRweOmodboFRyIGd4gy46rXp+puEJFVGHkTbwwouWEiYnGd+yvnDcbr83R24wt
	 irIpOZg1XpaycZQj44GWPErB9UzMowQqOPkKjv79G6wYVhLtFIDsPjZcmQ41ntwSMP
	 OCDlsWDo6azvLIFyD1nsYq9JSN7l1NOgHF93+zGG5p8YqE5Iszk/Z3ngCZRNdzy2df
	 2ElfdxIdQH2kqc1brZCL16gMsdyXhuhbgV1PxhETiPGMYEJRWtqPAyf9x6MGzO9z+m
	 k1YuMAmTYkIFg==
Date: Wed, 5 Nov 2025 09:48:01 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 05/12] NFSD: Remove alignment size checking
Message-ID: <aQtjoU9ClF8TAIq9@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-6-cel@kernel.org>
 <176220902556.1793333.10293656800242618512@noble.neil.brown.name>
 <aQnpB4mYMwW9IGM0@infradead.org>
 <35ddc8b0-2727-453e-b970-07b493e21f93@kernel.org>
 <aQtIqn28Bo2ElPqG@infradead.org>
 <a06fd92d-0c37-4b18-8ec2-1392d587264a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a06fd92d-0c37-4b18-8ec2-1392d587264a@kernel.org>

On Wed, Nov 05, 2025 at 09:38:33AM -0500, Chuck Lever wrote:
> On 11/5/25 7:52 AM, Christoph Hellwig wrote:
> > On Tue, Nov 04, 2025 at 09:14:09AM -0500, Chuck Lever wrote:
> >>>> It might be good to capture here *why* the check is removed.
> >>>> Is it because alignments never exceed PAGE_SIZE, or because the code is
> >>>> quite capable of handling larger alignments
> >>>> (I haven't been following the conversation closely..)
> >>>
> >>> I'm still trying to understand why it was added in the first place :)
> >>
> >> I'm trying to understand what action you'd like me to take. Should I
> >> drop this patch?
> > 
> > With "it" I meant the check.  І think Mike explain this was due to a
> > PAGE_SIZE bound buffer originally, and in that context it makes sense.
> > Without the explanation I don't understand the rationale for adding the
> > check in the first place.
> 
> Agreed, Mike's original patch has no explanatory comment, and there
> needs to be one. Mike, can you suggest a one or two sentence comment
> and I will replace this patch with one that adds the comment.

I replied yesterday suggesting you just fold 5 into 3.

> >>> But I'm also completely lost in the maze of fixup patches.
> >> Several people have asked me to collapse the fix-ups into a single
> >> patch. We would lose some history and attributions doing that. Does
> >> anyone have other thoughts?
> > 
> > The action I'd see is to collapse the series into reviewable chunks.
> > I.e., fold the addition of the direct I/O writes into a single patch
> > that has all the policy decisions and documents them, leaving only
> > clearly separate prep patches separate.
> Meaning: combine the patches from 3/12 to 12/12 into a single patch.

But if you elect to fold all of 3 to 12, definitely add your
Co-developed-by:

