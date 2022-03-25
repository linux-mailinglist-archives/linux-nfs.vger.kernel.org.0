Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4951F4E78C8
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Mar 2022 17:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiCYQTo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Mar 2022 12:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350083AbiCYQTn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Mar 2022 12:19:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CA055A3
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 09:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8ABBB82979
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 16:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D32DC340E9
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648225085;
        bh=bxoRtE2cvyWd1cGlIvG//hdo7fF6MZCn8772j8y4Aas=;
        h=From:To:Subject:Date:From;
        b=YJ3Q3gWB3wt0smqtNxeB1rZJlQH1yocK/kRnqOb/UTpTp4m8+EGx/H6twl/yQC8u1
         C461/JxxHYbidtPQOAJetcla2MT+SWEMUckMrm9THuovJGU7R3soFlU1OWckYOli0v
         JGPLir1ACP7rMCQni684zZp5vxBRWlvQxDAZtywHbgWaBkEbCaHVyVCzusBVQsPwHC
         GSHygbJcVokHemo7Xf1TX0znYy0J9bGM2q4hC/2CQoMTWnlN0KzE650jkXSdCRqS6L
         JMjc3hKpYTLbdpEMNcTFB9ZGdHVqncfFmpNpFDpbfpt4vgvNevTgjMJGEq0ACZ8y/3
         A2XGrDVftczpQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] SUNRPC: Do not dereference non-socket transports in sysfs
Date:   Fri, 25 Mar 2022 12:11:37 -0400
Message-Id: <20220325161138.249905-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Do not cast the struct xprt to a sock_xprt unless we know it is a UDP or
TCP transport. Otherwise the call to lock the mutex will scribble over
whatever structure is actually there. This has been seen to cause hard
system lockups when the underlying transport was RDMA.

Fixes: b49ea673e119 ("SUNRPC: lock against ->sock changing during sysfs read")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/xprt.h     |  3 ++
 include/linux/sunrpc/xprtsock.h |  1 -
 net/sunrpc/sysfs.c              | 50 +++++++++++++++++----------------
 net/sunrpc/xprtsock.c           | 26 +++++++++++++++--
 4 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 955ea4d7af0b..eef5e87c03b4 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -139,6 +139,9 @@ struct rpc_xprt_ops {
 	void		(*rpcbind)(struct rpc_task *task);
 	void		(*set_port)(struct rpc_xprt *xprt, unsigned short port);
 	void		(*connect)(struct rpc_xprt *xprt, struct rpc_task *task);
+	int		(*get_srcaddr)(struct rpc_xprt *xprt, char *buf,
+				       size_t buflen);
+	unsigned short	(*get_srcport)(struct rpc_xprt *xprt);
 	int		(*buf_alloc)(struct rpc_task *task);
 	void		(*buf_free)(struct rpc_task *task);
 	void		(*prepare_request)(struct rpc_rqst *req);
diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index 3eb0079669c5..38284f25eddf 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -10,7 +10,6 @@
 
 int		init_socket_xprt(void);
 void		cleanup_socket_xprt(void);
-unsigned short	get_srcport(struct rpc_xprt *);
 
 #define RPC_MIN_RESVPORT	(1U)
 #define RPC_MAX_RESVPORT	(65535U)
diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
index 05c758da6a92..60ff32296da3 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -105,33 +105,34 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
 					   char *buf)
 {
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
-	struct sockaddr_storage saddr;
-	struct sock_xprt *sock;
-	ssize_t ret = -1;
+	size_t buflen = PAGE_SIZE;
+	ssize_t ret = -ENOTSOCK;
 
 	if (!xprt || !xprt_connected(xprt)) {
-		xprt_put(xprt);
-		return -ENOTCONN;
+		ret = -ENOTCONN;
+	} else if (xprt->ops->get_srcaddr) {
+		ret = xprt->ops->get_srcaddr(xprt, buf, buflen);
+		if (ret > 0) {
+			if (ret < buflen - 1) {
+				buf[ret] = '\n';
+				ret++;
+			}
+			if (ret < buflen) {
+				buf[ret] = '\0';
+				ret++;
+			}
+		}
 	}
-
-	sock = container_of(xprt, struct sock_xprt, xprt);
-	mutex_lock(&sock->recv_mutex);
-	if (sock->sock == NULL ||
-	    kernel_getsockname(sock->sock, (struct sockaddr *)&saddr) < 0)
-		goto out;
-
-	ret = sprintf(buf, "%pISc\n", &saddr);
-out:
-	mutex_unlock(&sock->recv_mutex);
 	xprt_put(xprt);
-	return ret + 1;
+	return ret;
 }
 
 static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
-					struct kobj_attribute *attr,
-					char *buf)
+					struct kobj_attribute *attr, char *buf)
 {
 	struct rpc_xprt *xprt = rpc_sysfs_xprt_kobj_get_xprt(kobj);
+	unsigned short srcport = 0;
+	size_t buflen = PAGE_SIZE;
 	ssize_t ret;
 
 	if (!xprt || !xprt_connected(xprt)) {
@@ -139,7 +140,11 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 		return -ENOTCONN;
 	}
 
-	ret = sprintf(buf, "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
+	if (xprt->ops->get_srcport)
+		srcport = xprt->ops->get_srcport(xprt);
+
+	ret = snprintf(buf, buflen,
+		       "last_used=%lu\ncur_cong=%lu\ncong_win=%lu\n"
 		       "max_num_slots=%u\nmin_num_slots=%u\nnum_reqs=%u\n"
 		       "binding_q_len=%u\nsending_q_len=%u\npending_q_len=%u\n"
 		       "backlog_q_len=%u\nmain_xprt=%d\nsrc_port=%u\n"
@@ -147,12 +152,9 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
 		       xprt->last_used, xprt->cong, xprt->cwnd, xprt->max_reqs,
 		       xprt->min_reqs, xprt->num_reqs, xprt->binding.qlen,
 		       xprt->sending.qlen, xprt->pending.qlen,
-		       xprt->backlog.qlen, xprt->main,
-		       (xprt->xprt_class->ident == XPRT_TRANSPORT_TCP) ?
-		       get_srcport(xprt) : 0,
+		       xprt->backlog.qlen, xprt->main, srcport,
 		       atomic_long_read(&xprt->queuelen),
-		       (xprt->xprt_class->ident == XPRT_TRANSPORT_TCP) ?
-				xprt->address_strings[RPC_DISPLAY_PORT] : "0");
+		       xprt->address_strings[RPC_DISPLAY_PORT]);
 	xprt_put(xprt);
 	return ret + 1;
 }
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index b52eaa8a0cda..78af7518f263 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1638,7 +1638,7 @@ static int xs_get_srcport(struct sock_xprt *transport)
 	return port;
 }
 
-unsigned short get_srcport(struct rpc_xprt *xprt)
+static unsigned short xs_sock_srcport(struct rpc_xprt *xprt)
 {
 	struct sock_xprt *sock = container_of(xprt, struct sock_xprt, xprt);
 	unsigned short ret = 0;
@@ -1648,7 +1648,25 @@ unsigned short get_srcport(struct rpc_xprt *xprt)
 	mutex_unlock(&sock->recv_mutex);
 	return ret;
 }
-EXPORT_SYMBOL(get_srcport);
+
+static int xs_sock_srcaddr(struct rpc_xprt *xprt, char *buf, size_t buflen)
+{
+	struct sock_xprt *sock = container_of(xprt, struct sock_xprt, xprt);
+	union {
+		struct sockaddr sa;
+		struct sockaddr_storage st;
+	} saddr;
+	int ret = -ENOTCONN;
+
+	mutex_lock(&sock->recv_mutex);
+	if (sock->sock) {
+		ret = kernel_getsockname(sock->sock, &saddr.sa);
+		if (ret >= 0)
+			ret = snprintf(buf, buflen, "%pISc", &saddr.sa);
+	}
+	mutex_unlock(&sock->recv_mutex);
+	return ret;
+}
 
 static unsigned short xs_next_srcport(struct sock_xprt *transport, unsigned short port)
 {
@@ -2622,6 +2640,8 @@ static const struct rpc_xprt_ops xs_udp_ops = {
 	.rpcbind		= rpcb_getport_async,
 	.set_port		= xs_set_port,
 	.connect		= xs_connect,
+	.get_srcaddr		= xs_sock_srcaddr,
+	.get_srcport		= xs_sock_srcport,
 	.buf_alloc		= rpc_malloc,
 	.buf_free		= rpc_free,
 	.send_request		= xs_udp_send_request,
@@ -2644,6 +2664,8 @@ static const struct rpc_xprt_ops xs_tcp_ops = {
 	.rpcbind		= rpcb_getport_async,
 	.set_port		= xs_set_port,
 	.connect		= xs_connect,
+	.get_srcaddr		= xs_sock_srcaddr,
+	.get_srcport		= xs_sock_srcport,
 	.buf_alloc		= rpc_malloc,
 	.buf_free		= rpc_free,
 	.prepare_request	= xs_stream_prepare_request,
-- 
2.35.1

