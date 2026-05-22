Return-Path: <linux-nfs+bounces-21793-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A4/JwFOEGq5VwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21793-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:37:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB715B4355
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45C5A306520B
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847CC3A4508;
	Fri, 22 May 2026 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAPvCmbi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7E3A2576;
	Fri, 22 May 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452971; cv=none; b=H6UFqlQvRRL5xoYCEGhfQGKppjt5q9Uhnj7GYZEt+FZWQ2Bj+zk/iPNA0KJDb8Laf6B+WnL1bX7WzZfymp4uVCqRvT9O1gIioKyDJDlJIo4OwDyGPoqOyCs+WP67lBZ0YyWl9t20hsQXhho4lvl1trNgLyG5PFsf6lyoPfNPk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452971; c=relaxed/simple;
	bh=WtCsTt7GqWI6wIG7UjJHamJhQxbCqTdMWHwIGmCs/cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+XD08REaQjayV1ZCJhBfWtGCCvUgONGvzXHklPS+j3cyhNnKGjFaAZTUPSdAfWaFNLhmNlSG4RX8JIdxNlfTH8h3BQuBdWEUJl+8KH1S7do8xp44/JmB2uw4q8YOv41HcCcQwi/CWPzdVNdZQIMZf6NpEmYgVxIwmidYq6u2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAPvCmbi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7780A1F00A3E;
	Fri, 22 May 2026 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452969;
	bh=pO+8xSv0vMbVLlIOVu1sUSgwIlOn2Ujffy4e7uLZjPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UAPvCmbiOA51t8kBVorYrxYuBY3neAcEdfMEi1B7ByOwVLQWNOZX96+oJ31YT1t4h
	 ZDYFfTwBDIclsG1s/Pi3yp60EObX/rGI8AvGvsNso6rcw1rPjh9COtM6IeolmYTSFU
	 AN4euJVx8OdDLHjgGEVIWx30FqiS3rQQ39ABwWWK6RAF4hVIhsXIry4WFTHHlPVilX
	 EzDozR6fAwFSG5qsCZURqbw5RpN6GZBt0f52pqo75PE0TEx704VWroaf9uk0ZXAQxL
	 uv/VBC7ywjW7dK/x/aMQOUFv/5vcqGy0MaI/gbvnBlNcdeFkSgJasK5AsFgIcLrZQU
	 axKL/dqpFh63w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:01 -0400
Subject: [PATCH v4 12/21] nfsd: apply the notify mask to the delegation
 when requested
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-12-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WtCsTt7GqWI6wIG7UjJHamJhQxbCqTdMWHwIGmCs/cc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwQPpkcDHYnYvZbvk0JoHwQtSQagwF34bhka
 ScyXFE0FtiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEAAKCRAADmhBGVaC
 Fb6BD/9qVagnufnnGq9zP3yDYmOfi/0oOUQNY1giyGQDG5kxE9hqQPW1CAJkJnmhLygAypwJo3G
 kPr1YHdIK1ulgnNvteepynRSQ7oifSy/9p5F0ipDBys49LUTwmoWpfUEikaM4P6LaNqXqRwiX60
 ZwQhpQkGDToQQc5uTTU5D+MJet/+wtWA37VM30csDp8Q9HjTFpCel8pmptM7ySP5j4b8aaElwk/
 rWncnSjHvoNeuOZm7KzPfk/usutfJU7qKnLE1ONMeApLl/eiY2zNxZMEBsiuuC4wjSFCyH1RPiu
 48of22UG7yrCz+e7bFFH2uWIJSBRKvd1wsIIs35UiS1GTkqkB332UmgTTB5520PMvKhWhukOQzj
 Lw7/sQ9/wniOTD1zXI6WzG/OBh1n9w2PPjVHz7eoVa5ivA9ZbAHrZR41EKb5ELSCnVO9lRAJicn
 lOTo88oJ17kybF2+MnG8LBfVchdWKK/V3e7ORlg0KApULzZHMnkCF/FnH8nJsm84MDYugtVfNi/
 ICMERxMGCa4eiLU901bhrBeZEPhRzTfP4vf9rmdcEICNo7n3mJXO015AAThgJTK7AWfW1ckKg0C
 FbX67db1SURLCf2IiEadRCrTlNiWwugiQTz1L0GYNPKkf40g8QCEocv/Eyn+x35cOrQNBkxRpSW
 f4+TnILtxxCMt/A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21793-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3CB715B4355
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
index 8561540ab2db..30f338f90acd 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2521,12 +2521,18 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -2535,6 +2541,12 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
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


