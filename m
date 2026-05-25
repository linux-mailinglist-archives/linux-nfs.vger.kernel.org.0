Return-Path: <linux-nfs+bounces-21921-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFX6D3ZEFGqmLQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21921-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:45:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4B5CAA9B
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 943E0301369C
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 12:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55538237C;
	Mon, 25 May 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2wigTql"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2063815FA
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713122; cv=none; b=MCFHSG1zWJV2iZmglFG1NjY2wRW2Yr9zx+0+cTOujYmrI63bOui2l2xMSVfCTmQF0YS4PeSBZUlb0xKl8dRcT3RdQ3e8JoUWOjoZhb5PzIylEhfUjF29jBwAi8M1UGrMHnsBRACcEq0D14I4OaWm0moZY+tT+w9nlciyOEfa+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713122; c=relaxed/simple;
	bh=tQpBNksDrL+lG4e0v0u/3yS4EKpKZ6X7dBRHzsPn6Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DWgaMtA12jaAnz8k+0XrCnzR64uKKZf3kootU9+O9jrHM4/nh66a/ySRG5icNK5+FxxMRBLMHetKXisTJy0c20lX70r4lqYXuSweiS2u5I8lTcnnW80NfUD5vC9iLyex2flgp4WR8FYU3w+LH4kT42JMy1MfoZbfig9/5mN8dmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2wigTql; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FFA1F000E9;
	Mon, 25 May 2026 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779713120;
	bh=a/c3/WbYJc913U8llsrRHVmvbfK7aBLHvEc0RhmyS9M=;
	h=From:Date:Subject:To:Cc;
	b=k2wigTqlD1IoYn+pFHz6bmAumRnK4fSctB+ALSV7sop6VjDWP8SfJyzMl6UAyWUBx
	 9eoqGFjfRV/rPEMKkwcCWkjfj47vqGWh8Q12IFJJ8GAOZKwyZSUqq+Le3+GghhOFKV
	 VokaZbxsuAqbGSzHKKml/3nf47fHNoCsa59coSD/8u6JokiByGfkhz9zKLZSXwwx06
	 xnm67bjG1n0gSBGY0/bMaRx3HAwkf3QdcAhbGP3Prla75ltm6WUd8HgZz9IyH5iTcb
	 IuGGQbktxM+qJMt291ggGA7FW/csrQO414yihA8RIGBsW+ry4paks5AuNYtpNCTxxm
	 SJArknu2uYaHQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 25 May 2026 08:45:14 -0400
Subject: [PATCH nfs-utils] nfsstat: add netlink support for fetching server
 statistics
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-nfsstat-nl-v1-1-eca0764921ea@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkGjIvpKdDDbakEsXItA/HvSc
 WBmEggFJoGxShDoYeHTF9B1BfYwfifktTA0qulVp1v0m0g0Eb1D3VuzkLaDMgQluAJt/P6zCYq
 Hd2QnMOf8AVHKNnZnAAAA
X-Change-ID: 20260514-nfsstat-nl-16cabe1c80ae
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12500; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tQpBNksDrL+lG4e0v0u/3yS4EKpKZ6X7dBRHzsPn6Cw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFERfM6FoNXVfqSmOscBHvIQaapw2iLjGxnncL
 MQ4kAc/r26JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahREXwAKCRAADmhBGVaC
 FU3xEAC8wmiXInIpp2Kkuf1MCprvp8QrFb54DMpCBi/CGnTID7bzeMoeNtgN83/X3f+a8ejkxJG
 TZMCxwa2Ud0CzGFzD1Rfq/uZSf4bnAZUrEv/5x6Fg50cIiJ1xgTiHTsiYaT/wbQjusTDFYb9N4/
 dcO8RBAASOa1mpSPy6CdpI92QXS2Lq53law4gBoG+dycngux2x9r1/rJuG6PXTvHdEM80HZrDbx
 16DFh/KtZPtwos9MwG/+KP3NK+M3wldNRQriC0qzgrXdDKprai8Rg9E1hKN87D8+25L/s0B/ZFq
 gahfZ9qrHlngLca7Ghw3rMgLft6zzp4VBIjfDcHDfWZmkjYHOnejOo23iAPAJVIWAbcmn6nQfr0
 FZypwGVVKHAad+L5QKn7gi0ieSA93Rnee9rNZUIXVWHWX4QTUYH1vaWbkBawFOMrUScja8Tp8Gk
 pN/kEOb/gNCTTWefqgAZ41aGN+R09y5sgTjRd4fUOUcsl2+jiWL/ipgOaHFFUTHU4EU/4DOB7xu
 STJFroA2zdXtZNpRKB9TE+uK/4D1mXAoAJNKffwR+lUdaiuhcrmLTW9zFSWdtVBVhKoHXtpEu0N
 Cy2y//bHtZ2ZjrUPEoOQu4R1naXxof8R1ybGe745ta/rEEEgY/LOsXgMyg4MFXu0Z6VgcGz/DQL
 6Q9URGNbvggTZYQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21921-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 90C4B5CAA9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add Generic Netlink support to nfsstat for retrieving NFS server
statistics, with automatic fallback to the existing /proc/net/rpc/nfsd
parsing when netlink is unavailable (e.g., older kernels).

The new code sends NFSD_CMD_SERVER_STATS_GET as a dump command and
parses the reply to populate the same stat arrays used by the proc
path: reply cache (rc), filehandle (fh), IO, network, RPC, and
per-version procedure call counts (proc2/3/4/proc4ops).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This patch requires the corresponding kernel patches to add netlink
support:

https://lore.kernel.org/linux-nfs/20260525-exportd-netlink-v2-0-40003fed450c@kernel.org/
---
 support/include/nfsd_netlink.h |  86 ++++++++-----
 utils/nfsstat/Makefile.am      |   4 +-
 utils/nfsstat/nfsstat.c        | 282 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 341 insertions(+), 31 deletions(-)

diff --git a/support/include/nfsd_netlink.h b/support/include/nfsd_netlink.h
index a6a831866be8..3d076d173b1d 100644
--- a/support/include/nfsd_netlink.h
+++ b/support/include/nfsd_netlink.h
@@ -128,27 +128,6 @@ enum {
 	NFSD_A_POOL_MODE_MAX = (__NFSD_A_POOL_MODE_MAX - 1)
 };
 
-enum {
-	NFSD_A_UNLOCK_IP_ADDRESS = 1,
-
-	__NFSD_A_UNLOCK_IP_MAX,
-	NFSD_A_UNLOCK_IP_MAX = (__NFSD_A_UNLOCK_IP_MAX - 1)
-};
-
-enum {
-	NFSD_A_UNLOCK_FILESYSTEM_PATH = 1,
-
-	__NFSD_A_UNLOCK_FILESYSTEM_MAX,
-	NFSD_A_UNLOCK_FILESYSTEM_MAX = (__NFSD_A_UNLOCK_FILESYSTEM_MAX - 1)
-};
-
-enum {
-	NFSD_A_UNLOCK_EXPORT_PATH = 1,
-
-	__NFSD_A_UNLOCK_EXPORT_MAX,
-	NFSD_A_UNLOCK_EXPORT_MAX = (__NFSD_A_UNLOCK_EXPORT_MAX - 1)
-};
-
 enum {
 	NFSD_A_FSLOCATION_HOST = 1,
 	NFSD_A_FSLOCATION_PATH,
@@ -172,15 +151,6 @@ enum {
 	NFSD_A_AUTH_FLAVOR_MAX = (__NFSD_A_AUTH_FLAVOR_MAX - 1)
 };
 
-enum {
-	NFSD_A_SVC_EXPORT_REQ_SEQNO = 1,
-	NFSD_A_SVC_EXPORT_REQ_CLIENT,
-	NFSD_A_SVC_EXPORT_REQ_PATH,
-
-	__NFSD_A_SVC_EXPORT_REQ_MAX,
-	NFSD_A_SVC_EXPORT_REQ_MAX = (__NFSD_A_SVC_EXPORT_REQ_MAX - 1)
-};
-
 enum {
 	NFSD_A_SVC_EXPORT_SEQNO = 1,
 	NFSD_A_SVC_EXPORT_CLIENT,
@@ -234,6 +204,61 @@ enum {
 	NFSD_A_CACHE_FLUSH_MAX = (__NFSD_A_CACHE_FLUSH_MAX - 1)
 };
 
+enum {
+	NFSD_A_UNLOCK_IP_ADDRESS = 1,
+
+	__NFSD_A_UNLOCK_IP_MAX,
+	NFSD_A_UNLOCK_IP_MAX = (__NFSD_A_UNLOCK_IP_MAX - 1)
+};
+
+enum {
+	NFSD_A_UNLOCK_FILESYSTEM_PATH = 1,
+
+	__NFSD_A_UNLOCK_FILESYSTEM_MAX,
+	NFSD_A_UNLOCK_FILESYSTEM_MAX = (__NFSD_A_UNLOCK_FILESYSTEM_MAX - 1)
+};
+
+enum {
+	NFSD_A_UNLOCK_EXPORT_PATH = 1,
+
+	__NFSD_A_UNLOCK_EXPORT_MAX,
+	NFSD_A_UNLOCK_EXPORT_MAX = (__NFSD_A_UNLOCK_EXPORT_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_PROC_ENTRY_OP = 1,
+	NFSD_A_SERVER_PROC_ENTRY_COUNT,
+	NFSD_A_SERVER_PROC_ENTRY_PAD,
+
+	__NFSD_A_SERVER_PROC_ENTRY_MAX,
+	NFSD_A_SERVER_PROC_ENTRY_MAX = (__NFSD_A_SERVER_PROC_ENTRY_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_STATS_RC_HITS = 1,
+	NFSD_A_SERVER_STATS_RC_MISSES,
+	NFSD_A_SERVER_STATS_RC_NOCACHE,
+	NFSD_A_SERVER_STATS_PAD,
+	NFSD_A_SERVER_STATS_FH_STALE,
+	NFSD_A_SERVER_STATS_IO_READ,
+	NFSD_A_SERVER_STATS_IO_WRITE,
+	NFSD_A_SERVER_STATS_NETCNT,
+	NFSD_A_SERVER_STATS_NETUDPCNT,
+	NFSD_A_SERVER_STATS_NETTCPCNT,
+	NFSD_A_SERVER_STATS_NETTCPCONN,
+	NFSD_A_SERVER_STATS_RPCCNT,
+	NFSD_A_SERVER_STATS_RPCBADFMT,
+	NFSD_A_SERVER_STATS_RPCBADAUTH,
+	NFSD_A_SERVER_STATS_RPCBADCLNT,
+	NFSD_A_SERVER_STATS_PROC2_OPS,
+	NFSD_A_SERVER_STATS_PROC3_OPS,
+	NFSD_A_SERVER_STATS_PROC4_OPS,
+	NFSD_A_SERVER_STATS_PROC4OPS_OPS,
+
+	__NFSD_A_SERVER_STATS_MAX,
+	NFSD_A_SERVER_STATS_MAX = (__NFSD_A_SERVER_STATS_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -253,6 +278,7 @@ enum {
 	NFSD_CMD_UNLOCK_IP,
 	NFSD_CMD_UNLOCK_FILESYSTEM,
 	NFSD_CMD_UNLOCK_EXPORT,
+	NFSD_CMD_SERVER_STATS_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
diff --git a/utils/nfsstat/Makefile.am b/utils/nfsstat/Makefile.am
index d1555a7d82d3..8b121c48c35c 100644
--- a/utils/nfsstat/Makefile.am
+++ b/utils/nfsstat/Makefile.am
@@ -5,8 +5,10 @@ EXTRA_DIST	= $(man8_MANS)
 
 sbin_PROGRAMS	= nfsstat
 nfsstat_SOURCES = nfsstat.c
+nfsstat_CFLAGS = $(LIBNL3_CFLAGS) $(LIBNLGENL3_CFLAGS)
 nfsstat_LDADD = ../../support/export/libexport.a \
 	      	../../support/nfs/libnfs.la \
-		../../support/misc/libmisc.a
+		../../support/misc/libmisc.a \
+		$(LIBNL3_LIBS) $(LIBNLGENL3_LIBS)
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/utils/nfsstat/nfsstat.c b/utils/nfsstat/nfsstat.c
index ca845325f0dc..f09e1d6a447f 100644
--- a/utils/nfsstat/nfsstat.c
+++ b/utils/nfsstat/nfsstat.c
@@ -23,6 +23,17 @@
 #include <signal.h>
 #include <time.h>
 
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+
+#ifdef USE_SYSTEM_NFSD_NETLINK_H
+#include <linux/nfsd_netlink.h>
+#else
+#include "nfsd_netlink.h"
+#endif
+
 #define MAXNRVALS	32
 
 enum {
@@ -271,6 +282,7 @@ static statinfo		*get_stat_info(const char *, struct statinfo *);
 
 static int		mounts(const char *);
 
+static int		get_stats_netlink(struct statinfo *);
 static void		get_stats(const char *, struct statinfo *, int *, int,
 					int);
 static int		has_stats(const unsigned int *, int);
@@ -1051,6 +1063,272 @@ mounts(const char *name)
 	return 1;
 }
 
+/*
+ * Netlink helpers for fetching server stats via Generic Netlink.
+ */
+static int nl_error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
+			    void *arg)
+{
+	int *ret = arg;
+
+	*ret = err->error;
+	return NL_SKIP;
+}
+
+static int nl_finish_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+
+	*ret = 0;
+	return NL_SKIP;
+}
+
+static int nl_ack_handler(struct nl_msg *msg, void *arg)
+{
+	int *ret = arg;
+
+	*ret = 0;
+	return NL_STOP;
+}
+
+static void parse_one_proc_entry(struct nlattr *nest, unsigned int *info,
+				 unsigned int max_ops)
+{
+	struct nlattr *tb[NFSD_A_SERVER_PROC_ENTRY_MAX + 1];
+	unsigned int op, count;
+
+	nla_parse_nested(tb, NFSD_A_SERVER_PROC_ENTRY_MAX, nest, NULL);
+	if (!tb[NFSD_A_SERVER_PROC_ENTRY_OP] ||
+	    !tb[NFSD_A_SERVER_PROC_ENTRY_COUNT])
+		return;
+
+	op = nla_get_u32(tb[NFSD_A_SERVER_PROC_ENTRY_OP]);
+	count = (unsigned int)nla_get_u64(tb[NFSD_A_SERVER_PROC_ENTRY_COUNT]);
+	if (op < max_ops) {
+		info[0] = max_ops;
+		info[op + 1] = count;
+	}
+}
+
+static int stats_nl_handler(struct nl_msg *msg, void *arg)
+{
+	struct statinfo *info = arg;
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *attr;
+	statinfo *si;
+	int rem;
+
+	nla_for_each_attr(attr, genlmsg_attrdata(gnlh, 0),
+			  genlmsg_attrlen(gnlh, 0), rem) {
+		int type = nla_type(attr);
+
+		switch (type) {
+		/* Reply cache */
+		case NFSD_A_SERVER_STATS_RC_HITS:
+			si = get_stat_info("rc", info);
+			if (si)
+				si->valptr[0] = nla_get_u64(attr);
+			break;
+		case NFSD_A_SERVER_STATS_RC_MISSES:
+			si = get_stat_info("rc", info);
+			if (si)
+				si->valptr[1] = nla_get_u64(attr);
+			break;
+		case NFSD_A_SERVER_STATS_RC_NOCACHE:
+			si = get_stat_info("rc", info);
+			if (si)
+				si->valptr[2] = nla_get_u64(attr);
+			break;
+
+		/* Filehandle */
+		case NFSD_A_SERVER_STATS_FH_STALE:
+			si = get_stat_info("fh", info);
+			if (si)
+				si->valptr[0] = nla_get_u64(attr);
+			break;
+
+		/* IO */
+		case NFSD_A_SERVER_STATS_IO_READ:
+			si = get_stat_info("io", info);
+			if (si)
+				si->valptr[0] = nla_get_u64(attr);
+			break;
+		case NFSD_A_SERVER_STATS_IO_WRITE:
+			si = get_stat_info("io", info);
+			if (si)
+				si->valptr[1] = nla_get_u64(attr);
+			break;
+
+		/* Network */
+		case NFSD_A_SERVER_STATS_NETCNT:
+			si = get_stat_info("net", info);
+			if (si)
+				si->valptr[0] = nla_get_u32(attr);
+			break;
+		case NFSD_A_SERVER_STATS_NETUDPCNT:
+			si = get_stat_info("net", info);
+			if (si)
+				si->valptr[1] = nla_get_u32(attr);
+			break;
+		case NFSD_A_SERVER_STATS_NETTCPCNT:
+			si = get_stat_info("net", info);
+			if (si)
+				si->valptr[2] = nla_get_u32(attr);
+			break;
+		case NFSD_A_SERVER_STATS_NETTCPCONN:
+			si = get_stat_info("net", info);
+			if (si)
+				si->valptr[3] = nla_get_u32(attr);
+			break;
+
+		/* RPC */
+		case NFSD_A_SERVER_STATS_RPCCNT:
+			si = get_stat_info("rpc", info);
+			if (si)
+				si->valptr[0] = nla_get_u32(attr);
+			break;
+		case NFSD_A_SERVER_STATS_RPCBADFMT:
+			si = get_stat_info("rpc", info);
+			if (si)
+				si->valptr[2] = nla_get_u32(attr);
+			break;
+		case NFSD_A_SERVER_STATS_RPCBADAUTH:
+			si = get_stat_info("rpc", info);
+			if (si)
+				si->valptr[3] = nla_get_u32(attr);
+			break;
+		case NFSD_A_SERVER_STATS_RPCBADCLNT:
+			si = get_stat_info("rpc", info);
+			if (si)
+				si->valptr[4] = nla_get_u32(attr);
+			break;
+
+		/* Per-version procedure counts (multi-attr) */
+		case NFSD_A_SERVER_STATS_PROC2_OPS:
+			si = get_stat_info("proc2", info);
+			if (si)
+				parse_one_proc_entry(attr, si->valptr,
+						     SRVPROC2_SZ);
+			break;
+		case NFSD_A_SERVER_STATS_PROC3_OPS:
+			si = get_stat_info("proc3", info);
+			if (si)
+				parse_one_proc_entry(attr, si->valptr,
+						     SRVPROC3_SZ);
+			break;
+		case NFSD_A_SERVER_STATS_PROC4_OPS:
+			si = get_stat_info("proc4", info);
+			if (si)
+				parse_one_proc_entry(attr, si->valptr,
+						     SRVPROC4_SZ);
+			break;
+		case NFSD_A_SERVER_STATS_PROC4OPS_OPS:
+			si = get_stat_info("proc4ops", info);
+			if (si)
+				parse_one_proc_entry(attr, si->valptr,
+						     SRVPROC4OPS_SZ);
+			break;
+		}
+	}
+
+	return NL_OK;
+}
+
+/*
+ * Fetch server stats via Generic Netlink.
+ * Returns 0 on success, -1 on failure.
+ */
+static int
+get_stats_netlink(struct statinfo *info)
+{
+	struct nl_sock *sock;
+	struct nl_msg *msg;
+	struct nl_cb *cb;
+	int family, ret;
+	statinfo *si;
+
+	sock = nl_socket_alloc();
+	if (!sock)
+		return -1;
+
+	if (genl_connect(sock)) {
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	family = genl_ctrl_resolve(sock, NFSD_FAMILY_NAME);
+	if (family < 0) {
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	msg = nlmsg_alloc();
+	if (!msg) {
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	if (!genlmsg_put(msg, NL_AUTO_PID, NL_AUTO_SEQ, family, 0,
+			 NLM_F_DUMP, NFSD_CMD_SERVER_STATS_GET, 0)) {
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	cb = nl_cb_alloc(NL_CB_CUSTOM);
+	if (!cb) {
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	ret = nl_send_auto(sock, msg);
+	if (ret < 0) {
+		nl_cb_put(cb);
+		nlmsg_free(msg);
+		nl_socket_free(sock);
+		return -1;
+	}
+
+	ret = 1;
+	nl_cb_err(cb, NL_CB_CUSTOM, nl_error_handler, &ret);
+	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, nl_finish_handler, &ret);
+	nl_cb_set(cb, NL_CB_ACK, NL_CB_CUSTOM, nl_ack_handler, &ret);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, stats_nl_handler, info);
+
+	while (ret > 0)
+		nl_recvmsgs(sock, cb);
+
+	nl_cb_put(cb);
+	nlmsg_free(msg);
+	nl_socket_free(sock);
+
+	if (ret < 0)
+		return -1;
+
+	/*
+	 * Compute derived fields. The proc file emits "rpc rpccnt
+	 * badcalls badfmt badauth badclnt" where badcalls is the sum
+	 * of badfmt+badauth+badclnt. The netlink interface sends the
+	 * components individually, so recompute the sum here.
+	 */
+	si = get_stat_info("rpc", info);
+	if (si)
+		si->valptr[1] = si->valptr[2] + si->valptr[3] + si->valptr[4];
+
+	/* Compute totals for each stat category */
+	for (si = info; si->tag; si++) {
+		unsigned int total = 0;
+		int i;
+
+		for (i = 0; i < si->nrvals - 1; i++)
+			total += si->valptr[i];
+		si->valptr[si->nrvals - 1] = total;
+	}
+
+	return 0;
+}
+
 static void
 get_stats(const char *file, struct statinfo *info, int *opt, int other_opt,
 		int is_srv)
@@ -1060,6 +1338,10 @@ get_stats(const char *file, struct statinfo *info, int *opt, int other_opt,
 	int err = 1;
 	char *label = is_srv ? "Server" : "Client";
 
+	/* Try netlink first for server stats */
+	if (is_srv && get_stats_netlink(info) == 0)
+		return;
+
 	/* try to guess what type of stat file we're dealing with */
 	if ((fp = fopen(file, "r")) == NULL)
 		goto out;

---
base-commit: a806c9d65662ecf5d40c00d60a514e13ada8d76e
change-id: 20260514-nfsstat-nl-16cabe1c80ae

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


