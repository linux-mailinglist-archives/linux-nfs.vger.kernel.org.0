Return-Path: <linux-nfs+bounces-3920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F8B90B64E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1651C21E67
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED614D6ED;
	Mon, 17 Jun 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHdppmDl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860B847A;
	Mon, 17 Jun 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641590; cv=none; b=HpGXiQZgKsLPPV5/A3kIprGs+8AeC5JACVM1ocXQ5mzjlg1IklvnRXjWVt8RyBColBP/uo0OLHlUKrN0btWyd8xlQKJEBBhzBj0Bban0c5FVJ3SxinBybr295KEzUSkB1+1eSoQ7HN8LMERJaCV4gNFLYbNL0OszFNFwf8P6r9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641590; c=relaxed/simple;
	bh=x/+rYjgcBrv/kxkvx4UsKVg2EWz//HXLjLduTq0c2lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9W68H/yWneOZimM6kPi3w/Kv78jO8qYROjCy6WbY0WY8+uG8g8YYPNlJD8Aak6uv995R1nhpuJq3GuQw/v48vGAVD7skuaAssnq8ytg8mnKQshfUgxVEaRvqr88zAqPGwk1DEnICgIbJU0FPUQ8NrhjvcFzPTwbcXAW8Rr8Y3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHdppmDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0261EC2BD10;
	Mon, 17 Jun 2024 16:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718641589;
	bh=x/+rYjgcBrv/kxkvx4UsKVg2EWz//HXLjLduTq0c2lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHdppmDlpM4t132ZQcmIVBl5QfAiUQa5DxHFGjz1t7ZeUXtm/uA73Y1FYkubYeXqz
	 IKpu2WbLbZD3cY290HxG/bi29Xi3BZpngTL7vmJqvD4PluHl/2G1iiT/zdj8U5deGK
	 GLGdoVmNMIrpa+9aEuAnOge+RaPmmQ8CdwNSEpE9fIx9RwbaNFk8E+bA9MYAJtqgit
	 Nd5Udy4UOFGPO6fVmxLy6AWEcMyO+7VHpo4iuqbTXqi5NELyMFtpiZo2i5KdU1OO9Z
	 dNJnRG9hEwCQ44Ct/4wA/KLnSIvbP1z+ArfeMVMHpIz7GsFbsJYaHkbz3ZJB9rvtt0
	 YGh7pSq01eLwg==
Date: Mon, 17 Jun 2024 18:26:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: syzbot <syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com>
Cc: Dai.Ngo@oracle.com, chuck.lever@oracle.com, jlayton@kernel.org,
	kolga@netapp.com, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, neilb@suse.de,
	syzkaller-bugs@googlegroups.com, tom@talpey.com
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_get_doit
Message-ID: <ZnBjsQazkJK0MyNk@lore-desk>
References: <000000000000322bec061aeb58a3@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ff2ky68OnslJ7cew"
Content-Disposition: inline
In-Reply-To: <000000000000322bec061aeb58a3@google.com>


--ff2ky68OnslJ7cew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    cea2a26553ac mailmap: Add my outdated addresses to the ma=
p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D169fd8ee980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfa0ce06dcc735=
711
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4207adf14e7c098=
1d28d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1f7ce933512f/dis=
k-cea2a265.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0ce3b9940616/vmlinu=
x-cea2a265.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/19e24094ea37/b=
zImage-cea2a265.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+4207adf14e7c0981d28d@syzkaller.appspotmail.com
>=20
> INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
>       Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D stack:23800 pid:17770 tgid:17767 ppid:11381 =
 flags:0x00000006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5408 [inline]
>  __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
>  __schedule_loop kernel/sched/core.c:6822 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6837
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x223/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
>  ___sys_sendmsg net/socket.c:2639 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f24ed27cea9
> RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
> RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup
>=20

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git 4dd=
fda417a50

=46rom be9676fba16c0b8769c3b6094f35da39b1ba3953 Mon Sep 17 00:00:00 2001
Message-ID: <be9676fba16c0b8769c3b6094f35da39b1ba3953.1718640518.git.lorenz=
o@kernel.org>
=46rom: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 17 Jun 2024 16:26:26 +0200
Subject: [PATCH] NFSD: grab nfsd_mutex in nfsd_nl_rpc_status_get_dumpit()

Grab nfsd_mutex lock in nfsd_nl_rpc_status_get_dumpit routine and remove
nfsd_nl_rpc_status_get_start() and nfsd_nl_rpc_status_get_done(). This
patch fix the syzbot log reported below:

INFO: task syz-executor.1:17770 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller-00022-gcea2a26553ac #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:23800 pid:17770 tgid:17767 ppid:11381  f=
lags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 nfsd_nl_listener_get_doit+0x115/0x5d0 fs/nfsd/nfsctl.c:2124
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb16/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ec/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24ed27cea9
RSP: 002b:00007f24ee0080c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f24ed3b3f80 RCX: 00007f24ed27cea9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007f24ed2ebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000

Fixes: 1bd773b4f0c9 ("nfsd: hold nfsd_mutex across entire netlink operation=
")
Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  2 --
 fs/nfsd/netlink.c                     |  2 --
 fs/nfsd/netlink.h                     |  3 --
 fs/nfsd/nfsctl.c                      | 48 ++++++---------------------
 4 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/=
specs/nfsd.yaml
index 5a98e5a06c68..c87658114852 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -132,8 +132,6 @@ operations:
       doc: dump pending nfsd rpc
       attribute-set: rpc-status
       dump:
-        pre: nfsd-nl-rpc-status-get-start
-        post: nfsd-nl-rpc-status-get-done
         reply:
           attributes:
             - xid
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 137701153c9e..ca54aa583530 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -49,9 +49,7 @@ static const struct nla_policy nfsd_pool_mode_set_nl_poli=
cy[NFSD_A_POOL_MODE_MOD
 static const struct genl_split_ops nfsd_nl_ops[] =3D {
 	{
 		.cmd	=3D NFSD_CMD_RPC_STATUS_GET,
-		.start	=3D nfsd_nl_rpc_status_get_start,
 		.dumpit	=3D nfsd_nl_rpc_status_get_dumpit,
-		.done	=3D nfsd_nl_rpc_status_get_done,
 		.flags	=3D GENL_CMD_CAP_DUMP,
 	},
 	{
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 9459547de04e..8eb903f24c41 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -15,9 +15,6 @@
 extern const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_N=
AME + 1];
 extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABL=
ED + 1];
=20
-int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
-int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
-
 int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb);
 int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e5d2cc74ef77..78091a73b33b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1468,28 +1468,6 @@ static int create_proc_exports_entry(void)
=20
 unsigned int nfsd_net_id;
=20
-/**
- * nfsd_nl_rpc_status_get_start - Prepare rpc_status_get dumpit
- * @cb: netlink metadata and command arguments
- *
- * Return values:
- *   %0: The rpc_status_get command may proceed
- *   %-ENODEV: There is no NFSD running in this namespace
- */
-int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb)
-{
-	struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net_id);
-	int ret =3D -ENODEV;
-
-	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv)
-		ret =3D 0;
-	else
-		mutex_unlock(&nfsd_mutex);
-
-	return ret;
-}
-
 static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 					    struct netlink_callback *cb,
 					    struct nfsd_genl_rqstp *rqstp)
@@ -1566,8 +1544,16 @@ static int nfsd_genl_rpc_status_compose_msg(struct s=
k_buff *skb,
 int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb)
 {
-	struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id);
 	int i, ret, rqstp_index =3D 0;
+	struct nfsd_net *nn;
+
+	mutex_lock(&nfsd_mutex);
+
+	nn =3D net_generic(sock_net(skb->sk), nfsd_net_id);
+	if (!nn->nfsd_serv) {
+		ret =3D -ENODEV;
+		goto out_unlock;
+	}
=20
 	rcu_read_lock();
=20
@@ -1644,22 +1630,10 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
 	ret =3D skb->len;
 out:
 	rcu_read_unlock();
-
-	return ret;
-}
-
-/**
- * nfsd_nl_rpc_status_get_done - rpc_status_get dumpit post-processing
- * @cb: netlink metadata and command arguments
- *
- * Return values:
- *   %0: Success
- */
-int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
-{
+out_unlock:
 	mutex_unlock(&nfsd_mutex);
=20
-	return 0;
+	return ret;
 }
=20
 /**
--=20
2.45.1



--ff2ky68OnslJ7cew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnBjsQAKCRA6cBh0uS2t
rFYwAP9U6eWF8ZOcb7ZDWrjswBZhE52XDShnFMYeqAHpGomlhwEAg7N1Pubd+rHs
HwFhSWm4NpaNZjC1q3DXl7BgoqUdsQY=
=hn83
-----END PGP SIGNATURE-----

--ff2ky68OnslJ7cew--

