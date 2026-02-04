Return-Path: <linux-nfs+bounces-18698-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPWvK1A8g2ngjwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18698-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 13:32:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A05E5D3E
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 13:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B2D4306689C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097CF3ED10D;
	Wed,  4 Feb 2026 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpALBb1g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A93EDABC
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208122; cv=none; b=krHeULuugGvjxE8W0mJ5Vs5Ml50WYEKbaQoq4nQnL6IWL+v2bET/Vz6J3qGHxk/Ok788fO15/Cv7ZDr21XpxHOMxiQqn7tql2WOtBjGzPcM2t8Lf3GDeePPtYs0wL/QEKBTJZKILwDuATIYTl/f/FnuvxsTMWOl8Kjmjw7uKG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208122; c=relaxed/simple;
	bh=V6/VvxvNgx9GoJ7hYN817DAw7/IwaMOJODLjg3aGd0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVwwMyFRnYlH5GykxCbookmwE0Kuuc8MPozLxZ2vlg/mLpcP9/o3H1CW+ZC8eqx5+/taRZlj84kwyFmVAURTCrtL8XoKDvckWgwz+tDeb0FjpfkD1kL4ISvfOkBB7lbt58Tv9RwN5yvk12J0gktcAayVHIASqMOqND14FRFpHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpALBb1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C40C19422;
	Wed,  4 Feb 2026 12:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770208122;
	bh=V6/VvxvNgx9GoJ7hYN817DAw7/IwaMOJODLjg3aGd0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bpALBb1g+macuuEO9JJPNUflyxROt6+rPkuHg1vRsMDBVw7YYClYy1+joCCI9VwIw
	 MlEObuaoC286Sp3ZRusaTSjbDQzpJHHQqKN0ji+nzhHc9AmFn9l8jcbH3a0YJU/Zhy
	 SKXRA6gnkP2uYSbEMbkdijQrC12nCXDoZAd1VwQQ7F4m1ELzQlnBjStIvZR3CFccIN
	 11Rax+sqvRWLPCEd/tEK0Vm7A/m7oY4STUeQx60rOPvdn6idZ8BVZpPhyuuZtvmA8f
	 pxyOGoHdr8PbhM0SMb5G0ettY9AOEYLJP4XytC7siGy+29i441+O8pvxenA9nRZNhA
	 Q6SNJVi473rBA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Feb 2026 07:28:26 -0500
Subject: [PATCH nfs-utils 1/3] nfsdctl: only resolve netlink family names
 once
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-minthreads-v1-1-9f348608f884@kernel.org>
References: <20260204-minthreads-v1-0-9f348608f884@kernel.org>
In-Reply-To: <20260204-minthreads-v1-0-9f348608f884@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Ben Coddington <bcodding@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5001; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=V6/VvxvNgx9GoJ7hYN817DAw7/IwaMOJODLjg3aGd0o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpgzt4tmUrM/c0j/Cbf1he4njUPGqF0XPnq3bc5
 4uHpEQrkO6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYM7eAAKCRAADmhBGVaC
 FeBbD/4gXyXFIQv/8rRTaSu7g3jtaBncpPYdesa3/GjngZRHeD9pzizb5qyuyWVZgOUABdTPpEP
 qIDKXfPD4++NMm01umx5OuRgllDsRoOeCihdKOFj9w0qf6oR5ISODHLp4wmhyO5W2wn+c3lyx9b
 UAPJVKAYKn7jNxRvuhFS7c4gdNpzA8Nnr/ArQ8aqrzdUkdiTej/hjvDPZ+8IKz0AknwVn6t0QVo
 tTZiw3XDRNIwLWe5uLrfaRQA8pQx6DMIvc1kbbbrmyXn/cMkE+aU4yCOG8AlRH0Bvp7VTov+lXx
 SXFuwXCchgr9+0nWQSBtAU9Ba6+3MoJa6EXoATkVLtQTv1309Vl3Hy8Cmu04BvgJxjHmb18FU33
 pbMUjRcg0tTHY9MlpNqXh9kPWzbHD04wCBZyzAY1xLJaURsKf6YL+KQy2WJhHFjT4qx38H4PZfS
 jVr00i1RgHuzMDyJE6kXCdAy1ufmOfBE0pc6x+S/ZnA7zfyzEItqNZxYk0I6gHn4b4Slf7Jiq5G
 vJzx/5/cnilALBiYy7LsHGLPf/0SOqtzvs9neuEyGDYb86bPDuKcX7XQHmmNzk8M4nnWtxyv2mu
 EnE1PW3T+YlxZJR6lCzuPnJPySbNnYx7Zv8VJ4cIOeX8J4M8M2xOm7JHsdAiAfm7LIX/hpw8Ekn
 Ac2SrHuKf8CuMIQ==
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18698-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14A05E5D3E
X-Rspamd-Action: no action

The current code resolves the string name to an id for every netlink
call. Just resolve the family names once and keep them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 83 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 19 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index c906a2c8ba6d357e182d341a30610e367e74c093..0d624d4de6016e3c9189d488736eb1b9b2f6fe6e 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -46,9 +46,11 @@
 #include "conffile.h"
 #include "xlog.h"
 
-/* compile note:
- * gcc -I/usr/include/libnl3/ -o <prog-name> <prog-name>.c -lnl-3 -lnl-genl-3
- */
+/* The index of the "lockd" netlink family */
+static int lockd_nl_family;
+
+/* The index of the "nfsd" netlink family */
+static int nfsd_nl_family;
 
 struct nfs_version {
 	uint8_t	major;
@@ -435,24 +437,18 @@ static struct nl_sock *netlink_sock_alloc(void)
 	return sock;
 }
 
-static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family)
+static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, int family)
 {
 	struct nl_msg *msg;
 	int id;
 
-	id = genl_ctrl_resolve(sock, family);
-	if (id < 0) {
-		xlog(L_ERROR, "failed to resolve %s generic netlink family", family);
-		return NULL;
-	}
-
 	msg = nlmsg_alloc();
 	if (!msg) {
 		xlog(L_ERROR, "failed to allocate netlink message");
 		return NULL;
 	}
 
-	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
+	if (!genlmsg_put(msg, 0, 0, family, 0, 0, 0, 0)) {
 		xlog(L_ERROR, "failed to add generic netlink headers to netlink message");
 		nlmsg_free(msg);
 		return NULL;
@@ -461,6 +457,31 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
 	return msg;
 }
 
+static int resolve_family(struct nl_sock *sock, const char *name)
+{
+	int family = genl_ctrl_resolve(sock, name);
+
+	if (family < 0) {
+		xlog(L_ERROR, "failed to resolve %s generic netlink family: %d", name, family);
+		family = 0;
+	}
+	return family;
+}
+
+static int lockd_nl_family_setup(struct nl_sock *sock)
+{
+	if (!lockd_nl_family)
+		lockd_nl_family = resolve_family(sock, LOCKD_FAMILY_NAME);
+	return lockd_nl_family;
+}
+
+static int nfsd_nl_family_setup(struct nl_sock *sock)
+{
+	if (!nfsd_nl_family)
+		nfsd_nl_family = resolve_family(sock, NFSD_FAMILY_NAME);
+	return nfsd_nl_family;
+}
+
 static void status_usage(void)
 {
 	printf("Usage: %s status\n", taskname);
@@ -484,7 +505,10 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
 		}
 	}
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -532,7 +556,10 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -674,7 +701,10 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -739,7 +769,10 @@ static int set_nfsd_versions(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int i, ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -920,7 +953,10 @@ static int fetch_current_listeners(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -1165,7 +1201,10 @@ static int set_listeners(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int i, ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -1286,7 +1325,10 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -1379,7 +1421,10 @@ static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcppo
 			return 0;
 	}
 
-	msg = netlink_msg_alloc(sock, LOCKD_FAMILY_NAME);
+	if (!lockd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, lockd_nl_family);
 	if (!msg)
 		return 1;
 

-- 
2.52.0


