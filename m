Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD0672505
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjARRc1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjARRcH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:32:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE413801D
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:31:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79D3AB81E14
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6E2C433EF;
        Wed, 18 Jan 2023 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674063104;
        bh=3kNURuXV5VsUjoqAAWDksFKLe/DfV9UoeeIFj3Rmj8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xj9NFwb3KmwaLoKkhDcLeLqcbqqKspcZ1CcwGytjWjYDK2LQmPRWlsCuM0QhikYA6
         yYYGUdFvA7ItKrXmkMNqzwZbAs71x8vo1V36EPPDsM24/B4JjUY5uFzERVTtNoSUxD
         5r8Kaud+/6ueT7lwK4OZ7CsJ7zV5gyup1hnD1MRu5TIVkYHIwB2g8pg5pj4Vj0BojU
         KK8TzlGJ8o/WSvNTa/N2GgDkNM67eTB2F2gBKB3LPh6pfGEhxKc1/DAU7mqi5RT+Z1
         Y6lbl047TmXagPHPluBHvAJjbt6b/0CXJ6R2zbz4sOFVajdGd4GP1+wyx/ZzSckYJu
         SIRm6y5059WNQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/6] nfsd: eliminate __nfs4_get_fd
Date:   Wed, 18 Jan 2023 12:31:39 -0500
Message-Id: <20230118173139.71846-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118173139.71846-1-jlayton@kernel.org>
References: <20230118173139.71846-1-jlayton@kernel.org>
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

This is wrapper is pointless, and just obscures what's going on.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 06a95f25c522..e61b878a4b45 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -599,12 +599,6 @@ put_nfs4_file(struct nfs4_file *fi)
 	}
 }
 
-static struct nfsd_file *
-__nfs4_get_fd(struct nfs4_file *f, int oflag)
-{
-	return nfsd_file_get(f->fi_fds[oflag]);
-}
-
 static struct nfsd_file *
 find_writeable_file_locked(struct nfs4_file *f)
 {
@@ -612,9 +606,9 @@ find_writeable_file_locked(struct nfs4_file *f)
 
 	lockdep_assert_held(&f->fi_lock);
 
-	ret = __nfs4_get_fd(f, O_WRONLY);
+	ret = nfsd_file_get(f->fi_fds[O_WRONLY]);
 	if (!ret)
-		ret = __nfs4_get_fd(f, O_RDWR);
+		ret = nfsd_file_get(f->fi_fds[O_RDWR]);
 	return ret;
 }
 
@@ -637,9 +631,9 @@ find_readable_file_locked(struct nfs4_file *f)
 
 	lockdep_assert_held(&f->fi_lock);
 
-	ret = __nfs4_get_fd(f, O_RDONLY);
+	ret = nfsd_file_get(f->fi_fds[O_RDONLY]);
 	if (!ret)
-		ret = __nfs4_get_fd(f, O_RDWR);
+		ret = nfsd_file_get(f->fi_fds[O_RDWR]);
 	return ret;
 }
 
@@ -663,11 +657,11 @@ find_any_file(struct nfs4_file *f)
 	if (!f)
 		return NULL;
 	spin_lock(&f->fi_lock);
-	ret = __nfs4_get_fd(f, O_RDWR);
+	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
 	if (!ret) {
-		ret = __nfs4_get_fd(f, O_WRONLY);
+		ret = nfsd_file_get(f->fi_fds[O_WRONLY]);
 		if (!ret)
-			ret = __nfs4_get_fd(f, O_RDONLY);
+			ret = nfsd_file_get(f->fi_fds[O_RDONLY]);
 	}
 	spin_unlock(&f->fi_lock);
 	return ret;
-- 
2.39.0

