Return-Path: <linux-nfs+bounces-18394-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLcuGfnDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18394-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6979D9D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6418304E180
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931E42BE63F;
	Fri, 23 Jan 2026 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kujXxw37"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDF2BDC3E
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194409; cv=none; b=LDfqCBCE7ccNu41HOnGuH5/DRHV7jPivOslmL7tz0JgMSb5FQ7N3PRtPPDdEmPK6GagIRQADpmtmdRfowSZlfTGWK+8hCTHbv1DPtCZu9pDfWFK56Nqc4y3TPBFcQE2HQgkeQYdYMXorULfBOaYgEYHjKyDL8scFzpghKofjwgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194409; c=relaxed/simple;
	bh=HKe/+JTMsQPqOXopt9BIn3KjbbfuOoPyQnQwplTHM+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHIjF9SzcMNojeKYUMFyqzGaXAqCTFv4cNnd8XF3JTOzxcD0vJ6PIgSGUbBDR7YnECchCvbW4hCG8C+7XjUOT4gQKtuc/ZP3h3nWMlq8WatqE4HWOJPE6uNpP2XtB1tO4cxsrgkMJ5IRZrY9ZUUfdWow8KQemIK23ZR+IArALGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kujXxw37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DBBC4CEF1;
	Fri, 23 Jan 2026 18:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194409;
	bh=HKe/+JTMsQPqOXopt9BIn3KjbbfuOoPyQnQwplTHM+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kujXxw37jQhQX+qN6w+KhzgFopThKYUrsbwZdLILFGa90YtJlUpNKaBxmVgXOFyYA
	 hmupaZ9aCudRkSkHnSx9kYJOWJB8mjhqFW5bHU5J8iOsT3eDRNUxkKrcKh538U66TB
	 OssFln1i8EL7jW5MHnidgsah22j5A4bBlTa7PKPPlnC2ovfoYsU95jc8iAZxKZ/1ho
	 PnqSEJHxqn7kp0BBxKUAaM7ca1jgR6Pra0UXsPcNDBu3c6mC4DNuD79AuOkKx16cKc
	 6V23zzrSCpA3mmn5JjfTzwnE2pgI0mTJQw+RCVUzFVilER7nwqRit8oIEYAQ8tAUT+
	 pM6eTdPDvqK8w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 33/42] lockd: Convert server-side undefined procedures to xdrgen
Date: Fri, 23 Jan 2026 13:52:50 -0500
Message-ID: <20260123185259.1215767-34-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18394-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: D0B6979D9D
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLMv4 protocol defines several procedure slots that are
not implemented. These undefined procedures need proper
handling to return rpc_proc_unavail to clients that
mistakenly invoke them.

This patch converts the three undefined procedure entries
(slots 17, 18, and 19) to use xdrgen functions
nlm4_svc_decode_void and nlm4_svc_encode_void. The
nlm4svc_proc_unused function is also moved earlier in the
file to follow the convention of placing procedure
implementations before the procedure table.

The pc_argsize, pc_ressize, and pc_argzero fields are now
correctly set to zero since no arguments or results are
processed. The pc_xdrressize field is updated to XDR_void
to accurately reflect the response size.

This conversion completes the migration of all NLMv4
server-side procedures to use xdrgen-generated XDR
functions, improving type safety and eliminating
hand-written XDR code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 7e936bd00a50..d8a5f662ab39 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1020,6 +1020,18 @@ static __be32 nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_unused - stub for unused procedures
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_proc_unavail:	Program can't support procedure.
+ */
+static __be32 nlm4svc_proc_unused(struct svc_rqst *rqstp)
+{
+	return rpc_proc_unavail;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -1122,12 +1134,6 @@ nlm4svc_proc_free_all(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-static __be32
-nlm4svc_proc_unused(struct svc_rqst *rqstp)
-{
-	return rpc_proc_unavail;
-}
-
 
 /*
  * NLM Server procedures.
@@ -1312,34 +1318,34 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_name	= "SM_NOTIFY",
 	},
 	[17] = {
-		.pc_func = nlm4svc_proc_unused,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = 0,
-		.pc_name = "UNUSED",
+		.pc_func	= nlm4svc_proc_unused,
+		.pc_decode	= nlm4_svc_decode_void,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= 0,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNUSED",
 	},
 	[18] = {
-		.pc_func = nlm4svc_proc_unused,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = 0,
-		.pc_name = "UNUSED",
+		.pc_func	= nlm4svc_proc_unused,
+		.pc_decode	= nlm4_svc_decode_void,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= 0,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNUSED",
 	},
 	[19] = {
-		.pc_func = nlm4svc_proc_unused,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_void),
-		.pc_argzero = sizeof(struct nlm_void),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = 0,
-		.pc_name = "UNUSED",
+		.pc_func	= nlm4svc_proc_unused,
+		.pc_decode	= nlm4_svc_decode_void,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= 0,
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "UNUSED",
 	},
 	[NLMPROC_SHARE] = {
 		.pc_func = nlm4svc_proc_share,
-- 
2.52.0


