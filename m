Return-Path: <linux-nfs+bounces-9035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43299A080A7
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 20:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B244C7A3A22
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A21AF0B6;
	Thu,  9 Jan 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHLjGHkI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2171ACEC6
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451611; cv=none; b=LAgTOtvozQ2lSTlA1QXVbeBO4pZzsTzhl1Fk5JyBqZJhYSI4o3Ms+v8VhTMYk+xi9NLt7X7ox8FcIrXP5WhGv9emd1PdyxsBeilivZy+BPrWSaHfmZysw+FfEWdP9ZMq/u/jb9r+zRmetm4dMAcXX2Mg0UwzzT1dR41RpAusJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451611; c=relaxed/simple;
	bh=LzRXeeOoATYtjz10FZpp8TxMm2bzHoYe5Y7uw8Fy/zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eDh0x8SM+2bHE3rhfC+6lyvRYFhqLDYODAmqoTyeg5redsMJscgmULV93HQ0NJhfgIU3CMF6JfyrEkyUOR7+Hczm/CmA1mXgxAY3s2uIJtMJEJH/K7drYFKLI1TtQ9k4uQPyoDX4xN5yDyndurb/lf2xO7jWV83XLh7oS4G9tPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHLjGHkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760DEC4CEE2;
	Thu,  9 Jan 2025 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736451610;
	bh=LzRXeeOoATYtjz10FZpp8TxMm2bzHoYe5Y7uw8Fy/zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lHLjGHkI99OK2HOYKQ9TX94L5vXKZH5W0Ze0qtpL6qRIh6Xmz0DMpg62B7E6rVf7/
	 rdcteaj+jZzTnwMD4J4m++XfSveWOUg0EC0/jpaO35jdSoVAZ8bll8IC5Fhs2OhWk0
	 X7yMea+3sJYkGEXDGvqL5KMkCK0DxaT/W91hGO5h6/OwMGoR0pd23srrnZOlvlJkAM
	 11fkerzwFOySFlPgghgMSxLRFrchXKkWVrVxjLg7KrckHoi7SM0Bo+3uiaecGa1GyP
	 dYgnOneMJpTjqNwP8oZ3d47IJaK8DGldkc2pJyWbHanxz07xCWRUQP/zLO0/VxCAO7
	 NBMQEzw6gg8IQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jan 2025 14:40:04 -0500
Subject: [PATCH 1/3] nfsdctl: convert to xlog()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-lockd-nl-v1-1-108548ab0b6b@kernel.org>
References: <20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org>
In-Reply-To: <20250109-lockd-nl-v1-0-108548ab0b6b@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Scott Mayhew <smayhew@redhat.com>, Yongcheng Yang <yoyang@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12475; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LzRXeeOoATYtjz10FZpp8TxMm2bzHoYe5Y7uw8Fy/zw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBngCYZRsFhsimZG0uqFRenwfU8knuEHI9ZF7Qpl
 kh/ssi28uGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ4AmGQAKCRAADmhBGVaC
 FbFZD/9WQpmrn5VPbz2TyNlNNoSQnynusjamb0k/50fo6EJ0fk0m62cMwj86FyHPJZ3bSLI5GA0
 0xARiNR4ebN3kPZ8cWuqeS+IKX7wrjruLeY6/YPfBmlylRacy6l2ijax3Q3xd6tiOAY7uqtxQB2
 ynDQOm3sm49QRw7rl1eSAma7NW8HpC/ZJ6Wj015d5goK93+geXok2jQ7b7olTGyNuGGT6GiCHvA
 BacfKIg2stjMkNn8yT7oYJz0cqNI9bx6tONu5kj6syRc7CUGh2s3EwbosOTSomuelx4gFEZiCOY
 sFaKWNibI9anbMFAZREAk502kCemom3cdAXaq6rJXpHC/flHF6kRBbjp5IxI9amEH7AhAk0S7Nt
 wupGbiia2hcO6zTCgsaabw/fwLVZrsVxq0o6/gtSW0JIhddPXkVPleICxofpgJ93rbXM3JI5rC3
 gB8WlaUWbuxd7SJvAW4hm7FU/BQP4tWE9B7SW/Nk4aa44WenmFWl8Y4uaaQAnjcFookuNCZNPEl
 uUgHhumBVphIo9xTeURDR3xHkHWle0IXcKwJTkWCfpOkjDw3RBjzeXPlxjPG9AEzpMEph6p2fEl
 nf/Wn+w/3prtWxUBjBeG6/difq6j18kLOB+emldGj6CdnCz8+isvmyHePRrlDHR7GzezdostGlM
 CbuVMnXKZ61e1ew==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert all of the fprintf(stderr, ...) calls to xlog(L_ERROR, ...)
calls.  Change the -d option to not take an argument, and add a -s
option that will make nfsdctl log to syslog instead of stderr.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.adoc |   3 ++
 utils/nfsdctl/nfsdctl.c    | 103 ++++++++++++++++++++++++---------------------
 2 files changed, 59 insertions(+), 47 deletions(-)

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
index b138f06d8b5504e4bf0362041ba36a68aeb12508..11fa4363907a0897ddf79f21916f9e25b9e88dbb 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -45,8 +45,6 @@
  * gcc -I/usr/include/libnl3/ -o <prog-name> <prog-name>.c -lnl-3 -lnl-genl-3
  */
 
-static int debug_level;
-
 struct nfs_version {
 	uint8_t	major;
 	uint8_t	minor;
@@ -390,7 +388,7 @@ static struct nl_sock *netlink_sock_alloc(void)
 		return NULL;
 
 	if (genl_connect(sock)) {
-		fprintf(stderr, "Failed to connect to generic netlink\n");
+		xlog(L_ERROR, "Failed to connect to generic netlink");
 		nl_socket_free(sock);
 		return NULL;
 	}
@@ -409,18 +407,18 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock)
 
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
@@ -462,7 +460,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
 
 	cb = nl_cb_alloc(NL_CB_CUSTOM);
 	if (!cb) {
-		fprintf(stderr, "failed to allocate netlink callbacks\n");
+		xlog(L_ERROR, "failed to allocate netlink callbacks");
 		ret = 1;
 		goto out;
 	}
@@ -480,7 +478,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -521,14 +519,14 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 
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
 
@@ -541,7 +539,7 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -586,13 +584,13 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 
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
@@ -621,14 +619,14 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 
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
 
@@ -641,7 +639,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -690,7 +688,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
 
 		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_PROTO_VERSION);
 		if (!a) {
-			fprintf(stderr, "Unable to allocate version nest!\n");
+			xlog(L_ERROR, "Unable to allocate version nest!");
 			ret = 1;
 			goto out;
 		}
@@ -707,14 +705,14 @@ static int set_nfsd_versions(struct nl_sock *sock)
 
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
 
@@ -727,7 +725,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -752,7 +750,7 @@ static int update_nfsd_version(int major, int minor, bool enabled)
 	/* the kernel doesn't support this version */
 	if (!enabled)
 		return 0;
-	fprintf(stderr, "This kernel does not support NFS version %d.%d\n", major, minor);
+	xlog(L_ERROR, "This kernel does not support NFS version %d.%d", major, minor);
 	return -EINVAL;
 }
 
@@ -794,7 +792,7 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
 
 			ret = sscanf(str, "%c%d.%d\n", &sign, &major, &minor);
 			if (ret < 2) {
-				fprintf(stderr, "Invalid version string (%d) %s\n", ret, str);
+				xlog(L_ERROR, "Invalid version string (%d) %s", ret, str);
 				return -EINVAL;
 			}
 
@@ -806,7 +804,7 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
 				enabled = false;
 				break;
 			default:
-				fprintf(stderr, "Invalid version string %s\n", str);
+				xlog(L_ERROR, "Invalid version string %s", str);
 				return -EINVAL;
 			}
 
@@ -839,14 +837,14 @@ static int fetch_current_listeners(struct nl_sock *sock)
 
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
 
@@ -859,7 +857,7 @@ static int fetch_current_listeners(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -994,7 +992,7 @@ static int update_listeners(const char *str)
 	 */
 	ret = getaddrinfo(addr, port, &hints, &res);
 	if (ret) {
-		fprintf(stderr, "getaddrinfo of \"%s\" failed: %s\n",
+		xlog(L_ERROR, "getaddrinfo of \"%s\" failed: %s",
 			addr, gai_strerror(ret));
 		return -EINVAL;
 	}
@@ -1046,7 +1044,7 @@ static int update_listeners(const char *str)
 	}
 	return 0;
 out_inval:
-	fprintf(stderr, "Invalid listener update string: %s", str);
+	xlog(L_ERROR, "Invalid listener update string: %s", str);
 	return -EINVAL;
 }
 
@@ -1076,7 +1074,7 @@ static int set_listeners(struct nl_sock *sock)
 
 		a = nla_nest_start(msg, NLA_F_NESTED | NFSD_A_SERVER_SOCK_ADDR);
 		if (!a) {
-			fprintf(stderr, "Unable to allocate listener nest!\n");
+			xlog(L_ERROR, "Unable to allocate listener nest!");
 			ret = 1;
 			goto out;
 		}
@@ -1091,14 +1089,14 @@ static int set_listeners(struct nl_sock *sock)
 
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
 
@@ -1111,7 +1109,7 @@ static int set_listeners(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -1188,14 +1186,14 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 
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
 
@@ -1208,7 +1206,7 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		fprintf(stderr, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "Error: %s", strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -1245,7 +1243,7 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
 
 		/* empty string? */
 		if (*targv[0] == '\0') {
-			fprintf(stderr, "Invalid threads value %s.\n", targv[0]);
+			xlog(L_ERROR, "Invalid threads value %s.", targv[0]);
 			return 1;
 		}
 		pool_mode = targv[0];
@@ -1397,7 +1395,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 
 			threads[idx++] = strtol(n->field, &endptr, 0);
 			if (!endptr || *endptr != '\0') {
-				fprintf(stderr, "Invalid threads value %s.\n", n->field);
+				xlog(L_ERROR, "Invalid threads value %s.", n->field);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -1470,7 +1468,8 @@ static void usage(void)
 /* Options given before the command string */
 static const struct option pre_options[] = {
 	{ "help", no_argument, NULL, 'h' },
-	{ "debug", required_argument, NULL, 'd' },
+	{ "debug", no_argument, NULL, 'd' },
+	{ "syslog", no_argument, NULL, 's' },
 	{ "version", no_argument, NULL, 'V' },
 	{ },
 };
@@ -1524,7 +1523,7 @@ static int run_commandline(struct nl_sock *sock)
 		if (!ret)
 			ret = run_one_command(sock, argc, argv);
 		if (ret)
-			fprintf(stderr, "Error: %s\n", strerror(ret));
+			xlog(L_ERROR, "Error: %s", strerror(ret));
 		free(line);
 	}
 	return 0;
@@ -1533,23 +1532,25 @@ static int run_commandline(struct nl_sock *sock)
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
@@ -1557,6 +1558,14 @@ int main(int argc, char **argv)
 		}
 	}
 
+	xlog_open(basename(argv[0]));
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

-- 
2.47.1


