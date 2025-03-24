Return-Path: <linux-nfs+bounces-10784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5BA6E5E5
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 22:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1323A5230
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Mar 2025 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F4E19F421;
	Mon, 24 Mar 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un66cDOM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290115E96
	for <linux-nfs@vger.kernel.org>; Mon, 24 Mar 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853151; cv=none; b=giLaj0kcWVNbokoqYH860QJnpV5gt1hK++5DL5zPDIn6z5G+Nl9YoUk21lzkGAKoqe1PaUgyU7X0FaBjPeITdcE0ACwxJz18vy0dJcFZ+eyxdRVcpt+us4bG6eyFxRf0btggejfJZOjU71kQOoHnuPELVFfTLVlwrtMjs7Ov+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853151; c=relaxed/simple;
	bh=cWTANf1xVGYFl4ZMIKQZawOAAmsSEUySFUkCS9P1wmY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=fZxnxfOGVuhGkJQW6YNhBRptjyn+xnxqL67OgrSGwzbz8t/sJ7Ri7JEUjp+4kVNZ5/zyYY3jvI3G8xnywhAhbLM9CvolrTHIK6KnY2jLVtDP0ar6zeqfq/uHH3q14mVzHFM9Rn/zZxQfcLJkNLqLolx/z0uDvqMHD1HjgjnKH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un66cDOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075FEC4CEDD;
	Mon, 24 Mar 2025 21:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853150;
	bh=cWTANf1xVGYFl4ZMIKQZawOAAmsSEUySFUkCS9P1wmY=;
	h=Subject:From:To:Cc:Date:From;
	b=un66cDOMr19S/jjlTKYuwX4DCgUGD/6rPThOdJp5voQUmgOXNYGD8US0djMB6LMuX
	 cdqFkEFBGEIweNG105ZKLY+Jhs5293tFdIXc0uIPjPE7i0jjYeB8z1hX6i54fOxGp1
	 jl088sxWENV5OWoINCyM9A/jftl+IMAslBSJoDiY4qTIpJm+oHOG66NEO+52OgISjm
	 fbxMqCxtyNg8LtgS+Y5gPGdkSYjxpW+kcPF87/XdPYYJh9XwFvztk8uQk4MRkiTKRP
	 4ztEYyKWq2Lzo7CnA9z6n1w8U2YptoUVoZcLZRqGKkV+haURjHwkwGX4Hs4KKTdZN4
	 fIrSuyXDPfqTA==
Message-ID: <6e7e33f51047df535e2e6a4c33fc54e258910ea9.camel@kernel.org>
Subject: client looping in state recovery after netns teardown
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: clm@fb.com, linux-nfs@vger.kernel.org
Date: Mon, 24 Mar 2025 17:52:28 -0400
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

Hi Trond,

We hit a new failure mode with the containerized NFS client teardown
patches.

The symptoms are that we see the state recovery thread stuck, and then
we see a flusher thread stuck like this:

#0  context_switch (kernel/sched/core.c:5434:2)
#1  __schedule (kernel/sched/core.c:6799:8)
#2  __schedule_loop (kernel/sched/core.c:6874:3)
#3  schedule (kernel/sched/core.c:6889:2)
#4  nfs_wait_bit_killable (fs/nfs/inode.c:77:2)
#5  __wait_on_bit (kernel/sched/wait_bit.c:49:10)
#6  out_of_line_wait_on_bit (kernel/sched/wait_bit.c:64:9)
#7  wait_on_bit_action (./include/linux/wait_bit.h:156:9)
#8  nfs4_wait_clnt_recover (fs/nfs/nfs4state.c:1329:8)
#9  nfs4_client_recover_expired_lease (fs/nfs/nfs4state.c:1347:9)
#10 pnfs_update_layout (fs/nfs/pnfs.c:2133:17)
#11 ff_layout_pg_get_mirror_count_write
(fs/nfs/flexfilelayout/flexfilelayout.c:949:4)
#12 nfs_pageio_setup_mirroring (fs/nfs/pagelist.c:1114:18)
#13 nfs_pageio_add_request (fs/nfs/pagelist.c:1406:2)
#14 nfs_page_async_flush (fs/nfs/write.c:631:7)
#15 nfs_do_writepage (fs/nfs/write.c:657:9)
#16 nfs_writepages_callback (fs/nfs/write.c:684:8)
#17 write_cache_pages (mm/page-writeback.c:2569:11)
#18 nfs_writepages (fs/nfs/write.c:723:9)
#19 do_writepages (mm/page-writeback.c:2612:10)
#20 __writeback_single_inode (fs/fs-writeback.c:1650:8)
#21 writeback_sb_inodes (fs/fs-writeback.c:1942:3)
#22 __writeback_inodes_wb (fs/fs-writeback.c:2013:12)
#23 wb_writeback (fs/fs-writeback.c:2120:15)
#24 wb_check_old_data_flush (fs/fs-writeback.c:2224:10)
#25 wb_do_writeback (fs/fs-writeback.c:2277:11)
#26 wb_workfn (fs/fs-writeback.c:2305:20)
#27 process_one_work (kernel/workqueue.c:3267:2)
#28 process_scheduled_works (kernel/workqueue.c:3348:3)
#29 worker_thread (kernel/workqueue.c:3429:4)
#30 kthread (kernel/kthread.c:388:9)
#31 ret_from_fork (arch/x86/kernel/process.c:147:3)
#32 ret_from_fork_asm+0x11/0x16 (arch/x86/entry/entry_64.S:244)

Turning up some tracepoints, I see this:

 kworker/u1028:1-997456  [159] .....  9027.330396: rpc_task_run_action: tas=
k:0000174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TI=
MEOUT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserve [sun=
rpc]
 kworker/u1028:1-997456  [159] .....  9027.330397: xprt_reserve: task:00001=
74b@00000000 xid=3D0x6bfc099c
 kworker/u1028:1-997456  [159] .....  9027.330397: rpc_task_run_action: tas=
k:0000174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TI=
MEO
UT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserveresult [=
sunrpc]
 kworker/u1028:1-997456  [159] .....  9027.330397: rpc_task_run_action: tas=
k:0000174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TI=
MEO
UT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refresh [sunrpc=
]
 kworker/u1028:1-997456  [159] .....  9027.330399: rpc_task_run_action: tas=
k:0000174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TI=
MEO
UT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refreshresult [=
sunrpc]
 kworker/u1028:1-997456  [159] .....  9027.330399: rpc_task_run_action: tas=
k:0000174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TI=
MEO
UT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_allocate [sunrp=
c]
 kworker/u1028:1-997456  [159] .....  9027.330400: rpc_buf_alloc: task:0000=
174b@00000000 callsize=3D368 recvsize=3D80 status=3D0
 kworker/u1028:1-997456  [159] .....  9027.330400: rpc_task_run_action: tas=
k:0000174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TI=
MEOUT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode [sunr=
pc]
 kworker/u1028:1-997456  [159] .....  9027.330402: rpc_task_run_action: tas=
k:0000174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TI=
MEOUT|NORTO runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 action=
=3Dcall_connect [sunrpc]
 kworker/u1028:1-997456  [159] .....  9027.330403: xprt_reserve_xprt: task:=
0000174b@00000000 snd_task:0000174b
 kworker/u1028:1-997456  [159] .....  9027.330404: xprt_connect: peer=3D[2a=
03:83e4:4002:0:12a::2a]:20492 state=3DLOCKED|BOUND
 kworker/u1028:1-997456  [159] .....  9027.330405: rpc_task_sleep: task:000=
0174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOUT=
|NORTO runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 timeout=3D0=
 queue=3Dxprt_pending
 kworker/u1028:1-997456  [159] .....  9027.330442: rpc_socket_connect: erro=
r=3D-22 socket:[15084763] srcaddr=3D[::]:993 dstaddr=3D[2a03:83e4:4002:0:12=
a::2a]:0 state=3D1 (UNCONNECTED) sk_state=3D7 (CLOSE)
 kworker/u1028:1-997456  [159] .....  9027.330443: rpc_task_wakeup: task:00=
00174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOU=
T|NORTO runstate=3DQUEUED|ACTIVE|NEED_XMIT|NEED_RECV status=3D-22 timeout=
=3D60000 queue=3Dxprt_pending
 kworker/u1028:1-997456  [159] .....  9027.330444: xprt_disconnect_force: p=
eer=3D[2a03:83e4:4002:0:12a::2a]:20492 state=3DLOCKED|CONNECTING|BOUND|SND_=
IS_COOKIE
 kworker/u1028:1-997456  [159] .....  9027.330444: xprt_release_xprt: task:=
ffffffff@ffffffff snd_task:ffffffff
 kworker/u1028:1-997456  [159] .....  9027.330445: rpc_task_run_action: tas=
k:0000174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TI=
MEOUT|NORTO runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-22 acti=
on=3Dcall_connect_status [sunrpc]
 kworker/u1028:1-997456  [159] .....  9027.330446: rpc_connect_status: task=
:0000174b@00000000 status=3D-22
 kworker/u1028:1-997456  [159] .....  9027.330446: rpc_call_rpcerror: task:=
0000174b@00000000 tk_status=3D-22 rpc_status=3D-22
 kworker/u1028:1-997456  [159] .....  9027.330446: rpc_task_run_action: tas=
k:0000174b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TI=
MEO
UT|NORTO runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-22 action=
=3Drpc_exit_task [sunrpc]
 kworker/u1028:1-997456  [159] .....  9027.330447: rpc_task_end: task:00001=
74b@00000000 flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOUT|N=
ORTO runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-22 action=3Drp=
c_exit_task [sunrpc]

There is no traffic on the wire. So, the problem seems to be in this
situation that we're calling call_connect, and getting back -EINVAL
from the network layer, which doesn't trigger the -ENETUNREACH
handling.

Is this a bug from the network layer, or do we also need to handle -
EINVAL in call_connect_status?

...or do we need a different fix?

Thoughts?
--=20
Jeff Layton <jlayton@kernel.org>

