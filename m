Return-Path: <linux-nfs+bounces-20517-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAqBL1l/ymmR9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20517-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:49:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9F35C4BB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2C093099699
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D57F3D5223;
	Mon, 30 Mar 2026 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ulmsqrhr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FF23D5221
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877925; cv=none; b=jqZ4nRaNRa0BH5VkJAJnWqW+5/jikCbGb0juEzKlyByYMIzKp5Km5tJWWS1ecKAHWXpOFOQX1xUTSwHv7E0JPqOVx2gcyGWSte3CIyszl9RrAjAvvaCqnfIAH72rbwclARfRnaCFjl6xXxTEzaYJJ/AFIBTRWs4QDjn+YNv2cIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877925; c=relaxed/simple;
	bh=cZU40Ci65u926oZLO4k96TjI0rXRL98e9XlDPUbdS50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nun5TLrd9/SNFrXZcvF+5Ld6HocM6ue1iTE4LFfjJq2hqaRWBdU8kl9jzuC95/NR9w+gC4dhOPyFeNQwpFhSMrV5v6w1EHAek5wb1Wn+1qpqnw2VtZYq59C3HB7+rhGuKsKlZLB+ozJhl4GuH5pyeylyBUcrPjeppy/ijWraeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ulmsqrhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC15C4CEF7;
	Mon, 30 Mar 2026 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877925;
	bh=cZU40Ci65u926oZLO4k96TjI0rXRL98e9XlDPUbdS50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ulmsqrhrfyz5/FsPJWtg0jnvHoMtFh01MmoLUK3YeuX3mE2XMfTraKqKk8voMA7pe
	 d2eGR1qx9gaZZn/gVTFttjc8NmwTfHK8qxAmNowscNVQR1SA+1dSQLp+GTEOTZB8/9
	 sSjkaaJRORR3LwdTZF0OsJYjkD8Slu5nT49Ie5HZe6VYoomzbNIwg4r5Qljq+ZftG7
	 dUWMkrtNd5+VvNv3w5/aXV1zRm19LKFZ5LO/Bt1iNeyo9mH5PQxNhhB0sVLj7oSF6h
	 YzarGNJ46kUzzPEn5y5DW3V2S1p4iznmdGh0gpnoJKEia6VCJUVh94qRodW5YG3KCK
	 /gfWG6HIE3wyg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:22 -0400
Subject: [PATCH nfs-utils v2 02/16] support/export: remove unnecessary
 static variables in nfsd_fh expkey lookup
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-2-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cZU40Ci65u926oZLO4k96TjI0rXRL98e9XlDPUbdS50=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzeyzPlRBxc+KZIakeW2/cfz4h6cc5RHlh7h
 gUqZiOB+52JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp83gAKCRAADmhBGVaC
 FZMTD/0RZyI4RwhP0AnQm2yZ+gBD9j9HYgvTqSOvxgC0nyMmLDSixIwuCcmikdS9uiipg0L2B+H
 IF7Lq8LUFPDJzPbdxqEyOJN/WYYbmiKWHgXkHSDHM8lG7pi1uIgbfWQzyFXhTwHM6KzFHjv+vD1
 ih9TCDn97YrWh9bppOTA2yK/4cz2Se0kKH40juAOTB6uPL1BKlWtejXBjWd/5wfchMkgutK2TPV
 +2VwycffhMxNiOSDAN9lH/0vHEuzWqLpk4CPawrgpEqNQ1dGbjIQIsKqk8NegyRzfqb8Nf+pZV9
 0AaGVwrT/cCykJT4F1leVYWb3FEh6VBp+o80mkNZxYz2R1aZ82i8BePYzyTnNk07LnFYFlJGVb4
 cB0ts8JiAxUmKpdcwi0NiS05KbWz2ESf6HHpN+rIkOSMjkmZqaFAHkkA1M5uIgZQWBIT+nwE+uM
 YIiC4mO59Wu1UMSOVhHKqhyNiMxnQvHJbxXPbBpUisIzDOT+SGm0jQZgez67asjwUXueSaTnbhb
 Jp1GGLiUS2gNb8ofHqsypB8pEhg8HFWdSaBMwSnP4SKm0DHVq9o9MvkytdsGYNhoI68mhddod1E
 6Hl8tXsmB0rpa5gtFF3lGhRCx8FWeneqVWKSHHPdbcMrztIbqsVIYA+TQUDMsgGxAIvQxpPkjBE
 Cw+mo++2EKsGDNw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20517-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39B9F35C4BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The prev and mnt variables in the CROSSMOUNT submount iteration loop
only need to persist across iterations of the inner for loop, not
across calls to the function. Convert them from static to local
variables scoped to the outer for loop.
---
 support/export/cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 6859a55b7ae5c132255b756052c6ddd1734173f0..c052455889481f04631e4ef0e16cd48bc6c11964 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -810,7 +810,10 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
 
 	/* Now determine export point for this fsid/domain */
 	for (i=0 ; i < MCL_MAXTYPES; i++) {
+		nfs_export *prev = NULL;
 		nfs_export *next_exp;
+		void *mnt = NULL;
+
 		for (exp = exportlist[i].p_head; exp; exp = next_exp) {
 			char *path;
 
@@ -820,9 +823,6 @@ static int nfsd_handle_fh(int f, char *bp, int blen)
 			}
 
 			if (exp->m_export.e_flags & NFSEXP_CROSSMOUNT) {
-				static nfs_export *prev = NULL;
-				static void *mnt = NULL;
-				
 				if (prev == exp) {
 					/* try a submount */
 					path = next_mnt(&mnt, exp->m_export.e_path);

-- 
2.53.0


