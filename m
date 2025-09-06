Return-Path: <linux-nfs+bounces-14101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC0B474E6
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30AD1BC3E88
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE85258CD7;
	Sat,  6 Sep 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKXmh19M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E535257AC8
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176941; cv=none; b=dWH/RJComLINXsBjzcGk9OvTyXWVTKVbQ824AhzP3gbs6vxbGwmBTFPwpCFCy0FSE5vjxqEYlpYcgfrGx8HqCV1gShIkPamjvh00B3WkmbFh8B3fIbaeHTx+QmU4vU6qAFIKZkxAuhDq9kQK7ocyba+TkVDFrtEupRdBC02AmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176941; c=relaxed/simple;
	bh=h8H9gL0ZP6FnB1ixJuOd+Mxh2wQcP/L4qvoYTDwWyu4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfGvacpt0r80qSM7xkwruUz9J+2jk0eFHuUy06ATJAnHAQ5JmCM1pJMgPwj4cf/7uNmAS0NO9IZn28+jNSyMUNgZq6hKUnoESYC9pn1HBRw8Cll+BQzAPaAl9wI7B6wuTt6udoLUzwxtU3DO8SGnhRPCJTxF9ivyz7ZtSVom6lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKXmh19M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10443C4CEFA
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757176941;
	bh=h8H9gL0ZP6FnB1ixJuOd+Mxh2wQcP/L4qvoYTDwWyu4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KKXmh19MZXZ0pIDPhQtxDGizzgGKCUw0TdduxhjC/zllpYJ5Mc/AXwLze0p28ivK6
	 9ltA9pgUAr31a1/0QEPGRo8/ZNaxrzQ8mapBB8wIJyUtdivU0oYgvRo4jggVlSd7tC
	 ANgy6Mh399jUDPAXYgAPyOk5Oul+1blg0Fv4VIzbyyFH/Jt+bgAubNtSJfvkaoFI9V
	 f2yzSOHjyTwCL2jKKX762kHB5isxHxPkZBHY0KvNdWF3htZfI8sLZ06iWSAH/g8zjV
	 4jJ81dXI5uMfkMz7vaGZ3XbaljtTdQbH+30CivA4xQLbXf+fnjkgq43YygwBuulBvD
	 SQQ6Zlq9TvgQg==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/8] NFSv4.2: Serialise O_DIRECT i/o and copy range
Date: Sat,  6 Sep 2025 12:42:14 -0400
Message-ID: <b7aa4a0ebb7f8bd1901a9802d48de768f0afc9a6.1757176392.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757176392.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com> <cover.1757176392.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that all O_DIRECT reads and writes complete before copying a file
range, so that the destination is up to date.

Fixes: a5864c999de6 ("NFS: Do not serialise O_DIRECT reads and writes")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 1a169372ca16..6a0b5871ba3b 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -445,6 +445,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 		return status;
 	}
 
+	nfs_file_block_o_direct(NFS_I(dst_inode));
 	status = nfs_sync_inode(dst_inode);
 	if (status)
 		return status;
-- 
2.51.0


