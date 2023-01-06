Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE20660374
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 16:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjAFPjP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 10:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjAFPjI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 10:39:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E710876820
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 07:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A25C4B81DA5
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 15:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06588C433D2;
        Fri,  6 Jan 2023 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673019543;
        bh=YI1EgRfIL23H/lrhRZh/vL63jTkmc7NFYAalGEm1TEY=;
        h=From:To:Cc:Subject:Date:From;
        b=aIKyBJjTEDzb9qc6FNRM8CosNgGSFV1j6vlFNL0DUKa1KDuHeobwfoBidsoPjvn3X
         IzbBK33y9G6sTxEQfUjFVEUa2VcB4on0TUl/qf+o72BPdhnBmvXaOutjQ5535NM8w1
         t1fWOD53hNYzqhYPcs/6g6McbkI/RUVpt7tu3c/noXLMlsBunbhU7Mq+Y6oWDJEwC/
         n1HcwDkvmPf7UMLkWZvhB7sqaZ48R51tK4Tn7YqBoVSg+CzSA9yHHi/7ZtbMnyKQoD
         NRjAiNAwm7Jmw3yZtqWwcXKxck1V+AlSlW74aSLyBp0oTTyDq1lQZy13Ph+U1eGgri
         JWGsidDiTvHlA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries
Date:   Fri,  6 Jan 2023 10:39:00 -0500
Message-Id: <20230106153901.105230-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since v4 files are expected to be long-lived, there's little value in
closing them out of the cache when there is conflicting access.

Change the comparator to also match the gc value in the key. Change both
of the current users of that key to set the gc value in the key to
"true".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index d630b4b74783..3b52c1888421 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -175,6 +175,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
 
 	switch (key->type) {
 	case NFSD_FILE_KEY_INODE:
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
+			return 1;
 		if (nf->nf_inode != key->inode)
 			return 1;
 		break;
@@ -683,6 +685,7 @@ nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_INODE,
 		.inode	= inode,
+		.gc	= true,
 	};
 	struct nfsd_file *nf;
 
@@ -1059,6 +1062,7 @@ nfsd_file_is_cached(struct inode *inode)
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_INODE,
 		.inode	= inode,
+		.gc	= true,
 	};
 	bool ret = false;
 
-- 
2.39.0

