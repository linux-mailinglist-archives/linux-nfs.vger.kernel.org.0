Return-Path: <linux-nfs+bounces-18714-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEzPMXV4g2mFmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18714-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:48:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF41EA86B
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A110C3008C0D
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85C313531;
	Wed,  4 Feb 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdKkkoaB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B94A33B97E
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223728; cv=none; b=ZATv/jnXzk62EFCyn9XanfnKh/nC38TIrwQBYp5aVVHozysgzP8f1XeDxbSxThvbO5nxgEyHRCjxVjL1U8MxGS8YBnTUkU2aeT3O2jE8y0T855Ynr9zZtLarB5C68IOBD9g+hWhnH7fLaKlpkUZF78+EB4NlHDHisex1gLxOJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223728; c=relaxed/simple;
	bh=IWa++nWlBsO8ZnSovrLgs4i5S2IaSaCSxEtp68oxyuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VsMRmaaUvjZaGbDQB+lqIIjChBuWCCbRA+lK3x7/K/doclzVyoqGQVGi6McYb+1ti+4mnX8P3X+h2o0Mv5vw/WVD1ITy3EL1zWmE/BQhy1BVaLuoKJ6CCLIVvFIYX89prSTNY1tpDjYbcXRpsjA+0p/7HCMms7xd1EC7/2GEB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdKkkoaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EA0C19425;
	Wed,  4 Feb 2026 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770223728;
	bh=IWa++nWlBsO8ZnSovrLgs4i5S2IaSaCSxEtp68oxyuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MdKkkoaB7CQUBuuWW3lvSCd30YP22198qnGjEWsof3qad45DODpeTnbAXPCO/ToLf
	 8x0Vmt5nF57WRDbKzmRBHqTzJY6+ic18HzhQbJ/Z3DBro76NtLPHG1rcStLgHK01yy
	 yQ4fbaCUEw2DZa8Y19KnHtQfFcesq8y6UnNuYufDgVTxOtXAi8N45+oRw9McAkuyqP
	 Uk8Rv/PaDIppi4MgBaklVOi/wSwCb92VDo2ENE/0rU3timuRmECDDT+gFsEWX1dIb1
	 W/1UHEECQ0X9X3YeohcwaMdthh4eY8CmrEG9e1yXyXeZvm/rlCCf9+A7/Eqh/hpgwk
	 aJyEPo4tUKOwQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Feb 2026 11:48:22 -0500
Subject: [PATCH nfs-utils v2 1/4] nfsdctl: unconditionally enable support
 for min-threads
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-minthreads-v2-1-a7eba34201e9@kernel.org>
References: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
In-Reply-To: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Ben Coddington <bcodding@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4645; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IWa++nWlBsO8ZnSovrLgs4i5S2IaSaCSxEtp68oxyuk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpg3ht3jSx1SaVbhW2L09L5RmzC76OA7G37hqlq
 vL07yYyd++JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYN4bQAKCRAADmhBGVaC
 FcpnD/9yZoLQH+ddtB03o8LYObB6RD0Gv25vTEbGT3LdBYoAJ6L2dI2YiJorLiWaY/juAqviG4v
 7yDm+Gk8Q1FxdOO88qjUbrkfHJAuy9tB+Opu2MA3ODF++qwUFtn66EYVb6FqvnpVKwUqXSuVy15
 1yeAHgOJIj2IAFdV/sikTuONPY3RXbpdOE5+TfFU5tV49Qw7XBdco6HuR/bA3KFtLcgYDkKmot7
 YczSVTd4CHDGE/+i0cg/Fh17+/UfyBrYaIzCsq/QDYU9qZN+29A4alsEsmx5YSYtyeUEsbSeguf
 7U0CJ9lxCE/3d1ss3OYJEQBg7Kxx72z1rcVlZr9ZVmDrA+UYUlnnk/cQjtEDDd8e+lveHoMijqo
 7MUrYgmSf2IYUm67R+u6vDe3Ih8LW+ekoEsfEZQj+HscapdgTEAfJuaG6dOgJGj1uwe+ecL+/Z9
 v+ibFNRsHpIF5Gi9lLHeLAQLy9Fcey3drorTPyQOvTc8OQ6iucVHw3sU1WQIhPhUe7/MnatNvzt
 zRWP2llBPwp2WmZ+VDvkAHuEhz6pSFHqRqeF4ULZIE0Ik2BH5NlM8AVSlwieVAwBJ45sfAw0dwu
 sfDYvbc/8+q4j82OVV/n1a6OqI5VGKSLo5hyaGtXNbYCNa13g+gmWoHTqOftxK4JakjfFt1w5QZ
 noqks69T7kIubWQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18714-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BF41EA86B
X-Rspamd-Action: no action

I originally had this depend on the system header, but if we maintain
our copy of nfsd_netlink.h in tree, then we can unconditionally compile
in support for the MIN_THREADS option.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac                 |  6 ++----
 utils/nfsdctl/nfsd_netlink.h |  2 ++
 utils/nfsdctl/nfsdctl.c      | 16 +---------------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5cc1e9186542c975abf200edbef30bc8f6ecb8ee..a65c7837b8cb72eaa2f3dbb89069599c074be4ec 100644
--- a/configure.ac
+++ b/configure.ac
@@ -262,12 +262,10 @@ AC_ARG_ENABLE(nfsdctl,
 		PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
 		PKG_CHECK_MODULES(LIBREADLINE, readline)
 		AC_CHECK_HEADERS(linux/nfsd_netlink.h)
-		AC_CHECK_DECLS([NFSD_A_SERVER_MIN_THREADS], , ,
-			       [#include <linux/nfsd_netlink.h>])
 
-		# ensure we have the pool-mode commands
+		# ensure we have the MIN_THREADS attribute
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
-				                   [[int foo = NFSD_CMD_POOL_MODE_GET;]])],
+				                   [[int foo = NFSD_A_SERVER_MIN_THREADS;]])],
 				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
 					      ["Use system's linux/nfsd_netlink.h"])])
 		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
diff --git a/utils/nfsdctl/nfsd_netlink.h b/utils/nfsdctl/nfsd_netlink.h
index 887cbd12b695f2398c96976ba2d70e68ee0d93c0..e9efbc9e63d83ed25fcd790b7a877c0023638f15 100644
--- a/utils/nfsdctl/nfsd_netlink.h
+++ b/utils/nfsdctl/nfsd_netlink.h
@@ -2,6 +2,7 @@
 /* Do not edit directly, auto-generated from: */
 /*	Documentation/netlink/specs/nfsd.yaml */
 /* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
 #ifndef _UAPI_LINUX_NFSD_NETLINK_H
 #define _UAPI_LINUX_NFSD_NETLINK_H
@@ -34,6 +35,7 @@ enum {
 	NFSD_A_SERVER_GRACETIME,
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
+	NFSD_A_SERVER_MIN_THREADS,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index c906a2c8ba6d357e182d341a30610e367e74c093..6b3c98009488d1687e7e751eaed6c4f1d9613d39 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -324,11 +324,9 @@ static void parse_threads_get(struct genlmsghdr *gnlh)
 		case NFSD_A_SERVER_THREADS:
 			pool_threads[i++] = nla_get_u32(attr);
 			break;
-#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
 		case NFSD_A_SERVER_MIN_THREADS:
 			printf("min-threads: %u\n", nla_get_u32(attr));
 			break;
-#endif
 		default:
 			break;
 		}
@@ -546,10 +544,8 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 			nla_put_u32(msg, NFSD_A_SERVER_LEASETIME, lease);
 		if (scope)
 			nla_put_string(msg, NFSD_A_SERVER_SCOPE, scope);
-#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
 		if (minthreads >= 0)
 			nla_put_u32(msg, NFSD_A_SERVER_MIN_THREADS, minthreads);
-#endif
 		for (i = 0; i < pool_count; ++i)
 			nla_put_u32(msg, NFSD_A_SERVER_THREADS, pool_threads[i]);
 	}
@@ -591,24 +587,16 @@ out:
 static void threads_usage(void)
 {
 	printf("Usage: %s threads { --min-threads=X } [ pool0_count ] [ pool1_count ] ...\n", taskname);
-#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
 	printf("    --min-threads= set the minimum thread count per pool to value\n");
-#endif
 	printf("    pool0_count: thread count for pool0, etc...\n");
 	printf("Omit any arguments to show current thread counts.\n");
 }
 
-#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
 static const struct option threads_options[] = {
 	{ "help", no_argument, NULL, 'h' },
 	{ "min-threads", required_argument, NULL, 'm' },
 	{ },
 };
-#define THREADS_OPTSTRING "hm:"
-#else
-#define threads_options help_only_options
-#define THREADS_OPTSTRING "h"
-#endif
 
 static int threads_func(struct nl_sock *sock, int argc, char **argv)
 {
@@ -618,12 +606,11 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 	int opt, pools = 0;
 
 	optind = 1;
-	while ((opt = getopt_long(argc, argv, THREADS_OPTSTRING, threads_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "hm:", threads_options, NULL)) != -1) {
 		switch (opt) {
 		case 'h':
 			threads_usage();
 			return 0;
-#if HAVE_DECL_NFSD_A_SERVER_MIN_THREADS
 		case 'm':
 			errno = 0;
 			minthreads = strtoul(optarg, NULL, 0);
@@ -632,7 +619,6 @@ static int threads_func(struct nl_sock *sock, int argc, char **argv)
 				return 1;
 			}
 			break;
-#endif
 		}
 	}
 

-- 
2.52.0


