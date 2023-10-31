Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017647DCD9D
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344471AbjJaNOC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbjJaNOB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 09:14:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1EEDA
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 06:13:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd73395bceso4171189b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698758038; x=1699362838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB566YCHTASYF1Q8UTMkal48ruGoIhbv/qQQAAKy4z8=;
        b=QZheh4jbi9TEla0loQJkFRy/al0NRSqmG3sCj//HnM3JStl3xUH/agYc3qN09VLMVV
         wFyDctgnu31n3SWaaXeG9QweLOrLTWcV51gLFmZsQmzFSz15WdePXfBLdz/7gw08y7aw
         bnxEwihn1Y//hCdTnUcuhcR/Kq91qfCy/ca7RN79Ku3vfMfwxlXRgbScjaL/f6XPwqmQ
         LinDPvT9AsOaWpX3n3NT7ZfIH1c2q/M0Cdxtibokq+ZDGX8RBOC1YixnXetoQaT4AqTl
         JsEoBvJyYLMB2qtIKuk7qT+yHRLmc7PSjwCW7PDWH7wvnS3eJkSTCs6OY4izsx91xZsb
         CVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698758038; x=1699362838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB566YCHTASYF1Q8UTMkal48ruGoIhbv/qQQAAKy4z8=;
        b=FGaW83uUb6F7AsTc/9mx3DA8YZZxsG9Tcrl255tJbuE6OW01gEbIfJPXFRchNFO3Ca
         ThmVFDwWd6mfY2SwfjeQODaooYM5DZkb3Pno80ndwpCPrN73w6vlUcwDewalqi+y72EB
         LH87HDgGSGt3T4VMHD05DlorDjnd+EU/EfkZSFMc/dRO8kqJ9hMQVJVaCHS0MrH+D0Wi
         fdFLuq+0XeAxhi87/B/1ChhIiDHgzoZXk2X0DFdx6qEhwJ1Q+ZkA0FgU0r/0Ovm5iOLQ
         U8/XMjHh1tdUDEpuo2k6iWAUrYnw0tC+L92TfcWlMREpGTcH3v2PhSQ5I/S9myuSDjdI
         wmQw==
X-Gm-Message-State: AOJu0YzHDKGbJaS8cH0RbiDgMLa6/q+XfKIvMoh93x0X0FJEGpW2AzYn
        6dDyJ43h5Nk2qokQ3Cr2oFc=
X-Google-Smtp-Source: AGHT+IEZ+WTx/HPv7va0ONwDf5mg8VP1Hq3vlf/3E2OBuZ+ppR/R+H4bXkwTDvHFIzf6FgNJk1xhpw==
X-Received: by 2002:a05:6a00:38d0:b0:6be:c6f7:f9fd with SMTP id ey16-20020a056a0038d000b006bec6f7f9fdmr3015192pfb.11.1698758038080;
        Tue, 31 Oct 2023 06:13:58 -0700 (PDT)
Received: from localhost.localdomain ([36.142.182.171])
        by smtp.gmail.com with ESMTPSA id h18-20020aa786d2000000b006c031c6c200sm1223746pfo.88.2023.10.31.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 06:13:57 -0700 (PDT)
From:   Zhuohao Bai <wcwfta@gmail.com>
X-Google-Original-From: Zhuohao Bai <zhuohao_bai@foxmail.com>
To:     steved@redhat.com
Cc:     libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        tanyuan@tinylab.org, forrestniu@foxmail.com, falcon@tinylab.org,
        zhuohao_bai@foxmail.com
Subject: [PATCH v1 2/2] _rpc_dtablesize: Cleaning up the existing code
Date:   Tue, 31 Oct 2023 21:13:10 +0800
Message-Id: <61483752fe0b46729ae223e928d811924f053a7c.1698751763.git.zhuohao_bai@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1698751763.git.zhuohao_bai@foxmail.com>
References: <cover.1698751763.git.zhuohao_bai@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Some users have already taken steps to address this issue. To prevent
duplication, we need to remove the modified code and modify the rpc_dtablesize
function.

Signed-off-by: Zhuohao Bai <zhuohao_bai@foxmail.com>
---
 src/rpc_dtablesize.c | 4 +++-
 src/svc.c            | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/rpc_dtablesize.c b/src/rpc_dtablesize.c
index 12f80c1..e88698f 100644
--- a/src/rpc_dtablesize.c
+++ b/src/rpc_dtablesize.c
@@ -41,7 +41,9 @@ _rpc_dtablesize(void)
 	static int size;
 
 	if (size == 0) {
-		size = min(1024, sysconf(_SC_OPEN_MAX));
+		size = sysconf(_SC_OPEN_MAX);
+		if (size > FD_SETSIZE)
+			size = FD_SETSIZE;
 	}
 	return (size);
 }
diff --git a/src/svc.c b/src/svc.c
index 3a8709f..9b932a5 100644
--- a/src/svc.c
+++ b/src/svc.c
@@ -657,8 +657,6 @@ svc_getreqset (readfds)
   assert (readfds != NULL);
 
   setsize = _rpc_dtablesize ();
-  if (setsize > FD_SETSIZE)
-    setsize = FD_SETSIZE;
   maskp = readfds->fds_bits;
   for (sock = 0; sock < setsize; sock += NFDBITS)
     {
-- 
2.25.1

