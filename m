Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0EC3A499E
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Jun 2021 21:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhFKTxE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Jun 2021 15:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230129AbhFKTxE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Jun 2021 15:53:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FBC561285
        for <linux-nfs@vger.kernel.org>; Fri, 11 Jun 2021 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623441066;
        bh=OEISauP8k0bP2I5qtSH1pfJz7FcVQNzytEF/UNvO8jU=;
        h=From:To:Subject:Date:From;
        b=gr6II+rbdvjpvLd3cTHP9MAZdqXIvmD9apXEB22nz/yzT9QzBBfQ0pT1gva5TZosU
         hM84OCUrYeZfchz5hsDPZbIb6VnYMxkXKOlMi6UVckswPfCEr+nshnsarNQQqxlkNw
         iznzuCxTqMs6UxhHZ3Tt8mulowirse01453WyqnmX+ip59q2OCWLC3qFHxSGHR3qGx
         +Q2lW48MYHAlxSh6uI+nLXBV0P9+fBK1OzIZMGOJi51uY5EXQrdl+06iF79yEN0iLI
         sAwFFKuCGMquXyGmb6tQWyEmPJa3M4OeXiNhpMODUebyWxXaAHmivO6y5sX0TJyC7Y
         IXBCPGBtycrpQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Fix an Oops in pnfs_mark_request_commit() when doing O_DIRECT
Date:   Fri, 11 Jun 2021 15:51:04 -0400
Message-Id: <20210611195104.220192-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Fix an Oopsable condition in pnfs_mark_request_commit() when we're
putting a set of writes on the commit list to reschedule them after a
failed pNFS attempt.

Fixes: 9c455a8c1e14 ("NFS/pNFS: Clean up pNFS commit operations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2d30a4da49fa..2e894fec036b 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -700,8 +700,8 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 {
 	struct nfs_direct_req *dreq = hdr->dreq;
 	struct nfs_commit_info cinfo;
-	bool request_commit = false;
 	struct nfs_page *req = nfs_list_entry(hdr->pages.next);
+	int flags = NFS_ODIRECT_DONE;
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 
@@ -713,15 +713,9 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 
 	nfs_direct_count_bytes(dreq, hdr);
 	if (hdr->good_bytes != 0 && nfs_write_need_commit(hdr)) {
-		switch (dreq->flags) {
-		case 0:
+		if (!dreq->flags)
 			dreq->flags = NFS_ODIRECT_DO_COMMIT;
-			request_commit = true;
-			break;
-		case NFS_ODIRECT_RESCHED_WRITES:
-		case NFS_ODIRECT_DO_COMMIT:
-			request_commit = true;
-		}
+		flags = dreq->flags;
 	}
 	spin_unlock(&dreq->lock);
 
@@ -729,12 +723,15 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 
 		req = nfs_list_entry(hdr->pages.next);
 		nfs_list_remove_request(req);
-		if (request_commit) {
+		if (flags == NFS_ODIRECT_DO_COMMIT) {
 			kref_get(&req->wb_kref);
 			memcpy(&req->wb_verf, &hdr->verf.verifier,
 			       sizeof(req->wb_verf));
 			nfs_mark_request_commit(req, hdr->lseg, &cinfo,
 				hdr->ds_commit_idx);
+		} else if (flags == NFS_ODIRECT_RESCHED_WRITES) {
+			kref_get(&req->wb_kref);
+			nfs_mark_request_commit(req, NULL, &cinfo, 0);
 		}
 		nfs_unlock_and_release_request(req);
 	}
-- 
2.31.1

