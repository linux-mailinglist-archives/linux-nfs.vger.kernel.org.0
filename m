Return-Path: <linux-nfs+bounces-21231-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNbGCUtf8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21231-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:18:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436547EA93
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF3F830C2559
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FA23D0935;
	Tue, 28 Apr 2026 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjzij2ku"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2A3B5319;
	Tue, 28 Apr 2026 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360309; cv=none; b=qlMaQz5zEwS4PKMzsu8yPTdiDR3mo/IeIxq38j6V0EAjtP5T2kGoEl+xO/tW9sQ3qr1/ZCPvBKhlTK7+lXqEnCzRZ+L9CiffHpG1m99dknCFSm3Cm5uUs6R1Mo5yfrh96fK/H99ah2gQLIsRHoftlKK31cn4ekGh8h7HaVW8P6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360309; c=relaxed/simple;
	bh=vT13omJ88avBYGucyN258JCiiQFLmujH3myXqMMliO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHgwYeA79c5PvZW2EcefrbxsUXewuv9jfU+Occc2Bt6wo5n7ZPc0PmccrA9KTadWd194EEUKReAf36vrEA0+EnZiXI5h2qEDIEadt3o5xBO9NYscIUv9nY0Hv80lM27KVr1Ga9BAQ+h0Nd+QNJgxTOTXMQOCKdjkujvYDnQgmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjzij2ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35FBC2BCB8;
	Tue, 28 Apr 2026 07:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360309;
	bh=vT13omJ88avBYGucyN258JCiiQFLmujH3myXqMMliO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cjzij2kuogfQieZ/URzMNhfb9lTkuFmwzsJraWgfgBHa+9sHXzIA39T0lPILwpfRi
	 54fQpweaLs0GaH4rzrJhl1Gr5Yc0WmGAoGBUkzAoocS6E0RpIjeMSKY0yidRtKQUa0
	 gSpLFslEeku2+0/7tVmEcsdHYnuhIC7AEmIBOt3muu0HGXMP07DNV0h+y6Mi+QkqY9
	 oW/yTX2cDxeBKu/akRMd+NG+YcfwHLGmgfo3M00idpdYJ7f9A9UTLJJb2mdeFeboFh
	 HhclalfSdgfg4XEfv2fIz4qLY05J6+Z9zIRbTAAU/3X/0reGkmSR+DmAD5L3/evHpS
	 B41l1UxoAmdqA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:10:03 +0100
Subject: [PATCH v3 19/28] nfsd: apply the notify mask to the delegation
 when requested
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-19-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vT13omJ88avBYGucyN258JCiiQFLmujH3myXqMMliO0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1SGqE91Drbd+PXxtfVoL+xhtx7kUAjoI4LW
 Uakszs2KeSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdUgAKCRAADmhBGVaC
 FT9cD/9vvluBBLEbvU4l9jTWxcvM1HNJqSJCL3xHE4kNhyPSJ0B5fkGi6fYUsrgA2VqfoKc9o3k
 V9hTW24/FcjDogCqQ7CJcOzU2fWpcfdsQe1HJJiZP4R5ZbLElUTybTHk69xyI6HUPC0N+1sIo/H
 zuvNvBpxGVATKnkzWi4P4fuPGyAgeN1OGXO7vKZiWflt+YW5mIr49LTur3UA4+WPwFdgTGfHGdR
 +0RsLP7yQDondpLwogZKv2eE2UxZ8oKONGVyit1i/EYhdFr6jUJP+QrEvFRWxAVhhfco2lnSBuU
 qcquT2oGc7nd4+GSXRnE7Diy5ydYuXjRSqKi+YTL0TpotWo0P9FEUzJISvzSB08yRRpqb5H8Hje
 YfjnGpDxj3/ZkpX/7XWN7VhDewC6iPVAFbOwLZ3E2owgcR+YlW70vOxClLPzPKmFVfZqyr4QyL7
 bhtSnpgKipdPDqc+KJ0gOzDxvNejxlTTfYteefmf0VTB5KsoreDiQhVDWDTEdM5mPmcantc4T3m
 /I4Xs1R9yROhK0No+6h295BzrhuPX2YR//PEwrlbKU3qxmFRWVyC6rD38hDzcUGrlXN14fMkauX
 RLP8aX9cyAfxMOtno6kvexkb/WYoJrbM9Ji1Omw9hSmq1b88P2+mfzVzJtlgYAW50vze/XPEGVJ
 OSxhPKeBS1b9lSw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 9436547EA93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21231-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

If the client requests a directory delegation with notifications
enabled, set the appropriate return mask in gddr_notification[0]. This
will ensure the lease acquisition sets the appropriate ignore mask.

If the client doesn't set NOTIFY4_GFLAG_EXTEND, then don't offer any
notifications, as nfsd won't provide directory offset information, and
"classic" notifications require them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2797da8cc950..01e3bf9e1839 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2506,12 +2506,18 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
+#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_REMOVE_ENTRY) |	\
+				 BIT(NOTIFY4_ADD_ENTRY) |	\
+				 BIT(NOTIFY4_RENAME_ENTRY) |	\
+				 BIT(NOTIFY4_GFLAG_EXTEND))
+
 static __be32
 nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 			 struct nfsd4_compound_state *cstate,
 			 union nfsd4_op_u *u)
 {
 	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
+	u32 requested = gdd->gdda_notification_types[0];
 	struct nfs4_delegation *dd;
 	struct nfsd_file *nf;
 	__be32 status;
@@ -2520,6 +2526,12 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 	if (status != nfs_ok)
 		return status;
 
+	/* No notifications if you don't set NOTIFY4_GFLAG_EXTEND! */
+	if (!(requested & BIT(NOTIFY4_GFLAG_EXTEND)))
+		requested = 0;
+
+	gdd->gddr_notification[0] = requested & SUPPORTED_NOTIFY_MASK;
+
 	/*
 	 * RFC 8881, section 18.39.3 says:
 	 *

-- 
2.54.0


