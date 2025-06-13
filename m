Return-Path: <linux-nfs+bounces-12438-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B1AD8C2C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 14:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C4F3B4DA1
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490610F9;
	Fri, 13 Jun 2025 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH+R4TPh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BD10E9
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817969; cv=none; b=JmCre8rD784v1VGuQDUUoL1TsRaDQyy0DmScMB9HY7KKI+pA8xjgUGXks2emVZDw+YH0QRNVNOkRD6vH+4r2q9n5l31hab1eoHm5irCGC6+2aCoqxne9AqDQwgGnzhRaSwWgec99DkUgoEwA5q0wP6ewOk2RaeIL63M6EFx9Ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817969; c=relaxed/simple;
	bh=Y7stRnCMPkgguDzOdN652geU6LWdLukinjicF/QbR4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VsAy1BBXSul/ogda+CtN5sjrTr/YYEIinsmLRRsuZkPFEbiMQRZv/X3WeFBMmHy9hX4Mh5k3X9DXzskvv1tD/YB6Ld/E4HfSA4F1jplCWzOH/Is6CspqP5Za+xgT/bUxiOpiHOmi9FxAYBSvUtHsDxXZY6XpX9UARttLG6M2iY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH+R4TPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5ECC4CEE3;
	Fri, 13 Jun 2025 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749817968;
	bh=Y7stRnCMPkgguDzOdN652geU6LWdLukinjicF/QbR4Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SH+R4TPhCVbMqH0cMoj1BCmYuHqpSfOGNFjaqNCWMb0N4Hgn7tBrqxnL49mCCHTBJ
	 Rj0TdPySYIMi2lSTEoI3TVUgD7q3ONuPYqThRb5xhrofobaT4rL5k+cPAieRpjOkis
	 sMU3fY1crONdXF6nSxWtG8K56XKOf3xXXcYvZ4D9D+pF0hjZ/YpVopzfzGhCFUpkA7
	 Qe+HUq9v4kXvehORXWbjzXaBM7vFF3tzKWj+mpC4grTQ0G9DN5+3MVtAvc0ZkLwsLo
	 8sfjwXfIplAEzsLtXDhpBeC4Am7nChASOfRzhi98kFkr5tGb/RZyeQZ5qXorHwmByf
	 S/tLY45yFi7MQ==
Message-ID: <d1bd6ba1c4a6e603fd47eec0a2e1c071abeaa2ba.camel@kernel.org>
Subject: Re: unable to run NFSD in container if "options sunrpc
 pool_mode=pernode"
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: steved@redhat.com, Chuck Lever <chuck.lever@oracle.com>, NeilBrown
	 <neil@brown.name>, linux-nfs@vger.kernel.org
Date: Fri, 13 Jun 2025 08:32:47 -0400
In-Reply-To: <aDHYtTJxeAr5FDRK@kernel.org>
References: <aDC-ftnzhJAlwqwh@kernel.org>
	 <f93f70ce429f2dd6d11f6900808fc4ab737f765f.camel@kernel.org>
	 <aDD0VxdSk0O6LdFG@kernel.org>
	 <6bb9e9cce27e2a222bf55e272d690aab8f0eef13.camel@kernel.org>
	 <aDEAJzELBTH0CqHI@kernel.org> <aDFCuXj2JBQuv-Yd@kernel.org>
	 <73c6caaa51804da9ae850ee65b6ab51640706d74.camel@kernel.org>
	 <aDHYtTJxeAr5FDRK@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-05-24 at 10:33 -0400, Mike Snitzer wrote:
> On Sat, May 24, 2025 at 08:05:19AM -0400, Jeff Layton wrote:
> > On Fri, 2025-05-23 at 23:53 -0400, Mike Snitzer wrote:
> > > On Fri, May 23, 2025 at 07:09:27PM -0400, Mike Snitzer wrote:
> > > > On Fri, May 23, 2025 at 06:40:45PM -0400, Jeff Layton wrote:
> > > > > On Fri, 2025-05-23 at 18:19 -0400, Mike Snitzer wrote:
> > > > > > On Fri, May 23, 2025 at 02:40:17PM -0400, Jeff Layton wrote:
> > > > > > > On Fri, 2025-05-23 at 14:29 -0400, Mike Snitzer wrote:
> > > > > > > > I don't know if $SUBJECT ever worked... but with latest 6.1=
5 or
> > > > > > > > nfsd-testing if I just use pool_mode=3Dglobal then all is f=
ine.
> > > > > > > >=20
> > > > > > > > If pool_mode=3Dpernode then mounting the container's NFSv3 =
export fails.
> > > > > > > >=20
> > > > > > > > I haven't started to dig into code yet but pool_mode=3Dpern=
ode works
> > > > > > > > perfectly fine if NFSD isn't running in a container.
> > > > > > > >=20
> > > > >=20
> > > > > Oops, I went and looked and nfsd isn't running in a container on =
these
> > > > > boxes. There are some other containerized apps running on the box=
, but
> > > > > nfsd isn't running in a container.
> > > >=20
> > > > OK.
> > > >=20
> > > > > > I'm using nfs-utils-2.8.2.  I don't see any nfsd threads runnin=
g if I
> > > > > > use "options sunrpc pool_mode=3Dpernode".
> > > > > >=20
> > > > >=20
> > > > > I'll have a look soon, but if you figure it out in the meantime, =
let us
> > > > > know.
> > > >=20
> > > > Will do.
> > > >=20
> > > > Just the latest info I have, with sunrpc's pool_mode=3Dpernode dd h=
angs
> > > > with this stack trace:
> > >=20
> > > Turns out this pool_mode=3Dpernode issue is a regression caused by th=
e
> > > very recent nfs-utils 2.8.2 (I rebuilt EL10's nfs-utils package,
> > > because why not upgrade to the latest!?).
> > >=20
> > > If I use EL9.5's latest nfs-utils-2.5.4-37.el8.x86_64 then sunrpc's
> > > pool_mode=3Dpernode works fine.
> > >=20
> > > And this issue doesn't have anything to do with running in a containe=
r
> > > (it seemed to be container related purely because I happened to be
> > > seeing the issue with an EL9.5 container that had the EL10-based
> > > nfs-utils 2.8.2 installed).
> > >=20
> > > Steved, unfortunately I'm not sure what the problem is with the newer
> > > nfs-utils and setting "options sunrpc pool_mode=3Dpernode"
> > >=20
> >=20
> > I tried to reproduce this using fedora-41 VMs (no f42 available for
> > virt-builder yet), but everything worked. I don't have any actual NUMA
> > hw here though, so maybe that matters?
> >=20
> > Can you run this on the nfs server and send back the output? I'm
> > wondering if this setting might not track the module option properly on
> > that host for some reason:
> >=20
> >     # nfsdctl pool-mode
>=20
> (from EL9.5 container with nfs-utils 2.8.2)
> # nfsdctl pool-mode
> pool-mode: pernode
> npools: 2
>=20
> (on host)
> # numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 11665 MB
> node 0 free: 9892 MB
> node 1 cpus: 8 9 10 11 12 13 14 15
> node 1 size: 6042 MB
> node 1 free: 5127 MB
> node distances:
> node   0   1
>   0:  10  20
>   1:  20  10
>=20
> (and yeahh I was aware the newer nfs-utils uses the netlink interface,
> will be interesting to pin down what the issue is with
> pool-mode=3Dpernode)

Hi Mike,

I submitted a patch for this a couple of weeks ago:

    https://lore.kernel.org/linux-nfs/20250527-rpc-numa-v1-1-fa1d98e9a900@k=
ernel.org/

Were you able to test it, and did it fix your issue?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>

