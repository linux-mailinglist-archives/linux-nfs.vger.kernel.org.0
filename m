Return-Path: <linux-nfs+bounces-18945-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ElIHmM4k2mV2gEAu9opvQ
	(envelope-from <linux-nfs+bounces-18945-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 16:31:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C21459BD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 16:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 053A230068CC
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4975330670;
	Mon, 16 Feb 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYtlKvG1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C2330663
	for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255904; cv=none; b=jxKFMinNByC4RPGnzx/Am4PCbLIDROiWIr2ZuzLxeFF/RkfMD5eRAc48+U5s42q640m3Wj6pn9auhADroslEPIzG/5fe+YZBnTqBu3b2zD536x6KvrdP4ckLgrous3fWg+36Sas/pR707DpF6TbtlVnlCjrGT91gWLkzviBjl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255904; c=relaxed/simple;
	bh=K7+ij6mlkHSQRbtHyK9+K2ag/lNvAxLxBJhCDrz3rb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhJK38vOq6c0bOnJKLm31FKDyHxlFBjZuSEdkKqLKv7utC59S9QbwiYMqte3gf7aA9RPYJt2V75jSTRnROivmlGflKlq0EQ00l1v33l12H7yM1Sp1m8dGaNXSvuSHpk7MAawLllhWeRaX891gMZuAEB0QICkjFHk4cJ0qoZMjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYtlKvG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18653C116C6;
	Mon, 16 Feb 2026 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771255904;
	bh=K7+ij6mlkHSQRbtHyK9+K2ag/lNvAxLxBJhCDrz3rb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYtlKvG1nki9RLoPZtpoQt/pSTpbdbsnRRWkIRVqC6FM1wZHutiKxOIYEorz0xc9W
	 0lF1KJCunK1B3Ipvk21S//EpDVP6vXcVUjsRiZR6n0pKAPR4JiTQknHi09da3lPjK7
	 yQRZjyxVNF4z99O64BYwxccTiiQq+Erooe8lTodwAh+Ma7oiAbzKKQEK7EwjaoYzjc
	 87s76TCboSB7bsmXvLGQ4z+DC5U6UTlldziKNFq+7qA2cuo+Cu4nTT+YfNJG07P0HQ
	 d/o/jV+sBPwTWovypmAwvX9LW4ijXHkgKepOUcJieAILTTc84kbF0fc5CWDsTbxnLi
	 ls7aNlZX08RMw==
Date: Mon, 16 Feb 2026 16:31:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org,
	dlemoal@kernel.org
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 7.0
Message-ID: <aZM4XPFLM4V3YtsD@ryzen>
References: <20260212220625.358550-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212220625.358550-1-anna@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18945-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 110C21459BD
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 05:06:25PM -0500, Anna Schumaker wrote:
> Hi Linus,
> 
> The following changes since commit 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7:
> 
>   Linux 6.19-rc6 (2026-01-18 15:42:45 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.0-1
> 
> for you to fetch changes up to dd2fdc3504592d85e549c523b054898a036a6afe:
> 
>   SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path (2026-02-09 16:39:50 -0500)
> 
> ----------------------------------------------------------------
> NFS Client Updates for Linux 7.0
> 
> New Features:
>  * Use an LRU list for returning unused delegations
>  * Introduce a KConfig option to disable NFS v4.0 and make NFS v4.1 the default
> 
> Bugfixes:
>  * NFS/localio: Handle short writes by retrying
>  * NFS/localio: prevent direct reclaim recursion into NFS via nfs_writepages
>  * NFS/localio: use GFP_NOIO and non-memreclaim workqueue in nfs_local_commit
>  * NFS/localio: remove -EAGAIN handling in nfs_local_doio()
>  * pNFS: fix a missing wake up while waiting on NFS_LAYOUT_DRAIN
>  * fs/nfs: Fix a readdir slow-start regression
>  * SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path
> 
> Other Cleanups and Improvements:
>   * A few other NFS/localio cleanups
>   * Various other delegation handling cleanups from Christoph
>   * Unify security_inode_listsecurity() calls
>   * Improvements to NFSv4 lease handling
>   * Clean up SUNRPC *_debug fields when CONFIG_SUNRPC_DEBUG is not set
> 
> Thanks,
> Anna

Hello Anna,

This seems to break my setup:

[  103.402033] VFS: Unable to mount root fs via NFS.
[  103.402476] devtmpfs: mounted
[  103.406171] Freeing unused kernel memory: 4352K
[  103.406633] Run /sbin/init as init process
[  103.406993]   with arguments:
[  103.407253]     /sbin/init
[  103.407491]   with environment:
[  103.407767]     HOME=/
[  103.407976]     TERM=linux
[  103.408228] Run /etc/init as init process
[  103.408580]   with arguments:
[  103.408841]     /etc/init
[  103.409071]   with environment:
[  103.409346]     HOME=/
[  103.409553]     TERM=linux
[  103.409802] Run /bin/init as init process
[  103.410153]   with arguments:
[  103.410414]     /bin/init
[  103.410644]   with environment:
[  103.410920]     HOME=/
[  103.411128]     TERM=linux
[  103.411367] Run /bin/sh as init process
[  103.411703]   with arguments:
[  103.411963]     /bin/sh
[  103.412179]   with environment:
[  103.412454]     HOME=/
[  103.412662]     TERM=linux
[  103.412904] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.


Doing a git bisect results in:

commit 4e0269352534715915aae3fb84dd4d3bb3ff3738
Author: Anna Schumaker <anna.schumaker@oracle.com>
Date:   Fri Nov 21 14:53:50 2025 -0500

    NFS: Add a way to disable NFS v4.0 via KConfig

    I introduce NFS4_MIN_MINOR_VERSION as a parallel to
    NFS4_MAX_MINOR_VERSION to check if NFS v4.0 has been compiled in and
    return an appropriate error if not.



Before commit above my config has:
CONFIG_NFS_FS=y
CONFIG_NFS_V4=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y

after commit above (with make olddefconfig), my config has:
CONFIG_NFS_FS=y
CONFIG_NFS_V4=y
# CONFIG_NFS_V4_0 is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y



My kernel command line has:
nfsroot=192.168.1.10:/srv/nfs/rootfs,nfsvers=4


I notice that I am probably stupid who has the above, as I assumed that
it meant use the best NFS 4.x version supported by the kernel.


If I change it to:
nfsroot=192.168.1.10:/srv/nfs/rootfs,nfsvers=4.2

The config:
CONFIG_NFS_FS=y
CONFIG_NFS_V4=y
# CONFIG_NFS_V4_0 is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y

successfully mounts my rootfs.


So AFAICT, it seems that nfsvers=4 actually means nfsvers=4.0

I am probably not the only person to who has "nfsvers=4" on the kernel
command line.



Possible solutions I can see:

If the intention is for commit 4e0269352534 ("NFS: Add a way to disable
NFS v4.0 via KConfig") to allow people to disable NFS 4.0, we could
change the new "config NFS_V4_0" to be either "default y".

or

Perhaps we could modify "nfsvers=4" to actually mean "use whatever highest
NFS 4.x version supported by the kernel", rather than use NFS 4.0 and only
4.0.



Kind regards,
Niklas

