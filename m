Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1F5520C5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbiFTP0F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244639AbiFTPZ0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:26 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F992E48
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:43 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g15so8018180qke.4
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAh9dzPILMHQWI8/F4SQx4JCHCxKzo11Zr+T4oaJSao=;
        b=PR5qTNGRhwRdExCn+/SVMM61J5hWqY06ps1bkPBZUgx6QpG2HeXODeLNM8rdwMsBrc
         RyNZA/uo26CbFEOC3RHKltlJ/pPenUJ4+kxu+7eiJO2xi7eSx5ta4EaB5iMuiZj8/qXF
         XB7MwnygUXwOwS65oTFwlFTTgkLP6zs8cW5EX6RaHgHSTZ45xnMIwuweFuAxKt+ktWiF
         zmhpjjVlDr6NB7iPC2rTZtZf0vCXUpj0/bqAZU0Ma+fz/b3Rpwck3NZ9pfJuft5TddZ+
         nisXN7VsJdj85dKFtRkX6iT4+54ZpxFGZ8y5XwyymTrKUsa4EW0tpnhxeF8WbfSzREjZ
         Zn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAh9dzPILMHQWI8/F4SQx4JCHCxKzo11Zr+T4oaJSao=;
        b=FMLulj0YW9t3gfe2o3ZP96alhcDk8yaG+BqJ+wu/wT1CrRsSG6bJOCMylx51RHrcS6
         0c1pYgrw0flLjV2eotFCHJZYpnSIeL8LxbpdC+O0jka6z5GnlzdRs1UFBuh2cskMnc7l
         KxJ/WHiGZLWdRCUHX4c2aQ+g5eug+OYaGDQK9is9a0DvN+xTILahaCZJchwu5w6fhrpj
         /HpVVS1oeo6gxDQujoArwBzvuA0JrerBT/jO+kulrBy/xUzG2VEYiMC/klZj/Urko79O
         plu26c9HQjhqEdt0MpX8j4iP2WmlHBZMbP7sZUeZF5DFbH9NKo/GJsqIsizPwlmjfV3e
         QlOw==
X-Gm-Message-State: AJIora8jc1OoOJUgepQx5rrKw59udFtgnrfVdjsUlg2lRKMXDdR6AHZm
        G8RoKuRiWXCylNEPM4usJ4oyyWJuaI14cA==
X-Google-Smtp-Source: AGRyM1vec9RvD5EKD1ZO0kuRwC9zD07tKqDgSUfKElOI6phUGhHw4KhetTrmpZKI2/aixIOxYHlmlw==
X-Received: by 2002:a05:620a:2681:b0:67e:933e:54b6 with SMTP id c1-20020a05620a268100b0067e933e54b6mr16710169qkp.428.1655738682745;
        Mon, 20 Jun 2022 08:24:42 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:42 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 10/12] SUNRPC export xprt_iter_rewind function
Date:   Mon, 20 Jun 2022 11:24:05 -0400
Message-Id: <20220620152407.63127-11-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Make xprt_iter_rewind callable outside of xprtmultipath.c

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprtmultipath.h | 2 ++
 net/sunrpc/xprtmultipath.c           | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index 9fff0768d942..c0514c684b2c 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -68,6 +68,8 @@ extern void xprt_iter_init_listoffline(struct rpc_xprt_iter *xpi,
 
 extern void xprt_iter_destroy(struct rpc_xprt_iter *xpi);
 
+extern void xprt_iter_rewind(struct rpc_xprt_iter *xpi);
+
 extern struct rpc_xprt_switch *xprt_iter_xchg_switch(
 		struct rpc_xprt_iter *xpi,
 		struct rpc_xprt_switch *newswitch);
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 41ec46e5f1a3..154bb6cf27ad 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -479,7 +479,6 @@ struct rpc_xprt *xprt_iter_next_entry_offline(struct rpc_xprt_iter *xpi)
  * Resets xpi to ensure that it points to the first entry in the list
  * of transports.
  */
-static
 void xprt_iter_rewind(struct rpc_xprt_iter *xpi)
 {
 	rcu_read_lock();
-- 
2.27.0

