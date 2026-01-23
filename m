Return-Path: <linux-nfs+bounces-18373-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDD6DM/Dc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18373-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BE579D39
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF859304069A
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C502248176;
	Fri, 23 Jan 2026 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbnLBzfq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05523182D
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194393; cv=none; b=b8f97D4MKtNGT4xYElIZDXkaf7/H4I/YSIG8pauA+e76JoFkqGFro6JjrM5TKeBr9hMlvvHcZ+BmvYLJXktrIYTBGRaDVWJkq758n4pY+tJr9fWzaIHohtywzju0chlIl+1lYJHw5+jyugzTgorQUC0RvtOhk2jeN7+h2TiQE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194393; c=relaxed/simple;
	bh=uIR/2bwrIBSScq65Fl9f2rK4MBB4DgwLWegHpEKurFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeWRgPtFfaolYbgZOir+V4HmVOepiai8lzPuaFl6j/lXzbvR0pgcqyukKK3RpfSuV0oq0K8WXsG49QaKKOhEU2h+1k/b+J05SAixe7mXyBy07eIHmxSnwZxVjcNsUie9myc6b2kTZ16DanLjz8B093ZMFUg2U1rY5j9Y3BHcHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbnLBzfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6ACC4CEF1;
	Fri, 23 Jan 2026 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194392;
	bh=uIR/2bwrIBSScq65Fl9f2rK4MBB4DgwLWegHpEKurFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbnLBzfq2wEZC6geOw6FJRkwfeW38nKFaTi0gyoJOUlY2xSu9aErMVSiAY6WZerIR
	 VOFLZv87O5wUkUGS+fGslj+ARgQV9rE3rsj7jbEu4oik/ZNzPyagv7rChvhcUBSx09
	 KDb/LNuelpac5GCrrm+/rATuU/uNDm0Gn0HIXxILUixm60fJQQniF6BBk+X/ThxDqO
	 YbYzdWWwUEQUBVDJDcuONR2rLHGltFzkeOeYU41LDldDmrMqYVTBQy1xRP0OZCDMeo
	 SYqgwfpF7tSwh3U/HgL3w6D5vLwnyb6yg5gTTmuTmzCByl1DMW6/ZeMVI1lRzKNDjD
	 l2GJq9EUglMIQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 12/42] lockd: Move nlm4svc_set_file_lock_range()
Date: Fri, 23 Jan 2026 13:52:29 -0500
Message-ID: <20260123185259.1215767-13-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18373-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2BE579D39
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: nlm4svc_set_file_lock_range() is used by both the
client-side and server-side code. Remove the "svc" from the
name and relocate the function to a generic header.

This clean up partly enables the removal of '#include "xdr4.h"'
from fs/lockd/clnt4xdr.c.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clnt4xdr.c |  2 +-
 fs/lockd/lockd.h    | 23 +++++++++++++++++++++++
 fs/lockd/xdr4.c     | 13 +------------
 fs/lockd/xdr4.h     |  1 -
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 61ee5fa6dfa4..c09e67765cac 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -287,7 +287,7 @@ static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 	fl->c.flc_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
 	p = xdr_decode_hyper(p, &l_offset);
 	xdr_decode_hyper(p, &l_len);
-	nlm4svc_set_file_lock_range(fl, l_offset, l_len);
+	lockd_set_file_lock_range4(fl, l_offset, l_len);
 	error = 0;
 out:
 	return error;
diff --git a/fs/lockd/lockd.h b/fs/lockd/lockd.h
index 3f44820974cd..c889475a74e0 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -413,6 +413,29 @@ static inline int nlm_compare_locks(const struct file_lock *fl1,
 	     &&(fl1->c.flc_type  == fl2->c.flc_type || fl2->c.flc_type == F_UNLCK);
 }
 
+/**
+ * lockd_set_file_lock_range4 - set the byte range of a file_lock
+ * @fl: file_lock whose length fields are to be initialized
+ * @off: starting offset of the lock, in bytes
+ * @len: length of the byte range, in bytes, or zero
+ *
+ * NLMv4 uses a (start, length) representation for lock byte ranges,
+ * while the kernel's file_lock uses (start, end). A length of zero
+ * means "lock to end of file."  This function handles the conversion
+ * and also treats arithmetic overflow as "lock to end of file."
+ */
+static inline void
+lockd_set_file_lock_range4(struct file_lock *fl, u64 off, u64 len)
+{
+	s64 end = off + len - 1;
+
+	fl->fl_start = off;
+	if (len == 0 || end < 0)
+		fl->fl_end = OFFSET_MAX;
+	else
+		fl->fl_end = end;
+}
+
 extern const struct lock_manager_operations nlmsvc_lock_operations;
 
 #endif /* _LOCKD_LOCKD_H */
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index f57d4881d5f1..dbbb2dfcb81b 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -34,17 +34,6 @@ loff_t_to_s64(loff_t offset)
 	return res;
 }
 
-void nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len)
-{
-	s64 end = off + len - 1;
-
-	fl->fl_start = off;
-	if (len == 0 || end < 0)
-		fl->fl_end = OFFSET_MAX;
-	else
-		fl->fl_end = end;
-}
-
 /*
  * NLM file handles are defined by specification to be a variable-length
  * XDR opaque no longer than 1024 bytes. However, this implementation
@@ -91,7 +80,7 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 
 	locks_init_lock(fl);
 	fl->c.flc_type  = F_RDLCK;
-	nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
+	lockd_set_file_lock_range4(fl, lock->lock_start, lock->lock_len);
 	return true;
 }
 
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index 7be318c0512b..4ddf51a2e0ea 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -15,7 +15,6 @@
 #define	nlm4_fbig		cpu_to_be32(NLM_FBIG)
 #define	nlm4_failed		cpu_to_be32(NLM_FAILED)
 
-void	nlm4svc_set_file_lock_range(struct file_lock *fl, u64 off, u64 len);
 bool	nlm4svc_decode_void(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
 bool	nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr);
-- 
2.52.0


