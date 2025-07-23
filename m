Return-Path: <linux-nfs+bounces-13212-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04459B0F754
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 17:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F317AC298
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A11F5838;
	Wed, 23 Jul 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC7v+tB5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FA20013A
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285436; cv=none; b=NTQ9ArLettfmU1g7Bh32FNFq0PBrrUK0/5J1xDBCq4olLra6ssehn4wdRSxuXJES914J0amWFAWC24DGNJ4yykZcGJfEKZbrA85WxpBLPtI87D1Hm+qqesX4DAhrslgDZWexk3XfFw2pOInvObP57efbyOjBdmg4JfHZmv3Qwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285436; c=relaxed/simple;
	bh=phcD0xYctYRyjQC24j7l3FiqBweMy9EiaH0z+tHmeqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOGj0INibBjBEoUjViyDtRXJzQclXLRAZZgLPxgGxHOCwOhEvx1dYvuzsReovqDmgWObRnDlC2NCECzDNsTI+u0Eg3+/n7Y5cAMYhOIAPiAMdvAnKEgmoggP+I57aR5hrF2YwH0N26ftgyMoZ82HhgLrTaBdrmw23YRIo2XDqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC7v+tB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79D7C4CEE7;
	Wed, 23 Jul 2025 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285436;
	bh=phcD0xYctYRyjQC24j7l3FiqBweMy9EiaH0z+tHmeqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IC7v+tB5PZKOmchp+UQLI3MdHVnWV5WCcCeOKoxGs+vUVFMjYNexpr/4FmP9QlhgM
	 is610LuXeWsmaDjD798Rj8U4VwF952J9a6ecwJCqBRbJhSb5DkRTtgLNQo315OC12G
	 5WXO88EmJbgNJAWSnElpbtOX5GV+hRzl4JmS3jLYSUTS8QOVZskOCfMzp459wF82NW
	 bm74ft0liUwdfzLlaQuvU5/neYjQnX0tWSFdb6ALAO1yAXrP6/g2czQt2fyDQRZx60
	 HHlrFJZErLevu5CHRfIsWeMQ/VqJXbJ0FKHvp3ClGbjEqFNnanRSrJXiYRQ3bWlQY7
	 0cpyt+lN0MkkQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/5] NFSD: pass nfsd_file to nfsd_iter_read()
Date: Wed, 23 Jul 2025 11:43:48 -0400
Message-ID: <20250723154351.59042-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250723154351.59042-1-snitzer@kernel.org>
References: <20250723154351.59042-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepares for nfsd_iter_read() to use DIO alignment stored in nfsd_file.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 8 ++++----
 fs/nfsd/vfs.c     | 7 ++++---
 fs/nfsd/vfs.h     | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 15331c15ece8..c77279cb25f6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4465,7 +4465,7 @@ static __be32 nfsd4_encode_splice_read(
 
 static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 				 struct nfsd4_read *read,
-				 struct file *file, unsigned long maxcount)
+				 unsigned long maxcount)
 {
 	struct xdr_stream *xdr = resp->xdr;
 	unsigned int base = xdr->buf->page_len & ~PAGE_MASK;
@@ -4476,7 +4476,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
 		return nfserr_resource;
 
-	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, file,
+	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
 				read->rd_offset, &maxcount, base,
 				&read->rd_eof);
 	read->rd_length = maxcount;
@@ -4523,7 +4523,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
-		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_readv(resp, read, maxcount);
 	if (nfserr) {
 		xdr_truncate_encode(xdr, eof_offset);
 		return nfserr;
@@ -5419,7 +5419,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
-		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_readv(resp, read, maxcount);
 	if (nfserr)
 		return nfserr;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0c0f25b2c8e3..79439ad93880 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1075,7 +1075,7 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * nfsd_iter_read - Perform a VFS read using an iterator
  * @rqstp: RPC transaction context
  * @fhp: file handle of file to be read
- * @file: opened struct file of file to be read
+ * @nf: opened struct nfsd_file of file to be read
  * @offset: starting byte offset
  * @count: IN: requested number of bytes; OUT: number of bytes read
  * @base: offset in first page of read buffer
@@ -1088,9 +1088,10 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * returned.
  */
 __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		      struct file *file, loff_t offset, unsigned long *count,
+		      struct nfsd_file *nf, loff_t offset, unsigned long *count,
 		      unsigned int base, u32 *eof)
 {
+	struct file *file = nf->nf_file;
 	unsigned long v, total;
 	struct iov_iter iter;
 	struct kiocb kiocb;
@@ -1312,7 +1313,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (file->f_op->splice_read && nfsd_read_splice_ok(rqstp))
 		err = nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
 	else
-		err = nfsd_iter_read(rqstp, fhp, file, offset, count, 0, eof);
+		err = nfsd_iter_read(rqstp, fhp, nf, offset, count, 0, eof);
 
 	nfsd_file_put(nf);
 	trace_nfsd_read_done(rqstp, fhp, offset, *count);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 0c0292611c6d..fa46f8b5f132 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -121,7 +121,7 @@ __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				unsigned long *count,
 				u32 *eof);
 __be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				struct file *file, loff_t offset,
+				struct nfsd_file *nf, loff_t offset,
 				unsigned long *count, unsigned int base,
 				u32 *eof);
 bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);
-- 
2.44.0


