Return-Path: <linux-nfs+bounces-19818-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPR1O4bRqWmYFgEAu9opvQ
	(envelope-from <linux-nfs+bounces-19818-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 19:55:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 520382172A2
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 19:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 106D93117294
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADCD2EC561;
	Thu,  5 Mar 2026 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkGcpx5D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80022EBBA4;
	Thu,  5 Mar 2026 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736795; cv=none; b=WJuPaDx5HqlV1uo0uMLOIElVGE/JtF6U1pthou4xfud2cCPAGuvEOw/kxVOHAPPX3wegTnA6BKA+6+DxevNIvHp3xy4Y1ydrtHV2wFFU9J+7EpoR2auYNBeITxEFsdvTSpHcjW2dEzxpDO6xo/JHn/G4z278mAIPC/S9NWQq3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736795; c=relaxed/simple;
	bh=pUQvmH62q2O6eU04poXvkWXDGCmvlv+pRppn5LiGz3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKeFZR2qmoK1cfm/EkbnJ0epbP2XGvx6SioxI9HXrsyNhic7BOHq+le/IFLNCtJfK2FkcJYGlhk6sjVjCvXu0iZebVtaKrdUwzjMTh+GVFwq/5/mU0YaS2cxXh7dZZBMYTOKFDAamoLt10Mc3QcE9iQ2f9RYUQ9DTOCS6qo4z3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkGcpx5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB279C19422;
	Thu,  5 Mar 2026 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772736795;
	bh=pUQvmH62q2O6eU04poXvkWXDGCmvlv+pRppn5LiGz3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tkGcpx5DiaPzSNgTrAbDbGAUtNDZUc0/3qFMJ1CN6CLZDKGk4NxlQB32Hk74r6952
	 Ettp7b+Pc1PScCnd7GC1ub7LQywzO3g5KlGzsAqXCvfXWiJKQYAM1KfYaIE5yq4aqd
	 Hz8Y0EvBgHO6ivIlaudc69K1TtJJ1ASbv62DqrXyXMiPPGxhm0AdXbs7JmEBbs02W9
	 wjd1kxfBfzHC1unl5aaymwXQ9rIjE9yhWdL0sKoXBnL8x647HsickjUCV/G71A1wlJ
	 0uOKdGdl2ETR5HL3x9xS/fEo/QniJzd+9IKqVffviwM5Cmx1+fj1h5SBIISL4QH1gr
	 zji7C1XBhjxnQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Mar 2026 13:53:04 -0500
Subject: [PATCH 2/2] nfs: update inode ctime after removexattr operation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-nfs-7-1-v1-2-e2200f69e543@kernel.org>
References: <20260305-nfs-7-1-v1-0-e2200f69e543@kernel.org>
In-Reply-To: <20260305-nfs-7-1-v1-0-e2200f69e543@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4123; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pUQvmH62q2O6eU04poXvkWXDGCmvlv+pRppn5LiGz3M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpqdEYn1kc8sRDr4A5o60VmBzy4eiw8w9CuAZkl
 bA+Ac8Qb86JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaanRGAAKCRAADmhBGVaC
 FZeLD/99ss8LG9n5TZ+JPUkF3bq8zUOmOjXUA/qvFueRQ8YrT7f/8OxIXPTXQtmqAXpLM+yOy5Y
 SzqHgnRb7BpM+HyW6b2Jir8K6d5duBsYqHx8mC7uPnkF0tYN5J7PDiUTZfx3d7NgzHzetDi2ivn
 aCCt4doEmlvwRdbaSuR/NwsbAUN5MgZs/c7Oa2isvMzsDDJMGwyC/qR2kiVsN+fmFezxEFm9+MA
 tvl4zXIJJFLgUCLdkJfSmSqDMfeS0yC9HRVTjKEUcCIG1XNo0c7wwudKdtAWQ9pp58ONVcHP9n+
 Q8W1Rby+aLBC1vEt2se8H5wHaZUMME6paryATDGJ6v6uqGgHuWQuN1VLT5EmB0+Rqr4ahADZrA8
 CutLb8oi3CScbDB8yaAIgh3HhydxIN60cdigag7f+gFwXF5tWEvBrKdWjS/fDwH2Iaf09+zpmeI
 1ccD7xkJ1KpI6JY6raFE+ZLqivwKLsdv2/WRwSGRZl+S1dOdu+vce3d6NcZuGeH+uXvS1eEJx13
 THCQvHr7Ol/EvEVom/2ZjOHrQbRALQNvqyHGt70ck+F0obcA21qNRSWkNm1YSjJEJE4VjKj54lU
 Epgt+YR3xiZXsyff2f2cKRjH6/AbOfOZsdR0kGeaillHqtVQh7a+IRFyF7cVwXoII3wqV+6tP0e
 6sTSV/II/Ijn+rQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 520382172A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19818-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,umich.edu:email]
X-Rspamd-Action: no action

xfstest generic/728 fails with delegated timestamps. The client does a
removexattr and then a stat to test the ctime, which doesn't change. The
stat() doesn't trigger a GETATTR because of the delegated timestamps, so
it relies on the cached ctime, which is wrong.

The setxattr compound has a trailing GETATTR, which ensures that its
ctime gets updated. Follow the same strategy with removexattr.

Reported-by: Olga Kornievskaia <aglo@umich.edu>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
 fs/nfs/nfs42xdr.c       | 10 ++++++++--
 include/linux/nfs_xdr.h |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc11c9d5a55b3621977ac83bb98f7c20 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *src_f, struct file *dst_f,
 static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
+	__u32 bitmask[NFS_BITMASK_SZ];
 	struct nfs42_removexattrargs args = {
 		.fh = NFS_FH(inode),
+		.bitmask = bitmask,
 		.xattr_name = name,
 	};
-	struct nfs42_removexattrres res;
+	struct nfs42_removexattrres res = {
+		.server = server,
+	};
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_REMOVEXATTR],
 		.rpc_argp = &args,
@@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
 	int ret;
 	unsigned long timestamp = jiffies;
 
+	res.fattr = nfs_alloc_fattr();
+	if (!res.fattr)
+		return -ENOMEM;
+
+	nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask,
+			 inode, NFS_INO_INVALID_CHANGE);
+
 	ret = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
 	    &res.seq_res, 1);
 	trace_nfs4_removexattr(inode, name, ret);
-	if (!ret)
+	if (!ret) {
 		nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
+		ret = nfs_post_op_update_inode(inode, res.fattr);
+	}
 
+	kfree(res.fattr);
 	return ret;
 }
 
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f721cfe01bfc60f5981396958084d627 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -263,11 +263,13 @@
 #define NFS4_enc_removexattr_sz		(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
-					 encode_removexattr_maxsz)
+					 encode_removexattr_maxsz + \
+					 encode_getattr_maxsz)
 #define NFS4_dec_removexattr_sz		(compound_decode_hdr_maxsz + \
 					 decode_sequence_maxsz + \
 					 decode_putfh_maxsz + \
-					 decode_removexattr_maxsz)
+					 decode_removexattr_maxsz + \
+					 decode_getattr_maxsz)
 
 /*
  * These values specify the maximum amount of data that is not
@@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(struct rpc_rqst *req,
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
 	encode_removexattr(xdr, args->xattr_name, &hdr);
+	encode_getfattr(xdr, args->bitmask, &hdr);
 	encode_nops(&hdr);
 }
 
@@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
 		goto out;
 
 	status = decode_removexattr(xdr, &res->cinfo);
+	if (status)
+		goto out;
+	status = decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685f46136a210c8e11c20a54d6ed9dad 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
 struct nfs42_removexattrargs {
 	struct nfs4_sequence_args	seq_args;
 	struct nfs_fh			*fh;
+	const u32			*bitmask;
 	const char			*xattr_name;
 };
 
 struct nfs42_removexattrres {
 	struct nfs4_sequence_res	seq_res;
 	struct nfs4_change_info		cinfo;
+	struct nfs_fattr		*fattr;
+	const struct nfs_server		*server;
 };
 
 #endif /* CONFIG_NFS_V4_2 */

-- 
2.53.0


