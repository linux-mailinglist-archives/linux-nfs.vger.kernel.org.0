Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFE7A3EC6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 01:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjIQXMH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Sep 2023 19:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbjIQXME (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Sep 2023 19:12:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E44611F
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 16:11:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4FBC433C8;
        Sun, 17 Sep 2023 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694992317;
        bh=aYfde5eM3WvCla80MMfJ6aK7fi7rG7vNHxS84KWVDLw=;
        h=From:To:Cc:Subject:Date:From;
        b=puiC0eNdfTijFs8dM2CurOPLZfOy1kGYFcyy7bDTwa8VnSIYwQz2g2S7VI+TCKQyo
         VnHIEmZmJfHiJLFCBQ/gr9WG0KgrmCII2SNcujwuOO8M+gKr93ySpQ/OjrJKpQSEN0
         FvmepNRFH+eQzXBmCWErnnuGFXbnd3/stDWVjrXjNxFzyctXHB+GOJb3e3S839VYxk
         frMNUSjCLmnJHC5JAyQRNvnxR/SmXGehPjnNOLrcmC0+WK5vpjlkwMkaQ/8iB81nIS
         VbkuLvNO4cePrWx0XiuVN4X1fxEaf8AFIAFODQ0nsCGh8a822MNvZ45DPsKCiqbFw2
         0QXoVooUnxd8A==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: [PATCH 1/2] NFSv4: Fix a nfs4_state_manager() race
Date:   Sun, 17 Sep 2023 19:05:50 -0400
Message-ID: <20230917230551.30483-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the NFS4CLNT_RUN_MANAGER flag got set just before we cleared
NFS4CLNT_MANAGER_RUNNING, then we might have won the race against
nfs4_schedule_state_manager(), and are responsible for handling the
recovery situation.

Fixes: aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index e079987af4a3..0bc160fbabec 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2703,6 +2703,13 @@ static void nfs4_state_manager(struct nfs_client *clp)
 		nfs4_end_drain_session(clp);
 		nfs4_clear_state_manager_bit(clp);
 
+		if (test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
+		    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING,
+				      &clp->cl_state)) {
+			memflags = memalloc_nofs_save();
+			continue;
+		}
+
 		if (!test_and_set_bit(NFS4CLNT_RECALL_RUNNING, &clp->cl_state)) {
 			if (test_and_clear_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state)) {
 				nfs_client_return_marked_delegations(clp);
-- 
2.41.0

