Return-Path: <linux-nfs+bounces-18360-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EkPfH5PCc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18360-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:48:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2279C12
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C693010507
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3325524C;
	Fri, 23 Jan 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT46EE1u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB1254B03
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194128; cv=none; b=NLmsfYyY9OJuYxfYq5mquvTBVozkIK32maSR8w8auS1W96rshLHvtR3sWAcCy0t1nj+LkAufPlCn37Q0G3TMH9P6RaqgI+nUTJeYwZZjoVun5qTxteDgN87ERqfMT2b4CfpKvwU6bx2d6uVlsWNgrSGjXKgwFI9v7sG2YT47lwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194128; c=relaxed/simple;
	bh=SOK/v7mDo5XoRUQnmjXaewziwDevTcwNyik/tO7U/P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u5yKDJDMiLZccxUFq+Hakp2PDN6DNFuVr4y4jacwKXCS1nY36/VFHgi7VSiUIhXfXJ/2fvynTEPgM7f/TuX9gQwEBo/au7pdTr383YA0eidr21Hac6RdQGiQ+3Ff/HBxZ/nC3LRFziJiqyB68rJqHqQ8eq2mA5k4c3YVxG6jo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT46EE1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57827C4CEF1;
	Fri, 23 Jan 2026 18:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194128;
	bh=SOK/v7mDo5XoRUQnmjXaewziwDevTcwNyik/tO7U/P8=;
	h=From:Date:Subject:To:Cc:From;
	b=hT46EE1uPWQQ0ocAgSjo2GO42NcwrwcwQjM/Aa+uins51IsJ3p3erKqkrveUq19e8
	 6BIoLiqfWXI0JuHAjt/+zF2Dt4I+FwyijyJZkO8ty4xxmZfJVwkeupOI4tfeU1wY7R
	 8Il5Nxt03W9NpON78EY/PeX/veGgQf8DiPuKbfKB+USm+zE8W8flj82kEWYsBhznC7
	 aCt9FiTjeDXD0ige40/ZD+zb4JwXN27BsVRMfXpvj7a0qQ2Z9RBFcEMM/8hJ0Xcd1i
	 Fd1Grqb8QmQdGDZ/OyknYGoWf9ndYEDCJPGDESaNkz1dm1Oyyn6wC1FQOLNOhc0jsP
	 +YVX9FX4T2obA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 23 Jan 2026 13:48:38 -0500
Subject: [PATCH nfs-utils v2] nfsdctl: add support for min-threads
 parameter
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-minthreads-v2-1-9bfbae745845@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02NwQ6CMBBEf4Xs2ZpuUUg9+R+GAylb2IjF7CLRE
 P7dBi8eX2bmzQpKwqRwKVYQWlh5ShncoYAwtKknw11mcNZVFq03D07zINR2ampvK6JAXfQe8uA
 pFPm9y26QoprXzKNCk6OBdZ7ks98suBd+RnT/xgUNmtKGczwhlrWz1ztJovE4SQ/Ntm1fW7b9F
 LAAAAA=
X-Change-ID: 20260109-minthreads-7906eecedf99
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10190; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SOK/v7mDo5XoRUQnmjXaewziwDevTcwNyik/tO7U/P8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpc8KJurqMQvKMRP6CANCcZAi0mp0eb3qeXm2W6
 n+3vBNA5iuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXPCiQAKCRAADmhBGVaC
 FezZD/4q8K6djvCRj7uukjC3BF+LI+mQYvKLMT6wo4FNIhztmm4BLy+NR/P/2SVgnTFv+mzibT9
 7eg+U3r0NRRN4eu+czHUCj+YArXN8y+susScPqa2gKEIWMpNtvZa+JKGBxnY+AwcT8ZY/Kmw+q7
 RD4wn7xPkCszXtr2JmCp0aXTey7s+GJxlsnEcWjPXHWT3Ee7ZWgyJ2EVz4Ri+7B1Ea1R6v7ztUj
 2rau3hE6beg8oSpdHTokqFBAqd3bxgweXfY7BksveTDiWb8HbSc94kd6PXUl2fpUtPEcTp08TTm
 mlJR45aEfSpgRI0ukmhIUXtnTXhyJ+b6oU5pZOlSoMU2qBVoZfDsstABIZyAkR1d+kSv7GLvvA4
 p/iYZK0NoAeguCXjddyXNpoE/Ge+PGWJN5LNXmKaNgH3BTH6YCgAiYNaIMVJhPqpMAjbItufSmi
 tlUR4btUwUFN58O4HyBjCxHzdi5BkVSkLXAT82f66VWXhodpMiw3K8uOenwY9h7mwcTuhcPOPTr
 x3VH4gWYN23TVWMRgrUtjv1nbM164d/6L20viOh9q1N/AhcfhfWnfQyO9vmT6E2drcXn6bMfGX2
 YW//0ucKBHasn5D6Novt188t2r5grWoiucGIwbRkLskouvzXToWpilRKgz3p1HMbYbVM2k+8K78
 9/Rut/Ge+LE10mA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18360-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,configure.ac:url]
X-Rspamd-Queue-Id: B8F2279C12
X-Rspamd-Action: no action

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
This just has a couple of minor revisions to the earlier set. Steve,
does this look acceptable?
---
Changes in v2:
- properly handle getopt in threads_func()
- #ifdef out the --minthreads help text when compiled out
- Link to v1: https://lore.kernel.org/r/20260112-minthreads-v1-1-30c5f4113720@kernel.org
---
 configure.ac               |  3 ++-
 systemd/nfs.conf.man       |  3 ++-
 utils/nfsdctl/nfsdctl.8    | 20 +++++++++++++++++--
 utils/nfsdctl/nfsdctl.adoc | 13 ++++++++++++
 utils/nfsdctl/nfsdctl.c    | 49 ++++++++++++++++++++++++++++++++++++++++------
 5 files changed, 78 insertions(+), 10 deletions(-)

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
index e7a0e12495277d2e98a6c21c7cee29fe459f37cc..1e60b9ae6d9ec61ca243fc62623a1a4b9a3b45a7 100644
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
@@ -580,23 +590,49 @@ out:
 
 static void threads_usage(void)
 {
-	printf("Usage: %s threads [ pool0_count ] [ pool1_count ] ...\n", taskname);
+	printf("Usage: %s threads { --min-threads=X } [ pool0_count ] [ pool1_count ] ...\n", taskname);
+#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
+	printf("    --min-threads= set the minimum thread count per pool to value\n");
+#endif
 	printf("    pool0_count: thread count for pool0, etc...\n");
 	printf("Omit any arguments to show current thread counts.\n");
 }
 
+#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
+static const struct option threads_options[] = {
+	{ "help", no_argument, NULL, 'h' },
+	{ "min-threads", required_argument, NULL, 'm' },
+	{ },
+};
+#define THREADS_OPTSTRING "hm:"
+#else
+#define threads_options help_only_options
+#define THREADS_OPTSTRING "h"
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
+	while ((opt = getopt_long(argc, argv, THREADS_OPTSTRING, threads_options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
 			threads_usage();
 			return 0;
+#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
+		case 'm':
+			errno = 0;
+			minthreads = strtoul(optarg, NULL, 0);
+			if (minthreads == ULONG_MAX && errno != 0) {
+				fprintf(stderr, "Bad --min-threads value.");
+				return 1;
+			}
+			break;
+#endif
 		}
 	}
 
@@ -624,7 +660,7 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 			}
 		}
 	}
-	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL);
+	return threads_doit(sock, cmd, 0, 0, pools, pool_threads, NULL, minthreads);
 }
 
 /*
@@ -1578,7 +1614,7 @@ static void autostart_usage(void)
 
 static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	int *threads, grace, lease, idx, ret, opt, pools;
+	int *threads, grace, lease, idx, ret, opt, pools, minthreads;
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
 	char *scope, *pool_mode;
@@ -1659,9 +1695,10 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 
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


