Return-Path: <linux-nfs+bounces-7887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51FA9C4A89
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3B02811A6
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129FF7082D;
	Tue, 12 Nov 2024 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C20ghNPZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94006F30C
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370611; cv=none; b=DbXcMXi82K03lPMUr5CunOZttCK6xXQ22XleEpDqxVG2J/LT4MPOFga5xFodv2L1Ns30M9AYk13ckAmmVi42/2Bh2HYSA2MSGRW8V92LTeoUyVs/xeLb/65Zv/lqLct9ePEiBu8FmUuje38dL7vuoTxirGe+Odv6bJApn/xaowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370611; c=relaxed/simple;
	bh=DbE0wK6fsKZsuYrBB+nmqqxn4kpwUtx9fQOwAD7XyV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXXSSASnEv28qaxoku0RHP8czr3YgIOp1NlVeSXzfTBojF5SeDjYO570M9w5p93HLsAGYbvoOT7futQxHtVnAV1qwhham5Eg7bLVp1lDhOXgGxm6WpqW7Fhof7CCoh4GwqYemJ4grT3Vr/TaGYvxhVQmgaSUwv2QVhwQNRCK8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C20ghNPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5118BC4CED7;
	Tue, 12 Nov 2024 00:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731370611;
	bh=DbE0wK6fsKZsuYrBB+nmqqxn4kpwUtx9fQOwAD7XyV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C20ghNPZcLoCcrns9MfaqKIx+LmmNVekm3QOD/LtWdUjGANZ9u1yzflqtDWQk0s53
	 Zm+MRX71v0A/YiNmrAo2es+fpUHXV3afqJrHGiJoHCMONXIknVKgC9KH0fdt3RVcfv
	 Jw+xaktXBqLmtBfm2aYuRW2NlDROMgd7imgmybxT9C48e3U9jp/wQomZqh51u0/bLR
	 Ageg5Z6tpHMIya9Kov16Q3/zElHqAp9CzKBkhqeCP4bjCdCNlwjM8B5zO8j6QZnYBC
	 mLK1nuvb1uNOeZ/y2G91vluzc8fILJJVurPLkutwhl8SIqDloZkBlALqman3KgChc4
	 mJ9Huv5g+ZyyA==
Date: Mon, 11 Nov 2024 19:16:50 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
Message-ID: <ZzKeciwU6n4R9VgX@kernel.org>
References: <>
 <ZzKE6aQyEKiIgMLG@kernel.org>
 <173136739945.1734440.14539377225286667908@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173136739945.1734440.14539377225286667908@noble.neil.brown.name>

On Tue, Nov 12, 2024 at 10:23:19AM +1100, NeilBrown wrote:
> On Tue, 12 Nov 2024, Mike Snitzer wrote:
> > On Tue, Nov 12, 2024 at 07:35:04AM +1100, NeilBrown wrote:
> > > 
> > > I don't like NFS_CS_LOCAL_IO_CAPABLE.
> > > A use case that I imagine (and a customer does something like this) is an
> > > HA cluster where the NFS server can move from one node to another.  All
> > > the node access the filesystem, most over NFS.  If a server-migration
> > > happens (e.g.  the current server node failed) then the new server node
> > > would suddenly become LOCALIO-capable even though it wasn't at
> > > mount-time.  I would like it to be able to detect this and start doing
> > > localio.
> > 
> > Server migration while retaining the client being local to the new
> > server?  So client migrates too?
> 
> No.  Client doesn't migrate.  Server migrates and appears on the same
> host as the client.  The client can suddenly get better performance.  It
> should benefit from that.
> 
> > 
> > If the client migrates then it will negotiate with server using
> > LOCALIO protocol.
> > 
> > Anyway, this HA hypothetical feels contrived.  It is fine that you
> > dislike NFS_CS_LOCAL_IO_CAPABLE but I don't understand what you'd like
> > as an alternative.  Or why the simplicity in my approach lacking.
> 
> We have customers with exactly this HA config.  This is why I put work
> into make sure loop-back NFS (client and server on same node) works
> cleanly without memory allocation deadlocks.
>   https://lwn.net/Articles/595652/
> Getting localio in that config would be even better.
> 
> Your approach assumes that if LOCALIO isn't detected at mount time, it
> will never been available.  I think that is a flawed assumption.

That's fair, I agree your HA scenario is valid.  It was terse as
initially presented but I understand now, thanks.

> > > So I don't want NFS_CS_LOCAL_IO_CAPABLE.  I think tracking when the
> > > network connection is re-established is sufficient.
> > 
> > Eh, that type of tracking doesn't really buy me anything if I've lost
> > context (that LOCALIO was previously established and should be
> > re-established).
> > 
> > NFS v3 is stateless, hence my hooking off read and write paths to
> > trigger nfs_local_probe_async().  Unlike NFS v4, with its grace, more
> > care is needed to avoid needless calls to nfs_local_probe_async().
> 
> I think it makes perfect sense to trigger the probe on a successful
> read/write with some rate limiting to avoid sending a LOCALIO probe on
> EVERY read/write.  Your rate-limiting for NFSv3 is:
>    - never probe if the mount-time probe was not successful
>    - otherwise probe once every 256 IO requests.
> 
> I think the first is too restrictive, and the second is unnecessarily
> frequent.
> I propose:
>    - probe once each time the client reconnects with the server
> 
> This will result in many fewer probes in practice, but any successful
> probe will happen at nearly the earliest possible moment.

I'm all for what you're proposing (its what I wanted from the start).
In practice I just don't quite grok the client reconnect awareness
implementation you're saying is at our finger tips.

> > Your previous email about just tracking network connection change was
> > an optimization for avoiding repeat (pointless) probes.  We still
> > need to know to do the probe to begin with.  Are you saying you want
> > to backfill the equivalent of grace (or pseudo-grace) to NFSv3?
> 
> You don't "know to do the probe" at mount time.  You simply always do
> it.  Similarly whenever localio isn't active it is always appropriate to
> probe - with rate limiting.
> 
> And NFSv3 already has a grace period - in the NLM/STAT protocols.  We
> could use STAT to detect when the server has restarted and so it is worth
> probing again.  But STAT is not as reliable as we might like and it
> would be more complexity with no real gain.

If you have a specific idea for the mechanism we need to create to
detect the v3 client reconnects to the server please let me know.
Reusing or augmenting an existing thing is fine by me.
 
> I would be happy to use exactly the same mechanism for both v3 and v4:
> send a probe after IO on a new connection.  But your solution for v4 is
> simple and elegant so I'm not at all against it.
> 
> > 
> > My approach works.  Not following what you are saying will be better.
> 
>  - server-migration can benefit from localio on the new host
>  - many fewer probes
>  - probes are much more timely.

Ha, you misunderstood me: I know the benefits.. what eludes me is the
construction of the point to probe (reliable v3 client reconnect
awareness). ;)

Mike

