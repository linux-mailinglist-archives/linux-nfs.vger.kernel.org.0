Return-Path: <linux-nfs+bounces-11889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485FAC2C14
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 01:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034C91889DC6
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 23:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417E1F584C;
	Fri, 23 May 2025 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+xetKiU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1022AD2D
	for <linux-nfs@vger.kernel.org>; Fri, 23 May 2025 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041770; cv=none; b=LetHvYIkTB2AAq4BP+gfauNPbrNHVIoxmmf4SNrVlrnhfhaVu5mPG4F0sKh0wA0kRa918c+1xaf4j+cR9R3zHYB8InRoqUeM/vkKgXerJWSNMLaFgRtdzFTJxdE/ND/rL/DrelPOaghtuvrxoZA05to62bKgnIfdJyvc2UZObCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041770; c=relaxed/simple;
	bh=nFKNYQjbOO8zSV448A4OuvJplJ4elLzUI6GhwuVDylY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTCwXbW4L+50LoOHH5+ebSFdJwL6OFpXjT8rzl2RYtfe4ltG4ynVThEue9K1p9MWb1Ou0KcHJaywBip7XExkbr/uwo5kM/84WCX6YcYIexqnGZtL2mfLyHDez/76oqX5Dt35aCYNAojpk8Q0vLdAU50YmrrUfw7ZlB5yzqCBGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+xetKiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B99C4CEE9;
	Fri, 23 May 2025 23:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748041769;
	bh=nFKNYQjbOO8zSV448A4OuvJplJ4elLzUI6GhwuVDylY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+xetKiUri7CFNtFf2t3Zi/rAnPARk4hDzP99+3y6qFYJsMYAWaZa8Ca9bM61HQms
	 69n5jE/jT3UhtVxJAePyvfjnu0g+Htx6WpGLZ1boKQb6TzJJG3BQDGUAoWuMEHGCJr
	 MkBG7EukOgwBrc3Zhd7vkjNJjpu9712BYC5IfTYSpvtgvW8h4MSkfucbMJ7uKFqdiz
	 4C+Ohc0pFWu5xIAzKrC9t5/5ynSTrTRDiqRV8T2rw/YgMr9XuTdNtUJZmm/Z6WEwbU
	 okMrEx+JeNQVJdI2ng1LiUNo0Tmc3u5Bz7gjvUK8OBWxpGwWB4dUHezmTkGditKNvQ
	 anFQFM0VqaRSw==
Date: Fri, 23 May 2025 19:09:27 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	linux-nfs@vger.kernel.org
Subject: Re: unable to run NFSD in container if "options sunrpc
 pool_mode=pernode"
Message-ID: <aDEAJzELBTH0CqHI@kernel.org>
References: <aDC-ftnzhJAlwqwh@kernel.org>
 <f93f70ce429f2dd6d11f6900808fc4ab737f765f.camel@kernel.org>
 <aDD0VxdSk0O6LdFG@kernel.org>
 <6bb9e9cce27e2a222bf55e272d690aab8f0eef13.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb9e9cce27e2a222bf55e272d690aab8f0eef13.camel@kernel.org>

On Fri, May 23, 2025 at 06:40:45PM -0400, Jeff Layton wrote:
> On Fri, 2025-05-23 at 18:19 -0400, Mike Snitzer wrote:
> > On Fri, May 23, 2025 at 02:40:17PM -0400, Jeff Layton wrote:
> > > On Fri, 2025-05-23 at 14:29 -0400, Mike Snitzer wrote:
> > > > I don't know if $SUBJECT ever worked... but with latest 6.15 or
> > > > nfsd-testing if I just use pool_mode=global then all is fine.
> > > > 
> > > > If pool_mode=pernode then mounting the container's NFSv3 export fails.
> > > > 
> > > > I haven't started to dig into code yet but pool_mode=pernode works
> > > > perfectly fine if NFSD isn't running in a container.
> > > > 
> 
> Oops, I went and looked and nfsd isn't running in a container on these
> boxes. There are some other containerized apps running on the box, but
> nfsd isn't running in a container.

OK.

> > > > ps. yet another reason why pool_mode=pernode should be the default if
> > > > more than 1 NUMA node ;)
> > > 
> > > Huh, strange. I've no idea why that would be. What kernel is this?
> > 
> > It is this 6.12.24 based frankenbeast-ish kernel:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.24/main-testing
> > 
> > Basically just 6.12.24 + NFS and NFSD sync'd through nfs-testing and
> > nfsd-testing (so 6.15 NFS and NFSD going on 6.16).
> > 
> > But I also just verified that this kernel built on Chuck's
> > nfsd-testing branch (with 2 extra patches) has the same issue:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=cel-nfsd-testing-6.16
> > 
> > Here is the NFS related config:
> > 
> > CONFIG_NETWORK_FILESYSTEMS=y
> > CONFIG_NFS_FS=m
> > # CONFIG_NFS_V2 is not set
> > CONFIG_NFS_V3=m
> > CONFIG_NFS_V3_ACL=y
> > CONFIG_NFS_V4=m
> > # CONFIG_NFS_SWAP is not set
> > CONFIG_NFS_V4_1=y
> > CONFIG_NFS_V4_2=y
> > CONFIG_PNFS_FILE_LAYOUT=m
> > CONFIG_PNFS_BLOCK=m
> > CONFIG_PNFS_FLEXFILE_LAYOUT=m
> > CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> > # CONFIG_NFS_V4_1_MIGRATION is not set
> > CONFIG_NFS_V4_SECURITY_LABEL=y
> > CONFIG_NFS_FSCACHE=y
> > # CONFIG_NFS_USE_LEGACY_DNS is not set
> > CONFIG_NFS_USE_KERNEL_DNS=y
> > CONFIG_NFS_DEBUG=y
> > CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> > # CONFIG_NFS_V4_2_READ_PLUS is not set
> > CONFIG_NFSD=m
> > # CONFIG_NFSD_V2 is not set
> > CONFIG_NFSD_V3_ACL=y
> > CONFIG_NFSD_V4=y
> > CONFIG_NFSD_PNFS=y
> > # CONFIG_NFSD_BLOCKLAYOUT is not set
> > CONFIG_NFSD_SCSILAYOUT=y
> > # CONFIG_NFSD_FLEXFILELAYOUT is not set
> > # CONFIG_NFSD_V4_2_INTER_SSC is not set
> > CONFIG_NFSD_V4_SECURITY_LABEL=y
> > # CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set
> > # CONFIG_NFSD_V4_DELEG_TIMESTAMPS is not set
> > CONFIG_GRACE_PERIOD=m
> > CONFIG_LOCKD=m
> > CONFIG_LOCKD_V4=y
> > CONFIG_NFS_ACL_SUPPORT=m
> > CONFIG_NFS_COMMON=y
> > CONFIG_NFS_COMMON_LOCALIO_SUPPORT=m
> > CONFIG_NFS_LOCALIO=y
> > CONFIG_NFS_V4_2_SSC_HELPER=y
> > CONFIG_SUNRPC=m
> > CONFIG_SUNRPC_GSS=m
> > CONFIG_SUNRPC_BACKCHANNEL=y
> > CONFIG_RPCSEC_GSS_KRB5=m
> > CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
> > CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=y
> > CONFIG_SUNRPC_DEBUG=y
> > CONFIG_SUNRPC_XPRT_RDMA=m
> > 
> > > FWIW, I just built a localio-enabled on a v6.12-uek kernel for our own
> > > purposes yesterday and it's running pool_mode=pernode. It seemed to
> > > work fine as a v3 DS, but I didn't test mounting the container's export
> > > directly.
> > 
> > OK, but you were able to access the v3 DS just fine (assuming pNFS
> > flexfiles layouts that point to your DS that is running NFSD in a
> > container) ?
> > 
> > I'm using nfs-utils-2.8.2.  I don't see any nfsd threads running if I
> > use "options sunrpc pool_mode=pernode".
> > 
> 
> I'll have a look soon, but if you figure it out in the meantime, let us
> know.

Will do.

Just the latest info I have, with sunrpc's pool_mode=pernode dd hangs
with this stack trace:

# cat /proc/8087/stack
[<0>] rpc_wait_bit_killable+0x25/0x80 [sunrpc]
[<0>] __rpc_execute+0x151/0x480 [sunrpc]
[<0>] rpc_execute+0xca/0xf0 [sunrpc]
[<0>] rpc_run_task+0x110/0x180 [sunrpc]
[<0>] nfs4_call_sync_custom+0xb/0x30 [nfsv4]
[<0>] nfs4_do_call_sync+0x69/0x90 [nfsv4]
[<0>] _nfs4_proc_getattr+0x128/0x160 [nfsv4]
[<0>] nfs4_proc_getattr+0x73/0x100 [nfsv4]
[<0>] nfs4_do_open+0x775/0x9d0 [nfsv4]
[<0>] nfs4_atomic_open+0xf7/0x100 [nfsv4]
[<0>] nfs_atomic_open+0x1e7/0x6c0 [nfs]
[<0>] path_openat+0xd38/0x11f0
[<0>] do_filp_open+0xae/0x120
[<0>] do_sys_openat2+0x24d/0x2a0
[<0>] do_sys_open+0x4f/0x90
[<0>] do_syscall_64+0x7b/0x160
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

And if I just try to mount using v3 it fails with:

# mount -vvvvvvv -o vers=3,nolock 10.200.80.89:/cvol_12_0 /mnt/test
mount.nfs: timeout set for Fri May 23 22:52:04 2025
mount.nfs: trying text-based options 'vers=3,nolock,addr=10.200.80.89'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: trying 10.200.80.89 prog 100003 vers 3 prot TCP port 2049
mount.nfs: portmap query retrying: RPC: Timed out
mount.nfs: prog 100003, trying vers=3, prot=17
mount.nfs: portmap query failed: RPC: Program not registered
mount.nfs: trying text-based options 'vers=3,nolock,addr=10.200.80.89'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: trying 10.200.80.89 prog 100003 vers 3 prot TCP port 2049
mount.nfs: portmap query retrying: RPC: Timed out
mount.nfs: prog 100003, trying vers=3, prot=17
mount.nfs: portmap query failed: RPC: Program not registered
mount.nfs: trying text-based options 'vers=3,nolock,addr=10.200.80.89'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: trying 10.200.80.89 prog 100003 vers 3 prot TCP port 2049
mount.nfs: portmap query retrying: RPC: Timed out
mount.nfs: prog 100003, trying vers=3, prot=17
mount.nfs: portmap query failed: RPC: Program not registered
mount.nfs: requested NFS version or transport protocol is not supported for /mnt/test

# rpcinfo -p 10.200.80.89
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100005    1   udp  20048  mountd
    100005    1   tcp  20048  mountd
    100005    2   udp  20048  mountd
    100005    2   tcp  20048  mountd
    100024    1   udp  45252  status
    100024    1   tcp  60557  status
    100005    3   udp  20048  mountd
    100005    3   tcp  20048  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100021    1   udp  40987  nlockmgr
    100021    3   udp  40987  nlockmgr
    100021    4   udp  40987  nlockmgr
    100021    1   tcp  36527  nlockmgr
    100021    3   tcp  36527  nlockmgr
    100021    4   tcp  36527  nlockmgr

(Not sure what's up with portmap issues and it not progressing to
trying program 100005.. which as you can see below it does)

But if I just use sunrpc's default pool_mode=global:

# mount -vvvvvvv -o vers=3,nolock 10.200.80.89:/cvol_12_0 /mnt/test
mount.nfs: timeout set for Fri May 23 22:55:43 2025
mount.nfs: trying text-based options 'vers=3,nolock,addr=10.200.80.89'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: trying 10.200.80.89 prog 100003 vers 3 prot TCP port 2049
mount.nfs: prog 100005, trying vers=3, prot=17
mount.nfs: trying 10.200.80.89 prog 100005 vers 3 prot UDP port 20048

# rpcinfo -p 10.200.80.89
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100024    1   udp  54037  status
    100024    1   tcp  46339  status
    100005    1   udp  20048  mountd
    100005    1   tcp  20048  mountd
    100005    2   udp  20048  mountd
    100005    2   tcp  20048  mountd
    100005    3   udp  20048  mountd
    100005    3   tcp  20048  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100021    1   udp  36268  nlockmgr
    100021    3   udp  36268  nlockmgr
    100021    4   udp  36268  nlockmgr
    100021    1   tcp  44195  nlockmgr
    100021    3   tcp  44195  nlockmgr
    100021    4   tcp  44195  nlockmgr

