Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F30C588308
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Aug 2022 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiHBUPv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Aug 2022 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiHBUPl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Aug 2022 16:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA4186E4
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 13:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45C9D6115A
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 20:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E142C433D6
        for <linux-nfs@vger.kernel.org>; Tue,  2 Aug 2022 20:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659471337;
        bh=VqN9wUXjS5oylqwX7/Coac3pLS5+vAUJdt2X/N2/gjI=;
        h=From:To:Subject:Date:From;
        b=HaelRN+a6W588WDQJp4WVOtUYcQ//Il0uTp0MYoIa0Uc0pgkKJdueMSnvY9vT6/22
         NEx2P7ZTFwCrG/8gqhf7YLcnPGeulpo3qOgza+3gRKm/sJZjPURIahMI8YNOeSIsEF
         67l6EcYZ3cD5qGQIiWePBfE0j6irjG2CKe69Zi+GNgDk7XpJVxFnXLgY6YRZZnw+Xj
         5PTmtoCVcgbvqQa/j7Yt6syY0Nk4uGbPHSstJ4blCF0Sv4mcfEpONoAWLePGDdnFpM
         zDjOowQnAq2BgY4vdWLu+oKQuGHnnKFI79HJZJt7rA/Qau49i928venHVZDMzvtSNS
         sg5bydjqBW9dg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4/pnfs: Fix a use-after-free bug in open
Date:   Tue,  2 Aug 2022 16:09:10 -0400
Message-Id: <20220802200910.381918-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If someone cancels the open RPC call, then we must not try to free
either the open slot or the layoutget operation arguments, since they
are likely still in use by the hung RPC call.

Fixes: 6949493884fe ("NFSv4: Don't hold the layoutget locks across multiple RPC calls")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2d7c14ade193..3ed14a2a84a4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3096,12 +3096,13 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	}
 
 out:
-	if (opendata->lgp) {
-		nfs4_lgopen_release(opendata->lgp);
-		opendata->lgp = NULL;
-	}
-	if (!opendata->cancelled)
+	if (!opendata->cancelled) {
+		if (opendata->lgp) {
+			nfs4_lgopen_release(opendata->lgp);
+			opendata->lgp = NULL;
+		}
 		nfs4_sequence_free_slot(&opendata->o_res.seq_res);
+	}
 	return ret;
 }
 
-- 
2.37.1

