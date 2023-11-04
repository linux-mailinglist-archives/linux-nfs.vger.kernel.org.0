Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5965C7E0F06
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Nov 2023 12:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjKDLO1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Nov 2023 07:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjKDLO0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Nov 2023 07:14:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A445E1BD
        for <linux-nfs@vger.kernel.org>; Sat,  4 Nov 2023 04:14:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB94AC433C8;
        Sat,  4 Nov 2023 11:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699096463;
        bh=8QOwRw5NzPh2NmltfMjV5zZwIWR4GIWze3KPND0XmXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlPZPX9MvLqcIUq8n4j+NjGz+FHdgEYopkd18nVZsmffwPgkN3eq7NrpdVYZN/lBV
         1LD0601xipejSwNfVdoUJhMuR09MwJbxMbnWlphMo82nOtfGNbWM/j6VQDc+yilN7q
         4KPqD1BZKGp+KcKcie26c9v2tS7nEg5KaPqcV2HvnHwQTyyHQTFqpyn4CQfGl/clKt
         uKRx7m/2OzTQqqjXWvBgsyXes9x8LeIm5nQTW8PzMeWhjG1t83ADvMixW/PzlPqzi/
         Fr3cuSSO8gZ1gpK5x6Vi9eTg3umyDWNDRtAmCTH/A7AroMRnqcM1gQpXesTi0RxYt/
         C/xyszxlCbw1Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, neilb@suse.de, chuck.lever@oracle.com,
        netdev@vger.kernel.org, jlayton@kernel.org, kuba@kernel.org
Subject: [PATCH v4 3/3] NFSD: convert write_ports to netlink command
Date:   Sat,  4 Nov 2023 12:13:47 +0100
Message-ID: <153b94db12b5c8fff270706673afffad5d84938c.1699095665.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699095665.git.lorenzo@kernel.org>
References: <cover.1699095665.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce write_ports netlink command similar to the ones available
through the procfs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  28 +++++++
 fs/nfsd/netlink.c                     |  18 +++++
 fs/nfsd/netlink.h                     |   3 +
 fs/nfsd/nfsctl.c                      | 104 ++++++++++++++++++++++++--
 include/uapi/linux/nfsd_netlink.h     |  10 +++
 tools/net/ynl/generated/nfsd-user.c   |  81 ++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h   |  54 +++++++++++++
 7 files changed, 291 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 6c5e42bb20f6..1c342ad3c5fa 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -80,6 +80,15 @@ attribute-sets:
       -
         name: status
         type: u8
+  -
+    name: server-listener
+    attributes:
+      -
+        name: transport-name
+        type: string
+      -
+        name: port
+        type: u32
 
 operations:
   list:
@@ -142,3 +151,22 @@ operations:
           attributes:
             - major
             - minor
+    -
+      name: listener-start
+      doc: start server listener
+      attribute-set: server-listener
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - transport-name
+            - port
+    -
+      name: listener-get
+      doc: dump server listeners
+      attribute-set: server-listener
+      dump:
+        reply:
+          attributes:
+            - transport-name
+            - port
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 0608a7bd193b..cd51393ede72 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -22,6 +22,12 @@ static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_VERSION_
 	[NFSD_A_SERVER_VERSION_STATUS] = { .type = NLA_U8, },
 };
 
+/* NFSD_CMD_LISTENER_START - do */
+static const struct nla_policy nfsd_listener_start_nl_policy[NFSD_A_SERVER_LISTENER_PORT + 1] = {
+	[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_SERVER_LISTENER_PORT] = { .type = NLA_U32, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -55,6 +61,18 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.dumpit	= nfsd_nl_version_get_dumpit,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NFSD_CMD_LISTENER_START,
+		.doit		= nfsd_nl_listener_start_doit,
+		.policy		= nfsd_listener_start_nl_policy,
+		.maxattr	= NFSD_A_SERVER_LISTENER_PORT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_LISTENER_GET,
+		.dumpit	= nfsd_nl_listener_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index 7d203cec08e4..9a51cb83f343 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -21,6 +21,9 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
 			       struct netlink_callback *cb);
+int nfsd_nl_listener_start_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_listener_get_dumpit(struct sk_buff *skb,
+				struct netlink_callback *cb);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 5cf6238617d9..471021b92519 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -717,18 +717,16 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
  * A transport listener is added by writing its transport name and
  * a port number.
  */
-static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cred *cred)
+static ssize_t ___write_ports_addxprt(struct net *net, const struct cred *cred,
+				      const char *transport, const int port)
 {
-	char transport[16];
-	struct svc_xprt *xprt;
-	int port, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	if (sscanf(buf, "%15s %5u", transport, &port) != 2)
-		return -EINVAL;
+	struct svc_xprt *xprt;
+	int err;
 
 	if (port < 1 || port > USHRT_MAX)
 		return -EINVAL;
+
 	trace_nfsd_ctl_ports_addxprt(net, transport, port);
 
 	err = nfsd_create_serv(net);
@@ -761,6 +759,17 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	return err;
 }
 
+static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cred *cred)
+{
+	char transport[16];
+	int port;
+
+	if (sscanf(buf, "%15s %5u", transport, &port) != 2)
+		return -EINVAL;
+
+	return ___write_ports_addxprt(net, cred, transport, port);
+}
+
 static ssize_t __write_ports(struct file *file, char *buf, size_t size,
 			     struct net *net)
 {
@@ -1856,6 +1865,87 @@ int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * nfsd_nl_listener_start_doit - start the provided nfs server listener
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_listener_start_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME) ||
+	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_PORT))
+		return -EINVAL;
+
+	mutex_lock(&nfsd_mutex);
+	ret = ___write_ports_addxprt(genl_info_net(info), get_current_cred(),
+			nla_data(info->attrs[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME]),
+			nla_get_u32(info->attrs[NFSD_A_SERVER_LISTENER_PORT]));
+	mutex_unlock(&nfsd_mutex);
+
+	return 0;
+}
+
+/**
+ * nfsd_nl_version_get_dumpit - Handle listener_get dumpit
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_listener_get_dumpit(struct sk_buff *skb,
+				struct netlink_callback *cb)
+{
+	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
+	int i = 0, ret = -ENOMEM;
+	struct svc_xprt *xprt;
+	struct svc_serv *serv;
+
+	mutex_lock(&nfsd_mutex);
+
+	serv = nn->nfsd_serv;
+	if (!serv) {
+		mutex_unlock(&nfsd_mutex);
+		return 0;
+	}
+
+	spin_lock_bh(&serv->sv_lock);
+	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
+		void *hdr;
+
+		if (i < cb->args[0]) /* already consumed */
+			continue;
+
+		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, &nfsd_nl_family,
+				  0, NFSD_CMD_LISTENER_GET);
+		if (!hdr)
+			goto out;
+
+		if (nla_put_string(skb, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME,
+				   xprt->xpt_class->xcl_name))
+			goto out;
+
+		if (nla_put_u32(skb, NFSD_A_SERVER_LISTENER_PORT,
+				svc_xprt_local_port(xprt)))
+			goto out;
+
+		genlmsg_end(skb, hdr);
+		i++;
+	}
+	cb->args[0] = i;
+	ret = skb->len;
+out:
+	spin_unlock_bh(&serv->sv_lock);
+
+	mutex_unlock(&nfsd_mutex);
+
+	return ret;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 51f078b26af4..2690bab6cef2 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -45,12 +45,22 @@ enum {
 	NFSD_A_SERVER_VERSION_MAX = (__NFSD_A_SERVER_VERSION_MAX - 1)
 };
 
+enum {
+	NFSD_A_SERVER_LISTENER_TRANSPORT_NAME = 1,
+	NFSD_A_SERVER_LISTENER_PORT,
+
+	__NFSD_A_SERVER_LISTENER_MAX,
+	NFSD_A_SERVER_LISTENER_MAX = (__NFSD_A_SERVER_LISTENER_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
 	NFSD_CMD_THREADS_GET,
 	NFSD_CMD_VERSION_SET,
 	NFSD_CMD_VERSION_GET,
+	NFSD_CMD_LISTENER_START,
+	NFSD_CMD_LISTENER_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
index dceaccbdfb69..8a7cef300b9b 100644
--- a/tools/net/ynl/generated/nfsd-user.c
+++ b/tools/net/ynl/generated/nfsd-user.c
@@ -19,6 +19,8 @@ static const char * const nfsd_op_strmap[] = {
 	[NFSD_CMD_THREADS_GET] = "threads-get",
 	[NFSD_CMD_VERSION_SET] = "version-set",
 	[NFSD_CMD_VERSION_GET] = "version-get",
+	[NFSD_CMD_LISTENER_START] = "listener-start",
+	[NFSD_CMD_LISTENER_GET] = "listener-get",
 };
 
 const char *nfsd_op_str(int op)
@@ -71,6 +73,16 @@ struct ynl_policy_nest nfsd_server_version_nest = {
 	.table = nfsd_server_version_policy,
 };
 
+struct ynl_policy_attr nfsd_server_listener_policy[NFSD_A_SERVER_LISTENER_MAX + 1] = {
+	[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME] = { .name = "transport-name", .type = YNL_PT_NUL_STR, },
+	[NFSD_A_SERVER_LISTENER_PORT] = { .name = "port", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest nfsd_server_listener_nest = {
+	.max_attr = NFSD_A_SERVER_LISTENER_MAX,
+	.table = nfsd_server_listener_policy,
+};
+
 /* Common nested types */
 /* ============== NFSD_CMD_RPC_STATUS_GET ============== */
 /* NFSD_CMD_RPC_STATUS_GET - dump */
@@ -263,6 +275,75 @@ struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *ys)
 	return NULL;
 }
 
+/* ============== NFSD_CMD_LISTENER_START ============== */
+/* NFSD_CMD_LISTENER_START - do */
+void nfsd_listener_start_req_free(struct nfsd_listener_start_req *req)
+{
+	free(req->transport_name);
+	free(req);
+}
+
+int nfsd_listener_start(struct ynl_sock *ys,
+			struct nfsd_listener_start_req *req)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_START, 1);
+	ys->req_policy = &nfsd_server_listener_nest;
+
+	if (req->_present.transport_name_len)
+		mnl_attr_put_strz(nlh, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME, req->transport_name);
+	if (req->_present.port)
+		mnl_attr_put_u32(nlh, NFSD_A_SERVER_LISTENER_PORT, req->port);
+
+	err = ynl_exec(ys, nlh, NULL);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
+/* ============== NFSD_CMD_LISTENER_GET ============== */
+/* NFSD_CMD_LISTENER_GET - dump */
+void nfsd_listener_get_list_free(struct nfsd_listener_get_list *rsp)
+{
+	struct nfsd_listener_get_list *next = rsp;
+
+	while ((void *)next != YNL_LIST_END) {
+		rsp = next;
+		next = rsp->next;
+
+		free(rsp->obj.transport_name);
+		free(rsp);
+	}
+}
+
+struct nfsd_listener_get_list *nfsd_listener_get_dump(struct ynl_sock *ys)
+{
+	struct ynl_dump_state yds = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	yds.ys = ys;
+	yds.alloc_sz = sizeof(struct nfsd_listener_get_list);
+	yds.cb = nfsd_listener_get_rsp_parse;
+	yds.rsp_cmd = NFSD_CMD_LISTENER_GET;
+	yds.rsp_policy = &nfsd_server_listener_nest;
+
+	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_LISTENER_GET, 1);
+
+	err = ynl_exec_dump(ys, nlh, &yds);
+	if (err < 0)
+		goto free_list;
+
+	return yds.first;
+
+free_list:
+	nfsd_listener_get_list_free(yds.first);
+	return NULL;
+}
+
 const struct ynl_family ynl_nfsd_family =  {
 	.name		= "nfsd",
 };
diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
index 2272cb25c364..c757387cd60d 100644
--- a/tools/net/ynl/generated/nfsd-user.h
+++ b/tools/net/ynl/generated/nfsd-user.h
@@ -132,4 +132,58 @@ void nfsd_version_get_list_free(struct nfsd_version_get_list *rsp);
 
 struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *ys);
 
+/* ============== NFSD_CMD_LISTENER_START ============== */
+/* NFSD_CMD_LISTENER_START - do */
+struct nfsd_listener_start_req {
+	struct {
+		__u32 transport_name_len;
+		__u32 port:1;
+	} _present;
+
+	char *transport_name;
+	__u32 port;
+};
+
+static inline struct nfsd_listener_start_req *
+nfsd_listener_start_req_alloc(void)
+{
+	return calloc(1, sizeof(struct nfsd_listener_start_req));
+}
+void nfsd_listener_start_req_free(struct nfsd_listener_start_req *req);
+
+static inline void
+nfsd_listener_start_req_set_transport_name(struct nfsd_listener_start_req *req,
+					   const char *transport_name)
+{
+	free(req->transport_name);
+	req->_present.transport_name_len = strlen(transport_name);
+	req->transport_name = malloc(req->_present.transport_name_len + 1);
+	memcpy(req->transport_name, transport_name, req->_present.transport_name_len);
+	req->transport_name[req->_present.transport_name_len] = 0;
+}
+static inline void
+nfsd_listener_start_req_set_port(struct nfsd_listener_start_req *req,
+				 __u32 port)
+{
+	req->_present.port = 1;
+	req->port = port;
+}
+
+/*
+ * start server listener
+ */
+int nfsd_listener_start(struct ynl_sock *ys,
+			struct nfsd_listener_start_req *req);
+
+/* ============== NFSD_CMD_LISTENER_GET ============== */
+/* NFSD_CMD_LISTENER_GET - dump */
+struct nfsd_listener_get_list {
+	struct nfsd_listener_get_list *next;
+	struct nfsd_listener_get_rsp obj __attribute__ ((aligned (8)));
+};
+
+void nfsd_listener_get_list_free(struct nfsd_listener_get_list *rsp);
+
+struct nfsd_listener_get_list *nfsd_listener_get_dump(struct ynl_sock *ys);
+
 #endif /* _LINUX_NFSD_GEN_H */
-- 
2.41.0

