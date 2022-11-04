Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7E61A377
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 22:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKDViR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 17:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKDVh5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 17:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9720650F02
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 14:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F7E461A43
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 21:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE42C433D6
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667597872;
        bh=1EHBRFTuP+e9R2x30OuWd0ihg+JXlAjj8LctJ++Evy8=;
        h=From:To:Subject:Date:From;
        b=Rp9/vzCLOqSCzKg5Luxu39c4VF5Gff/xGIcGFAcLHScNs5zzPNBmeCBXqm4DcIsM3
         CFaC9/pKGsjEiE8X4BLeEc2gl+IOp5//kQQGkuGHeuLJ+fpDEjoUh0UHR2HDWqD8YO
         NJOeyM1y0EucxZ104aqBBONzrWeW9HIQ9ZbTLIJ2W5oPI6Vq5ZRxKavP2GPCks7AsT
         gGKuoGq5jPV8MgY18vFIMuzD0MiQmbefaX6ryJSfHCS3uyjur8JuTYVaKasLeqacBS
         enDaba2KaJDxXFxt7pyU3rU6UQJB0Wiw1dDHeKuavNpeWke9ytTnrIapqg9Gc1caD3
         o9QZaigIuT8gw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4: Fix a deadlock between nfs4_open_recover_helper() and delegreturn
Date:   Fri,  4 Nov 2022 17:31:26 -0400
Message-Id: <20221104213126.403303-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're asked to recover open state while a delegation return is
outstanding, then the state manager thread cannot use a cached open, so
if the server returns a delegation, we can end up deadlocked behind the
pending delegreturn.
To avoid this problem, let's just ask the server not to give us a
delegation unless we're explicitly reclaiming one.

Fixes: be36e185bd26 ("NFSv4: nfs4_open_recover_helper() must set share access")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bd89c7f06952..e51044a5f550 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2131,18 +2131,18 @@ static struct nfs4_opendata *nfs4_open_recoverdata_alloc(struct nfs_open_context
 }
 
 static int nfs4_open_recover_helper(struct nfs4_opendata *opendata,
-		fmode_t fmode)
+				    fmode_t fmode)
 {
 	struct nfs4_state *newstate;
+	struct nfs_server *server = NFS_SB(opendata->dentry->d_sb);
+	int openflags = opendata->o_arg.open_flags;
 	int ret;
 
 	if (!nfs4_mode_match_open_stateid(opendata->state, fmode))
 		return 0;
-	opendata->o_arg.open_flags = 0;
 	opendata->o_arg.fmode = fmode;
-	opendata->o_arg.share_access = nfs4_map_atomic_open_share(
-			NFS_SB(opendata->dentry->d_sb),
-			fmode, 0);
+	opendata->o_arg.share_access =
+		nfs4_map_atomic_open_share(server, fmode, openflags);
 	memset(&opendata->o_res, 0, sizeof(opendata->o_res));
 	memset(&opendata->c_res, 0, sizeof(opendata->c_res));
 	nfs4_init_opendata_res(opendata);
@@ -2724,10 +2724,15 @@ static int _nfs4_open_expired(struct nfs_open_context *ctx, struct nfs4_state *s
 	struct nfs4_opendata *opendata;
 	int ret;
 
-	opendata = nfs4_open_recoverdata_alloc(ctx, state,
-			NFS4_OPEN_CLAIM_FH);
+	opendata = nfs4_open_recoverdata_alloc(ctx, state, NFS4_OPEN_CLAIM_FH);
 	if (IS_ERR(opendata))
 		return PTR_ERR(opendata);
+	/*
+	 * We're not recovering a delegation, so ask for no delegation.
+	 * Otherwise the recovery thread could deadlock with an outstanding
+	 * delegation return.
+	 */
+	opendata->o_arg.open_flags = O_DIRECT;
 	ret = nfs4_open_recover(opendata, state);
 	if (ret == -ESTALE)
 		d_drop(ctx->dentry);
-- 
2.38.1

