Return-Path: <linux-nfs+bounces-17115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6ECCC1F67
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 11:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C1003018949
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0623358D5;
	Tue, 16 Dec 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WmVBZ+WI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1C29B777;
	Tue, 16 Dec 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880872; cv=none; b=a0ydIxT7QYU2FwwOxQWDiU7SUhax3wVLwSsNNwi2SI/Pzh90wM+CFyRnctxFciHS0yhWtHj2r7XSP2AD+ukhxLu3++Zobm44OYGCYVdJxuoEQ5fMWmoYLbwJ1P05fjZpsmF/uKzYOa+AVLLPchggK22A9AuvjJMGCyrz/yAGckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880872; c=relaxed/simple;
	bh=QN+f1RRBVXy2K8qV0jJk3vTIiJSWfrUzJ8LJjNrGDlc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XbTbC5Hyvr7nAwzJZlHWmfrruitaY5jkM+7/rkRBMlYhz3XU1MnCQQFeshReOOiByBbK98sfKJezezsKxSI5zn134kwNlN+uJ3rfJqiz6z0RJfVnEdVTACPONTbrCOJgJ/+XRZwgkW2eeLWANAHFHtruvRQxjM0GBtYW0ceS75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WmVBZ+WI; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765880861; bh=AaXcFD1jzEfYHQfie4D5v7+FvbRXj76sqVrNaTd5ZGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WmVBZ+WIWEetMb/ynq7CaEqY6FZ27f3SZIG+omOVyRJUe2rgxkEl6oA4EygAdTc86
	 C0ncnQweo4uzSRiF4RWCAGT+GB+FjbTkqOXAY3nLFywQnd3MMl7JmNNUv0uARQ9lpn
	 nHFOzZ3lAn24Toxzlz6udT4us1FJlTMZaQDgYnb0=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 6E58F4BF; Tue, 16 Dec 2025 18:27:37 +0800
X-QQ-mid: xmsmtpt1765880857tygqs5kwc
Message-ID: <tencent_4DA6D7B3792370296083BAC4525778776405@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJxovtrM+E6kyzXYwfYCMZw0xHbCiAp1G6QECHL/zer1OXAf2rN6
	 OLzU2iJkGUqfS1mVe3A9obEfiAJlP/n4Vd4zMk7dgFCkqjtjzqz4jwCyMyrcH+p+v6/UZIiM1rYa
	 zma6meT5vJ3KoB1bdGpPp0j0PsnDnTINBnsHE6kyd6PBqDLW1k6AXw6kr4rzr1uSTwGQXOzAjoZ4
	 mD+kVnxMPwIpJB2XnRIQgmlcJI6Tgdgs6i9UNdz8edurDbefK+Wi91abUmENYufwkWdi5uYHG/W1
	 WpFF5T8P6dS4WUmcsRDjgWQ+/P0DvzLwy3HiU2xX4lQ1kUujdcIxGChCfX+veYMmHDK2kK+3aYs0
	 GJOoRkzLOs4oaGudXuOvjyccH13CDThaZ9rRvyo0XBi7xwVOvg/z9jLgr+xFKbiFChjz6GcF811S
	 6xj0tDdF3VfCuq00CQxBppslR5MEg0w3eLjPx4XfRQH9BhrRY3l967cWt7F0YMiIv0igggyxTm8h
	 8jrXzwzGb5MkABVeiqvle+Bk/P9UvK1IA+MfiPQgysDHDH1b7+ryvbVrX6ziBYmd1CF4S6dFlzDW
	 tc1rqhn9voX/f0jD1j7UTN5qP/RYvw44EXtpzMTwU1yT5M1RdU4U9bEVONczokejHdGjCP6HlDdH
	 d+F10O76ABzzA9ER6YArQpYx6mHGxqKSF+zTlSOX7I8ue4s2cLsBH61WNaLQPnRjKVDPikxvzt6N
	 qUY5DdCzTOi84XhwLB0bSm3OwNJSN1CjTxUuuM4Z4s1ZQDhChd88UGJs8vPC6lHeQKbmrEDLyN+g
	 YwxaaH3gF2H/4A2djws+DMiHK9v3B/K5iOaIwqGGU0w3Y34IsO4EhId0AIE9eY/BRdUxzD7Qg+Fz
	 N84rktg4fiTYyBEhbVrowwGIMrzmnO/8A+j3CTRYf7H9zzRnmmoT0ZXuUX2C1PSWBsUztMA8LpTG
	 AOrpMmUjKY5wVQkuwS0c/f+fe4ypmWIRiomZeWzxhguLTclnO5d9tJ+gra8yHrMORJMs8faFpjDu
	 kRAejuGQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com
Cc: Dai.Ngo@oracle.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	syzkaller-bugs@googlegroups.com,
	tom@talpey.com
Subject: [PATCH] NFSD: net ref data still needs to be freed even if net hasn't startup
Date: Tue, 16 Dec 2025 18:27:37 +0800
X-OQ-MSGID: <20251216102737.25532-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69410b4b.a70a0220.104cf0.0347.GAE@google.com>
References: <69410b4b.a70a0220.104cf0.0347.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the NFSD instance doesn't to startup, the net ref data memory is
not properly reclaimed, which triggers the memory leak issue reported
by syzbot [1].

To avoid the problem reported in [1], the net ref data memory reclamation
action is moved outside of nfsd_net_up when the net is shutdown.

[1]
BUG: memory leak
unreferenced object 0xffff88812a39dfc0 (size 64):
  backtrace (crc a2262fc6):
    percpu_ref_init+0x94/0x1e0 lib/percpu-refcount.c:76
    nfsd_create_serv+0xbe/0x260 fs/nfsd/nfssvc.c:605
    nfsd_nl_listener_set_doit+0x62/0xb00 fs/nfsd/nfsctl.c:1882
    genl_family_rcv_msg_doit+0x11e/0x190 net/netlink/genetlink.c:1115
    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
    genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1210
    
Reported-by: syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6ee3b889bdeada0a6226
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/nfsd/nfssvc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b08ae85d53ef..e2b2cf0dd013 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -406,26 +406,26 @@ static void nfsd_shutdown_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	if (!nn->nfsd_net_up)
-		return;
-
-	percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
-	wait_for_completion(&nn->nfsd_net_confirm_done);
-
-	nfsd_export_flush(net);
-	nfs4_state_shutdown_net(net);
-	nfsd_reply_cache_shutdown(nn);
-	nfsd_file_cache_shutdown_net(net);
-	if (nn->lockd_up) {
-		lockd_down(net);
-		nn->lockd_up = false;
+	if (nn->nfsd_net_up) {
+		percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
+		wait_for_completion(&nn->nfsd_net_confirm_done);
+
+		nfsd_export_flush(net);
+		nfs4_state_shutdown_net(net);
+		nfsd_reply_cache_shutdown(nn);
+		nfsd_file_cache_shutdown_net(net);
+		if (nn->lockd_up) {
+			lockd_down(net);
+			nn->lockd_up = false;
+		}
+		wait_for_completion(&nn->nfsd_net_free_done);
 	}
 
-	wait_for_completion(&nn->nfsd_net_free_done);
 	percpu_ref_exit(&nn->nfsd_net_ref);
 
+	if (nn->nfsd_net_up)
+		nfsd_shutdown_generic();
 	nn->nfsd_net_up = false;
-	nfsd_shutdown_generic();
 }
 
 static DEFINE_SPINLOCK(nfsd_notifier_lock);
-- 
2.43.0


