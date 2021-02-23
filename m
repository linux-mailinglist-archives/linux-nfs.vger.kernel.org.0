Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA5323414
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 00:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhBWXBT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Feb 2021 18:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhBWW5o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Feb 2021 17:57:44 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F436C061574
        for <linux-nfs@vger.kernel.org>; Tue, 23 Feb 2021 14:57:03 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id CFFD72824; Tue, 23 Feb 2021 17:57:01 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CFFD72824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1614121021;
        bh=KijHVf2zJ4ircJTvmXpuKdC5Xnu+V9r9blSGqqRTCSs=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ItZ8cSzYUb0wDZkxOgfSmUi9wouUlTGNupWY1wCCZMD/zpalCFx3SmtltXF6xNFBs
         E0BAyAf3s/7igv0optL1rluf4Q2OBvVojhxuUDZ9ziUwquKi4cfailtLyb1//1+Spq
         zAy0MtkH6jFLF2IME/VM2UHp/GBhxvrSImfdcebk=
Date:   Tue, 23 Feb 2021 17:57:01 -0500
To:     Nick Alcock <nix@esperi.org.uk>
Cc:     NFS list <linux-nfs@vger.kernel.org>
Subject: Re: steam-associated reproducible hard NFSv4.2 client hang (5.9,
 5.10)
Message-ID: <20210223225701.GD8042@fieldses.org>
References: <877dourt7c.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dourt7c.fsf@esperi.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Jan 03, 2021 at 02:27:51PM +0000, Nick Alcock wrote:
> So I bought a game or two on Steam a fortnight ago to while away a
> Christmas spent stuck indoors with no family, decorations, or presents
> (stuck at my sister's and she got a perfectly-timed case of covid-19).
> It turned out this was a very bad idea!
> 
> I keep my Steam directory on an ext4 fs on the local fileserver and
> access it via NFSv4.2: over 10GbE: it's actually faster than local
> spinning-rust storage would be (five-spindle RAID-6 and bcache and
> 128GiB RAM on the server for caching probably have something to do with
> that!) though likely slower than the NVMe the local machine actually
> has: but it doesn't have enough local storage, so I keep all the Steam
> stuff remotely.
> 
> (I keep my $HOME on the same fileserver, though that's on xfs: I'd use
> xfs for Steam, too, but there are still a lot of games out there that
> fail on filesystems with 64-bit inode numbers.)
> 
> Unfortunately, what I observe now when kicking up Steam is a spasm of
> downloading I/O for the game I just bought and then a complete
> client-side hang when it starts installing: just about all I can do is
> hard-reboot. This of course stops me using Steam for anything which
> didn't make me very happy :P
> 
> The server hums onwards as though nothing went wrong, but the client is
> in a bad way indeed: not only has NFS hung but there are clearly some
> important locks taken out since even an ls on a non-NFS dir (with no NFS
> dirs in the PATH) hangs, as does a while :; ps -e; done loop. I can
> rebuild with lockdep and do a lock dump if that would be useful. (The
> kernel is not quite stock: it has DTrace built in, but the hangs happen
> even if the kernel module has never been loaded, and I'm pretty sure the
> hangs can't be associated with the not-very-substantial built-in DTrace
> changes. I can try rebuilding without that as well, but I'll have to rip
> chunks out of my monitoring machinery to do that so I've avoided doing
> it so far.)
> 
> I finally got round to doing a bit of debugging today. NFS debugging
> dumps covering the last fifteen seconds or so before the hang and a
> couple of minutes afterwards (taken on the client, logged without
> incident to the server's syslog, as proof that not *everything* is
> stalled) are a few megabytes long so are at
> <http://www.esperi.org.uk/~nix/temporary/nfs-steam-hang.log>. Everything
> seems to go wrong after an especially large bunch of NFS commits.
> 
> Both client (silk, 192.168.16.21) and server (loom, 192.168.16.8) are
> running 5.10.4 with the same NFS config, though the client has no NFS
> server exports at the time and the server isn't acting as an NFS client
> at all:
> 
> CONFIG_NFS_FS=y
> # CONFIG_NFS_V2 is not set
> CONFIG_NFS_V3=y
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=y
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
> CONFIG_PNFS_FILE_LAYOUT=y
> CONFIG_PNFS_BLOCK=y
> CONFIG_PNFS_FLEXFILE_LAYOUT=m
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DEBUG=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFS_V4_2_READ_PLUS is not set
> CONFIG_NFSD=y
> CONFIG_NFSD_V2_ACL=y
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V3_ACL=y
> CONFIG_NFSD_V4=y
> # CONFIG_NFSD_BLOCKLAYOUT is not set
> # CONFIG_NFSD_SCSILAYOUT is not set
> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> CONFIG_NFSD_V4_2_INTER_SSC=y
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_ACL_SUPPORT=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=y
> CONFIG_SUNRPC_BACKCHANNEL=y
> CONFIG_SUNRPC_DEBUG=y
> 
> The server (loom) has a large number of exports: many of the filesystems
> being exported are moved around via bind mounts and the like. The steam
> datadir is in /pkg/non-free/steam, which is bind-mounted onto
> /home/nix/.steam on the client: /home/nix itself is bind-mounted from
> /home/.loom.srvr.nix/steam, and is NFS-exported from the server under
> that pathname.
> 
> Relevant exports, from /proc/fs/nfs/exports:
> 
> /	192.168.16.0/24,silk.wkstn.nix(ro,insecure,no_root_squash,sync,no_wdelay,no_subtree_check,v4root,fsid=0,uuid=0a4a4563:00764033:8c827c0e:989cf534,sec=390003:390004:390005:1)
> /home/.loom.srvr.nix	*.srvr.nix,fold.srvr.nix(rw,root_squash,sync,wdelay,no_subtree_check,uuid=0a4a4563:00764033:8c827c0e:989cf534,sec=1)
> /pkg/non-free/steam	192.168.16.0/24,silk.wkstn.nix(rw,root_squash,sync,wdelay,uuid=11b94016:cb6e4b64:beb6c134:9ea3d6b3,sec=1)
> 
> Blocked tasks after the hang suggest that the client is hung waiting
> indefinitely for the server to reply, and I'd guess the server doesn't
> think it needs to. (I can do some server-side debugging dumps too if you
> think the problem might be there.)

I seem to remember there have been some subtle changes to how dropped
replies are handled.  If I remember right: a v4 server is never supposed
to drop a reply without also closing the tcp connection, but it may have
done so in the past.  (I *think* all those cases are fixed?)

And the client may have been changed to be more unforgiving about that
requirement in recent years.

But I don't know if that's where the issue is.

I'm not sure how best to go about debugging.  I suppose you could try to
capture a network trace and work out if there's an RPC that isn't
getting a reply.

Maybe turning on server debugging and looking for "svc: svc_process
dropit" messages timed with the start of the hang.  I think what you
want is "rpdebug -m rpc -s svcdsp".

Does rpc.mountd look healthy?

--b.


> 
> [  322.843962] sysrq: Show Blocked State
> [  322.844058] task:tee             state:D stack:    0 pid: 1176 ppid:  1173 flags:0x00000000
> [  322.844064] Call Trace:
> [  322.844074]  __schedule+0x3db/0x7ee
> [  322.844079]  ? io_schedule+0x70/0x6d
> [  322.844082]  schedule+0x68/0xdc
> [  322.844085]  io_schedule+0x46/0x6d
> [  322.844089]  bit_wait_io+0x11/0x52
> [  322.844092]  __wait_on_bit+0x31/0x90
> [  322.844096]  out_of_line_wait_on_bit+0x7e/0x80
> [  322.844100]  ? var_wake_function+0x30/0x27
> [  322.844104]  nfs_wait_on_request.part.0+0x31/0x33
> [  322.844107]  nfs_page_group_lock_head+0x31/0x78
> [  322.844110]  nfs_lock_and_join_requests+0x9d/0x26e
> [  322.844114]  nfs_updatepage+0x1be/0x985
> [  322.844118]  nfs_write_end+0x128/0x52a
> [  322.844122]  ? iov_iter_copy_from_user_atomic+0xe8/0x3ce
> [  322.844127]  generic_perform_write+0xed/0x17c
> [  322.844131]  nfs_file_write+0x14a/0x29f
> [  322.844135]  new_sync_write+0xfb/0x16b
> [  322.844139]  vfs_write+0x1ee/0x29a
> [  322.844142]  ? vfs_read+0x17b/0x198
> [  322.844145]  ksys_write+0x61/0xd0
> [  322.844148]  __x64_sys_write+0x1a/0x1c
> [  322.844151]  do_syscall_64+0x32/0x45
> [  322.844154]  entry_SYSCALL_64_after_hwframe+0x44/0x0
> [  322.844158] RIP: 0033:0x7f4781f323a3
> [  322.844160] RSP: 002b:00007ffcf8220408 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  322.844164] RAX: ffffffffffffffda RBX: 0000000000000092 RCX: 00007f4781f323a3
> [  322.844166] RDX: 0000000000000092 RSI: 00007ffcf8220530 RDI: 0000000000000003
> [  322.844168] RBP: 00007ffcf8220530 R08: 0000000000000000 R09: 0000000000000001
> [  322.844170] R10: 0000000000400ad2 R11: 0000000000000246 R12: 0000000000000092
> [  322.844172] R13: 0000000002361580 R14: 0000000000000092 R15: 00007f4782201720
> [  322.844202] task:CIPCServer::Thr state:D stack:    0 pid: 1801 ppid:  1540 flags:0x20020000
> [  322.844207] Call Trace:
> [  322.844212]  __schedule+0x3db/0x7ee
> [  322.844219]  ? trace_event_raw_event_rpc_xdr_overflow+0x280/0x27e
> [  322.844222]  schedule+0x68/0xdc
> [  322.844227]  rpc_wait_bit_killable+0x11/0x52
> [  322.844230]  __wait_on_bit+0x31/0x90
> [  322.844235]  ? __rpc_atrun+0x20/0x1a
> [  322.844238]  ? __rpc_atrun+0x20/0x1a
> [  322.844242]  out_of_line_wait_on_bit+0x7e/0x80
> [  322.844246]  ? var_wake_function+0x30/0x27
> [  322.844250]  __rpc_execute+0xe5/0x485
> [  322.844254]  ? sugov_get_util+0xf0/0xeb
> [  322.844258]  rpc_execute+0xa5/0xaa
> [  322.844263]  rpc_run_task+0x148/0x187
> [  322.844267]  nfs4_do_call_sync+0x61/0x81
> [  322.844272]  _nfs4_proc_getattr+0x10a/0x120
> [  322.844278]  nfs4_proc_getattr+0x67/0xee
> [  322.844283]  __nfs_revalidate_inode+0xb7/0x2df
> [  322.844287]  nfs_access_get_cached+0x14d/0x1df
> [  322.844291]  nfs_do_access+0x48/0x28e
> [  322.844296]  ? step_into+0x2bc/0x6a1
> [  322.844301]  nfs_permission+0xa2/0x1b8
> [  322.844305]  inode_permission+0x96/0xca
> [  322.844308]  ? unlazy_walk+0x4c/0x80
> [  322.844312]  link_path_walk.part.0+0x2a5/0x320
> [  322.844315]  ? path_init+0x2c2/0x3e5
> [  322.844318]  path_lookupat+0x3f/0x1b1
> [  322.844322]  filename_lookup+0x97/0x17f
> [  322.844326]  ? kmem_cache_alloc+0x32/0x200
> [  322.844331]  user_path_at_empty+0x59/0x8a
> [  322.844333]  do_faccessat+0x70/0x227
> [  322.844337]  __ia32_sys_access+0x1c/0x1e
> [  322.844340]  __do_fast_syscall_32+0x5f/0x8e
> [  322.844342]  do_fast_syscall_32+0x3d/0x80
> [  322.844346]  entry_SYSCALL_compat_after_hwframe+0x45/0x0
> [  322.844348] RIP: 0023:0xf7ee6549
> [  322.844350] RSP: 002b:00000000eb763b28 EFLAGS: 00200292 ORIG_RAX: 0000000000000021
> [  322.844353] RAX: ffffffffffffffda RBX: 000000005754d9e0 RCX: 0000000000000004
> [  322.844355] RDX: 00000000f7ab3e1c RSI: 000000005754d9e0 RDI: 00000000eb763bc8
> [  322.844357] RBP: 00000000f78a91c0 R08: 0000000000000000 R09: 0000000000000000
> [  322.844359] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  322.844360] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  322.844364] task:CFileWriterThre state:D stack:    0 pid: 1810 ppid:  1540 flags:0x20024000
> [  322.844367] Call Trace:
> [  322.844371]  __schedule+0x3db/0x7ee
> [  322.844375]  ? trace_event_raw_event_rpc_xdr_overflow+0x280/0x27e
> [  322.844379]  schedule+0x68/0xdc
> [  322.844382]  rpc_wait_bit_killable+0x11/0x52
> [  322.844385]  __wait_on_bit+0x31/0x90
> [  322.844389]  ? call_reserveresult+0xa0/0x9f
> [  322.844391]  ? call_transmit_status+0x160/0x159
> [  322.844395]  out_of_line_wait_on_bit+0x7e/0x80
> [  322.844398]  ? var_wake_function+0x30/0x27
> [  322.844401]  __rpc_execute+0xe5/0x485
> [  322.844404]  ? nfs_check_verifier+0x5b/0xa4
> [  322.844407]  rpc_execute+0xa5/0xaa
> [  322.844410]  rpc_run_task+0x148/0x187
> [  322.844414]  nfs4_do_call_sync+0x61/0x81
> [  322.844417]  _nfs4_proc_getattr+0x10a/0x120
> [  322.844422]  nfs4_proc_getattr+0x67/0xee
> [  322.844426]  __nfs_revalidate_inode+0xb7/0x2df
> [  322.844430]  nfs_getattr+0x159/0x374
> [  322.844433]  vfs_getattr_nosec+0x96/0xa4
> [  322.844435]  vfs_statx+0x7a/0xe5
> [  322.844438]  vfs_fstatat+0x1f/0x21
> [  322.844443]  __do_compat_sys_ia32_lstat64+0x2b/0x4e
> [  322.844448]  __ia32_compat_sys_ia32_lstat64+0x14/0x16
> [  322.844450]  __do_fast_syscall_32+0x5f/0x8e
> [  322.844453]  do_fast_syscall_32+0x3d/0x80
> [  322.844457]  entry_SYSCALL_compat_after_hwframe+0x45/0x0
> [  322.844459] RIP: 0023:0xf7ee6549
> [  322.844460] RSP: 002b:00000000eb561be8 EFLAGS: 00000292 ORIG_RAX: 00000000000000c4
> [  322.844463] RAX: ffffffffffffffda RBX: 00000000c521bf60 RCX: 00000000eb561e70
> [  322.844465] RDX: 00000000f7ab3e1c RSI: 00000000eb561e70 RDI: 00000000c521bf60
> [  322.844467] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [  322.844468] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  322.844470] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  322.844477] task:Steam - DirWatc state:D stack:    0 pid: 1924 ppid:  1540 flags:0x20024000
> [  322.844480] Call Trace:
> [  322.844484]  __schedule+0x3db/0x7ee
> [  322.844488]  ? trace_event_raw_event_rpc_xdr_overflow+0x280/0x27e
> [  322.844492]  schedule+0x68/0xdc
> [  322.844495]  rpc_wait_bit_killable+0x11/0x52
> [  322.844498]  __wait_on_bit+0x31/0x90
> [  322.844501]  ? rpc_sleep_on_timeout+0x64/0x9c
> [  322.844504]  ? rpc_check_timeout+0x1e0/0x1e0
> [  322.844507]  ? call_connect_status+0x180/0x17a
> [  322.844511]  out_of_line_wait_on_bit+0x7e/0x80
> [  322.844513]  ? var_wake_function+0x30/0x27
> [  322.844516]  __rpc_execute+0xe5/0x485
> [  322.844520]  rpc_execute+0xa5/0xaa
> [  322.844523]  rpc_run_task+0x148/0x187
> [  322.844526]  nfs4_do_call_sync+0x61/0x81
> [  322.844530]  _nfs4_proc_getattr+0x10a/0x120
> [  322.844534]  nfs4_proc_getattr+0x67/0xee
> [  322.844538]  __nfs_revalidate_inode+0xb7/0x2df
> [  322.844542]  nfs_lookup_verify_inode+0x67/0x82
> [  322.844545]  nfs_do_lookup_revalidate+0x19b/0x29c
> [  322.844548]  nfs4_do_lookup_revalidate+0x5d/0xc5
> [  322.844552]  nfs4_lookup_revalidate+0x6a/0x8d
> [  322.844555]  lookup_fast+0xb8/0x122
> [  322.844559]  path_openat+0xfd/0xfd8
> [  322.844562]  ? unlazy_walk+0x4c/0x80
> [  322.844565]  ? terminate_walk+0x62/0xed
> [  322.844569]  ? putname+0x4b/0x53
> [  322.844572]  do_filp_open+0x86/0x110
> [  322.844576]  ? kmem_cache_alloc+0x32/0x200
> [  322.844579]  ? __alloc_fd+0xb2/0x143
> [  322.844583]  do_sys_openat2+0x8d/0x13a
> [  322.844585]  ? do_faccessat+0x108/0x227
> [  322.844588]  __ia32_compat_sys_openat+0x48/0x63
> [  322.844591]  __do_fast_syscall_32+0x5f/0x8e
> [  322.844594]  do_fast_syscall_32+0x3d/0x80
> [  322.844597]  entry_SYSCALL_compat_after_hwframe+0x45/0x0
> [  322.844600] RIP: 0023:0xf7ee6549
> [  322.844601] RSP: 002b:000000008c8fbcb0 EFLAGS: 00200287 ORIG_RAX: 0000000000000127
> [  322.844604] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 000000008c8fbffc
> [  322.844606] RDX: 0000000000098800 RSI: 0000000000000000 RDI: 00000000f7ab3e1c
> [  322.844608] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [  322.844609] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  322.844611] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  322.844614] task:CGenericAsyncFi state:D stack:    0 pid: 1927 ppid:  1540 flags:0x20020000
> [  322.844617] Call Trace:
> [  322.844621]  __schedule+0x3db/0x7ee
> [  322.844625]  schedule+0x68/0xdc
> [  322.844628]  io_schedule+0x46/0x6d
> [  322.844631]  wait_on_page_bit_common+0xf8/0x325
> [  322.844634]  ? trace_raw_output_file_check_and_advance_wb_err+0x80/0x7d
> [  322.844638]  wait_on_page_bit+0x3f/0x41
> [  322.844642]  wait_on_page_writeback.part.0+0x35/0x80
> [  322.844645]  wait_on_page_writeback+0x27/0x29
> [  322.844647]  __filemap_fdatawait_range+0x88/0xd9
> [  322.844651]  filemap_write_and_wait_range+0x45/0x80
> [  322.844655]  nfs_wb_all+0x30/0x13d
> [  322.844658]  nfs4_file_flush+0x85/0xc0
> [  322.844661]  filp_close+0x3e/0x78
> [  322.844664]  __close_fd+0x23/0x30
> [  322.844667]  __ia32_sys_close+0x22/0x50
> [  322.844670]  __do_fast_syscall_32+0x5f/0x8e
> [  322.844673]  do_fast_syscall_32+0x3d/0x80
> [  322.844676]  entry_SYSCALL_compat_after_hwframe+0x45/0x0
> [  322.844678] RIP: 0023:0xf7ee6549
> [  322.844680] RSP: 002b:000000008c5fddb0 EFLAGS: 00200286 ORIG_RAX: 0000000000000006
> [  322.844682] RAX: ffffffffffffffda RBX: 000000000000004d RCX: 0000000000000002
> [  322.844684] RDX: 0000000000000000 RSI: 00000000f7d02e70 RDI: 000000000000004d
> [  322.844686] RBP: 000000008c5fe110 R08: 0000000000000000 R09: 0000000000000000
> [  322.844688] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  322.844689] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  322.844699] task:ThreadPoolForeg state:D stack:    0 pid: 1768 ppid:  1735 flags:0x00004000
> [  322.844702] Call Trace:
> [  322.844705]  __schedule+0x3db/0x7ee
> [  322.844709]  ? trace_event_raw_event_rpc_xdr_overflow+0x280/0x27e
> [  322.844712]  schedule+0x68/0xdc
> [  322.844716]  rpc_wait_bit_killable+0x11/0x52
> [  322.844719]  __wait_on_bit+0x31/0x90
> [  322.844722]  ? rpc_sleep_on_timeout+0x64/0x9c
> [  322.844725]  ? rpc_check_timeout+0x1e0/0x1e0
> [  322.844728]  ? call_connect_status+0x180/0x17a
> [  322.844731]  out_of_line_wait_on_bit+0x7e/0x80
> [  322.844734]  ? var_wake_function+0x30/0x27
> [  322.844737]  __rpc_execute+0xe5/0x485
> [  322.844740]  ? nfs_check_verifier+0x5b/0xa4
> [  322.844743]  rpc_execute+0xa5/0xaa
> [  322.844746]  rpc_run_task+0x148/0x187
> [  322.844750]  nfs4_do_call_sync+0x61/0x81
> [  322.844753]  _nfs4_proc_getattr+0x10a/0x120
> [  322.844758]  nfs4_proc_getattr+0x67/0xee
> [  322.844762]  __nfs_revalidate_inode+0xb7/0x2df
> [  322.844766]  nfs_getattr+0x159/0x374
> [  322.844769]  vfs_getattr_nosec+0x96/0xa4
> [  322.844771]  vfs_statx+0x7a/0xe5
> [  322.844774]  __do_sys_newstat+0x31/0x4c
> [  322.844778]  __x64_sys_newstat+0x16/0x18
> [  322.844781]  do_syscall_64+0x32/0x45
> [  322.844783]  entry_SYSCALL_64_after_hwframe+0x44/0x0
> [  322.844786] RIP: 0033:0x7fe70ebf19e6
> [  322.844787] RSP: 002b:00007fe6c15b2068 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
> [  322.844790] RAX: ffffffffffffffda RBX: 00000bd4193e1910 RCX: 00007fe70ebf19e6
> [  322.844792] RDX: 00007fe6c15b2078 RSI: 00007fe6c15b2078 RDI: 00000bd4193e1910
> [  322.844794] RBP: 00007fe6c15b2160 R08: 0000000000000001 R09: 00007ffd971ed090
> [  322.844796] R10: 0000000000056764 R11: 0000000000000246 R12: 00007fe6c15b2078
> [  322.844797] R13: 00000bd4192f6f60 R14: 00007fe6c15b2108 R15: 00007fe6c15b2120
> [  322.844801] task:ThreadPoolForeg state:D stack:    0 pid: 1769 ppid:  1735 flags:0x00000000
> [  322.844804] Call Trace:
> [  322.844807]  __schedule+0x3db/0x7ee
> [  322.844811]  ? trace_event_raw_event_rpc_xdr_overflow+0x280/0x27e
> [  322.844814]  schedule+0x68/0xdc
> [  322.844817]  rpc_wait_bit_killable+0x11/0x52
> [  322.844820]  __wait_on_bit+0x31/0x90
> [  322.844823]  ? __rpc_atrun+0x20/0x1a
> [  322.844826]  ? __rpc_atrun+0x20/0x1a
> [  322.844829]  out_of_line_wait_on_bit+0x7e/0x80
> [  322.844831]  ? var_wake_function+0x30/0x27
> [  322.844834]  __rpc_execute+0xe5/0x485
> [  322.844837]  ? update_cfs_group+0x9a/0x9e
> [  322.844840]  rpc_execute+0xa5/0xaa
> [  322.844842]  rpc_run_task+0x148/0x187
> [  322.844845]  nfs4_do_call_sync+0x61/0x81
> [  322.844849]  _nfs4_proc_getattr+0x10a/0x120
> [  322.844853]  nfs4_proc_getattr+0x67/0xee
> [  322.844856]  __nfs_revalidate_inode+0xb7/0x2df
> [  322.844859]  nfs_file_write+0xfc/0x29f
> [  322.844862]  new_sync_write+0xfb/0x16b
> [  322.844866]  vfs_write+0x1ee/0x29a
> [  322.844868]  ? __fget_light+0x31/0x72
> [  322.844871]  ksys_write+0x61/0xd0
> [  322.844874]  __x64_sys_write+0x1a/0x1c
> [  322.844877]  do_syscall_64+0x32/0x45
> [  322.844880]  entry_SYSCALL_64_after_hwframe+0x44/0x0
> [  322.844881] RIP: 0033:0x7fe71859ab7f
> [  322.844883] RSP: 002b:00007fe6bd5b0d30 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  322.844885] RAX: ffffffffffffffda RBX: 00007fe6bd5b0d68 RCX: 00007fe71859ab7f
> [  322.844887] RDX: 0000000000000007 RSI: 00007fe6bd5b1090 RDI: 000000000000005b
> [  322.844888] RBP: 00007fe6bd5b0de0 R08: 0000000000000000 R09: 00007ffd971ed090
> [  322.844890] R10: 0000000000065fd2 R11: 0000000000000293 R12: 00000bd418d95020
> [  322.844891] R13: 00007fe6bd5b1090 R14: 0000000000000007 R15: 0000000000000000
> [  322.844900] task:ThreadPoolForeg state:D stack:    0 pid: 1807 ppid:  1773 flags:0x00000000
> [  322.844902] Call Trace:
> [  322.844904]  __schedule+0x3db/0x7ee
> [  322.844907]  ? trace_event_raw_event_rpc_xdr_overflow+0x280/0x27e
> [  322.844908]  schedule+0x68/0xdc
> [  322.844911]  rpc_wait_bit_killable+0x11/0x52
> [  322.844913]  __wait_on_bit+0x31/0x90
> [  322.844915]  ? __rpc_atrun+0x20/0x1a
> [  322.844916]  ? __rpc_atrun+0x20/0x1a
> [  322.844918]  out_of_line_wait_on_bit+0x7e/0x80
> [  322.844920]  ? var_wake_function+0x30/0x27
> [  322.844922]  __rpc_execute+0xe5/0x485
> [  322.844924]  rpc_execute+0xa5/0xaa
> [  322.844926]  rpc_run_task+0x148/0x187
> [  322.844928]  nfs4_do_call_sync+0x61/0x81
> [  322.844930]  _nfs4_proc_getattr+0x10a/0x120
> [  322.844933]  nfs4_proc_getattr+0x67/0xee
> [  322.844936]  __nfs_revalidate_inode+0xb7/0x2df
> [  322.844938]  nfs_access_get_cached+0x14d/0x1df
> [  322.844940]  nfs_do_access+0x48/0x28e
> [  322.844942]  ? nfs4_lookup_revalidate+0x38/0x8d
> [  322.844944]  nfs_permission+0xa2/0x1b8
> [  322.844946]  inode_permission+0x96/0xca
> [  322.844948]  ? unlazy_walk+0x4c/0x80
> [  322.844950]  link_path_walk.part.0+0x2a5/0x320
> [  322.844952]  ? path_init+0x2c2/0x3e5
> [  322.844954]  path_lookupat+0x3f/0x1b1
> [  322.844956]  filename_lookup+0x97/0x17f
> [  322.844959]  ? do_unlk+0x9a/0xca
> [  322.844960]  ? kmem_cache_alloc+0x32/0x200
> [  322.844963]  user_path_at_empty+0x59/0x8a
> [  322.844965]  vfs_statx+0x64/0xe5
> [  322.844967]  __do_sys_newstat+0x31/0x4c
> [  322.844968]  ? do_fcntl+0x113/0x582
> [  322.844971]  ? fput+0x13/0x15
> [  322.844972]  ? __x64_sys_fcntl+0x81/0xa8
> [  322.844974]  __x64_sys_newstat+0x16/0x18
> [  322.844976]  do_syscall_64+0x32/0x45
> [  322.844977]  entry_SYSCALL_64_after_hwframe+0x44/0x0
> [  322.844979] RIP: 0033:0x7f0d1fd0c9e6
> [  322.844980] RSP: 002b:00007f0d08e12e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
> [  322.844981] RAX: ffffffffffffffda RBX: 00007f0d08e12edc RCX: 00007f0d1fd0c9e6
> [  322.844983] RDX: 00007f0d08e12e28 RSI: 00007f0d08e12e28 RDI: 00001605c2ff1169
> [  322.844984] RBP: 00007f0d08e12ec0 R08: 0000000000000001 R09: 00007fffaddd9090
> [  322.844985] R10: 00001605c3133480 R11: 0000000000000246 R12: 0000000000000000
> [  322.844986] R13: 0000000000000000 R14: 00001605c2ff0f00 R15: 0000000000000000
> [  322.844988] task:ThreadPoolForeg state:D stack:    0 pid: 2031 ppid:  1773 flags:0x00004000
> [  322.844990] Call Trace:
> [  322.844992]  __schedule+0x3db/0x7ee
> [  322.844995]  ? trace_event_raw_event_rpc_xdr_overflow+0x280/0x27e
> [  322.844997]  schedule+0x68/0xdc
> [  322.844999]  rpc_wait_bit_killable+0x11/0x52
> [  322.845001]  __wait_on_bit+0x31/0x90
> [  322.845003]  ? rpc_sleep_on_timeout+0x64/0x9c
> [  322.845005]  ? rpc_check_timeout+0x1e0/0x1e0
> [  322.845006]  ? call_connect_status+0x180/0x17a
> [  322.845009]  out_of_line_wait_on_bit+0x7e/0x80
> [  322.845010]  ? var_wake_function+0x30/0x27
> [  322.845012]  __rpc_execute+0xe5/0x485
> [  322.845014]  rpc_execute+0xa5/0xaa
> [  322.845016]  rpc_run_task+0x148/0x187
> [  322.845018]  nfs4_do_call_sync+0x61/0x81
> [  322.845020]  _nfs4_proc_getattr+0x10a/0x120
> [  322.845023]  nfs4_proc_getattr+0x67/0xee
> [  322.845026]  __nfs_revalidate_inode+0xb7/0x2df
> [  322.845028]  nfs_access_get_cached+0x14d/0x1df
> [  322.845030]  nfs_do_access+0x48/0x28e
> [  322.845032]  ? nfs4_lookup_revalidate+0x38/0x8d
> [  322.845034]  nfs_permission+0xa2/0x1b8
> [  322.845036]  inode_permission+0x96/0xca
> [  322.845038]  ? unlazy_walk+0x4c/0x80
> [  322.845040]  link_path_walk.part.0+0x2a5/0x320
> [  322.845042]  ? path_init+0x2c2/0x3e5
> [  322.845044]  path_lookupat+0x3f/0x1b1
> [  322.845046]  filename_lookup+0x97/0x17f
> [  322.845049]  ? kmem_cache_alloc+0x32/0x200
> [  322.845051]  user_path_at_empty+0x59/0x8a
> [  322.845054]  ? mntput_no_expire+0x4f/0x264
> [  322.845055]  vfs_statx+0x64/0xe5
> [  322.845057]  ? putname+0x4b/0x53
> [  322.845059]  __do_sys_newstat+0x31/0x4c
> [  322.845062]  ? __x64_sys_futex+0x13a/0x159
> [  322.845064]  ? switch_fpu_return+0x58/0xf2
> [  322.845066]  __x64_sys_newstat+0x16/0x18
> [  322.845068]  do_syscall_64+0x32/0x45
> [  322.845069]  entry_SYSCALL_64_after_hwframe+0x44/0x0
> [  322.845071] RIP: 0033:0x7f0d1fd0c9e6
> [  322.845072] RSP: 002b:00007f0d00331108 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
> [  322.845073] RAX: ffffffffffffffda RBX: 00001605c2fdc0a0 RCX: 00007f0d1fd0c9e6
> [  322.845074] RDX: 00007f0d00331118 RSI: 00007f0d00331118 RDI: 00001605c2fdc0a0
> [  322.845076] RBP: 00007f0d00331200 R08: 0000000000000001 R09: 00007fffaddd9090
> [  322.845077] R10: 000000000005771c R11: 0000000000000246 R12: 00007f0d00331118
> [  322.845078] R13: 00001605c3309c40 R14: 00007f0d003311a8 R15: 00007f0d003311c0
> [  322.845087] task:192.168.16.8-ma state:D stack:    0 pid: 2044 ppid:     2 flags:0x00004000
> [  322.845089] Call Trace:
> [  322.845091]  __schedule+0x3db/0x7ee
> [  322.845094]  ? trace_event_raw_event_rpc_xdr_overflow+0x280/0x27e
> [  322.845095]  schedule+0x68/0xdc
> [  322.845098]  rpc_wait_bit_killable+0x11/0x52
> [  322.845100]  __wait_on_bit+0x31/0x90
> [  322.845102]  ? __rpc_atrun+0x20/0x1a
> [  322.845103]  ? __rpc_atrun+0x20/0x1a
> [  322.845105]  out_of_line_wait_on_bit+0x7e/0x80
> [  322.845107]  ? var_wake_function+0x30/0x27
> [  322.845109]  __rpc_execute+0xe5/0x485
> [  322.845111]  rpc_execute+0xa5/0xaa
> [  322.845113]  rpc_run_task+0x148/0x187
> [  322.845115]  nfs4_do_call_sync+0x61/0x81
> [  322.845117]  _nfs4_proc_statfs+0xc1/0xcf
> [  322.845120]  nfs4_proc_statfs+0x55/0x74
> [  322.845122]  nfs_statfs+0x65/0x152
> [  322.845124]  ? _nfs4_proc_delegreturn+0x21e/0x2e5
> [  322.845127]  statfs_by_dentry+0x55/0x74
> [  322.845129]  vfs_statfs+0x24/0x43
> [  322.845132]  check_free_space+0x3c/0xe5
> [  322.845135]  do_acct_process+0x5d/0x5e1
> [  322.845136]  ? nfs_end_delegation_return+0x1cb/0x3aa
> [  322.845138]  ? complete+0x49/0x57
> [  322.845141]  acct_process+0xe5/0x105
> [  322.845143]  do_exit+0x781/0xa1b
> [  322.845145]  ? refcount_dec_and_lock+0x22/0x8c
> [  322.845148]  __module_put_and_exit+0x1b/0x1b
> [  322.845150]  nfs4_run_state_manager+0x293/0x933
> [  322.845152]  ? nfs4_do_reclaim+0x820/0x81c
> [  322.845155]  kthread+0x142/0x15f
> [  322.845157]  ? __kthread_create_worker+0x130/0x122
> [  322.845159]  ret_from_fork+0x1f/0x2a
> [  369.859385] INFO: task tee:1176 blocked for more than 122 seconds.
> [  369.859391]       Not tainted 5.10.4-00021-gde017294a539-dirty #3
> [  369.859393] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  369.859395] task:tee             state:D stack:    0 pid: 1176 ppid:  1173 flags:0x00000000
> [  369.859399] Call Trace:
> [  369.859407]  __schedule+0x3db/0x7ee
> [  369.859410]  ? io_schedule+0x70/0x6d
> [  369.859412]  schedule+0x68/0xdc
> [  369.859415]  io_schedule+0x46/0x6d
> [  369.859417]  bit_wait_io+0x11/0x52
> [  369.859420]  __wait_on_bit+0x31/0x90
> [  369.859422]  out_of_line_wait_on_bit+0x7e/0x80
> [  369.859426]  ? var_wake_function+0x30/0x27
> [  369.859429]  nfs_wait_on_request.part.0+0x31/0x33
> [  369.859431]  nfs_page_group_lock_head+0x31/0x78
> [  369.859433]  nfs_lock_and_join_requests+0x9d/0x26e
> [  369.859436]  nfs_updatepage+0x1be/0x985
> [  369.859439]  nfs_write_end+0x128/0x52a
> [  369.859443]  ? iov_iter_copy_from_user_atomic+0xe8/0x3ce
> [  369.859446]  generic_perform_write+0xed/0x17c
> [  369.859449]  nfs_file_write+0x14a/0x29f
> [  369.859452]  new_sync_write+0xfb/0x16b
> [  369.859455]  vfs_write+0x1ee/0x29a
> [  369.859457]  ? vfs_read+0x17b/0x198
> [  369.859459]  ksys_write+0x61/0xd0
> [  369.859462]  __x64_sys_write+0x1a/0x1c
> [  369.859464]  do_syscall_64+0x32/0x45
> [  369.859467]  entry_SYSCALL_64_after_hwframe+0x44/0x0
> [  369.859469] RIP: 0033:0x7f4781f323a3
> [  369.859471] RSP: 002b:00007ffcf8220408 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  369.859474] RAX: ffffffffffffffda RBX: 0000000000000092 RCX: 00007f4781f323a3
> [  369.859475] RDX: 0000000000000092 RSI: 00007ffcf8220530 RDI: 0000000000000003
> [  369.859477] RBP: 00007ffcf8220530 R08: 0000000000000000 R09: 0000000000000001
> [  369.859478] R10: 0000000000400ad2 R11: 0000000000000246 R12: 0000000000000092
> [  369.859480] R13: 0000000002361580 R14: 0000000000000092 R15: 00007f4782201720
> [  369.859495] INFO: task CGenericAsyncFi:1927 blocked for more than 122 seconds.
> [  369.859497]       Not tainted 5.10.4-00021-gde017294a539-dirty #3
> [  369.859498] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  369.859499] task:CGenericAsyncFi state:D stack:    0 pid: 1927 ppid:  1540 flags:0x20020000
> [  369.859501] Call Trace:
> [  369.859504]  __schedule+0x3db/0x7ee
> [  369.859506]  schedule+0x68/0xdc
> [  369.859508]  io_schedule+0x46/0x6d
> [  369.859510]  wait_on_page_bit_common+0xf8/0x325
> [  369.859512]  ? trace_raw_output_file_check_and_advance_wb_err+0x80/0x7d
> [  369.859515]  wait_on_page_bit+0x3f/0x41
> [  369.859517]  wait_on_page_writeback.part.0+0x35/0x80
> [  369.859519]  wait_on_page_writeback+0x27/0x29
> [  369.859521]  __filemap_fdatawait_range+0x88/0xd9
> [  369.859523]  filemap_write_and_wait_range+0x45/0x80
> [  369.859525]  nfs_wb_all+0x30/0x13d
> [  369.859528]  nfs4_file_flush+0x85/0xc0
> [  369.859530]  filp_close+0x3e/0x78
> [  369.859532]  __close_fd+0x23/0x30
> [  369.859534]  __ia32_sys_close+0x22/0x50
> [  369.859536]  __do_fast_syscall_32+0x5f/0x8e
> [  369.859538]  do_fast_syscall_32+0x3d/0x80
> [  369.859540]  entry_SYSCALL_compat_after_hwframe+0x45/0x0
> [  369.859541] RIP: 0023:0xf7ee6549
> [  369.859543] RSP: 002b:000000008c5fddb0 EFLAGS: 00200286 ORIG_RAX: 0000000000000006
> [  369.859545] RAX: ffffffffffffffda RBX: 000000000000004d RCX: 0000000000000002
> [  369.859546] RDX: 0000000000000000 RSI: 00000000f7d02e70 RDI: 000000000000004d
> [  369.859547] RBP: 000000008c5fe110 R08: 0000000000000000 R09: 0000000000000000
> [  369.859548] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  369.859549] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  394.423093] nfs: server loom not responding, still trying
> 
> -- 
> NULL && (void)
