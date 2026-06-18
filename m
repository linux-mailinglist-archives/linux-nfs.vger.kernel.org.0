Return-Path: <linux-nfs+bounces-22679-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aef6L1kqNGqhQQYAu9opvQ
	(envelope-from <linux-nfs+bounces-22679-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 19:26:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5E6A1EE1
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 19:26:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gqeIEW5L;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22679-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22679-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0435303D113
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C50280A56;
	Thu, 18 Jun 2026 17:24:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F32773DE
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jun 2026 17:24:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803494; cv=none; b=EJB/la9sr5CDmS2bFePHgrREEK6vZS/LquLSjhyUnfyE63AZs5YNNn2B4cRrPRAe0QNIJzko8DUdPAAmbTL1WxVx3BH/dfQztMgAtfPbbbViYai/GJw2wSfFQ88mlV3yWaMSMt6yOuLfDfuRMDARLuI4cgomFTciL7zoa2q5NpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803494; c=relaxed/simple;
	bh=x8/tbsxNblV5U1JZdvvIqYD23ddQJk5QZiWv+gpI7K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KiO1vgX4xrC2bKx/ULY5RU/ubQRwxxX+7ciRGBX3Z7G6Do1wBRzE5wJUcBRvJWUgMVdow9DIsTWWASe3zyWYBhy30y7CWzWmGFZM82wVpFKJ5kJbab14AMrDv+6GR5V+aUkoSYxAI+SDrgwfcvy9utBpvQqQSuVbhKidJz76OFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqeIEW5L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BDF1F000E9;
	Thu, 18 Jun 2026 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781803493;
	bh=aWfYBgU1hT8fsG3z5ebrYKdLa+ang7O1x/pQLZuCQQk=;
	h=From:Date:Subject:To:Cc;
	b=gqeIEW5LAzjP2+aT4Uaol+9ZZ5wxm1/RWZ1om9WSGxadLYxJQcjBV3X1O4CUlhh1O
	 jV+4hheaT/p6k21fg4a0csDZRhc71w3+cweBMjFZ/krf4OlrM3PpIJeOOjQqLZnFmn
	 pYH+Xl3MnjOIPHTCMFuJzlXpcw7GSs/LTe90DZ6cUJKDtzd/8Q9srMbTP+xNXENo/t
	 D46KaiBnHKlHR7S7zRpRXvokDaKqwEENRS+Upn7qkDqV6X9ZCzJr2L+yeOn1k4Ompp
	 S7FYR4I8K1DhnnEFHGYtH3Rrg6RaPOG+4hr1ibRQ6VBvI/RfRJ0Fy3vt2A9XNk/Sra
	 8VllTCu25hDIw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 18 Jun 2026 13:24:48 -0400
Subject: [PATCH nfs-utils] nfsstat: display NFSv4 callback operation
 statistics
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-nfsstat-nl-v1-1-bd00f7e20b80@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G6hbXb4iHqpGDUiVpopQ/LvF4
 8DMBBByTAJdEsDRzcKHjZClCUybsSshz5EhV7lWOmvQLiLeeLQ71moudWXGsi1GiMHpaOHnn/U
 QPbw87wLD+36Z217vZwAAAA==
X-Change-ID: 20260618-nfsstat-nl-70d465ab493b
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6521; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=x8/tbsxNblV5U1JZdvvIqYD23ddQJk5QZiWv+gpI7K4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNCnj+BwQAwz/nBQSWDDtFVxXjsbo5fZTp3YSR
 n+5bZF0jaCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajQp4wAKCRAADmhBGVaC
 FUBJD/0c0NEkgZLCgnoobrWqo4zo5Pn65/CJA3MapDNQi7sM915ISLIkt/EzB06+YA4dwsEin6d
 2EGDckfGgCzs0Xs163cE7RTbDfMZFBYc3V8NKf2xr6MKnuwWdZdzLD/c4a2xgeJ6OEO3rbtC9QY
 ycq59gcxwZaBxGtVgyKC43ugBssGnDgsbtQX+PAZENzjfeNXaxJChplxPk+UrQ4J2Rev6oWGQ4M
 qaEDvzwFEjuEpFDYpVSJ5DksV6Y8g0D+cyU1fNZnMT7jYC1hQ8/sVmmSIf9Edj0lWwPwAhccMt9
 mQHJC/hONOR5Mhv+iCnRk9oqx85PjRezXNtUTe47Cg64h1G2f5GZPzY+ibCleDrlBiIUBI6p387
 U7IuDizN7Hc86bkx4lXPLD7ts62pM/wmw/Uh6tnEq2TtWRgbUKhB4a89DIYzW/8WSEOLBZmsrtc
 PzwlLp9wCtICNgRgv2/CuctVenHCKAW/31/Dak06Yj1a+Dq2wyLrsDxRbg7D7oKkaiE36WttZX+
 NsB5LsbhMCtHQL0AWM0MUGQGqVZ0XoeQaydUDM+oARnGT+OyEJstbGQ/dKuldShUFHuOB8KG9qn
 QtPAViosD6HkHoNFGjbCm49LO/YUAGMU8OItKVyYdsyAAldwlcw4euUgMddVlc2P8CDXiu2oqZP
 2vdxj16WY3glwuw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22679-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:steved@redhat.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16E5E6A1EE1

The kernel now maintains per-operation call counts for the NFSv4
backchannel (callback) operations it sends to clients, and exports them
through the server-stats netlink dump as a new proc4cb-ops nested
attribute (one server-proc-entry per callback opcode, OP_CB_GETATTR
through OP_CB_OFFLOAD).

Add a "Server nfs v4 callback operations" section to nfsstat that
reports these counts. The data is only available over netlink -- the
/proc interface exposes nothing equivalent (only the single
wdeleg_getattr line, which corresponds to CB_GETATTR) -- so the section
is displayed solely when the stats were fetched via netlink. This is
detected by srvproc4cbinfo[0] being non-zero, which the netlink handler
sets from the entry count and the /proc parsers never touch.

The counters are indexed directly by RFC 8881 callback opcode, so the
name array carries placeholders for the unassigned opcodes 0-2 to keep
the array index aligned with the opcode value, mirroring the kernel's
cb_counter layout.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
After the most recent review, we decided to add server side callback
counts as a new feature for nfsstat. See the kernel patches here:

https://lore.kernel.org/linux-nfs/20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org/
---
 support/include/nfsd_netlink.h |  1 +
 utils/nfsstat/nfsstat.c        | 46 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/support/include/nfsd_netlink.h b/support/include/nfsd_netlink.h
index 3d076d173b1d..87da1d0bb21e 100644
--- a/support/include/nfsd_netlink.h
+++ b/support/include/nfsd_netlink.h
@@ -254,6 +254,7 @@ enum {
 	NFSD_A_SERVER_STATS_PROC3_OPS,
 	NFSD_A_SERVER_STATS_PROC4_OPS,
 	NFSD_A_SERVER_STATS_PROC4OPS_OPS,
+	NFSD_A_SERVER_STATS_PROC4CB_OPS,
 
 	__NFSD_A_SERVER_STATS_MAX,
 	NFSD_A_SERVER_STATS_MAX = (__NFSD_A_SERVER_STATS_MAX - 1)
diff --git a/utils/nfsstat/nfsstat.c b/utils/nfsstat/nfsstat.c
index f09e1d6a447f..6717be502a82 100644
--- a/utils/nfsstat/nfsstat.c
+++ b/utils/nfsstat/nfsstat.c
@@ -44,6 +44,8 @@ enum {
 	SRVPROC4_SZ = 2,
 	CLTPROC4_SZ = 59,
 	SRVPROC4OPS_SZ = 71,
+	SRVPROC4CB_SZ = 16,	/* indexed by callback opcode; OP_CB_OFFLOAD == 15 */
+	SRVPROC4CB_FIRST = 3,	/* first assigned callback opcode, OP_CB_GETATTR */
 };
 
 static unsigned int	srvproc2info[SRVPROC2_SZ+2],
@@ -60,6 +62,8 @@ static unsigned int	cltproc4info[CLTPROC4_SZ+2],
 			cltproc4info_old[CLTPROC4_SZ+2];	/* NFSv4 call counts ([0] == 49) */
 static unsigned int	srvproc4opsinfo[SRVPROC4OPS_SZ+2],
 			srvproc4opsinfo_old[SRVPROC4OPS_SZ+2];	/* NFSv4 call counts ([0] == 59) */
+static unsigned int	srvproc4cbinfo[SRVPROC4CB_SZ+2],
+			srvproc4cbinfo_old[SRVPROC4CB_SZ+2];	/* NFSv4 callback op counts (netlink only, [0] == 16) */
 static unsigned int	srvnetinfo[5], srvnetinfo_old[5];	/* 0  # of received packets
 								 * 1  UDP packets
 								 * 2  TCP packets
@@ -207,6 +211,19 @@ static const char *     nfssrvproc4opname[SRVPROC4OPS_SZ] = {
 	"write_same",
 };
 
+/*
+ * NFSv4 callback (backchannel) operations, indexed directly by RFC 8881
+ * callback opcode.  Opcodes 0-2 are not assigned, so the first three slots
+ * are placeholders to keep the array index aligned with the opcode value;
+ * display starts at SRVPROC4CB_FIRST and never prints them.
+ */
+static const char *	nfssrvproc4cbname[SRVPROC4CB_SZ] = {
+	"op0-unused",	"op1-unused",	"op2-unused",	"cb_getattr",
+	"cb_recall",	"cb_layoutrecall", "cb_notify",	"cb_push_deleg",
+	"cb_recall_any","cb_recall_obj","cb_recall_slot", "cb_sequence",
+	"cb_wants_cancel", "cb_notify_lock", "cb_notify_devid", "cb_offload",
+};
+
 #define LABEL_srvnet		"Server packet stats:\n"
 #define LABEL_srvrpc		"Server rpc stats:\n"
 #define LABEL_srvrc		"Server reply cache:\n"
@@ -217,6 +234,7 @@ static const char *     nfssrvproc4opname[SRVPROC4OPS_SZ] = {
 #define LABEL_srvproc3		"Server nfs v3:\n"
 #define LABEL_srvproc4		"Server nfs v4:\n"
 #define LABEL_srvproc4ops	"Server nfs v4 operations:\n"
+#define LABEL_srvproc4cb	"Server nfs v4 callback operations:\n"
 #define LABEL_cltnet		"Client packet stats:\n"
 #define LABEL_cltrpc		"Client rpc stats:\n"
 #define LABEL_cltproc2		"Client nfs v2:\n"
@@ -250,6 +268,7 @@ typedef struct statinfo {
 					SRV(proc3,s),\
 					SRV(proc4,s), \
 					SRV(proc4ops,s),\
+					SRV(proc4cb,s),\
 					{ NULL, NULL, 0, NULL }\
 				}
 #define DECLARE_CLT(n, s...)  	static statinfo n##s[] = { \
@@ -683,14 +702,24 @@ print_server_stats(int opt_prt)
 					nfssrvproc4name, srvproc4info + 1, 
 					sizeof(nfssrvproc4name)/sizeof(char *));
 				print_callstats(LABEL_srvproc4ops,
-					nfssrvproc4opname, srvproc4opsinfo + 1, 
+					nfssrvproc4opname, srvproc4opsinfo + 1,
 					sizeof(nfssrvproc4opname)/sizeof(char *));
+				/*
+				 * Callback op counts are only available via
+				 * netlink; srvproc4cbinfo[0] is left zero when
+				 * stats come from /proc.
+				 */
+				if (srvproc4cbinfo[0])
+					print_callstats(LABEL_srvproc4cb,
+						nfssrvproc4cbname + SRVPROC4CB_FIRST,
+						srvproc4cbinfo + 1 + SRVPROC4CB_FIRST,
+						SRVPROC4CB_SZ - SRVPROC4CB_FIRST);
 			}
 		}
 	}
 }
 static void
-print_client_stats(int opt_prt) 
+print_client_stats(int opt_prt)
 {
 	if (opt_prt & PRNT_NET) {
 		if (opt_sleep && !has_rpcstats(cltnetinfo, 4)) {
@@ -806,8 +835,13 @@ print_serv_list(int opt_prt)
 					nfssrvproc4name, srvproc4info + 1, 
 					sizeof(nfssrvproc4name)/sizeof(char *));
 				print_callstats_list("nfs v4 servop",
-					nfssrvproc4opname, srvproc4opsinfo + 1, 
+					nfssrvproc4opname, srvproc4opsinfo + 1,
 					sizeof(nfssrvproc4opname)/sizeof(char *));
+				if (srvproc4cbinfo[0])
+					print_callstats_list("nfs v4 cback",
+						nfssrvproc4cbname + SRVPROC4CB_FIRST,
+						srvproc4cbinfo + 1 + SRVPROC4CB_FIRST,
+						SRVPROC4CB_SZ - SRVPROC4CB_FIRST);
 			}
 		}
 	}
@@ -1228,6 +1262,12 @@ static int stats_nl_handler(struct nl_msg *msg, void *arg)
 				parse_one_proc_entry(attr, si->valptr,
 						     SRVPROC4OPS_SZ);
 			break;
+		case NFSD_A_SERVER_STATS_PROC4CB_OPS:
+			si = get_stat_info("proc4cb", info);
+			if (si)
+				parse_one_proc_entry(attr, si->valptr,
+						     SRVPROC4CB_SZ);
+			break;
 		}
 	}
 

---
base-commit: e4342316f4c93e88cce1382560c36dafbf4df58e
change-id: 20260618-nfsstat-nl-70d465ab493b

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


