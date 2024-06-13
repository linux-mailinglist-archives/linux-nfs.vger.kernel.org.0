Return-Path: <linux-nfs+bounces-3776-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8056390788C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B091C22B04
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD582149E14;
	Thu, 13 Jun 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocEDH6Q5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9851149E13
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297070; cv=none; b=hdmY2EYOARquCSkQJiuJO6Vy70igVMO87grgn+BQNh00OFrkWpoTkGEGp1dgifnFqsLlvHmRQWrvAXGVV0ie9xGO0CTn/imcyqtfEuhI5XzKANym4SVxXAnfUugPmUexgTv2zBv17orqpDX4gUrLdRESTlwQ+lm6nsXSPqIjrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297070; c=relaxed/simple;
	bh=pDjkJcDQSy7iagioZzAU5V/Nm4H31Sxq6T5r65wDnKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/whQFC1D1pIjRlprKlKW1UTU66CcTA1MY6gyKfCe7l5lLZvI84wyNIgexzn9PQ2Su0wq4NeCXjFK+56u7i6oEEyorvi/L++UdrMdPHSYYw7ciqF9VQAHSFuzlfg5d/qgzbn03Jy0KeKrUgqtsOGYMsx1tvsg1ZYQuUeAKsdt84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocEDH6Q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93141C2BBFC;
	Thu, 13 Jun 2024 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718297070;
	bh=pDjkJcDQSy7iagioZzAU5V/Nm4H31Sxq6T5r65wDnKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ocEDH6Q5d2tSBtowUNi5RdCt2JhJoqlcNOlWRDTe/LsyurkzllEydlPEiPQ8kIgrD
	 zCFLPhA1rEp6Taw80pp3rY7CnEbPIv5VHEraXiEIhNhDyaNOWuC+4Q+DlPgVPUynU9
	 w1BsiBNKXNyDX+Y7MQdMoUq2NDqR85qq0K9uNTkYXHjDccrYp3Bjw8BB92jtZPN7Vn
	 GKVwS6RhItHQlmweatGf5sXY5/67mvM/Qc3GgyOcVlxfTqrHe5GPt2nBiDySbI8asn
	 /froml79MLh75HTpNTJ0hVt19RHGo1GUIczEA72KeIvWU2J7HMUxJ3QifEi/R9FdZs
	 Epa4SZZL1D5Xg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 12:44:09 -0400
Subject: [PATCH nfs-utils v5 4/4] nfsdctl: add support for pool-mode
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsdctl-v5-4-0b7a39102bac@kernel.org>
References: <20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org>
In-Reply-To: <20240613-nfsdctl-v5-0-0b7a39102bac@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10126; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pDjkJcDQSy7iagioZzAU5V/Nm4H31Sxq6T5r65wDnKA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmayHp1gIMVU2RQF0opVNNrLCD2/i7CVuSpdF/b
 1ShNEJCQQSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmsh6QAKCRAADmhBGVaC
 FdK3EACByhwsjMrCPqw8FVUbgrxFTHeJRYovlxmMRTJqAUdG81IyPdooPa7cRT88bUwLBcLVwnw
 +g5AzUaLBhn9eGGxg2ojsc76jKUkk1sdf8LApGfY7dOgQn4nyOhLS24I5Lk3WOAF7PJifiA79zC
 ER0OWhsxzw9hwBon8Qecr96uxgaIjkt1wFrbqurkRdwy92NBTtYaVtqXkrPtqCbL4oogzysQ8C0
 lZyVk5emS79XRPAlkN+BAcdr5OTq1JOW2U2uYKGL2IknAx+IhBOV4K8JfVPJToWukt/GOSGH7R/
 fHQSYjD4YrZVi0v1Zwcja1tYXzNqA2te8vIxbbQmnXj3+jWI5QdGfD5FmIkOs1MPn/5N1DhsaJW
 ZIkFwmaHE5B9Z3LW2NVEUtHNoqaOuzLCSPepwA90uNQ/+HnBfCZ0m6+nxwSwYvU+RraBVk/JwIY
 VDQMXcZhtPUCi3zRy/gzeU5lK58Kg9pjA1YuL9VvJ23K9Szm80GfMKtl9n5cEjeOwJ8okrGExJs
 e+AXoNV7iiGX66fAGWk0WUkcQXxqTEYOONMq1/X0q+8XZggA0cUHRdXRUGi7agSBBizTDuT8A6b
 rhrfXHMU9TRrharZ7g7f7Z1tF3Tl2eEpnrnkgZTMZ7L41A6xm4xT0jdpZCBRlhbJ/Gz81g9mAx7
 AP+w5FiBa2VmGrQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow nfsdctl to use the new POOL_MODE_GET/SET operations to configure
the pool-mode on the host. This setting mirrors the behavior of the
sunrpc module parameter. The patch also adds support for a new pool-mode
option in /etc/nfs.conf. With this change, you can now configure a
multipool NFS server by just properly setting up /etc/nfs.conf.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac                 |   2 +-
 utils/nfsdctl/nfsd_netlink.h |  10 +++
 utils/nfsdctl/nfsdctl.8      |  23 ++++++-
 utils/nfsdctl/nfsdctl.adoc   |  12 ++++
 utils/nfsdctl/nfsdctl.c      | 154 ++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 183 insertions(+), 18 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8cb42ebc5846..1aebc3a767a7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -265,7 +265,7 @@ AC_ARG_ENABLE(nfsdctl,
 
 		# ensure we have the pool-mode commands
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
-				                   [[int foo = NFSD_CMD_LISTENER_GET;]])],
+				                   [[int foo = NFSD_CMD_POOL_MODE_GET;]])],
 				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
 					      ["Use system's linux/nfsd_netlink.h"])])
 	fi
diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
index 24c86dbc7ed5..887cbd12b695 100644
--- a/utils/nfsdctl/nfsd_netlink.h
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -70,6 +70,14 @@ enum {
 	NFSD_A_SERVER_SOCK_MAX = (__NFSD_A_SERVER_SOCK_MAX - 1)
 };
 
+enum {
+	NFSD_A_POOL_MODE_MODE = 1,
+	NFSD_A_POOL_MODE_NPOOLS,
+
+	__NFSD_A_POOL_MODE_MAX,
+	NFSD_A_POOL_MODE_MAX = (__NFSD_A_POOL_MODE_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -78,6 +86,8 @@ enum {
 	NFSD_CMD_VERSION_GET,
 	NFSD_CMD_LISTENER_SET,
 	NFSD_CMD_LISTENER_GET,
+	NFSD_CMD_POOL_MODE_SET,
+	NFSD_CMD_POOL_MODE_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
index 7f5d981042a5..d55862cc1fc1 100644
--- a/utils/nfsdctl/nfsdctl.8
+++ b/utils/nfsdctl/nfsdctl.8
@@ -2,12 +2,12 @@
 .\"     Title: nfsdctl
 .\"    Author: Jeff Layton
 .\" Generator: Asciidoctor 2.0.20
-.\"      Date: 2024-04-23
+.\"      Date: 2024-06-13
 .\"    Manual: \ \&
 .\"    Source: \ \&
 .\"  Language: English
 .\"
-.TH "NFSDCTL" "8" "2024-04-23" "\ \&" "\ \&"
+.TH "NFSDCTL" "8" "2024-06-13" "\ \&" "\ \&"
 .ie \n(.g .ds Aq \(aq
 .el       .ds Aq '
 .ss \n[.ss] 0
@@ -176,6 +176,25 @@ all minorversions for that major version.
 .fi
 .if n .RE
 .RE
+.sp
+\fBpool\-mode\fP
+.RS 4
+Get/set the host\(cqs pool mode. This will cause the server to start threads
+that are pinned to either the CPU or the NUMA node. This can only be set
+when there are no nfsd threads running.
+.sp
+.if n .RS 4
+.nf
+.fam C
+The available options are:
+  global:  single large pool
+  percpu:  pool per CPU
+  pernode: pool per NUMA node
+  auto:    choose a mode based on host configuration
+.fam
+.fi
+.if n .RE
+.RE
 .SH "EXAMPLES"
 .sp
 Start the server with the settings in nfs.conf:
diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
index b2f00c11829e..03c5c281d92e 100644
--- a/utils/nfsdctl/nfsdctl.adoc
+++ b/utils/nfsdctl/nfsdctl.adoc
@@ -91,6 +91,18 @@ Each subcommand can also accept its own set of options and arguments. The
   The minorversion field is optional. If not given, it will disable or enable
   all minorversions for that major version.
 
+*pool-mode*::
+
+  Get/set the host's pool mode. This will cause the server to start threads
+  that are pinned to either the CPU or the NUMA node. This can only be set
+  when there are no nfsd threads running.
+
+  The available options are:
+    global:  single large pool
+    percpu:  pool per CPU
+    pernode: pool per NUMA node
+    auto:    choose a mode based on host configuration
+
 == EXAMPLES
 
 Start the server with the settings in nfs.conf:
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 986c937b620d..55bf5cd21783 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -320,20 +320,20 @@ static void parse_threads_get(struct genlmsghdr *gnlh)
 		struct nlattr *a;
 
 		switch (nla_type(attr)) {
-			case NFSD_A_SERVER_GRACETIME:
-				printf("gracetime: %u\n", nla_get_u32(attr));
-				break;
-			case NFSD_A_SERVER_LEASETIME:
-				printf("leasetime: %u\n", nla_get_u32(attr));
-				break;
-			case NFSD_A_SERVER_SCOPE:
-				printf("scope: %s\n", nla_data(attr));
-				break;
-			case NFSD_A_SERVER_THREADS:
-				pool_threads[i++] = nla_get_u32(attr);
-				break;
-			default:
-				break;
+		case NFSD_A_SERVER_GRACETIME:
+			printf("gracetime: %u\n", nla_get_u32(attr));
+			break;
+		case NFSD_A_SERVER_LEASETIME:
+			printf("leasetime: %u\n", nla_get_u32(attr));
+			break;
+		case NFSD_A_SERVER_SCOPE:
+			printf("scope: %s\n", nla_data(attr));
+			break;
+		case NFSD_A_SERVER_THREADS:
+			pool_threads[i++] = nla_get_u32(attr);
+			break;
+		default:
+			break;
 		}
 	}
 
@@ -343,6 +343,26 @@ static void parse_threads_get(struct genlmsghdr *gnlh)
 	putchar('\n');
 }
 
+static void parse_pool_mode_get(struct genlmsghdr *gnlh)
+{
+	struct nlattr *attr;
+	int rem;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		switch (nla_type(attr)) {
+		case NFSD_A_POOL_MODE_MODE:
+			printf("pool-mode: %s\n", nla_data(attr));
+			break;
+		case NFSD_A_POOL_MODE_NPOOLS:
+			printf("npools: %u\n", nla_get_u32(attr));
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static int recv_handler(struct nl_msg *msg, void *arg)
 {
 	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
@@ -361,6 +381,9 @@ static int recv_handler(struct nl_msg *msg, void *arg)
 	case NFSD_CMD_LISTENER_GET:
 		parse_listener_get(gnlh);
 		break;
+	case NFSD_CMD_POOL_MODE_GET:
+		parse_pool_mode_get(gnlh);
+		break;
 	default:
 		break;
 	}
@@ -1158,6 +1181,95 @@ static int listener_func(struct nl_sock *sock, int argc, char ** argv)
 	return 0;
 }
 
+static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret;
+
+	msg = netlink_msg_alloc(sock);
+	if (!msg)
+		return 1;
+
+	nlh = nlmsg_hdr(msg);
+	if (cmd == NFSD_CMD_POOL_MODE_SET) {
+		if (pool_mode)
+			nla_put_string(msg, NFSD_A_POOL_MODE_MODE, pool_mode);
+	}
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = cmd;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		fprintf(stderr, "send failed (%d)!\n", ret);
+		goto out_cb;
+	}
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, recv_handler, NULL);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+	if (ret < 0) {
+		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		ret = 1;
+	}
+out_cb:
+	nl_cb_put(cb);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static void pool_mode_usage(void)
+{
+	printf("Usage: %s pool-mode { global | auto | percpu | pernode } ...\n", taskname);
+}
+
+static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
+{
+	uint8_t cmd = NFSD_CMD_POOL_MODE_GET;
+	const char *pool_mode = NULL;
+	int opt;
+
+	optind = 1;
+	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			pool_mode_usage();
+			return 0;
+		}
+	}
+
+	if (optind < argc) {
+		char **targv = &argv[optind];
+		int i;
+
+		cmd = NFSD_CMD_POOL_MODE_SET;
+
+		/* empty string? */
+		if (targv[i][0] == '\0') {
+			fprintf(stderr, "Invalid threads value %s.\n", targv[i]);
+			return 1;
+		}
+
+		pool_mode = targv[0];
+	}
+	return pool_mode_doit(sock, cmd, pool_mode);
+}
+
 #define MAX_LISTENER_LEN (64 * 2 + 16)
 
 static int
@@ -1249,7 +1361,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	int *threads, grace, lease, idx, ret, opt;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
-	char *scope;
+	char *scope, *pool_mode;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
@@ -1262,6 +1374,13 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 
 	read_nfsd_conf();
 
+	pool_mode = conf_get_str("nfsd", "pool-mode");
+	if (pool_mode) {
+		ret = pool_mode_doit(sock, NFSD_CMD_POOL_MODE_SET, pool_mode);
+		if (ret)
+			return ret;
+	}
+
 	ret = fetch_nfsd_versions(sock);
 	if (ret)
 		return ret;
@@ -1312,6 +1431,7 @@ enum nfsdctl_commands {
 	NFSDCTL_VERSION,
 	NFSDCTL_LISTENER,
 	NFSDCTL_AUTOSTART,
+	NFSDCTL_POOL_MODE,
 };
 
 static int parse_command(char *str)
@@ -1326,6 +1446,8 @@ static int parse_command(char *str)
 		return NFSDCTL_LISTENER;
 	if (!strcmp(str, "autostart"))
 		return NFSDCTL_AUTOSTART;
+	if (!strcmp(str, "pool-mode"))
+		return NFSDCTL_POOL_MODE;
 	return -1;
 }
 
@@ -1337,6 +1459,7 @@ static nfsdctl_func func[] = {
 	[NFSDCTL_VERSION] = version_func,
 	[NFSDCTL_LISTENER] = listener_func,
 	[NFSDCTL_AUTOSTART] = autostart_func,
+	[NFSDCTL_POOL_MODE] = pool_mode_func,
 };
 
 static void usage(void)
@@ -1348,6 +1471,7 @@ static void usage(void)
 	printf("    -d | --debug=NUM     enable debugging\n");
 	printf("    -V | --version       print version info\n");
 	printf("  commands:\n");
+	printf("    pool-mode            get/set host pool mode setting\n");
 	printf("    listener             get/set listener info\n");
 	printf("    version              get/set supported NFS versions\n");
 	printf("    threads              get/set nfsd thread settings\n");

-- 
2.45.2


