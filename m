Return-Path: <linux-nfs+bounces-8983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B546FA066BE
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F1B3A7193
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E0A20468D;
	Wed,  8 Jan 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jltAl4bq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3A203713;
	Wed,  8 Jan 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370018; cv=none; b=gwD4Ncy1mzAQzH+SHRSiwdX4sUHUOUyqlQE0Jt2URKG1ms9AO8PwiYhn0R3wi6S8mxjcIMi2uffdkQc7m6pDiyUdxTJq36BGytITvfmO4RuIUFdmTCHOp16/w4BW10yQQkKn6pzwj5aXjRmFNY/GxtzpIhnDiF2OliTNVxix1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370018; c=relaxed/simple;
	bh=bA7CYs8ZO25il6tO7iT21wQeNuUCG//E8j3ST9SvzW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cuC4GVDesPWOxxq6B6JJXsD+vutZJ9F2dF2U6jN+u6j4pmSe/pskaYsqce08f7RIhKL1QTe7BFhMDzQMTk8QiYpJG4AODRPyyqm5h4V34ICAooscUnFIG8j9ZTGZm+SnVEgMNvd5zIFuGD6YeBY0F1FBK/eATvnWD2mabY15CyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jltAl4bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65789C4CEDF;
	Wed,  8 Jan 2025 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736370018;
	bh=bA7CYs8ZO25il6tO7iT21wQeNuUCG//E8j3ST9SvzW4=;
	h=From:Date:Subject:To:Cc:From;
	b=jltAl4bqeDUUhfe8qsNzdUBoJiCPeAQnm2tPQk9XLyBSyhnTH1Ok7BRla+hIha5KT
	 b7Lc9zAWcSplAfd/41lrg9kFQ/MCJZwd9QVzqRX6RP+Vp1z+glaGyfoNX14aGZKTe5
	 1GQEpBaiwahu8jPoKXj84OerF5hGzOL4SbyfqajlvrOre8a0zK3+u/RkZwYpipkak8
	 RJwKvK/weCfzMoNsSJ09ym/w1fza6vlaiex1qjWNAkf8HndN+ClL3/vt/09R2nKT6Z
	 Cgd+InSGeZAbV6Hse8TEWX4DdZa1V/4VsrpN7thds3BOfYrdlOT7kcWYkf+DuScoq3
	 GdvbqAAT9O4fQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 08 Jan 2025 16:00:15 -0500
Subject: [PATCH] lockd: add netlink control interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-lockd-nl-v1-1-b39f89ae0f20@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF7nfmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQwML3Zz85OwU3bwc3aS0VHOz5GQDCyNzcyWg8oKi1LTMCrBR0bG1tQB
 KVzNtWgAAAA==
X-Change-ID: 20250108-lockd-nl-bfe76cc08277
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12834; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bA7CYs8ZO25il6tO7iT21wQeNuUCG//E8j3ST9SvzW4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnfudgMYepPYPEL/EH6c7WM+v4CKUJzE+qY/fs9
 yAahCmf16WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ37nYAAKCRAADmhBGVaC
 FbpQD/4nGYwYHT11Ukth7gIRDEFwqug4g8t4iBoR+M5Bm6lT5JlQPZ7BovDB01gRMfCCIy/f6IJ
 N8PMbA3xmePNLWAr78DzHkDCoc/4Fui5psrioi6dzzSxAvXDCaTO84+NUWAD/aISYaLpw6vnZ/B
 I9W/I1WpJVoxHvWQo5doqIRcH9Ua8d6fGKXxB2LhEgY/D0nJkXyFXQ5JNVIK+4CgdwQfqvYWWcx
 ycIO3C5/oMOZKewEboCVzwk0b+eLtc816+vxFYF+xZ6/HbmYgc4EBmpM7ElfF5ZupcG4zOyHFvI
 2PlrmhfljE9acd5N+PLEdZa9TF07zRS8afS1vtyStSKAFGR53QXj/Ksasb7Jj3L/tpmIB6VCidf
 UmIT2mu2HnwDihO8Oc2ffuOGizxvvVQASYMn9cxdODSf3vR+VqbdNMGa3COSc5Ylt8CdOuqodVZ
 t9zFuM8Y7dg4VinN6shQvwOkS/oLRb6HbOCjLl+2Juxd+gBfzZdbW1Wj3hEskXECE2V70yAFWlf
 GNbYFwpnCyTqKNyG3EZ53hWhYBbcfJ8sYDNaLJ27p8w8iVK8ZmjeA8xKGBbxYM2uQ2Xr1e36fib
 +PaxnEFLnqsYjRziU+CU3/WhGl+7N7zkbS9qW7STDWxUWRvnrTFEtLN3pVo5WCyxsy5+qzq2WtX
 DKt3F3cvfvSdX9g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The legacy rpc.nfsd tool will set the nlm_grace_period if the NFSv4
grace period is set. nfsdctl is missing this functionality, so add a new
netlink control interface for lockd that it can use. For now, it only
allows setting the grace period, and the tcp and udp listener ports.

lockd currently uses module parameters and sysctls for configuration, so
all of its settings are global. With this change, lockd now tracks these
values on a per-net-ns basis. It will only fall back to using the global
values if any of them are 0.

Finally, as a backward compatability measure, if updating the nlm
settings in the init_net namespace, also update the legacy global
values to match.

Link: https://issues.redhat.com/browse/RHEL-71698
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Yongcheng and Scott reported seeing ths problem in testing. I'm also
working on nfs-utils patches for nfsdctl, but they're still a bit rough
and aren't ready to be posted yet.

The main bit I consider questionable is the place where it's copying
back to the "legacy" global values. We can drop that bit if it seems
problematic.
---
 Documentation/netlink/specs/lockd.yaml |  45 +++++++++++++
 fs/lockd/Makefile                      |   2 +-
 fs/lockd/netlink.c                     |  44 ++++++++++++
 fs/lockd/netlink.h                     |  19 ++++++
 fs/lockd/netns.h                       |   3 +
 fs/lockd/svc.c                         | 118 +++++++++++++++++++++++++++++++--
 include/uapi/linux/lockd_netlink.h     |  29 ++++++++
 7 files changed, 253 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/lockd.yaml b/Documentation/netlink/specs/lockd.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..bbd4da5fe54b8b128383ac567941060fa99784d6
--- /dev/null
+++ b/Documentation/netlink/specs/lockd.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: lockd
+protocol: genetlink
+uapi-header: linux/lockd_netlink.h
+
+doc: lockd configuration over generic netlink
+
+attribute-sets:
+  -
+    name: server
+    attributes:
+      -
+        name: gracetime
+        type: u32
+      -
+        name: tcp-port
+        type: u16
+      -
+        name: udp-port
+        type: u16
+
+operations:
+  list:
+    -
+      name: server-set
+      doc: set the lockd server parameters
+      attribute-set: server
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - gracetime
+            - tcp-port
+            - udp-port
+    -
+      name: server-get
+      doc: get the lockd server parameters
+      attribute-set: server
+      do:
+        reply:
+          attributes:
+            - gracetime
+            - tcp-port
+            - udp-port
diff --git a/fs/lockd/Makefile b/fs/lockd/Makefile
index fe3e23dd29c32af8a0191686113b68541e6cb183..51bbe22d21e3545764260fb4472524211b4aa550 100644
--- a/fs/lockd/Makefile
+++ b/fs/lockd/Makefile
@@ -8,6 +8,6 @@ ccflags-y += -I$(src)			# needed for trace events
 obj-$(CONFIG_LOCKD) += lockd.o
 
 lockd-y := clntlock.o clntproc.o clntxdr.o host.o svc.o svclock.o \
-	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o
+	   svcshare.o svcproc.o svcsubs.o mon.o trace.o xdr.o netlink.o
 lockd-$(CONFIG_LOCKD_V4) += clnt4xdr.o xdr4.o svc4proc.o
 lockd-$(CONFIG_PROC_FS) += procfs.o
diff --git a/fs/lockd/netlink.c b/fs/lockd/netlink.c
new file mode 100644
index 0000000000000000000000000000000000000000..6e00b02cad9083ff708429ccc86b01857e6f648b
--- /dev/null
+++ b/fs/lockd/netlink.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/lockd.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "netlink.h"
+
+#include <uapi/linux/lockd_netlink.h>
+
+/* LOCKD_CMD_SERVER_SET - do */
+static const struct nla_policy lockd_server_set_nl_policy[LOCKD_A_SERVER_UDP_PORT + 1] = {
+	[LOCKD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
+	[LOCKD_A_SERVER_TCP_PORT] = { .type = NLA_U16, },
+	[LOCKD_A_SERVER_UDP_PORT] = { .type = NLA_U16, },
+};
+
+/* Ops table for lockd */
+static const struct genl_split_ops lockd_nl_ops[] = {
+	{
+		.cmd		= LOCKD_CMD_SERVER_SET,
+		.doit		= lockd_nl_server_set_doit,
+		.policy		= lockd_server_set_nl_policy,
+		.maxattr	= LOCKD_A_SERVER_UDP_PORT,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= LOCKD_CMD_SERVER_GET,
+		.doit	= lockd_nl_server_get_doit,
+		.flags	= GENL_CMD_CAP_DO,
+	},
+};
+
+struct genl_family lockd_nl_family __ro_after_init = {
+	.name		= LOCKD_FAMILY_NAME,
+	.version	= LOCKD_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= lockd_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(lockd_nl_ops),
+};
diff --git a/fs/lockd/netlink.h b/fs/lockd/netlink.h
new file mode 100644
index 0000000000000000000000000000000000000000..1920543a79557aa1a26d991df0701c2a1647b797
--- /dev/null
+++ b/fs/lockd/netlink.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/lockd.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_LOCKD_GEN_H
+#define _LINUX_LOCKD_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/lockd_netlink.h>
+
+int lockd_nl_server_set_doit(struct sk_buff *skb, struct genl_info *info);
+int lockd_nl_server_get_doit(struct sk_buff *skb, struct genl_info *info);
+
+extern struct genl_family lockd_nl_family;
+
+#endif /* _LINUX_LOCKD_GEN_H */
diff --git a/fs/lockd/netns.h b/fs/lockd/netns.h
index 17432c445fe6f0841b3c821ca1c71babf4e50b7a..88e8e2a973977433703cac3a046e0f09501b26b5 100644
--- a/fs/lockd/netns.h
+++ b/fs/lockd/netns.h
@@ -10,6 +10,9 @@ struct lockd_net {
 	unsigned int nlmsvc_users;
 	unsigned long next_gc;
 	unsigned long nrhosts;
+	u32 gracetime;
+	u16 tcp_port;
+	u16 udp_port;
 
 	struct delayed_work grace_period_end;
 	struct lock_manager lockd_manager;
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 7ded57ec3a603197f22c711b40eae39104a63de4..904aabb9fd1d0a745de2fd139a0335bdd87df6a5 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -41,6 +41,7 @@
 
 #include "netns.h"
 #include "procfs.h"
+#include "netlink.h"
 
 #define NLMDBG_FACILITY		NLMDBG_SVC
 #define LOCKD_BUFSIZE		(1024 + NLMSVC_XDRSIZE)
@@ -83,8 +84,14 @@ static const int		nlm_port_min = 0, nlm_port_max = 65535;
 static struct ctl_table_header * nlm_sysctl_table;
 #endif
 
-static unsigned long get_lockd_grace_period(void)
+static unsigned long get_lockd_grace_period(struct net *net)
 {
+	struct lockd_net *ln = net_generic(net, lockd_net_id);
+
+	/* Return the net-ns specific grace period, if there is one */
+	if (ln->gracetime)
+		return ln->gracetime * HZ;
+
 	/* Note: nlm_timeout should always be nonzero */
 	if (nlm_grace_period)
 		return roundup(nlm_grace_period, nlm_timeout) * HZ;
@@ -103,7 +110,7 @@ static void grace_ender(struct work_struct *grace)
 
 static void set_grace_period(struct net *net)
 {
-	unsigned long grace_period = get_lockd_grace_period();
+	unsigned long grace_period = get_lockd_grace_period(net);
 	struct lockd_net *ln = net_generic(net, lockd_net_id);
 
 	locks_start_grace(net, &ln->lockd_manager);
@@ -166,15 +173,16 @@ static int create_lockd_listener(struct svc_serv *serv, const char *name,
 static int create_lockd_family(struct svc_serv *serv, struct net *net,
 			       const int family, const struct cred *cred)
 {
+	struct lockd_net *ln = net_generic(net, lockd_net_id);
 	int err;
 
-	err = create_lockd_listener(serv, "udp", net, family, nlm_udpport,
-			cred);
+	err = create_lockd_listener(serv, "udp", net, family,
+				    ln->udp_port ? ln->udp_port : nlm_udpport, cred);
 	if (err < 0)
 		return err;
 
-	return create_lockd_listener(serv, "tcp", net, family, nlm_tcpport,
-			cred);
+	return create_lockd_listener(serv, "tcp", net, family,
+				     ln->tcp_port ? ln->tcp_port : nlm_tcpport, cred);
 }
 
 /*
@@ -588,6 +596,10 @@ static int __init init_nlm(void)
 	if (err)
 		goto err_pernet;
 
+	err = genl_register_family(&lockd_nl_family);
+	if (err)
+		goto err_netlink;
+
 	err = lockd_create_procfs();
 	if (err)
 		goto err_procfs;
@@ -595,6 +607,8 @@ static int __init init_nlm(void)
 	return 0;
 
 err_procfs:
+	genl_unregister_family(&lockd_nl_family);
+err_netlink:
 	unregister_pernet_subsys(&lockd_net_ops);
 err_pernet:
 #ifdef CONFIG_SYSCTL
@@ -608,6 +622,7 @@ static void __exit exit_nlm(void)
 {
 	/* FIXME: delete all NLM clients */
 	nlm_shutdown_hosts();
+	genl_unregister_family(&lockd_nl_family);
 	lockd_remove_procfs();
 	unregister_pernet_subsys(&lockd_net_ops);
 #ifdef CONFIG_SYSCTL
@@ -710,3 +725,94 @@ static struct svc_program	nlmsvc_program = {
 	.pg_init_request	= svc_generic_init_request,
 	.pg_rpcbind_set		= svc_generic_rpcbind_set,
 };
+
+/**
+ * lockd_nl_server_set_doit - set the lockd server parameters via netlink
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * This updates the per-net values. When updating the values in the init_net
+ * namespace, also update the "legacy" global values.
+ *
+ * Return 0 on success or a negative errno.
+ */
+int lockd_nl_server_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct lockd_net *ln = net_generic(net, lockd_net_id);
+	const struct nlattr *attr;
+
+	if (GENL_REQ_ATTR_CHECK(info, LOCKD_A_SERVER_GRACETIME))
+		return -EINVAL;
+
+	if (info->attrs[LOCKD_A_SERVER_GRACETIME] ||
+	    info->attrs[LOCKD_A_SERVER_TCP_PORT] ||
+	    info->attrs[LOCKD_A_SERVER_UDP_PORT]) {
+		attr = info->attrs[LOCKD_A_SERVER_GRACETIME];
+		if (attr) {
+			u32 gracetime = nla_get_u32(attr);
+
+			if (gracetime > nlm_grace_period_max)
+				return -EINVAL;
+
+			ln->gracetime = gracetime;
+
+			if (net == &init_net)
+				nlm_grace_period = gracetime;
+		}
+
+		attr = info->attrs[LOCKD_A_SERVER_TCP_PORT];
+		if (attr) {
+			ln->tcp_port = nla_get_u16(attr);
+			if (net == &init_net)
+				nlm_tcpport = ln->tcp_port;
+		}
+
+		attr = info->attrs[LOCKD_A_SERVER_UDP_PORT];
+		if (attr) {
+			ln->udp_port = nla_get_u16(attr);
+			if (net == &init_net)
+				nlm_udpport = ln->udp_port;
+		}
+	}
+	return 0;
+}
+
+/**
+ * lockd_nl_server_get_doit - get lockd server parameters via netlink
+ * @skb: reply buffer
+ * @info: netlink metadata and command arguments
+ *
+ * Return 0 on success or a negative errno.
+ */
+int lockd_nl_server_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct lockd_net *ln = net_generic(net, lockd_net_id);
+	void *hdr;
+	int err;
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(skb, info);
+	if (!hdr) {
+		err = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	err = nla_put_u32(skb, LOCKD_A_SERVER_GRACETIME, ln->gracetime) ||
+	      nla_put_u16(skb, LOCKD_A_SERVER_TCP_PORT, ln->tcp_port) ||
+	      nla_put_u16(skb, LOCKD_A_SERVER_UDP_PORT, ln->udp_port);
+	if (err)
+		goto err_free_msg;
+
+	genlmsg_end(skb, hdr);
+
+	return genlmsg_reply(skb, info);
+err_free_msg:
+	nlmsg_free(skb);
+
+	return err;
+}
diff --git a/include/uapi/linux/lockd_netlink.h b/include/uapi/linux/lockd_netlink.h
new file mode 100644
index 0000000000000000000000000000000000000000..21c65aec3bc6d1839961937081e6d16540332179
--- /dev/null
+++ b/include/uapi/linux/lockd_netlink.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/lockd.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_LOCKD_NETLINK_H
+#define _UAPI_LINUX_LOCKD_NETLINK_H
+
+#define LOCKD_FAMILY_NAME	"lockd"
+#define LOCKD_FAMILY_VERSION	1
+
+enum {
+	LOCKD_A_SERVER_GRACETIME = 1,
+	LOCKD_A_SERVER_TCP_PORT,
+	LOCKD_A_SERVER_UDP_PORT,
+
+	__LOCKD_A_SERVER_MAX,
+	LOCKD_A_SERVER_MAX = (__LOCKD_A_SERVER_MAX - 1)
+};
+
+enum {
+	LOCKD_CMD_SERVER_SET = 1,
+	LOCKD_CMD_SERVER_GET,
+
+	__LOCKD_CMD_MAX,
+	LOCKD_CMD_MAX = (__LOCKD_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_LOCKD_NETLINK_H */

---
base-commit: e43aefc29f1848068bc37c285ab882368e08e4be
change-id: 20250108-lockd-nl-bfe76cc08277

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


