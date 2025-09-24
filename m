Return-Path: <linux-nfs+bounces-14637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18622B97F10
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 02:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C253C3BF3E1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 00:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A41DE4C9;
	Wed, 24 Sep 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8u2AHkI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410D71D63F8
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675005; cv=none; b=tCMR5yjWBh8wx5NodyPcfshYprl3jVgfGEnzQMconLtAk79JXfGOnUFqCp2JIJ2G2wtAAZ+wHb/v2qyEOlndnTbeswQ4fktmfQMGoidpiWzoMCr/Ki5TYFZI0ob4R40FurTaT3m6zrpCuBk+eQ+Ble9D7rM4QEjxlzO8YHsVIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675005; c=relaxed/simple;
	bh=RpGOdoYZ8P9vJQ7e9sDTlcwEBP9l5mHmcJxAYbFf/xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3/20RuWUlYmKb8xFSg8DsspbnlzHpFS+5ry2fHSgaSJ09TlcHUFb5cerGcjSMzD9n4xkcBfptFCDzPqTIZvj0qr3JgO66NLfyX017jHrolpZgW7WHcWRRWV91jjpUI0Zi8XBHrzOMfdqRKy5xSwEvCK0k4nF9AzOfAZcshDy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8u2AHkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2770C4CEF5;
	Wed, 24 Sep 2025 00:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758675004;
	bh=RpGOdoYZ8P9vJQ7e9sDTlcwEBP9l5mHmcJxAYbFf/xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8u2AHkIoDihJ9rYlFfngPa8lMCK04yCFhkCpIMd4C+riGApW4GfRaRmh285tF3nc
	 CmYTLDKVJRSzx4DN5H4SG8QB0gVZYj2n1XTaQnmyMkpJ8lKRDmNltWZHL4bX5TwwjM
	 cpnQNLWsp1RBBhMIk7C5FzfJXnBcfqvBlBPZt0gi0bi0NAp9wkOioYlq6+CcR0b6fM
	 nKmgu1gX+K1m8sg96/rSG13R4jdPPp2AACTi+llOBlGaxI159jZCYzUJMe+BDaEfFR
	 xSffGACRUMN6veJX//FfmkT2jjADPn5l8h7v+tLDHRmJxh8ADK1AEugiivth9NAOom
	 l4v57upfmEKgQ==
Date: Tue, 23 Sep 2025 17:50:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
Message-ID: <20250924005004.GM8117@frogsfrogsfrogs>
References: <20250921194353.66095-1-cel@kernel.org>
 <175851511014.1696783.3027085648108996983@noble.neil.brown.name>
 <0fbaef6f-80ad-4885-ba2b-6a9567f01042@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fbaef6f-80ad-4885-ba2b-6a9567f01042@kernel.org>

On Mon, Sep 22, 2025 at 10:29:11AM -0400, Chuck Lever wrote:
> Hi Neil -
> 
> On 9/21/25 9:25 PM, NeilBrown wrote:
> >> +Patch preparation
> >> +~~~~~~~~~~~~~~~~~
> >> +Like all kernel submissions, please use tagging to identify all
> >> +patch authors. Reviewers and testers can be added by replying to
> >> +the email patch submission. Email is extensively used in order to
> >> +publicly archive review and testing attributions, and will be
> >> +automatically inserted into your patches when they are applied.
> >> +
> >> +The patch description must contain information that does not appear
> >> +in the body of the diff. The code should be good enough to tell a
> >> +story -- self-documenting -- but the patch description needs to
> >> +provide rationale ("why does NFSD benefit from this change?") or
> >> +a clear problem statement ("what is this patch trying to fix?").
> 
> > These paras look to be completely generic - not at all nfsd-specific.
> > Do they belong here?
> 
> Can you clarify which paragraphs you mean, exactly? Maybe the whole
> section?
> 
> For context:
> 
> IMHO these comments aren't necessarily generic because I haven't seen
> them in other documents, and we seem to get a lot of patches where the
> description is just "Make this change".

TBH I think this ought to be in SubmittingPatches, "make this change"
helps nobody.

> The comments about tagging: I think other subsystems might not mind
> seeing Cc: stable in the initial submission. NFS maintainers (even on
> the client side) like to add those themselves.
> 
> I'd like to encourage contributors to get the Fixes: tag right before
> submitting, too. It saves me a little incremental time per patch.

/me notes that over in xfsland, I have a script that tries to guess the
correct "Cc: stable@vger.kernel.org # VERSION" and "Fixes:" tags for a
given diff, so I send them in the initial patch submission.  Obviously I
check the guesswork before sending.

--D

> And, some of this text was cribbed from netdev's policy document, not
> from a generic document, suggesting these are subsystem addendums.
> 
> 
> > I expect more of a patch description than is given here.  I agree that
> > "code should be good enough to tell a store" but I don't think that a
> > patch can by itself be good enough.
> > So I think that a patch description should describe the patch -
> > particularly how the various changes in the patch relate.
> > 
> > With a good patch description, I should be able to then read the patch
> > and every change will make sense in the context provided by the
> > description.  It isn't just "Why", it is also "how".
> 
> I can add these remarks.
> 
> 
> -- 
> Chuck Lever

