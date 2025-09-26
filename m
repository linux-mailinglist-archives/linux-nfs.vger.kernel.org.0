Return-Path: <linux-nfs+bounces-14740-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37397BA44BC
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 16:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A85B624544
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405B1EBA1E;
	Fri, 26 Sep 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPIV39gU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8381E8337
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898315; cv=none; b=OgO/C1R+uZu8pt2pc6VOnbfl0c3uRfaNTFMYxi/PxCPgWA30ZMDAuFUGI5fqKf/I1pYF5hQjqyhvVuAITZKxm9v6V9WQ3wy5u5B16nPtMs0rHUe4QQFW9jAq4NrKaO1WSif/YtAh/cwIgpnUdqtcW/17WgwjctVz/o4mkhr3MqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898315; c=relaxed/simple;
	bh=AXfHLfoIW6jals9OvhKMBBLH00FN4D1LzK/al4wD0Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktWRF+n7CcRuQrAM1mwmB1TrC5yPl6J0ECkefSkH2l3X0+LHIodRu1u/CFjumthOg0y8bJcEWEjkLm/hPX69mylUArPRcL7MD74UL0MA4MzEPfD7ZAuT8MkGnWNeVlWGJAP/OlCq8P9GqNIj3HSjGcccZM5dif7yrk+WEg+lzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPIV39gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4073CC4CEF4;
	Fri, 26 Sep 2025 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758898314;
	bh=AXfHLfoIW6jals9OvhKMBBLH00FN4D1LzK/al4wD0Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPIV39gUTJdGhuvsn2Dv2XbYgxCX40mSrIFr5jdnkyBCvMPUCZSlvLscsOJoZx0zO
	 Bgw4cWNEptxsWHZudC/B4rtio7WbOJjAp52ObMrrnqPu1xRxSjyYGQSvWWeAjNxsBC
	 we0qs6sisWwFtgD6wGR81TvVZeeL/Z9jyGnN9kucHrtX1Nu/g2jb0r9Zf/ZMU0xOOg
	 LWXKrszgC9GHo1ktmslhGCe69ycNuxdgu0Y7TtXefFJmsEkl1juD753CFrBohVTZIw
	 tE9tiBw7MINoQbsoMg67HbynciVUI80Kz7zOIDDcdJ1le86e2zlnF05gsCIg+f80pS
	 5WIChugNAbBKA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v4 2/4] NFSD: pass nfsd_file to nfsd_iter_read()
Date: Fri, 26 Sep 2025 10:51:49 -0400
Message-ID: <20250926145151.59941-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926145151.59941-1-cel@kernel.org>
References: <20250926145151.59941-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@kernel.org>

Prepare for nfsd_iter_read() to use the DIO alignment stored in
nfsd_file by passing the nfsd_file to nfsd_iter_read() rather than
just the file which is associaed with the nfsd_file.

This means nfsd4_encode_readv() now also needs the nfsd_file rather
than the file.  Instead of changing the file arg to be the nfsd_file,
we discard the file arg as the nfsd_file (and indeed the file) is
already available via the "read" argument.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 8 ++++----
 fs/nfsd/vfs.c     | 7 ++++---
 fs/nfsd/vfs.h     | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 97e9e9afa80a..41f0d54d6e1b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4467,7 +4467,7 @@ static __be32 nfsd4_encode_splice_read(
 
 static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 				 struct nfsd4_read *read,
-				 struct file *file, unsigned long maxcount)
+				 unsigned long maxcount)
 {
 	struct xdr_stream *xdr = resp->xdr;
 	unsigned int base = xdr->buf->page_len & ~PAGE_MASK;
@@ -4478,7 +4478,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
 		return nfserr_resource;
 
-	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, file,
+	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
 				read->rd_offset, &maxcount, base,
 				&read->rd_eof);
 	read->rd_length = maxcount;
@@ -4525,7 +4525,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
-		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_readv(resp, read, maxcount);
 	if (nfserr) {
 		xdr_truncate_encode(xdr, eof_offset);
 		return nfserr;
@@ -5421,7 +5421,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	if (file->f_op->splice_read && splice_ok)
 		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
 	else
-		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_readv(resp, read, maxcount);
 	if (nfserr)
 		return nfserr;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2026431500ec..35880d3f1326 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1078,7 +1078,7 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * nfsd_iter_read - Perform a VFS read using an iterator
  * @rqstp: RPC transaction context
  * @fhp: file handle of file to be read
- * @file: opened struct file of file to be read
+ * @nf: opened struct nfsd_file of file to be read
  * @offset: starting byte offset
  * @count: IN: requested number of bytes; OUT: number of bytes read
  * @base: offset in first page of read buffer
@@ -1091,9 +1091,10 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1336,7 +1337,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
2.51.0


