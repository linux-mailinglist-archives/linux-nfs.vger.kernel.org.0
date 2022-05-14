Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3F0527208
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiENOdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiENOdQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:33:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB01C921
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81BC5B808D5
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD49C34118;
        Sat, 14 May 2022 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652538793;
        bh=XqCH6ObzSoxrvWct9VTFUaMTADQ3jzRx0P7yYzr2DdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xn7HjV1tdQDxNAR5JqaxElMUWedoT/ndLxX2OUbw9PlyaeERP8vnwx1TNcuuphHqO
         kxDa3GYSvcB17stbRv+qGb17LK1MLXVi7X85YVD4P2tL/0yQNub0gB0/yFmQYOIebu
         hVwGVlcj1Y7bMPWMzX+Dgsg2Jg6I68ZMYc4B9nQfQrB3j4QH/tn6kjg8R2mtz3JM1F
         +vFY1Id3zJA9yBx5ufPndi8JNHtPYB0S55Rg6nmbhzZmrYb7+ARHLfnzQaBNvZG7Wq
         iO549TUqh+ptJ8bggCL1LCFyXDggj6tpsKamYZ+SvyfOqXqROv0nBlD1adLl0AVutO
         Oc8LMXto1a56Q==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 4/5] NFS: Do not report flush errors in nfs_write_end()
Date:   Sat, 14 May 2022 10:27:03 -0400
Message-Id: <20220514142704.4149-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514142704.4149-4-trondmy@kernel.org>
References: <20220514142704.4149-1-trondmy@kernel.org>
 <20220514142704.4149-2-trondmy@kernel.org>
 <20220514142704.4149-3-trondmy@kernel.org>
 <20220514142704.4149-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we do flush cached writebacks in nfs_write_end() due to the imminent
expiration of an RPCSEC_GSS session, then we should defer reporting any
resulting errors until the calls to file_check_and_advance_wb_err() in
nfs_file_write() and nfs_file_fsync().

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with generic one")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 87e4cd5e8fe2..3f17748eaf29 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -386,11 +386,8 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 		return status;
 	NFS_I(mapping->host)->write_io += copied;
 
-	if (nfs_ctx_key_to_expire(ctx, mapping->host)) {
-		status = nfs_wb_all(mapping->host);
-		if (status < 0)
-			return status;
-	}
+	if (nfs_ctx_key_to_expire(ctx, mapping->host))
+		nfs_wb_all(mapping->host);
 
 	return copied;
 }
-- 
2.36.1

