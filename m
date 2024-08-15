Return-Path: <linux-nfs+bounces-5395-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3D095298E
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 08:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDDE5B24944
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 06:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D951991D0;
	Thu, 15 Aug 2024 06:53:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7121993B2;
	Thu, 15 Aug 2024 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704819; cv=none; b=XYSGcP0TxGIloYEhyJkynBqKPVp7TXxPXRHHERfWwOutBTzFallhCjT13aLTvdD4yCk0h0rS7EcbGp5jSqm3aIrBMO8+hBxE8+TPWzb41/Tww70xLX47DIiYKirYHqxulpHCl8q/vh7IMrbOhhNlXJ/RHEC2/xNaSl97DaFvLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704819; c=relaxed/simple;
	bh=gzhaYvuozbAEV0fB78OfLgO0ob3E53kZabu7VyMo1B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU1hSKRWAiUC2/Tk9UEjKMvnnw+gS846Amkz8HKOlLbaBf7iV1DvGPyS5IiUVfkmOFXgWeLdf3ouSAJ9s3+tlSvmjKJy7zPuVWO/JKx8U0Ym8LVSCuy2T02H530ZWk3tuYq49JbdvK2BXAfNLfCg3z/bp6uIHGd+zr6yl5/GIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A27D1FFC0;
	Thu, 15 Aug 2024 06:53:35 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF3D213983;
	Thu, 15 Aug 2024 06:53:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zrObM+6lvWa/YQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 15 Aug 2024 06:53:34 +0000
Date: Thu, 15 Aug 2024 08:53:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>, Greg KH <greg@kroah.com>,
	Sherry Yang <sherry.yang@oracle.com>,
	Calum Mackay <calum.mackay@oracle.com>,
	linux-stable <stable@vger.kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	Avinesh Kumar <akumar@suse.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Message-ID: <20240815065333.GA560832@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <>
 <20240814205519.GA550121@pevik>
 <172367387549.6062.7078032983644586462@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172367387549.6062.7078032983644586462@noble.neil.brown.name>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4A27D1FFC0
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

> On Thu, 15 Aug 2024, Petr Vorel wrote:
> > > On Fri, 12 Jul 2024, Jeff Layton wrote:
> > > > On Fri, 2024-07-12 at 16:12 +1000, NeilBrown wrote:

> > > > > My point is that if we are going to change the kernel to accommodate LTP
> > > > > at all, we should accommodate LTP as it is today.  If we are going to
> > > > > change LTP to accommodate the kernel, then it should accommodate the
> > > > > kernel as it is today.


> > > > The problem is that there is no way for userland tell the difference
> > > > between the older and newer behavior. That was what I was suggesting we
> > > > add.

> > > To make sure I wasn't talking through my hat, I had a look at the ltp
> > > code.

> > > The test in question simply tests that the count of RPC calls increases.

> > > It can get the count of RPC calls in one of 2 ways :
> > >  1/ "lhost" - look directly in /proc/net/rpc/{nfs,nfsd}
> > >  2/ "rhost" - ssh to the server and look in that file.

> > FYI "rhost" in LTP can be either using namespaces (Single Host Configuration [1]),
> > which is run by default, or SSH based (Two Host Configuration [2]). IMHO most of
> > the testers (including myself run tests simply via network namespaces).

> > NOTE: I suppose CONFIG_NAMESPACES=y is a must for 'ip netns' to be working, thus
> > tests would hopefully failed early on kernel having that disabled.

> > > The current test to "fix" this for kernels -ge "6.9" is to force the use
> > > of "rhost".

> > > I'm guessing that always using "rhost" for the nfsd stats would always
> > > work.

> > FYI this old commit [3] allowed these tests to be working in network namespaces.
> > It reads for network namespaces both /proc/net/rpc/{nfs,nfsd} from non-namespace
> > ("lhost").  This is the subject of the change in 6.9, which now fails.
> > And for SSH based we obviously look on "rhost" already.

> That patch looks like a mistake.  The author noticed that the rpc stats
> were not "namespacified" and instead of reporting the bug (and surely
> the whole point of a test suite is to report bugs), they made a change
> that seems completely unnecessary which had the effect of entrenching
> the bug.  Unfortunately the commit message only says why it is same to
> make the change, not why it us useful.

Fully agree. With nowadays experiences I would have asked him to discuss that on
this ML. Ironically, Alexey back then (as part of Oracle) did had report and
even fix few network protocol related bugs, did some testing for NFS related
fixes.

> > > But if not, the code could get both the local and remote nfsd stats, and
> > > check that at least one of them increases (and neither decrease).

> > This sounds reasonable, thanks for a hint. I'll just look for client RPC calls
> > (/proc/net/rpc/nfs) in both non-namespace and namespace. The only think is that
> > we effectively give up checking where it should be (if it for whatever reason in
> > the future changes again, we miss that). I'm not sure if this would be treated
> > the same as the current situation (Josef Bacik had obvious reasons for this to
> > be working).

> Stats should always be visible in the relevant namespace.  server stats
> should be visible in the name space where the server runs.  client stats
> should be visible in the namespace where the filesystem is mounted.
> This has always been true (as long as we have had stats) and if it ever
> stops being true, that is a bug.

+1

> I think the test suite should test for precisely this case.  Testing if
> the stats are visible from a different namespace is not likely to be an
> interesting test - unless you want to guard against the possibility that
> we will one day accidentally de-namespaceify the stats (stranger things
> have happened).

There could be additional check for namespaces only (skip in SSH) that there is
no information leak.

Kind regards,
Petr

> Thanks,
> NeilBrown


> > @Josef @NFS maintainers: WDYT?

> > Kind regards,
> > Petr

> > > So ltp doesn't need to know which kernel is being used - it can be
> > > written to work safely on either.

> > > NeilBrown

> > [1] https://github.com/linux-test-project/ltp/tree/master/testcases/network#single-host-configuration
> > [2] https://github.com/linux-test-project/ltp/tree/master/testcases/network#two-host-configuration
> > [3] https://github.com/linux-test-project/ltp/commit/40958772f11d90e4b5052e7e772a3837d285cf89

> > > > To be clear, I hold this opinion loosely. If the consensus is that we
> > > > need to revert things then so be it. I just don't see the value of
> > > > doing that in this particular situation.
> > > > -- 
> > > > Jeff Layton <jlayton@kernel.org>





