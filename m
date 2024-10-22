Return-Path: <linux-nfs+bounces-7357-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E36EA9AB038
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 15:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8EAB21337
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B109188A0D;
	Tue, 22 Oct 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrOfYKRN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9F16A92E
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605453; cv=none; b=i8PbaKky0SBXhOzth83PDkcwc2+a9QfBK+wKClW8O7CxqHiONWgTvZczqO1+jgyPResxHwoQCIXsH/FTyPa0WMq6lPl04X4x1Rm2N3z/irWEZYoevjoDd7vpGkbai9QVXHeofvqq8TCdc31Tzb3T09Gwn2mFe94ZoGv2JUFvO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605453; c=relaxed/simple;
	bh=HjfYK+rCFKWb+9d+52YTcc7FBGyUM8HvGhKlIlVfgaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeshS6YEAiqh8VzVc2t8NEvQj37Gnkyy6HgMgt1excpq4ZCNKBx44RPjyRW3RQjAYHMP/q49/226tsQFNazj/MQIbGsu2EnjIpdbI38mejFCpd7UrnQ2xhXy7/qeVrlzxP7eRFqjFlClIEa25Lnm0fK/dU0d+JljOePVMErXHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrOfYKRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBB7C4CEC3;
	Tue, 22 Oct 2024 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729605453;
	bh=HjfYK+rCFKWb+9d+52YTcc7FBGyUM8HvGhKlIlVfgaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrOfYKRNmUsNKBehFojVQBMCPcMHuDN2QuOp4OCFSXGmwhu5KK3pNl4jDlOcx4kKF
	 qwgB+ezh9jYrzNHdmjy/k07bap0L14RlZVpn/B0hSWNFukRu5ODTrH+LbDCNDVBmOH
	 M4FfCISmVLvmihBxtAkhRdGSDbhGlhcrkEk3EAGIyHZ7qyncbszVFkBTSnYw8nBs05
	 eAkfxqHlaMSq4yxtliB7MFFNVJLw3HA4I4oVd1WLhe73yLgXvQ8imYZcMmXllEWbgs
	 tHhYYqUdz+eK6oGx1b65anevnp/9VqAp/XBf+Ny48IAN2QXP3TQHfM6GcAdZ0hR39A
	 NR1yCLybkNHKA==
Date: Tue, 22 Oct 2024 09:57:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Janpieter Sollie via Bugspray Bot <bugbot@kernel.org>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
	cel@kernel.org, jlayton@kernel.org
Subject: Re: link error while compiling localio.c
Message-ID: <ZxevSxHOBA7s5mUC@kernel.org>
References: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>

On Thu, Oct 10, 2024 at 07:35:10AM +0000, Janpieter Sollie via Bugspray Bot wrote:
> Janpieter Sollie added an attachment on Kernel.org Bugzilla:
> 
> Created attachment 306999
> kernel .config
> 
> tried both GCC and clang:
> Clang output:
> > ld.lld: error: undefined symbol: nfs_to
> > >>> referenced by localio.c:37 (fs/nfsd/localio.c:37)
> > >>>               vmlinux.o:(init_nfsd)
> > >>> referenced by localio.c:37 (/usr/src/linux/fs/nfsd/localio.c:37)
> > >>>               vmlinux.o:(nfsd_localio_ops_init)
> > 
> > ld.lld: error: undefined symbol: nfs_uuid_invalidate_clients
> > >>> referenced by nfsctl.c:2286 (/usr/src/linux/fs/nfsd/nfsctl.c:2286)
> > >>>               vmlinux.o:(nfsd_net_pre_exit)
> > 
> > ld.lld: error: undefined symbol: nfs_uuid_is_local
> > >>> referenced by localio.c:116 (/usr/src/linux/fs/nfsd/localio.c:116)
> > >>>               vmlinux.o:(localio_proc_uuid_is_local)
> GCC output:
> ld: fs/nfsd/nfsctl.o: in function `nfsd_net_pre_exit':
> nfsctl.c:(.text+0x122): undefined reference to `nfs_uuid_invalidate_clients'
> ld: fs/nfsd/localio.o: in function `localio_proc_uuid_is_local':
> /usr/src/linux/fs/nfsd/localio.c:116:(.text+0x56): undefined reference to `nfs_uuid_is_local'
> ld: fs/nfsd/localio.o: in function `nfsd_localio_ops_init':
> /usr/src/linux/fs/nfsd/localio.c:37:(.text+0x2c9): undefined reference to `nfs_to'
> 
> Command:
> make -j64 or make LLVM=1 -j64
> 
> the config file for GCC will be attached, let me know if the clang version is desired as well
> 
> As you might guess, not trimming the unused symbols fixes the issue ...
> 
> File: config.txt (text/plain)
> Size: 130.19 KiB
> Link: https://bugzilla.kernel.org/attachment.cgi?id=306999
> ---
> kernel .config
> 
> You can reply to this message to join the discussion.
> -- 
> Deet-doot-dot, I am a bot.
> Kernel.org Bugzilla (bugspray 0.1-dev)

I will report as much via bugzilla.kernel.org but for the benefit of those cc'd:

This was fixed via v6.12-rc3 commit 009b15b57485 ("nfs_common: fix
Kconfig for NFS_COMMON_LOCALIO_SUPPORT")

In the provided kernel config:

CONFIG_NFS_FS=m
CONFIG_NFSD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_COMMON_LOCALIO_SUPPORT=m
CONFIG_NFS_LOCALIO=y

My Kconfig fix will result in CONFIG_NFS_LOCALIO=m so that the symbols
are available to the nfs.ko kernel module.

But if you have any further issues, certainly let me know.

Thanks,
Mike

