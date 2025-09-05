Return-Path: <linux-nfs+bounces-14076-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25EAB45A87
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 16:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680D87C3A34
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A14350D6F;
	Fri,  5 Sep 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TalVwmEf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E341B661
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082640; cv=none; b=E6hdrJ+7Ssxg/iCghhXkbdhbALyGLnP8lj+8tLTQMbE0ebN/g3YEXeYJFTtoO+RsQpiLF4DGXfF3+M4ZEeE9jGDniPlWDAr3gCdx96JNdN4G/UbghoAzhvcXabNWy35EhH9A9dQ2ntk9XbiZnIVbGMgH77EmtzAhptne2CWFmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082640; c=relaxed/simple;
	bh=6ZU7tQNXq2BjBESJbyK1ETPcJ51tRNTgq35yQFYIYJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8Q2vwhOpectoXlFC1PvcwwyKOs23gZw03tuQM6H8257utMxPLPER5m6OEShZGAI3tIKNAp9QOka/2JbHb8297m3EKsIpIyRk3QnjSDJXUk23QwPRD0YbpHbkdQIDThOyK9O1nYqYyr5QEx+fiS8tbXD4zxfR3uZKOu7dmgliMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TalVwmEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8802C4CEF1;
	Fri,  5 Sep 2025 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757082640;
	bh=6ZU7tQNXq2BjBESJbyK1ETPcJ51tRNTgq35yQFYIYJY=;
	h=From:To:Cc:Subject:Date:From;
	b=TalVwmEfSiIFmFSrDj7zl+02dcnMLnSJbBHmz9pqIlZSKSzGMCQyqYEB+q9NRyKrp
	 HK9+XowOck0ILiNJsP/Mc6mvPM6Xo60rxKwiK+GUxPi7fJFgj8eUxdP1fj41p4L+H8
	 2vac/S+RyxJltcGdzR0c2ET0xV/l2BY98pWrziEtUFG5/DOZ3i1lD61UFT4tzewPud
	 vqG2o7jXTThny+MKn3h9bN89DAINQ6iTZpAMkcPCQYAukp9u9irkdQUw5U7CtHvc23
	 GCriNJHUh/namw0TderZ7YGEd8k0GYlHfYwky1LOd3VsbA3unE3x6JewQfNFWmIwgy
	 eKrvkMmWBUQIw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] NFSD: Do the grace period check in ->proc_layoutget
Date: Fri,  5 Sep 2025 10:30:37 -0400
Message-ID: <20250905143037.6467-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 8881 Section 18.43.3 states:
> If the metadata server is in a grace period, and does not persist
> layouts and device ID to device address mappings, then it MUST
> return NFS4ERR_GRACE (see Section 8.4.2.1).

Jeff observed that this suggests the grace period check is better
done by the individual layout type implementations, because checking
for the server grace period is unnecessary for some layout types.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/linux-nfs/7h5p5ktyptyt37u6jhpbjfd5u6tg44lriqkdc7iz7czeeabrvo@ijgxz27dw4sg/T/#t
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/blocklayout.c    | 7 +++++--
 fs/nfsd/flexfilelayout.c | 4 ++--
 fs/nfsd/nfs4proc.c       | 7 +------
 fs/nfsd/pnfs.h           | 4 ++--
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 0822d8a119c6..fde5539cf6a6 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -18,8 +18,8 @@
 
 
 static __be32
-nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
-		struct nfsd4_layoutget *args)
+nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
+		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	struct super_block *sb = inode->i_sb;
@@ -29,6 +29,9 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 	u32 device_generation = 0;
 	int error;
 
+	if (locks_in_grace(SVC_NET(rqstp)))
+		return nfserr_grace;
+
 	if (seg->offset & (block_size - 1)) {
 		dprintk("pnfsd: I/O misaligned\n");
 		goto out_layoutunavailable;
diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 3ca5304440ff..c318cf74e388 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -20,8 +20,8 @@
 #define NFSDDBG_FACILITY	NFSDDBG_PNFS
 
 static __be32
-nfsd4_ff_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
-		struct nfsd4_layoutget *args)
+nfsd4_ff_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
+		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
 	u32 device_generation = 0;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2dc8910f8f72..b79c267607d4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2435,7 +2435,6 @@ static __be32
 nfsd4_layoutget(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
 {
-	struct net *net = SVC_NET(rqstp);
 	struct nfsd4_layoutget *lgp = &u->layoutget;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
@@ -2487,10 +2486,6 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	if (lgp->lg_seg.length == 0)
 		goto out;
 
-	nfserr = nfserr_grace;
-	if (locks_in_grace(net))
-		goto out;
-
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lgp->lg_sid,
 						true, lgp->lg_layout_type, &ls);
 	if (nfserr) {
@@ -2502,7 +2497,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	if (atomic_read(&ls->ls_stid.sc_file->fi_lo_recalls))
 		goto out_put_stid;
 
-	nfserr = ops->proc_layoutget(d_inode(current_fh->fh_dentry),
+	nfserr = ops->proc_layoutget(rqstp, d_inode(current_fh->fh_dentry),
 				     current_fh, lgp);
 	if (nfserr)
 		goto out_put_stid;
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index dfd411d1f363..8654e63e72a7 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -29,8 +29,8 @@ struct nfsd4_layout_ops {
 	__be32 (*encode_getdeviceinfo)(struct xdr_stream *xdr,
 			const struct nfsd4_getdeviceinfo *gdevp);
 
-	__be32 (*proc_layoutget)(struct inode *, const struct svc_fh *fhp,
-			struct nfsd4_layoutget *lgp);
+	__be32 (*proc_layoutget)(struct svc_rqst *rqstp, struct inode *,
+			const struct svc_fh *fhp, struct nfsd4_layoutget *lgp);
 	__be32 (*encode_layoutget)(struct xdr_stream *xdr,
 			const struct nfsd4_layoutget *lgp);
 
-- 
2.50.0


