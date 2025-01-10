Return-Path: <linux-nfs+bounces-9099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A631A09269
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 14:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23D91695FB
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0AE20E6EE;
	Fri, 10 Jan 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRhJbjia"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8B20E6E3
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516805; cv=none; b=Ux1e58AACGbRCx7JDfEX4yVjqL4yE5YK53aFFNaEl8PXXYFYw7YG2GKK+DuPot+iWa4/+Wfu8f9jupHg2XBxGk5nK/Cu5ABH601Io+IjDPws3zBaWyqK+hzMGxyIK76TMMXx6EuuZinW3l/fm2STS9SVLXtF0rKcz+HeT4lZNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516805; c=relaxed/simple;
	bh=7jfizV44XL6C/Eojn+gPB40Hc2BcZMct7cFKxDOgEus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzhlSg+1HKEv4XcGdqLNrolQyZuwn5fxjScTD8+t6+SolLdHOF3HG16ojYhgfUxdFYPWHC1qIMY2CeIvLuF34oE+j+7dBfr/G8DfMYrxd1TByfD02VbaRrPZdLA46glsJ7vblI8U/gD0rzrn7rZxETB7rZbP9iiXQmFFkEAZu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRhJbjia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31EEC4CEE0;
	Fri, 10 Jan 2025 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736516805;
	bh=7jfizV44XL6C/Eojn+gPB40Hc2BcZMct7cFKxDOgEus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kRhJbjia7VvEUN5ZQWXD/ocWmKAfxyjkRgryGMpHTac7lzzWKOJWuu3znz7/hBEyr
	 8HNhqDCURAM64mbGSVIES0B1/a7f1Aj+lCSrtDiXR4PAROxrkI6LGnUGzpwIlwEPdm
	 e4MsJTGexjLaUoEoYpGL7OgP121HweCAL+HSxuzO6LT7uyJNAxx/zBnn14QW9wy3Jl
	 Ff5RbXgNBuKDb2h8/odZviUdjnagOL2DxM3/XQlAgqVNAKw7v0KImQZeRUMuXjarmU
	 5VsaNrBqI3wWB9apJORbX+4lc/zdNMM4vfOMSOx3mwjU5lo1qmRF0FgJrWrkAodaRm
	 8TOx948ZnRcrA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Jan 2025 08:46:23 -0500
Subject: [PATCH v2 3/3] nfsdctl: add necessary bits to configure lockd
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-lockd-nl-v2-3-e3abe78cc7fb@kernel.org>
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
In-Reply-To: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13773; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7jfizV44XL6C/Eojn+gPB40Hc2BcZMct7cFKxDOgEus=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBngSTCMxsN4W/2YJ2YXzZC/umlIuL1inA93H9fq
 ACtlRhwE6iJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ4EkwgAKCRAADmhBGVaC
 FWahD/9Tzn+iyKM8pT2jIatyya41CGzIDWefoUiBAgYhI/ckuGzky4w/AayG0vpZIPDVVqxeYhq
 q3usBjzNyIlmLgxAhXM3e+HNic9jqaDEYVDBJXLLfy4E+MMBw+z/LodXTfOH+i8BQwHNPuwm06u
 pT/8+9E1OIIJjNHL227OGYi3tZ0cabIyDg4Y1bEVxzMaX7S3oQ88DHL4x3ZgYQoSYDy7U67iN5w
 8/quc3AFetdlWRXt5UffZ1v3MWaVcbHX2BvcC912sOpH6qT3nLU1cyMA8AiKwL1ihm/oQPJVsSe
 Z8Xcw8NPZPVXCN2x12hkV1rlxvYqCLvD31FdzFJ3hKGiKHOfkngkTm3bxf5gcPvH7cmd/ALXlr7
 cnTmlX0rWPES/s55Vgmc2NV86M2Kw3Kp9K+lxktEWMjci1xQ8E4UZPj8ZbAZVabcxjt+UwTBLgt
 fRpkFcaZ9OzaPlyclwWxd/mTxBfcEG8NZOQg7DGRyFsuqmRWoJNC9xbxjZzdgpOHDzJWK1z95sX
 MPWvuuTzCXmimIgD9bND8IOxqMRTYHH7eJp1xMeIzQOi0IIa6EGD1WaZe48bvm16BrKqvhcgA7a
 NmqsAU/xoHQ4Cn5ggd4GWqpB1dDhU0TUBrN24UyJ3tPY8DbLyB/ZbDIt49EHDbRWUChCq8l/zLZ
 Mum20Ju8c95xyHA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The legacy rpc.nfsd program would configure the nlm_grace_period to
match the NFSv4 grace period when starting the server. This adds similar
functionality to the autostart subcommand using the new lockd netlink
configuration interfaces. In addition, if lockd's udp or tcp listener
ports are specified, also configure them before starting the server.

A "nlm" subcommand is also added that will display the current lockd
config settings in the current net ns. In the future, we could add the
ability to set these values using the "nlm" subcommand, but for now I
didn't see a real use-case for that, so I left it out.

Link: https://issues.redhat.com/browse/RHEL-71698
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac                  |   4 +
 utils/nfsdctl/lockd_netlink.h |  29 ++++++
 utils/nfsdctl/nfsdctl.8       |   6 ++
 utils/nfsdctl/nfsdctl.adoc    |   5 +
 utils/nfsdctl/nfsdctl.c       | 218 +++++++++++++++++++++++++++++++++++++++---
 5 files changed, 249 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index 561e894dc46f48997df4ba6dc3e7691876589fdb..1d865fbc1c7f79e3ac6152bc59995e99fe10a38e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -268,6 +268,10 @@ AC_ARG_ENABLE(nfsdctl,
 				                   [[int foo = NFSD_CMD_POOL_MODE_GET;]])],
 				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
 					      ["Use system's linux/nfsd_netlink.h"])])
+		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
+				                   [[int foo = LOCKD_CMD_SERVER_GET;]])],
+				   [AC_DEFINE([USE_SYSTEM_LOCKD_NETLINK_H], 1,
+					      ["Use system's linux/lockd_netlink.h"])])
 	fi
 
 AC_ARG_ENABLE(nfsv4server,
diff --git a/utils/nfsdctl/lockd_netlink.h b/utils/nfsdctl/lockd_netlink.h
new file mode 100644
index 0000000000000000000000000000000000000000..21c65aec3bc6d1839961937081e6d16540332179
--- /dev/null
+++ b/utils/nfsdctl/lockd_netlink.h
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
diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
index 39ae1855ae50e94da113981d5e8cf8ac14440c3a..d69922448eb17fb155f05dc4ddc9aefffbf966e4 100644
--- a/utils/nfsdctl/nfsdctl.8
+++ b/utils/nfsdctl/nfsdctl.8
@@ -127,6 +127,12 @@ colon separated form, and must be enclosed in square brackets.
 .if n .RE
 .RE
 .sp
+\fBnlm\fP
+.RS 4
+Get information about NLM (lockd) settings in the current net namespace. This
+subcommand takes no arguments.
+.RE
+.sp
 \fBstatus\fP
 .RS 4
 Get information about RPCs currently executing in the server. This subcommand
diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
index 2114693042594297b7c5d8600ca16813a0f2356c..0207eff6118d2dcc5a794d2013c039d9beb11ddc 100644
--- a/utils/nfsdctl/nfsdctl.adoc
+++ b/utils/nfsdctl/nfsdctl.adoc
@@ -67,6 +67,11 @@ Each subcommand can also accept its own set of options and arguments. The
   addresses must be in dotted-quad form. IPv6 addresses should be in standard
   colon separated form, and must be enclosed in square brackets.
 
+*nlm*::
+
+  Get information about NLM (lockd) settings in the current net namespace. This
+  subcommand takes no arguments.
+
 *status*::
 
   Get information about RPCs currently executing in the server. This subcommand
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 5c319a74273fd2bbe84003c1261043c4b2f1ff29..003daba5f30a403eb4168f6103e5a496d96968a4 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -35,6 +35,12 @@
 #include "nfsd_netlink.h"
 #endif
 
+#ifdef USE_SYSTEM_LOCKD_NETLINK_H
+#include <linux/lockd_netlink.h>
+#else
+#include "lockd_netlink.h"
+#endif
+
 #include "nfsdctl.h"
 #include "conffile.h"
 #include "xlog.h"
@@ -348,6 +354,28 @@ static void parse_pool_mode_get(struct genlmsghdr *gnlh)
 	}
 }
 
+static void parse_lockd_get(struct genlmsghdr *gnlh)
+{
+	struct nlattr *attr;
+	int rem;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		switch (nla_type(attr)) {
+		case LOCKD_A_SERVER_GRACETIME:
+			printf("gracetime: %u\n", nla_get_u32(attr));
+			break;
+		case LOCKD_A_SERVER_TCP_PORT:
+			printf("tcp_port: %hu\n", nla_get_u16(attr));
+			break;
+		case LOCKD_A_SERVER_UDP_PORT:
+			printf("udp_port: %hu\n", nla_get_u16(attr));
+			break;
+		default:
+			break;
+		}
+	}
+}
 static int recv_handler(struct nl_msg *msg, void *arg)
 {
 	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
@@ -368,6 +396,9 @@ static int recv_handler(struct nl_msg *msg, void *arg)
 	case NFSD_CMD_POOL_MODE_GET:
 		parse_pool_mode_get(gnlh);
 		break;
+	case LOCKD_CMD_SERVER_GET:
+		parse_lockd_get(gnlh);
+		break;
 	default:
 		break;
 	}
@@ -398,12 +429,12 @@ static struct nl_sock *netlink_sock_alloc(void)
 	return sock;
 }
 
-static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock)
+static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family)
 {
 	struct nl_msg *msg;
 	int id;
 
-	id = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
+	id = genl_ctrl_resolve(sock, family);
 	if (id < 0) {
 		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
 		return NULL;
@@ -447,7 +478,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
 		}
 	}
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -495,7 +526,7 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -607,7 +638,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -672,7 +703,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int i, ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -825,7 +856,7 @@ static int fetch_current_listeners(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -1054,7 +1085,7 @@ static int set_listeners(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int i, ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -1170,7 +1201,7 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -1249,6 +1280,131 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
 	return pool_mode_doit(sock, cmd, pool_mode);
 }
 
+static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcpport, int udpport)
+{
+	struct genlmsghdr *ghdr;
+	struct nlmsghdr *nlh;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int ret;
+
+	if (cmd == LOCKD_CMD_SERVER_SET) {
+		/* Do nothing if there is nothing to set */
+		if (!grace && !tcpport && !udpport)
+			return 0;
+	}
+
+	msg = netlink_msg_alloc(sock, LOCKD_FAMILY_NAME);
+	if (!msg)
+		return 1;
+
+	nlh = nlmsg_hdr(msg);
+	if (cmd == LOCKD_CMD_SERVER_SET) {
+		if (grace)
+			nla_put_u32(msg, LOCKD_A_SERVER_GRACETIME, grace);
+		if (tcpport)
+			nla_put_u16(msg, LOCKD_A_SERVER_TCP_PORT, tcpport);
+		if (udpport)
+			nla_put_u16(msg, LOCKD_A_SERVER_UDP_PORT, udpport);
+	}
+
+	ghdr = nlmsg_data(nlh);
+	ghdr->cmd = cmd;
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		xlog(L_ERROR, "failed to allocate netlink callbacks\n");
+		ret = 1;
+		goto out;
+	}
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		xlog(L_ERROR, "send failed (%d)!\n", ret);
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
+		xlog(L_ERROR, "Error: %s\n", strerror(-ret));
+		ret = 1;
+	}
+out_cb:
+	nl_cb_put(cb);
+out:
+	nlmsg_free(msg);
+	return ret;
+}
+
+static int get_service(const char *svc)
+{
+	struct addrinfo *res, hints = { .ai_flags = AI_PASSIVE };
+	int ret, port;
+
+	if (!svc)
+		return 0;
+
+	ret = getaddrinfo(NULL, svc, &hints, &res);
+	if (ret) {
+		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s\n",
+			svc, gai_strerror(ret));
+		return -1;
+	}
+
+	switch (res->ai_family) {
+	case AF_INET:
+		{
+			struct sockaddr_in *sin = (struct sockaddr_in *)res->ai_addr;
+
+			port = ntohs(sin->sin_port);
+		}
+		break;
+	case AF_INET6:
+		{
+			struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)res->ai_addr;
+
+			port = ntohs(sin6->sin6_port);
+		}
+		break;
+	default:
+		xlog(L_ERROR, "Bad address family: %d\n", res->ai_family);
+		port = -1;
+	}
+	freeaddrinfo(res);
+	return port;
+}
+
+static int lockd_configure(struct nl_sock *sock, int grace)
+{
+	char *tcp_svc, *udp_svc;
+	int tcpport = 0, udpport = 0;
+	int ret;
+
+	tcp_svc = conf_get_str("lockd", "port");
+	if (tcp_svc) {
+		tcpport = get_service(tcp_svc);
+		if (tcpport < 0)
+			return 1;
+	}
+
+	udp_svc = conf_get_str("lockd", "udp-port");
+	if (udp_svc) {
+		udpport = get_service(udp_svc);
+		if (udpport < 0)
+			return 1;
+	}
+
+	return lockd_config_doit(sock, LOCKD_CMD_SERVER_SET, grace, tcpport, udpport);
+}
+
+
 #define MAX_LISTENER_LEN (64 * 2 + 16)
 
 static void
@@ -1355,6 +1511,13 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 
 	read_nfsd_conf();
 
+	grace = conf_get_num("nfsd", "grace-time", 0);
+	ret = lockd_configure(sock, grace);
+	if (ret) {
+		xlog(L_ERROR, "lockd configuration failure");
+		return ret;
+	}
+
 	pool_mode = conf_get_str("nfsd", "pool-mode");
 	if (pool_mode) {
 		ret = pool_mode_doit(sock, NFSD_CMD_POOL_MODE_SET, pool_mode);
@@ -1370,15 +1533,12 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	if (ret)
 		return ret;
 
+	xlog(D_GENERAL, "configuring listeners");
 	configure_listeners();
 	ret = set_listeners(sock);
 	if (ret)
 		return ret;
 
-	grace = conf_get_num("nfsd", "grace-time", 0);
-	lease = conf_get_num("nfsd", "lease-time", 0);
-	scope = conf_get_str("nfsd", "scope");
-
 	thread_str = conf_get_list("nfsd", "threads");
 	pools = thread_str ? thread_str->cnt : 1;
 
@@ -1402,6 +1562,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		threads[0] = DEFAULT_AUTOSTART_THREADS;
 	}
 
+	lease = conf_get_num("nfsd", "lease-time", 0);
+	scope = conf_get_str("nfsd", "scope");
+
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
 			   threads, scope);
 out:
@@ -1409,6 +1572,30 @@ out:
 	return ret;
 }
 
+static void nlm_usage(void)
+{
+	printf("Usage: %s nlm\n", taskname);
+	printf("    Get the current settings for the NLM (lockd) server.\n");
+}
+
+static int nlm_func(struct nl_sock *sock, int argc, char ** argv)
+{
+	int *threads, grace, lease, idx, ret, opt, pools;
+	struct conf_list *thread_str;
+	struct conf_list_node *n;
+	char *scope, *pool_mode;
+
+	optind = 1;
+	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			nlm_usage();
+			return 0;
+		}
+	}
+	return lockd_config_doit(sock, LOCKD_CMD_SERVER_GET, 0, 0, 0);
+}
+
 enum nfsdctl_commands {
 	NFSDCTL_STATUS,
 	NFSDCTL_THREADS,
@@ -1416,6 +1603,7 @@ enum nfsdctl_commands {
 	NFSDCTL_LISTENER,
 	NFSDCTL_AUTOSTART,
 	NFSDCTL_POOL_MODE,
+	NFSDCTL_NLM,
 };
 
 static int parse_command(char *str)
@@ -1432,6 +1620,8 @@ static int parse_command(char *str)
 		return NFSDCTL_AUTOSTART;
 	if (!strcmp(str, "pool-mode"))
 		return NFSDCTL_POOL_MODE;
+	if (!strcmp(str, "nlm"))
+		return NFSDCTL_NLM;
 	return -1;
 }
 
@@ -1444,6 +1634,7 @@ static nfsdctl_func func[] = {
 	[NFSDCTL_LISTENER] = listener_func,
 	[NFSDCTL_AUTOSTART] = autostart_func,
 	[NFSDCTL_POOL_MODE] = pool_mode_func,
+	[NFSDCTL_NLM] = nlm_func,
 };
 
 static void usage(void)
@@ -1460,6 +1651,7 @@ static void usage(void)
 	printf("    listener             get/set listener info\n");
 	printf("    version              get/set supported NFS versions\n");
 	printf("    threads              get/set nfsd thread settings\n");
+	printf("    nlm                  get current nlm settings\n");
 	printf("    status               get current RPC processing info\n");
 	printf("    autostart            start server with settings from /etc/nfs.conf\n");
 }

-- 
2.47.1


