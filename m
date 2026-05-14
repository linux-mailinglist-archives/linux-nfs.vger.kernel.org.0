Return-Path: <linux-nfs+bounces-21619-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKXvGkYlBmqmfgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21619-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 21:40:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B851154670C
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 21:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D9E3017C2D
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 19:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB3B3AE1B9;
	Thu, 14 May 2026 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJMK8A57"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0203ACEF6
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787650; cv=none; b=BUBkRiveESK/Tog2i28M/p3OWI0ITyDlNRNT5fqANoJTwn7ePc4cDcq+VyR2keHnGNzTZv/IR6MsMDcr9uqCfpQi8hvnIZxhwnu+M1TXF0fvhr1A5jx91fVmGnwvOUgurqYg9S2AOUrJbYi7/X9CpKbegnyUwjCk53WwDyUma9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787650; c=relaxed/simple;
	bh=xOwA8RaWI15R4219Kk0CCMteUWNg1lcK+YrpexseW9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jYFHanGb3aznWoZVjcHSTkgschGAYBFCDjza7E0rbCPGbhauselHTt506m7iGs9k00uQxOaZ4kikk+odRxYTb27bktJ3VT63eLYVGS9g7vkmOC6CHhA9N+Wvy3tJJ/2h0+evkpPegnkNbuCaEtOGm6SKxjCSS0O9Cn6d8dS7ZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJMK8A57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67705C2BCB3;
	Thu, 14 May 2026 19:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778787649;
	bh=xOwA8RaWI15R4219Kk0CCMteUWNg1lcK+YrpexseW9w=;
	h=From:Date:Subject:To:Cc:From;
	b=ZJMK8A57QwuRQpuyHQ4hX+tMQE3QUEqmD6B4csvsbP5xPCVl286tXl9BO4YHp+l7r
	 N4WScMHlWowWvp/PjRoA2MArKNqos/Q0SgTK9yBzvnA5cKi1dH39mH90n7ORVNHKlM
	 gAWJVuXwxWvx5ukrNXnKZGNdBWmnVoU7QFb+nBEB534OYk8RTH9eK/TgHNeC9icHxd
	 9kdiP1Ns7x0WeTWnLag6/VNRx7hI1aLgYnE8stAtP3fkHYKmskQV2kFxyqVg0b31nv
	 cgyaPq79AHySyy3HtU8SOqOUCXsGCfBAml0ZlbAmzuDPjstXSegI982qD6DaROsgdU
	 DJ1qI1ZqM0d0Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 14 May 2026 15:40:39 -0400
Subject: [PATCH] exportfs: drop unused is_export parameter from xtab_read()
 and xtab_write()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-exportd-v1-1-be603d7fac41@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MT3dSKgvyikhTd5NQkQyPjVLO0tDQjJaDqgqLUtMwKsEnRsbW1AO9
 T+IRZAAAA
X-Change-ID: 20260514-exportd-ceb123e6fff2
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3585; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xOwA8RaWI15R4219Kk0CCMteUWNg1lcK+YrpexseW9w=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqBiU8E563gaCSi07qsqhq47M2O2qccJXmd8N7g
 RjF3EN+4cOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCagYlPAAKCRAADmhBGVaC
 FVy1EACffclyviK/w0f22jx06PBOb1y4OXAvlM0Qhu/NXtX+eaAI/9b9kY5S4Hj2LLQ0xxfzrbB
 izgkzANDa6zJURMyUYCMgiXmIs4iZRlRwUwLsBBdzwwIXngOgZDHe2r5UwcEhU1dOvcQ3QdaMAd
 hE8Ljd3hbWze2qsTiCwM5F/xGLJnXC0GundGSeVlJlCJjozt5ituuZtuprlT0/qtKw17TcoDkFp
 tbwE9qXZIZrT8NTLSK2P6W7+VdIXJIGHsFGGwJoo4CtPsLZT1UZzE9VEX2DRNQ7/8XITRRx87RD
 ZaJ/QRGmxmL6EIJX9AqIGxXG0ramz1kovrJvJidPQo/NiYHNf03kdqxkK/+BiYkvk+DRWJLssbq
 42fP5YdNmZC5J30sMs3c4S7B1JyHxEvKaSamV0OEvUrJ3m3gFznK8E9mx4cKJY6858rfU991NG+
 QZsAs2voh8+PUw42bHYu32RPCgcy4LWXiEmlBojOtFh1j4oc+PZNXF7g1Hy+Av64GHYd93rL/aQ
 LOs1zfCBXwzBjGFGxHxNKuC2tLuLq2Zejad2fVlQ7nMfovKy2jBy1Ijrmn6pHZ0Rg6JH7tJcR0F
 g3IVMYFcfuNdD7fI93GNifNnZFQEWR9YIVZjgvWvDlG4d3maevCpIAFjeBwL1seKQWmgPEVbsd9
 NDibD/ElF0LiJyg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: B851154670C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21619-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The is_export parameter is always passed as 1. Remove it and simplify
both functions by eliminating the dead is_export == 0 code paths.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/xtab.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/support/export/xtab.c b/support/export/xtab.c
index 282f15bc79cd..0a9660512b26 100644
--- a/support/export/xtab.c
+++ b/support/export/xtab.c
@@ -33,11 +33,8 @@ int v4root_needed;
 static void cond_rename(char *newfile, char *oldfile);
 
 static int
-xtab_read(char *xtab, char *lockfn, int is_export)
+xtab_read(char *xtab, char *lockfn)
 {
-    /* is_export == 0  => reading /proc/fs/nfs/exports - we know these things are exported to kernel
-     * is_export == 1  => reading /var/lib/nfs/etab - these things are allowed to be exported
-     */
 	struct exportent	*xp;
 	nfs_export		*exp;
 	int			lockid;
@@ -45,11 +42,10 @@ xtab_read(char *xtab, char *lockfn, int is_export)
 	if ((lockid = xflock(lockfn, "r")) < 0)
 		return 0;
 	setexportent(xtab, "r");
-	if (is_export == 1)
-		v4root_needed = 1;
-	while ((xp = getexportent(is_export==0)) != NULL) {
-		if (!(exp = export_lookup(xp->e_hostname, xp->e_path, is_export != 1)) &&
-		    !(exp = export_create(xp, is_export!=1))) {
+	v4root_needed = 1;
+	while ((xp = getexportent(0)) != NULL) {
+		if (!(exp = export_lookup(xp->e_hostname, xp->e_path, 0)) &&
+		    !(exp = export_create(xp, 0))) {
                         if(xp->e_hostname) {
                             free(xp->e_hostname);
                             xp->e_hostname=NULL;
@@ -60,17 +56,10 @@ xtab_read(char *xtab, char *lockfn, int is_export)
                         }
 			continue;
 		}
-		switch (is_export) {
-		case 0:
-			exp->m_exported = 1;
-			break;
-		case 1:
-			exp->m_xtabent = 1;
-			exp->m_mayexport = 1;
-			if ((xp->e_flags & NFSEXP_FSID) && xp->e_fsid == 0)
-				v4root_needed = 0;
-			break;
-		}  
+		exp->m_xtabent = 1;
+		exp->m_mayexport = 1;
+		if ((xp->e_flags & NFSEXP_FSID) && xp->e_fsid == 0)
+			v4root_needed = 0;
                 if(xp->e_hostname) {
                     free(xp->e_hostname);
                     xp->e_hostname=NULL;
@@ -90,7 +79,7 @@ xtab_read(char *xtab, char *lockfn, int is_export)
 int
 xtab_export_read(void)
 {
-	return xtab_read(etab.statefn, etab.lockfn, 1);
+	return xtab_read(etab.statefn, etab.lockfn);
 }
 
 /*
@@ -100,7 +89,7 @@ xtab_export_read(void)
  * fix the auth_reload logic as well...
  */
 static int
-xtab_write(char *xtab, char *xtabtmp, char *lockfn, int is_export)
+xtab_write(char *xtab, char *xtabtmp, char *lockfn)
 {
 	struct exportent	xe;
 	nfs_export		*exp;
@@ -114,9 +103,7 @@ xtab_write(char *xtab, char *xtabtmp, char *lockfn, int is_export)
 
 	for (i = 0; i < MCL_MAXTYPES; i++) {
 		for (exp = exportlist[i].p_head; exp; exp = exp->m_next) {
-			if (is_export && !exp->m_xtabent)
-				continue;
-			if (!is_export && ! exp->m_exported)
+			if (!exp->m_xtabent)
 				continue;
 
 			/* write out the export entry using the FQDN */
@@ -137,7 +124,7 @@ xtab_write(char *xtab, char *xtabtmp, char *lockfn, int is_export)
 int
 xtab_export_write(void)
 {
-	return xtab_write(etab.statefn, etab.tmpfn, etab.lockfn, 1);
+	return xtab_write(etab.statefn, etab.tmpfn, etab.lockfn);
 }
 
 /*

---
base-commit: cbbf618b31b64198de06a350c4f5744c76e51ecb
change-id: 20260514-exportd-ceb123e6fff2

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


