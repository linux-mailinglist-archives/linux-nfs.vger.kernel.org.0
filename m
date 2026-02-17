Return-Path: <linux-nfs+bounces-19001-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DrVFjXnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19001-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B383315155A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F3F3072A37
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83D31355D;
	Tue, 17 Feb 2026 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4rMgGTb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DB313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366061; cv=none; b=IZ+aj3tttIn+qb31gc6eyEIIBS7pzJU2T3uO35aIE6weQBqGSUvhXKaLDY0lnpDdIx9HugSGXuFHRs8Q+oaqXK0m9hXny6nZ/j68vR+OsUMb5SXSltHSVaxONPnetAJNxwNu0JDINRCiRvIaEbWUFL8bCfKIKm5zwp0/gMrR9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366061; c=relaxed/simple;
	bh=29tZywbvlpO2DSCG1YxRfU1bmis5SVWx83d7TGKNO1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhN7dNRgZWaO8kto7WLac/+yRkn15LH339vhDpntWKodSt4+i/UijW784xFwRFDLXIkgl3FzCcSooJXJ4HCYOhQfI6H8QzTt/av/9G14cz5F0L1Ryc0k6hnbFWEOU2fketwYj8yGc0ORC8KzXeW5lY3uIzpHpQ5KyMP18YvI7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4rMgGTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFEBC19425;
	Tue, 17 Feb 2026 22:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366060;
	bh=29tZywbvlpO2DSCG1YxRfU1bmis5SVWx83d7TGKNO1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4rMgGTbEMpv7XP8c/WZ6JIzORU4y/jqwlK2QYnMIKxmYNSLrfy1NtWzKFHvycBlG
	 5jp5j6EOWPvNEJqfBC3/x+gGnOATvD5xNdJF0Ug5QF0Ebfoz4aKtviav/JcPFknV+2
	 OOZl+6gP8mv2oYqoKww7TgGyxZI5N4iV21Hu4rHgYWO96BoCHWCRk3ibmLv4s6NeAP
	 lt6gBOsveLQE2O09t9ChjlWEYjEV1WWulodaOTu8uh8rGoaLj71QjfGu3wh6uPKezA
	 TtT6hOug/DctnQDlX7YgpvAEbw9ZHk2En1KrtVL2WvcWLnMF1lw0HJ6HIA14sU3CJM
	 BID55cbO0x+nA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 18/29] lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_RES procedure
Date: Tue, 17 Feb 2026 17:07:10 -0500
Message-ID: <20260217220721.1928847-19-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217220721.1928847-1-cel@kernel.org>
References: <20260217220721.1928847-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-19001-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B383315155A
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Convert the GRANTED_RES procedure to use xdrgen functions
nlm4_svc_decode_nlm4_res and nlm4_svc_encode_void.
GRANTED_RES is a callback procedure where the client sends
granted lock results back to the server after an async
GRANTED request.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments, making the early
defensive memset unnecessary.

This change also corrects the pc_xdrressize field, which
previously contained a placeholder value.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 60 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index f730da7d1168..f986cdac5d00 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -71,6 +71,7 @@ static_assert(offsetof(struct nlm4_testres_wrapper, xdrgen) == 0);
 
 struct nlm4_res_wrapper {
 	struct nlm4_res			xdrgen;
+	struct nlm_cookie		cookie;
 };
 
 static_assert(offsetof(struct nlm4_res_wrapper, xdrgen) == 0);
@@ -959,6 +960,30 @@ static __be32 nlm4svc_proc_granted_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_granted_msg);
 }
 
+/**
+ * nlm4svc_proc_granted_res - GRANTED_RES: Lock Granted result
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_GRANTED_RES(nlm4_res) = 15;
+ */
+static __be32 nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
+{
+	struct nlm4_res_wrapper *argp = rqstp->rq_argp;
+
+	if (!nlmsvc_ops)
+		return rpc_success;
+
+	if (nlm4_netobj_to_cookie(&argp->cookie, &argp->xdrgen.cookie))
+		return rpc_success;
+	nlmsvc_grant_reply(&argp->cookie, argp->xdrgen.stat.stat);
+
+	return rpc_success;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -1084,23 +1109,6 @@ nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * client sent a GRANTED_RES, let's remove the associated block
- */
-static __be32
-nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
-{
-	struct nlm_res *argp = rqstp->rq_argp;
-
-        if (!nlmsvc_ops)
-                return rpc_success;
-
-        dprintk("lockd: GRANTED_RES   called\n");
-
-        nlmsvc_grant_reply(&argp->cookie, argp->status);
-        return rpc_success;
-}
-
 static __be32
 nlm4svc_proc_unused(struct svc_rqst *rqstp)
 {
@@ -1270,15 +1278,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNLOCK_RES",
 	},
-	[NLMPROC_GRANTED_RES] = {
-		.pc_func = nlm4svc_proc_granted_res,
-		.pc_decode = nlm4svc_decode_res,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "GRANTED_RES",
+	[NLMPROC4_GRANTED_RES] = {
+		.pc_func	= nlm4svc_proc_granted_res,
+		.pc_decode	= nlm4_svc_decode_nlm4_res,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_res_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "GRANTED_RES",
 	},
 	[NLMPROC_NSM_NOTIFY] = {
 		.pc_func = nlm4svc_proc_sm_notify,
-- 
2.53.0


