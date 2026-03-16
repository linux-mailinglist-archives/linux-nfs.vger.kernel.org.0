Return-Path: <linux-nfs+bounces-20204-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHrlAE4huGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20204-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:27:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 609BF29C4E0
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D10131476C6
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06973A6413;
	Mon, 16 Mar 2026 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO5SfOW7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F33A640A
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674218; cv=none; b=Ec4Cn0j+pJT1a+V4F01Xhn5h1+U/hqlZEiDtc9u3jKUzTlAZJTee1ldkyakb66EdyfwCe+STgnaKwNWX4hbVbeHaL9zdsNGsFBEKEaVa7XG5aJTmfbWnfHbCxVFnx2yGKnWPM3KqbECzVTzc5OXBv/GhRb84O9OZhQlxBytBqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674218; c=relaxed/simple;
	bh=JvbeddlOm0xcRydnLMdh41j9nnPNMQAY2tLLE0K/e3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JEfUK8haR6uUcHim7UAxN4mw8BldYHd44SNCa9upXazN5ZmQklT0fs+C1YF7foKTH5+VKr92Xj1oIiF2XsprwZb9ddfgsqHCSTjG2W2iLYjWeoXixqbvHwmdodLCVMrDa9ZTZFr3mIYSALfn2Wju7UF+Z97QMBver3gWZCJJa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO5SfOW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB40C19421;
	Mon, 16 Mar 2026 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674218;
	bh=JvbeddlOm0xcRydnLMdh41j9nnPNMQAY2tLLE0K/e3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WO5SfOW7E6x3Vo2+teqbX39aDHRJffV7X4Eb8UVM7UwUOQXBqh2EZ0/fuoXczdmF3
	 fP0MMQvIqAFTYXl9hVr4eWsN11EhI7sV/4igRwmUGttcgp6SjZ9F/kB8W5E3AAyhxd
	 Ixz4g1xDGJgNiZPwcQV3pHWrliKUPXJcOp9vvh5+8Gvw+RDSkc+3O0jlpveeaRChnQ
	 xIMISzwxkEeoOVlAQpJ24ZSGsL0LGE1RmkzhpuTjVl1WWMA+Za2f/fgumhgvYF6cKi
	 u0u6k9BOWIAOYgbEUJB7nSf18Y/q/XyEXY/8U/ju15I9Tomx7qjfwZZRqCjUHGDKP6
	 hwUz3zaWsRBrA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:43 -0400
Subject: [PATCH nfs-utils 05/17] build: add libnl3 and netlink header
 support for exportd and mountd
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-5-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4767; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JvbeddlOm0xcRydnLMdh41j9nnPNMQAY2tLLE0K/e3s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7gnf8jx3LAMfPbFgKVWtiSqhKhwKPOAiuBh
 Y2S2aDc1xeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4AAKCRAADmhBGVaC
 FRWHEACoymGBeK07U+hZUm9Snyr+06SyNytdyLJ0b+tMoB7utraw4PMo+4jBODxNULT/DeZr3XN
 tyr6PwRF/8fnK6EJraJZfYJPt8iLU6pvCvPo/RzC+da3nfpz0zyOtvlc5zHUISRB/ZzWUNH7rHP
 5j/rmIxpM996NKGeTA3mjsZuX75QnlU4ceTwZeA2cSmaB40Kq0gYT22WhCD5miaOfyxVw4kB3Qf
 XOPf4tJ+udInym0b4WHE0HhQY2KxusjMjnhzKLY4rV78xJgjqm+iVFpwaNKBVlY/PUXmu39+iTG
 t28bPyf7h2x7bYRSwnNQtmYSWxP4vlCEjS3lHfjNI/Tx9wVGxH1i9GE3Duk38r5mlbUvx8OLULs
 34n0i1I4K9KYIQ5dfndszNiVO6WeBRR0pEU2TC5VXGeg8Zhvg5tHSjdTI2CJb5h3Q7Kyf+XrudE
 i52sthbW6Bkw7WJWa7aZR30zq4FbzG+G5uWz1QhFWONFu08eXMb1bhM++j067Wmr+MhFCHh025c
 rfkNyTC7Oc7LDkDk8v25TTrXkkoWwhKzwb21+oC9ycmF89jAxcwyltPqjB1aXsnCYnM5xtRsv19
 rioIY2rZFyY+3lkGE1pkJRfPDyCwobAdY0fRZoflGcLoke5dUnjpVmi5EmJCVOkixFLaUZE9JEi
 F+ne9b367oLiRow==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20204-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,configure.ac:url]
X-Rspamd-Queue-Id: 609BF29C4E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add libnl3 dependency and netlink header detection for exportd and
mountd builds. Update the nfsd_netlink.h sentinel to check for
NFSD_A_EXPKEY_SEQNO to ensure the system header includes expkey
support. Add AC_COMPILE_IFELSE check for sunrpc_netlink.h using
SUNRPC_CMD_CACHE_NOTIFY as sentinel.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 configure.ac               | 32 +++++++++++++++++++-------------
 support/export/Makefile.am |  3 ++-
 utils/exportd/Makefile.am  |  2 +-
 utils/mountd/Makefile.am   |  2 +-
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/configure.ac b/configure.ac
index b134c98c7c6e1ba56c2b2a0b4e8d614d58093f35..f8c04fbfeaaafa63c07f7552dd7c71ef234eab10 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,26 +252,32 @@ AC_ARG_ENABLE(nfsdcltrack,
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
-				                   [[int foo = NFSD_A_SERVER_MIN_THREADS;]])],
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


