Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECF611A8D
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJ1S5V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJ1S5U (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 14:57:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D312A1D2B58
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 11:57:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F767B82C88
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 18:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B3DC433D6;
        Fri, 28 Oct 2022 18:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666983437;
        bh=Fh57O2isAT251Px6qkrQwR+hkIPHdB8ywH4ZqCZZ5ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeYOB/G1p1bIUN6+jk4jdlTRMBMOVgRD0in7Ml4R53g7R9b/ZzYGfDifU/fAwRJmn
         +UNBbVjLajeCMKBckQCAP0KeGU4Ss3FjMxLop1WXhR/XtkiKx+hRZl+9S5//yDME47
         m5mMpu9vcqvea1NWkuV1ifUG4+izfhE87MBJ937Uf6gmf/QjQOAPZ7vnugYf+p36tK
         +PMO+ismYjIaq90MxBkNylDbcYgBIWfHAHWymq1fNH/DB72C0YtQzE6YICUy7cetMU
         QnfW6dyfbtWXxbyczn189XT4OPv2TzKRL6DVXc+bOwe4zlMIbvoWAZRBVEOSgzKv7r
         dMgdTN0PTLcCg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v3 4/4] nfsd: start non-blocking writeback after adding nfsd_file to the LRU
Date:   Fri, 28 Oct 2022 14:57:12 -0400
Message-Id: <20221028185712.79863-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028185712.79863-1-jlayton@kernel.org>
References: <20221028185712.79863-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a GC entry gets added to the LRU, kick off SYNC_NONE writeback
so that we can be ready to close it when the time comes. This should
help minimize delays when freeing objects reaped from the LRU.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 47cdc6129a7b..c43b6cff03e2 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -325,6 +325,20 @@ nfsd_file_fsync(struct nfsd_file *nf)
 		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 }
 
+static void
+nfsd_file_flush(struct nfsd_file *nf)
+{
+	struct file *file = nf->nf_file;
+	struct address_space *mapping;
+
+	if (!file || !(file->f_mode & FMODE_WRITE))
+		return;
+
+	mapping = file->f_mapping;
+	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+		filemap_flush(mapping);
+}
+
 static int
 nfsd_file_check_write_error(struct nfsd_file *nf)
 {
@@ -484,9 +498,14 @@ nfsd_file_put(struct nfsd_file *nf)
 
 		/* Try to add it to the LRU.  If that fails, decrement. */
 		if (nfsd_file_lru_add(nf)) {
-			/* If it's still hashed, we're done */
-			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
+			/*
+			 * If it's still hashed, we can just return now,
+			 * after kicking off SYNC_NONE writeback.
+			 */
+			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+				nfsd_file_flush(nf);
 				return;
+			}
 
 			/*
 			 * We're racing with unhashing, so try to remove it from
-- 
2.37.3

