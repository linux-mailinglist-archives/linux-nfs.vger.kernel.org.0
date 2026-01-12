Return-Path: <linux-nfs+bounces-17755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AEAD1455D
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 18:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FD7030F89BA
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA30E374161;
	Mon, 12 Jan 2026 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejKhFjLV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06887374184
	for <linux-nfs@vger.kernel.org>; Mon, 12 Jan 2026 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238046; cv=none; b=pMzT0lf7acoBnZ4FZyqxbvlz+qt5qsby3l6TTw7y5BEuMH0HNgrXYF55FYE5dmuLrWVQa1shVATWPO2IIkSXBPYwyl08C2XAnakls1J3+HJxM3/D47up1UXZ3XPlZjzs39R6B9TykMWobRbGw3Nk1T3GIxSt0A7xJkPiX50vBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238046; c=relaxed/simple;
	bh=ifYk9tmArHSUC/OJfspg5a36nJqod5WTaQoGFNoFXWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uGu6PeHmeZB7gfl6C9ciSSWWO/VKxd264Z8uWL63vSnkubU3JYhAfZ6biP4nwpPRs9eAeL0tptBK11siSzOFgQ5K0i8f6PGIYMNLV2P2Z9awYC4UImekWjcF/b5JRZG0dahVdAHpVtSRrnBUr5b/FZUuLJy8soYTLtbq2JM4TEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejKhFjLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4CCC19424;
	Mon, 12 Jan 2026 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768238044;
	bh=ifYk9tmArHSUC/OJfspg5a36nJqod5WTaQoGFNoFXWM=;
	h=From:Date:Subject:To:Cc:From;
	b=ejKhFjLVpI1Gim+DQyTkn5gH+yV5nEAScg5aS9IFkobkTYEYkiCo8qQizJQCc8ITY
	 OqBt/JtZOzTH3GJRwt3sgmifUmour45XtQAP1P1wf3GvxR4JY5FOZRd5QCIl2wdU8H
	 kdeukfLWta969caiquVo4z1piL46+00YQSqzVgXzRlDu6BzY6FGr+9Lte1eXCq8NaP
	 1oWv2FxJAmZj0GMckDBTq/nDCVrTjssloKRTnMxMaqpllG73zw6E0p5C8cczP33zE2
	 aJi745W/9tHNRs5CM1GqQzirnzrsjof+TbN4+b7py9py2392+nQa7pDpLYgYBC0TIB
	 RUe/tahwsV/lg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 12 Jan 2026 12:13:51 -0500
Subject: [PATCH] nfsdctl: add support for min-threads parameter
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-minthreads-v1-1-30c5f4113720@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQwNL3dzMvJKMotTElGJdc0sDs9TU5NSUNEtLJaCGgqLUtMwKsGHRsbW
 1ADj632BcAAAA
X-Change-ID: 20260109-minthreads-7906eecedf99
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10060; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ifYk9tmArHSUC/OJfspg5a36nJqod5WTaQoGFNoFXWM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpZSvbuKWZ+Z3DZLOz/+QdwfFibJamkhhlEg9Hg
 p/RIAVUlPiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWUr2wAKCRAADmhBGVaC
 FStEEACdTmgXAwG9+SJineb4PgXTXDI1xWjjGA7v4CqnlZHXCNoH/UvBM/QUR8THQaLP1utLJB/
 DQX6An6bmo5mRFA1ZJi+Y9v3NsiENHwiJA56jM8nKm816hNLAwgohsd9dZU3XWm3upIPwk52xF+
 kJ839d3DggdtTXZprixxqiV7vZfz7xuiBs0YGcdrlnDa0hQ5xjoD8G/OV+iLiwoXOfcO8VvOCbh
 IgIe9xi8+Uv2oEh6J7mZHqSRKPrWHZldkF4hNCRvI5JK79vyqSbOZpSgpFKZQABJnmAk4FtUzNT
 bqn0VxKZhiqTVY4gfsg0tHJdvwOgz2NUsz2d2nDnh380eqwGgOponUgluFfL5md6CFW4DiQDQE1
 ARngsEmXez0ySRyaYLsIFDag62aOtJIrr5rAXiTryyRZ+4DzuuRhMxHuMB113wUC6rP2u54Ouq6
 UhAXibUCdN2pOw/Q8Jc+QjDqs/MbuUSiCaRscvhPrIAj+HP1bG4BM75eZjB39anB8dd3/ge1Zr7
 w+B7E6yfHfDTwQq3PH2Ux782pYb3DJuEW7IRBToeLs29XhOy8wkRghGj06FW3QaBIMg4cC+0YLT
 3msOjSAjoRTGFZ6Fcat7DJ9AuaclxKjs6WcuM2EYv5cpym22M1Tl43tSmStFqYXstxlPWWb4O3c
 AENFoJU+1D06+ug==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patch adds proper support to nfsdctl to manage nfsd's new dynamic
threading when NFSD_A_SERVER_MIN_THREADS is defined in the header:

If the user sets min-threads, and has a new enough kernel, the
traditional threads parameters will represent the max number of threads.
The min-threads value represents the minimum number of threads to run in
each pool. The kernel will start the minimum number of threads at
startup time, and the thread count will dynamically fluctuate between
the min and max based on load.

Allow the "autostart" subcommand to find the "min-threads" parameter in
nfs.conf and set it in the netlink call appropriately. If it's not set,
then assume that it's 0, which will disable dynamic threading.

For the "threads" subcommand, add a new command-line option. If it's not
set, then don't send it in the netlink command at all. That allows the
kernel's existing setting to remain as-is, unless explicitly changed.

Also, update the documentation with info about min-threads.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Consider this a starting point for discussion. The userland interface
can be different from the kernel's min-threads interface.

One alternative idea:

We could just expose dynamic threading in the config file and
command-line interface as a bool. If enabled, we'd set min-threads to 1.
If disabled, set it to 0.

I guess we could also do both as well...
---
 configure.ac               |  3 ++-
 systemd/nfs.conf.man       |  3 ++-
 utils/nfsdctl/nfsdctl.8    | 20 ++++++++++++++++++--
 utils/nfsdctl/nfsdctl.adoc | 13 +++++++++++++
 utils/nfsdctl/nfsdctl.c    | 43 +++++++++++++++++++++++++++++++++++++------
 5 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6da23915836d34ff4d9bdef79af13499990688f9..33866e869666d8ebdebc8d7b5b08bf6ffbe92aa2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -262,6 +262,8 @@ AC_ARG_ENABLE(nfsdctl,
 		PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
 		PKG_CHECK_MODULES(LIBREADLINE, readline)
 		AC_CHECK_HEADERS(linux/nfsd_netlink.h)
+		AC_CHECK_DECLS([NFSD_A_SERVER_MIN_THREADS], , ,
+			       [#include <linux/nfsd_netlink.h>])
 
 		# ensure we have the pool-mode commands
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
@@ -620,7 +622,6 @@ AC_CHECK_SIZEOF(socklen_t,, [AC_INCLUDES_DEFAULT
                              # include <sys/socket.h>
                              #endif])
 
-
 dnl *************************************************************
 dnl Export some path names to config.h
 dnl *************************************************************
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index e6a84a9725da5a3cc40611f45d343a670fdb94ca..484de2c086db91ede38490e49411e1514a5da754 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -162,6 +162,7 @@ option.
 .B nfsd
 Recognized values:
 .BR threads ,
+.BR min-threads ,
 .BR host ,
 .BR scope ,
 .BR port ,
@@ -179,7 +180,7 @@ Recognized values:
 Version and protocol values are Boolean values as described above,
 and are also used by
 .BR rpc.mountd .
-Threads and the two times are integers.
+Threads, min-threads and the two times are integers.
 .B port
 and
 .B rdma
diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
index d69922448eb17fb155f05dc4ddc9aefffbf966e4..a86ffe8e1f4d39ef7041ac0f6867792466c40af0 100644
--- a/utils/nfsdctl/nfsdctl.8
+++ b/utils/nfsdctl/nfsdctl.8
@@ -2,12 +2,12 @@
 .\"     Title: nfsdctl
 .\"    Author: Jeff Layton
 .\" Generator: Asciidoctor 2.0.20
-.\"      Date: 2025-01-09
+.\"      Date: 2026-01-12
 .\"    Manual: \ \&
 .\"    Source: \ \&
 .\"  Language: English
 .\"
-.TH "NFSDCTL" "8" "2025-01-09" "\ \&" "\ \&"
+.TH "NFSDCTL" "8" "2026-01-12" "\ \&" "\ \&"
 .ie \n(.g .ds Aq \(aq
 .el       .ds Aq '
 .ss \n[.ss] 0
@@ -147,6 +147,22 @@ value of 0 will shut down the NFS server. Run this without arguments to
 get the current number of running threads in each pool.
 .RE
 .sp
+.if n .RS 4
+.nf
+.fam C
+These options are specific to the "threads" subcommand:
+
+\-m, \-\-min\-threads=
+    If set to a positive, non\-zero value, then dynamic threading is enabled for
+    nfsd.  In this mode, the traditional "threads" values are treated as a maximum
+    number of threads. This specifies the minimum number of threads per pool. The
+    kernel will start the minimum number and dynamically start and stop threads as
+    needed. If the minimum is larger than the maximum, then dynamic threadis is
+    disabled, and the maximum number is started.
+.fam
+.fi
+.if n .RE
+.sp
 \fBversion\fP
 .RS 4
 Get/set the enabled NFS versions for the server. Run without arguments to
diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
index 0207eff6118d2dcc5a794d2013c039d9beb11ddc..e85348e29ed815470d35b6365a212d8872cf645c 100644
--- a/utils/nfsdctl/nfsdctl.adoc
+++ b/utils/nfsdctl/nfsdctl.adoc
@@ -84,6 +84,19 @@ Each subcommand can also accept its own set of options and arguments. The
   value of 0 will shut down the NFS server. Run this without arguments to
   get the current number of running threads in each pool.
 
+[source,bash]
+----
+These options are specific to the "threads" subcommand:
+
+-m, --min-threads=
+    If set to a positive, non-zero value, then dynamic threading is enabled for
+    nfsd.  In this mode, the traditional "threads" values are treated as a maximum
+    number of threads. This specifies the minimum number of threads per pool. The
+    kernel will start the minimum number and dynamically start and stop threads as
+    needed. If the minimum is larger than the maximum, then dynamic threadis is
+    disabled, and the maximum number is started.
+----
+
 *version*::
 
   Get/set the enabled NFS versions for the server. Run without arguments to
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index e7a0e12495277d2e98a6c21c7cee29fe459f37cc..67cf27b04ca39e42459bc8188e5ae527166a74d1 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -19,6 +19,7 @@
 #include <string.h>
 #include <sched.h>
 #include <sys/queue.h>
+#include <limits.h>
 
 #include <netlink/genl/family.h>
 #include <netlink/genl/ctrl.h>
@@ -323,6 +324,11 @@ static void parse_threads_get(struct genlmsghdr *gnlh)
 		case NFSD_A_SERVER_THREADS:
 			pool_threads[i++] = nla_get_u32(attr);
 			break;
+#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
+		case NFSD_A_SERVER_MIN_THREADS:
+			printf("min-threads: %u\n", nla_get_u32(attr));
+			break;
+#endif
 		default:
 			break;
 		}
@@ -518,7 +524,7 @@ out:
 }
 
 static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
-			int pool_count, int *pool_threads, char *scope)
+			int pool_count, int *pool_threads, char *scope, int minthreads)
 {
 	struct genlmsghdr *ghdr;
 	struct nlmsghdr *nlh;
@@ -540,6 +546,10 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 			nla_put_u32(msg, NFSD_A_SERVER_LEASETIME, lease);
 		if (scope)
 			nla_put_string(msg, NFSD_A_SERVER_SCOPE, scope);
+#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
+		if (minthreads >= 0)
+			nla_put_u32(msg, NFSD_A_SERVER_MIN_THREADS, minthreads);
+#endif
 		for (i = 0; i < pool_count; ++i)
 			nla_put_u32(msg, NFSD_A_SERVER_THREADS, pool_threads[i]);
 	}
@@ -580,23 +590,43 @@ out:
 
 static void threads_usage(void)
 {
-	printf("Usage: %s threads [ pool0_count ] [ pool1_count ] ...\n", taskname);
+	printf("Usage: %s threads { --min-threads=X } [ pool0_count ] [ pool1_count ] ...\n", taskname);
+	printf("    --min-threads= set the minimum thread count per pool to value\n");
 	printf("    pool0_count: thread count for pool0, etc...\n");
 	printf("Omit any arguments to show current thread counts.\n");
 }
 
+#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
+static const struct option threads_options[] = {
+	{ "help", no_argument, NULL, 'h' },
+	{ "min-threads", required_argument, NULL, 'm' },
+	{ },
+};
+#else
+#define threads_options help_only_options
+#endif
+
 static int threads_func(struct nl_sock *sock, int argc, char **argv)
 {
 	uint8_t cmd = NFSD_CMD_THREADS_GET;
 	int *pool_threads = NULL;
+	int minthreads = -1;
 	int opt, pools = 0;
 
 	optind = 1;
-	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "h", threads_options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
 			threads_usage();
 			return 0;
+		case 'm':
+			errno = 0;
+			minthreads = strtoul(optarg, NULL, 0);
+			if (minthreads == ULONG_MAX && errno != 0) {
+				fprintf(stderr, "Bad --min-threads value.");
+				return 1;
+			}
+			break;
 		}
 	}
 
@@ -624,7 +654,7 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			}
 		}
 	}
-	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL);
+	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
 }
 
 /*
@@ -1578,7 +1608,7 @@ static void autostart_usage(void)
 
 static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	int *threads, grace, lease, idx, ret, opt, pools;
+	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
 	char *scope, *pool_mode;
@@ -1659,9 +1689,10 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 
 	lease = conf_get_num("nfsd", "lease-time", 0);
 	scope = conf_get_str("nfsd", "scope");
+	minthreads = conf_get_num("nfsd", "min-threads", 0);
 
 	ret = threads_doit(sock, NFSD_CMD_THREADS_SET, grace, lease, pools,
-			   threads, scope);
+			   threads, scope, minthreads);
 out:
 	free(threads);
 	return ret;

---
base-commit: 0e71be58cdead21b7bc0285fa6afbf1d0eca3049
change-id: 20260109-minthreads-7906eecedf99

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


