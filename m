Return-Path: <linux-nfs+bounces-20891-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHpkF4Ue4WlbpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20891-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:38:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7084412ED3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5051C3018628
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52403E8699;
	Thu, 16 Apr 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tctEIYJd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1B3346B4;
	Thu, 16 Apr 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360953; cv=none; b=eCs00Vss781MpC0FYTO7+PNC0zLt5Ql2WViAF5CrvzGPV3zrQRWUo3c0/DzOSnd60FFKexTlQ6vqOHrFMd+xwNYGJ2shWSSXqQEvZYhk2EZmp8FTVDX5BS0bjYsCzeyNMd2j2Y0MDTvomgfMm9iB8uffKS2iFtbLh/poucZHAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360953; c=relaxed/simple;
	bh=Z4zXI+/IobxHZzp9dQaWHHuZTrII6y4E+PNc85tZohQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAHKWge+la+XgbLqvNnCJfSPJowsl1eFQgnvfwAHmEnDdkWcD/fLXE+Z3QfaA2e/0xJfKN1Z0wX6pTp28tkJgnp6EvHiUN2hAsybXQYeAR4ZS5c8CiY0nUN6Gu2+CoIyBytcxXxUtxupE7uMwZLEfXh3OytGyn++vUCjjreRPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tctEIYJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE5CC2BCC4;
	Thu, 16 Apr 2026 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360953;
	bh=Z4zXI+/IobxHZzp9dQaWHHuZTrII6y4E+PNc85tZohQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tctEIYJd3bUfGB57UGAbe8Pymec9X8bRK+gdgr1hFfHxdikw2GqnaNxI7DGjrLh/K
	 K5Y/oU0K1XcVhcVbxA4fC/6mrvd4Bx+wXLKBxXzcp0TUPSsHJ8vcQf9C87r20kHlB5
	 aNe+f/vsu0ZE9FF30Cn/xz/U5NV657k8JelsoZZ+FRaKcvEEd+TUMu1GDGgKY8d5pR
	 mof5xgXkfI2lypqsx9KV/ZNiKQrj6y94HWR0XKrZmLB3swfcBQJIN7vCI6/QvAUTb5
	 TBiIq86qypHVMNenuwM6aP9Gqp6asMeAkGo0E0nY8Y5HAyRXUz7vdrOpYb15qdRPSh
	 PGJpUXQeSiSNA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:20 -0700
Subject: [PATCH v2 19/28] nfsd: apply the notify mask to the delegation
 when requested
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-19-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
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
 h=from:subject:message-id; bh=Z4zXI+/IobxHZzp9dQaWHHuZTrII6y4E+PNc85tZohQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3mXskgeu4rpA1iAyUvcphi0Go+X/Us8dmBy
 H/cB93+cBiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd5gAKCRAADmhBGVaC
 FdavD/0UpyKiznoUXgT9hM7wx3ql+BywYFs10pkLMMYfjKP+dqh04VZr0kunWWCP0FHAfRO7us0
 kCMma/Xc5m+iGs2cpo9jKXMI9ZhH6R/js/uCf/T1ON8VqIUILDTOjjHfxFlsty/5l91NlqYePnB
 CbP3gmUoXX9F7uduXkV8ARE3vg9CSUZQlBCwKR8sdF5MAl/D5qWsnuOLDSoLUVROqqU+YRceWEK
 09m/zWoorW1HBqt6ymMs2PqvvHnN5Lnu+ZtpviOKtO8iQOkeAieiGC8Nz9YoVC23JkaS4WSf+mh
 t6y3yJNKQg2PJlgevVRarcxudBkco8hZRjf7p3RT4lY1vUYSAizEaBm9IDEoZeu6MxTcNmJz3wu
 9w13+fLKkUTjkDTEDHfSesrR72UaOn8enBx4fyln2aIS4as9KcfPvxnRooPRzno/fHt8D1GwTNe
 ytBtjLLuDjDhdNb3G01tBNVTe9pKBPS3GmfunFYoPIS9+IQDH74ab3jI5mM7Vww2xWi98JhmoXF
 ErV9FuHyamYH+WDc9I8tGKIXx7S9uFEapS8j4G5Q1lrUO4YOfY4ryJY0fIYj7aV4y397g4G9A1n
 c54vxhQOBYWDq7OH1VEIQkPXm61TxIg7iJYerrBpWxDt66uvXUR+3jdFK/8sY4/c+rndBWG2aHg
 FW3uFlr3E8FiZVg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20891-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7084412ED3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.53.0


