Return-Path: <linux-nfs+bounces-22885-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TJF+N66QQ2qpcAoAu9opvQ
	(envelope-from <linux-nfs+bounces-22885-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 11:47:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816FF6E26A0
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 11:47:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=synology.com header.s=123 header.b=cxlO59pp;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22885-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22885-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=synology.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0F71303BDF2
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994452D73B9;
	Tue, 30 Jun 2026 09:39:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE82B37F8C6
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 09:39:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812357; cv=none; b=RzrbY3FWKKigMDd9XekViL5lIYnAYmlm4Yo2U8ekt2BTpxKo4cvj0qcIKaJpO1xNFkFtf9FmcV0hv80cnWZLUOi3yBLXPfuMlJh0W8GYbG2NKdNgeGm8EHKBG9/I4kfAzAajPGue3eOLLSpLI6QtxPe1IZit/GVzIGIeCOeA8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812357; c=relaxed/simple;
	bh=DmochjmHEtiC9ToNcxkx7Ruy4fGiLmy9DHiPBXNSG1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rCNBHTlEPeq1V+9Xj21sQScVYeMbuiEY7bG1UNiKk+NGPxjiPuzqW5lfM0NcyQFeq/BShN2Xb+PJGtnC37XdC30ip6+f+SnijNj2Kq4zr0zlwJF/GrxH4Rdus5b2N90lOG5QrtRC297Ew1gPI+NHcb4nfrYyECOWYJnmyUg8wqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=cxlO59pp; arc=none smtp.client-ip=211.23.38.101
Received: from vbm-oscarou.. (unknown [10.17.211.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.synology.com (Postfix) with ESMTPSA id 4gqJ4q1v9jzKND4gf;
	Tue, 30 Jun 2026 17:39:07 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synology.com;
	s=123; t=1782812347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nXfyYsO/jbkYECyIFS4Ec3CG8ZLpSM0E9EisGnkg9Ks=;
	b=cxlO59ppXt/vqp2WEaLs4sIVYsMAN4hx8jmXmBZyYzZFEGRnxLrMqGOYbSlbx6wz7/MZVL
	B6QyNA/52BwIEuD95K8fM38es5DMXDCHiq+2oTRCe5pfKjWu5dMZgAutYa55AARqT/G1sX
	svchbuVSXXk+tcpTFz02Tkg8tGPuNB0=
From: Oscar Ou <oscarou@synology.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Oscar Ou <oscarou@synology.com>
Subject: [PATCH] lockd: refcount NLM_SHARE access/deny modes
Date: Tue, 30 Jun 2026 17:38:20 +0800
Message-Id: <20260630093820.2162344-1-oscarou@synology.com>
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
	DMARC_POLICY_ALLOW(-0.50)[synology.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[synology.com:s=123];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:oscarou@synology.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22885-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[oscarou@synology.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscarou@synology.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[synology.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 816FF6E26A0

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
are recomputed in both paths as the union of all positive buckets,
and the entry is freed only when every bucket has reached zero.

NLM_UNSHARE gains the access and deny modes as arguments so the
correct buckets can be decremented.  The two callers in svcproc.c
and svc4proc.c are updated to forward the decoded values.

The per-file f_mutex held by callers in fs/lockd/svcsubs.c continues
to serialise share manipulation, so the new arrays do not require
their own locking.

Signed-off-by: Oscar Ou <oscarou@synology.com>
---
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
index 5ac0ec25d62d..4a1a09c209ea 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -25,6 +25,24 @@ nlm_cmp_owner(struct lockd_share *share, struct xdr_netobj *oh)
 	    && !memcmp(share->s_owner.data, oh->data, oh->len);
 }
 
+/*
+ * Recompute s_access / s_mode as the union of all positive refcount
+ * buckets.  Caller must hold the per-file f_mutex.
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

