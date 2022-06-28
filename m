Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6955F048
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 23:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiF1VZa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Jun 2022 17:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiF1VZ3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Jun 2022 17:25:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF273A730;
        Tue, 28 Jun 2022 14:25:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f190so7847319wma.5;
        Tue, 28 Jun 2022 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggP20+YtDR/ba9ZGcccJ7AMV2oMsWGgviBSb7C0BwSo=;
        b=L7DkmGA4vHMTLK7wq4lGxEi16hlAS20VwFe7CLrCWR6U4pAUNC1xYKXrwv+CBExbM7
         dLCc4ng70SF2VHI26CY+JAfKM7CMlcV6xn0tGiCjVqpINZ5aZeUXVztJ24xUCqarR07Q
         F39K7Qj3A0lGD+5GdKhTzloNYYA8LxiJyOCYrwieL6nxMGdhCAbvKkw/gZZbw7w7mmZN
         iNZZKrUYEHzNg8Iyeo0+O6jNRuarL15dAfWWWmO/Vd/OzvFSzttOTlcb1va26M94PrTH
         Up0hNH1bVMqqsbDS02QAy9pfoM6Qtl5jukgt/y3+uhJse+XuI7ea2eDVqVJgiHnhSGwD
         e1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggP20+YtDR/ba9ZGcccJ7AMV2oMsWGgviBSb7C0BwSo=;
        b=8Gk5xUmPLY41eeyhudOr1/YQKY4YvteH+5ITf++F3rucRLLUNbx79skoKWzIIO8b6w
         nRO/sVYf0CKXUO0gQhd/IC1iNH0Ezg7n4/gjztglLUNjFg6CibF42PnJ6JgYYTFe52Fa
         ksdrRaI0IT+oju5CsJaUH9BbQ2TVg2IJ563LxCKDNyjfj96tkXF+Q8627wD8n43R/7fW
         QE+1HMex9RBFtz/pfj63DF79OdIIdjNdJEF0aXlgSRQ4jjgnzux1kmL82PU63+M1ctBw
         BrBW2aeeYnfMCBdx5+LlK/B86JletxfJUrfU9xFu3g8xSBO59uj5dsCaOsfCXE2gmLXL
         4nUg==
X-Gm-Message-State: AJIora9UHODRC1ln4x0fpFtD0hKI88ZxhMqN6OZ64FL9bcmT5HUbCQob
        e7f7QnioKt+q5DrEMnKqtjk=
X-Google-Smtp-Source: AGRyM1sX6vcWI+ufYs2TQWTtdp6s5a2mtPPCla3n2TrP+X81JVA2O9xRgbPhB7B8f4ygrqldae+ezQ==
X-Received: by 2002:a05:600c:3c83:b0:39c:9039:852c with SMTP id bg3-20020a05600c3c8300b0039c9039852cmr1785941wmb.187.1656451527504;
        Tue, 28 Jun 2022 14:25:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b003a04a9504b0sm966567wmb.40.2022.06.28.14.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:25:26 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: remove redundant assignment to variable len
Date:   Tue, 28 Jun 2022 22:25:25 +0100
Message-Id: <20220628212525.353730-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable len is being assigned a value zero and this is never
read, it is being re-assigned later. The assignment is redundant
and can be removed.

Cleans up clang scan-build warning:
fs/nfsd/nfsctl.c:636:2: warning: Value stored to 'len' is never read

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/nfsd/nfsctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 0621c2faf242..66c352bf61b1 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -633,7 +633,6 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
 	}
 
 	/* Now write current state into reply buffer */
-	len = 0;
 	sep = "";
 	remaining = SIMPLE_TRANSACTION_LIMIT;
 	for (num=2 ; num <= 4 ; num++) {
-- 
2.35.3

