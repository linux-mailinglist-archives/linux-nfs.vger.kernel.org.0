Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8B4819F4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Dec 2021 07:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhL3Gew (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Dec 2021 01:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhL3Gev (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Dec 2021 01:34:51 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FF8C061574;
        Wed, 29 Dec 2021 22:34:51 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id l11so21820493qke.11;
        Wed, 29 Dec 2021 22:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHf0SEKvzcJGlMghKnXLnXPdfTHRbi2dF8lcRvloMiQ=;
        b=Hs/o8PIWhtOumRTlwHRAEYXYHSEjHe5O5SgYUawcpQ3DF1R7mBZMSVvvswt5TwtktO
         TCvLEGQ4af+EGmjbmTprpbLiJFVSN9a/jO+L+UIpGsLNikY+VNctkwvWs9hzX9WxfRVm
         nxpjbwt9KKyNKRjJseiP8nho5ED6xq7bXjojDOAYQ3bbBasiAZJ5mpo9mBqYmRZRolk9
         t068dS/rmm7kIEBKHL+swiVSIr4zPX1VBEmfSmPpfXCg39CjZkJqdN/SMvI66QXp5hdd
         PptHl0sjkIWPRim6kmvIgZ8dUXwA/98NSW45zetXkkjPqKzEk63G+mR2p8CGPWoyrfdX
         Dsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHf0SEKvzcJGlMghKnXLnXPdfTHRbi2dF8lcRvloMiQ=;
        b=nrod+CtrvLDra3ryI4wAR+1NNljy530gFTwBLn8e3/c7XvSMauwP4DIYWVGT1dKUnX
         TXD7GVd6JTb4qUzhTiiY671+epCNZTdUU8wtZm+6H6GsrSPuT95xiqrp2zIcslfbNihk
         rhm0V/bMmy5o4TeQ5H3sDXaNlYJHx+YTGVE4QltIxajiKfPsRaIu7p2fzXTSWSKxT9/I
         FhE/37N5ItLve8UwYjsIoP0jqKN0hnJHpEhdFlF6U62yYL7SuEllHNAPzidi75J7DZko
         Sn1lKHXnIRIeSsq24HAkOUu6xI6yun8LknJy2V0vljwfnDnxE7SulJZ1UEoCmkqlmrir
         hWYg==
X-Gm-Message-State: AOAM5309/5dsqzZl899RZzT8AmRqNIBaoavDedw9sDr6bQDCcCXCsgiz
        JaWrL3KEvgtuek14TuFKx7nWycV3vNA=
X-Google-Smtp-Source: ABdhPJwF12SeRWfAaPL6mK/XQ2TJcuLN2vtNRvIO2KLuZRX0t9l2Ey/HkAkFuXolMM/sTmDjg0fwHQ==
X-Received: by 2002:a37:c50:: with SMTP id 77mr21257625qkm.717.1640846090605;
        Wed, 29 Dec 2021 22:34:50 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g27sm16005722qts.69.2021.12.29.22.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 22:34:50 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: luo.penghao@zte.com.cn
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux] nfs: Remove unnecessary ret assignment
Date:   Thu, 30 Dec 2021 06:34:44 +0000
Message-Id: <20211230063444.586292-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: luo penghao <luo.penghao@zte.com.cn>

Subsequent if judgments will assign new values to ret, so the
statement here should be deleted

The clang_analyzer complains as follows:

fs/nfs/callback.c:

Value stored to 'ret' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 fs/nfs/callback.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 86d856d..1c1c82a 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -209,7 +209,6 @@ static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
 		goto err_bind;
 	}
 
-	ret = 0;
 	if (!IS_ENABLED(CONFIG_NFS_V4_1) || minorversion == 0)
 		ret = nfs4_callback_up_net(serv, net);
 	else if (xprt->ops->bc_setup)
-- 
2.15.2


