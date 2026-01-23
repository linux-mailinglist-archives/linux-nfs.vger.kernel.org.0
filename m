Return-Path: <linux-nfs+bounces-18363-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NJdGK3Dc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18363-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90C79CBA
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9444A300B289
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9902BE63F;
	Fri, 23 Jan 2026 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwvX5904"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE193EBF0D
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194385; cv=none; b=tNw9pLi9gG2vQSB6jm3WLn2vSFHI70DNQDJl1iP8PaDA0T/H+HqrT22TmkmM6F591YUUk98qaZZdzkyqVdHz7QgcGNypSiFaKm8f7gN7GtIkuaCZyYksHxmBVKLThFN8NF8J1okmUjgUrDa9GkZbuS+uGubw+LcB2/Sln7V5/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194385; c=relaxed/simple;
	bh=OzYnMAZMcz4Y2AJycyGMYjk8jkIT2eO3e5UyTMZHdYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wn2PNyK3406uwRB7CTR1bapQUT5rjhlUFTPPiQjmdLsJ03l01MHqhuuAcGzbB3wcp8Ti47Bg4Cy28YbFH/x2pjs22itbouS69d3DMgBD3Om3rBmTWCSTSMv4WL/YuSzU+nZ7LRMmC/SQYqH9JnC/XFHOo0UGvwjj0WFg1ITaMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwvX5904; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9DDC4CEF1;
	Fri, 23 Jan 2026 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194384;
	bh=OzYnMAZMcz4Y2AJycyGMYjk8jkIT2eO3e5UyTMZHdYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwvX59045WVI+YNAthPw3WUHF+95OnKpJvyBQS1XNUF1XMI5zon2R5blp57Crjp+t
	 x1SyAxgVxu16t7ceQTjN7YOf9BMUjjakjrDaWN7rPr9sepCuEw820SAeA98Au3PW7X
	 cOH8NiOz1lZ6/SUKZZtVn5TT3TDY0S4uuU+Ea2VZMbtnYnHMOHyKIIekCoBo8GRbu4
	 zdCegTBQSOoSax0cpXIuKzQoGL5C3MPtDwvnoBsJVEax807odYBI49LF9WRqnPfgFf
	 dT8SE9DYPdnGEoc+0+AgVWIPcf2AdF8/ZZZDjDv1z6kISPZNO0/sMNUJMzB+4/eb9K
	 zO5Ehy3p6krZg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 02/42] lockd: Introduce nlm__int__deadlock
Date: Fri, 23 Jan 2026 13:52:19 -0500
Message-ID: <20260123185259.1215767-3-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18363-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B90C79CBA
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c         | 10 ++++++++--
 fs/lockd/svclock.c          |  8 +-------
 fs/lockd/svcproc.c          |  4 +++-
 include/linux/lockd/lockd.h |  7 +++++++
 include/linux/lockd/xdr.h   |  2 --
 5 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4b6f18d97734..061686b36b38 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -146,10 +146,16 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
 					argp->block, &argp->cookie,
 					argp->reclaim);
-	if (resp->status == nlm_drop_reply)
+	switch (resp->status) {
+	case nlm_drop_reply:
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
index 712df1e025d8..e80e3b4ee689 100644
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
index 95c6bf7ab757..3e890534c3dc 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -27,7 +27,7 @@ static inline __be32 cast_status(__be32 status)
 	case nlm_lck_denied_grace_period:
 	case nlm_drop_reply:
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
index 330e38776bb2..36a744f212ca 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -38,6 +38,13 @@
  */
 #define LOCKD_DFLT_TIMEO	10
 
+/*
+ * Internal-use status codes, not to be placed on the wire.
+ * Version handlers translate these to appropriate wire values.
+ */
+#define nlm_drop_reply		cpu_to_be32(30000)
+#define nlm__int__deadlock	cpu_to_be32(30001)
+
 /*
  * Lockd host handle (used both by the client and server personality).
  */
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 17d53165d9f2..292e4e38d17d 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -33,8 +33,6 @@ struct svc_rqst;
 #define	nlm_lck_blocked		cpu_to_be32(NLM_LCK_BLOCKED)
 #define	nlm_lck_denied_grace_period	cpu_to_be32(NLM_LCK_DENIED_GRACE_PERIOD)
 
-#define nlm_drop_reply		cpu_to_be32(30000)
-
 /* Lock info passed via NLM */
 struct nlm_lock {
 	char *			caller;
-- 
2.52.0


