Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DFD7A271E
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 21:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjIOTVi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbjIOTVZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 15:21:25 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746A31FE0
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 12:21:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-760dff4b701so37511539f.0
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694805679; x=1695410479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjElj1Y7dyx25+YVDMvYRWaZ4jnIteZwPRcb1817cvU=;
        b=ISgWbL1IEpe/FQf5ZkKADsaX3fhzIrgn82H5EiM2w5qcGQvl7yHKdz0+TOIq+5lI03
         YLwUBOsJam7yscvaK2bNFjl3LJAJGPgc/W1Sw12d5X+DYCxkZZHPnbLhwirRmy1szfLJ
         GS+gurNsIQEZQu/AHeH9XDH1GAnyiIDYgTiv30deZA9+fzuDJibd0aCXT1g5EWE32+mR
         tI82YekdKFhoBanhfx7OThiSHvuwet+63HcV5RDnndlepMX8KM8xxHjPEXoXNf/M0NLZ
         /SgAcbi3fgnd2YOOrorSJnTCrJfTT/V7CaxPR40q32HDrM1o/I/qIegMmWKPv2oSR46O
         zsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694805679; x=1695410479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjElj1Y7dyx25+YVDMvYRWaZ4jnIteZwPRcb1817cvU=;
        b=dWfOwV+GPLIBs02yHiWgcwCmsEWUltrerjJ+grbYmDqcXj+3eJjtYOvEkOz4T5UfDs
         7uoPAp10d5vTR/7wS5sOSB+MDLaegQPS0u4pmeGYoMmOVwx8uPb+xPwFkLhOHakJ/Wrr
         mSY9l/KP/vLiJsOaHISAntxtrDkJzheNZS/LWf5Jpn448sReuE3GIT55xxBDQNYlDagJ
         OVseNnF2JtfbmJVw3AAELIt4QzeooJoHnB+tyOWZYjWVDkYszXK07DPtAHufEIfm0xnG
         ElAFk63Db1o9A/MIOfud6LKckM3yPhKMvDjFQrJtYru4uch4m+WTNiqjXAq9syoK+jsv
         nEPQ==
X-Gm-Message-State: AOJu0YzQ92O9V+rWBVaOijxpEZsK0RDLCtXTKvaOrTPPTZcmx6Ej57od
        +py6vFAPx2VYiwFGmF5ICnM=
X-Google-Smtp-Source: AGHT+IHXzhiazCEV28AS2MNefEkTO4xZW9NGOBkRddL8KjdsoCuEgv8GTfbgQhgfLbTCAf4VWAVs/g==
X-Received: by 2002:a05:6602:2d86:b0:794:da1e:b249 with SMTP id k6-20020a0566022d8600b00794da1eb249mr3762574iow.1.1694805678794;
        Fri, 15 Sep 2023 12:21:18 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a8ce:bd30:447c:d564])
        by smtp.gmail.com with ESMTPSA id s11-20020a02cf2b000000b0043978165d54sm1250967jar.104.2023.09.15.12.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:21:18 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: fix handling NFS4ERR_DELAY when testing for session trunking
Date:   Fri, 15 Sep 2023 15:21:16 -0400
Message-Id: <20230915192116.14484-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently when client sends an EXCHANGE_ID for a possible trunked
connection, for any error that happened, the trunk will be thrown
out. However, an NFS4ERR_DELAY is a transient error that should be
retried instead.

Fixes: e818bd085baf ("NFSv4.1 remove xprt from xprt_switch if session trunking test fails")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 890ae26006ee..1dafead441c6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8936,6 +8936,7 @@ void nfs4_test_session_trunk(struct rpc_clnt *clnt, struct rpc_xprt *xprt,
 
 	sp4_how = (adata->clp->cl_sp4_flags == 0 ? SP4_NONE : SP4_MACH_CRED);
 
+try_again:
 	/* Test connection for session trunking. Async exchange_id call */
 	task = nfs4_run_exchange_id(adata->clp, adata->cred, sp4_how, xprt);
 	if (IS_ERR(task))
@@ -8948,11 +8949,15 @@ void nfs4_test_session_trunk(struct rpc_clnt *clnt, struct rpc_xprt *xprt,
 
 	if (status == 0)
 		rpc_clnt_xprt_switch_add_xprt(clnt, xprt);
-	else if (rpc_clnt_xprt_switch_has_addr(clnt,
+	else if (status != -NFS4ERR_DELAY && rpc_clnt_xprt_switch_has_addr(clnt,
 				(struct sockaddr *)&xprt->addr))
 		rpc_clnt_xprt_switch_remove_xprt(clnt, xprt);
 
 	rpc_put_task(task);
+	if (status == -NFS4ERR_DELAY) {
+		ssleep(1);
+		goto try_again;
+	}
 }
 EXPORT_SYMBOL_GPL(nfs4_test_session_trunk);
 
-- 
2.39.1

