Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64139057F
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhEYPeH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 11:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhEYPeD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 May 2021 11:34:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A710861260
        for <linux-nfs@vger.kernel.org>; Tue, 25 May 2021 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621956753;
        bh=rYJN+2NHKR3vhkKyU0i4tiOckY3G/n5xWgAvhLK7VeA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=B73rImv7mZzKUiO+8fp2D8izysB3meIfUeUa5H6NpLedYd1Ti4GREbAa7pQPOv/mz
         +HfRoJwo9g6h0rE41sryc2dgCkamMw+iR0XtSucELWdrgFrW0eP2I+Czzdm296QNjK
         dGLUfMs/x0hRXMYavUw3091cPBHvYEECJiWWaeDdNhfSzvL3eXIlfn8uo0gxcjaoE5
         Bl7XFAARM+2yFDh5bLabstKnDFgBjoSi4MmTAVUCgkCDe+f8QZfLIltGn3K8gWI2gs
         oFTfont5TGKEUpR6tz2xuK/n5OtjnCSt7zqEU5crbl9I7gf7AnLxSU242CZzAsVqTU
         EZje1eR1T0fZA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFS: Clean up reset of the mirror accounting variables
Date:   Tue, 25 May 2021 11:32:31 -0400
Message-Id: <20210525153231.240329-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525153231.240329-2-trondmy@kernel.org>
References: <20210525153231.240329-1-trondmy@kernel.org>
 <20210525153231.240329-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index a5d3e2a12ae9..855f159fe9da 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -810,6 +810,13 @@ static void nfs_pgio_release(void *calldata)
 	hdr->completion_ops->completion(hdr);
 }
 
+static void nfs_pageio_mirror_reset(struct nfs_pgio_mirror *mirror)
+{
+	mirror->pg_count = 0;
+	mirror->pg_base = 0;
+	mirror->pg_recoalesce = 0;
+}
+
 static void nfs_pageio_mirror_init(struct nfs_pgio_mirror *mirror,
 				   unsigned int bsize)
 {
@@ -1133,9 +1140,7 @@ static void nfs_pageio_doio(struct nfs_pageio_descriptor *desc)
 	}
 	if (list_empty(&mirror->pg_list)) {
 		mirror->pg_bytes_written += mirror->pg_count;
-		mirror->pg_count = 0;
-		mirror->pg_base = 0;
-		mirror->pg_recoalesce = 0;
+		nfs_pageio_mirror_reset(mirror);
 	}
 }
 
@@ -1225,9 +1230,7 @@ static int nfs_do_recoalesce(struct nfs_pageio_descriptor *desc)
 
 	do {
 		list_splice_init(&mirror->pg_list, &head);
-		mirror->pg_count = 0;
-		mirror->pg_base = 0;
-		mirror->pg_recoalesce = 0;
+		nfs_pageio_mirror_reset(mirror);
 
 		while (!list_empty(&head)) {
 			struct nfs_page *req;
@@ -1275,9 +1278,7 @@ static void nfs_pageio_error_cleanup(struct nfs_pageio_descriptor *desc)
 		mirror = nfs_pgio_get_mirror(desc, midx);
 		desc->pg_completion_ops->error_cleanup(&mirror->pg_list,
 				desc->pg_error);
-		mirror->pg_count = 0;
-		mirror->pg_base = 0;
-		mirror->pg_recoalesce = 0;
+		nfs_pageio_mirror_reset(mirror);
 	}
 }
 
-- 
2.31.1

