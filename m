Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4068A171
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Feb 2023 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBCSSn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Feb 2023 13:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjBCSSn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Feb 2023 13:18:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C1A911A
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 10:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D9D5B82B94
        for <linux-nfs@vger.kernel.org>; Fri,  3 Feb 2023 18:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6EFC433EF;
        Fri,  3 Feb 2023 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675448316;
        bh=AQz63sNpX6Wi+JXZHJ4O7NLxdwGtXHBs5OM7Z996nXU=;
        h=From:To:Cc:Subject:Date:From;
        b=naryX1HK0IKifCOFQIydlbP/FxSked6K2FBBpBB/tg3OnkrnpO/hEpRAVjyff3ubw
         QSmcADCDCra97vCWULDU0cE3hdSSENI0t9FcOFKln8GE1geNLdQI88uGssI+Dn1chx
         HANUApfsXEv1PQ6DUdGtp46OEJCskq7zn29d/qXUuCNjBh9LPMKNG2BubblZycvpuE
         PDZRKABpKgUg7sj632TtJvP+wii83nzeUr1Tgoz889fANX9NSksae+Il3jrRNvq5pq
         K0qO99gVsrHA1LGNWxjlfKp3CKVcs7JPE4NmsR7xtj3AX34CbV3c5h20uInBHLQaC3
         aAq2mfHKECe5Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org,
        =?UTF-8?q?=E5=BC=B5=E6=99=BA=E8=AB=BA?= <cc85nod@gmail.com>,
        Dai Ngo <dai.ngo@oracle.com>
Subject: [PATCH] nfsd: fix courtesy client with deny mode handling in nfs4_upgrade_open
Date:   Fri,  3 Feb 2023 13:18:34 -0500
Message-Id: <20230203181834.58634-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nested if statements here make no sense, as you can never reach
"else" branch in the nested statement. Fix the error handling for
when there is a courtesy client that holds a conflicting deny mode.

Fixes: 3d69427151806 (NFSD: add support for share reservation conflict to courteous server)
Reported-by: 張智諺 <cc85nod@gmail.com>
Cc: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c39e43742dd6..af22dfdc6fcc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5282,16 +5282,17 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	/* test and set deny mode */
 	spin_lock(&fp->fi_lock);
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
-	if (status == nfs_ok) {
-		if (status != nfserr_share_denied) {
-			set_deny(open->op_share_deny, stp);
-			fp->fi_share_deny |=
-				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
-		} else {
-			if (nfs4_resolve_deny_conflicts_locked(fp, false,
-					stp, open->op_share_deny, false))
-				status = nfserr_jukebox;
-		}
+	switch (status) {
+	case nfs_ok:
+		set_deny(open->op_share_deny, stp);
+		fp->fi_share_deny |=
+			(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
+		break;
+	case nfserr_share_denied:
+		if (nfs4_resolve_deny_conflicts_locked(fp, false,
+				stp, open->op_share_deny, false))
+			status = nfserr_jukebox;
+		break;
 	}
 	spin_unlock(&fp->fi_lock);
 
-- 
2.39.1

