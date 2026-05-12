Return-Path: <linux-nfs+bounces-21578-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA3iMBFyA2rH5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21578-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74068527B48
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45996330FC7A
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90FE37F742;
	Tue, 12 May 2026 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1dYqjZK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652E375AB1
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609673; cv=none; b=KA1qAgAHdhPJp4fb/W6HtFuzg2bNjcsrBy529CYACTeCjn+QWJYQzlniIra71K/rZK5egnrsFmApODVJ/RJ+BuCXb2HjYSQ7lyNdbvUVDxB+DsLk7hMG7wXOwgdrLsbeYN6xNsktdvqP42s6YgHHnjVcb4GQqpuoeNf/IgDRosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609673; c=relaxed/simple;
	bh=8WSgroPpnIxGVYTmteZT1o7qBtlWPoNZfHUTcELK+Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mW7q7RMPIg1rpW4T8yQfnUaj+Vn8Ma5DsDTtiT9skpalgH76BVkUY7E/lPvTvQJjG0sS/o0bdnUnLr405rOPKM+5GI5BuEYEpnPUO8/jcfPGRiv84GmhYTpH6Ce7rA/Rqn65//ioVXlvRcAuzVwbi1fivFPVp32DCbiTEykRWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1dYqjZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4418C2BCB0;
	Tue, 12 May 2026 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609673;
	bh=8WSgroPpnIxGVYTmteZT1o7qBtlWPoNZfHUTcELK+Fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H1dYqjZKz5aPsGxvFXqUTnHqDVPpjTFlpe4zdoMoIuEkA52ezyer7HJ6KUJEau0dk
	 jMiBhwnpqVc1j7eXhA+VbUzm8tWq0Gp2UmrXu+YkMfi2vkXJsft9xqhj+4elY499J+
	 ZPi7EnHQ3OfF9WGOJPPAzEqJYj9k0nRMt9TFpKlklEUib8zM644n37kmqTbw1s5tb4
	 rtA/+C4HZibRCQpllH2zbjqRcWmQ3gfIDk1Cc7ff9X+9mQjwgqIPM8taxbD5yytDcV
	 9SwriJO1f2TldzIMZZVQ1sWgh+76n5ncUxMN+bzGnYORPwL2q1NoZiUDbPzWph8lxk
	 oBOOYWzMTNRXQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:13 -0400
Subject: [PATCH 38/38] lockd: Unify cast_status
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-38-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=NPzo/qpU9OgPt/kcXnFSLS4gfs713T8J/PRNxtHqfTo=;
 b=kA0DAAoBM2qzM29mf5cByyZiAGoDbefIi3/bDpBsCvl8TL4+RS2Bvy2lXBkLPCTFyZHm2vLrS
 YkCMwQAAQoAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJqA23nAAoJEDNqszNvZn+XlQMP/iWN
 XBahklD13w4QBDdFkQeUBTbpMgsT5i0BgN19esdmY5q6FNi9+U3OmUM48VpL56lBU2wsMdQJZen
 NQN6e1zczAFfIsHeRlACzWet6GbqDFkBJ1EQoobJZnOO3WzmbVFb8CDjN5R/dCu/NZFCBKOcZfF
 b9aq6W8t5o3Ps7GLV9zJUkkxWfriawxl9cMHhGPYx2nEaiCyRt5VeIZHoK3ufk9bvyCZ6VghJob
 3S8AHJbJImYQTdSc2loVHI0Mlg2/bubveQN6qKnkO67SYNfylj0FGLJhQS217iwNKZmD8uJBuLX
 TXrpS1SIcXpL8TqV2KHQ9xyc/ujrBZL6c8NLpSdKTPYfKBDEr+dn+G0+x+YzO0bR8RdcHAMzD4g
 Vx4B8pZPT18MznetrSl6NfNGY1wEh731wv6R3FY/m6xx2gqA/mRb+D0hWlahglwGsIqP4T+KJeo
 aYmIUQ/6zaI33oQnjgtoLcLPf4b6QNXnLvoUfglBHl5VAdINz1NOxsFVNV/23pY86OAnCZAqQEX
 jupHaCz7J5oi4izgnZ3K7wlB0lULKa67cC+XQU5yKh2mwdX/h9aR4gaxyAYRh90NUy0jx1PufV6
 8rODKJEZfTMUgz9VI6WjzFykajuLnCk+30VbfzmjvHITH1K5Awap28tjVrY2eZBSD4PXtKBD8K4
 BeLri
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 74068527B48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21578-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

cast_status folds internal lock-daemon sentinels into NLMv1/v3
wire status codes for the v3 reply path.  Two variants have
existed since the original kernel import: a strict allowlist
under CONFIG_LOCKD_V4 and a sentinel-translation form for the
!CONFIG_LOCKD_V4 build.  The split was never grounded in a
behavioural difference -- nlmsvc_testlock and nlmsvc_lock,
which feed cast_status, return the same set of values in both
configurations -- and recent xdrgen conversions have narrowed
the caller set further: nlm__int__stale_fh and nlm__int__failed
are now translated at their point of origin in nlm3svc_lookup_file,
and the cast_status wraps around nlmsvc_cancel_blocked and
nlmsvc_unlock have been dropped because those functions return
only wire codes.

Collapse the two variants into one.  The unified form keeps the
CONFIG_LOCKD_V4 arm's allowlist, retains the nlm__int__deadlock
translation, and folds anything else to nlm_lck_denied_nolocks
after a pr_warn_once so an unexpected sentinel from a future
refactor remains visible in the kernel log instead of being
silently passed to the wire encoder.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index f62b0b39c5e9..4836887f11ef 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -203,7 +203,6 @@ nlm3svc_lookup_file(struct svc_rqst *rqstp, struct nlm_host *host,
 	return nlm_granted;
 }
 
-#ifdef CONFIG_LOCKD_V4
 static inline __be32 cast_status(__be32 status)
 {
 	switch (status) {
@@ -218,31 +217,13 @@ static inline __be32 cast_status(__be32 status)
 		status = nlm_lck_denied;
 		break;
 	default:
+		pr_warn_once("lockd: unhandled internal status %u\n",
+			     be32_to_cpu(status));
 		status = nlm_lck_denied_nolocks;
-	}
-
-	return status;
-}
-#else
-static inline __be32 cast_status(__be32 status)
-{
-	switch (status) {
-	case nlm__int__deadlock:
-		status = nlm_lck_denied;
-		break;
-	case nlm__int__stale_fh:
-	case nlm__int__failed:
-		status = nlm_lck_denied_nolocks;
-		break;
-	default:
-		if (be32_to_cpu(status) > be32_to_cpu(nlm__int__drop_reply))
-			pr_warn_once("lockd: unhandled internal status %u\n",
-				     be32_to_cpu(status));
 		break;
 	}
 	return status;
 }
-#endif
 
 /**
  * nlmsvc_proc_null - NULL: Test for presence of service

-- 
2.54.0


