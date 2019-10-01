Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601BAC3FDE
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2019 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfJASau (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Oct 2019 14:30:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19517 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJASau (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 1 Oct 2019 14:30:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0797D2546;
        Tue,  1 Oct 2019 18:30:50 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6E735D9C9;
        Tue,  1 Oct 2019 18:30:49 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 0DC27109C550; Tue,  1 Oct 2019 14:30:50 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     James Harvey <jamespharvey20@gmail.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: fix race to sk_err after xs_error_report
Date:   Tue,  1 Oct 2019 14:30:50 -0400
Message-Id: <9796ba15d926f65923965c2aedf777aaa59861e8.1569954618.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 01 Oct 2019 18:30:50 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 4f8943f80883 ("SUNRPC: Replace direct task wakeups from
softirq context") there has been a race to the value of the sk_err if both
XPRT_SOCK_WAKE_ERROR and XPRT_SOCK_WAKE_DISCONNECT are set.  In that case,
we may end up losing the sk_err value that existed when xs_error_report was
called.

Fix this by reverting to the previous behavior: instead of using SO_ERROR
to retrieve the value at a later time (which might also return sk_err_soft),
copy the sk_err value onto struct sock_xprt, and use that value to wake
pending tasks.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Fixes: 4f8943f80883 ("SUNRPC: Replace direct task wakeups from softirq context")
---
 include/linux/sunrpc/xprtsock.h |  1 +
 net/sunrpc/xprtsock.c           | 13 +++++--------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index 7638dbe7bc50..8ffae73dea6c 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -56,6 +56,7 @@ struct sock_xprt {
 	 */
 	unsigned long		sock_state;
 	struct delayed_work	connect_worker;
+	int			xprt_err;
 	struct work_struct	error_worker;
 	struct work_struct	recv_worker;
 	struct mutex		recv_mutex;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e2176c167a57..7fe77eef7080 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1250,12 +1250,12 @@ static void xs_error_report(struct sock *sk)
 		goto out;
 
 	transport = container_of(xprt, struct sock_xprt, xprt);
-	err = -sk->sk_err;
-	if (err == 0)
+	transport->xprt_err = -sk->sk_err;
+	if (transport->xprt_err == 0)
 		goto out;
 	dprintk("RPC:       xs_error_report client %p, error=%d...\n",
-			xprt, -err);
-	trace_rpc_socket_error(xprt, sk->sk_socket, err);
+			xprt, -transport->xprt_err);
+	trace_rpc_socket_error(xprt, sk->sk_socket, transport->xprt_err);
 	xs_run_error_worker(transport, XPRT_SOCK_WAKE_ERROR);
  out:
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -2470,7 +2470,6 @@ static void xs_wake_write(struct sock_xprt *transport)
 static void xs_wake_error(struct sock_xprt *transport)
 {
 	int sockerr;
-	int sockerr_len = sizeof(sockerr);
 
 	if (!test_bit(XPRT_SOCK_WAKE_ERROR, &transport->sock_state))
 		return;
@@ -2479,9 +2478,7 @@ static void xs_wake_error(struct sock_xprt *transport)
 		goto out;
 	if (!test_and_clear_bit(XPRT_SOCK_WAKE_ERROR, &transport->sock_state))
 		goto out;
-	if (kernel_getsockopt(transport->sock, SOL_SOCKET, SO_ERROR,
-				(char *)&sockerr, &sockerr_len) != 0)
-		goto out;
+	sockerr = xchg(&transport->xprt_err, 0);
 	if (sockerr < 0)
 		xprt_wake_pending_tasks(&transport->xprt, sockerr);
 out:
-- 
2.20.1

