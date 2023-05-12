Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEABA700AEB
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbjELO7w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 10:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbjELO7v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 10:59:51 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487F11608;
        Fri, 12 May 2023 07:59:24 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-331514f56a6so20413055ab.2;
        Fri, 12 May 2023 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683903563; x=1686495563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uej35fMaBDYd/DBll/McZZLDRRbg42nhAQBBcpMPQrQ=;
        b=V57JcuucsAIuXt3aSibGx5xkBLrqx7Y7CA6em6tCJ3nR5ydpSvbBmWjyUXWFJ8OJIs
         927EEJ/YsKoVdJQdflmZFuG0VKB46AQxNb6JWAGBW7FTm5qYZqHFMT1VnbONdSvWDKU1
         O2VEGC/NiDCpGK5GiJnyqkXc0D+uohP6vVbuhTeU2H4IUTMHRJaw53yh2hHS7wu0pfNW
         QXu5BSo5fVioI50ZeaRxcr51vJbyu5FKqVQKskeO/Ho/uqMqJ2yUvcasSJE2R9G6FXTS
         gR72ocWdgaVFnjbdNU2caQhgtrKGt02xoK8JqTc1rP+tlob+qPddBl1qTKCH9vyTBIDN
         /X6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903563; x=1686495563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uej35fMaBDYd/DBll/McZZLDRRbg42nhAQBBcpMPQrQ=;
        b=ZRo1xbaD2gmiYYNVnc73HlAmDiylCa34eQPD6dcawwjLQbeezrTyoxQJhiAQo1UQjF
         DY8zmQ9MeMcREC1m2Kw4iVUlO8RVzji/L+5CqOkdCnYlwhCZ30lVi9ml9npZiftIkdD/
         axAoiUb7b3ANufNwoqOsLl/EvedrQSmqoR1tzFdJS744uWhVpMA7SVnKv+BlQ1l2zGOk
         mt2mHLXh9qqCNSkFl5IH1o1SAcQHmmoneM2ilIxNbo+fmXe5QJNgpc30AjQpFCjWUB3z
         2+mAXX8oBEqxUowARXHZeEUD0FiQeaDO7U04v98dmLIn0vbMjfaSCXmjO4PExnxcuOZB
         EAMQ==
X-Gm-Message-State: AC+VfDychvG53d6O/Mdfm9Xos81eCbrAPhUHFs/8pXRgwiW64at+aQkF
        L3efVrar4t+g7L1Bm9MrBcE=
X-Google-Smtp-Source: ACHHUZ6AOFV5bZbDecttClyZvy1sr8yZ35rhGviIy5aKT1jefBEfHUcpBfdM0lwIf6U6SsW+JKTU7Q==
X-Received: by 2002:a92:d98c:0:b0:32a:fc58:7a4d with SMTP id r12-20020a92d98c000000b0032afc587a4dmr17102476iln.2.1683903562775;
        Fri, 12 May 2023 07:59:22 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id v10-20020a92cd4a000000b00328757d82c8sm5134810ilq.46.2023.05.12.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 07:59:22 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-hardening@vger.kernel.org, keescook@chromium.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] NFSD: Remove all occurences of strlcpy
Date:   Fri, 12 May 2023 14:53:56 +0000
Message-ID: <20230512145356.396567-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
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
strlcpy here.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")
Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v1: https://lore.kernel.org/all/20230510220952.3507366-1-azeemshaikh38@gmail.com/

Changes in v2:
 - Use __assign_str instead of strscpy.
 - Added the Fixes tag.

 fs/nfsd/trace.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4183819ea082..72a906a053dc 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
 		__field(u32, cl_id)
 		__field(unsigned long, authflavor)
 		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
-		__array(unsigned char, netid, 8)
+		__string(netid, netid)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
 		__entry->cl_id = clp->cl_clientid.cl_id;
-		strlcpy(__entry->netid, netid, sizeof(__entry->netid));
+		__assign_str(netid, netid);
 		__entry->authflavor = authflavor;
 		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
 				  clp->cl_cb_conn.cb_addrlen)
 	),
 	TP_printk("addr=%pISpc client %08x:%08x proto=%s flavor=%s",
 		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
-		__entry->netid, show_nfsd_authflavor(__entry->authflavor))
+		__get_str(netid), show_nfsd_authflavor(__entry->authflavor))
 );
 
 TRACE_EVENT(nfsd_cb_setup_err,
-- 
2.40.1.606.ga4b1b128d6-goog


