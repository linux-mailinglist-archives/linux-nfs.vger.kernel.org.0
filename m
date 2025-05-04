Return-Path: <linux-nfs+bounces-11433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11985AA8558
	for <lists+linux-nfs@lfdr.de>; Sun,  4 May 2025 11:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71082160BB5
	for <lists+linux-nfs@lfdr.de>; Sun,  4 May 2025 09:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3001EF1D;
	Sun,  4 May 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5A0pgQg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE31862
	for <linux-nfs@vger.kernel.org>; Sun,  4 May 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349681; cv=none; b=SntOp8F9qiVeF3jVVsQrT99lrRoZH9TuXpHaVPyOu9GUYsfudZcelTt8Z2Xa/K0pYAVHmCbs3Lk5WW9Z3ye9U18/qgi0pQX9YTpNr0edNMPnvdUUjsBWfquZ3kJZ6tvQuwRdgBUd4QLKM6dSZJzcFBGL1ckmMclcukfL42NDNps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349681; c=relaxed/simple;
	bh=n/sZKPxIjGd2JSOOIiMCgSuY7iAEsXd+pfm5gSh1oIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acdLjtP+pHQ4kmbSAhUl3puER1iNBDgECvzz7+9mPogO9AKoAn6G/r/n2i0TpiO7l7L68HVQ1VGKJYG8ztUzxlYOqojajv9FQ3iFMm1RptcJgmkh3RKtiLDKDyHy6y8CiBr4dtIRdLi4jMjCNAtiMvDIt8I/kHwmaHH29OypRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5A0pgQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9C7C4CEE7;
	Sun,  4 May 2025 09:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746349681;
	bh=n/sZKPxIjGd2JSOOIiMCgSuY7iAEsXd+pfm5gSh1oIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5A0pgQgaiXrmCoDYAjIt/gHOsHmiMasHdIEHSY+hZwch72nam421oGGyq046vxX1
	 rt9rWXF2bRCpTgaYDAeEJMb2IMzlsy5XfxvTLHsSwnem+P7lfHMAdn8+jH0SHImxlt
	 1v3RFVDfgAr5abS6prZy+b/h4tYRZjS1JouAoShcXE9PqO7oZk/PYyGX7qnDk5SrrZ
	 UxaUtfiZkkf881RSjhF+xQ2FoAPqWajYqBfTWtlqn5TM2SYXmnfFy2sbXU6nBuujhL
	 PD4H0MobcEr+ZxB5yOzKNv/OTlPqSNMO1xq++sG3GOWp0CBVN0uHhStBafE4kt1t37
	 ffapUPv18skig==
Received: by pali.im (Postfix)
	id 00359731; Sun,  4 May 2025 11:07:57 +0200 (CEST)
Date: Sun, 4 May 2025 11:07:57 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
Message-ID: <20250504090757.zk5rgb4lg4cgqenf@pali>
References: <>
 <20250422201609.gkcgjgdljd2u4rx7@pali>
 <174535888011.500591.1496684320777038856@noble.neil.brown.name>
 <20250422220200.otabh5q7efh63rjh@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422220200.otabh5q7efh63rjh@pali>
User-Agent: NeoMutt/20180716

On Wednesday 23 April 2025 00:02:00 Pali Rohár wrote:
> On Wednesday 23 April 2025 07:54:40 NeilBrown wrote:
> > On Wed, 23 Apr 2025, Pali Rohár wrote:
> > > On Sunday 20 April 2025 12:12:22 Mike Snitzer wrote:
> > > > On Sat, Apr 19, 2025 at 01:52:31PM -0400, Chuck Lever wrote:
> > > > > On 4/18/25 5:34 PM, Mike Snitzer wrote:
> > > > > > On Wed, Apr 16, 2025 at 09:31:55AM -0400, Chuck Lever wrote:
> > > > > >> On 4/15/25 10:41 PM, Vincent Mailhol wrote:
> > > > > >>> +CC: Neil Brown
> > > > > >>> +CC: Olga Kornievskaia
> > > > > >>> +CC: Dai Ngo
> > > > > >>> +CC: Tom Talpey
> > > > > >>> +CC: Trond Myklebust
> > > > > >>> +CC: Anna Schumaker
> > > > > >>>
> > > > > >>> (just to make sure that anyone listed in
> > > > > >>>
> > > > > >>>   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
> > > > > >>>
> > > > > >>> get copied).
> > > > > >>>
> > > > > >>> Here is the link to the full thread:
> > > > > >>>
> > > > > >>>   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
> > > > > >>>
> > > > > >>>
> > > > > >>> On 10/04/2025 at 11:09, Mike Snitzer:
> > > > > >>>> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> > > > > >>>> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Otherwise
> > > > > >>>> RCU code (rcu_dereference and rcu_access_pointer) will dereference
> > > > > >>>> what should just be an opaque pointer (by using typeof(*ptr)).
> > > > > >>>>
> > > > > >>>> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> > > > > >>>> Cc: stable@vger.kernel.org
> > > > > >>>> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> > > > > >>>> Tested-by: Pali Rohár <pali@kernel.org>
> > > > > >>>> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > > > >>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > >>>
> > > > > >>> Hi everyone,
> > > > > >>>
> > > > > >>> The build has been broken for several weeks already. Does anyone have
> > > > > >>> intention to pick-up this patch?
> > > > > >>>
> > > > > >>> (please ignore if someone already picked it up and if it is already on
> > > > > >>> its way to Linus's tree).
> > > > > >>
> > > > > >> I assumed that, like all LOCALIO-related changes, this fix would go
> > > > > >> in through the NFS client tree. Let me know if it needs to go via NFSD.
> > > > > > 
> > > > > > Since we haven't heard from Trond or Anna about it, I think you'd be
> > > > > > perfectly fine to pick it up.  It is a compiler fixup associated with
> > > > > > nfd_file being kept opaque to the client -- but given it is "struct
> > > > > > nfsd_file" that gives you full license to grab it (IMO).
> > > > > > 
> > > > > > I'm also unaware of any conflicting changes in the NFS client tree.
> > > > > 
> > > > > Hi Mike -
> > > > > 
> > > > > I just looked at this one again. The patch's diffstat is:
> > > > > 
> > > > >  fs/nfs/localio.c           | 8 ++++++++
> > > > >  fs/nfs_common/nfslocalio.c | 8 ++++++++
> > > > > 
> > > > > Although fs/nfs_common/ is part of both trees, fs/nfs/localio.c is
> > > > > definitely a client file. I'm still happy to pick it up, but technically
> > > > > I would need an Acked-by: from one of the NFS client maintainers.
> > > > > 
> > > > > My impression is that Trond is managing the NFS client pulls for v6.15.
> > > > 
> > > > Sure, that's my understanding too.  Feel free to offer your Acked-by
> > > > (for fs/nfs_common/) and hopefully it'll get picked up.  I can
> > > > followup with Trond later this coming week if/as needed.
> > > > 
> > > > Thanks,
> > > > Mike
> > > 
> > > Can we move forward here? The compilation of kernel is broken for at
> > > least 2 months. Also I have tried to contact Trond for more months but
> > > has not responded to my emails.
> > > 
> > > Could be this change picked with a slightly higher priority than just
> > > waiting another two months? Note that nobody objected this particular
> > > fix and there are 3+ Tested-by lines. And it is not a good image if some
> > > kernel component does not compile...
> > > 
> > 
> > Actually I do object to this fix (though I've been busy and hadn't had
> > much change to look at it properly).
> > The fix is ugly.  At the very least it should be wrapping in an 
> >    #if  GCC_VERSION  < whatever
> 
> The problem is that this compile issue happens also with some builds of
> gcc 13.3.0 as was discussed in the email thread.
> 
> So is not clear what is that "whatever". For me it looks like that it
> would be more than the version, probably also some build characteristics
> of gcc. But I have not been investigating it deeper.

Neil, thank you for taking care about this. I will retest your next
patches later.

> > to make the purpose more clear.  But I'd rather a deeper fix.
> > 
> > GCC is complaining that rcu_dereference is being called on a point to a
> > structure that it doesn't know the content of.
> > So the code is says "I'm going to dereference this pointer even that
> > that is actually impossible as I don't know what any of the fields are".
> > 
> > I'd rather it didn't do that.  I've been playing with the code and I
> > think it can be made quite a bit cleaner by moving the rcu_dereference()
> > call into the nfsd side of the code.  Hopefully I'll have a patch in a
> > day or so to demonstrate what I mean.
> > 
> > I understand your desire for some action - but the reality is that you
> > have the full source code of the kernel and you can do whatever you want
> > to the kernel that you are working on.  You don't need us.
> > Getting code upstream is certainly good and we should continue to work
> > on doing that, but if you *need* something to be upstream then you might
> > want to consider whether your processes are really serving you.

I need to comment this. I read more times that kernel developers are
complaining about vendors who do not provide accurate kernel support for
their hardware, like not sending changes to mainline kernel and instead
just publishing their own SDK (=copy of kernel with own changes) or not
providing nothing at all, and that this is being repeated.
And here you are saying that it OK and basically preferred, you have
sources do that and do not care about mainline kernel.
Then we have there developers who are saying that usage of non-mainline
or patched kernel is not supported and would not take any bug report and
instead redirect them to vendor portal. So at the end the result for
some specific hardware is that you cannot use mainline kernel because of
broken A, you have to use vendor kernel, but there is a broken thing B
about which vendor do not care (and taking it from mainline) and you
cannot report it to kernel developers because you are not using mainline.
Which makes the situation really bad for (end) users...

> > Trond does often seem slow to take patches, and often they simply appear
> > in git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git without any
> > reply to the emails, but he or Anna does usually get to stuff
> > eventually.
> > 
> > NeilBrown

So how to contact those people if they do not react for year? I tried to
remind changes more times, but no response. I was already told by more
people that this is a private group which is not taking changes or
(security) bug reports from outside, and my experience just proves it.

