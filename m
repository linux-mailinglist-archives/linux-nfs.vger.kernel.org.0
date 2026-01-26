Return-Path: <linux-nfs+bounces-18496-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJj/AcjGd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18496-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 999E98CCE3
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6964D301C5B5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4500A288C96;
	Mon, 26 Jan 2026 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2oN73jh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B35288C81
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457341; cv=none; b=J52AqvuD6xWEMqIv3gqN+4gMPQ7Ug/BounjSBrsRXdHDu9Wo1FZ4CJE55s5SR9hVBwR/V7McvRyITJRkZ2oyHi000tBjZdoFpsRspT6tIK7i+T9NELpoYyKLxAzMGfTiyFzDtEmZ7YRk0FKt0Pj7btZCEgzvPf00WGw5DixtFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457341; c=relaxed/simple;
	bh=NzTsWtYe8RGfAPWhJ5PZSQurQJyQYmrC2ZFg/YEvsnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ts0S8iM3SN+61AIbHsEGIz6szNAl56av31m6fXHxasqPn824U79ljNSef7JJoxOnDOacsTNxM16XXxOd8BkQNL7cp6KULuxqmYEXVwiyxeeCwHgYBhyREa7xTQPnOx0ur4tU9BPyrO5m87uDnNcEWN2R2IOU2O9z+aU39lOZ5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2oN73jh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D020C19422;
	Mon, 26 Jan 2026 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457340;
	bh=NzTsWtYe8RGfAPWhJ5PZSQurQJyQYmrC2ZFg/YEvsnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2oN73jhiuvPT0XonKqA3AytAm7cGyNkybXaPOoeqSASNAc5Xdg/JsUavOh/kDSuT
	 4ogkZ2EiBUQw1RcjoccIY5zGGcTa2QbGyu4ZZ83qT/9e6t74H0Ip3Erd1EOzo9k9Cm
	 Nz1HIE9ulz3Acm3VbkcUEt3gpKHOSJUhSL0h9sgw9uj525Y0yZ18+gWm2N3l2WfyaK
	 uIY5AbvOh1Y6XKK8+ZfLqKPANGauNUM9ftydirJ4fG4oZgrPbanq2x7Aoq9hUvHNLI
	 4jLfIy1acJHyFYjVzaTCfkP4cS8Qfdj+uN9wAAY+78J43Aw7SJA9MYK/ipClUJLFXv
	 utHu6M14dazAw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 03/14] lockd: Introduce nlm__int__deadlock
Date: Mon, 26 Jan 2026 14:55:24 -0500
Message-ID: <20260126195535.154697-4-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18496-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 999E98CCE3
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The use of CONFIG_LOCKD_V4 in combination with a later cast_status()
in the NLMv3 code is difficult to reason about. Instead, replace the
use of nlm_deadlock with an implementation-defined status value that
version-specific code translates appropriately.

The new approach establishes a translation boundary: generic lockd
code returns nlm__int__deadlock when posix_lock_file() yields
-EDEADLK. Version-specific handlers (svc4proc.c for NLMv4,
svcproc.c for NLMv3) translate this internal status to the
appropriate wire protocol value. NLMv4 maps to nlm4_deadlock;
NLMv3 maps to nlm_lck_denied (since NLMv3 lacks a deadlock-specific
status code).

Later this modification will also remove the need to include NLMv4
headers in NLMv3 and generic code.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c         | 10 ++++++++--
 fs/lockd/svclock.c          |  8 +-------
 fs/lockd/svcproc.c          |  4 +++-
 include/linux/lockd/lockd.h |  1 +
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 9c756d07223a..55b6dcc56db1 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -148,10 +148,16 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
 					argp->block, &argp->cookie,
 					argp->reclaim);
-	if (resp->status == nlm__int__drop_reply)
+	switch (resp->status) {
+	case nlm__int__drop_reply:
 		rc = rpc_drop_reply;
-	else
+		break;
+	case nlm__int__deadlock:
+		resp->status = nlm4_deadlock;
+		fallthrough;
+	default:
 		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
+	}
 
 	nlmsvc_release_lockowner(&argp->lock);
 	nlmsvc_release_host(host);
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 83b6dd243bcd..b08bbd3ee753 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -33,12 +33,6 @@
 
 #define NLMDBG_FACILITY		NLMDBG_SVCLOCK
 
-#ifdef CONFIG_LOCKD_V4
-#define nlm_deadlock	nlm4_deadlock
-#else
-#define nlm_deadlock	nlm_lck_denied
-#endif
-
 static void nlmsvc_release_block(struct nlm_block *block);
 static void	nlmsvc_insert_block(struct nlm_block *block, unsigned long);
 static void	nlmsvc_remove_block(struct nlm_block *block);
@@ -589,7 +583,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			goto out;
 		case -EDEADLK:
 			nlmsvc_remove_block(block);
-			ret = nlm_deadlock;
+			ret = nlm__int__deadlock;
 			goto out;
 		default:			/* includes ENOLCK */
 			nlmsvc_remove_block(block);
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 2a2e48a9bd12..27ed71935e45 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -27,7 +27,7 @@ static inline __be32 cast_status(__be32 status)
 	case nlm_lck_denied_grace_period:
 	case nlm__int__drop_reply:
 		break;
-	case nlm4_deadlock:
+	case nlm__int__deadlock:
 		status = nlm_lck_denied;
 		break;
 	default:
@@ -39,6 +39,8 @@ static inline __be32 cast_status(__be32 status)
 #else
 static inline __be32 cast_status(__be32 status)
 {
+	if (status == nlm__int__deadlock)
+		status = nlm_lck_denied;
 	return status;
 }
 #endif
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index fdefec39553f..793691912137 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -43,6 +43,7 @@
  * Version handlers translate these to appropriate wire values.
  */
 #define nlm__int__drop_reply	cpu_to_be32(30000)
+#define nlm__int__deadlock	cpu_to_be32(30001)
 
 /*
  * Lockd host handle (used both by the client and server personality).
-- 
2.52.0


