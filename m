Return-Path: <linux-nfs+bounces-7567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A798B9B5EE2
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 10:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEAE283D41
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBD1E201C;
	Wed, 30 Oct 2024 09:32:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBB1E1A2B;
	Wed, 30 Oct 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730280763; cv=none; b=Rr1jvs4q7BA3e3Wo/vSr1JAnSh5U+Kbc1edG7Hd/bASaYrjXFYSdYgYO0S4o5ciwbnxERONhgtqrYMaR1Oxtr+tUjYpSi+ezaHcSie9RxjjKg1IWSRXXayAyCZmrs0nFLRmSDk9/fgeSvUN5tjb3IUiASOWwHv0B55Ops2HdhUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730280763; c=relaxed/simple;
	bh=Vz1zeao+5C1Aan/4lWHPC555V7hRfONpgEaV3FUEcZg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qwdsns8RkhioFWb/88rTGK8qel8IORo7SR2TrZSnFfZOzX9zvSG6lnXlFXf55eSyZEdHynIsHr1y9Pp1uuIB6UrtPrv/PfiQrWnfYIgitzZV4/xBA5ZpNvN51PLkW4y4qkMLOUKvOGMSnRf9yC1eYrPESBCml+V0CecNfOhIqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Xdhhm5r80zQsLr;
	Wed, 30 Oct 2024 17:31:36 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D9C21400E3;
	Wed, 30 Oct 2024 17:32:36 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200003.china.huawei.com
 (7.202.181.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Oct
 2024 17:32:35 +0800
From: Liu Jian <liujian56@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<ofir.gal@volumez.com>, <geert+renesas@glider.be>, <ebiederm@xmission.com>
CC: <netdev@vger.kernel.org>, <linux-nfs@vger.kernel.org>
Subject: [PATCH net v2] sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket
Date: Wed, 30 Oct 2024 17:49:53 +0800
Message-ID: <20241030094953.1921574-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200003.china.huawei.com (7.202.181.30)

BUG: KASAN: slab-use-after-free in tcp_write_timer_handler+0x156/0x3e0
Read of size 1 at addr ffff888111f322cd by task swapper/0/0

CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc4-dirty #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
Call Trace:
 <IRQ>
 dump_stack_lvl+0x68/0xa0
 print_address_description.constprop.0+0x2c/0x3d0
 print_report+0xb4/0x270
 kasan_report+0xbd/0xf0
 tcp_write_timer_handler+0x156/0x3e0
 tcp_write_timer+0x66/0x170
 call_timer_fn+0xfb/0x1d0
 __run_timers+0x3f8/0x480
 run_timer_softirq+0x9b/0x100
 handle_softirqs+0x153/0x390
 __irq_exit_rcu+0x103/0x120
 irq_exit_rcu+0xe/0x20
 sysvec_apic_timer_interrupt+0x76/0x90
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20
RIP: 0010:default_idle+0xf/0x20
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90
 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 f8 25 00 fb f4 <fa> c3 cc cc cc
 cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffffffa2007e28 EFLAGS: 00000242
RAX: 00000000000f3b31 RBX: 1ffffffff4400fc7 RCX: ffffffffa09c3196
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9f00590f
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed102360835d
R10: ffff88811b041aeb R11: 0000000000000001 R12: 0000000000000000
R13: ffffffffa202d7c0 R14: 0000000000000000 R15: 00000000000147d0
 default_idle_call+0x6b/0xa0
 cpuidle_idle_call+0x1af/0x1f0
 do_idle+0xbc/0x130
 cpu_startup_entry+0x33/0x40
 rest_init+0x11f/0x210
 start_kernel+0x39a/0x420
 x86_64_start_reservations+0x18/0x30
 x86_64_start_kernel+0x97/0xa0
 common_startup_64+0x13e/0x141
 </TASK>

Allocated by task 595:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 __kasan_slab_alloc+0x87/0x90
 kmem_cache_alloc_noprof+0x12b/0x3f0
 copy_net_ns+0x94/0x380
 create_new_namespaces+0x24c/0x500
 unshare_nsproxy_namespaces+0x75/0xf0
 ksys_unshare+0x24e/0x4f0
 __x64_sys_unshare+0x1f/0x30
 do_syscall_64+0x70/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 100:
 kasan_save_stack+0x24/0x50
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x54/0x70
 kmem_cache_free+0x156/0x5d0
 cleanup_net+0x5d3/0x670
 process_one_work+0x776/0xa90
 worker_thread+0x2e2/0x560
 kthread+0x1a8/0x1f0
 ret_from_fork+0x34/0x60
 ret_from_fork_asm+0x1a/0x30

Reproduction script:

mkdir -p /mnt/nfsshare
mkdir -p /mnt/nfs/netns_1
mkfs.ext4 /dev/sdb
mount /dev/sdb /mnt/nfsshare
systemctl restart nfs-server
chmod 777 /mnt/nfsshare
exportfs -i -o rw,no_root_squash *:/mnt/nfsshare

ip netns add netns_1
ip link add name veth_1_peer type veth peer veth_1
ifconfig veth_1_peer 11.11.0.254 up
ip link set veth_1 netns netns_1
ip netns exec netns_1 ifconfig veth_1 11.11.0.1

ip netns exec netns_1 /root/iptables -A OUTPUT -d 11.11.0.254 -p tcp \
	--tcp-flags FIN FIN  -j DROP

(note: In my environment, a DESTROY_CLIENTID operation is always sent
 immediately, breaking the nfs tcp connection.)
ip netns exec netns_1 timeout -s 9 300 mount -t nfs -o proto=tcp,vers=4.1 \
	11.11.0.254:/mnt/nfsshare /mnt/nfs/netns_1

ip netns del netns_1

The reason here is that the tcp socket in netns_1 (nfs side) has been
shutdown and closed (done in xs_destroy), but the FIN message (with ack)
is discarded, and the nfsd side keeps sending retransmission messages.
As a result, when the tcp sock in netns_1 processes the received message,
it sends the message (FIN message) in the sending queue, and the tcp timer
is re-established. When the network namespace is deleted, the net structure
accessed by tcp's timer handler function causes problems.

To fix this problem:
Add the sock_create_kern_getnet() helper function, add the get_net()
 operation for the kernel socket.

Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
v1: https://lore.kernel.org/all/20241024015543.568476-1-liujian56@huawei.com/
v1->v2: change to get netns reference count.
 include/linux/net.h   |  1 +
 net/socket.c          | 28 ++++++++++++++++++++++++++++
 net/sunrpc/svcsock.c  |  2 +-
 net/sunrpc/xprtsock.c |  2 +-
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index b75bc534c1b3..58216da3b62c 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -255,6 +255,7 @@ int __sock_create(struct net *net, int family, int type, int proto,
 		  struct socket **res, int kern);
 int sock_create(int family, int type, int proto, struct socket **res);
 int sock_create_kern(struct net *net, int family, int type, int proto, struct socket **res);
+int sock_create_kern_getnet(struct net *net, int family, int type, int proto, struct socket **res);
 int sock_create_lite(int family, int type, int proto, struct socket **res);
 struct socket *sock_alloc(void);
 void sock_release(struct socket *sock);
diff --git a/net/socket.c b/net/socket.c
index 042451f01c65..e64a02445b1a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1651,6 +1651,34 @@ int sock_create_kern(struct net *net, int family, int type, int protocol, struct
 }
 EXPORT_SYMBOL(sock_create_kern);
 
+int sock_create_kern_getnet(struct net *net, int family, int type, int proto, struct socket **res)
+{
+	struct sock *sk;
+	int ret;
+
+	if (!maybe_get_net(net))
+		return -EINVAL;
+
+	ret = sock_create_kern(net, family, type, proto, res);
+	if (ret < 0) {
+		put_net(net);
+		return ret;
+	}
+
+	sk = (*res)->sk;
+	lock_sock(sk);
+	/* Update ns_tracker to current stack trace and refcounted tracker */
+	__netns_tracker_free(net, &sk->ns_tracker, false);
+
+	sk->sk_net_refcnt = 1;
+	netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
+	sock_inuse_add(net, 1);
+	release_sock(sk);
+
+	return ret;
+}
+EXPORT_SYMBOL(sock_create_kern_getnet);
+
 static struct socket *__sys_socket_create(int family, int type, int protocol)
 {
 	struct socket *sock;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 825ec5357691..6f272013fd9b 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1526,7 +1526,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = __sock_create(net, family, type, protocol, &sock, 1);
+	error = sock_create_kern_getnet(net, family, type, protocol, &sock);
 	if (error < 0)
 		return ERR_PTR(error);
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 110749b85040..f7734ce5eec9 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1925,7 +1925,7 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 	struct socket *sock;
 	int err;
 
-	err = __sock_create(xprt->xprt_net, family, type, protocol, &sock, 1);
+	err = sock_create_kern_getnet(xprt->xprt_net, family, type, protocol, &sock);
 	if (err < 0) {
 		dprintk("RPC:       can't create %d transport socket (%d).\n",
 				protocol, -err);
-- 
2.34.1


