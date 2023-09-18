Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015EA7A41A5
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 09:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbjIRG7x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Sep 2023 02:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbjIRG7b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Sep 2023 02:59:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D32CD2
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 23:59:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so44687505e9.1
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695020353; x=1695625153; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm6vAOFaX7yxl9xWdmtMSipp5k6yO3unKKLg/6PO4o4=;
        b=RKZcvAiv+/9slK1JpZSPnXumoJG61Xr0vZEB2NXb5rQa3gjgVJClb0cGVRjIh6eHVR
         ncnERc0hpAMg1qQdHxSrz1VYMLRC20E+8I1RKTecU10LUoudqySjBjJctMyfcgkHXS9e
         A3qr/j9tget8heEbTFxEWpPgUx1dQLS9S48Psp6mah+Hkdmelg/zBbalAjqYS4asQg++
         IefjmbjEKV48ZtLa6UPDKQ7xXhqeK1qJ7Uw/ZilvmbYEfYXep4wGu/UN+wuCTV4cSXVw
         V+jLCh4QB4ghTbNKpPnM+rka1kgEp2YXcOblxOi0tH+nIbJJbM7gGUB+TL8v95LGD/9p
         4nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695020353; x=1695625153;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hm6vAOFaX7yxl9xWdmtMSipp5k6yO3unKKLg/6PO4o4=;
        b=tetVzv6EpxGNskdG44GShO82XVsjP27SqZ0knimJ8ww/k/2INh2+zHPQ+BL7GJOdk0
         5i9TfmThU+eHJ7GB3ZcYmdG9ToLsVrvj+ubDS6QDEpLSdBQLG3jRaBV0tH0cUzVdcw5W
         nmx5ZhTg8LYqHJSbga18cptyvqzsqUYvqexkL4Ubeu8pyK+z5+AaiTeJZ1f8c5uesMKL
         UaemffwLH5fwcPobctT4ltWnCF48PvwV2+tV1NR+Ukh0a9T9M5ycL/eGWcx3eA9s3wf9
         Zds7ZB2ZzNoS1NfyJ1XWbcBTL93UxKPmexGPq618DzUV0Qn6qRFysmj0xA3SUjy+StNT
         z8JQ==
X-Gm-Message-State: AOJu0YxugaaCRDjdndmC4vKqvGiKAhIEfP89EmnvDwK3NQWkHinnRFvg
        npTACQfeV0B3N5WyWi69+AmnZs0mtD43BA==
X-Google-Smtp-Source: AGHT+IHpoqgxDZGmdQdcxsjZ2Mq11PF7QrpLugN2w0cA6l3USSmyZnmk9Ui8+k1vnCo7sqmoa9+qlg==
X-Received: by 2002:a7b:cd96:0:b0:402:ea6f:e88f with SMTP id y22-20020a7bcd96000000b00402ea6fe88fmr6630980wmj.5.1695020352607;
        Sun, 17 Sep 2023 23:59:12 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id ba13-20020a0560001c0d00b0031ddf6cc89csm8843590wrb.98.2023.09.17.23.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 23:59:12 -0700 (PDT)
Message-ID: <f44e51ae-baca-4091-b6eb-85537a43b752@gmail.com>
Date:   Mon, 18 Sep 2023 14:59:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Frank van der Linden <fllinden@amazon.com>
From:   Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] nfs: fix the typo of rfc number about xattr in NFSv4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 include/linux/nfs4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 730003c4f4af..b6fa923a3111 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -150,7 +150,7 @@ enum nfs_opnum4 {
 	OP_WRITE_SAME = 70,
 	OP_CLONE = 71,
 
-	/* xattr support (RFC8726) */
+	/* xattr support (RFC8276) */
 	OP_GETXATTR                = 72,
 	OP_SETXATTR                = 73,
 	OP_LISTXATTRS              = 74,
-- 
2.41.0

