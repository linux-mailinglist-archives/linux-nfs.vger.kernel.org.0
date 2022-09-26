Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31F25EB050
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Sep 2022 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiIZSms (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Sep 2022 14:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIZSlw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Sep 2022 14:41:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BF6765B
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 11:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7066B80D6A
        for <linux-nfs@vger.kernel.org>; Mon, 26 Sep 2022 18:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A55C43152;
        Mon, 26 Sep 2022 18:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664217664;
        bh=xpEap7HOqRKMq5Q/QJesxgmIWMtl4RumIJX0YUJgL40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QuUI56IKYuKTu+VioYH4xhBJGoRfuM+3cgEWHZlyCIZrWrtg3hwc0KRWGEN4oXYQ9
         klFFTVLWW8T3v4NUmMx7w5VZDNOyiOB8VEZnyXtypeJ6xpmCB1VfKmfZhAwMoarKQG
         rWlgg3oDk8gA8/S0uihwQbBHiUOXO1ZaJJV+H3n38uVSsDEc8ZtuLdxBdcb/YcUOuo
         1Ovxw45lsN1O273TwdFMkhxetx6AQ1Q52BVKGqBnow6PINVa2prdxJ/mN+VqpTnFEy
         g4J+mpRPO61EHalfy7/k1lkH87QU2Y/Yu1kkN6eoFNdLfn/AJvYgo2QQiGtDbuDhoE
         VtUfPuX79glYw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] nfsd: extra checks when freeing delegation stateids
Date:   Mon, 26 Sep 2022 14:41:02 -0400
Message-Id: <20220926184102.57254-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926184102.57254-1-jlayton@kernel.org>
References: <20220926184102.57254-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We've had some reports of problems in the refcounting for delegation
stateids that we've yet to track down. Add some extra checks to ensure
that we've removed the object from various lists before freeing it.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2127067
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c78c3223161e..198d7abf34e4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1060,7 +1060,12 @@ static struct nfs4_ol_stateid * nfs4_alloc_open_stateid(struct nfs4_client *clp)
 
 static void nfs4_free_deleg(struct nfs4_stid *stid)
 {
-	WARN_ON(!list_empty(&stid->sc_cp_list));
+	struct nfs4_delegation *dp = delegstateid(stid);
+
+	WARN_ON_ONCE(!list_empty(&stid->sc_cp_list));
+	WARN_ON_ONCE(!list_empty(&dp->dl_perfile));
+	WARN_ON_ONCE(!list_empty(&dp->dl_perclnt));
+	WARN_ON_ONCE(!list_empty(&dp->dl_recall_lru));
 	kmem_cache_free(deleg_slab, stid);
 	atomic_long_dec(&num_delegations);
 }
-- 
2.37.3

