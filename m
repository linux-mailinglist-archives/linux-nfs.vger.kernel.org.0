Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931D34D771E
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiCMRN1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiCMRNX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3408139CDC
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94D64B80CAD
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2406AC340F3
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191534;
        bh=QjZwwJ3HUUQO+XfH2y64vcVJH+KHF3AR7/ERcEVd28Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TIzFTOTIzF2KQCNC8+MJBux48u/BUKywVu47KPeC5QfGRpDDhJltpelVdvI/HAqof
         e2YVrsX540+9hVNvmX+DLy7r/Gh63yczDq9X/AcIk4loofj7VPlLwSzEx5pFZkNIPd
         H/E6vyjWRidT/v9T8dK8rgIP/6VZ7v/zL7bJsSvM+AP64hj3KN7BB0UN57/HJWL2zR
         eMheuXQkJSZp6nNFKH5cy5brgQiQOpkDExSud8A0Jw9x58Za5sJKx7V9xy6oGYZlUb
         96yas/+vyGxTdR5ZHVKIewdiJuRUFTS9boYI0uUzFmHCWNorXrCsBbhhXE+T22x3iw
         pNg8ZpdjPimlA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 26/26] NFS: Cache all entries in the readdirplus reply
Date:   Sun, 13 Mar 2022 13:05:57 -0400
Message-Id: <20220313170557.5940-27-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-26-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
 <20220313170557.5940-5-trondmy@kernel.org>
 <20220313170557.5940-6-trondmy@kernel.org>
 <20220313170557.5940-7-trondmy@kernel.org>
 <20220313170557.5940-8-trondmy@kernel.org>
 <20220313170557.5940-9-trondmy@kernel.org>
 <20220313170557.5940-10-trondmy@kernel.org>
 <20220313170557.5940-11-trondmy@kernel.org>
 <20220313170557.5940-12-trondmy@kernel.org>
 <20220313170557.5940-13-trondmy@kernel.org>
 <20220313170557.5940-14-trondmy@kernel.org>
 <20220313170557.5940-15-trondmy@kernel.org>
 <20220313170557.5940-16-trondmy@kernel.org>
 <20220313170557.5940-17-trondmy@kernel.org>
 <20220313170557.5940-18-trondmy@kernel.org>
 <20220313170557.5940-19-trondmy@kernel.org>
 <20220313170557.5940-20-trondmy@kernel.org>
 <20220313170557.5940-21-trondmy@kernel.org>
 <20220313170557.5940-22-trondmy@kernel.org>
 <20220313170557.5940-23-trondmy@kernel.org>
 <20220313170557.5940-24-trondmy@kernel.org>
 <20220313170557.5940-25-trondmy@kernel.org>
 <20220313170557.5940-26-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Even if we're not able to cache all the entries in the readdir buffer,
let's ensure that we do prime the dcache.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 033249a72e92..7e12102b29e7 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -789,6 +789,21 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 	dput(dentry);
 }
 
+static int nfs_readdir_entry_decode(struct nfs_readdir_descriptor *desc,
+				    struct nfs_entry *entry,
+				    struct xdr_stream *stream)
+{
+	int ret;
+
+	if (entry->fattr->label)
+		entry->fattr->label->len = NFS4_MAXLABELLEN;
+	ret = xdr_decode(desc, entry, stream);
+	if (ret || !desc->plus)
+		return ret;
+	nfs_prime_dcache(file_dentry(desc->file), entry, desc->dir_verifier);
+	return 0;
+}
+
 /* Perform conversion from xdr to cache array */
 static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				   struct nfs_entry *entry,
@@ -811,17 +826,10 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	xdr_set_scratch_page(&stream, scratch);
 
 	do {
-		if (entry->fattr->label)
-			entry->fattr->label->len = NFS4_MAXLABELLEN;
-
-		status = xdr_decode(desc, entry, &stream);
+		status = nfs_readdir_entry_decode(desc, entry, &stream);
 		if (status != 0)
 			break;
 
-		if (desc->plus)
-			nfs_prime_dcache(file_dentry(desc->file), entry,
-					desc->dir_verifier);
-
 		status = nfs_readdir_page_array_append(page, entry, &cookie);
 		if (status != -ENOSPC)
 			continue;
@@ -849,15 +857,19 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 
 	switch (status) {
 	case -EBADCOOKIE:
-		if (entry->eof) {
-			nfs_readdir_page_set_eof(page);
-			status = 0;
-		}
-		break;
-	case -ENOSPC:
+		if (!entry->eof)
+			break;
+		nfs_readdir_page_set_eof(page);
+		fallthrough;
 	case -EAGAIN:
 		status = 0;
 		break;
+	case -ENOSPC:
+		status = 0;
+		if (!desc->plus)
+			break;
+		while (!nfs_readdir_entry_decode(desc, entry, &stream))
+			;
 	}
 
 	if (page != *arrays)
-- 
2.35.1

