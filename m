Return-Path: <linux-nfs+bounces-11649-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B7EAB2073
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 02:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6239D520A11
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 00:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B491D6AA;
	Sat, 10 May 2025 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxSHcZcT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6C347A2
	for <linux-nfs@vger.kernel.org>; Sat, 10 May 2025 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746836203; cv=none; b=JyUyN2jk9UNaKByO65bGroBuDe71Hg4GbtcwFmprjzlKaNjcvjm7jHCvEBEOy/RLVXVawDvhZoED4DSc0cGX4OA8LcKQqO/Q7aTyoF4kZwvOrwkh36l36nO2CZ7Tb9tgxjhAdD3B2UfrC03WyHsTBiO+ENkXmYvMVXicKLtlppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746836203; c=relaxed/simple;
	bh=ihZSisicZyd96lSru4KYC0CCOWiHjYghEimqQz0Bkpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ae5P0tqdESjHsZNFJSMqz1en8XXm72ownl1RG+HzyzjqBnqIE80xB5ataKnR1hH+d8bFVgLMZi5G8W9YZ0fm+9JYARi1G92a9z49idvS60IEP40oUkrn3dYDAjgVYcdESRg1yPB9Fa721gHvDJWfRChwGE9ZPPvBE5+255SNB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxSHcZcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E6EC4CEED;
	Sat, 10 May 2025 00:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746836202;
	bh=ihZSisicZyd96lSru4KYC0CCOWiHjYghEimqQz0Bkpk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CxSHcZcTHMC12HWZPMXCLQvjfpwX98FQRLFUIoUi9dvTchiLY93ffY2TquVR3wnyk
	 3meFmTU/nySdErYyupevpVpLRd2q4Az6TFW/YfyGVPFUrGhIeHXxx3376k/6dQfuFl
	 zaokiOgGZZSyDlJVocXmMdcqU1DD4vjuyJZCCIT0Bu5t4WJte/pSC0B2rTDyU7I94V
	 BHRJkMI87GLPlpjrFzt6Ss9VAk2j16fef0i91Y3X7rbZ72CRUk3Ipe8rbfqAtKKWFL
	 02dVcK1bkDTurx+seKiDDS1KJZyGJVCblNv/+Y4RBpbY2NOYTv3N16Xy9E+Z7YJISw
	 p690SNx3u7qAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4938FCE08A0; Fri,  9 May 2025 17:16:42 -0700 (PDT)
Date: Fri, 9 May 2025 17:16:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from
 older compilers
Message-ID: <b2e7698b-55e7-485a-84ad-fc81c3af7652@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <aB5tZY9ucJigXGFp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB5tZY9ucJigXGFp@kernel.org>

On Fri, May 09, 2025 at 05:02:29PM -0400, Mike Snitzer wrote:
> On Fri, May 09, 2025 at 12:01:19PM -0400, Chuck Lever wrote:
> > [ adding Paul McK ]
> > 
> > On 5/8/25 8:46 PM, NeilBrown wrote:
> > > This is a revised version a the earlier series.  I've actually tested
> > > this time and fixed a few issues including the one that Mike found.
> > 
> > As Mike mentioned in a previous thread, at this point, any fix for this
> > issue will need to be applied to recent stable kernels as well. This
> > series looks a bit too complicated for that.
> > 
> > I expect that other subsystems will encounter this issue eventually,
> > so it would be beneficial to address the root cause. For that purpose, I
> > think I like Vincent's proposal the best:
> > 
> > https://lore.kernel.org/linux-nfs/8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr/raw
> > 
> > None of this is to say that Neil's patches shouldn't be applied. But
> > perhaps these are not a broad solution to the RCU compilation issue.
> 
> I agree with your suggested approach.  Hopefully Paul agrees and
> Vincent can polish a patch for near-term inclusion.

The main issue that I see with Vincent's patch is that we need the
asterisks ("*") to remain in order to mesh with the definition of __rcu
and to work correctly with the "sparse" tool.  The __rcu address space
applies to the pointed-to data, not the pointer.  So removing the
asterisks from __rcu_access_pointer() and friends would require the
various uses of __rcu to move to the other side of the asterisk,
right?  For example, this:

	struct pci_dev __rcu *pdev;

would need to become this:

	struct pci_dev *__rcu pdev

And the same for the more than 1,000 other uses of __rcu.

Or am I missing something here?  In particular, did it turn out that
sparse and the other tools were all happy with this change?

							Thanx, Paul

> It'll be at least a week before I can put adequate time to reviewing
> and testing Neil's patchset.
> 
> Thanks,
> Mike

