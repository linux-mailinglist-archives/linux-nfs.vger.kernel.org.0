Return-Path: <linux-nfs+bounces-20520-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKK3Cxx9ymlo9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20520-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1E35C229
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82E1730168AF
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AE93D5658;
	Mon, 30 Mar 2026 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWoyhgQR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5C3D5226
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877928; cv=none; b=BqKfL0S8QdHyMucdKAt9FC8uhaP3q5DnMG54PiLhWraU2hMuSv/lf2PnU5YSyNEPm9u8UP64Vx58JSLJWMhR750Zj1i5UPW5G/WgCdCVIY3HMrbMKCuXs7BYxxirYK3HiFicJjMEuWhOkqOhYuhj1q18H75GYbSQP2BKmbrPZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877928; c=relaxed/simple;
	bh=pjn2Wvw0p+KSAF1ftPn1Oao4MmF9HDDtKVjj3bIleWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+GaCDdQH9UmBTS5B0qSVY6NkPeDdUegtKD2vBkDvqJuUbcXR2Dz3xdUTKVUEXfySB3CqdGRaa8BF5M+cFefCtbURDJJu8rpRhJAcCcgQzkckqEsmD4BZXg5P5HE3AUR3tsy7xOXxtzDJmS7arnCPx2k5dFzgEyVPwtqFDp68eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWoyhgQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F60C2BCB3;
	Mon, 30 Mar 2026 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877928;
	bh=pjn2Wvw0p+KSAF1ftPn1Oao4MmF9HDDtKVjj3bIleWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aWoyhgQRAdNo0RhKM3MkfHdXLglxhFt/KPLNLMDW5BClJEe0uRFmMj7Cx1bQk9XIj
	 kw6cXUZdc4ojfwinp025hess1MiVEc/x4HeMQeB6VPFq2x24vJD+nYEiaAbdf9aDnP
	 EtH6BU9QS2HG+l/sdKlbR4DPAlGUX5XwqMKcukIRVS4sMJ2VqYwYR1xN7QfGOpmqp2
	 AeRSSbw92+sf7zrsw+NvhwYaxGNRPFdZKo2c5M471QVwInkq4WJ5BBPzyhB/9tifOo
	 /voRsQjTt39+syIqL5tt7A49riNYV1rLcMnRVG/xGPtQlaqtpM1boYJeAtZOjK5pms
	 3QtdpslZJno0g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:25 -0400
Subject: [PATCH nfs-utils v2 05/16] build: add libnl3 and netlink header
 support for exportd and mountd
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-5-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4803; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pjn2Wvw0p+KSAF1ftPn1Oao4MmF9HDDtKVjj3bIleWI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzeFgK3sgAgCYHXApKkPp6lvgE+EKOm3omuj
 Oj3Uki87DGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp83gAKCRAADmhBGVaC
 FVmBD/47utFy2VB2nsPpHtHgDzTYeVViK/m2W6dqijULamJ6Cg6wLe8i/zTS0kFQG3p+kVALHmR
 rsWSfbygOMkEhPaogvsxIwkHSWgk/UO/8rMKF4z3XXKkLiivuXyCq5kp8rNc4WcC0wr621as2HJ
 evnHFc4anxcXSaF8vn0H16SQsYVDt84nMBkJ8HleE8IwMFxzPJnmy5XD8jIWyEF1cY67uRvND40
 pwB2KtUzPDtLQwkzfmIuBsKZfsSjOixcE68rW9YcXYwXmsI1036SpqXH1lJMxxKR0aGGbDQyDib
 FQ2UBV35fpquaO5DxC/12kkubRKBsw3S84DCFvSxyCx2RsI++HiCGeLkHv098iAACc57QjnQ9Tt
 VM+jOvtJuGe5godYrJyxZYi36q4YaQU878Cd1WXoga4FyTAZuWHYd/r6+0DygvuCbQAsIo9C5Vh
 E5JOIow6271e/eg/e9/m4kOeFMbUHDH0YBsFfgmXXCrV+4KLF7UoFuUYeZ+OewvzyIeBdYznUGd
 ZEU5KwaH//PJkBYW8tV+j5Ox0B3t7JdZVbz6htDXsxb+dprDETyPiiORrKZQS3Tr4EoDCvYVNXw
 jC4pRSmaDIM3CjkZ5f0ZfrgfL4SjftqHKejt93wOEYcQAB3rwFtNqvEYXIUKdHKH2ZBtnT+rZqU
 9xgpJEwU/VybGNQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20520-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFC1E35C229
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add libnl3 dependency and netlink header detection for exportd and
mountd builds. Update the nfsd_netlink.h sentinel to check for
NFSD_A_EXPKEY_SEQNO to ensure the system header includes expkey
support. Add AC_COMPILE_IFELSE check for sunrpc_netlink.h using
SUNRPC_CMD_CACHE_NOTIFY as sentinel.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac               | 33 +++++++++++++++++++--------------
 support/export/Makefile.am |  3 ++-
 utils/exportd/Makefile.am  |  2 +-
 utils/mountd/Makefile.am   |  2 +-
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8771971fe6f8910ec9e7a6ec318563ae2e7457e3..a43e924420f6474073d517c827b38b7a7674ad16 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,27 +252,32 @@ AC_ARG_ENABLE(nfsdcltrack,
 	enable_nfsdcltrack=$enableval,
 	enable_nfsdcltrack="no")
 
+PKG_CHECK_MODULES(LIBNL3, libnl-3.0 >= 3.1)
+PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
+
+AC_CHECK_HEADERS(linux/nfsd_netlink.h)
+
+# ensure we have the expkey attributes
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
+			                   [[int foo = NFSD_A_EXPKEY_SEQNO;]])],
+			   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
+				      ["Use system's linux/nfsd_netlink.h"])])
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
+			                   [[int foo = LOCKD_CMD_SERVER_GET;]])],
+			   [AC_DEFINE([USE_SYSTEM_LOCKD_NETLINK_H], 1,
+				      ["Use system's linux/lockd_netlink.h"])])
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/sunrpc_netlink.h>]],
+			                   [[int foo = SUNRPC_CMD_CACHE_NOTIFY;]])],
+			   [AC_DEFINE([USE_SYSTEM_SUNRPC_NETLINK_H], 1,
+				      ["Use system's linux/sunrpc_netlink.h"])])
+
 AC_ARG_ENABLE(nfsdctl,
 	[AS_HELP_STRING([--disable-nfsdctl],[disable nfsdctl program for controlling nfsd@<:@default=no@:>@])],
 	enable_nfsdctl=$enableval,
 	enable_nfsdctl="yes")
 	AM_CONDITIONAL(CONFIG_NFSDCTL, [test "$enable_nfsdctl" = "yes" ])
 	if test "$enable_nfsdctl" = yes; then
-		PKG_CHECK_MODULES(LIBNL3, libnl-3.0 >= 3.1)
-		PKG_CHECK_MODULES(LIBNLGENL3, libnl-genl-3.0 >= 3.1)
 		PKG_CHECK_MODULES(LIBREADLINE, readline)
-		AC_CHECK_HEADERS(linux/nfsd_netlink.h)
-
-		# ensure we have the MIN_THREADS attribute
-		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/nfsd_netlink.h>]],
-								   [[int foo = NFSD_A_SERVER_MIN_THREADS;
-								     int bar = NFSD_A_SERVER_FH_KEY;]])],
-				   [AC_DEFINE([USE_SYSTEM_NFSD_NETLINK_H], 1,
-					      ["Use system's linux/nfsd_netlink.h"])])
-		AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <linux/lockd_netlink.h>]],
-				                   [[int foo = LOCKD_CMD_SERVER_GET;]])],
-				   [AC_DEFINE([USE_SYSTEM_LOCKD_NETLINK_H], 1,
-					      ["Use system's linux/lockd_netlink.h"])])
 	fi
 
 AC_ARG_ENABLE(nfsv4server,
diff --git a/support/export/Makefile.am b/support/export/Makefile.am
index 7338e1c7e719b2684745e0d71810c9f52d08a3c9..ae7ace44112b889f1c461c5473fb1bd42a42f182 100644
--- a/support/export/Makefile.am
+++ b/support/export/Makefile.am
@@ -14,7 +14,8 @@ libexport_a_SOURCES = client.c export.c hostname.c \
 		      xtab.c mount_clnt.c mount_xdr.c \
 		      cache.c auth.c v4root.c fsloc.c \
 		      v4clients.c
-libexport_a_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport
+libexport_a_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) -I$(top_srcdir)/support/reexport \
+		       $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS)
 
 BUILT_SOURCES 	= $(GENFILES)
 
diff --git a/utils/exportd/Makefile.am b/utils/exportd/Makefile.am
index 26078c9b11b54d2af7bce0273f1cac577f0d8097..e25166b1aa1871492d11a83decd63e76a1528f9b 100644
--- a/utils/exportd/Makefile.am
+++ b/utils/exportd/Makefile.am
@@ -18,7 +18,7 @@ exportd_LDADD = ../../support/export/libexport.a \
 			../../support/misc/libmisc.a \
 			../../support/reexport/libreexport.a \
 			$(OPTLIBS) $(LIBBLKID) $(LIBPTHREAD) \
-			-luuid
+			-luuid $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS)
 
 exportd_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) \
 		-I$(top_srcdir)/support/export
diff --git a/utils/mountd/Makefile.am b/utils/mountd/Makefile.am
index 197ef29b4fe4a855da3b26c701fa0b41916ea59c..808baf318fe54ccee13cf60b4cd71ade0444508b 100644
--- a/utils/mountd/Makefile.am
+++ b/utils/mountd/Makefile.am
@@ -20,7 +20,7 @@ mountd_LDADD = ../../support/export/libexport.a \
 	       ../../support/reexport/libreexport.a \
 	       $(OPTLIBS) \
 	       $(LIBBSD) $(LIBWRAP) $(LIBNSL) $(LIBBLKID) -luuid $(LIBTIRPC) \
-	       $(LIBPTHREAD)
+	       $(LIBPTHREAD) $(LIBNL3_LIBS) $(LIBNLGENL3_LIBS)
 
 mountd_CPPFLAGS = $(AM_CPPFLAGS) $(CPPFLAGS) \
 		  -I$(top_builddir)/support/include \

-- 
2.53.0


