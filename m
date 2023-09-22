Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F77AB263
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjIVMpI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjIVMpH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 08:45:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E08F
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 05:45:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA577C433C8;
        Fri, 22 Sep 2023 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695386701;
        bh=lXu3gbEYpYxZKk3OtpxHdDR4wko55KgbOhVSsGGEhX8=;
        h=From:To:Cc:Subject:Date:From;
        b=HlnehsXr3+8B0A9BavZvjuUGf6m9A2+W8MZzu2GtgTc/w34siY3Jb0U9Ihs91qS1D
         F8FfoTU052AEJbNaqmzE4+Ba1Aqx5HA351eE9LCsHVjvelNXlH71JFE107MKfAncmP
         IRyXuTnNeyflVrEO/XBJOPdBnrdu3etEGCwhnw5IZSJ/P2HqwrE4Vd65TjaOo6KBAE
         8pZd/3FItNL3Hbh384P8YiOB6JxaTdGgDnWZaDL0y2BC4v6R0jljI35eDOakcaOl+d
         wwhFHWN7yLZehLGTJX2669bd7MhKeQ52fMY4LPFWP7XjvQNfpMZiv/zq681NFpYmSE
         H1Q0zzR5b8cLQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, jlayton@kernel.org, neilb@suse.de,
        chuck.lever@oracle.com, netdev@vger.kernel.org
Subject: [PATCH] NFSD: convert write_threads and write_v4_end_grace to netlink commands
Date:   Fri, 22 Sep 2023 14:44:52 +0200
Message-ID: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce write_threads and write_v4_end_grace netlink commands similar
to the ones available through the procfs.
Introduce nfsd_nl_server_status_get_dumpit netlink command in order to
report global server metadata.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch can be tested with user-space tool reported below:
https://github.com/LorenzoBianconi/nfsd-netlink.git
---
 Documentation/netlink/specs/nfsd.yaml | 33 +++++++++
 fs/nfsd/netlink.c                     | 30 ++++++++
 fs/nfsd/netlink.h                     |  5 ++
 fs/nfsd/nfsctl.c                      | 98 +++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     | 11 +++
 5 files changed, 177 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 403d3e3a04f3..fa1204892703 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -62,6 +62,15 @@ attribute-sets:
         name: compound-ops
         type: u32
         multi-attr: true
+  -
+    name: server-attr
+    attributes:
+      -
+        name: threads
+        type: u16
+      -
+        name: v4-grace
+        type: u8
 
 operations:
   list:
@@ -72,3 +81,27 @@ operations:
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
+      name: v4-grace-release
+      doc: release the grace period for nfsd's v4 lock manager
+      attribute-set: server-attr
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - v4-grace
+    -
+      name: server-status-get
+      doc: dump server status info
+      attribute-set: server-attr
+      dump:
+        pre: nfsd-nl-server-status-get-start
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 0e1d635ec5f9..783a34e69354 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -10,6 +10,16 @@
 
 #include <uapi/linux/nfsd_netlink.h>
 
+/* NFSD_CMD_THREADS_SET - do */
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_ATTR_THREADS + 1] = {
+	[NFSD_A_SERVER_ATTR_THREADS] = { .type = NLA_U16, },
+};
+
+/* NFSD_CMD_V4_GRACE_RELEASE - do */
+static const struct nla_policy nfsd_v4_grace_release_nl_policy[NFSD_A_SERVER_ATTR_V4_GRACE + 1] = {
+	[NFSD_A_SERVER_ATTR_V4_GRACE] = { .type = NLA_U8, },
+};
+
 /* Ops table for nfsd */
 static const struct genl_split_ops nfsd_nl_ops[] = {
 	{
@@ -19,6 +29,26 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
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
+		.cmd		= NFSD_CMD_V4_GRACE_RELEASE,
+		.doit		= nfsd_nl_v4_grace_release_doit,
+		.policy		= nfsd_v4_grace_release_nl_policy,
+		.maxattr	= NFSD_A_SERVER_ATTR_V4_GRACE,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NFSD_CMD_SERVER_STATUS_GET,
+		.start	= nfsd_nl_server_status_get_start,
+		.dumpit	= nfsd_nl_server_status_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 struct genl_family nfsd_nl_family __ro_after_init = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index d83dd6bdee92..2e98061fbb0a 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -12,10 +12,15 @@
 #include <uapi/linux/nfsd_netlink.h>
 
 int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
+int nfsd_nl_server_status_get_start(struct netlink_callback *cb);
 int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
 
 int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb);
+int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
+				     struct netlink_callback *cb);
 
 extern struct genl_family nfsd_nl_family;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b71744e355a8..c631b59b7a4f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1694,6 +1694,104 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
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
+	nthreads = nla_get_u16(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);
+
+	ret = nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
+	return ret == nthreads ? 0 : ret;
+}
+
+/**
+ * nfsd_nl_v4_grace_release_doit - release the nfs4 grace period
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_info *info)
+{
+#ifdef CONFIG_NFSD_V4
+	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
+
+	if (!info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE])
+		return -EINVAL;
+
+	if (nla_get_u8(info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE]))
+		nfsd4_end_grace(nn);
+
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif /* CONFIG_NFSD_V4 */
+}
+
+/**
+ * nfsd_nl_server_status_get_start - Prepare server_status_get dumpit
+ * @cb: netlink metadata and command arguments
+ *
+ * Return values:
+ *   %0: The server_status_get command may proceed
+ *   %-ENODEV: There is no NFSD running in this namespace
+ */
+int nfsd_nl_server_status_get_start(struct netlink_callback *cb)
+{
+	struct nfsd_net *nn = net_generic(sock_net(cb->skb->sk), nfsd_net_id);
+
+	return nn->nfsd_serv ? 0 : -ENODEV;
+}
+
+/**
+ * nfsd_nl_server_status_get_dumpit - dump server status info
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
+				     struct netlink_callback *cb)
+{
+	struct net *net = sock_net(skb->sk);
+#ifdef CONFIG_NFSD_V4
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+#endif /* CONFIG_NFSD_V4 */
+	void *hdr;
+
+	if (cb->args[0]) /* already consumed */
+		return 0;
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &nfsd_nl_family, NLM_F_MULTI,
+			  NFSD_CMD_SERVER_STATUS_GET);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put_u16(skb, NFSD_A_SERVER_ATTR_THREADS, nfsd_nrthreads(net)))
+		return -ENOBUFS;
+#ifdef CONFIG_NFSD_V4
+	if (nla_put_u8(skb, NFSD_A_SERVER_ATTR_V4_GRACE, !nn->grace_ended))
+		return -ENOBUFS;
+#endif /* CONFIG_NFSD_V4 */
+
+	genlmsg_end(skb, hdr);
+	cb->args[0] = 1;
+
+	return skb->len;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index c8ae72466ee6..b82fbc53d336 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -29,8 +29,19 @@ enum {
 	NFSD_A_RPC_STATUS_MAX = (__NFSD_A_RPC_STATUS_MAX - 1)
 };
 
+enum {
+	NFSD_A_SERVER_ATTR_THREADS = 1,
+	NFSD_A_SERVER_ATTR_V4_GRACE,
+
+	__NFSD_A_SERVER_ATTR_MAX,
+	NFSD_A_SERVER_ATTR_MAX = (__NFSD_A_SERVER_ATTR_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
+	NFSD_CMD_THREADS_SET,
+	NFSD_CMD_V4_GRACE_RELEASE,
+	NFSD_CMD_SERVER_STATUS_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
-- 
2.41.0

