Return-Path: <linux-nfs+bounces-9824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C507DA24BB5
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 20:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59923A6893
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822FA1CC881;
	Sat,  1 Feb 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b055SIJe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539761CBEA4
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738439945; cv=none; b=C7+6B9YENbrn0KQgEvkdzfBgRijOP3Q8Z//67kjX/Bs/qFJbN5f4a084U4ZzRVlUKgpwG0fK12sks3awVuWlSLdI7hUQ+l+AhwJy6XeLSSD0JWFgtIP/SThjMeupRB7j8QftNbEL8WHYmodla9bF84v4CidmXA86tNxH9ROlUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738439945; c=relaxed/simple;
	bh=OkMFOun3CcqVpITDxaDL7rZfpu6Ja1NzUNUuIETr54E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fv5C3JvK/P34E2JSxpDbNCEmO6UVHEShr8vY/v9LfLROIwTe7YCwEO8dZcSd6uPntFw8hSbqjaCMT57OxPMWek8oz9TOQpCtYLQA+QpjHeZ64mUpZeblJOgxE7tgdgw6qC4TGluFxsE8p8rZumHAipzdPINPE2ONW0oJsBr+c4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b055SIJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAB4C4CED3;
	Sat,  1 Feb 2025 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738439944;
	bh=OkMFOun3CcqVpITDxaDL7rZfpu6Ja1NzUNUuIETr54E=;
	h=From:To:Cc:Subject:Date:From;
	b=b055SIJeWUgHuPpygPjk7BW1pulXspVIGTkBlNCeBnpE/bq/Tm0PRmUfalx80mqFv
	 eIf51yyHLU6BthgXzRGcOMOrYGBqUuUq2YrEMDo4H+W8r4c3OuYTgytP28gr4krL5o
	 G9fVSaKhO03r2w7qXBklUTSY/UpiJxOILBg1rlP2EBs+RD+LnTc0REaq/t0ZKGtAjL
	 3FIzibKDz7YB829a/uvQiIzYwBpV3x6nWtKwgeqGmo9Fu6JpnZZeSfpOS9TOUX6gBa
	 Kx2sHNOJgJ+OOQKLO8QiVu7w/e39jhtHBVlL0AF8bn5XJuAmF3qIkE6oBG1w3/NI4t
	 RoHkohGdQ/iXw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/2] NFS: O_DIRECT writes must check and adjust the file length
Date: Sat,  1 Feb 2025 14:59:02 -0500
Message-ID: <2e064c1d4ebaa8a58267fcd4f474e1a1e0089f38.1738439818.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

While it is uncommon for delegations to be held while O_DIRECT writes
are in progress, it is possible. The xfstests generic/647 and
generic/729 both end up triggering that state, and end up failing due to
the fact that the file size is not adjusted.

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219738
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index f45beea92d03..40e13c9a2873 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -130,6 +130,20 @@ static void nfs_direct_truncate_request(struct nfs_direct_req *dreq,
 		dreq->count = req_start;
 }
 
+static void nfs_direct_file_adjust_size_locked(struct inode *inode,
+					       loff_t offset, size_t count)
+{
+	loff_t newsize = offset + (loff_t)count;
+	loff_t oldsize = i_size_read(inode);
+
+	if (newsize > oldsize) {
+		i_size_write(inode, newsize);
+		NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
+		trace_nfs_size_grow(inode, newsize);
+		nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
+	}
+}
+
 /**
  * nfs_swap_rw - NFS address space operation for swap I/O
  * @iocb: target I/O control block
@@ -741,6 +755,7 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	struct nfs_direct_req *dreq = hdr->dreq;
 	struct nfs_commit_info cinfo;
 	struct nfs_page *req = nfs_list_entry(hdr->pages.next);
+	struct inode *inode = dreq->inode;
 	int flags = NFS_ODIRECT_DONE;
 
 	trace_nfs_direct_write_completion(dreq);
@@ -762,6 +777,10 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	}
 	spin_unlock(&dreq->lock);
 
+	spin_lock(&inode->i_lock);
+	nfs_direct_file_adjust_size_locked(inode, dreq->io_start, dreq->count);
+	spin_unlock(&inode->i_lock);
+
 	while (!list_empty(&hdr->pages)) {
 
 		req = nfs_list_entry(hdr->pages.next);
-- 
2.48.1


