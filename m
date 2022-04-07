Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192DC4F83F6
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbiDGPrV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbiDGPqr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 11:46:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C92EC6B7A
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 08:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6927061EC5
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AFAC385A4
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649346272;
        bh=pj6f8DlWv3kPYUyaziTO0UM8iZIeqmqtlEJMypSzRhQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jvZG9czSd403JHlkKDkOZZaTdfMUJ06XR3QXX3FbR6HHlzV6fwLJI3gidpwL81TyH
         iqchSy+3pdTxhIsLFgW9tB1NDaNKnLHk9QeydtrW1F2U2TNJOiAayfCQwHFOQHRwuQ
         DgeXmgO1qfTKJPIS0N0UjCX11ufW4ulLZ377m7/Phjdny+wQS7mwo5PSL0Ili/Gzqe
         APARN66cODfiD8Bx5ldbFGqN8cCe7bJDbLMKiJpEaVDwOtMf7Njg8VNoJorE9c1uBp
         MG0AwcJeYzDYmEWQzIsxhZOkbOJiyDlDJxbeXiMXEmz64uoJ+06BcEcx4AhdxhX07j
         NoeRv06KnQGqw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/7] NFSv4/pnfs: Handle RPC allocation errors in nfs4_proc_layoutget
Date:   Thu,  7 Apr 2022 11:38:06 -0400
Message-Id: <20220407153809.1053261-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407153809.1053261-3-trondmy@kernel.org>
References: <20220407153809.1053261-1-trondmy@kernel.org>
 <20220407153809.1053261-2-trondmy@kernel.org>
 <20220407153809.1053261-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If rpc_run_task() fails due to an allocation error, then bail out early.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e3f5b380cefe..16106f805ffa 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9615,6 +9615,8 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout)
 	nfs4_init_sequence(&lgp->args.seq_args, &lgp->res.seq_res, 0, 0);
 
 	task = rpc_run_task(&task_setup_data);
+	if (IS_ERR(task))
+		return ERR_CAST(task);
 
 	status = rpc_wait_for_completion_task(task);
 	if (status != 0)
-- 
2.35.1

