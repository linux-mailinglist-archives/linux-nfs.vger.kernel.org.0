Return-Path: <linux-nfs+bounces-21801-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LNgLAhQEGq4WAYAu9opvQ
	(envelope-from <linux-nfs+bounces-21801-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:46:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 334D45B45E4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 937FC30FBC3D
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D463AEF2E;
	Fri, 22 May 2026 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7X4unIO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76183A5E9F;
	Fri, 22 May 2026 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452985; cv=none; b=C/9YqmDza4QZsQhVrrmZntGps/6qdaMJZWya9QA0XF8D9D3Rfjm5+CBv7NnL+fgT0r9/nc+B2fI/X6BucgC+qYwDUsenLlO7TFNyQjisAnE3xdb00azQBg52Mj68OKfW+KmEqmQ1eEO0JP0xjNXVj55NOtoGypDJZ9UszFckl+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452985; c=relaxed/simple;
	bh=NWvvem3CW6rxu7DKwqXTlkFQFX+XJDKIa2pHqduYekY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtWHOpipZUXaSNmY/9dhSUfMMASGEBb2vN9NsmKRudPpnU7EGFd0A3VRHGNxDDXt8CdF7nhf8aX5tgRV51KybYuAcO7LnUa9P5GRMyzeCMgyBYU3i+Br4wqd/1wC2NQl39CyaZbHHB3Re+0ZMc/bvCwimTJ8BL/wIpk6XOiwMMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7X4unIO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176711F0155F;
	Fri, 22 May 2026 12:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452983;
	bh=r83rwBwe//1WtoEhr33QAfdCCDq5UmpT/2oTOLquYB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k7X4unIObTLQq0J+xcUUXSTe/gfLT1IJwObzz2wnv60yhXpzMsfA1L/fqqCwxNCzb
	 2AKR5fsB6zsZz6I/vRMpyAPnR1hNMJ5olb/Sz35bhls0vHKtuRQ8UrcCQlmuons7gv
	 XQ26sq7Zpm5NR+bs4WpfceKvZn/cX11+4J7xEH64C390cgDa2NkQNtlmCSEQfSO/tY
	 oahAhcUKepTREoSAQuiYeicD9ORYppjaCzc+NeRn1fEOo4tafKq02BFsbS2g4ssXC1
	 MvY73Wc7RVlEVzkhXUYTi3lZtXMVPgXuMtyuJyKMZhn7vY2k7A00qxnuDPuG0sQNW+
	 tP/r2R6/8EtXg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:29:09 -0400
Subject: [PATCH v4 20/21] nfsd: track requested dir attributes
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-20-2acb883ac6bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3281; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NWvvem3CW6rxu7DKwqXTlkFQFX+XJDKIa2pHqduYekY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwShHsJ8URiPBlb6HOuNmPEYMJGlV2gIBZs6
 SlokQGq8+6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMEgAKCRAADmhBGVaC
 FWiND/0T1Z33y3Yd2JdtVJtcqmYoT6XaykYthLh1kXZz7J3GUk5q1GNT22haIPz/d8kmUxrhlTb
 DU1knScvOtwT2Z5ab+xq1q23LzULAczoLb/Cr43d1JWkh+zA10/J5a4wpneY/Z7xA9NwJSEH5ek
 OihvqeXLVMXAHX7/05vaSCigJQLzFWEFlz7k6Z/faWbVS4OGCKYXJbF0hnRDQrWRUN7cM/S5y8M
 fdRGQyk0YlITwEJx25s49gr9ztkBVL6r3iTU7NLt9jp81w6fDsKVFLCz6TXdyC6Wxn5iARulCDo
 z/dcP8HLrXWURFJQAq08XVJTXeM2J6AyaPxpmII0+1YVmPJkGI4COPLrmqM2BxbRecq8z+IfegK
 Q05Q4uTS8cVgpzR0d+IkkoJSvFzJnpX71mJKRM25owgmDfCXFH6gNT2EoLvzKmziFM/IyXs26BS
 Uomghpm2hs+NStAmhpQf9QrgZGOz0GN9aCJ7GLOy0pju59wjixZQvpBUxzANp0ex2MMeGuSmCXX
 9rh7/GIfYTZ0j8caMuf1ItQjhj1cN/R6AES29ZxHD0xlN+GthxiDJpVU27jk63J6FpGRXqCFM7O
 9qIjMZZ09s0MDewvvqTlbt/A0FiSmaxJqbegOFPmT2bYCY2XdVBV/KNqD/MfhgTlJc903CVO+ME
 myzU6iYKS2fhOZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21801-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 334D45B45E4
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
index 90055edc633b..4a078b51506b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9831,6 +9831,15 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
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
@@ -9900,10 +9909,13 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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


