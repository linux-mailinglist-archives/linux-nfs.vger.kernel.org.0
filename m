Return-Path: <linux-nfs+bounces-22969-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wiDLJz1ZR2pYWgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22969-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 08:39:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2556D6FF228
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 08:39:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=t1tU5MnX;
	dmarc=pass (policy=quarantine) header.from=synology.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22969-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22969-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE3F9302A700
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 06:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0875359A70;
	Fri,  3 Jul 2026 06:39:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08707357D00
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jul 2026 06:39:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060747; cv=none; b=IehlGVW6VAad65i99Nv8k3rNuGu3zjPK0QGJm+Fc9A8JT+hTS8iIe1beb6CR+HBgwqkGUFHe3gSoOkvrdOVnRPKdSS4Szr4tCSPu/zZgEVNShNmdxW+bYTgYSAv6UQIdA0FsNq7dgNdttKRK/+cNS76Lx8ivLYn9eXTHoaTch/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060747; c=relaxed/simple;
	bh=WgMgDm4mqeYtfMknsMn2FR/CjQ9bwbBUkmEX1Mc2xkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Mu9GPinFPDCFqujCZwXQi2Sm4h3zXUn0k04LgEpXVf72HKI/UigCKbLFLdDtWzVchAB9DCRWVNdO2LbuD/dJ1dRrFkhEaJSHOAadRHk0T2QYrQ3wJcF5e67OYwKEaRnv7CXKJvdKj04g7VNLNwooZlKWwGJLVzphV9T06VQcB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=t1tU5MnX; arc=none smtp.client-ip=211.23.38.101
Received: from vbm-oscarou.. (unknown [10.17.211.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.synology.com (Postfix) with ESMTPSA id 4gs3xg5kd8zKRTcR5;
	Fri, 03 Jul 2026 14:39:03 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1783060743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NP6uZVwqY74LkGX4ivQ9PQByLy9G0RQ9p1AMLhs6iBU=;
	b=t1tU5MnXJ4kvqJGpYtcJEnXd+zZc1Aw2QMdnEbs7RNX4QJA1138DfnMB25VGbTJcfYJPVJ
	DJ/8WUTDHQXQe0ZvYMxKia+LWlZkTk7rkSVG9vUisN9sOqehhkVvjwKDIzVjOLC8vE4WKv
	CQutCXLYPlU7vnQ/JZV45+mChDL0wQM=
From: Oscar Ou <oscarou@synology.com>
To: cel@kernel.org,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Oscar Ou <oscarou@synology.com>
Subject: [PATCH v3] lockd: preserve multiple NLM_SHARE grants from the same owner
Date: Fri,  3 Jul 2026 14:38:56 +0800
Message-Id: <20260703063856.2423734-1-oscarou@synology.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22969-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:oscarou@synology.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,synology.com:from_mime,synology.com:email,synology.com:mid,synology.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2556D6FF228

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

NLM has no duplicate reply cache, so both SHARE and UNSHARE handlers
must be idempotent under UDP retransmit.

Track each (access, deny) pair with a single bit in a u16 bitmap.
fsh_access and fsh_mode are each in {0..3}, so there are 16 possible
pairs; index = (access << 2) | deny.  SHARE sets the bit, UNSHARE
clears it, both via idempotent bit operations.  s_access and s_mode
are recomputed as the union of the (access, deny) values whose bit
is set, and the entry is freed once s_access_deny_bmap reaches zero.

NLM_UNSHARE gains the access and deny modes as arguments so the
correct bit can be cleared.  The two callers in svcproc.c and
svc4proc.c are updated to forward the decoded values.

Signed-off-by: Oscar Ou <oscarou@synology.com>
---
Applies on top of "lockd: Regenerate NLMv4 XDR code" by Chuck Lever.

No Fixes: tag.  The fix depends on the xdrgen regeneration to reject
out-of-range fsh_access / fsh_mode on the wire, so a Fixes: tag would
mislead -stable backporters.

Changes since v2:
- Replaced the per-value refcount with a u16 bitmap indexed by
  (access << 2) | deny.  NLM has no DRC, so SHARE/UNSHARE must be
  idempotent under UDP retransmit; setting or clearing a single bit
  is idempotent, whereas incrementing and decrementing a refcount
  is not.
- Reworded subject and commit message accordingly; kept the same
  worked example and the argument addition to nlmsvc_unshare_file().

 fs/lockd/share.h    |  8 +++++++-
 fs/lockd/svc4proc.c |  4 +++-
 fs/lockd/svcproc.c  |  4 +++-
 fs/lockd/svcshare.c | 36 +++++++++++++++++++++++++++++++-----
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/fs/lockd/share.h b/fs/lockd/share.h
index 1ec3ccdb2aef..a12b6c454f58 100644
--- a/fs/lockd/share.h
+++ b/fs/lockd/share.h
@@ -8,9 +8,14 @@
 #ifndef _LOCKD_SHARE_H
 #define _LOCKD_SHARE_H
 
+#include <linux/bits.h>
+
 /* Synthetic svid for lockowner lookup during share operations */
 #define LOCKD_SHARE_SVID	(~(u32)0)
 
+/* One bit per (access, deny) pair; index = (access << 2) | deny */
+#define LOCKD_FSH_BIT(a, d)	BIT(((a) << 2) | (d))
+
 /*
  * DOS share for a specific file
  */
@@ -21,12 +26,13 @@ struct lockd_share {
 	struct xdr_netobj	s_owner;	/* owner handle */
 	u32			s_access;	/* access mode */
 	u32			s_mode;		/* deny mode */
+	u16			s_access_deny_bmap;	/* held (access, deny) pairs */
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
index 5ac0ec25d62d..a58b7035b58b 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -25,6 +25,25 @@ nlm_cmp_owner(struct lockd_share *share, struct xdr_netobj *oh)
 	    && !memcmp(share->s_owner.data, oh->data, oh->len);
 }
 
+/*
+ * Recompute s_access / s_mode as the union of every (access, deny) pair
+ * whose bit is currently set in s_access_deny_bmap.
+ */
+static void nlm_recompute_share(struct lockd_share *share)
+{
+	u32 new_access = 0, new_mode = 0;
+	unsigned int i;
+
+	for (i = 0; i < 16; i++) {
+		if (share->s_access_deny_bmap & BIT(i)) {
+			new_access |= i >> 2;
+			new_mode   |= i & 3;
+		}
+	}
+	share->s_access = new_access;
+	share->s_mode = new_mode;
+}
+
 /**
  * nlmsvc_share_file - create a share
  * @host: Network client peer
@@ -64,12 +83,13 @@ nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
 	share->s_host       = host;
 	share->s_owner.data = ohdata;
 	share->s_owner.len  = oh->len;
+	share->s_access_deny_bmap  = 0;
 	share->s_next       = file->f_shares;
 	file->f_shares      = share;
 
 update:
-	share->s_access = access;
-	share->s_mode = mode;
+	share->s_access_deny_bmap |= LOCKD_FSH_BIT(access, mode);
+	nlm_recompute_share(share);
 	return nlm_granted;
 }
 
@@ -78,12 +98,14 @@ nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
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
 
@@ -93,8 +115,12 @@ nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
 	for (shpp = &file->f_shares; (share = *shpp) != NULL;
 					shpp = &share->s_next) {
 		if (share->s_host == host && nlm_cmp_owner(share, oh)) {
-			*shpp = share->s_next;
-			kfree(share);
+			share->s_access_deny_bmap &= ~LOCKD_FSH_BIT(access, mode);
+			nlm_recompute_share(share);
+			if (!share->s_access_deny_bmap) {
+				*shpp = share->s_next;
+				kfree(share);
+			}
 			return nlm_granted;
 		}
 	}
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

