Return-Path: <linux-nfs+bounces-11887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842CFAC2BE8
	for <lists+linux-nfs@lfdr.de>; Sat, 24 May 2025 00:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484271658CE
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 22:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88F1EB1B4;
	Fri, 23 May 2025 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCIdN0Wv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79842DCBE6
	for <linux-nfs@vger.kernel.org>; Fri, 23 May 2025 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039941; cv=none; b=ry0tl873i2vrSln/8VsntiCn76eug8frH01BIDPC0wxIvKhiXibmhz0W9FtvexRoJGDmT8Hq8q8yMUNnQJ5msBPNJEH4jZHKoZYqAFblFN7wUnK2NIOZoRGBEoIkrXqg5S5s4vxg0AzWiLRoCRQGGAR7m7Wr7Q3tvyy8WZmtEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039941; c=relaxed/simple;
	bh=nigQY1fyJonPn/fPiLiJO1adFgSH58CyWCgeU6eszME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOlkibg6P1s8KZSWn5F4kh8wg0aDzvQqPRmL2mx81C9hSA6S1h2yxkDtFVLRwkbpL2fHlQERf0yIdB3185IYrxhs6NGKRuIfLxJl3PPDmcUF2v9aoC9waVJHwASFN4VBnUzuG8sNJbVt3za+C3XAuvaqBc37QqMTYZphTBNseOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCIdN0Wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB754C4CEE9;
	Fri, 23 May 2025 22:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748039941;
	bh=nigQY1fyJonPn/fPiLiJO1adFgSH58CyWCgeU6eszME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCIdN0WvtiSAlAiLFoRIdBb0rSCeS8QZtzl8arwzrBrAZGN3NCH0nkpFLnlJBFMDL
	 uzNGlWn64mF7VhrLa4+0f9dlURiEepwGq3r1X5h/2/aa5ZTxOLxGcZU9Aof3Rt9vU1
	 o6EQsLY2PJMpxEaR0m3LEqEMHyV+pf3sCKTd37JdJAfbjsT2LpqwjdePYB+Cs5Id5z
	 0qfBn+9aS3rvlZO8QuHN0DGs67vb9ooIYkf2q08tY8/C2sJX9rOz4WoJuovsqlSoG+
	 0Y+VnJw/1Mv3X62R0VYY7ny0XFVxmQaHmclVGe8ogG6K/R6PySXu6NGyxGX444xcgw
	 ht7o9CmzHtX4Q==
Date: Fri, 23 May 2025 18:38:59 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	linux-nfs@vger.kernel.org
Subject: Re: unable to run NFSD in container if "options sunrpc
 pool_mode=pernode"
Message-ID: <aDD5A9_vphMkBxjC@kernel.org>
References: <aDC-ftnzhJAlwqwh@kernel.org>
 <f93f70ce429f2dd6d11f6900808fc4ab737f765f.camel@kernel.org>
 <aDD0VxdSk0O6LdFG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDD0VxdSk0O6LdFG@kernel.org>

On Fri, May 23, 2025 at 06:19:03PM -0400, Mike Snitzer wrote:
> On Fri, May 23, 2025 at 02:40:17PM -0400, Jeff Layton wrote:
> > On Fri, 2025-05-23 at 14:29 -0400, Mike Snitzer wrote:
> > > I don't know if $SUBJECT ever worked... but with latest 6.15 or
> > > nfsd-testing if I just use pool_mode=global then all is fine.
> > > 
> > > If pool_mode=pernode then mounting the container's NFSv3 export fails.
> > > 
> > > I haven't started to dig into code yet but pool_mode=pernode works
> > > perfectly fine if NFSD isn't running in a container.
> > > 
> > > Mike
> > > 
> > > ps. yet another reason why pool_mode=pernode should be the default if
> > > more than 1 NUMA node ;)
> > 
> > Huh, strange. I've no idea why that would be. What kernel is this?
> 
> It is this 6.12.24 based frankenbeast-ish kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.24/main-testing
> 
> Basically just 6.12.24 + NFS and NFSD sync'd through nfs-testing and
> nfsd-testing (so 6.15 NFS and NFSD going on 6.16).
> 
> But I also just verified that this kernel built on Chuck's
> nfsd-testing branch (with 2 extra patches) has the same issue:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=cel-nfsd-testing-6.16
> 
> Here is the NFS related config:
> 
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=m
> # CONFIG_NFS_V2 is not set
> CONFIG_NFS_V3=m
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
> CONFIG_PNFS_FILE_LAYOUT=m
> CONFIG_PNFS_BLOCK=m
> CONFIG_PNFS_FLEXFILE_LAYOUT=m
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_V4_SECURITY_LABEL=y
> CONFIG_NFS_FSCACHE=y
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DEBUG=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFS_V4_2_READ_PLUS is not set
> CONFIG_NFSD=m
> # CONFIG_NFSD_V2 is not set
> CONFIG_NFSD_V3_ACL=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_PNFS=y
> # CONFIG_NFSD_BLOCKLAYOUT is not set
> CONFIG_NFSD_SCSILAYOUT=y
> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> # CONFIG_NFSD_V4_2_INTER_SSC is not set
> CONFIG_NFSD_V4_SECURITY_LABEL=y
> # CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set
> # CONFIG_NFSD_V4_DELEG_TIMESTAMPS is not set
> CONFIG_GRACE_PERIOD=m
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_ACL_SUPPORT=m
> CONFIG_NFS_COMMON=y
> CONFIG_NFS_COMMON_LOCALIO_SUPPORT=m
> CONFIG_NFS_LOCALIO=y
> CONFIG_NFS_V4_2_SSC_HELPER=y
> CONFIG_SUNRPC=m
> CONFIG_SUNRPC_GSS=m
> CONFIG_SUNRPC_BACKCHANNEL=y
> CONFIG_RPCSEC_GSS_KRB5=m
> CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
> CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=y
> CONFIG_SUNRPC_DEBUG=y
> CONFIG_SUNRPC_XPRT_RDMA=m
> 
> > FWIW, I just built a localio-enabled on a v6.12-uek kernel for our own
> > purposes yesterday and it's running pool_mode=pernode. It seemed to
> > work fine as a v3 DS, but I didn't test mounting the container's export
> > directly.
> 
> OK, but you were able to access the v3 DS just fine (assuming pNFS
> flexfiles layouts that point to your DS that is running NFSD in a
> container) ?
> 
> I'm using nfs-utils-2.8.2.  I don't see any nfsd threads running if I
> use "options sunrpc pool_mode=pernode".

Actually, I do see nfsd threads running.. just that if I try to issue
IO (using pNFS flexfiles to file on v3 DS) it hangs.

Mike

