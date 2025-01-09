Return-Path: <linux-nfs+bounces-9037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B150A080A8
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 20:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257E6188BE2F
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821941F542F;
	Thu,  9 Jan 2025 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8oDRKBm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA851F427A
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451612; cv=none; b=bp+hha7fKF8me6PjileREuE+DErE5obTI8rhSiv1I9k11GrGsxqYZ4XN9uBwzZWQSeZSK5R1lrT/OlmADdGi1CmJ3MguMZhjkJ11iXSxaxs8ZNY6sOuIhFtkmEc3zgvsXHdHSZplcGTp6OjOLikX9GXPoIjLYP5glL1Z1+kx+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451612; c=relaxed/simple;
	bh=8Qh1IqUgEJ+JN41r4/O4Oe+sd0HayAGH3uQ/rvuNMS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELJMBERgiHENscmCgsVEZ3o+ASzbf2VvzynhidhJpoNTTvp2CCw2oQ14MHSSrXWkoUH3I+xjIgfZDR8HC9yYkQbE6XF1mh+waPwmD+yb/hLCIIlfWThZwrwC8JF2tl2uHdG9PM9smU3VOzE6/lhvKbl6x4dy6Z2qNyIRvy9zzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8oDRKBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D27C4CEE2;
	Thu,  9 Jan 2025 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736451612;
	bh=8Qh1IqUgEJ+JN41r4/O4Oe+sd0HayAGH3uQ/rvuNMS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N8oDRKBmMX7eyx5w7B/HPT6lBO2P4G3KMzk7GOfmjEGUviULS+1OW0yCmHhm2QtJp
	 7qVlN9GfgbGFZyJDnFpna9H2wKnZASmbs8CE8eVNxzaCL64mXjjIz0j5PcKuEpeJKh
	 zPLq5XX0FfT0BZyZaToPGrvWOiY2JQucbldFTu4lHVGTvtUL+CrTctmYSCQFZHYr7x
	 xBxPn3ltrjDswN5is2W8mpo9jOcc6Z5P0M7uKV0/obHxKML8j5pwt0CVnwo5/uvYgm
	 RKKngVdd1Gi6wfOVjOnuKzz66bb0IMR61IOVWTOn8caZ6s14QisdCeSxhbnX7lMW0F
	 s/4IQ3m4nwFCQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jan 2025 14:40:06 -0500
Subject: [PATCH 3/3] nfsdctl: add necessary bits to configure lockd
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-lockd-nl-v1-3-108548ab0b6b@kernel.org>
References: <20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org>
In-Reply-To: <20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13814; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8Qh1IqUgEJ+JN41r4/O4Oe+sd0HayAGH3uQ/rvuNMS0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBngCYZED/+uRWLxKmDphczt+ZuMNxzH/74UcQhx
 Q+YywAZ8AWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ4AmGQAKCRAADmhBGVaC
 FTBCD/9jv29lZOmcmHZufgpE5mCTCvFAFTH20rAEnoVG5XpExE3oMly4QwqZodoGRVVl2vI8mb6
 XYZ0ID3vYY7Ng2wcDvfHWEJ+1DIny5lkVq4s0Hg7qbmQxC+GWoSTpHQIwE5icPdCnFmIZXSpuKD
 y/DkiE0bRyOhVA6BR+gxTfttMjoz0jRdSmMHIQ/LFxS2HQZQZUWXas8Xta3y0hukit64iC1k+nm
 kPz6IrY94JxBZ2hN+DJMPbBLZ59fXr0dBF4td+/Nj5Ad0bgpsT+zJOVJwPzoYVP5Qmq4+LBqupO
 KOx3dFb/LnjfYMmjklimVd8WxXXJc0WV9TY99qUoKLXNh8F5DpxqLf1qPil+gwHYrOHyjNvVFss
 wLxKCPw9WuwMnUifNzx1uaD3QTxi+Si9UXjFYPhZ/BdDJkP+zAfoc18eCF0L+n1J4rUjCwbCrGY
 CDEEF1J2DMxDZOaYEsL/ViOPaJrN2rKxdybg0nnuehaVwZd85Am82P7qDiLYpC9F0xvfvOF7EYw
 mixsuFjTDmsY6pHYp6vrtuiWFyz2KNcPggidKBUWBGqhP35xY/Ioo54e3TA3ZEq9vkc6cVc/GDJ
 WdsOlwh24IIi2IiHGhpFARllhl6kJ3rqunjDCPVP4C5KGR4tj1MdUsZmid9oKsG2j+34Aw7SQg7
 bnVqfjbXMebr+kg==
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
 utils/nfsdctl/nfsdctl.adoc    |   5 +
 utils/nfsdctl/nfsdctl.c       | 220 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 242 insertions(+), 16 deletions(-)

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
index 2cd58fef079aec74000bb68a81a05eb7bd876d7f..40a0f4e5936a87a38ef69487aec35c990b95b97c 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -35,7 +35,11 @@
 #include "nfsd_netlink.h"
 #endif
 
+#ifdef USE_SYSTEM_LOCKD_NETLINK_H
+#include <linux/lockd_netlink.h>
+#else
 #include "lockd_netlink.h"
+#endif
 
 #include "nfsdctl.h"
 #include "conffile.h"
@@ -350,6 +354,28 @@ static void parse_pool_mode_get(struct genlmsghdr *gnlh)
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
@@ -370,6 +396,9 @@ static int recv_handler(struct nl_msg *msg, void *arg)
 	case NFSD_CMD_POOL_MODE_GET:
 		parse_pool_mode_get(gnlh);
 		break;
+	case LOCKD_CMD_SERVER_GET:
+		parse_lockd_get(gnlh);
+		break;
 	default:
 		break;
 	}
@@ -400,12 +429,12 @@ static struct nl_sock *netlink_sock_alloc(void)
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
@@ -449,7 +478,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
 		}
 	}
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -497,7 +526,7 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -609,7 +638,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -674,7 +703,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int i, ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -827,7 +856,7 @@ static int fetch_current_listeners(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -1056,7 +1085,7 @@ static int set_listeners(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int i, ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -1172,7 +1201,7 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock);
+	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
 	if (!msg)
 		return 1;
 
@@ -1251,6 +1280,131 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
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
@@ -1357,6 +1511,13 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 
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
@@ -1372,15 +1533,12 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
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
 
@@ -1404,6 +1562,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		threads[0] = DEFAULT_AUTOSTART_THREADS;
 	}
 
+	lease = conf_get_num("nfsd", "lease-time", 0);
+	scope = conf_get_str("nfsd", "scope");
+
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
 			   threads, scope);
 out:
@@ -1411,6 +1572,30 @@ out:
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
@@ -1418,6 +1603,7 @@ enum nfsdctl_commands {
 	NFSDCTL_LISTENER,
 	NFSDCTL_AUTOSTART,
 	NFSDCTL_POOL_MODE,
+	NFSDCTL_NLM,
 };
 
 static int parse_command(char *str)
@@ -1434,6 +1620,8 @@ static int parse_command(char *str)
 		return NFSDCTL_AUTOSTART;
 	if (!strcmp(str, "pool-mode"))
 		return NFSDCTL_POOL_MODE;
+	if (!strcmp(str, "nlm"))
+		return NFSDCTL_NLM;
 	return -1;
 }
 
@@ -1446,6 +1634,7 @@ static nfsdctl_func func[] = {
 	[NFSDCTL_LISTENER] = listener_func,
 	[NFSDCTL_AUTOSTART] = autostart_func,
 	[NFSDCTL_POOL_MODE] = pool_mode_func,
+	[NFSDCTL_NLM] = nlm_func,
 };
 
 static void usage(void)
@@ -1454,13 +1643,14 @@ static void usage(void)
 	printf("%s [-hv] [COMMAND] [ARGS]\n", taskname);
 	printf("  options:\n");
 	printf("    -h | --help          usage info\n");
-	printf("    -d | --debug=NUM     enable debugging\n");
+	printf("    -d | --debug         enable debugging\n");
 	printf("    -V | --version       print version info\n");
 	printf("  commands:\n");
 	printf("    pool-mode            get/set host pool mode setting\n");
 	printf("    listener             get/set listener info\n");
 	printf("    version              get/set supported NFS versions\n");
 	printf("    threads              get/set nfsd thread settings\n");
+	printf("    nlm                  get current nlm settings\n");
 	printf("    status               get current RPC processing info\n");
 	printf("    autostart            start server with settings from /etc/nfs.conf\n");
 }
@@ -1522,8 +1712,6 @@ static int run_commandline(struct nl_sock *sock)
 		ret = tokenize_string(line, &argc, argv);
 		if (!ret)
 			ret = run_one_command(sock, argc, argv);
-		if (ret)
-			xlog(L_ERROR, "Error: %s", strerror(ret));
 		free(line);
 	}
 	return 0;

-- 
2.47.1


