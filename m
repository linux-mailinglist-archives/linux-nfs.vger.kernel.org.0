Return-Path: <linux-nfs+bounces-20710-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BkDJAUI1WnMzgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20710-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:35:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA373AF3AA
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D4430F8421
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DEA3C276A;
	Tue,  7 Apr 2026 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmXX/5XO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07413BA23B;
	Tue,  7 Apr 2026 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568195; cv=none; b=Rq7PHv8KFKXIMVV9QzGCcQW4kQx9Gq5QksCboH2mYxDxtNfNVy6ML2i/KUF+dBbVLRqI5m4jkdu7h3FzpAlhxS20tdosHf69SLN2nO4//Jolnmjls5DQi7zsUmNl8cUBNy7n1H3A36U9DG5UwuP89wyBN4hXV+KG02DczDDGgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568195; c=relaxed/simple;
	bh=cV8pXiuyww/5TGNvhSUjcD3GMkRQw1n4h5NogV50cnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YM4d3mRxaflKGvN5RmRxneuTbIYJto0RCWB8EgAtPL3acPkE9gd64hpSWIGHTfaHLbrt9hGOUQozCCAeHt1EZUUP+z5Pd120OyPylI8vzE1snnAxt1r0UFISojSUlZztpDBFemKpIRUY0Vd+mIZAvmRwbTus8u+smohmcgpkXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmXX/5XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66360C2BCAF;
	Tue,  7 Apr 2026 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775568195;
	bh=cV8pXiuyww/5TGNvhSUjcD3GMkRQw1n4h5NogV50cnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JmXX/5XONUkCrb+nx9dY1n9XoWY6F3FipeusMaKqc048XeJa9G69AudB5j0QIuKoc
	 gxXPw28zqFQDStctePz5VIqKYUVb+7ZOsaPVoJy/pBdDl2F+MejTa7vj9F4RFS+UUQ
	 qpv2vzq+8FKaiVjjbZLQjETc9t3KPz9ufkbLX3Klq4UY/0sY3/NrJYbv4wjbjGILRs
	 F5jnoYGCM0phchAjNUDki+i8gpsGakzRfzl4RSKJjiZAhLNMQhlWp37u7z5XPT3qYz
	 fzx9uf6szUXOV26ymcoPLOrvHje34MQ4jZvNMePbWnZ/BwpzHEQFO2vcXmzQTRQFU/
	 8PqDYvoqV4tuA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 07 Apr 2026 09:21:36 -0400
Subject: [PATCH 23/24] nfsd: track requested dir attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-dir-deleg-v1-23-aaf68c478abd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2846; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cV8pXiuyww/5TGNvhSUjcD3GMkRQw1n4h5NogV50cnI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp1QUL8zuuKLv6Yact/lLT4jRwrbRopcqjbV94M
 PYWLd84jIOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCadUFCwAKCRAADmhBGVaC
 FQ92EADCa7pHQEKRBDt2eQob0s1rgETuh1Wpk18yZ3Txw8qa5tUHPcy+o0k9PpnfyEys6/BaDEr
 bxcaooM6z4ycTqVnxYFc4I5m5/cl00kx50z2Z9ZlGbSEY7vl5FX3Qgr/kXlnn+BP5ejueeTkkIC
 Brz5rTtEYXSn697xleZqEzWHgVCFgz7YLdlXghmKpaLNmNDEMCuPYGtctTGzOHuo0MnVabhbEJO
 UL0vP32xafljSpjlMeXYUGHZX7sq/KTuD+pGelFeJDDozdgOuIKF6TkQpGB6nqckir8aQZbtsbz
 i09DqGsKM7ujFGJsp5xf8rxPfW/R2Mx+dODC2xFc9mTH4pppXSOsjTs3nFhN5Ie5zsWLm04nC2u
 v2twYTUbFx8k3de5FtPx7UJJZn6Fd9yb/5DZTZf3t0yPOC8dbKpFlk2WgRuAARpWD+TyiOHJXaJ
 uOqJQhq8e3rL+sl7Lklc5xyTBvwiBp3kLVa+CTAmkfDBhkETRV5CaNzV5Z5piCc3AIbetpYefoQ
 LYu1sxKcmi8iDsycHf36hrjaKEi8BP5a7tWN7zzNvrRFRs6/7AkkvmqoZjdYy79J3obuHj3MINg
 8uncqrAS/1EhZ3KoIgb75T9Kb82z8beqZWfiZYUkZx0njRJB6EBg+D1HTND8OwFnAV5WTnhvEfH
 OieY/B55nsDLEIw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20710-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FA373AF3AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Track the union of requested and supported dir attributes in the
delegation, and only encode the attributes in that union when sending
add/remove/rename updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  7 ++++---
 fs/nfsd/nfs4state.c | 14 +++++++++++++-
 fs/nfsd/state.h     |  2 ++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a807a55dddf9..82d7c473e4d3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2506,9 +2506,10 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
-#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_REMOVE_ENTRY) |	\
-				 BIT(NOTIFY4_ADD_ENTRY) |	\
-				 BIT(NOTIFY4_RENAME_ENTRY) |	\
+#define SUPPORTED_NOTIFY_MASK	(BIT(NOTIFY4_CHANGE_DIR_ATTRS) |	\
+				 BIT(NOTIFY4_REMOVE_ENTRY) |		\
+				 BIT(NOTIFY4_ADD_ENTRY) |		\
+				 BIT(NOTIFY4_RENAME_ENTRY) |		\
 				 BIT(NOTIFY4_GFLAG_EXTEND))
 
 static __be32
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 59a9b1ca836b..c4b6f4d65a47 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9795,6 +9795,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
@@ -9864,10 +9873,13 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 		dp->dl_stid.sc_export =
 			exp_get(cstate->current_fh.fh_export);
 
+	dp->dl_notify_mask = gdd->gddr_notification[0];
 	dp->dl_child_attrs[0] = gdd->gdda_child_attributes[0] & GDD_WORD0_CHILD_ATTRS;
 	dp->dl_child_attrs[1] = gdd->gdda_child_attributes[1] & GDD_WORD1_CHILD_ATTRS;
+	dp->dl_dir_attrs[0] = gdd->gdda_dir_attributes[0] & GDD_WORD0_DIR_ATTRS;
+	dp->dl_dir_attrs[1] = gdd->gdda_dir_attributes[1] & GDD_WORD1_DIR_ATTRS;
 
-	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);
+	fl = nfs4_alloc_init_lease(dp, dp->dl_notify_mask);
 	if (!fl)
 		goto out_put_stid;
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 7ca5ef9caafe..56a3cfb12e65 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -284,7 +284,9 @@ struct nfs4_delegation {
 	struct timespec64	dl_ctime;
 
 	/* For dir delegations */
+	uint32_t		dl_notify_mask;
 	uint32_t		dl_child_attrs[2];
+	uint32_t		dl_dir_attrs[2];
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.53.0


