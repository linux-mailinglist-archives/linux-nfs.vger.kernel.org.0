Return-Path: <linux-nfs+bounces-18567-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FT16Cx4peml/3gEAu9opvQ
	(envelope-from <linux-nfs+bounces-18567-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:19:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64579A3A8C
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 639803012C80
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3DD36A01B;
	Wed, 28 Jan 2026 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nki0qlR+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE382BD5AF
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613578; cv=none; b=WRBHNsXgKyAlwRiVGeNwGMhHYeqMQhRvPQ4GQSdijMTCkqjekSeNHPubn5fFtETPhjMPs9KucUXiEDdFRze+omfeGUQBYEMRnzWdBssZqNg2jj1wIU5+UO8cXcjT8T+8xVh97Yy0DQ82WKzQ1DBfHXd2zcwa5tl4kTORqkDn3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613578; c=relaxed/simple;
	bh=YTdROeVV9pacPvZoAwA8uFi9Qi1gPw1NPvMpUCKXSU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCzQW9sboM6yeuKGONKGsKyuyX6+p+pavr8fFo+A6Jgs3lxa+JBTx8RRf+bgCBjfa9MrjEHFbHHKcYvEeGPhgBiHIGJjfl5gNnC4MGvxrTu8ZOTufC/Zn40pWn2TO2irlgcZhN3zBi6emI63O/Vt90gcb+uil/Y0A44ONyhjRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nki0qlR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF53C4CEF7;
	Wed, 28 Jan 2026 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613578;
	bh=YTdROeVV9pacPvZoAwA8uFi9Qi1gPw1NPvMpUCKXSU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nki0qlR+54fpsjArh7stVAt7E9OX9B60ownO3A9QX0gzoWaIMLl1uDNicBohdOO0d
	 rIn/3GkJZ8qIrJ5RIYeiFfbXB0fNM/vxvbqXgZp+U5hNdaLWUCTfLlsG0E5HPiNiCC
	 2YloHwKksfAXJ2Oqf6g1EnySD4RcjxObc1MJh4W99PIYq+0U56zZAyvfxdrHrXndf2
	 tIa+c2onlnJL8oNFz1TwLK0PkWWgMrocwhLX90WqdsUCNzI+/aEyHB+rPXYyuQ4Huy
	 SUa1Xs8GoqAnAylyjGYikFVRtgvK7lGVfMZZoriJZeeMYTcbiXSS/JPkitBPDiOauF
	 N8af5kCbTSHWA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 01/14] lockd: Simplify cast_status() in svcproc.c
Date: Wed, 28 Jan 2026 10:19:22 -0500
Message-ID: <20260128151935.1646063-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128151935.1646063-1-cel@kernel.org>
References: <20260128151935.1646063-1-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18567-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64579A3A8C
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


