Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1116A9713
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Mar 2023 13:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjCCMQM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Mar 2023 07:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCCMQL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Mar 2023 07:16:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F95F53A
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 04:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC5F1617FB
        for <linux-nfs@vger.kernel.org>; Fri,  3 Mar 2023 12:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B45BC4339C;
        Fri,  3 Mar 2023 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845769;
        bh=NDJF/TFU4uRBVwWzlv6UNRp72n5x20LYx6vr92kzbck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTWbyOIJesIDKlSIFv/CmqT/EllRZ6I39fXD+oyEk7aybr+hrht/CAo6ktO7pXH8q
         35ym8uQ6Y84m8HT/t5N82hiuiRGAE1FQt8tvOT8LMpk7rCqGCdLKVdzZFp3VUlpDKW
         yzQME7zggLSsz7HJTlAcCKzAltjemJ7Yrnm26xa3czxiXLqFb0VoIbX2qKlHRYtgh7
         30Hde77K2wuRd29osPNJnSTUcruS5KnTWGFkEKIkmsTXsO61zYaKYtRRnyuFo4wIW4
         wo9HtvIrwCDT0Udwg6ielNVufG+/rIt9GO05nx0dMWkTh4x9uxE4/qDlypwJhqel3a
         sJHpYNNnapUBQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, yoyang@redhat.com
Subject: [PATCH 5/7] lockd: server should unlock lock if client rejects the grant
Date:   Fri,  3 Mar 2023 07:16:01 -0500
Message-Id: <20230303121603.132103-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303121603.132103-1-jlayton@kernel.org>
References: <20230303121603.132103-1-jlayton@kernel.org>
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

Currently lockd just dequeues the block and ignores it if the client
sends a GRANT_RES with a status of nlm_lck_denied. That status is an
indicator that the client has rejected the lock, so the right thing to
do is to unlock the lock we were trying to grant.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2063818
Reported-by: Yongcheng Yang <yoyang@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svclock.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 4e30f3c50970..c43ccdf28ed9 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -954,19 +954,32 @@ void
 nlmsvc_grant_reply(struct nlm_cookie *cookie, __be32 status)
 {
 	struct nlm_block	*block;
+	struct file_lock	*fl;
+	int			error;
 
 	dprintk("grant_reply: looking for cookie %x, s=%d \n",
 		*(unsigned int *)(cookie->data), status);
 	if (!(block = nlmsvc_find_block(cookie)))
 		return;
 
-	if (status == nlm_lck_denied_grace_period) {
+	switch (status) {
+	case nlm_lck_denied_grace_period:
 		/* Try again in a couple of seconds */
 		nlmsvc_insert_block(block, 10 * HZ);
-	} else {
+		break;
+	case nlm_lck_denied:
+		/* Client doesn't want it, just unlock it */
+		nlmsvc_unlink_block(block);
+		fl = &block->b_call->a_args.lock.fl;
+		fl->fl_type = F_UNLCK;
+		error = vfs_lock_file(fl->fl_file, F_SETLK, fl, NULL);
+		if (error)
+			pr_warn("lockd: unable to unlock lock rejected by client!\n");
+		break;
+	default:
 		/*
-		 * Lock is now held by client, or has been rejected.
-		 * In both cases, the block should be removed.
+		 * Either it was accepted or the status makes no sense
+		 * just unlink it either way.
 		 */
 		nlmsvc_unlink_block(block);
 	}
-- 
2.39.2

