Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A97DCD9F
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbjJaNN4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 09:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344452AbjJaNNz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 09:13:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC8DE
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 06:13:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso4933897b3a.3
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698758033; x=1699362833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD8VWPASmmhS2IhXP01B8qSPpw2IJI2K/JZ8p09kfNo=;
        b=QIUAG4GbBjE0ZxOMR7+IuEaV0jAzfuv9JB4Y5cdXnDxsyigJG0oWrZscPm1AgpkbdW
         DC/G4UwKvMlgc8tf3PI9Emzx/ZyjTveRfKL0M2FmsIwcOBLzfgCVOONh80DuwfTtXfSf
         NSjb2RefmdYcYhmpdC9p9pjZYJh5XLyC6ADeD97zsN8syR1OijAiGcD8RiQP7E/jva87
         k+NNbTAEAckupKCJ/A/9jaUq53zvgWGyUBpgJhX8VMnkj1UvcwNoKxpawqpP+7klXxPc
         gwJHWsaW40oz2s67+oUpR1FXrQyuy5NDTYtNpE/TfbLZwzoU4SQHi2GkKBxLojQT7M+C
         Yi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698758033; x=1699362833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD8VWPASmmhS2IhXP01B8qSPpw2IJI2K/JZ8p09kfNo=;
        b=ZCfEOc5hM7x2lTFkZdY4yQEAfIui3zy7QBuM3Dyl8A9V53133XO0Py5WFSY6RGSTaM
         c1mMKxFy6qqX6HERc3/xl9HU9YMXv5loT5TRMGyt770r9FG2xmSvK+TaDAeRy3NEmGiD
         kQX5zqSGqZI3gxhQ1hizDQec288/naoBU0KzOD0ldTGiu4buq2Pt0ZMd8iRn41Kd4utM
         6Sszr3L0XRp4LiSvVXjiCQfw6t1T+fAjmACr0YGamjJszzRmiMHJj/zO8M/JZ6cRZ3WL
         Jt+t21noVtSkEcwwSGSoN3BSzdM9K0W0qjGOHIFne5PmNcDvODyERf8SL/Qt8R0Zuj3K
         V3mQ==
X-Gm-Message-State: AOJu0YzgTtIaNO7wCNzdznm9zmyO+dF86hQ2vVh6UjOhm5EX6+ec1nM2
        naX8QD69awMUmpk687rfc94=
X-Google-Smtp-Source: AGHT+IGsY8dmV4/7tg+ScTj8Rvz9OYv+dBfUsAday/opVNolVKLDCJT+bjp+/SnbDUDHhnNNBiK8qQ==
X-Received: by 2002:a05:6a00:2d94:b0:6be:4228:698b with SMTP id fb20-20020a056a002d9400b006be4228698bmr11020883pfb.20.1698758032731;
        Tue, 31 Oct 2023 06:13:52 -0700 (PDT)
Received: from localhost.localdomain ([36.142.182.171])
        by smtp.gmail.com with ESMTPSA id h18-20020aa786d2000000b006c031c6c200sm1223746pfo.88.2023.10.31.06.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 06:13:52 -0700 (PDT)
From:   Zhuohao Bai <wcwfta@gmail.com>
X-Google-Original-From: Zhuohao Bai <zhuohao_bai@foxmail.com>
To:     steved@redhat.com
Cc:     libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        tanyuan@tinylab.org, forrestniu@foxmail.com, falcon@tinylab.org,
        zhuohao_bai@foxmail.com
Subject: [PATCH v1 1/2] _rpc_dtablesize: Decrease the value of size.
Date:   Tue, 31 Oct 2023 21:13:09 +0800
Message-Id: <724549cc2342aaa4b3832967e086252134528d3f.1698751763.git.zhuohao_bai@foxmail.com>
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

To fix the bug caused by a Size value that is too large and leads to an array
that requires excessive memory, which subsequently results in the failure of
rpcbind to start properly.

Signed-off-by: Zhuohao Bai <zhuohao_bai@foxmail.com>
---
 src/rpc_dtablesize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rpc_dtablesize.c b/src/rpc_dtablesize.c
index bce97e8..12f80c1 100644
--- a/src/rpc_dtablesize.c
+++ b/src/rpc_dtablesize.c
@@ -41,7 +41,7 @@ _rpc_dtablesize(void)
 	static int size;
 
 	if (size == 0) {
-		size = sysconf(_SC_OPEN_MAX);
+		size = min(1024, sysconf(_SC_OPEN_MAX));
 	}
 	return (size);
 }
-- 
2.25.1

