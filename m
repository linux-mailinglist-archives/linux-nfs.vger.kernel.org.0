Return-Path: <linux-nfs+bounces-13497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D7B1E781
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 13:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FA21AA0287
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Aug 2025 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD883274FCD;
	Fri,  8 Aug 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7Rh1x+F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC59274B5B;
	Fri,  8 Aug 2025 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653271; cv=none; b=mtFtw5pUJGiaAOu4P+cwHBFGVQxgfl2qzdpFig4A87Jih5reoI2RKsPpNFLSeDlt9T+CqKeSYUVeoO+Wqi+3sHyfsNiBZQ5gQnnHyvMqsbVf3+DAFiFefOE/+Tthw9QaQEx6MieYr2nFrLAqb0FevZ+aosIMDVhZJunCLBMLkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653271; c=relaxed/simple;
	bh=CZVKUAHenl2LlUGd9AUz2lOcktD/ckrjcqgdg1ufbfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aq03L4sqeMtplH0ozqZoQeikeOz7HwAglSaeuwq1X6GJT3X/JmFk1LxAxmr19zG2CDrSkxD2UkpOvM0JBUVJZeEipSA0eqXG5DJVV2U3ZTfRxyROEdjWi/iKGzLfKiGSDiDqr7XN8/NN+915V6hAiOznqKOU5rjGm9NKuJfgLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7Rh1x+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E87C4CEF6;
	Fri,  8 Aug 2025 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653271;
	bh=CZVKUAHenl2LlUGd9AUz2lOcktD/ckrjcqgdg1ufbfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j7Rh1x+FUvnkKOv0XrzlWfJHpFJoq7tZwyyuvXjiR5PajCtEeu5wsOM+RzcnoyWgc
	 bVsN5PJzqS4DKPN34SAWWPBSYlN+rqpRYSLtqe8xjihBsp1OdoYJqowg8rH45/cirN
	 uxrTzsqEo+Mav6+Z0/LN6eRRhUOLMcXAGnhq5PcUUpaGpYV4UNLUHj9vo9a3+B0P2A
	 Gyz+T/WngqmwpYhWlHCvYrjqKyGATDPSUCEc5VdeNL+BkPiTBVE0A+FHLOg8THIrjq
	 K7iu+cWXnN0h5TPyj9nLYmv3XcjNAjzb9ngCTCqbHBddxYAa+PoPeYxiSVm4GITtrV
	 Lc1d78K4C61fA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 08 Aug 2025 07:40:32 -0400
Subject: [PATCH 3/5] nfs: new tracepoints around write handling
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-nfs-tracepoints-v1-3-f8fdebb195c9@kernel.org>
References: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
In-Reply-To: <20250808-nfs-tracepoints-v1-0-f8fdebb195c9@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4981; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CZVKUAHenl2LlUGd9AUz2lOcktD/ckrjcqgdg1ufbfw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoleJUgMyHvrem46KDKZtb8WFbu68IFDAs+UmEB
 bBLgymBYO2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJXiVAAKCRAADmhBGVaC
 FRaXD/0T8ojzs0WWsZTf5d5qXSwbB2gUp4PSqBgZlcp9Nwg80Mfm3BpCX0MyZoNHQsrF2lHQH2Z
 miJIhRSc5gu7DtrFS9F9XMNDmmCFMbX9CEtTZ6m8yh0giF0/qKef1YTVRy2UWk8biFOOtkoEcDA
 ZvOca6W8N7+D8x4KH+ZM2St5JETacKcyP46mpWpO25He0CW1RxhJoEH8MGqTs3URa7qVm846OTr
 A+QXyBy5+20bNV/K1ywH4y9YdfQZfQZ4cjpztu/eo2dVmfwLqdVI/KKi0do+WrwdFoYkKgVJxgK
 20O9teev1/D5C/Xjn/VsLXQqysUz4ykMxEk4+EkqK207/YwxkzFGdpfgJ5VwTmDVgcCgNs6Ct8W
 V+QYu3Qt++883ODgxGqg86kvrx2EBr4TloH1Vhxl4HnuZBeUb9i1V2xjROqudmlMHuhZd5qTDyq
 291DTBK8BFIJIDWlBEg1C0WqiItS77oSalTUBEByEOgLBtat7N2HhfYVghJ45pRpC6yC/+Q0fg0
 /TBJ0OPlRuAt0Zb9PUV1kHENX7Lhg+DhbddosNFrqkPphcscjwJczvSshXTPzwNadqZvlEK11aI
 jInxB/AdmD0DFmXF5TBVmExLT7Und8abzenEK/EATqmI63Oa/LIBZI9cR9IcwbVm5ZDzNvH/x1u
 nRG3AC5mSheDBvA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

New start and done tracepoints for:

nfs_update_folio()
nfs_write_begin()
nfs_write_end()
nfs_try_to_update_request()

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/file.c     | 16 +++++++++++++---
 fs/nfs/nfstrace.h | 13 +++++++++++++
 fs/nfs/write.c    | 10 +++++++++-
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1e89801abed626ea64cd79722fad8720b2485d32..058cb545ab8a2974e08810c0309e5a2040f82cc2 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -356,6 +356,8 @@ static int nfs_write_begin(const struct kiocb *iocb,
 	int once_thru = 0;
 	int ret;
 
+	trace_nfs_write_begin(file_inode(file), pos, len);
+
 	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
 
@@ -363,8 +365,10 @@ static int nfs_write_begin(const struct kiocb *iocb,
 start:
 	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, fgp,
 				    mapping_gfp_mask(mapping));
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
+		goto out;
+	}
 	*foliop = folio;
 
 	ret = nfs_flush_incompatible(file, folio);
@@ -379,6 +383,8 @@ static int nfs_write_begin(const struct kiocb *iocb,
 		if (!ret)
 			goto start;
 	}
+out:
+	trace_nfs_write_begin_done(file_inode(file), pos, len, ret);
 	return ret;
 }
 
@@ -392,6 +398,7 @@ static int nfs_write_end(const struct kiocb *iocb,
 	unsigned offset = offset_in_folio(folio, pos);
 	int status;
 
+	trace_nfs_write_end(file_inode(file), pos, len);
 	dfprintk(PAGECACHE, "NFS: write_end(%pD2(%lu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
 
@@ -420,13 +427,16 @@ static int nfs_write_end(const struct kiocb *iocb,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (status < 0)
+	if (status < 0) {
+		trace_nfs_write_end_done(file_inode(file), pos, len, status);
 		return status;
+	}
 	NFS_I(mapping->host)->write_io += copied;
 
 	if (nfs_ctx_key_to_expire(ctx, mapping->host))
 		nfs_wb_all(mapping->host);
 
+	trace_nfs_write_end_done(file_inode(file), pos, len, copied);
 	return copied;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index d7d25cdf0060b3fa7c5889752a1bd193d0e8ca92..b90eed094e639a532463cb5a3f6ba32c64431a6a 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1045,6 +1045,19 @@ DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_done);
 DEFINE_NFS_FOLIO_EVENT(nfs_invalidate_folio);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_launder_folio_done);
 
+DEFINE_NFS_FOLIO_EVENT(nfs_try_to_update_request);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_try_to_update_request_done);
+
+DEFINE_NFS_FOLIO_EVENT(nfs_update_folio);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_update_folio_done);
+
+DEFINE_NFS_FOLIO_EVENT(nfs_write_begin);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_write_begin_done);
+
+DEFINE_NFS_FOLIO_EVENT(nfs_write_end);
+DEFINE_NFS_FOLIO_EVENT_DONE(nfs_write_end_done);
+
+
 DECLARE_EVENT_CLASS(nfs_kiocb_event,
 		TP_PROTO(
 			const struct kiocb *iocb,
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 374fc6b34c7954ef781026e5114cf5411f366ecd..60138026053b992434c6fadc7bc53ebb5d8e8545 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1068,11 +1068,12 @@ static struct nfs_page *nfs_try_to_update_request(struct folio *folio,
 	unsigned int end;
 	int error;
 
+	trace_nfs_try_to_update_request(folio_inode(folio), offset, bytes);
 	end = offset + bytes;
 
 	req = nfs_lock_and_join_requests(folio);
 	if (IS_ERR_OR_NULL(req))
-		return req;
+		goto out;
 
 	rqend = req->wb_offset + req->wb_bytes;
 	/*
@@ -1094,6 +1095,9 @@ static struct nfs_page *nfs_try_to_update_request(struct folio *folio,
 	else
 		req->wb_bytes = rqend - req->wb_offset;
 	req->wb_nio = 0;
+out:
+	trace_nfs_try_to_update_request_done(folio_inode(folio), offset, bytes,
+					     PTR_ERR_OR_ZERO(req));
 	return req;
 out_flushme:
 	/*
@@ -1104,6 +1108,7 @@ static struct nfs_page *nfs_try_to_update_request(struct folio *folio,
 	nfs_mark_request_dirty(req);
 	nfs_unlock_and_release_request(req);
 	error = nfs_wb_folio(folio->mapping->host, folio);
+	trace_nfs_try_to_update_request_done(folio_inode(folio), offset, bytes, error);
 	return (error < 0) ? ERR_PTR(error) : NULL;
 }
 
@@ -1341,6 +1346,8 @@ int nfs_update_folio(struct file *file, struct folio *folio,
 
 	nfs_inc_stats(inode, NFSIOS_VFSUPDATEPAGE);
 
+	trace_nfs_update_folio(inode, offset, count);
+
 	dprintk("NFS:       nfs_update_folio(%pD2 %d@%lld)\n", file, count,
 		(long long)(folio_pos(folio) + offset));
 
@@ -1360,6 +1367,7 @@ int nfs_update_folio(struct file *file, struct folio *folio,
 	if (status < 0)
 		nfs_set_pageerror(mapping);
 out:
+	trace_nfs_update_folio_done(inode, offset, count, status);
 	dprintk("NFS:       nfs_update_folio returns %d (isize %lld)\n",
 			status, (long long)i_size_read(inode));
 	return status;

-- 
2.50.1


