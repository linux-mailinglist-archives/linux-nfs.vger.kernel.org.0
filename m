Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDC044689A
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Nov 2021 19:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhKESr0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Nov 2021 14:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231904AbhKESrY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Nov 2021 14:47:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CCC661186
        for <linux-nfs@vger.kernel.org>; Fri,  5 Nov 2021 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636137884;
        bh=rcHD4hAf8x0Zpr6Ab7Ns3fgbqvBFYTyeiAHHsbVzxyY=;
        h=From:To:Subject:Date:From;
        b=bGxoXWy4Exe5z/+JsSklhpeRtTi3kphi/x0RHUbv6A29rrHU8+AUUvped6LGvHoap
         N/DUaI4/6Jz281zXtb5lvjYMZNlqxJvdL4PuLI4J/0EHc3FHF2mxi8CNv4QfFp5Pkw
         opQKJoJR7wqmjsrws1S3WTC8pCHR80T7H9Enzt0b0xXT5YC8rvkNGsTcOu+lyubtsr
         yh3qdCLIJDXvjS5/UVnzLcvbAXifQX+9GGDK1rh+Jk+oDYE0LN4gvrf+szo9SvEFpK
         elzbTMGsHBnKs005QS9Kd4bs1RsIggSdlBZ5qD0qUM3R3PQjzCxNm+QBHKXWwqUNHu
         gAyhTxI+jbOpQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Remove unnecessary 'minor version' check
Date:   Fri,  5 Nov 2021 14:38:16 -0400
Message-Id: <20211105183816.328639-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

It is completely redundant to the server capability check.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b81b2d2f47ad..b4cb75c45f90 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -378,14 +378,10 @@ void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
 
 struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags)
 {
-	struct nfs4_label *label = NULL;
-	int minor_version = server->nfs_client->cl_minorversion;
-
-	if (minor_version < 2)
-		return label;
+	struct nfs4_label *label;
 
 	if (!(server->caps & NFS_CAP_SECURITY_LABEL))
-		return label;
+		return NULL;
 
 	label = kzalloc(sizeof(struct nfs4_label), flags);
 	if (label == NULL)
-- 
2.33.1

