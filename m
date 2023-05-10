Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5B06FE707
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 00:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjEJWKi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 18:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjEJWKh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 18:10:37 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370687EF7;
        Wed, 10 May 2023 15:10:01 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-76c75d32005so20478039f.1;
        Wed, 10 May 2023 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683756600; x=1686348600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3s4NS5h+ppIdgnnYQegn2z2147cbkAQceVt2XlyQw1Y=;
        b=ImPDHWBF2qUQho/XSGzYwmUlPuFNt5nW0etWoAQx6NgoilJ5vmlVPRuX6Lbxc5bd8X
         erKFHCSLp5kU9kyH1UEXsSCL1OeKxknhYhiCqHtMAZIt6/4hMA9tPMXd1ixAFYhUdY9I
         ngeO9pyIGVx0Fe1/3lDNo+xH8rh8wyYrWLjkbuAfcusAgy6TpOuqVD932Kjh64493UBe
         myoMDto8+XjFryW4HEm0xdCCxEVGuGCmwGTcgUkyKUngTZ2T2a/66/C3bbrvrUrYYpNY
         HzPeLBosHjCK7IXn5tw+AZ6pw236RStp0hyIvHB2cC/qTiaoXv2YLcPKsMuSR12Joq6C
         D+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683756600; x=1686348600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s4NS5h+ppIdgnnYQegn2z2147cbkAQceVt2XlyQw1Y=;
        b=kP9uiGXvs6ZIunNM/w/QCbQPhk0z+18TW22cPiQXCzoFMENbVIUtx1VHhy9uStmVU+
         hlm89Rs1o0YFtyBHujDfKeVj1ChHiF8nndhyc0lsKMyLQJ/v0qogaQR+Xe2bMKBOF8/b
         f3m/0gNmccgLZQ8AJD2dcUZesS7ZbpH2tndWOt2Jyjqo0AjJY9PGowZJnjxXVkNBD/KV
         CiYOBt+4dpXkQtyIdDteKlzwOfsDArjLrnGfOK17nQYYmgDZs7q/V+68gMmtQQO34VQn
         lcE0zTJ/ZdD6gen24DU4VypbYeLKdaTI6iUn6BpcaIhtkcq5V08GKzSDVOK08u0iWOUY
         tCdQ==
X-Gm-Message-State: AC+VfDxBu9P8y62yuidbAcGwam4mQ4bAJvZNVRJqjfcEzsMpFDCbsMMv
        ZVA364vHVAlSc2uSlWbA1YY=
X-Google-Smtp-Source: ACHHUZ5Vr8aIzsxRpff9WfyD51ew3E6uvhrr4J0w4KIP58YXQy6L7ENpQQmdIKhw92vzL8FF4DvPUw==
X-Received: by 2002:a5e:d603:0:b0:76c:5cc1:22a9 with SMTP id w3-20020a5ed603000000b0076c5cc122a9mr4929885iom.17.1683756600028;
        Wed, 10 May 2023 15:10:00 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id s14-20020a02cf2e000000b0040fad79ac08sm3846047jar.89.2023.05.10.15.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:09:59 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: Replace all non-returning strlcpy with strscpy
Date:   Wed, 10 May 2023 22:09:52 +0000
Message-ID: <20230510220952.3507366-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 fs/nfsd/trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4183819ea082..9b32cda54808 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1370,7 +1370,7 @@ TRACE_EVENT(nfsd_cb_setup,
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
 		__entry->cl_id = clp->cl_clientid.cl_id;
-		strlcpy(__entry->netid, netid, sizeof(__entry->netid));
+		strscpy(__entry->netid, netid, sizeof(__entry->netid));
 		__entry->authflavor = authflavor;
 		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
 				  clp->cl_cb_conn.cb_addrlen)

