Return-Path: <linux-nfs+bounces-10786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 923C1A6E76A
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 01:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254241890ACA
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 00:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D37BA927;
	Tue, 25 Mar 2025 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj6181ac"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764322F42
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742861750; cv=none; b=CrRpNNvKVlbKDmPHFOUpmPnrRMECsBPZ6TUPTALtXTsNVj/ikRrIf/CDpHzK88GaKSZnrFSOPSo3K2lmosg2tLUGY04yv7f8a2jJmhz/Nqk+uSFiGSthBkpw7SlrKu1H+MkJpL/0HaA01fpHe1+P3wcRAzTrNlNNoLKQq2pg9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742861750; c=relaxed/simple;
	bh=mJoO3vjq+EWXuXTlZP+xTQzVmC2BomhESUp8ZVxNr4U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plOaiKy82Ohn7Os5U4JzgrCUwjk2mF/4St13YnUTnpO9NhQThd8AahITXhcyoVez7C4BNGaNnp5SqgsZwUJXkTJy0OgwubIn4n+ETD4ikrK6SL/tLe96tzjuOfgqrPuHhPjTYfJZ25nsFAGmvB+L87MI+/JQ38T+FLSho+6908Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj6181ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D08C4CEDD;
	Tue, 25 Mar 2025 00:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742861750;
	bh=mJoO3vjq+EWXuXTlZP+xTQzVmC2BomhESUp8ZVxNr4U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nj6181acYjb2FBwqEIYAtGqXQMi/pYegAA2bRaBJL98RVxJvt3owQuV5ZqwWShpm2
	 9Rw073qSQ4pmsrSvPKpDuosARwD8SZN0Fk2alnlYvMI4VUXXcYzkEvFy186Mrj0fer
	 HHZOvNrh6o8TQVg6RdG6sZ0Zx1KreNA1c2w92Nm1YKy4gEIsNy4XIAROBT7aZQ/fNV
	 84Gommudl2CzYMDS1RMorWVJlXImmExZz5SaQ8+bjc2Oyv4MLSx/U5+8oOSrZGeYo1
	 4q4TvIXF3L/I1e48m+gsgt+gt4TZ81ZfmjlGKjC4QQqIvGwISyof834cGZZWs/7Chl
	 axPX499qo75rQ==
Message-ID: <b799e9cb5b60e08186431915bda5111604fda4b3.camel@kernel.org>
Subject: Re: client looping in state recovery after netns teardown
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "clm@fb.com"
	 <clm@fb.com>
Date: Mon, 24 Mar 2025 20:15:48 -0400
In-Reply-To: <1f2d9f709a8b7b0f0746b90672f9a1f5293cba0a.camel@hammerspace.com>
References: <6e7e33f51047df535e2e6a4c33fc54e258910ea9.camel@kernel.org>
	 <1f2d9f709a8b7b0f0746b90672f9a1f5293cba0a.camel@hammerspace.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: multipart/mixed; boundary="=-UaR5zke1wCe4GfoTS840"
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-UaR5zke1wCe4GfoTS840
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-03-24 at 22:49 +0000, Trond Myklebust wrote:
> On Mon, 2025-03-24 at 17:52 -0400, Jeff Layton wrote:
> > Hi Trond,
> >=20
> > We hit a new failure mode with the containerized NFS client teardown
> > patches.
> >=20
> > The symptoms are that we see the state recovery thread stuck, and
> > then
> > we see a flusher thread stuck like this:
> >=20
> > #0=C2=A0 context_switch (kernel/sched/core.c:5434:2)
> > #1=C2=A0 __schedule (kernel/sched/core.c:6799:8)
> > #2=C2=A0 __schedule_loop (kernel/sched/core.c:6874:3)
> > #3=C2=A0 schedule (kernel/sched/core.c:6889:2)
> > #4=C2=A0 nfs_wait_bit_killable (fs/nfs/inode.c:77:2)
> > #5=C2=A0 __wait_on_bit (kernel/sched/wait_bit.c:49:10)
> > #6=C2=A0 out_of_line_wait_on_bit (kernel/sched/wait_bit.c:64:9)
> > #7=C2=A0 wait_on_bit_action (./include/linux/wait_bit.h:156:9)
> > #8=C2=A0 nfs4_wait_clnt_recover (fs/nfs/nfs4state.c:1329:8)
> > #9=C2=A0 nfs4_client_recover_expired_lease (fs/nfs/nfs4state.c:1347:9)
> > #10 pnfs_update_layout (fs/nfs/pnfs.c:2133:17)
> > #11 ff_layout_pg_get_mirror_count_write
> > (fs/nfs/flexfilelayout/flexfilelayout.c:949:4)
> > #12 nfs_pageio_setup_mirroring (fs/nfs/pagelist.c:1114:18)
> > #13 nfs_pageio_add_request (fs/nfs/pagelist.c:1406:2)
> > #14 nfs_page_async_flush (fs/nfs/write.c:631:7)
> > #15 nfs_do_writepage (fs/nfs/write.c:657:9)
> > #16 nfs_writepages_callback (fs/nfs/write.c:684:8)
> > #17 write_cache_pages (mm/page-writeback.c:2569:11)
> > #18 nfs_writepages (fs/nfs/write.c:723:9)
> > #19 do_writepages (mm/page-writeback.c:2612:10)
> > #20 __writeback_single_inode (fs/fs-writeback.c:1650:8)
> > #21 writeback_sb_inodes (fs/fs-writeback.c:1942:3)
> > #22 __writeback_inodes_wb (fs/fs-writeback.c:2013:12)
> > #23 wb_writeback (fs/fs-writeback.c:2120:15)
> > #24 wb_check_old_data_flush (fs/fs-writeback.c:2224:10)
> > #25 wb_do_writeback (fs/fs-writeback.c:2277:11)
> > #26 wb_workfn (fs/fs-writeback.c:2305:20)
> > #27 process_one_work (kernel/workqueue.c:3267:2)
> > #28 process_scheduled_works (kernel/workqueue.c:3348:3)
> > #29 worker_thread (kernel/workqueue.c:3429:4)
> > #30 kthread (kernel/kthread.c:388:9)
> > #31 ret_from_fork (arch/x86/kernel/process.c:147:3)
> > #32 ret_from_fork_asm+0x11/0x16 (arch/x86/entry/entry_64.S:244)
> >=20
> > Turning up some tracepoints, I see this:
> >=20
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330396:
> > rpc_task_run_action: task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOUT|NORTO
> > runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserve [sunrpc]
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330397: xprt_=
reserve:
> > task:0000174b@00000000 xid=3D0x6bfc099c
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330397:
> > rpc_task_run_action: task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEO
> > UT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserveresu=
lt
> > [sunrpc]
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330397:
> > rpc_task_run_action: task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEO
> > UT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refresh
> > [sunrpc]
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330399:
> > rpc_task_run_action: task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEO
> > UT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refreshresu=
lt
> > [sunrpc]
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330399:
> > rpc_task_run_action: task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEO
> > UT|NORTO runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_allocate
> > [sunrpc]
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330400: rpc_b=
uf_alloc:
> > task:0000174b@00000000 callsize=3D368 recvsize=3D80 status=3D0
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330400:
> > rpc_task_run_action: task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOUT|NORTO
> > runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode [sunrpc]
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330402:
> > rpc_task_run_action: task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOUT|NORTO
> > runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0
> > action=3Dcall_connect [sunrpc]
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330403: xprt_=
reserve_xprt:
> > task:0000174b@00000000 snd_task:0000174b
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330404: xprt_=
connect:
> > peer=3D[2a03:83e4:4002:0:12a::2a]:20492 state=3DLOCKED|BOUND
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330405: rpc_t=
ask_sleep:
> > task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOUT|NORTO
> > runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0 timeout=3D0
> > queue=3Dxprt_pending
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330442:
> > rpc_socket_connect: error=3D-22 socket:[15084763] srcaddr=3D[::]:993
> > dstaddr=3D[2a03:83e4:4002:0:12a::2a]:0 state=3D1 (UNCONNECTED) sk_state=
=3D7
> > (CLOSE)
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330443: rpc_t=
ask_wakeup:
> > task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOUT|NORTO
> > runstate=3DQUEUED|ACTIVE|NEED_XMIT|NEED_RECV status=3D-22 timeout=3D600=
00
> > queue=3Dxprt_pending
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330444:
> > xprt_disconnect_force: peer=3D[2a03:83e4:4002:0:12a::2a]:20492
> > state=3DLOCKED|CONNECTING|BOUND|SND_IS_COOKIE
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330444: xprt_=
release_xprt:
> > task:ffffffff@ffffffff snd_task:ffffffff
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330445:
> > rpc_task_run_action: task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOUT|NORTO
> > runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-22
> > action=3Dcall_connect_status [sunrpc]
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330446:
> > rpc_connect_status: task:0000174b@00000000 status=3D-22
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330446: rpc_c=
all_rpcerror:
> > task:0000174b@00000000 tk_status=3D-22 rpc_status=3D-22
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330446:
> > rpc_task_run_action: task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEO
> > UT|NORTO runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-22
> > action=3Drpc_exit_task [sunrpc]
> > =C2=A0kworker/u1028:1-997456=C2=A0 [159] .....=C2=A0 9027.330447: rpc_t=
ask_end:
> > task:0000174b@00000000
> > flags=3DASYNC|MOVEABLE|NETUNREACH_FATAL|DYNAMIC|SOFT|TIMEOUT|NORTO
> > runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-22
> > action=3Drpc_exit_task [sunrpc]
> >=20
> > There is no traffic on the wire. So, the problem seems to be in this
> > situation that we're calling call_connect, and getting back -EINVAL
> > from the network layer, which doesn't trigger the -ENETUNREACH
> > handling.
> >=20
> > Is this a bug from the network layer, or do we also need to handle -
> > EINVAL in call_connect_status?
> >=20
> > ...or do we need a different fix?
> >=20
> > Thoughts?
>=20
> We need a way to pass down to the client calling
> nfs4_client_recover_expired_lease() that the client is terminally gone
> away, and that it should stop looping.
> I'm thinking that we probably need to mark the client as errored out by
> using a call to nfs_mark_client_ready() to set clp->cl_cons_state in
> error.
>=20
> However I do find it odd that we're seeing an EINVAL error instead of
> ENETUNREACH.
>=20

Same.

> It looks from your traces above as if that is coming from
> the call to xs_tcp_finish_connecting(), which almost has to mean that
> it is being returned by kernel_connect().
> Hmm. Maybe it is this: "dstaddr=3D[2a03:83e4:4002:0:12a::2a]:0"? A zero
> port value might explain it...

That sounds entirely plausible.

Here is the whole trace buffer. It sort of looks like the port isn't 0,
in xprt_disconnect_auto/_force(), but in rpc_socket_connect() it
definitely is. I see no calls to call_bind() in here too, which is also
odd if the port is really 0.
--=20
Jeff Layton <jlayton@kernel.org>

--=-UaR5zke1wCe4GfoTS840
Content-Type: application/gzip; name="nfs-port0.txt.gz"
Content-Disposition: attachment; filename="nfs-port0.txt.gz"
Content-Transfer-Encoding: base64

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


--=-UaR5zke1wCe4GfoTS840--

