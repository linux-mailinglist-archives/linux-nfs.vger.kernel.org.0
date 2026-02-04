Return-Path: <linux-nfs+bounces-18715-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEkJFAx6g2nyngMAu9opvQ
	(envelope-from <linux-nfs+bounces-18715-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:55:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF619EA9BE
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E75D30574B8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 16:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31A33B97E;
	Wed,  4 Feb 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKUlovZK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375EF33B966
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223729; cv=none; b=oa8gCrDFl3hOu1hi2qWTJVyomExKA+S0eBWY92eZKNakSngkzicslyLJT5RFmMNZNwQ2GuwTTnHUXsMy0N13hhYvhFyBF/auzYL3IEQkyV9ImIvxFkWhfUiNRwMn6EjHrgsY5uJjsdygrEnbh+14owzm3w8Wy6JLxJTlx1ADQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223729; c=relaxed/simple;
	bh=IKeLqxERl4JCKJHCu9WMT5U8V/2xFW/5Uob6tMQvrwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqDBQ4ZpFGR7mUXEJfJAYBMVJHxP+rshRtFXCH5w01C+0nuEenu/CmFkOW/+dYmAxtoXmZwXVfgKHRBIMuvj42BPtwWsLMcA90dBOMTZaW/K1hPm/MYht/vqawhefc9gujdwCMoFP7H+Ilz0XP8CS7wGgm8RH5I+tujrAETZL3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKUlovZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0E2C19424;
	Wed,  4 Feb 2026 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770223728;
	bh=IKeLqxERl4JCKJHCu9WMT5U8V/2xFW/5Uob6tMQvrwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IKUlovZKcAjU0wrfNU25FlEty1B5QqRJJjM1F5QW1kIQgC3zl7sCUIJKanJjDz2Ck
	 +STyYjpXnqW1aIT9N6TY9lb+WrLHl4neW2B9woLS9hlIJenVLC+qvdVjO9JcUQ+nWr
	 iqzBjJyUdDZYd65pFD7jTh/IDE2w1wtQNK5PUaVUTzbjtOQAQlfxcu9jwZ7Q6KMJcd
	 HwC4dn5EmMtI1+id0drQzS1GBKwwdSOay40mEa74OPNmpAJQA5mMsMqv7UUzh/BwWp
	 QLQMjMFecnph/wb09/xhnF5fIDceW8fwUufeeSbYbyQCNUrkuC0VGlZVZF/7+HUs5e
	 HNTVGy6CkS9pQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 04 Feb 2026 11:48:23 -0500
Subject: [PATCH nfs-utils v2 2/4] nfsdctl: only resolve netlink family
 names once
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-minthreads-v2-2-a7eba34201e9@kernel.org>
References: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
In-Reply-To: <20260204-minthreads-v2-0-a7eba34201e9@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Ben Coddington <bcodding@hammerspace.com>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5001; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=IKeLqxERl4JCKJHCu9WMT5U8V/2xFW/5Uob6tMQvrwg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpg3htF5xgLMmQqjzTfrEL9baSdtQwsNaqfWLQn
 0cEC20lUnqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaYN4bQAKCRAADmhBGVaC
 FdHbD/9gd9j81cAkTkI5tok7JCrJUXfrgNlG3NdUpjdI3N4whu8Pe/Vmh7ivCXDYGCqRLHaRdCD
 /qLyr07vKQ5RK+C8EA/b/lBo49n+BGeCTq5Gh9sfOdytsMUozrEJAxIl5zOe/fd+67GY/TUAYZd
 W1uAObakL4baMnWfVlSjOL+Zgt9vvAr9vVfcNI2qa119yMzurouaN2+p7tzM7R5tR91StfbCWiB
 iHZysr23EXTtQ1AbDxB3UvLDR8fWmmFXRViwh0yPteGGdATTt3gC3+btOAIKNz7WSPq5a4thnO2
 78h8OGN8V82+4BQGnLzs48IwPuwNCgTYkdk/RZygz/Z9Fl+GkfR/vRsVDPrKu4nHvCOWoL0mneL
 RKuEnwiOd6yScWKwWew8ov1QB4txdo9rxfPHh6Lsw6+7suQ02DcNrgxH40rhaoOPxE65Iep5F+y
 9n/I3DZ2y84XunPht7r1gI7RX5VjnoSAT4Sz8+1b15MPhFlNpMRPB2ea44y+Ff0LVv5tZ/EqwkJ
 u5ZmiBZ2Qy657zK90nCub8NdmUvOheNtRMNU54zJTanmmXoDqE5B/M2TRfzrvtcKNsH0bizwgoP
 DDqmlyYMNDkPGB4xcsAdFVguA9RMfLWZ+vnPHbmHRk2arkJl2bdxUMJRKG18FUcStlyuh5sSGdN
 lJQnCDiGZa6UdXQ==
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
	TAGGED_FROM(0.00)[bounces-18715-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: EF619EA9BE
X-Rspamd-Action: no action

The current code resolves the string name to an id for every netlink
call. Just resolve the family names once and keep them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 83 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 19 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 6b3c98009488d1687e7e751eaed6c4f1d9613d39..86a4a944d4e131f1114ca358d81779de0a034872 100644
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
@@ -433,24 +435,18 @@ static struct nl_sock *netlink_sock_alloc(void)
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
@@ -459,6 +455,31 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
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
@@ -482,7 +503,10 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
 		}
 	}
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -530,7 +554,10 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -660,7 +687,10 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -725,7 +755,10 @@ static int set_nfsd_versions(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int i, ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -906,7 +939,10 @@ static int fetch_current_listeners(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -1151,7 +1187,10 @@ static int set_listeners(struct nl_sock *sock)
 	struct nl_cb *cb;
 	int i, ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -1272,7 +1311,10 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 	struct nl_cb *cb;
 	int ret;
 
-	msg = netlink_msg_alloc(sock, NFSD_FAMILY_NAME);
+	if (!nfsd_nl_family_setup(sock))
+		return 1;
+
+	msg = netlink_msg_alloc(sock, nfsd_nl_family);
 	if (!msg)
 		return 1;
 
@@ -1365,7 +1407,10 @@ static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcppo
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


