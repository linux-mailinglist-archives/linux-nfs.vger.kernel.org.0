Return-Path: <linux-nfs+bounces-22621-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oSf9GdY8MWoiewUAu9opvQ
	(envelope-from <linux-nfs+bounces-22621-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:08:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553568F1F5
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:08:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nIpooq6Q;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22621-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22621-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8266A30651D3
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA6477982;
	Tue, 16 Jun 2026 11:59:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F243E9D1;
	Tue, 16 Jun 2026 11:59:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611184; cv=none; b=De1xiQlKXoGh0wNyLlq3dCNwfYhY3KaGHxeH0DM8VcujtrdlQEevF1EYfhggt6rsijvTSyAvy/xXDlfeQ0Z/uSc1uYA3n2PWkaYyeHR44b/3bRwQCTeutJ1EIBDbmCsKW+oSBxfy9+1L/UC9nNhXzNLJ2gwLR4BCGRNV9LK9CrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611184; c=relaxed/simple;
	bh=VWFs3xg0NSs4Rrw/RZfEbf/2BkkyEivJ40opzfVk86E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFIxKf5R5xGbm1jjHZVkZEbkIEh3vklUyvKoBJtR542OaD1xEBr4GxT7t0WaDBFV3vt7GSQjTSFyCQK8m+mh1+va6EUDP1W9hEOvNO+43bPd0oA9V7XG2QAtm/OOCaNLwG4cHlDS7uesWWCnqzO5aMWOeQjKkE3WNriUhIguUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIpooq6Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252101F000E9;
	Tue, 16 Jun 2026 11:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611182;
	bh=G4T1ZM590htNf91b8j6WTP0fjfpn6BQoRqqdKcOsx3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nIpooq6Qi5dQfqTseq46awDKWeV5iBomPhUfEuJQs8rBRfmFaHz1z+v6gx53Pl063
	 ecUbZfsaO1dVWtPWBGwHBm0KdEco0iTvtQkz0q/Clb+B8lbiEOoaLkQyp0qHrI4AMk
	 o/tzWdKPt5idtFKb1M243hxbzZ31MSZiW9fedXwa+j35YhbLh9mO3NqJJt6tRRerP1
	 y3ikeY6LFMJIhPCFmpGADuQBGmicqUtR/MBtq/NglEkEbaHbf50T4J8AQs7QaBj6bT
	 9gFan2dIYOzJLHLr0klzU22tshj7/LBvK62CUBU5SFAtanQ3FMQ3xKr1UDNJN/r2Aj
	 hS9gqEjOqPqQA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:59:02 -0400
Subject: [PATCH v7 19/20] nfsd: track requested dir attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-19-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3673; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VWFs3xg0NSs4Rrw/RZfEbf/2BkkyEivJ40opzfVk86E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqIuxoBcNc4qqzPa+eVeXOkZSLLIlY3WrF7c
 AkKs2QuuwGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6iAAKCRAADmhBGVaC
 FWvcD/4vZOolYcBJnfJPBp2qYTvOHJIPYi3NJ1Nu8nycT+ln0m5J71Qn+NP1gvpSWjSllE6rTrn
 ohYDQEh27S2NYJJAtHdquQF/ierDsSW7gKg8YZ4X/sXfjdr/L/zWIoM2+LG2qbKP9uTWY5hnyYO
 jWX19x7rnBj85MPmLmzIvhu/syYAlfBmtYYO4EWjivvm5yiekdQrxfNdHt2dF9X7I7104HnlC0X
 8C9UMIr/JnwJGjFbVFtBJyo09PEbePp8qRKaBM3PvrsQ5MdlMWdKwGf4S5HH01eJBIJYxvTD8GT
 HNmYqGNxgMm7P6uM3TviRBgCUbhGaZ/i9r5+NvnzJ2R7uaT5v2LR2QG8MlY6wruGyBTP/4WVnYv
 s9mJCn6QducpO+Rdvh78V25qnCrFhYWZzqKioiNm+pN6rmOg2QJRseylaza8M9x7pvidz3XmZZl
 XcWs1xBI7G6njNHU9wEm4qWWijb/h2bxYSqJxJSrpCr6wUWFchNnEYlbvRjimAefCh0u9FTXF86
 pOuYBKeNx5/Cl74azkFwcfVXNXdvwT84mWzM8ZPHvOKZZEiA42liX/7ZadcjlyyQl7LK676UtGa
 iINRcvuTeYNZL3n0htZFrmcRc1u0wUAeP2kvQ2EAGt9rz9yJegUqRh4QJsZdRZU6FBcaVewZPb2
 SAsvzb0VBfGPbLw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22621-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0553568F1F5

Track the union of requested and supported dir attributes in the
delegation. In a later patch this will be used to ensure that we
only encode the attributes in that union when sending
add/remove/rename updates.

Since the requested dir attributes can now include word1 attributes,
gddr_dir_attributes[1] may be non-zero and nfsd4_encode_bitmap4() can
emit a two-word bitmap. Bump the dir-attribute bitmap budget in
nfsd4_get_dir_delegation_rsize() from one word to two accordingly, so the
reply-size check before this non-idempotent op accounts for the larger
encoding.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  4 +++-
 fs/nfsd/nfs4state.c | 17 ++++++++++++++---
 fs/nfsd/state.h     |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 576346578ee0..48fc7b0df4dc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2610,6 +2610,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
 	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
 	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
+	gdd->gddr_dir_attributes[0] = dd->dl_dir_attrs[0];
+	gdd->gddr_dir_attributes[1] = dd->dl_dir_attrs[1];
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
@@ -3577,7 +3579,7 @@ static u32 nfsd4_get_dir_delegation_rsize(const struct svc_rqst *rqstp,
 		op_encode_stateid_maxsz +
 		2 /* gddr_notification */ +
 		3 /* gddr_child_attributes */ +
-		2 /* gddr_dir_attributes */) * sizeof(__be32);
+		3 /* gddr_dir_attributes */) * sizeof(__be32);
 }
 
 #ifdef CONFIG_NFSD_PNFS
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c4dc0428f0a6..a948dc8a46cc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9974,6 +9974,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 				 FATTR4_WORD1_TIME_MODIFY |	\
 				 FATTR4_WORD1_TIME_CREATE)
 
+#define GDD_WORD0_DIR_ATTRS	(FATTR4_WORD0_CHANGE |		\
+				 FATTR4_WORD0_SIZE)
+
+#define GDD_WORD1_DIR_ATTRS	(FATTR4_WORD1_NUMLINKS |	\
+				 FATTR4_WORD1_SPACE_USED |	\
+				 FATTR4_WORD1_TIME_ACCESS |	\
+				 FATTR4_WORD1_TIME_METADATA |	\
+				 FATTR4_WORD1_TIME_MODIFY)
+
 /**
  * nfsd_get_dir_deleg - attempt to get a directory delegation
  * @cstate: compound state
@@ -10042,14 +10051,16 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		dp->dl_stid.sc_export =
 			exp_get(cstate->current_fh.fh_export);
 
-	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
-	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
-
 	/*
 	 * NB: gddr_notification[0] represents the notifications that
 	 * will be granted to the client
 	 */
 	dp->dl_notify_mask = gdd->gddr_notification[0];
+	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
+	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
+	dp->dl_dir_attrs[0] = gdd->gdda_dir_attributes[0] & GDD_WORD0_DIR_ATTRS;
+	dp->dl_dir_attrs[1] = gdd->gdda_dir_attributes[1] & GDD_WORD1_DIR_ATTRS;
+
 	fl = nfs4_alloc_init_lease(dp, dp->dl_notify_mask);
 	if (!fl)
 		goto out_put_stid;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 2bc54546deb3..bc0181ef1cb6 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -301,6 +301,7 @@ struct nfs4_delegation {
 	/* For dir delegations */
 	u32			dl_notify_mask;
 	u32			dl_child_attrs[2];
+	u32			dl_dir_attrs[2];
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.54.0


