Return-Path: <linux-nfs+bounces-3926-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB41B90B6FF
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 18:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755451F22827
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D73161904;
	Mon, 17 Jun 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP4GyC2D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EA29414;
	Mon, 17 Jun 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642999; cv=none; b=eFu2/kfcAXQpfnp6lo0ZLThVtsf1Ll2Kg/u1qTQ16HNSheM0YzGH1d0EmxX/B5qyqQnKqjnnLprtPE0ahRKJ1J1OZp5eEnHkYxh2xtVEJgCq5zLKpth7INEcm+G1Q3t9M3vXzAvlmQrqTXnk3/92v5o3h2YagfuQCuCWgnv4q7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642999; c=relaxed/simple;
	bh=xFDv5itLWWHNazNZbHJF9p1ZpfZrnLXE/9upJcBITBA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYxj8BzczxCkHuItPUJmENi/6g1IU6vXyx4+gY2PNOIejzsVxSedBLSswB0WhXLTwI9JObHtWstMHAce1/D69umADPDeAdPFp5Fpjv8f6rWI7gKaTUDPpCqQaAONmbtycnPgpCYjGyuipGlGtZivRL/lQZ75jWvH0O8ZhvfM54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP4GyC2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB4FC2BD10;
	Mon, 17 Jun 2024 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642999;
	bh=xFDv5itLWWHNazNZbHJF9p1ZpfZrnLXE/9upJcBITBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FP4GyC2DXPMjQQfKfSVTN7650WDP6rpnHyZYeRcHlaR0T14PQTFKKSJNAUkkMbXAN
	 6d4CWvLOoO/FzKZMX+GzRZHcP+gvV5W5BjyQSCwJ/jP7blh+zYP2Q5gsVRlf5h3dgR
	 m9GEdQmrctcMsQ/5X/t8NjBZfLHY6W10Urle9nRDaMQyjs/i+QSWh/8nXzzWuE02mp
	 U3b124GTMCh4kFYPUJ8w5z8ndRyOTGaBLEO64Gs92s6YuLzNdq0OnIoyBOwBCEKbfz
	 /adOSi9yeSqAUrmwTcCtUlZrKk5KJe4CAY+CAWbL3hSO1aoketBTrMIG5J8EODd0Pk
	 EjrWdsEKnUZLg==
Message-ID: <e651206265ac0736ee2ac8ba8cafefb15822c163.camel@kernel.org>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_get_doit
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, syzbot
	 <syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com>
Cc: Dai.Ngo@oracle.com, chuck.lever@oracle.com, kolga@netapp.com, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com
Date: Mon, 17 Jun 2024 12:49:56 -0400
In-Reply-To: <ZnBjsQazkJK0MyNk@lore-desk>
References: <000000000000322bec061aeb58a3@google.com>
	 <ZnBjsQazkJK0MyNk@lore-desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 18:26 +0200, Lorenzo Bianconi wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:=C2=A0=C2=A0=C2=A0 cea2a26553ac mailmap: Add my outdated ad=
dresses to
> > the map..
> > git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> > console output:
> > https://syzkaller.appspot.com/x/log.txt?x=3D169fd8ee980000
> > kernel config:=C2=A0
> > https://syzkaller.appspot.com/x/.config?x=3Dfa0ce06dcc735711
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=3D4207adf14e7c0981d28d
> > compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 15.0=
.6, GNU ld (GNU Binutils
> > for Debian) 2.40
> >=20
> > Unfortunately, I don't have any reproducer for this issue yet.
> >=20
> > Downloadable assets:
> > disk image:
> > https://storage.googleapis.com/syzbot-assets/1f7ce933512f/disk-cea2a265=
.raw.xz
> > vmlinux:
> > https://storage.googleapis.com/syzbot-assets/0ce3b9940616/vmlinux-cea2a=
265.xz
> > kernel image:
> > https://storage.googleapis.com/syzbot-assets/19e24094ea37/bzImage-cea2a=
265.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to
> > the commit:
> > Reported-by: syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com
> >=20
> > INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.10.0-rc3-syzkaller-00022-g=
cea2a26553ac #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> > message.
> > task:syz-executor.1=C2=A0 state:D stack:23800 pid:17770 tgid:17767
> > ppid:11381=C2=A0 flags:0x00000006
> > Call Trace:
> > =C2=A0<TASK>
> > =C2=A0context_switch kernel/sched/core.c:5408 [inline]
> > =C2=A0__schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
> > =C2=A0__schedule_loop kernel/sched/core.c:6822 [inline]
> > =C2=A0schedule+0x14b/0x320 kernel/sched/core.c:6837
> > =C2=A0schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
> > =C2=A0__mutex_lock_common kernel/locking/mutex.c:684 [inline]
> > =C2=A0__mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
> > =C2=A0nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
> > =C2=A0genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
> > =C2=A0genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
> > =C2=A0genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
> > =C2=A0netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
> > =C2=A0genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> > =C2=A0netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
> > =C2=A0netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
> > =C2=A0netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
> > =C2=A0sock_sendmsg_nosec net/socket.c:730 [inline]
> > =C2=A0__sock_sendmsg+0x223/0x270 net/socket.c:745
> > =C2=A0____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
> > =C2=A0___sys_sendmsg net/socket.c:2639 [inline]
> > =C2=A0__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
> > =C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > =C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f24ed27cea9
> > RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX:
> > 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
> > RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
> > RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >=20
> >=20
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ=C2=A0for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >=20
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status=C2=A0for how to communicate with syzbot.
> >=20
> > If the report is already addressed, let syzbot know by replying
> > with:
> > #syz fix: exact-commit-title
> >=20
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >=20
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >=20
> > If you want to undo deduplication, reply with:
> > #syz undup
> >=20
>=20
> #syz test
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git=C2=A04ddfda=
4
> 17a50
>=20
> From be9676fba16c0b8769c3b6094f35da39b1ba3953 Mon Sep 17 00:00:00
> 2001
> Message-ID:
> <be9676fba16c0b8769c3b6094f35da39b1ba3953.1718640518.git.lorenzo@kern
> el.org>
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Mon, 17 Jun 2024 16:26:26 +0200
> Subject: [PATCH] NFSD: grab nfsd_mutex in
> nfsd_nl_rpc_status_get_dumpit()
>=20
> Grab nfsd_mutex lock in nfsd_nl_rpc_status_get_dumpit routine and
> remove
> nfsd_nl_rpc_status_get_start() and nfsd_nl_rpc_status_get_done().
> This
> patch fix the syzbot log reported below:
>=20
> INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.10.0-rc3-syzkaller-00022-gce=
a2a26553ac #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> task:syz-executor.1=C2=A0 state:D stack:23800 pid:17770 tgid:17767
> ppid:11381=C2=A0 flags:0x00000006
> Call Trace:
> =C2=A0<TASK>
> =C2=A0context_switch kernel/sched/core.c:5408 [inline]
> =C2=A0__schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
> =C2=A0__schedule_loop kernel/sched/core.c:6822 [inline]
> =C2=A0schedule+0x14b/0x320 kernel/sched/core.c:6837
> =C2=A0schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
> =C2=A0__mutex_lock_common kernel/locking/mutex.c:684 [inline]
> =C2=A0__mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
> =C2=A0nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
> =C2=A0genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
> =C2=A0genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
> =C2=A0genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
> =C2=A0netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
> =C2=A0genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
> =C2=A0netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
> =C2=A0netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
> =C2=A0netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
> =C2=A0sock_sendmsg_nosec net/socket.c:730 [inline]
> =C2=A0__sock_sendmsg+0x223/0x270 net/socket.c:745
> =C2=A0____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
> =C2=A0___sys_sendmsg net/socket.c:2639 [inline]
> =C2=A0__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
> =C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> =C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f24ed27cea9
> RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
> RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>=20
> Fixes: 1bd773b4f0c9 ("nfsd: hold nfsd_mutex across entire netlink
> operation")
> Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> =C2=A0Documentation/netlink/specs/nfsd.yaml |=C2=A0 2 --
> =C2=A0fs/nfsd/netlink.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 --
> =C2=A0fs/nfsd/netlink.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 3 --
> =C2=A0fs/nfsd/nfsctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 48 ++++++-------------------
> --
> =C2=A04 files changed, 11 insertions(+), 44 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml
> b/Documentation/netlink/specs/nfsd.yaml
> index 5a98e5a06c68..c87658114852 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -132,8 +132,6 @@ operations:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: dump pending nfsd rpc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attribute-set: rpc-status
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dump:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pre: nfsd-nl-rpc-status-get-s=
tart
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 post: nfsd-nl-rpc-status-get-=
done
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reply:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attributes:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
- xid
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 137701153c9e..ca54aa583530 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -49,9 +49,7 @@ static const struct nla_policy
> nfsd_pool_mode_set_nl_policy[NFSD_A_POOL_MODE_MOD
> =C2=A0static const struct genl_split_ops nfsd_nl_ops[] =3D {
> =C2=A0	{
> =C2=A0		.cmd	=3D NFSD_CMD_RPC_STATUS_GET,
> -		.start	=3D nfsd_nl_rpc_status_get_start,
> =C2=A0		.dumpit	=3D nfsd_nl_rpc_status_get_dumpit,
> -		.done	=3D nfsd_nl_rpc_status_get_done,
> =C2=A0		.flags	=3D GENL_CMD_CAP_DUMP,
> =C2=A0	},
> =C2=A0	{
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index 9459547de04e..8eb903f24c41 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -15,9 +15,6 @@
> =C2=A0extern const struct nla_policy
> nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1];
> =C2=A0extern const struct nla_policy
> nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1];
> =C2=A0
> -int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> -int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> -
> =C2=A0int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> =C2=A0				=C2=A0 struct netlink_callback *cb);
> =C2=A0int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info
> *info);
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index e5d2cc74ef77..78091a73b33b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1468,28 +1468,6 @@ static int create_proc_exports_entry(void)
> =C2=A0
> =C2=A0unsigned int nfsd_net_id;
> =C2=A0
> -/**
> - * nfsd_nl_rpc_status_get_start - Prepare rpc_status_get dumpit
> - * @cb: netlink metadata and command arguments
> - *
> - * Return values:
> - *=C2=A0=C2=A0 %0: The rpc_status_get command may proceed
> - *=C2=A0=C2=A0 %-ENODEV: There is no NFSD running in this namespace
> - */
> -int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb)
> -{
> -	struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk),
> nfsd_net_id);
> -	int ret =3D -ENODEV;
> -
> -	mutex_lock(&nfsd_mutex);
> -	if (nn->nfsd_serv)
> -		ret =3D 0;
> -	else
> -		mutex_unlock(&nfsd_mutex);
> -
> -	return ret;
> -}
> -
> =C2=A0static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
> =C2=A0					=C2=A0=C2=A0=C2=A0 struct netlink_callback
> *cb,
> =C2=A0					=C2=A0=C2=A0=C2=A0 struct nfsd_genl_rqstp
> *rqstp)
> @@ -1566,8 +1544,16 @@ static int
> nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
> =C2=A0int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> =C2=A0				=C2=A0 struct netlink_callback *cb)
> =C2=A0{
> -	struct nfsd_net *nn =3D net_generic(sock_net(skb->sk),
> nfsd_net_id);
> =C2=A0	int i, ret, rqstp_index =3D 0;
> +	struct nfsd_net *nn;
> +
> +	mutex_lock(&nfsd_mutex);
> +
> +	nn =3D net_generic(sock_net(skb->sk), nfsd_net_id);
> +	if (!nn->nfsd_serv) {
> +		ret =3D -ENODEV;
> +		goto out_unlock;
> +	}
> =C2=A0
> =C2=A0	rcu_read_lock();
> =C2=A0
> @@ -1644,22 +1630,10 @@ int nfsd_nl_rpc_status_get_dumpit(struct
> sk_buff *skb,
> =C2=A0	ret =3D skb->len;
> =C2=A0out:
> =C2=A0	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
> -/**
> - * nfsd_nl_rpc_status_get_done - rpc_status_get dumpit post-
> processing
> - * @cb: netlink metadata and command arguments
> - *
> - * Return values:
> - *=C2=A0=C2=A0 %0: Success
> - */
> -int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
> -{
> +out_unlock:
> =C2=A0	mutex_unlock(&nfsd_mutex);
> =C2=A0
> -	return 0;
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0/**

Reviewed-by: Jeff Layton <jlayton@kernel.org>

