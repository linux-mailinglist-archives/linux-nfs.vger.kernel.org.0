Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DADE57FFE8
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiGYNcw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 09:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbiGYNcr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 09:32:47 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4687FE01D
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:46 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id y129so5116462vkg.5
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3FQ5JaSWfv3cXYAVokeJ/mo2/U8O1aJLSFu0DqXZFdU=;
        b=e9xEW2JvP6XNWIfVm2Gps7ogyM7g7AEBlmEnOBTB2UOq5jKs2FyJzo9vtH/qiOWPPK
         mHKS9zISQtDHBnWoAFTmdZDhpwFxqdhS2CXHzOeCaVjAfeBybzxGQVXiUBTEtKUKo3/z
         6f37hmipnTyAMze+jwaT//W0xVoh0WeDNhrnhi8KTY/FgxoLDGZrYKLy6MIC+sveThn+
         L/as/Cc8l4M3MGJbsU90kdYr4sybjwPLoEQ8PeoyEYVS8FlNQBjBt5iExy46LX0ssFBv
         CFz/vv48xxn9JHeE3qr9Ua5eT4ab4szHK8q6G4BNGO4DFNQbbiRThnH0mWVkVCE+r6mD
         EjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FQ5JaSWfv3cXYAVokeJ/mo2/U8O1aJLSFu0DqXZFdU=;
        b=h11YuBQqsPhRbNWLRv9NuR6EocSzPAbyNLEuEwDZmkUzVzuAzVebu1e6pPkjRAHhRP
         7TlM1hGfPBMep7mNwMPy1+dooKjI1MIch0KT3jkeFjVlu9mlLx0/If54J+ZXtiqDb91v
         6RNqim6VLCpR/O5K4hfqMtto4y1I2icUZSLnp6UuFGPXFEU3yfjDvgPtHeM+Rsx3GKou
         GMKsDrG0jmwnQHCaH5KJBWfrTQEMgA4XCS1dk8NVk9olVE5dPY+tiKyXuyadRyf32R6S
         DIWvdOQVVvVdLBtwTiu+iXhf+HOejkRhtfpOvJY25usM0pOsLTWjgGuCvdZK0iUm+d1S
         EvdQ==
X-Gm-Message-State: AJIora93lIngAJSmdWZhqgs82uEqJNTtCfvzGoT+2U7rZ9uqeJvR66l2
        wmCtVBdfhkl9G3rCK/jAOQI=
X-Google-Smtp-Source: AGRyM1v3LgOAX/9cpUV3U/3i06gKQY0F8nHPWauzP84MG7hUHdBQUznC+yqOyGRI4KGbQ56n2ewObw==
X-Received: by 2002:ac5:c38b:0:b0:374:e94e:5454 with SMTP id s11-20020ac5c38b000000b00374e94e5454mr3275057vkk.39.1658755964865;
        Mon, 25 Jul 2022 06:32:44 -0700 (PDT)
Received: from localhost.localdomain (071-047-011-047.res.spectrum.com. [71.47.11.47])
        by smtp.gmail.com with ESMTPSA id a6-20020ab06306000000b00383aeb53100sm2128826uap.16.2022.07.25.06.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:44 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 09/11] SUNRPC export xprt_iter_rewind function
Date:   Mon, 25 Jul 2022 09:32:29 -0400
Message-Id: <20220725133231.4279-10-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
References: <20220725133231.4279-1-olga.kornievskaia@gmail.com>
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
index 55da01730311..685db598acbe 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -481,7 +481,6 @@ struct rpc_xprt *xprt_iter_next_entry_offline(struct rpc_xprt_iter *xpi)
  * Resets xpi to ensure that it points to the first entry in the list
  * of transports.
  */
-static
 void xprt_iter_rewind(struct rpc_xprt_iter *xpi)
 {
 	rcu_read_lock();
-- 
2.27.0

