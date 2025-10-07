Return-Path: <linux-nfs+bounces-15018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF1BC1A36
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 16:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D34F7069
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8542E2DEF;
	Tue,  7 Oct 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAuNGNvP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A85A2E2DDD
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845902; cv=none; b=A1/PM8xe+oGnqmkOqnesUlyn7U4KgWb94CLmruLs/bcyn6RrKDfUAMevMJGX/tf0FDCl/kjjkhjcGurok5h7UpwIO8aYq3yyXZRaWSIP7LFA+OF8TRAj0fdRMsb0muv2ZxVipevUT6tzaU5ZSMCHwkhK/LO9SK7CVCN7dWK4U+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845902; c=relaxed/simple;
	bh=0Ovw9pktFTS5EXiDA3mvVqrw8up397qnxt2qJSH6Wow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBHWOq0QwcMX2+DNvttT1667pnNY5KPNe9GtHpnV1dxL+VlLpCb+B/97+hVKJDdMbk9q+GvcXsNPiyMx4liwxWdCC+85x3TVlXp3+xLrr6FPkk1DU3e/sZp93z+hUUgsOWg3ac0F7+0gjl8EZlNHtacANNdj0e9Ee8XvUJ33Kik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAuNGNvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FFDC4CEF9;
	Tue,  7 Oct 2025 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759845902;
	bh=0Ovw9pktFTS5EXiDA3mvVqrw8up397qnxt2qJSH6Wow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAuNGNvPYp8Q+EZKs2zW+uroTek3SbvPPKzSHkZh2iSuCBRTIJZF1wY80Pk5j8yI6
	 R+Svaz5NJt9sh/vp0S+bQTnW2jwq6V1FxpCP8tc8dCFmBBaG7f+ErXtr7ZhRiAMbWn
	 5Ax0IdHEg8V322pZ3nDjR1jk+MTzrLUUPKacbfLc3tAAjjh61mgJE81KhsYE3E7isO
	 rZmIVUXVdaUuYXjYl6axQGM+pUeC6RyKf5DSg7HNg1gl5EzlqwrmWTBDdActXCZMcl
	 8eWao7uUpBb9axFG2qCj2j4SM4mneiGChDN4O/MmR3HHnpOJo0E95d7StAHWd3f9hD
	 8tkzhDO2nOH+g==
Date: Tue, 7 Oct 2025 10:05:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jonathan Curley <jcurley@purestorage.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] NFSv4/flexfiles: Add support for striped
 layouts
Message-ID: <aOUeDCzouBMwjalF@kernel.org>
References: <20250924162050.634451-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924162050.634451-1-jcurley@purestorage.com>

On Wed, Sep 24, 2025 at 04:20:41PM +0000, Jonathan Curley wrote:
> This patch series introduces support for striped layouts:
> 
> The first 2 patches are simple preparation changes. There should be
> no logical impact to the code.
> 
> The 3rd patch refactors the nfs4_ff_layout_mirror struct to have an
> array of a new nfs4_ff_layout_ds_stripe type. The
> nfs4_ff_layout_ds_stripe has all the contents of ff_data_server4 per
> the flexfile rfc. I called it ds_stripe because ds was already taken
> by the deviceid side of the code.
> 
> The patches 4-8 update various paths to be dss_id aware. Most of this
> consists of either adding a new parameter to the function or adding a
> loop. Depending on which is appropriate.
> 
> The final patch 9 updates the layout creation path to populate the
> array and turns the feature on.
> 
> v1:
>  - Fixes function parameter 'dss_id' not described in
>    'nfs4_ff_layout_prepare_ds'
> 
> v2:
>  - Fixes layout stat error reporting path for commit to properly
>    calculate dss_id.
> 
> v3:
>  - Fixes do_div dividend to be u64.
> 
> v4:
>  - Use regular division operators for u32 commit path math.
>  - Fix mirror null check in ff_rw_layout_has_available_ds.
> 
> Jonathan Curley (9):
>   NFSv4/flexfiles: Remove cred local variable dependency
>   NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
>   NFSv4/flexfiles: Add data structure support for striped layouts
>   NFSv4/flexfiles: Update low level helper functions to be DS stripe
>     aware.
>   NFSv4/flexfiles: Read path updates for striped layouts
>   NFSv4/flexfiles: Commit path updates for striped layouts
>   NFSv4/flexfiles: Write path updates for striped layouts
>   NFSv4/flexfiles: Update layout stats & error paths for striped layouts
>   NFSv4/flexfiles: Add support for striped layouts
> 
>  fs/nfs/flexfilelayout/flexfilelayout.c    | 778 +++++++++++++++-------
>  fs/nfs/flexfilelayout/flexfilelayout.h    |  64 +-
>  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 105 +--
>  fs/nfs/write.c                            |   2 +-
>  4 files changed, 635 insertions(+), 314 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Hi Jonathan,

Testing the latest 'nfs-for-6.18-1' tag (now merged into Linus' tree),
with your flexfiles striped layout changes, using NFS LOCALIO results
in NFSD shutdown hanging due to nfsd refcount.

I'm using 4.2 flexfiles client that connects to local system's DS via
NFS v3 over LOCALIO, and then simply issuing very brief IO with dd:

dd if=/dev/zero of=/mnt/hs_test/dd_thisisa.test bs=47008 count=2 oflag=direct
dd if=/mnt/hs_test/dd_thisisa.test of=/dev/null bs=47008 count=2 iflag=direct

followed by umount of the filesystem, and then attempt to stop all
NFS/NFSD services so that all related kernel modules may be unloaded:

umount /mnt/hs_test
systemctl stop rpc-statd.service
systemctl stop rpc-statd-notify.service
systemctl stop var-lib-nfs-rpc_pipefs.mount
systemctl stop proc-fs-nfsd.mount
systemctl stop nfs-server.service
 # ^ this hangs below...

systemctl stop rpcbind
systemctl stop rpcbind.socket
systemctl stop nfsdcld.service
systemctl stop nfs-client.target

/var/log/messages shows:

Oct  6 18:08:20 plsm121c-06 systemd[1]: mnt-hs_test.mount: Deactivated successfully.
Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopping NFS status monitor for NFSv2/3 locking....
Oct  6 18:08:20 plsm121c-06 systemd[1]: rpc-statd.service: Deactivated successfully.
Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped NFS status monitor for NFSv2/3 locking..
Oct  6 18:08:20 plsm121c-06 systemd[1]: rpc-statd-notify.service: Deactivated successfully.
Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped Notify NFS peers of a restart.
Oct  6 18:08:20 plsm121c-06 rpc.idmapd[8982]: exiting on signal 15
Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopping NFSv4 ID-name mapping service...
Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopping NFSv4 Client Tracking Daemon...
Oct  6 18:08:20 plsm121c-06 systemd[1]: nfs-idmapd.service: Deactivated successfully.
Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped NFSv4 ID-name mapping service.
Oct  6 18:08:20 plsm121c-06 systemd[1]: nfsdcld.service: Deactivated successfully.
Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped NFSv4 Client Tracking Daemon.
Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped target rpc_pipefs.target.
Oct  6 18:08:20 plsm121c-06 systemd[1]: Unmounting RPC Pipe File System...
Oct  6 18:08:20 plsm121c-06 systemd[1]: var-lib-nfs-rpc_pipefs.mount: Deactivated successfully.
Oct  6 18:08:20 plsm121c-06 systemd[1]: Unmounted RPC Pipe File System.
Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopping NFS server and services...
Oct  6 18:08:22 plsm121c-06 rpc.mountd[8988]: v4.2 client detached: 0x68a8fa0468e404e3 from "192.168.0.105:853"

Oct  6 18:09:50 plsm121c-06 systemd[1]: nfs-server.service: Stopping timed out. Terminating.
Oct  6 18:10:00 plsm121c-06 systemd[1]: Starting system activity accounting tool...
Oct  6 18:10:00 plsm121c-06 systemd[1]: sysstat-collect.service: Deactivated successfully.
Oct  6 18:10:00 plsm121c-06 systemd[1]: Finished system activity accounting tool.

Oct  6 18:11:21 plsm121c-06 systemd[1]: nfs-server.service: State 'stop-sigterm' timed out. Killing.
Oct  6 18:11:21 plsm121c-06 systemd[1]: nfs-server.service: Killing process 9669 (rpc.nfsd) with signal SIGKILL.
Oct  6 18:11:26 plsm121c-06 kernel: INFO: task rpc.nfsd:9669 blocked for more than 122 seconds.
Oct  6 18:11:26 plsm121c-06 kernel:      Not tainted 6.12.24.23.hs.snitm+ #44
Oct  6 18:11:26 plsm121c-06 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct  6 18:11:26 plsm121c-06 kernel: task:rpc.nfsd        state:D stack:0     pid:9669  tgid:9669  ppid:1      flags:0x00004006
Oct  6 18:11:26 plsm121c-06 kernel: Call Trace:
Oct  6 18:11:26 plsm121c-06 kernel: <TASK>
Oct  6 18:11:26 plsm121c-06 kernel: __schedule+0x26d/0x530
Oct  6 18:11:26 plsm121c-06 kernel: schedule+0x27/0xa0
Oct  6 18:11:26 plsm121c-06 kernel: schedule_timeout+0x14e/0x160
Oct  6 18:11:26 plsm121c-06 kernel: ? svc_destroy+0xce/0x160 [sunrpc]
Oct  6 18:11:26 plsm121c-06 kernel: ? lockd_put+0x5f/0x90 [lockd]
Oct  6 18:11:26 plsm121c-06 kernel: __wait_for_common+0x8f/0x1d0
Oct  6 18:11:26 plsm121c-06 kernel: ? __pfx_schedule_timeout+0x10/0x10
Oct  6 18:11:26 plsm121c-06 kernel: nfsd_destroy_serv+0x138/0x1a0 [nfsd]
Oct  6 18:11:26 plsm121c-06 kernel: nfsd_svc+0xe0/0x170 [nfsd]
Oct  6 18:11:26 plsm121c-06 kernel: write_threads+0xc3/0x190 [nfsd]
Oct  6 18:11:26 plsm121c-06 kernel: ? simple_transaction_get+0xc2/0xe0
Oct  6 18:11:26 plsm121c-06 kernel: ? __pfx_write_threads+0x10/0x10 [nfsd]
Oct  6 18:11:26 plsm121c-06 kernel: nfsctl_transaction_write+0x47/0x80 [nfsd]
Oct  6 18:11:26 plsm121c-06 kernel: vfs_write+0xfa/0x420
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
Oct  6 18:11:26 plsm121c-06 kernel: ksys_write+0x63/0xe0
Oct  6 18:11:26 plsm121c-06 kernel: do_syscall_64+0x7d/0x160
Oct  6 18:11:26 plsm121c-06 kernel: ? __x64_sys_close+0x3c/0x80
Oct  6 18:11:26 plsm121c-06 kernel: ? kmem_cache_free+0x347/0x450
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
Oct  6 18:11:26 plsm121c-06 kernel: ? do_syscall_64+0x89/0x160
Oct  6 18:11:26 plsm121c-06 kernel: ? list_lru_add+0x142/0x190
Oct  6 18:11:26 plsm121c-06 kernel: ? task_lookup_next_fdget_rcu+0x91/0xd0
Oct  6 18:11:26 plsm121c-06 kernel: ? __pfx_proc_fd_instantiate+0x10/0x10
Oct  6 18:11:26 plsm121c-06 kernel: ? proc_readfd_common+0xf5/0x1f0
Oct  6 18:11:26 plsm121c-06 kernel: ? atime_needs_update+0x61/0x120
Oct  6 18:11:26 plsm121c-06 kernel: ? touch_atime+0x1e/0x100
Oct  6 18:11:26 plsm121c-06 kernel: ? iterate_dir+0x18f/0x220
Oct  6 18:11:26 plsm121c-06 kernel: ? __x64_sys_getdents64+0xf7/0x120
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
Oct  6 18:11:26 plsm121c-06 kernel: ? do_syscall_64+0x89/0x160
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
Oct  6 18:11:26 plsm121c-06 kernel: ? do_syscall_64+0x89/0x160
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
Oct  6 18:11:26 plsm121c-06 kernel: ? do_syscall_64+0x89/0x160
Oct  6 18:11:26 plsm121c-06 kernel: ? do_user_addr_fault+0x341/0x6b0
Oct  6 18:11:26 plsm121c-06 kernel: ? exc_page_fault+0x70/0x160
Oct  6 18:11:26 plsm121c-06 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
Oct  6 18:11:26 plsm121c-06 kernel: RIP: 0033:0x7fc17ecfd617
Oct  6 18:11:26 plsm121c-06 kernel: RSP: 002b:00007ffc321ff1c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Oct  6 18:11:26 plsm121c-06 kernel: RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc17ecfd617
Oct  6 18:11:26 plsm121c-06 kernel: RDX: 0000000000000002 RSI: 000056109cba2c20 RDI: 0000000000000003
Oct  6 18:11:26 plsm121c-06 kernel: RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffc321ff060
Oct  6 18:11:26 plsm121c-06 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000056109cba2c20
Oct  6 18:11:26 plsm121c-06 kernel: R13: 00007fc17ee086c8 R14: 00007ffc321ff290 R15: 00000000ffffffff
Oct  6 18:11:26 plsm121c-06 kernel: </TASK>

I started to try to bisect but if I only apply the first 3 commits in
your series:

fec80afc41af NFSv4/flexfiles: Remove cred local variable dependency
eb71428e1a7f NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
d442670c0f63 NFSv4/flexfiles: Add data structure support for striped layouts

and rerun the test I get a kernel panic (which I don't yet have a
crashdump for, kdump appears misconfigured on my system).

Mike

