Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5F34DCE0
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC3ATM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhC3ASk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28B7361985
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063519;
        bh=V5X6yA3MN6KRnuZ82v7bhzecoijFgN0fpVDH5KVCCl0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=m6cJHcr/h4+U9oe73ajDtX7vY+XViZk+wyssnO/4o693QjoTr2xulUUd7Tu4vhXAm
         Ur+YQ7ukri4Map0oXFMcIxWsDaJGij4WNxnsgfcwHJFgUnwHVI6hqUCi/YrGTooC5X
         u5PBolUBdPGuLbpdFvN5nxMBJ3kc4KHVX/hQMJ1uxRATyOron6I3bX9bCfyRY1p+FH
         CEzUYNYETxo3J0eRVC2un0NdXKOPz2i2SSeSJC7BGw2PL5hgzEavhEDXB/I504BMmU
         GPZLZr1JKiOEFNxl2WS0ISt9Oj2IXJaTokNeM2And1iW5pA89biWbmlmVNZFtccdhT
         QEOjA2wyNAyeA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/17] NFS: Fix up inode cache tracing
Date:   Mon, 29 Mar 2021 20:18:20 -0400
Message-Id: <20210330001835.41914-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-2-trondmy@kernel.org>
References: <20210330001835.41914-1-trondmy@kernel.org>
 <20210330001835.41914-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add missing enum definitions and missing entries for
nfs_show_cache_validity().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfstrace.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 5a59dcdce0b2..cdba6eebe3cb 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -45,6 +45,9 @@ TRACE_DEFINE_ENUM(NFS_INO_INVALID_CTIME);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_MTIME);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_SIZE);
 TRACE_DEFINE_ENUM(NFS_INO_INVALID_OTHER);
+TRACE_DEFINE_ENUM(NFS_INO_DATA_INVAL_DEFER);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_BLOCKS);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_XATTR);
 
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
@@ -60,6 +63,8 @@ TRACE_DEFINE_ENUM(NFS_INO_INVALID_OTHER);
 			{ NFS_INO_INVALID_MTIME, "INVALID_MTIME" }, \
 			{ NFS_INO_INVALID_SIZE, "INVALID_SIZE" }, \
 			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" }, \
+			{ NFS_INO_DATA_INVAL_DEFER, "DATA_INVAL_DEFER" }, \
+			{ NFS_INO_INVALID_BLOCKS, "INVALID_BLOCKS" }, \
 			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" })
 
 TRACE_DEFINE_ENUM(NFS_INO_ADVISE_RDPLUS);
-- 
2.30.2

