Return-Path: <linux-nfs+bounces-2783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE368A3035
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B5AB21A9E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFFF84DF6;
	Fri, 12 Apr 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPGYNkOh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DCF5914E
	for <linux-nfs@vger.kernel.org>; Fri, 12 Apr 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931235; cv=none; b=tgjCInfCKRiaNiWBCp4+YYCyyMr75IF1oijnsWTsX3dnXbQm5WDZU7A9oOQoVZ4RkMPsQ4gaBghWI2jKFkYOOQd/B/sL0ztsyYCqQoVug0cVTE50e6n7X89TfbuN9ofbvc5XOPh1DyqYT515WiWYr0gqma5LVOq/h4GPmVppnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931235; c=relaxed/simple;
	bh=GlxNcaip9zN2nnLUm2PFdfvkfxfSU25xS1ELQH7Kom4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHeVH8NA2CiT+3Ntv7/a8sYIdh8ArWMFigqgQMOwDZdNAtmAKAHd9hoq5cjQWUK31KRVqW0AiK86EbQ77mFIpuY6Fg6H+lzlWOYllHlq7fKn3/r2lhAgjcmTSY1L8rAAwZDNXehmBQjVx1aeghFIrJbx9BNDAMmALdleRE2ozJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPGYNkOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA79C113CC;
	Fri, 12 Apr 2024 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712931234;
	bh=GlxNcaip9zN2nnLUm2PFdfvkfxfSU25xS1ELQH7Kom4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QPGYNkOhNLvSyLqLragjzim5bajCyHaIAWv4+AQykgvu2CsF3aTIPhZ4Z87D0mP+O
	 jz9a1BK7GmZa/h8CeeDU50nRaml7WvmyrZ2Y2qGEAQKucwUk6663tSssiy3L0aQYnb
	 S39SoHkIHMnZkl2gHLsF1btnE2ZiXtE5VirH2fBHY6N2HtPihdgOqx0Fyr6rnirCXW
	 Em1jQRGbyxHlBAgMWaoCBpYKAYzUrhPvBg2lBBDX/4rERqqI/BrNzEn8ym8bZzfwNf
	 M2CPnVjZw9DfznkJHC9ii5auw1H+AmCDjG1lshMYjDnvZdcGKDoWt6qppidAKCX6H9
	 NtPtD9s0GjVqA==
Message-ID: <8396388e29e68a15b36f7ffe92b39f73af302c54.camel@kernel.org>
Subject: Re: directory caching & negative file lookups?
From: Jeff Layton <jlayton@kernel.org>
To: Daire Byrne <daire@dneg.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, "linux-nfs@vger.kernel.org"
	 <linux-nfs@vger.kernel.org>
Date: Fri, 12 Apr 2024 10:13:53 -0400
In-Reply-To: <CAPt2mGOK-rURRe1i7HJsEHkJDFKRrZexw4jS=FyAPyyuJq9Uwg@mail.gmail.com>
References: 
	<CAPt2mGOnsA9pcmZQkr2q40d7A+NLj7=xr+dzFh7XwJPdGYW6Hw@mail.gmail.com>
	 <a4abb5fcf94d706cc3f47d6b629763d5b1831c21.camel@hammerspace.com>
	 <CAPt2mGMOSHssr_J6bcf8A8dnU_oHNf_UuHZsDk1WxVi=TUheWA@mail.gmail.com>
	 <561ef18af88ecda0f7b8abf55c1dfb2b66cf5dea.camel@hammerspace.com>
	 <CAPt2mGNm11o3-b+W66eUUj=bvW-XV9wuiU+_uG+zigFPTQ6TwA@mail.gmail.com>
	 <CAPt2mGNYaeMxx4UCEKkaFjxk3K7hAhv8A9ARuPwhLx2yoOBv7Q@mail.gmail.com>
	 <17e2bf4c718a7cfdc34131978ad03656d0622de5.camel@hammerspace.com>
	 <CAPt2mGM-kc1UShzuuUZeeh4sJDbT==sVh+uv-HK7K9EoZoHvnA@mail.gmail.com>
	 <7e593bfb376eabb1968244d6014e223945e71990.camel@kernel.org>
	 <CAPt2mGOK-rURRe1i7HJsEHkJDFKRrZexw4jS=FyAPyyuJq9Uwg@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 12:43 +0100, Daire Byrne wrote:
> On Fri, 12 Apr 2024 at 11:21, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2024-04-12 at 10:11 +0100, Daire Byrne wrote:
> > > Thanks for the clarity Trond - I promise not to forget this time and
> > > ask the same question again in 2 years!
> > >=20
> > > It just keeps coming up here at DNEG due to accessing software over
> > > NFS and crazy PYTHONPATH usage by some of our developers. In some
> > > cases, there are 57,000 negative lookups but only 5000 positive
> > > lookups (and opens)!
> > >=20
> > > Getting devs to optimise their code is my cross to bear I guess.
> > >=20
> > > But this is also a well known and common problem for large batch farm=
s
> > > and there are some novel workarounds out there:
> > >=20
> > > https://guix.gnu.org/en/blog/2021/taming-the-stat-storm-with-a-loader=
-cache
> > > https://computing.llnl.gov/projects/spindle
> > > https://cernvm.cern.ch/fs/
> > >=20
> > > Coupled with our propensity for high latency (~100ms) NFS via
> > > re-export servers (for "cloud rendering"), these inefficient path
> > > lookups quickly become a killer - the application takes longer to
> > > lookup non-existent files and open files, than it does to execute to
> > > completion. We use aggressive caching (actimeo=3D3600,nocto,vers=3D3)=
 and
> > > "preload" metadata ops (ls -l, open) on a regular basis to try and
> > > keep things in (re-export) client cache which certainly helps. It's
> > > hard to keep known (expensive) metadata worksets in memory.
> > >=20
> > > I've also been looking at using an overlay and hand crafting whiteout
> > > files in the upper layers to essentially block known negative lookups
> > > from hitting the lower NFS share - again, only useful and correct for
> > > read-only software shares.
> > >=20
> > > I wonder if Jeff Layton's directory delegations will help for
> > > (read-only) metadata heavy lookups over the WAN?
> > >=20
> >=20
> > Probably not. In order to optimize away lookups of negative dentries
> > that aren't in cache, you need to know all of the positive dentries in
> > the directory. As Trond pointed out earlier in the discussion, NFS
> > doesn't have a concept of directory "completeness", so we can't
> > reasonably do this.
> >=20
> > FWIW, CephFS does have such a concept and can satisfy readdir requests
> > and negative lookups out of the cache when it has complete directory
> > info.
>=20
> Out of interest, do directory delegations help with positive lookups
> or repeat opens? They may be less numerous in our badly behaved
> workloads, but they are still nice to optimise for latency.
>=20
> Can you disable "cto" for example if you have a directory delegation
> and repeatedly open the same file for reading without a network hop?

Maybe? Dir delegations don't really help with CTO, since that's all
about the file itself, not its parent directory. It might help avoid
having to revalidate the parent directory for the lookup however.

FWIW, basic, recallable directory delegations with no notifications are
pretty useless in my testing. You optimize away a few GETATTRs on the
parent directories, but those are pretty infrequent anyway -- 1 every
60s or so on directories that aren't changing much by default.

That's close to "why bother" territory, but maybe there is a case to be
made for that on high-latency links (like you mention).

Mixing in notifications may change things though:

Consider 2 clients that are both working with files in the same
directory and both hold directory delegations. client1 creates a file or
another directory in the dir. Server then pushes out a notification to
client2. client2 goes to look up the new dentry later, and finds that
it's already in cache.

That's a potential optimization, but it's pretty specific to workloads
where multiple clients are operating on the same files in the a
directory that is frequently changing.

>=20
> I also noticed that "nocto" can completely stop any subsequent network
> hops for opens (with a long actimeo) for NFSv3, but on NFSv4 it only
> cuts a single GETATTR before still doing an OPEN DH over the network
> each time.
>=20

File delegations can allow you to do an open w/o having to cross the
network. If I hold the right sort of deleg on a file, I should be able
to open it without talking to the server.

Dir delegations could help optimize away some round trips for the
lookups leading up to the open however.

> I'm probably wandering off into "disconnected clients" and AFS style
> territory now...
>=20
>=20

>=20
> > > On Fri, 5 Apr 2024 at 16:03, Trond Myklebust <trondmy@hammerspace.com=
> wrote:
> > > >=20
> > > > On Fri, 2024-04-05 at 15:47 +0100, Daire Byrne wrote:
> > > > > Apologies for dragging up an old thread, but I've had to tackle
> > > > > wayward negative lookup storms again and I have obviously half
> > > > > forgotten what I learned in this thread last time (even after
> > > > > re-reading it!).
> > > > >=20
> > > > > Can I just ask if I understand correctly and that there was an
> > > > > intention a long time ago to be able to serve negative dentries f=
rom
> > > > > a
> > > > > "complete" READDIRPLUS result?
> > > > >=20
> > > > > https://www.cs.helsinki.fi/linux/linux-kernel/2002-30/0108.html
> > > > >=20
> > > > > So if we did a readdirplus on a directory then immediately fired
> > > > > random non existent lookups at the directory, it could be served =
from
> > > > > the readdirplus result? i.e. not in readdir result, then return
> > > > > ENOENT
> > > > > without needing to ask server?
> > > > >=20
> > > > > But that is not the case today because you can't track the
> > > > > "completeness" of a READDIRPLUS result for a directory over time =
(in
> > > > > page cache)? Or is it all due to needing to deal with case
> > > > > insensitive
> > > > > filesystems (which I would think effects positive lookups too)?
> > > > >=20
> > > > > I did try to decipher the v6.6 fs/nfs/dir.c READDIR bits but I
> > > > > quickly
> > > > > got lost...
> > > > >=20
> > > > > Cheers,
> > > > >=20
> > > > > Daire
> > > >=20
> > > > If the question is whether the client trusts that a READDIR call to=
 the
> > > > server returns all the names that can be successfully looked up, th=
en
> > > > the answer is "no".
> > > > It's not even a question of case sensitivity. There are plenty of
> > > > servers out there that will allow you to look up names that won't e=
ver
> > > > appear in the results of a READDIR (or READDIRPLUS) call. Having a
> > > > hidden ".snapshot" directory is, for instance, a popular way to pre=
sent
> > > > snapshots.
> > > >=20
> > > > So no, we're not ever going to implement any negative dentry cache
> > > > scheme that relies on READDIR/READDIRPLUS.
> > > > --
> > > > Trond Myklebust
> > > > Linux NFS client maintainer, Hammerspace
> > > > trond.myklebust@hammerspace.com
> > > >=20
> > > >=20
> > >=20
> >=20
> > --
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

