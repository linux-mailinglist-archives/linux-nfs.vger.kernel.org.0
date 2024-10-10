Return-Path: <linux-nfs+bounces-6996-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17090997F81
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 10:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9062837FF
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548E03211;
	Thu, 10 Oct 2024 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ync8X63r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE71C3F24
	for <linux-nfs@vger.kernel.org>; Thu, 10 Oct 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545710; cv=none; b=Ab+5ipHSdXnZg6jIAkBXyUFklFFzT19yVX0qRILzhE+uMIUn6IOEHfMsBOHa92aalvnMnFup7GSfpHalJMYxmhMiBGbf/dzmM+2Wxl45GaAwMhaYRCAU2S0OUgag8OV06LZTUgyXDq6zAXrWdsdcReCNHUuE0mbSO9HyQ/5nkzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545710; c=relaxed/simple;
	bh=6J+xgehmR5bEXv2IQS+Zb8jF1pO/nOC7QQrtDcrKDRM=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=txope1BJhx9ehz4qk3MfeOIH6BOuYueXwCUlgneTpP9r5svx5xikMTj6bmmVLkp99n+RYDd3l837Y9jBYbri4Krf7TrQypPKW/VvlqzaUv3c+P2MqU16PgUuE5kBAtMVtFncSX+3ZjkG38nG/aHA5MZjTxOK2qPyqBm/pRLJ1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ync8X63r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B86C4CEC5;
	Thu, 10 Oct 2024 07:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728545709;
	bh=6J+xgehmR5bEXv2IQS+Zb8jF1pO/nOC7QQrtDcrKDRM=;
	h=From:Date:To:Subject:From;
	b=Ync8X63rxnLY46uHzEXqvNZxWIUhF9zs6jAMBq6rlH3chG2wQ4JG2xPh/Me5g/6fm
	 IYs6XIdgUcQbHecC8PGLX2IQHttZ/DrUmllfsVIFWEOXBXYSJoNkE/NgBW5kgKkp3Z
	 jZR28S6APdnYChNOMChVBh8xea5sftEVBdQ/6GfVXwvyGknntW7nyGE+DBLJhFMOcL
	 Ecx0ANujoVQE0PND1gKYrYXCm/dw37bxxoseV+VJaHYYYwGxohFTx7i0BII5gAIpkq
	 whZuIzkzONMuvMc06iy1Y1bccBvRnjJtgfAcUa61g8PopfsojM8bJ/sDgaGhgiAuvp
	 f+wlOVfuVmgbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F41AD3803263;
	Thu, 10 Oct 2024 07:35:14 +0000 (UTC)
From: Janpieter Sollie via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 10 Oct 2024 07:35:10 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org, 
 cel@kernel.org, jlayton@kernel.org
Message-ID: <20241010-b219370c0-bd6df2a482ac@bugzilla.kernel.org>
Subject: link error while compiling localio.c
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Janpieter Sollie added an attachment on Kernel.org Bugzilla:

Created attachment 306999
kernel .config

tried both GCC and clang:
Clang output:
> ld.lld: error: undefined symbol: nfs_to
> >>> referenced by localio.c:37 (fs/nfsd/localio.c:37)
> >>>               vmlinux.o:(init_nfsd)
> >>> referenced by localio.c:37 (/usr/src/linux/fs/nfsd/localio.c:37)
> >>>               vmlinux.o:(nfsd_localio_ops_init)
> 
> ld.lld: error: undefined symbol: nfs_uuid_invalidate_clients
> >>> referenced by nfsctl.c:2286 (/usr/src/linux/fs/nfsd/nfsctl.c:2286)
> >>>               vmlinux.o:(nfsd_net_pre_exit)
> 
> ld.lld: error: undefined symbol: nfs_uuid_is_local
> >>> referenced by localio.c:116 (/usr/src/linux/fs/nfsd/localio.c:116)
> >>>               vmlinux.o:(localio_proc_uuid_is_local)
GCC output:
ld: fs/nfsd/nfsctl.o: in function `nfsd_net_pre_exit':
nfsctl.c:(.text+0x122): undefined reference to `nfs_uuid_invalidate_clients'
ld: fs/nfsd/localio.o: in function `localio_proc_uuid_is_local':
/usr/src/linux/fs/nfsd/localio.c:116:(.text+0x56): undefined reference to `nfs_uuid_is_local'
ld: fs/nfsd/localio.o: in function `nfsd_localio_ops_init':
/usr/src/linux/fs/nfsd/localio.c:37:(.text+0x2c9): undefined reference to `nfs_to'

Command:
make -j64 or make LLVM=1 -j64

the config file for GCC will be attached, let me know if the clang version is desired as well

As you might guess, not trimming the unused symbols fixes the issue ...

File: config.txt (text/plain)
Size: 130.19 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=306999
---
kernel .config

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


