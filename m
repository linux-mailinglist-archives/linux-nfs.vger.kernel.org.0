Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7F4E7DD9
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Mar 2022 01:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiCYUB7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Mar 2022 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiCYUBo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Mar 2022 16:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A124A77A
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 12:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBFFE61C04
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 18:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1458FC2BBE4
        for <linux-nfs@vger.kernel.org>; Fri, 25 Mar 2022 18:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648231328;
        bh=xgE52ENjsvJaU+eHOhkOn5sUZ+Jg33qJNki2L5qVGa8=;
        h=From:To:Subject:Date:From;
        b=WXLIkRSfMTqaJywov+xHQ9lbIXj8KvQlFwyruzcsvfyWpeJeLz4d8A5zFi0HilRlp
         H/Z7YbtZhdEUxselr3m2bYrNS9/DSI4jPoWnnmo+bX+ntZVRGljH3tvebamhcS4UiM
         VpyMhHiWDvQ3/aDD9g86/WDoZPlmjLvRW19uyIuEBOI9uH0VLGT0SrPc4sA7eCXXEf
         o2qDRPL4k9MtPNl8qP0N7zfJlXSq1bWt2uI70icJ0PxMSry79IimaOR9XhiMX+2T1a
         G3jh28tuq1uL0Jdg4VV8JC4KMgKPHt93ZKb1jv+r5KlOLWh9pNYmglrBZVS/8gHfh0
         n7z7JWe+WcGeQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/2] SUNRPC: Do not dereference non-socket transports in sysfs
Date:   Fri, 25 Mar 2022 13:55:20 -0400
Message-Id: <20220325175521.561344-1-trondmy@kernel.org>
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
v2: Rewrite to use transport switch
v3: remove '\0' from the pseudo-file

 include/linux/sunrpc/xprt.h     |  3 ++
 include/linux/sunrpc/xprtsock.h |  1 -
 net/sunrpc/sysfs.c              | 55 ++++++++++++++++-----------------
 net/sunrpc/xprtsock.c           | 26 ++++++++++++++--
 4 files changed, 54 insertions(+), 31 deletions(-)

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
index 05c758da6a92..9d8a7d9f3e41 100644
--- a/net/sunrpc/sysfs.c
+++ b/net/sunrpc/sysfs.c
@@ -97,7 +97,7 @@ static ssize_t rpc_sysfs_xprt_dstaddr_show(struct kobject *kobj,
 		return 0;
 	ret = sprintf(buf, "%s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
 	xprt_put(xprt);
-	return ret + 1;
+	return ret;
 }
 
 static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
@@ -105,33 +105,31 @@ static ssize_t rpc_sysfs_xprt_srcaddr_show(struct kobject *kobj,
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
+				buf[ret] = '\0';
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
@@ -139,7 +137,11 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
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
@@ -147,14 +149,11 @@ static ssize_t rpc_sysfs_xprt_info_show(struct kobject *kobj,
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
-	return ret + 1;
+	return ret;
 }
 
 static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
@@ -201,7 +200,7 @@ static ssize_t rpc_sysfs_xprt_state_show(struct kobject *kobj,
 	}
 
 	xprt_put(xprt);
-	return ret + 1;
+	return ret;
 }
 
 static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
@@ -220,7 +219,7 @@ static ssize_t rpc_sysfs_xprt_switch_info_show(struct kobject *kobj,
 		      xprt_switch->xps_nunique_destaddr_xprts,
 		      atomic_long_read(&xprt_switch->xps_queuelen));
 	xprt_switch_put(xprt_switch);
-	return ret + 1;
+	return ret;
 }
 
 static ssize_t rpc_sysfs_xprt_dstaddr_store(struct kobject *kobj,
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

