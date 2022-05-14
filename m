Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597915271BB
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiENOOb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiENOOZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CC61581D
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E24760F16
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89371C340EE;
        Sat, 14 May 2022 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652537663;
        bh=vYfJPBYCAjqilbHHrueSFEhX47JBAgIfuXTUg7hMCmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ky0A1cbsxwvCgAWVa4AHUFz2iJY1s64HwzB3EMuGQr5zpFXZ4MbAdcCwcv1Emlce9
         ZE5SH7Q93qHE5xo1mcpp4dqXxO2rfo9Sl/FSo7/RWcZc0h7DINJyj0gkFx1MfjuJHZ
         Fzb05TyTyt0AUzrcEPElJK2DCxj28EhzxpA+c8KiaM00uEF5cxO0oqrOzUKMjG/oPx
         Lj8PIzKh22Pku2TT161W/x2s4rkgF8SKl7T4+BQH3uy8qL9VGgx4OapRILVWyJqaXB
         3JtZCQd/P+M2ZHm7/fAUHlkknP9vbL1xKAcXO47vvYoalD+4V/7yIdgBz0u733IUJD
         yaP2SgHqkKp1Q==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] NFSv4: Don't hold the layoutget locks across multiple RPC calls
Date:   Sat, 14 May 2022 10:08:14 -0400
Message-Id: <20220514140814.3655-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514140814.3655-4-trondmy@kernel.org>
References: <20220514140814.3655-1-trondmy@kernel.org>
 <20220514140814.3655-2-trondmy@kernel.org>
 <20220514140814.3655-3-trondmy@kernel.org>
 <20220514140814.3655-4-trondmy@kernel.org>
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

When doing layoutget as part of the open() compound, we have to be
careful to release the layout locks before we can call any further RPC
calls, such as setattr(). The reason is that those calls could trigger
a recall, which could deadlock.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a79f66432bd3..bf3ba541b9fb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3098,6 +3098,10 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	}
 
 out:
+	if (opendata->lgp) {
+		nfs4_lgopen_release(opendata->lgp);
+		opendata->lgp = NULL;
+	}
 	if (!opendata->cancelled)
 		nfs4_sequence_free_slot(&opendata->o_res.seq_res);
 	return ret;
-- 
2.36.1

