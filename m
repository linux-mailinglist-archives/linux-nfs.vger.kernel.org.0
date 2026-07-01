Return-Path: <linux-nfs+bounces-22903-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0nTLHSulRGqWyQoAu9opvQ
	(envelope-from <linux-nfs+bounces-22903-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 07:27:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7A96E9D7E
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 07:27:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=K+zA1I5H;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22903-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22903-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=synology.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80B843028B1A
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 05:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2FF363081;
	Wed,  1 Jul 2026 05:27:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7F28504D
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jul 2026 05:27:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782883624; cv=none; b=H5P75F28BRPd+fRenTAqdayQLLs6lL+/AhC6q8ihxqyrQTS8T6GZ4sL3hyUsz7XupfTY1qGT8xdQg7RZsP91oCW1nnCBxgfXoMtgD0XbeLSL0jNrxHop3aZ6Na8xpv1xYwRwWcl7SsWGUhpGQAkieSI37Le3tZZT/RhdengO2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782883624; c=relaxed/simple;
	bh=CH+91z2l363PpCAf6OQY1pPqirG6umsDEx2xyK5i8Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rweq7wIwTDIG6M44KHqQYoK6mXcJ0187OubB5TYdL8kExj5Q3jQx65nLRaja29wbaqgPtNhKVvEjkb9sEsHkbacGKprdvxfZpRQLVmdzfGOrAHBdRj0Rby9tWxHXk1knZQHgCnz9bQNFtj/iL2MeTscr1JK/rv+OKlBrmNLWodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=K+zA1I5H; arc=none smtp.client-ip=211.23.38.101
Received: from vbm-oscarou.. (unknown [10.17.211.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.synology.com (Postfix) with ESMTPSA id 4gqpRS1Vw5zKP7XWM;
	Wed, 01 Jul 2026 13:27:00 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1782883620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZya2k8bPd/8VNgDFuYCUFC7ZX0vhDTT1XrLCj2Oclg=;
	b=K+zA1I5H2IlpOuZSGuOjErLPsgaTLmRj8l/BaR9dk2nf8qcxGAC9tOa5O2W4qLQylSRHiA
	sP+pl/Gg0izUac0sobVl9g2riimv2c8lrpRXcCgYt6xpCNSrU1IXUwZ+G95dyV3ah3fr/E
	q/mS8YitWAxAD72C8mwtfaH/brdB+QU=
From: Oscar Ou <oscarou@synology.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Oscar Ou <oscarou@synology.com>
Subject: [PATCH v2] lockd: refcount NLM_SHARE access/deny modes
Date: Wed,  1 Jul 2026 13:26:45 +0800
Message-Id: <20260701052645.2213483-1-oscarou@synology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630093820.2162344-1-oscarou@synology.com>
References: <20260630093820.2162344-1-oscarou@synology.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Auth: pass
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22903-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:oscarou@synology.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[oscarou@synology.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscarou@synology.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synology.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synology.com:dkim,synology.com:email,synology.com:mid,synology.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE7A96E9D7E

When an NFSv3/NLM client issues multiple NLM_SHARE calls from a single
host for the same (file, owner) tuple, the current implementation
overwrites the recorded access and deny modes with the latest pair.
A subsequent NLM_UNSHARE then drops the entire entry, even if other
grants were implicitly subsumed by the most recent SHARE.  This is
particularly visible to Windows-style clients that map each open of
a file to a distinct NLM_SHARE, all carrying the same NLM owner
handle.  For example:

    1. SHARE(access=RW, deny=W)   -> entry [RW, deny W]
    2. SHARE(access=R,  deny=N)   -> entry [R, deny N]   (RW/W overwritten)
    3. UNSHARE(access=R, deny=N)  -> entry freed
    4. UNSHARE(access=RW, deny=W) -> nothing to release

Track each of the four valid fsh_access and fsh_mode values with a
small per-value refcount.  On SHARE the appropriate buckets are
incremented; on UNSHARE they are decremented.  s_access / s_mode
are recomputed in both paths as the union of all positive buckets
with a non-NONE / non-DN value (indices 1..3), and the entry is
freed once s_access and s_mode are both zero.

NLM_UNSHARE gains the access and deny modes as arguments so the
correct buckets can be decremented.  The two callers in svcproc.c
and svc4proc.c are updated to forward the decoded values.

Signed-off-by: Oscar Ou <oscarou@synology.com>
---
Applies on top of "lockd: Regenerate NLMv4 XDR code" by Chuck Lever.

No Fixes: tag.  The fix depends mechanically on the xdrgen
regeneration, so a Fixes: tag would mislead -stable backporters.
Happy to add one plus an informal Depends-on: line if preferred.

Changes since v1:
- Reworded the "buckets" sentence in the commit message: the entry is
  freed once s_access and s_mode are both zero, not when every bucket
  has reached zero.  Index 0 (fsa_NONE / fsm_DN) contributes no bits
  to the union and does not gate freeing.
- Dropped the incorrect claim that per-file f_mutex serialises the
  new arrays, from both the commit message and the comment on
  nlm_recompute_share().  f_mutex is released by nlm_lookup_file()
  before the share helpers run.

 fs/lockd/share.h    |  6 +++++-
 fs/lockd/svc4proc.c |  4 +++-
 fs/lockd/svcproc.c  |  4 +++-
 fs/lockd/svcshare.c | 40 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/lockd/share.h b/fs/lockd/share.h
index 1ec3ccdb2aef..3b414774c5b3 100644
--- a/fs/lockd/share.h
+++ b/fs/lockd/share.h
@@ -11,6 +11,8 @@
 /* Synthetic svid for lockowner lookup during share operations */
 #define LOCKD_SHARE_SVID	(~(u32)0)
 
+#define LOCKD_FSH_NR		4	/* fsh_access / fsh_mode are in {0..3} */
+
 /*
  * DOS share for a specific file
  */
@@ -21,12 +23,14 @@ struct lockd_share {
 	struct xdr_netobj	s_owner;	/* owner handle */
 	u32			s_access;	/* access mode */
 	u32			s_mode;		/* deny mode */
+	u32			s_access_counts[LOCKD_FSH_NR];
+	u32			s_mode_counts[LOCKD_FSH_NR];
 };
 
 __be32	nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
 			  struct xdr_netobj *oh, u32 access, u32 mode);
 __be32	nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
-			    struct xdr_netobj *oh);
+			    struct xdr_netobj *oh, u32 access, u32 mode);
 void	nlmsvc_traverse_shares(struct nlm_host *, struct nlm_file *,
 					       nlm_host_match_fn_t);
 
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 78e675470c4b..49ae487e3390 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1078,7 +1078,9 @@ static __be32 nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 	if (resp->xdrgen.stat)
 		goto out;
 
-	resp->xdrgen.stat = nlmsvc_unshare_file(host, file, &lock->oh);
+	resp->xdrgen.stat = nlmsvc_unshare_file(host, file, &lock->oh,
+						argp->xdrgen.share.access,
+						argp->xdrgen.share.mode);
 
 	nlmsvc_release_lockowner(lock);
 
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 4836887f11ef..54845e52d31e 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -1097,7 +1097,9 @@ static __be32 nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 	if (resp->xdrgen.stat)
 		goto out;
 
-	resp->xdrgen.stat = nlmsvc_unshare_file(host, file, &lock->oh);
+	resp->xdrgen.stat = nlmsvc_unshare_file(host, file, &lock->oh,
+						argp->xdrgen.share.access,
+						argp->xdrgen.share.mode);
 
 	nlmsvc_release_lockowner(lock);
 
diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
index 5ac0ec25d62d..b7372094d397 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -25,6 +25,24 @@ nlm_cmp_owner(struct lockd_share *share, struct xdr_netobj *oh)
 	    && !memcmp(share->s_owner.data, oh->data, oh->len);
 }
 
+/*
+ * Recompute s_access / s_mode as the union of all positive refcount
+ * buckets.
+ */
+static void nlm_recompute_share(struct lockd_share *share)
+{
+	u32 new_access = 0, new_mode = 0, v;
+
+	for (v = 1; v < LOCKD_FSH_NR; v++) {
+		if (share->s_access_counts[v])
+			new_access |= v;
+		if (share->s_mode_counts[v])
+			new_mode |= v;
+	}
+	share->s_access = new_access;
+	share->s_mode = new_mode;
+}
+
 /**
  * nlmsvc_share_file - create a share
  * @host: Network client peer
@@ -64,12 +82,15 @@ nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
 	share->s_host       = host;
 	share->s_owner.data = ohdata;
 	share->s_owner.len  = oh->len;
+	memset(share->s_access_counts, 0, sizeof(share->s_access_counts));
+	memset(share->s_mode_counts, 0, sizeof(share->s_mode_counts));
 	share->s_next       = file->f_shares;
 	file->f_shares      = share;
 
 update:
-	share->s_access = access;
-	share->s_mode = mode;
+	share->s_access_counts[access]++;
+	share->s_mode_counts[mode]++;
+	nlm_recompute_share(share);
 	return nlm_granted;
 }
 
@@ -78,12 +99,14 @@ nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
  * @host: Network client peer
  * @file: File to be unshared
  * @oh: Share owner handle
+ * @access: Access mode of the SHARE being released
+ * @mode: Deny mode of the SHARE being released
  *
  * Returns an NLM status code.
  */
 __be32
 nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
-		    struct xdr_netobj *oh)
+		    struct xdr_netobj *oh, u32 access, u32 mode)
 {
 	struct lockd_share	*share, **shpp;
 
@@ -93,8 +116,15 @@ nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
 	for (shpp = &file->f_shares; (share = *shpp) != NULL;
 					shpp = &share->s_next) {
 		if (share->s_host == host && nlm_cmp_owner(share, oh)) {
-			*shpp = share->s_next;
-			kfree(share);
+			if (share->s_access_counts[access])
+				share->s_access_counts[access]--;
+			if (share->s_mode_counts[mode])
+				share->s_mode_counts[mode]--;
+			nlm_recompute_share(share);
+			if (!share->s_access && !share->s_mode) {
+				*shpp = share->s_next;
+				kfree(share);
+			}
 			return nlm_granted;
 		}
 	}
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

