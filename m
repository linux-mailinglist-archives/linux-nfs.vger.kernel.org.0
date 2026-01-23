Return-Path: <linux-nfs+bounces-18362-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC6VCqrDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18362-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EAC79CB2
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431F030347A3
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7782BD5A7;
	Fri, 23 Jan 2026 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA/1+C0O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887925524C
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194384; cv=none; b=gVx1XAP97vwSlEGv4yJBxi3iCE+b0Fnux+aN7A5HR2di5Q3nVCj+jrxNlW+mPFHCvNEKgmB/GYLYZcoVxCkaKdNikTn1rsHwAg217UIazwImmFODf7V+iO3uzfa0IXSDbMJO+4sJDcfp1LOxK/HMRMW3woyuYMmB6TuqkIgVnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194384; c=relaxed/simple;
	bh=wD3cTOsHjqj1eRVlAMxYyFSSZZPjY/KebYP4iCw28P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQFXfH4TKLjTHRVwIdBNK87qefRLYAzoJw2Qs7okcCrcBpyGlHrgEf90iDQpZMvpJ2Kluq69fd3pJbrg4zzo+D3lY+QCtAnj9UJuwF51TZ/zXK1BwwnlG7tcE02i+i2gW96QrP4/wEny8ABjYFH6wKiSaLsiRWRI+fQPxqYmci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA/1+C0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E0C116D0;
	Fri, 23 Jan 2026 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194384;
	bh=wD3cTOsHjqj1eRVlAMxYyFSSZZPjY/KebYP4iCw28P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sA/1+C0OUQTrH4PWMeYvF+2k7Nx2iHy9z1qrocOCTXIy6WOoc/vBGHCdzgfl3NWOq
	 Cis+EXggt8oOcVA4YJ+SWnM0UfmANnhOOHGer2lfDdVMUyYu4hQ7rp3EOJi9hotCsB
	 X0ZYFpdrlhG40IxyJb2xrvD9egqcBQFDBKuoVueda9ORIkwqLcd/xIA7D9hIite+g7
	 DPb9zljpQWYhMuMvc4DfLjisbLP63XGMXbkTVa4VA+W2LC5Js8aqsBdeJNN7QnFcwn
	 mMSJKPgkX3aOWz0S7UuQjrYOz9lx8aUWzseQwdVPCnTo+1asM7GI5WDNe3KH0wCJ2i
	 tiYh8kwAEKVeg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 01/42] lockd: Simplify cast_status() in svcproc.c
Date: Fri, 23 Jan 2026 13:52:18 -0500
Message-ID: <20260123185259.1215767-2-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18362-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 94EAC79CB2
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: The svcproc.c file handles only NLM v1 and v3 requests.
NLMv4 requests are routed to a separate procedure table in
svc4proc.c, so rqstp->rq_vers can never be 4 in this context.

Remove the unused vers parameter and the dead "vers != 4" check from
cast_to_nlm(). This eliminates the need for the macro wrapper.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 5817ef272332..95c6bf7ab757 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -17,32 +17,30 @@
 #define NLMDBG_FACILITY		NLMDBG_CLIENT
 
 #ifdef CONFIG_LOCKD_V4
-static __be32
-cast_to_nlm(__be32 status, u32 vers)
+static inline __be32 cast_status(__be32 status)
 {
-	/* Note: status is assumed to be in network byte order !!! */
-	if (vers != 4){
-		switch (status) {
-		case nlm_granted:
-		case nlm_lck_denied:
-		case nlm_lck_denied_nolocks:
-		case nlm_lck_blocked:
-		case nlm_lck_denied_grace_period:
-		case nlm_drop_reply:
-			break;
-		case nlm4_deadlock:
-			status = nlm_lck_denied;
-			break;
-		default:
-			status = nlm_lck_denied_nolocks;
-		}
+	switch (status) {
+	case nlm_granted:
+	case nlm_lck_denied:
+	case nlm_lck_denied_nolocks:
+	case nlm_lck_blocked:
+	case nlm_lck_denied_grace_period:
+	case nlm_drop_reply:
+		break;
+	case nlm4_deadlock:
+		status = nlm_lck_denied;
+		break;
+	default:
+		status = nlm_lck_denied_nolocks;
 	}
 
-	return (status);
+	return status;
 }
-#define	cast_status(status) (cast_to_nlm(status, rqstp->rq_vers))
 #else
-#define cast_status(status) (status)
+static inline __be32 cast_status(__be32 status)
+{
+	return status;
+}
 #endif
 
 /*
-- 
2.52.0


