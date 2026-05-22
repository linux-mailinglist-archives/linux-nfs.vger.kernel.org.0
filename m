Return-Path: <linux-nfs+bounces-21835-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8x3bBUeyEGq+cgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21835-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:45:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CD5B991C
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 21:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B79C301AA4A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 19:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40E386425;
	Fri, 22 May 2026 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO3GEHDH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8683388E57;
	Fri, 22 May 2026 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478993; cv=none; b=D/HvGMEX/i5f4+H3MWhvFBHUP7l7Nq5JeS2pRrG2Or52f959g5//9pEZmnDQe47WDw/Qd5m3Oehm5QdTW///4Jt0c1x5DsfHuzw29Vvl+9Pu1VRCIoaPmnLt2GcD7LahcOdqc/X7+8b9XysUzDsYsaodO1PQcV4jCAdRJ7szI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478993; c=relaxed/simple;
	bh=t9jrSKxw8DBvKHYaGlpafp9/PesIsxu9ynLOhInymQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhKYM0VsIK2YSI8JyITsj4CF4L6oZCpxUyLUFGe2EonE4HY7t3Bje4pmhSqcQdXNcUcKKcnRFiKR3iB+OJwj1yfGINY2yCWsNFeoSRMc7Qw2wlE7saBqCFgVDflEKoQc4KRp+RBUsFwnW6+O4NBFIBXoBkXMHMipEAcwzNJvQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO3GEHDH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D941F0155E;
	Fri, 22 May 2026 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478988;
	bh=joa0PwE25gT61noxUy/rusA1r43LI/faaUBqfT44OAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cO3GEHDHsJdEvt3IJoYzIV9Y8ozkFjs2SaOR9fzLXjPA+5a4FvvVSL4C8oLN7bDH7
	 aKcY1ERvoOJb1sBd79wFWBTf/KXagtukdpvOfDMAZw/KluDl9nhJVKQ2FPoHAecSTX
	 N0SJDYVuCz7YY0+DZmkWnAx30RE6kQjXqlVTeDMn+YZkxK9Tq4VNIe/OabcwCrMmGm
	 vu5NLCfjS7/hJOihFIzrP9qPxIto0gz+sjN7aEQQEPcJTxYg+uiPLum1n5w+h32ana
	 D4ih2CHPlyVqgcwVYISao0cS5JNHTHe9cQS3VWgh/Ih/bekPm2Ha9zLzWS4ggDtgmA
	 x+aMSRGEbNQrg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 15:42:25 -0400
Subject: [PATCH v5 20/21] nfsd: track requested dir attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v5-20-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
In-Reply-To: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=t9jrSKxw8DBvKHYaGlpafp9/PesIsxu9ynLOhInymQA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqELGjZPpn+ZYdbMiFMIq/ZaaBNn7PbUH47tdPz
 ovCDEBr90GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahCxowAKCRAADmhBGVaC
 FROND/9tvDdp6nYJGlCgJ+ZHFiCV1FCNmh1D1u5RILIr8KabT1ocLAtP38D6M4rT7bp7mE/kyKq
 q8SaBtYk5eCcPTiiXjTrVpWLMu4jrYHe3NIwBGwG+JNOvsawYVetzwiujGYUVDjC+vDdq+E53D3
 HEGyagYO1CJIkdOSq16WIxtoLwDFSG8tcceSmsdoYd1SsIUTvQyTZwyE5eVF1HpBRztUchxgrvZ
 BKEuKpw5DruwTxTJ4bzyzCQ/9hu7X5rltNIVBB/5B0ilG9GiA+p+U/FQTZiHKa35YXZBfq7Q62r
 HwTHkwA7R7+N9SZnUqMnUgbi/zOexiovXfl3yPSqyJhJBNitfvp1FJkP7Hx+wqYVtS2DL8mfWC8
 fPw/uKF1acx5844/RyU5HTRkgfi0z+NAXRqM78+55dY9T3uxR049+kZJe+rXUQCxjw8N+XVmPbJ
 zyyhADmfICi1kIpK8zGjWjjgMYVNHpobw54REjcFs4MAPacS18mojVZgot4mmtUxQhGXINWKe1w
 yDe7XK6XHcrB97vWmXunxOAPdFFJ4iUxZeW8EFYMvyjnO35OtashI6+ZJ3dDI+f5i/2BIGolraN
 oAt0j01JkkCwAC2ZDRz5snPc9WjYT2xk3ZZ1QvOxHRHg2Ovc+Obno+LilzuQVnfRFDR/ikj1jC4
 Wn/vdVN6e7TDuVQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21835-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AE6CD5B991C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Track the union of requested and supported dir attributes in the
delegation. In a later patch this will be used to ensure that we
only encode the attributes in that union when sending
add/remove/rename updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  9 ++++++---
 fs/nfsd/nfs4state.c | 14 +++++++++++++-
 fs/nfsd/state.h     |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 1eed8f23551d..43da73a537ad 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2521,9 +2521,10 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -2570,6 +2571,8 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
 	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
 	gdd->gddr_child_attributes[0] = dd->dl_child_attrs[0];
 	gdd->gddr_child_attributes[1] = dd->dl_child_attrs[1];
+	gdd->gddr_dir_attributes[0] = dd->dl_dir_attrs[0];
+	gdd->gddr_dir_attributes[1] = dd->dl_dir_attrs[1];
 	nfs4_put_stid(&dd->dl_stid);
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ce740a94a634..6c808149f251 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9835,6 +9835,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
@@ -9904,10 +9913,13 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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
index 461abcee9e6c..62a5fe3f6cc0 100644
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
2.54.0


