Return-Path: <linux-nfs+bounces-13453-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73837B1BD0D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054201836BF
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2929DB9A;
	Tue,  5 Aug 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8lGnh9/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4720B7ED
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436077; cv=none; b=iX24Jag/wXINBXBbduVJXb62+FaRZuMXKRm0ZS1SXfE2qty+XjHJOvUw7oKtJ7JbzDENzV6dMjn/SjmqwubAIkzvNfxIbH4sQ7nBBvND6c7qPp10BxgnCgo5sVq8xnAywwmFUvnKH5L9nENe0R1tUzmc37GJYQfhS7lDY/PS7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436077; c=relaxed/simple;
	bh=/9DIln/XpFLIMokQgtPS7zHhsfoGBIsux8fws1BCPL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clTkNx7P4w8vH44cRzvhV49gb2PCRVxHxtMGbIhtYH7LNqkjtoclpbGlSomCizMIEjMQfu7ksADWktCSoVL1q8h4VSmimmv3uYv1M7gbNTN9yrpxPr7An9wFCDGaIjlSR/a5Mgqk2rAiKsLg/lvRxfcqNHHTYwiUwZRqK63ZpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8lGnh9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEB4C4CEF0;
	Tue,  5 Aug 2025 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436077;
	bh=/9DIln/XpFLIMokQgtPS7zHhsfoGBIsux8fws1BCPL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8lGnh9/SKHwGP04u3F+guFYcRRpSGUvWSI8Zr80+EuXTrXlIi9petgOpCEjxUZFr
	 roid5GXsQK5yZRpRS1Uhd4ZQQvQa2M06iHcR9DvJ61kZRhpyXy262KilXFo9XzOnYw
	 Z1Whng7R1bgY+76rBsI+/mcjB0aPiS1K2u4ICTcSsbe1rn8FhkUD0wfmWeF+elbfER
	 Er7ShicWP6L0Lkw4gq5/WQxBTpzjENsDS4pUcoeXFnTEi/Q36DIxY95mKomSrLdcgT
	 i549+cjRrAISZI+K+XBZEBj23pdL80ffkv4AtC6zUQLuMpjq9wFQG65bTgEdbpTAgc
	 zyu+Cuhd3nsvw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 06/11] nfs/localio: add nfsd_file_dio_alignment
Date: Tue,  5 Aug 2025 19:21:01 -0400
Message-ID: <20250805232106.8656-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

And use it to avoid issuing misaligned IO using O_DIRECT.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c           | 25 +++++++++++++++++++++----
 fs/nfsd/localio.c          | 11 +++++++++++
 include/linux/nfslocalio.h |  2 ++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 2a6e1d3a764ba..932019c074a6e 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -322,12 +322,10 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 		return NULL;
 	}
 
+	init_sync_kiocb(&iocb->kiocb, file);
 	if (localio_O_DIRECT_semantics &&
-	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
-		iocb->kiocb.ki_filp = file;
+	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
 		iocb->kiocb.ki_flags = IOCB_DIRECT;
-	} else
-		init_sync_kiocb(&iocb->kiocb, file);
 
 	iocb->kiocb.ki_pos = hdr->args.offset;
 	iocb->hdr = hdr;
@@ -346,6 +344,25 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 		      hdr->args.count + hdr->args.pgbase);
 	if (hdr->args.pgbase != 0)
 		iov_iter_advance(i, hdr->args.pgbase);
+
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
+		/* Verify the IO is DIO-aligned as required */
+		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
+						&nf_dio_offset_align,
+						&nf_dio_read_offset_align);
+		if (dir == READ)
+			nf_dio_offset_align = nf_dio_read_offset_align;
+		/* direct I/O must be aligned to device logical sector size */
+		if (nf_dio_mem_align && nf_dio_offset_align &&
+		    (hdr->args.pgbase && (hdr->args.pgbase & (nf_dio_mem_align - 1)) == 0) &&
+		    (((hdr->args.offset | hdr->args.count) & (nf_dio_offset_align - 1)) == 0))
+			return 0;
+
+		/* Fallback to using buffered for this misaligned IO */
+		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
+		iocb->kiocb.ki_filp->f_flags &= ~O_DIRECT;
+	}
 }
 
 static void
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 269fa9391dc46..be710d809a3ba 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -117,12 +117,23 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	return localio;
 }
 
+static void nfsd_file_dio_alignment(struct nfsd_file *nf,
+				    u32 *nf_dio_mem_align,
+				    u32 *nf_dio_offset_align,
+				    u32 *nf_dio_read_offset_align)
+{
+	*nf_dio_mem_align = nf->nf_dio_mem_align;
+	*nf_dio_offset_align = nf->nf_dio_offset_align;
+	*nf_dio_read_offset_align = nf->nf_dio_read_offset_align;
+}
+
 static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_net_try_get  = nfsd_net_try_get,
 	.nfsd_net_put  = nfsd_net_put,
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
 	.nfsd_file_file = nfsd_file_file,
+	.nfsd_file_dio_alignment = nfsd_file_dio_alignment,
 };
 
 void nfsd_localio_ops_init(void)
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 59ea90bd136b6..3d91043254e64 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -64,6 +64,8 @@ struct nfsd_localio_operations {
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
+	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
+					u32 *, u32 *, u32 *);
 } ____cacheline_aligned;
 
 extern void nfsd_localio_ops_init(void);
-- 
2.44.0


