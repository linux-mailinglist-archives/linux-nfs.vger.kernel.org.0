Return-Path: <linux-nfs+bounces-18494-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPgzDsDGd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18494-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B79D8CCD5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B93C73006928
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940128C037;
	Mon, 26 Jan 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1z5V+YO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6948288C81
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457339; cv=none; b=k3vBRBqHArucpXaGr5Iw7uw3XWgGVeBLDZC0StrjuT2mJwxCibruQgJK2GFOLHxgb8UjdrZCYeD6UapWsTkm8zoUJO1EbcynCKAA1Ha/PfHW/KFnlQ5XsQ5DyebeTwL7ZCkoTX/qs6B+dw9SCDMhPPGZXXT8oDUBSXQIVULnPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457339; c=relaxed/simple;
	bh=YTdROeVV9pacPvZoAwA8uFi9Qi1gPw1NPvMpUCKXSU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARiupcPllcwJnuzYzgC7OUcbLDe5Rfq1kVTMdGC3LT2AuiEbB9YIOUWhOMH2/7B/hyWMtUtdkxCadjm6sNdcnk2r2l+ijpzXxXYQ97mWnzaL2zBR08bBsRhZFhIrs/3PsNJQ6vdWKPnU2BQrH81THO4KN/lAufA4AjfwOt+nUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1z5V+YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6986C19422;
	Mon, 26 Jan 2026 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457339;
	bh=YTdROeVV9pacPvZoAwA8uFi9Qi1gPw1NPvMpUCKXSU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1z5V+YOqJ6EoJAmaj7rSe1NMnasfeS4Qh/bi+tfArG5SBfYNKlBnTWvusdO7Joxj
	 PCWW0yYlmt1fupph9UwKA/ntoLnrWfcO27bTvnxST174vZ8S5rkTtaoV4cQBGi7rpk
	 jOsAU8BOLWD3AzMqXlB3wF69XikbNqlRRRifzU2sG6n/TFUaZklkz9LboIXLy5fC7g
	 FgEn5sGutsW8iclMf9qe8/W0sWHRB2zoFx4Gw6aTy0odrlrtqrtit/19arORETyIk7
	 v4oH1TvLR6ba4IwqdirjzafHZhx6zVhxKqC77cMP00OsbYDzt6vWmrE5jtNh0XXlUM
	 Znkbv2/R/+HDA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 01/14] lockd: Simplify cast_status() in svcproc.c
Date: Mon, 26 Jan 2026 14:55:22 -0500
Message-ID: <20260126195535.154697-2-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18494-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 3B79D8CCD5
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: The svcproc.c file handles only NLM v1 and v3 requests.
NLMv4 requests are routed to a separate procedure table in
svc4proc.c, so rqstp->rq_vers can never be 4 in this context.

Remove the unused vers parameter and the dead "vers != 4" check from
cast_to_nlm(). This eliminates the need for the macro wrapper.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


