Return-Path: <linux-nfs+bounces-9097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD57A09265
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 14:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9343A9A88
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510720E015;
	Fri, 10 Jan 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXPR7Qih"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECE20B804
	for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516804; cv=none; b=BwguAg4jMh2UY/1blVnH7CQiThRC5rEk0uB/A9LyN0vRQ0c1DXozonJ+CJZgJPiA4Fs4OsB7/WOsLCuFZS+k2jxmm4PBFie7gQaNSxUdZVkD90FFYwEtB1tTN0tFa6+MR/uhMNlXtQXZ7xkF3hCdXKdKA5UL7wq+Nd70ttNpfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516804; c=relaxed/simple;
	bh=TSCjJkuQJr6HDbAAc9MibdG9ISKIr7P2zAqztMO7QOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8s61LC/dritSonJYZIa7eGcyjAEtGNFKCcVJ02eK62KbobcfGbRIPjnZTv0bsU9hdnnXceMQDw2U5uUQgbdvh6dwv6rv023eB817Q+mFjwgyELG4LuWmpyL2w2y8iIbyb1cFiqYFwFbyJvCtL1WIReDbMgUe9/Vxm1Wo7pvSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXPR7Qih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2ABC4CEE0;
	Fri, 10 Jan 2025 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736516803;
	bh=TSCjJkuQJr6HDbAAc9MibdG9ISKIr7P2zAqztMO7QOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TXPR7Qihca1yaHGKyyy/xqp1QKFB7BxxknygaChoRU78uVy/gUBoGkXtklYxoiTjK
	 H8g031azuC1jmrPIi1lv0CGVb8WmKjHJe+Si9AMnkP6ZTkmVy1gtlciHYimFWOQ1dw
	 KSskSvOZbsBXgyyfErOha55SPMufanNODsiz0qavCSrGYORf8xooeeAk1+fSPSB9sv
	 7uXTFA/Ou7qTaxJGXcmGnjLtoZBpmxFG9OIWZFZOS9qkXcREPcAU1UR53QF8hvNax1
	 iApoq1u0LQ3Jpuv29DBcPYDzuqJMyo+dpM7KIbWfwicOzGPiWMGx9XxPcM8sJDZjyf
	 0kCCoeafI9RCw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Jan 2025 08:46:21 -0500
Subject: [PATCH v2 1/3] nfsdctl: convert to xlog()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-lockd-nl-v2-1-e3abe78cc7fb@kernel.org>
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
In-Reply-To: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14383; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TSCjJkuQJr6HDbAAc9MibdG9ISKIr7P2zAqztMO7QOQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBngSTB0QOFazVHm+Aau/TNxUVJTOI4rp3vRWD5i
 qpet+wLSpiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ4EkwQAKCRAADmhBGVaC
 FQwmD/9w5TL37Voj2WmDZbZK4BHEKDMkdUL6a7oakXNP6UEdOAPHEYaLbHjklvWvTV92nbq6NWc
 CohxVeahXwPEwG5GPTWjUk+RPB4UOsh2hNXHE2XUjq3xLXGhXhHfN4IK0u1ih+9uIfTkA9BnFM4
 nNeKtiLjgEzjrkv/HV2L9tYCH5LFZiDdb4lqg8H7lDQNFgZW/jYR5et5nvTwDD0jKDL73/cyOH6
 37jtsIf2i9t3OzsvDV4r7QvL4ttaGthmjrsE9x/0FYUCxex4nhBo0KQuizUl5ZnXgVEqNVWCcDa
 iHuB8MJ/+iLdAcGxtzbpam5AjvXkXpJbGt67LjJJIsmIlUWzQbidSUsOHa1s+0UW3V221/eNEw/
 /QcpSY1FZbhH539rW/EH6P7waKUzYKLW1LgjdQpozfPEhbkkhRyu196+OFPnz0iTulGOeOnVQjf
 JPEzTAAYUZfgxAOCNDswALY3aO3cDSBdEECBPeg5fEV3oVbzBzba300yfiYJeFwR7lZ5e65rPQN
 iLDaHLwDYA1PdnDfDKaBP+GszNWh7yMGwkQuZ57OvCsFAwNYpeUyrvW6wNsCJZV23P7mFjgOutn
 uqbjN0DSSNQLW3E7y+EY9mB5SArz7GsRhnlEE9kthRaX4rV5htYD+Oo//Z9TOOthcvKRiAnlcrG
 jrwtQsVcCpYhdJg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert all of the fprintf(stderr, ...) calls to xlog(L_ERROR, ...)
calls.  Change the -d option to not take an argument, and add a -s
option that will make nfsdctl log to syslog instead of stderr.

Also remove the extraneous error message in run_commandline, and add
a couple of trivial debug messages when the program starts and ends

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.8    |   9 +++-
 utils/nfsdctl/nfsdctl.adoc |   3 ++
 utils/nfsdctl/nfsdctl.c    | 111 +++++++++++++++++++++++++--------------------
 3 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
index b08fe8036a70155b8f8713ffccb861b98b15302a..39ae1855ae50e94da113981d5e8cf8ac14440c3a 100644
--- a/utils/nfsdctl/nfsdctl.8
+++ b/utils/nfsdctl/nfsdctl.8
@@ -2,12 +2,12 @@
 .\"     Title: nfsdctl
 .\"    Author: Jeff Layton
 .\" Generator: Asciidoctor 2.0.20
-.\"      Date: 2024-12-30
+.\"      Date: 2025-01-09
 .\"    Manual: \ \&
 .\"    Source: \ \&
 .\"  Language: English
 .\"
-.TH "NFSDCTL" "8" "2024-12-30" "\ \&" "\ \&"
+.TH "NFSDCTL" "8" "2025-01-09" "\ \&" "\ \&"
 .ie \n(.g .ds Aq \(aq
 .el       .ds Aq '
 .ss \n[.ss] 0
@@ -60,6 +60,11 @@ Enable debug logging
 Print program help text
 .RE
 .sp
+\fB\-s, \-\-syslog\fP
+.RS 4
+Log to syslog instead of to stderr (the default)
+.RE
+.sp
 \fB\-V, \-\-version\fP
 .RS 4
 Print program version
diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
index c5921458a8e81e749d264cc7dd8344889ec71ac5..2114693042594297b7c5d8600ca16813a0f2356c 100644
--- a/utils/nfsdctl/nfsdctl.adoc
+++ b/utils/nfsdctl/nfsdctl.adoc
@@ -30,6 +30,9 @@ To get information about different subcommand usage, pass the subcommand the
 *-h, --help*::
   Print program help text
 
+*-s, --syslog*::
+  Log to syslog instead of to stderr (the default)
+
 *-V, --version*::
   Print program version
 
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index ef917ff037e4ef9c532f814eb144ade642112036..e6819aec9890ae675a43b8259021ebaa909b08b9 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -43,8 +43,6 @@
  * gcc -I/usr/include/libnl3/ -o <prog-name> <prog-name>.c -lnl-3 -lnl-genl-3
  */
 
-static int debug_level;
-
 struct nfs_version {
 	uint8_t	major;
 	uint8_t	minor;
@@ -388,7 +386,7 @@ static struct nl_sock *netlink_sock_alloc(void)
 		return NULL;
 
 	if (genl_connect(sock)) {
-		fprintf(stderr, "Failed to connect to generic netlink\n");
+		xlog(L_ERROR, "Failed to connect to generic netlink");
 		nl_socket_free(sock);
 		return NULL;
 	}
@@ -407,18 +405,18 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock)
 
 	id = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
 	if (id < 0) {
-		fprintf(stderr, "%s not found\n", NFSD_FAMILY_NAME);
+		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
 		return NULL;
 	}
 
 	msg = nlmsg_alloc();
 	if (!msg) {
-		fprintf(stderr, "failed to allocate netlink message\n");
+		xlog(L_ERROR, "failed to allocate netlink message");
 		return NULL;
 	}
 
 	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
-		fprintf(stderr, "failed to allocate netlink message\n");
+		xlog(L_ERROR, "failed to allocate netlink message");
 		nlmsg_free(msg);
 		return NULL;
 	}
@@ -460,7 +458,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
@@ -478,7 +476,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -519,14 +517,14 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		fprintf(stderr, "send failed (%d)!\n", ret);
+		xlog(L_ERROR, "send failed (%d)!", ret);
 		goto out_cb;
 	}
 
@@ -539,7 +537,7 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -584,13 +582,13 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 
 			/* empty string? */
 			if (targv[i][0] == '\0') {
-				fprintf(stderr, "Invalid threads value %s.\n", targv[i]);
+				xlog(L_ERROR, "Invalid threads value %s.", targv[i]);
 				return 1;
 			}
 
 			pool_threads[i] = strtol(targv[i], &endptr, 0);
 			if (!endptr || *endptr != '\0') {
-				fprintf(stderr, "Invalid threads value %s.\n", argv[1]);
+				xlog(L_ERROR, "Invalid threads value %s.", argv[1]);
 				return 1;
 			}
 		}
@@ -619,14 +617,14 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		fprintf(stderr, "send failed: %d\n", ret);
+		xlog(L_ERROR, "send failed: %d", ret);
 		goto out_cb;
 	}
 
@@ -639,7 +637,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -688,7 +686,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
 
 		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_PROTO_VERSION);
 		if (!a) {
-			fprintf(stderr, "Unable to allocate version nest!\n");
+			xlog(L_ERROR, "Unable to allocate version nest!");
 			ret = 1;
 			goto out;
 		}
@@ -705,14 +703,14 @@ static int set_nfsd_versions(struct nl_sock *sock)
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		fprintf(stderr, "Failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "Failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		fprintf(stderr, "Send failed: %d\n", ret);
+		xlog(L_ERROR, "Send failed: %d", ret);
 		goto out_cb;
 	}
 
@@ -725,7 +723,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -750,7 +748,7 @@ static int update_nfsd_version(int major, int minor, bool enabled)
 	/* the kernel doesn't support this version */
 	if (!enabled)
 		return 0;
-	fprintf(stderr, "This kernel does not support NFS version %d.%d\n", major, minor);
+	xlog(L_ERROR, "This kernel does not support NFS version %d.%d", major, minor);
 	return -EINVAL;
 }
 
@@ -792,7 +790,7 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
 
 			ret = sscanf(str, "%c%d.%d\n", &sign, &major, &minor);
 			if (ret < 2) {
-				fprintf(stderr, "Invalid version string (%d) %s\n", ret, str);
+				xlog(L_ERROR, "Invalid version string (%d) %s", ret, str);
 				return -EINVAL;
 			}
 
@@ -804,7 +802,7 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
 				enabled = false;
 				break;
 			default:
-				fprintf(stderr, "Invalid version string %s\n", str);
+				xlog(L_ERROR, "Invalid version string %s", str);
 				return -EINVAL;
 			}
 
@@ -837,14 +835,14 @@ static int fetch_current_listeners(struct nl_sock *sock)
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		fprintf(stderr, "send failed: %d\n", ret);
+		xlog(L_ERROR, "send failed: %d", ret);
 		goto out_cb;
 	}
 
@@ -857,7 +855,7 @@ static int fetch_current_listeners(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -992,7 +990,7 @@ static int update_listeners(const char *str)
 	 */
 	ret = getaddrinfo(addr, port, &hints, &res);
 	if (ret) {
-		fprintf(stderr, "getaddrinfo of \"%s\" failed: %s\n",
+		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s",
 			addr, gai_strerror(ret));
 		return -EINVAL;
 	}
@@ -1044,7 +1042,7 @@ static int update_listeners(const char *str)
 	}
 	return 0;
 out_inval:
-	fprintf(stderr, "Invalid listener update string: %s", str);
+	xlog(L_ERROR, "Invalid listener update string: %s", str);
 	return -EINVAL;
 }
 
@@ -1074,7 +1072,7 @@ static int set_listeners(struct nl_sock *sock)
 
 		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_SOCK_ADDR);
 		if (!a) {
-			fprintf(stderr, "Unable to allocate listener nest!\n");
+			xlog(L_ERROR, "Unable to allocate listener nest!");
 			ret = 1;
 			goto out;
 		}
@@ -1089,14 +1087,14 @@ static int set_listeners(struct nl_sock *sock)
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		fprintf(stderr, "Failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "Failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		fprintf(stderr, "Send failed: %d\n", ret);
+		xlog(L_ERROR, "Send failed: %d", ret);
 		goto out_cb;
 	}
 
@@ -1109,7 +1107,7 @@ static int set_listeners(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -1186,14 +1184,14 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		fprintf(stderr, "send failed (%d)!\n", ret);
+		xlog(L_ERROR, "send failed (%d)!", ret);
 		goto out_cb;
 	}
 
@@ -1206,7 +1204,7 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -1243,7 +1241,7 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
 
 		/* empty string? */
 		if (*targv[0] == '\0') {
-			fprintf(stderr, "Invalid threads value %s.\n", targv[0]);
+			xlog(L_ERROR, "Invalid threads value %s.", targv[0]);
 			return 1;
 		}
 		pool_mode = targv[0];
@@ -1395,7 +1393,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 
 			threads[idx++] = strtol(n->field, &endptr, 0);
 			if (!endptr || *endptr != '\0') {
-				fprintf(stderr, "Invalid threads value %s.\n", n->field);
+				xlog(L_ERROR, "Invalid threads value %s.", n->field);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -1451,10 +1449,11 @@ static nfsdctl_func func[] = {
 static void usage(void)
 {
 	printf("Usage:\n");
-	printf("%s [-hv] [COMMAND] [ARGS]\n", taskname);
+	printf("%s [-hdsV] [COMMAND] [ARGS]\n", taskname);
 	printf("  options:\n");
 	printf("    -h | --help          usage info\n");
-	printf("    -d | --debug=NUM     enable debugging\n");
+	printf("    -d | --debug         enable debugging\n");
+	printf("    -s | --syslog        log messages to syslog\n");
 	printf("    -V | --version       print version info\n");
 	printf("  commands:\n");
 	printf("    pool-mode            get/set host pool mode setting\n");
@@ -1468,7 +1467,8 @@ static void usage(void)
 /* Options given before the command string */
 static const struct option pre_options[] = {
 	{ "help", no_argument, NULL, 'h' },
-	{ "debug", required_argument, NULL, 'd' },
+	{ "debug", no_argument, NULL, 'd' },
+	{ "syslog", no_argument, NULL, 's' },
 	{ "version", no_argument, NULL, 'V' },
 	{ },
 };
@@ -1521,8 +1521,6 @@ static int run_commandline(struct nl_sock *sock)
 		ret = tokenize_string(line, &argc, argv);
 		if (!ret)
 			ret = run_one_command(sock, argc, argv);
-		if (ret)
-			fprintf(stderr, "Error: %s\n", strerror(ret));
 		free(line);
 	}
 	return 0;
@@ -1531,23 +1529,25 @@ static int run_commandline(struct nl_sock *sock)
 int main(int argc, char **argv)
 {
 	int opt, ret;
-	struct nl_sock *sock = netlink_sock_alloc();
-
-	if (!sock) {
-		fprintf(stderr, "Unable to allocate netlink socket!");
-		return 1;
-	}
+	struct nl_sock *sock;
 
 	taskname = argv[0];
 
+	xlog_syslog(0);
+	xlog_stderr(1);
+
 	/* Parse the preliminary options */
-	while ((opt = getopt_long(argc, argv, "+hd:V", pre_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+hdsV", pre_options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
 			usage();
 			return 0;
 		case 'd':
-			debug_level = atoi(optarg);
+			xlog_config(D_ALL, 1);
+			break;
+		case 's':
+			xlog_syslog(1);
+			xlog_stderr(0);
 			break;
 		case 'V':
 			// FIXME: print_version();
@@ -1555,6 +1555,16 @@ int main(int argc, char **argv)
 		}
 	}
 
+	xlog_open(basename(argv[0]));
+
+	xlog(D_GENERAL, "nfsdctl started");
+
+	sock = netlink_sock_alloc();
+	if (!sock) {
+		xlog(L_ERROR, "Unable to allocate netlink socket!");
+		return 1;
+	}
+
 	if (optind > argc) {
 		usage();
 		return 1;
@@ -1566,5 +1576,6 @@ int main(int argc, char **argv)
 		ret = run_one_command(sock, argc - optind, &argv[optind]);
 
 	nl_socket_free(sock);
+	xlog(D_GENERAL, "nfsdctl exiting");
 	return ret;
 }

-- 
2.47.1


