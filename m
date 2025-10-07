Return-Path: <linux-nfs+bounces-15021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 474ACBC1CE8
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF31188826B
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2919755B;
	Tue,  7 Oct 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQQGkSTn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA2191F91
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848606; cv=none; b=N2L44sOA1J0rHnpNrchjl8cG2rnCbITdvJ6HnRF+OBV2lElilzofx/xnC/CP6uiRblCOWAzVYHAtPWzbJ/jEVPH7oUge8R8z6it5aR7EL55ddE9t7MxfmsPuIqX57b62vQQaYGroZN/OYms9lnKZ6pnd0HJ5UTpxK2KUi6o/2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848606; c=relaxed/simple;
	bh=v3ObmhtK12/1cjUnwjm6nRrxyym0lQLZLxqMYGFK6Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuTnsKM6BirVKYiVQ2N39qPnuXrrW85c7WM1a0CqsHFxpbaiWeQiy9OJN4HJC04yH+uR3XkANFORMuL7xRha//jz1BCt0yWsRMeCLOGKcBE+aCZmkyMjc+MIg5Xsg1zRrDgBMNBMy7YcteZg3tb7FJ/Amq+7u858hX9qzYpxTCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQQGkSTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B33C4CEF9;
	Tue,  7 Oct 2025 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759848605;
	bh=v3ObmhtK12/1cjUnwjm6nRrxyym0lQLZLxqMYGFK6Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQQGkSTn7Epe1nExul03ufq+RKxgQJD1vWcgFO4v1Ir4U6LL4IfcJtSybsql7oH3K
	 kzVdgACnCf1qLkjXHVGJfzwdTKUA5ZYmXGOK+HXCCGhFnHoQGXPTe1O7s2i5lbQaMV
	 qeT/8zWTMjI+DuyQO58+UfpX4rIeL00QSj8j1/V7KBDdLYe/ilWpEoWjffqp/vjsiD
	 vAICYpiFiJsbAFUbuTbd3/JlV02xmIMyIqujHXM74y3ZpFSxpEVKBQ8dlIXQzKXavU
	 9UvgENBt2dDZlljuMXRpJGcKncRCH5blHargvAoNQ2ZalHv7mpuyKknE9XhEPxVTnh
	 uJAB0P0NOecTw==
Date: Tue, 7 Oct 2025 10:50:04 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jonathan Curley <jcurley@purestorage.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] NFSv4/flexfiles: Add support for striped
 layouts
Message-ID: <aOUonNQRjYBpYcrD@kernel.org>
References: <20250924162050.634451-1-jcurley@purestorage.com>
 <aOUeDCzouBMwjalF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOUeDCzouBMwjalF@kernel.org>

On Tue, Oct 07, 2025 at 10:05:00AM -0400, Mike Snitzer wrote:
> On Wed, Sep 24, 2025 at 04:20:41PM +0000, Jonathan Curley wrote:
> > This patch series introduces support for striped layouts:
> > 
> > The first 2 patches are simple preparation changes. There should be
> > no logical impact to the code.
> > 
> > The 3rd patch refactors the nfs4_ff_layout_mirror struct to have an
> > array of a new nfs4_ff_layout_ds_stripe type. The
> > nfs4_ff_layout_ds_stripe has all the contents of ff_data_server4 per
> > the flexfile rfc. I called it ds_stripe because ds was already taken
> > by the deviceid side of the code.
> > 
> > The patches 4-8 update various paths to be dss_id aware. Most of this
> > consists of either adding a new parameter to the function or adding a
> > loop. Depending on which is appropriate.
> > 
> > The final patch 9 updates the layout creation path to populate the
> > array and turns the feature on.
> > 
> > v1:
> >  - Fixes function parameter 'dss_id' not described in
> >    'nfs4_ff_layout_prepare_ds'
> > 
> > v2:
> >  - Fixes layout stat error reporting path for commit to properly
> >    calculate dss_id.
> > 
> > v3:
> >  - Fixes do_div dividend to be u64.
> > 
> > v4:
> >  - Use regular division operators for u32 commit path math.
> >  - Fix mirror null check in ff_rw_layout_has_available_ds.
> > 
> > Jonathan Curley (9):
> >   NFSv4/flexfiles: Remove cred local variable dependency
> >   NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
> >   NFSv4/flexfiles: Add data structure support for striped layouts
> >   NFSv4/flexfiles: Update low level helper functions to be DS stripe
> >     aware.
> >   NFSv4/flexfiles: Read path updates for striped layouts
> >   NFSv4/flexfiles: Commit path updates for striped layouts
> >   NFSv4/flexfiles: Write path updates for striped layouts
> >   NFSv4/flexfiles: Update layout stats & error paths for striped layouts
> >   NFSv4/flexfiles: Add support for striped layouts
> > 
> >  fs/nfs/flexfilelayout/flexfilelayout.c    | 778 +++++++++++++++-------
> >  fs/nfs/flexfilelayout/flexfilelayout.h    |  64 +-
> >  fs/nfs/flexfilelayout/flexfilelayoutdev.c | 105 +--
> >  fs/nfs/write.c                            |   2 +-
> >  4 files changed, 635 insertions(+), 314 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 
> Hi Jonathan,
> 
> Testing the latest 'nfs-for-6.18-1' tag (now merged into Linus' tree),
> with your flexfiles striped layout changes, using NFS LOCALIO results
> in NFSD shutdown hanging due to nfsd refcount.
> 
> I'm using 4.2 flexfiles client that connects to local system's DS via
> NFS v3 over LOCALIO, and then simply issuing very brief IO with dd:
> 
> dd if=/dev/zero of=/mnt/hs_test/dd_thisisa.test bs=47008 count=2 oflag=direct
> dd if=/mnt/hs_test/dd_thisisa.test of=/dev/null bs=47008 count=2 iflag=direct
> 
> followed by umount of the filesystem, and then attempt to stop all
> NFS/NFSD services so that all related kernel modules may be unloaded:
> 
> umount /mnt/hs_test
> systemctl stop rpc-statd.service
> systemctl stop rpc-statd-notify.service
> systemctl stop var-lib-nfs-rpc_pipefs.mount
> systemctl stop proc-fs-nfsd.mount
> systemctl stop nfs-server.service
>  # ^ this hangs below...
> 
> systemctl stop rpcbind
> systemctl stop rpcbind.socket
> systemctl stop nfsdcld.service
> systemctl stop nfs-client.target
> 
> /var/log/messages shows:
> 
> Oct  6 18:08:20 plsm121c-06 systemd[1]: mnt-hs_test.mount: Deactivated successfully.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopping NFS status monitor for NFSv2/3 locking....
> Oct  6 18:08:20 plsm121c-06 systemd[1]: rpc-statd.service: Deactivated successfully.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped NFS status monitor for NFSv2/3 locking..
> Oct  6 18:08:20 plsm121c-06 systemd[1]: rpc-statd-notify.service: Deactivated successfully.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped Notify NFS peers of a restart.
> Oct  6 18:08:20 plsm121c-06 rpc.idmapd[8982]: exiting on signal 15
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopping NFSv4 ID-name mapping service...
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopping NFSv4 Client Tracking Daemon...
> Oct  6 18:08:20 plsm121c-06 systemd[1]: nfs-idmapd.service: Deactivated successfully.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped NFSv4 ID-name mapping service.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: nfsdcld.service: Deactivated successfully.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped NFSv4 Client Tracking Daemon.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopped target rpc_pipefs.target.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Unmounting RPC Pipe File System...
> Oct  6 18:08:20 plsm121c-06 systemd[1]: var-lib-nfs-rpc_pipefs.mount: Deactivated successfully.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Unmounted RPC Pipe File System.
> Oct  6 18:08:20 plsm121c-06 systemd[1]: Stopping NFS server and services...
> Oct  6 18:08:22 plsm121c-06 rpc.mountd[8988]: v4.2 client detached: 0x68a8fa0468e404e3 from "192.168.0.105:853"
> 
> Oct  6 18:09:50 plsm121c-06 systemd[1]: nfs-server.service: Stopping timed out. Terminating.
> Oct  6 18:10:00 plsm121c-06 systemd[1]: Starting system activity accounting tool...
> Oct  6 18:10:00 plsm121c-06 systemd[1]: sysstat-collect.service: Deactivated successfully.
> Oct  6 18:10:00 plsm121c-06 systemd[1]: Finished system activity accounting tool.
> 
> Oct  6 18:11:21 plsm121c-06 systemd[1]: nfs-server.service: State 'stop-sigterm' timed out. Killing.
> Oct  6 18:11:21 plsm121c-06 systemd[1]: nfs-server.service: Killing process 9669 (rpc.nfsd) with signal SIGKILL.
> Oct  6 18:11:26 plsm121c-06 kernel: INFO: task rpc.nfsd:9669 blocked for more than 122 seconds.
> Oct  6 18:11:26 plsm121c-06 kernel:      Not tainted 6.12.24.23.hs.snitm+ #44
> Oct  6 18:11:26 plsm121c-06 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Oct  6 18:11:26 plsm121c-06 kernel: task:rpc.nfsd        state:D stack:0     pid:9669  tgid:9669  ppid:1      flags:0x00004006
> Oct  6 18:11:26 plsm121c-06 kernel: Call Trace:
> Oct  6 18:11:26 plsm121c-06 kernel: <TASK>
> Oct  6 18:11:26 plsm121c-06 kernel: __schedule+0x26d/0x530
> Oct  6 18:11:26 plsm121c-06 kernel: schedule+0x27/0xa0
> Oct  6 18:11:26 plsm121c-06 kernel: schedule_timeout+0x14e/0x160
> Oct  6 18:11:26 plsm121c-06 kernel: ? svc_destroy+0xce/0x160 [sunrpc]
> Oct  6 18:11:26 plsm121c-06 kernel: ? lockd_put+0x5f/0x90 [lockd]
> Oct  6 18:11:26 plsm121c-06 kernel: __wait_for_common+0x8f/0x1d0
> Oct  6 18:11:26 plsm121c-06 kernel: ? __pfx_schedule_timeout+0x10/0x10
> Oct  6 18:11:26 plsm121c-06 kernel: nfsd_destroy_serv+0x138/0x1a0 [nfsd]
> Oct  6 18:11:26 plsm121c-06 kernel: nfsd_svc+0xe0/0x170 [nfsd]
> Oct  6 18:11:26 plsm121c-06 kernel: write_threads+0xc3/0x190 [nfsd]
> Oct  6 18:11:26 plsm121c-06 kernel: ? simple_transaction_get+0xc2/0xe0
> Oct  6 18:11:26 plsm121c-06 kernel: ? __pfx_write_threads+0x10/0x10 [nfsd]
> Oct  6 18:11:26 plsm121c-06 kernel: nfsctl_transaction_write+0x47/0x80 [nfsd]
> Oct  6 18:11:26 plsm121c-06 kernel: vfs_write+0xfa/0x420
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
> Oct  6 18:11:26 plsm121c-06 kernel: ksys_write+0x63/0xe0
> Oct  6 18:11:26 plsm121c-06 kernel: do_syscall_64+0x7d/0x160
> Oct  6 18:11:26 plsm121c-06 kernel: ? __x64_sys_close+0x3c/0x80
> Oct  6 18:11:26 plsm121c-06 kernel: ? kmem_cache_free+0x347/0x450
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
> Oct  6 18:11:26 plsm121c-06 kernel: ? do_syscall_64+0x89/0x160
> Oct  6 18:11:26 plsm121c-06 kernel: ? list_lru_add+0x142/0x190
> Oct  6 18:11:26 plsm121c-06 kernel: ? task_lookup_next_fdget_rcu+0x91/0xd0
> Oct  6 18:11:26 plsm121c-06 kernel: ? __pfx_proc_fd_instantiate+0x10/0x10
> Oct  6 18:11:26 plsm121c-06 kernel: ? proc_readfd_common+0xf5/0x1f0
> Oct  6 18:11:26 plsm121c-06 kernel: ? atime_needs_update+0x61/0x120
> Oct  6 18:11:26 plsm121c-06 kernel: ? touch_atime+0x1e/0x100
> Oct  6 18:11:26 plsm121c-06 kernel: ? iterate_dir+0x18f/0x220
> Oct  6 18:11:26 plsm121c-06 kernel: ? __x64_sys_getdents64+0xf7/0x120
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
> Oct  6 18:11:26 plsm121c-06 kernel: ? do_syscall_64+0x89/0x160
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
> Oct  6 18:11:26 plsm121c-06 kernel: ? do_syscall_64+0x89/0x160
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_work+0xf3/0x120
> Oct  6 18:11:26 plsm121c-06 kernel: ? syscall_exit_to_user_mode+0x32/0x1b0
> Oct  6 18:11:26 plsm121c-06 kernel: ? do_syscall_64+0x89/0x160
> Oct  6 18:11:26 plsm121c-06 kernel: ? do_user_addr_fault+0x341/0x6b0
> Oct  6 18:11:26 plsm121c-06 kernel: ? exc_page_fault+0x70/0x160
> Oct  6 18:11:26 plsm121c-06 kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Oct  6 18:11:26 plsm121c-06 kernel: RIP: 0033:0x7fc17ecfd617
> Oct  6 18:11:26 plsm121c-06 kernel: RSP: 002b:00007ffc321ff1c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> Oct  6 18:11:26 plsm121c-06 kernel: RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc17ecfd617
> Oct  6 18:11:26 plsm121c-06 kernel: RDX: 0000000000000002 RSI: 000056109cba2c20 RDI: 0000000000000003
> Oct  6 18:11:26 plsm121c-06 kernel: RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffc321ff060
> Oct  6 18:11:26 plsm121c-06 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000056109cba2c20
> Oct  6 18:11:26 plsm121c-06 kernel: R13: 00007fc17ee086c8 R14: 00007ffc321ff290 R15: 00000000ffffffff
> Oct  6 18:11:26 plsm121c-06 kernel: </TASK>
> 
> I started to try to bisect but if I only apply the first 3 commits in
> your series:
> 
> fec80afc41af NFSv4/flexfiles: Remove cred local variable dependency
> eb71428e1a7f NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
> d442670c0f63 NFSv4/flexfiles: Add data structure support for striped layouts

I was mistaken, I had  also applied the 4th commit:
a1491919c880 NFSv4/flexfiles: Update low level helper functions to be DS stripe aware.
 
> and rerun the test I get a kernel panic (which I don't yet have a
> crashdump for, kdump appears misconfigured on my system).

I also get a crash if I apply all but the last commit in the series,
and I was able to get a crashdump (which is the same that I actually
did get, for the previous case with only the first 4 commits applied):

[  301.706108] BUG: kernel NULL pointer dereference, address: 0000000000000060
[  301.706124] #PF: supervisor write access in kernel mode
[  301.706134] #PF: error_code(0x0002) - not-present page
[  301.706143] PGD 80a3680067 P4D 0
[  301.706150] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
[  301.706159] CPU: 27 UID: 0 PID: 4299 Comm: dd Kdump: loaded Tainted: G           O      -------  ---  6.12.24.23.hs.snitm+ #50
[  301.706176] Tainted: [O]=OOT_MODULE
[  301.706181] Hardware name: Supermicro SYS-121C-TN10R/X13DDW-A, BIOS 2.7 07/23/2025
[  301.706191] RIP: 0010:ff_layout_alloc_lseg+0x1d8/0x7b0 [nfs_layout_flexfiles]
[  301.706205] Code: 85 c0 0f 84 72 05 00 00 48 8d 50 08 c7 40 28 01 00 00 00 48 89 50 08 48 89 50 10 48 8b 50 20 c7 40 2c 00 00 00 00 48 8d 4a 70 <48> c7 42 60 00 00 00 00 48 89 4a 70 48 c7 42 68 00 00 00 00 48 89
[  301.706228] RSP: 0018:ff825cf2df0876c0 EFLAGS: 00010286
[  301.706236] RAX: ff373fab2dbf16c0 RBX: 0000000000000001 RCX: 0000000000000070
[  301.706246] RDX: 0000000000000000 RSI: ffffffffc1b4db5d RDI: ff373fab2dbf1700
[  301.706529] RBP: ff825cf2df0877c8 R08: 0000000000000040 R09: ff373fab2dbf16c0
[  301.706759] R10: ff825cf2df0876c0 R11: 0000000000000005 R12: ff37402c1f9c0e80
[  301.706979] R13: 0000000000000000 R14: ff37402c0269f080 R15: 0000000000000000
[  301.707194] FS:  00007fa060a0f740(0000) GS:ff3740a87f180000(0000) knlGS:0000000000000000
[  301.707409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  301.707617] CR2: 0000000000000060 CR3: 000000809d2a0001 CR4: 0000000000f73ef0
[  301.707822] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  301.708023] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  301.708223] PKRU: 55555554
[  301.708420] Call Trace:
[  301.708616]  <TASK>
[  301.708811]  ? __pfx_nfs_init_locked+0x10/0x10 [nfs]
[  301.709043]  pnfs_layout_process+0xc9/0x3c0 [nfsv4]
[  301.709283]  pnfs_parse_lgopen+0x5b/0x120 [nfsv4]
[  301.709511]  _nfs4_open_and_get_state+0x173/0x2b0 [nfsv4]
[  301.709734]  ? nfs4_opendata_alloc+0x26d/0x400 [nfsv4]
[  301.709956]  _nfs4_do_open.isra.0+0x168/0x470 [nfsv4]
[  301.710176]  nfs4_do_open+0xcc/0x210 [nfsv4]
[  301.710393]  ? __memcg_slab_post_alloc_hook+0x220/0x3d0
[  301.710595]  nfs4_atomic_open+0x10b/0x140 [nfsv4]
[  301.710818]  ? alloc_nfs_open_context+0x2e/0x190 [nfs]
[  301.711047]  nfs_atomic_open+0x209/0x6b0 [nfs]
[  301.711270]  lookup_open.isra.0+0x394/0x620
[  301.711473]  open_last_lookups+0x1f6/0x470
[  301.711677]  path_openat+0x88/0x280
[  301.711875]  ? folio_add_file_rmap_ptes+0x38/0xb0
[  301.712076]  do_filp_open+0xae/0x150
[  301.712273]  ? syscall_exit_to_user_mode+0x32/0x1b0
[  301.712474]  ? __check_object_size.part.0+0x5e/0x140
[  301.712672]  do_sys_openat2+0x96/0xd0
[  301.712871]  __x64_sys_openat+0x57/0xa0
[  301.713066]  do_syscall_64+0x7d/0x160
[  301.713260]  ? __count_memcg_events+0x53/0xf0
[  301.713449]  ? handle_mm_fault+0x245/0x340
[  301.713635]  ? do_user_addr_fault+0x341/0x6b0
[  301.713823]  ? exc_page_fault+0x70/0x160
[  301.714008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  301.714195] RIP: 0033:0x7fa0608fd2cb
[  301.714376] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
[  301.714749] RSP: 002b:00007ffe82758370 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  301.714938] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fa0608fd2cb
[  301.715127] RDX: 0000000000004241 RSI: 00007ffe82759ce1 RDI: 00000000ffffff9c
[  301.715311] RBP: 00007ffe82759ce1 R08: 0000000000000000 R09: 0000000000000002
[  301.715490] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000004241
[  301.715667] R13: 0000000000004241 R14: 00007ffe82759ce1 R15: 00007ffe82759d15
[  301.715843]  </TASK>

crash> l *ff_layout_alloc_lseg+0x1d8
0xffffffffc170eb88 is in ff_layout_alloc_lseg (./include/linux/nfs_fs.h:90).
85      };
86
87      static inline void nfs_localio_file_init(struct nfs_file_localio *nfl)
88      {
89      #if IS_ENABLED(CONFIG_NFS_LOCALIO)
90              nfl->ro_file = NULL;
91              nfl->rw_file = NULL;
92              INIT_LIST_HEAD(&nfl->list);
93              nfl->nfs_uuid = NULL;
94      #endif

pnfs_layout_process
	-> ff_layout_alloc_mirror
	   -> nfs_localio_file_init(&mirror->dss[0].nfl)

So given the crash with:
BUG: kernel NULL pointer dereference, address: 0000000000000060

It would appear mirror->dss[0] is NULL, given its nfl member is at 0x60:

crash> struct -o nfs4_ff_layout_ds_stripe
struct nfs4_ff_layout_ds_stripe {
    [0x0] struct nfs4_ff_layout_mirror *mirror;
    [0x8] struct nfs4_deviceid devid;
   [0x18] u32 efficiency;
   [0x20] struct nfs4_ff_layout_ds *mirror_ds;
   [0x28] u32 fh_versions_cnt;
   [0x30] struct nfs_fh *fh_versions;
   [0x38] nfs4_stateid stateid;
   [0x50] const struct cred *ro_cred;
   [0x58] const struct cred *rw_cred;
   [0x60] struct nfs_file_localio nfl;
   [0x88] struct nfs4_ff_layoutstat read_stat;
   [0xd0] struct nfs4_ff_layoutstat write_stat;
  [0x118] ktime_t start_time;
}
SIZE: 0x120

