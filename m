Return-Path: <linux-nfs+bounces-20702-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM4EJZkG1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20702-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:28:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B43AF1BE
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6981F306C7C5
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378E3BD648;
	Tue,  7 Apr 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVEeqR9/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDBC3BD62F;
	Tue,  7 Apr 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568177; cv=none; b=UI7WVm1YVnoFRzMG2zdDicYLhcdMYRCWIzVxgldNUBqh/2JiIq8ksox+57/hBV7HKByvBIGoNYFqmElf9IvcHdzgkIJWcd6Rti5P5zUssmxDJolmX+uh9o1AdNRhrzAiDoBUCC9oNKOhvb0EZpwExr6OKHbyKZo6LHRuL2wkJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568177; c=relaxed/simple;
	bh=Z4zXI+/IobxHZzp9dQaWHHuZTrII6y4E+PNc85tZohQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkRXrUJhy0gDxUnFYB0NQQImRj8pJvaInts8zj1n4C/GMOJb5azmoy2XPxqZBYHEupuL2KsW9M6fVi3vV1czZb1JaF+R0US8+n0qRqjEfUtlcss227/5CsZm6iT6dCqyCtzKKdHajROrehnWnW15UtAq2+Ru7/g2e/3fgfofxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVEeqR9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F5AC2BCB2;
	Tue,  7 Apr 2026 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568177;
	bh=Z4zXI+/IobxHZzp9dQaWHHuZTrII6y4E+PNc85tZohQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NVEeqR9/4xCM6Wei7iezf2QGvWNJIsosQFD5zQ76NybPB9z0H7QBDUnTxhoO0diCl
	 6xqq/Zk16C6ypyjFBjRIlMAS6nlLdzH4ogGCgy3Lbu1/RdgkvVRYytagldxQBr4YEs
	 4ZsFzuVa/3Jbiyw7Pk8zQWgQd0+dg+YSWryJUPlbuR+PdaTJ1lPXy2xcFvJ+djqhjp
	 pA9ExRJp09VkfsZjfMj8ekLt+tD3s1NCnNs8ny0z3APIb1bZEZhvkK4gtFEAHM0j9T
	 JfJ4/xQ//BZ0CpLHJhq0elx2lmjREqjIXzA6070A/mh/ZWg8j2e0H0ZpYJIUks9EiF
	 M/50CozkDJDnA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:28 -0400
Subject: [PATCH 15/24] nfsd: apply the notify mask to the delegation when
 requested
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-15-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
In-Reply-To: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUINxLwL7o0cUZ45n+7bAG37tQfqs6aYWIAX
 xsDYCUUMk+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFCAAKCRAADmhBGVaC
 FYS/D/4o7wY7j8NcguHPQOTzZ4OtGT7veKWW0iQc7FK8+ycMEt5RqatvjXZUozUXaMbt/0T3gOY
 UTCn9vr7SEkbJ2YYxnQ6Y/sGgUBo1F71LArFM7OZ/wAO+SmYoxcaimM9Ore7AgLcluPaDlyWYct
 HiVPxIPlPgx4oznB9CgJCFDvfu7AvMHRdLSlshLwzHgSw77145+KtbQHbfLZiZD8FVRFjQcSina
 ZFEsZpygh7E7n0OvH5CgBPzXdph2WZ0yWdym7wPjrWFl8TntMwPFqft2J2onb9IYCGGY7a/Fgjx
 /OWsH5Sch7OTlsoqiD0zJoGczwbMNbgodXrgo57XOAC3bhlX5xBpS8v39Q6G6k/7Nn2nkjBsYUc
 jKLlSL7mCfixudULsPgmG9R8+mwLX3g8fWtFhKYyys/fcp1Ey6toDOnBxbe/d4BpJEa8vYRB/dy
 zjtFVxEnKCRM3Y86RH9Qp8LmSuqmyuiZGLwkoR4trCIQJbP5gW+WPqxWGXE69VWf7zI/4rSlzLS
 1lTG+fq/p7PH6XyrXhVGkhPwNOxo7xgvLynz+4JcM5mhDf7Py20a7XU1Z9Y/4NGfUoWiuvQLlB1
 Wibk21R5SUCgCE55l3wIEo+qo7hk63+MnWoU6+KpETHMGzba17HQ7SxyeOXFxCqU5vLwypWFe/G
 QTmqImZ7PpN0umQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
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
	TAGGED_FROM(0.00)[bounces-20702-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 0C4B43AF1BE
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


