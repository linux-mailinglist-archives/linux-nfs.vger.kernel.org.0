Return-Path: <linux-nfs+bounces-10588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B38A5F6B4
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 14:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E2117EBC0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C25267B9B;
	Thu, 13 Mar 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNFd9PbY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C4267B72;
	Thu, 13 Mar 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873923; cv=none; b=g/EfHNk/J/HGIOn/6unDz+5+R0t85qcf+omCdpFdfrU19ryH7G4e/eNDxOVd7wQay91w5iE05hGb6HWjOp/OOr9zmWl1AuKA3rVn9TtcXNIsNzbwTzwS5N2b2AwGIJnAkljT0Yx+E5+FD+5wRwLkUQnXYE/nURvRo+nVuUV6kLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873923; c=relaxed/simple;
	bh=xoyDodBFvNvmguT9IBaqx5WxLExGYaUZYbOSWw3WeAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqZjVBTvAipbhOwrtnk60aXPk0VkJyeGyAubHbmzt2c2uZUOmGjIk6UN0U1D7xysBikv+bmIkCFrYEEEZ6Cw8AbMIZNJ3PBRDGBirFOIyRneeMujluoG8iKhKLiyLSd6ojF0rMqkHErA0U0qA7UIkpxK/0wgRjTHiOd5CdKeWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNFd9PbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7502C4CEE5;
	Thu, 13 Mar 2025 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873923;
	bh=xoyDodBFvNvmguT9IBaqx5WxLExGYaUZYbOSWw3WeAM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fNFd9PbYSlwvHXAweFPAWZH/AlJ7aS+fI5fv019D2PSu/qe+5Im8XZ3K2gEW1dkQI
	 7fs5toLr7n0RzbFWto2De6njD2bAWxSlDFJBz3BvUgdK3As5ealFp5C0gJVqd4ud/9
	 Yx5jrIZ0SK7kBq1aqJWG30HIbgmBJo5rHSsnBdUWLc0vqJ9l7gG+1qRbHVaEb3uEW8
	 xmH3BatLLr03NnoI3hMESgXZj4tQ+v2ONnWLtqKHP6pEk1cDCb3Ge5oER8daaHjoL9
	 DyJhJR6Fzd5FF0PsTnX1eyYD05+3cypQ4P4FuCUheVFqaVHjuqnZeFW0y1gbankVY6
	 tdeiZAvDBQNxA==
Message-ID: <e85ca4e841b8e5c5f7d0408caf99f404284da687.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: add a rpc_clnt shutdown control in debugfs
From: Jeff Layton <jlayton@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2025 09:52:01 -0400
In-Reply-To: <0E1E14E2-BD4B-433B-8355-EEF45384BE83@redhat.com>
References: <20250312-rpc-shutdown-v1-1-cc90d79a71c2@kernel.org>
	 <7906109F-91D2-4ECF-B868-5519B56D2CEE@redhat.com>
	 <997f992f951bd235953c5f0e2959da6351a65adb.camel@kernel.org>
	 <8bf55a6fb64ba9e21a1ec8c5644355ffd6496c6e.camel@hammerspace.com>
	 <ee74d5920532d81f77e503d6ef8bc5fbfc66d04e.camel@kernel.org>
	 <0E1E14E2-BD4B-433B-8355-EEF45384BE83@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-13 at 09:35 -0400, Benjamin Coddington wrote:
> On 13 Mar 2025, at 9:15, Jeff Layton wrote:
>=20
> > On Wed, 2025-03-12 at 22:31 +0000, Trond Myklebust wrote:
> > > On Wed, 2025-03-12 at 10:37 -0400, Jeff Layton wrote:
> > > > On Wed, 2025-03-12 at 09:52 -0400, Benjamin Coddington wrote:
> > > > > On 12 Mar 2025, at 9:36, Jeff Layton wrote:
> > > > >=20
> > > > > > There have been confirmed reports where a container with an NFS
> > > > > > mount
> > > > > > inside it dies abruptly, along with all of its processes, but t=
he
> > > > > > NFS
> > > > > > client sticks around and keeps trying to send RPCs after the
> > > > > > networking
> > > > > > is gone.
> > > > > >=20
> > > > > > We have a reproducer where if we SIGKILL a container with an NF=
S
> > > > > > mount,
> > > > > > the RPC clients will stick around indefinitely. The orchestrato=
r
> > > > > > does a MNT_DETACH unmount on the NFS mount, and then tears down
> > > > > > the
> > > > > > networking while there are still RPCs in flight.
> > > > > >=20
> > > > > > Recently new controls were added[1] that allow shutting down an
> > > > > > NFS
> > > > > > mount. That doesn't help here since the mount namespace is
> > > > > > detached from
> > > > > > any tasks at this point.
> > > > >=20
> > > > > That's interesting - seems like the orchestrator could just reord=
er
> > > > > its
> > > > > request to shutdown before detaching the mount namespace.=C2=A0 N=
ot an
> > > > > objection,
> > > > > just wondering why the MNT_DETACH must come first.
> > > > >=20
> > > >=20
> > > > The reproducer we have is to systemd-nspawn a container, mount up a=
n
> > > > NFS mount inside it, start some I/O on it with fio and then kill -9
> > > > the
> > > > systemd running inside the container. There isn't much the
> > > > orchestrator
> > > > (root-level systemd) can do to at that point other than clean up
> > > > what's
> > > > left.
> > > >=20
> > > > I'm still working on a way to reliably detect when this has happene=
d.
> > > > For now, we just have to notice that some clients aren't dying.
> > > >=20
> > > > > > Transplant shutdown_client() to the sunrpc module, and give it =
a
> > > > > > more
> > > > > > distinct name. Add a new debugfs sunrpc/rpc_clnt/*/shutdown kno=
b
> > > > > > that
> > > > > > allows the same functionality as the one in /sys/fs/nfs, but at
> > > > > > the
> > > > > > rpc_clnt level.
> > > > > >=20
> > > > > > [1]: commit d9615d166c7e ("NFS: add sysfs shutdown knob").
> > > > > >=20
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > >=20
> > > > > I have a TODO to patch Documentation/ for this knob mostly to wri=
te
> > > > > warnings
> > > > > because there are some potential "gotchas" here - for example you
> > > > > can have
> > > > > shared RPC clients and shutting down one of those can cause
> > > > > problems for a
> > > > > different mount (this is true today with the
> > > > > /sys/fs/nfs/[bdi]/shutdown
> > > > > knob).=C2=A0 Shutting down aribitrary clients will definitely bre=
ak
> > > > > things in
> > > > > weird ways, its not a safe place to explore.
> > > > >=20
> > > >=20
> > > > Yes, you really do need to know what you're doing. 0200 permissions
> > > > are
> > > > essential for this file, IOW. Thanks for the R-b!
> > >=20
> > > Sorry, but NACK! We should not be adding control mechanisms to debugf=
s.
> > >=20
> >=20
> > Ok. Would adding sunrpc controls under sysfs be more acceptable? I do
> > agree that this is a potential footgun, however. It would be nicer to
> > clean this situation up automagically.
> >=20
> > > One thing that might work in situations like this is perhaps to make
> > > use of the fact that we are monitoring whether or not rpc_pipefs is
> > > mounted. So if the mount is containerised, and the orchestrator
> > > unmounts everything, including rpc_pipefs, we might take that as a hi=
nt
> > > that we should treat any future connection errors as being fatal.
> > >=20
> >=20
> > rpc_pipefs isn't being mounted at all in the container I'm using. I
> > think that's not going to be a reliable test for this.
> >=20
> > > Otherwise, we'd have to be able to monitor the root task, and check i=
f
> > > it is still alive in order to figure out if out containerised world h=
as
> > > collapsed.
> > >=20
> >=20
> > If by the root task, you mean the initial task in the container, then
> > that method seems a little sketchy too. How would we determine that
> > from the RPC layer?
> >=20
> > To be clear: the situation here is that we have a container with a veth
> > device that is communicating with the outside world. Once all of the
> > processes in the container exit, the veth device in the container
> > disappears. The rpc_xprt holds a ref on the netns though, so that
> > sticks around trying to retransmit indefinitely.
> >=20
> > I think what we really need is a lightweight reference on the netns.
> > Something where we can tell that there are no userland tasks that care
> > about it anymore, so we can be more aggressive about giving up on it.
> >=20
> > There is a "passive" refcount inside struct net, but that's not quite
> > what we need as it won't keep the sunrpc_net in place.
> >=20
> > What if instead of holding a netns reference in the xprt, we have it
> > hold a reference on a new refcount_t that lives in sunrpc_net? Then, we
> > add a pre_exit pernet_ops callback that does a shutdown_client() on all
> > of the rpc_clnt's attached to the xprts in that netns. The pre_exit can
> > then just block until the sunrpc_net refcount goes to 0.
> >=20
> > I think that would allow everything to be cleaned up properly?
>=20
> Do you think that might create unwanted behaviors for a netns that might
> still be repairable?   Maybe that doesn't make a lot of sense if there ar=
e no
> processes in it, but I imagine a network namespace could be in this state
> and we'd still want to try to use it.
>=20

I don't think so. Once there are no userland tasks holding a reference
to a namespace, there is no way to reach it from outside the kernel,
AFAICT, so there is no way repair it.

It would actually be nice if we had a way to say "open net namespace
with this inode number". I guess we could add filehandle and
open_by_handle_at() support to nsfs...

> which, if used, creates an explicit requirement for the orchestrator to
> define exactly what should happen if the veth goes away.  When creating t=
he
> namespace, the orchestrator should insert a rule that says "when this vet=
h
> disappears, we shutdown this fs".
>
> Again, I'm not sure if that's even possible, but I'm willing to muck arou=
nd
> a bit and give it a try.
>=20

I'd really prefer to do something that "just works" with existing
userland applications, but if we have to do something like that, then
so be it.
--=20
Jeff Layton <jlayton@kernel.org>

