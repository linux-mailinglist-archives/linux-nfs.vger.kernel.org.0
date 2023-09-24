Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647237AC9DC
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Sep 2023 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjIXNxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Sep 2023 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjIXNxR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Sep 2023 09:53:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C1EFC
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 06:53:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F85EC433C8;
        Sun, 24 Sep 2023 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695563590;
        bh=1iIaSAHv0kaQteuUlk5NJXB83q6b5SznHLZlKTmwynw=;
        h=From:To:Cc:Subject:Date:From;
        b=Q/4JVrXnfDBrgG0o62TWI34E2ajjHXn7FGSsaBS6lzYO8KG9I8ZW1jCfJ9Gt2nPgf
         vd1XW3ujlSQzWKcCRz4jXMIaqyccf1Q/n5pf+aHfgu7m8Czg9LTb3CD4umm9WxAvNs
         FemDkK+b+oz7RPLa4/nUAxuYBlV77xXQ8X5ZL5pQ7z0/uuiiE5Sy8KDzv3D2oV8W+x
         DbcwDq5IaqN+6sSxhjTdrozuGrifQGFebdHlUQdIIIM3ozhdw7RYI+9yexrPS0micd
         JzIxeb6ThsbYDpqTMtBXAhqiaTixuXV+LFMrdTpq/DG8sE/4uvs51SNGSulAIOy5Yd
         0u3grAe1LEPYg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, jlayton@kernel.org, neilb@suse.de,
        chuck.lever@oracle.com, netdev@vger.kernel.org
Subject: [PATCH v2] NFSD: convert write_threads, write_maxblksize and write_maxconn to netlink commands
Date:   Sun, 24 Sep 2023 15:52:28 +0200
Message-ID: <b9fefe9a15d8a4c5ab597489902ab2f868199365.1695563204.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce write_threads, write_maxblksize and write_maxconn netlink
commands similar to the ones available through the procfs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- remove write_v4_end_grace command
- add write_maxblksize and write_maxconn netlink commands

This patch can be tested with user-space tool reported below:
https://github.com/LorenzoBianconi/nfsd-netlink.git
---
 Documentation/netlink/specs/nfsd.yaml |  63 ++++++++++++
 fs/nfsd/netlink.c                     |  51 ++++++++++
 fs/nfsd/netlink.h                     |   9 ++
 fs/nfsd/nfsctl.c                      | 139 ++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  15 +++
 5 files changed, 277 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 403d3e3a04f3..10214fcec8a5 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -62,6 +62,18 @@ attribute-sets:
         name: compound-ops
         type: u32
         multi-attr: true
+  -
+    name: server-attr
+    attributes:
+      -
+        name: threads
+        type: u32
+      -
+        name: max-blksize
+        type: u32
+      -
+        name: max-conn
+        type: u32
 
 operations:
   list:
@@ -72,3 +84,54 @@ operations:
       dump:
         pre: nfsd-nl-rpc-status-get-start
         post: nfsd-nl-rpc-status-get-done
+    -
+      name: threads-set
+      doc: set the number of running threads
+      attribute-set: server-attr
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - threads
+    -
+      name: threads-get
+      doc: dump the number of running threads
+      attribute-set: server-attr
+      dump:
+        reply:
+          attributes:
+            - threads
+    -
+      name: max-blksize-set
+      doc: set the nfs block size
+      attribute-set: server-attr
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - max-blksize
+    -
+      name: max-blksize-get
+      doc: dump the nfs block size
+      attribute-set: server-attr
+      dump:
+        reply:
+          attributes:
+            - max-blksize
+    -
+      name: max-conn-set
+      doc: set the max number of connections
+      attribute-set: server-attr
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - max-conn
+    -
+      name: max-conn-get
+      doc: dump the max number of connections
+      attribute-set: server-attr
+      dump:
+        reply:
+          attributes:
+            - max-conn
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 0e1d635ec5f9..f3dde1b1e162 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -10,6 +10,21 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* NFSD_CMD_THREADS_SET - do */
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_ATTR_THREADS + 1] = {
+	[NFSD_A_SERVER_ATTR_THREADS] = { .type = NLA_U32, },
+};
+
+/* NFSD_CMD_MAX_BLKSIZE_SET - do */
+static const struct nla_policy nfsd_max_blksize_set_nl_policy[NFSD_A_SERVER_ATTR_MAX_BLKSIZE + 1] = {
+	[NFSD_A_SERVER_ATTR_MAX_BLKSIZE] = { .type = NLA_U32, },
+};
+
+/* NFSD_CMD_MAX_CONN_SET - do */
+static const struct nla_policy nfsd_max_conn_set_nl_policy[NFSD_A_SERVER_ATTR_MAX_CONN + 1] = {
+	[NFSD_A_SERVER_ATTR_MAX_CONN] = { .type = NLA_U32, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -19,6 +34,42 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.done	= nfsd_nl_rpc_status_get_done,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NFSD_CMD_THREADS_SET,
+		.doit		= nfsd_nl_threads_set_doit,
+		.policy		= nfsd_threads_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_ATTR_THREADS,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_THREADS_GET,
+		.dumpit	= nfsd_nl_threads_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= NFSD_CMD_MAX_BLKSIZE_SET,
+		.doit		= nfsd_nl_max_blksize_set_doit,
+		.policy		= nfsd_max_blksize_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_ATTR_MAX_BLKSIZE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_MAX_BLKSIZE_GET,
+		.dumpit	= nfsd_nl_max_blksize_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+	{
+		.cmd		= NFSD_CMD_MAX_CONN_SET,
+		.doit		= nfsd_nl_max_conn_set_doit,
+		.policy		= nfsd_max_conn_set_nl_policy,
+		.maxattr	= NFSD_A_SERVER_ATTR_MAX_CONN,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_MAX_CONN_GET,
+		.dumpit	= nfsd_nl_max_conn_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index d83dd6bdee92..41b95651c638 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -16,6 +16,15 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
 
 int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb);
+int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_threads_get_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb);
+int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb);
+int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
+				struct netlink_callback *cb);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b71744e355a8..0167b7fd0d63 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1694,6 +1694,145 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
 	return 0;
 }
 
+/**
+ * nfsd_nl_threads_set_doit - set the number of running threads
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	u16 nthreads;
+	int ret;
+
+	if (!info->attrs[NFSD_A_SERVER_ATTR_THREADS])
+		return -EINVAL;
+
+	nthreads = nla_get_u32(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);
+
+	ret = nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
+	return ret == nthreads ? 0 : ret;
+}
+
+static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			    int cmd, int attr, u32 val)
+{
+	void *hdr;
+
+	if (cb->args[0]) /* already consumed */
+		return 0;
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &nfsd_nl_family, NLM_F_MULTI, cmd);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put_u32(skb, attr, val))
+		return -ENOBUFS;
+
+	genlmsg_end(skb, hdr);
+	cb->args[0] = 1;
+
+	return skb->len;
+}
+
+/**
+ * nfsd_nl_threads_get_dumpit - dump the number of running threads
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_threads_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_THREADS_GET,
+				NFSD_A_SERVER_ATTR_THREADS,
+				nfsd_nrthreads(sock_net(skb->sk)));
+}
+
+/**
+ * nfsd_nl_max_blksize_set_doit - set the nfs block size
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_max_blksize_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
+	int ret = 0;
+
+	if (!info->attrs[NFSD_A_SERVER_ATTR_MAX_BLKSIZE])
+		return -EINVAL;
+
+	mutex_lock(&nfsd_mutex);
+	if (nn->nfsd_serv) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	nfsd_max_blksize = nla_get_u32(info->attrs[NFSD_A_SERVER_ATTR_MAX_BLKSIZE]);
+	nfsd_max_blksize = max_t(int, nfsd_max_blksize, 1024);
+	nfsd_max_blksize = min_t(int, nfsd_max_blksize, NFSSVC_MAXBLKSIZE);
+	nfsd_max_blksize &= ~1023;
+out:
+	mutex_unlock(&nfsd_mutex);
+
+	return ret;
+}
+
+/**
+ * nfsd_nl_max_blksize_get_dumpit - dump the nfs block size
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_max_blksize_get_dumpit(struct sk_buff *skb,
+				   struct netlink_callback *cb)
+{
+	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_BLKSIZE_GET,
+				NFSD_A_SERVER_ATTR_MAX_BLKSIZE,
+				nfsd_max_blksize);
+}
+
+/**
+ * nfsd_nl_max_conn_set_doit - set the max number of connections
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_max_conn_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
+
+	if (!info->attrs[NFSD_A_SERVER_ATTR_MAX_CONN])
+		return -EINVAL;
+
+	nn->max_connections = nla_get_u32(info->attrs[NFSD_A_SERVER_ATTR_MAX_CONN]);
+
+	return 0;
+}
+
+/**
+ * nfsd_nl_max_conn_get_dumpit - dump the max number of connections
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_max_conn_get_dumpit(struct sk_buff *skb,
+				struct netlink_callback *cb)
+{
+	struct nfsd_net *nn = net_generic(sock_net(cb->skb->sk), nfsd_net_id);
+
+	return nfsd_nl_get_dump(skb, cb, NFSD_CMD_MAX_CONN_GET,
+				NFSD_A_SERVER_ATTR_MAX_CONN,
+				nn->max_connections);
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index c8ae72466ee6..59d0aa22ba94 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -29,8 +29,23 @@ enum {
 	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
 };
 
+enum {
+	NFSD_A_SERVER_ATTR_THREADS = 1,
+	NFSD_A_SERVER_ATTR_MAX_BLKSIZE,
+	NFSD_A_SERVER_ATTR_MAX_CONN,
+
+	__NFSD_A_SERVER_ATTR_MAX,
+	NFSD_A_SERVER_ATTR_MAX = (__NFSD_A_SERVER_ATTR_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
+	NFSD_CMD_THREADS_SET,
+	NFSD_CMD_THREADS_GET,
+	NFSD_CMD_MAX_BLKSIZE_SET,
+	NFSD_CMD_MAX_BLKSIZE_GET,
+	NFSD_CMD_MAX_CONN_SET,
+	NFSD_CMD_MAX_CONN_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
-- 
2.41.0

