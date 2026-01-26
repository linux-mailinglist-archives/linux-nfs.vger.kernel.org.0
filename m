Return-Path: <linux-nfs+bounces-18506-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJH/M+DGd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18506-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:56:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 749058CD2B
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55703303E485
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE128BAB9;
	Mon, 26 Jan 2026 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM2iK4WI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06AC288C81
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457348; cv=none; b=OOp1d09yfY/Zd/5mGZO9KnCDLrIj9ImvbVzrMEradEDS2om+3Lw3+zt90d53srk0AAli6C0JLeCZrfdXkzp4xEd2+jQGNlU4uFdI9n5i1rw94eexrIoCUTW+eItA/uOUk54CLyozR8GwM7EzlS6GIPrYja0Vt4Xsx95PEyH3+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457348; c=relaxed/simple;
	bh=Ad8FsgEpD1m/K+VE1Lx0dz8EuBwymdZcOfhV8U02i50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLJwZ/RUAsPrdQ0QhkASxh9ecUtjdeExws40WqhndEg5zkGY4IkJaWE1MvIPvSZcPlqlDaM3QTJPCC9nxa+q7fQ16Xeksv5BsHd1wdOBQSQj0fYEkAugQK7KIWu7wlKOIPR1Q4dq99D/uDpA0UCb3zLZ393MRxJdCI+E7FeULjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM2iK4WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D495C116C6;
	Mon, 26 Jan 2026 19:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457348;
	bh=Ad8FsgEpD1m/K+VE1Lx0dz8EuBwymdZcOfhV8U02i50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eM2iK4WIELpnllTGZsfKR8yVLWZSmY1lL6ZxkGdN8UxVS2Trj1g5ROua6JW0Hv7jM
	 QZqwxvWFoLKOhqKG3HkywoavRa1YcG6d9LRUxBQ80ZdthFMYW+zTpq2HbDOJS7cJyC
	 FqXw8GgWKinSvReyuTrSGJvIwg8jHQn7c5h4vpLnWgUFbn4GyHmy+wdY/im62WWBDQ
	 MdYzHsayvWSHuCAYyHYSpcPBxaV9+ri/UBf3sZcDR+YiVieqDD4L7haCSsMbS3RVSv
	 J+6T1Wy80cPb8UQzsw7eN+m/xHUvbXtdWSk3pAPtCxhmuhOTQyY5BoGfs9niPDzUxZ
	 UeCkwq4yGBoFg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 13/14] lockd: Move nlm4svc_set_file_lock_range()
Date: Mon, 26 Jan 2026 14:55:34 -0500
Message-ID: <20260126195535.154697-14-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126195535.154697-1-cel@kernel.org>
References: <20260126195535.154697-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18506-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 749058CD2B
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Both client-side and server-side NLMv4 code convert lock byte ranges
from the wire format (start, length) to the kernel's file_lock format
(start, end). The current nlm4svc_set_file_lock_range() performs this
conversion, but the "svc" prefix incorrectly suggests server-only use,
and client code must include server-internal headers to access it.

Rename to lockd_set_file_lock_range4() and relocate to the shared
lockd.h header, making it accessible to both client and server code.
This eliminates the need for client code to include xdr4.h, reducing
coupling between the XDR implementation files.

While relocating the function, add input validation: clamp the
starting offset to OFFSET_MAX before use. Without this, a malformed
lock request with off > OFFSET_MAX results in fl_start > fl_end,
violating file_lock invariants and potentially causing incorrect
lock conflict detection.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/clnt4xdr.c |  2 +-
 fs/lockd/lockd.h    | 25 +++++++++++++++++++++++++
 fs/lockd/xdr4.c     | 13 +------------
 fs/lockd/xdr4.h     |  1 -
 4 files changed, 27 insertions(+), 14 deletions(-)

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
index e73c6b348154..ef6431b4cac0 100644
--- a/fs/lockd/lockd.h
+++ b/fs/lockd/lockd.h
@@ -413,6 +413,31 @@ static inline int nlm_compare_locks(const struct file_lock *fl1,
 	     &&(fl1->c.flc_type  == fl2->c.flc_type || fl2->c.flc_type == F_UNLCK);
 }
 
+/**
+ * lockd_set_file_lock_range4 - set the byte range of a file_lock
+ * @fl: file_lock whose length fields are to be initialized
+ * @off: starting offset of the lock, in bytes
+ * @len: length of the byte range, in bytes, or zero
+ *
+ * The NLMv4 protocol represents lock byte ranges as (start, length),
+ * where length zero means "lock to end of file." The kernel's file_lock
+ * structure uses (start, end) representation. Convert from NLMv4 format
+ * to file_lock format, clamping the starting offset and treating
+ * arithmetic overflow as "lock to EOF."
+ */
+static inline void
+lockd_set_file_lock_range4(struct file_lock *fl, u64 off, u64 len)
+{
+	u64 clamped_off = (off > OFFSET_MAX) ? OFFSET_MAX : off;
+	s64 end = clamped_off + len - 1;
+
+	fl->fl_start = clamped_off;
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


