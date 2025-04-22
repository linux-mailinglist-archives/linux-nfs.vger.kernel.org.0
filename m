Return-Path: <linux-nfs+bounces-11213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACFA9769F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Apr 2025 22:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2744F1B6185F
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Apr 2025 20:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547391AA791;
	Tue, 22 Apr 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjWYz3YY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B171EB5C2
	for <linux-nfs@vger.kernel.org>; Tue, 22 Apr 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352974; cv=none; b=tXjVLrakpp+tam+0AWwQgzfvgRU2aFRQamNKZYYA7qTyLCkkQSXiwe9dwurUVpPkV0p3N7np9HtnxUOGEnaotMvJU42m19+M6HwHtuvavp7zwT6fzj79PPVhuBFby3dCOC4uB3HJZatwHxpebesMhR7iOFXn4sQ2GtqOXEivh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352974; c=relaxed/simple;
	bh=Ekek9Hey80HU+3a62bJoo4MS+e6L2hIsBypTuhUdUxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARLUXMsSfF7a1Baxuizccua3YJklxcmC4xW8jPVx0IW5VpRVlZXsJvuetbL5C19NtNPhAyuFfyd3A+8KS+kChN7RpLcUJtzUgIYweKA3UCcwcTA+AigbR0T/8c0Ga9LdOi26uPJOqWmBgAuu03j88ryGvQ1ZlZhp83TT6eaYIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjWYz3YY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43772C4CEE9;
	Tue, 22 Apr 2025 20:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745352973;
	bh=Ekek9Hey80HU+3a62bJoo4MS+e6L2hIsBypTuhUdUxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjWYz3YYKgsUhB+Tdhe3YUPzhJmcRsFPv1OfGm2kexXIU6V0ZdRU5oEDh7w5Ynk5o
	 7P3IHFtob54CXfhHFiSoXVX6b3w8GTPqYAQxlSsj4YgyT0j8xA3eviIVeDBjO5MJC4
	 99jvwaHWUigHhvDDOa8XqPzUl2B8zuBhfrdAgnhb4UdJrudZXql4yJwxFqBuSNrnSS
	 lB6PvRBjDQU+JJNR0bK6SO9FY+FctMwp63vKOqgClnH3nMHUB9+1FQVtwZXcJ6iBWd
	 op76cHMbIkaA5hmpJKkwTwr7HKnxCOTQHNyO1AR/uhY588NlBaE12CkSBLlTyF6WpQ
	 REC0ESsZDBPug==
Received: by pali.im (Postfix)
	id 18227476; Tue, 22 Apr 2025 22:16:10 +0200 (CEST)
Date: Tue, 22 Apr 2025 22:16:09 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
Message-ID: <20250422201609.gkcgjgdljd2u4rx7@pali>
References: <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <3911d932-5ad3-4cc9-98c9-408818cdb4cf@wanadoo.fr>
 <Z_coQbSdvMWD92IA@kernel.org>
 <738e994b-1601-4ae0-a9a2-f74a6b797f23@wanadoo.fr>
 <425a2e7c-6d42-451b-b8f8-7c923ac0ed03@oracle.com>
 <aALFdnEGTxF03uQd@kernel.org>
 <a3ff6c97-3ea5-4baf-aeaa-77e29e1d7216@oracle.com>
 <aAUc5m5_dv5xllqm@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAUc5m5_dv5xllqm@kernel.org>
User-Agent: NeoMutt/20180716

On Sunday 20 April 2025 12:12:22 Mike Snitzer wrote:
> On Sat, Apr 19, 2025 at 01:52:31PM -0400, Chuck Lever wrote:
> > On 4/18/25 5:34 PM, Mike Snitzer wrote:
> > > On Wed, Apr 16, 2025 at 09:31:55AM -0400, Chuck Lever wrote:
> > >> On 4/15/25 10:41 PM, Vincent Mailhol wrote:
> > >>> +CC: Neil Brown
> > >>> +CC: Olga Kornievskaia
> > >>> +CC: Dai Ngo
> > >>> +CC: Tom Talpey
> > >>> +CC: Trond Myklebust
> > >>> +CC: Anna Schumaker
> > >>>
> > >>> (just to make sure that anyone listed in
> > >>>
> > >>>   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
> > >>>
> > >>> get copied).
> > >>>
> > >>> Here is the link to the full thread:
> > >>>
> > >>>   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
> > >>>
> > >>>
> > >>> On 10/04/2025 at 11:09, Mike Snitzer:
> > >>>> Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
> > >>>> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Otherwise
> > >>>> RCU code (rcu_dereference and rcu_access_pointer) will dereference
> > >>>> what should just be an opaque pointer (by using typeof(*ptr)).
> > >>>>
> > >>>> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
> > >>>> Cc: stable@vger.kernel.org
> > >>>> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> > >>>> Tested-by: Pali Rohár <pali@kernel.org>
> > >>>> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > >>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > >>>
> > >>> Hi everyone,
> > >>>
> > >>> The build has been broken for several weeks already. Does anyone have
> > >>> intention to pick-up this patch?
> > >>>
> > >>> (please ignore if someone already picked it up and if it is already on
> > >>> its way to Linus's tree).
> > >>
> > >> I assumed that, like all LOCALIO-related changes, this fix would go
> > >> in through the NFS client tree. Let me know if it needs to go via NFSD.
> > > 
> > > Since we haven't heard from Trond or Anna about it, I think you'd be
> > > perfectly fine to pick it up.  It is a compiler fixup associated with
> > > nfd_file being kept opaque to the client -- but given it is "struct
> > > nfsd_file" that gives you full license to grab it (IMO).
> > > 
> > > I'm also unaware of any conflicting changes in the NFS client tree.
> > 
> > Hi Mike -
> > 
> > I just looked at this one again. The patch's diffstat is:
> > 
> >  fs/nfs/localio.c           | 8 ++++++++
> >  fs/nfs_common/nfslocalio.c | 8 ++++++++
> > 
> > Although fs/nfs_common/ is part of both trees, fs/nfs/localio.c is
> > definitely a client file. I'm still happy to pick it up, but technically
> > I would need an Acked-by: from one of the NFS client maintainers.
> > 
> > My impression is that Trond is managing the NFS client pulls for v6.15.
> 
> Sure, that's my understanding too.  Feel free to offer your Acked-by
> (for fs/nfs_common/) and hopefully it'll get picked up.  I can
> followup with Trond later this coming week if/as needed.
> 
> Thanks,
> Mike

Can we move forward here? The compilation of kernel is broken for at
least 2 months. Also I have tried to contact Trond for more months but
has not responded to my emails.

Could be this change picked with a slightly higher priority than just
waiting another two months? Note that nobody objected this particular
fix and there are 3+ Tested-by lines. And it is not a good image if some
kernel component does not compile...

