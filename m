Return-Path: <linux-nfs+bounces-20900-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGr/M1wg4WmipQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20900-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:46:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F041337B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46A3531CD41A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143BF3EF0C9;
	Thu, 16 Apr 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDIZZoHS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB53EF0BC;
	Thu, 16 Apr 2026 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360959; cv=none; b=gFzba3khCN3bb+9Xq5RK569VP6rRx7t/IZxayzG2kouhVI+l0yFkiz349tDneCrVooKSLLt83I14OfVUEqGdiH/siFVx0cJE34XJGs0U2s5LfVMQCulTLieXc1skkvS/Ks5IP1rFOeGSNh5+M8Yg5nB3giaZuR7Ld3CE+IcpKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360959; c=relaxed/simple;
	bh=0GGTP9r3MB3k1smQnZg4Uv4fvOIn7tuPPgHIzcrDbOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gmJZ/Fy0wUpxi5cTKyUskQFRC5J1LLWwHr2vz7IGjhl2zgN8Yi0C5ZE1g639GqMV+mc+fOZiX6nF0wxA4Jf5y+H8LGPf/sgoSXm7dfK18Dsccu1ItmPxHqUr5JDyRxFjrIT3oDqq2zT2us92wrR9qHRuYI/ybScETH1cWO2enhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDIZZoHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D6FC2BCAF;
	Thu, 16 Apr 2026 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360959;
	bh=0GGTP9r3MB3k1smQnZg4Uv4fvOIn7tuPPgHIzcrDbOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IDIZZoHSzIz3dh6A3uYiZTe0xG+vzzSOYVsqHvvub6+/61eRhZWhbJeDkhsa7L+bo
	 xIo8sSFWopvxTk4BjFcwfeEzULqZcQljc4h5y+I6OEuKtaGTiic6ZVreNoTYa0CYZs
	 P0AmQ4BLB4zCCaat244k9K7tJfmH0Uj6yx46CFifGp8Evarc/RaSNw0HKCeQ3aHpuE
	 lepEedEKQOgJZfg2euEEnIqFu+EUx1z9swFEpm2zivkPOvwt4jXaJcaTuqejdCH9gj
	 BMdSy1BB6Yi+yqBGmnFedMhBb54YhiMPVRW2UC148XjHc17V7xAO3ocB4xC969UYYS
	 yMH8FqZHXBWmQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:28 -0700
Subject: [PATCH v2 27/28] nfsd: track requested dir attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-27-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3281; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0GGTP9r3MB3k1smQnZg4Uv4fvOIn7tuPPgHIzcrDbOE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3opsiuoZ3PLu/ZCdoLxiWlOQsMqD1T7xYnr
 4UJsNhq0xmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd6AAKCRAADmhBGVaC
 FUoGD/4s7tCF3MmEJVOcLPUHU32gCHMs2zQyrtP1BXIGN5rp/cqIhBriAEHVi1eGu2HlM0+hIql
 YLiyA7usIzW998+GyVZSPr086ZtP8F0tcd6N6b2lDyN+LbVrUDBSs6sdOxgXX1fJjL5o/Vav41n
 dDbL5DUZyLs0X+xf4ZM7vI8RriC/dSDTn0UBQUoSG1vUoexpZYw3PioIiSuE1StjhW3cqFFNbAJ
 BJFbO54nVPe/qJ0J3xuwQ9pVGBvqoy07zeTAB6hq2flp0l9i54cvst85ABhqJGzy5o1vMWcwUrB
 wlSGs6jARfe5RYnYwyudek74b+X+l3TjX1V1H8ZsJ0vKRjyNJ2Df6vFAXsyFqz/+TJZ3f6laJoP
 /LPuZyP4Ji4TcJnKFQBonAVcMMAyGGrQp3Fxp8S98WDeNLJG1bNu7RZNjXBEFpZJ9j/WTtVh5df
 MYfU8dKWj/1Hj1/Zj3oU1jcwi7tU0Y8hrSUZjMxqhCX4s/lcwoF3jOZucSfGUc4PCtR9LjF18IM
 6vJl6cRcYpy//cKi0w+Hc+oMpo0d2vNJnUE3QPJefW/MGzqO3uUxZy8Pylk5vq8EkVfF2NvV8x/
 CS5/+qxpHXFZSKNLuCBafCMmyCf7mIbvpeVtdJbKjnTgyCGdQ8qjOBwkw0XnXn9fSwbmdP58dok
 +zb4m2XU24sgL3g==
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
	TAGGED_FROM(0.00)[bounces-20900-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 303F041337B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Track the union of requested and supported dir attributes in the
delegation, and only encode the attributes in that union when sending
add/remove/rename updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  9 ++++++---
 fs/nfsd/nfs4state.c | 14 +++++++++++++-
 fs/nfsd/state.h     |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a807a55dddf9..e4717e1e3d93 100644
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
@@ -2555,6 +2556,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
 	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
 	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
+	gdd->gddr_dir_attributes[0] = dd->dl_dir_attrs[0];
+	gdd->gddr_dir_attributes[1] = dd->dl_dir_attrs[1];
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 28e34f6c95e7..32340a0669df 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9822,6 +9822,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
@@ -9891,10 +9900,13 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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
index cb1ac3248fe8..4c5848285378 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -286,7 +286,9 @@ struct nfs4_delegation {
 	struct timespec64	dl_ctime;
 
 	/* For dir delegations */
+	uint32_t		dl_notify_mask;
 	uint32_t		dl_child_attrs[2];
+	uint32_t		dl_dir_attrs[2];
 };
 
 static inline bool deleg_is_read(u32 dl_type)

-- 
2.53.0


