Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7657D683
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 00:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiGUWH0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiGUWHZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 18:07:25 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C22593C2B
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:25 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q14so2445078iod.3
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoUJZLq0Q8GZjOnn3UNt3Y1wfADTVPUmy+JhoS9xaBU=;
        b=aYK21nDr9DrJJQSjoTdtVSgSSU0KuOkHOkdiYQkJI7TcieG7HQO0u15TO00WsitvLT
         +ZjQ2GKJ0Ytzr1Tq3qytLf0acJMC+7BO+wy/t/R74ZzjjNoC1deLeL06lc1WRHKYoTPn
         2lWdp/nlmLICMNqf2i4JNoyQKGcUaDAbzugjG7RnrNkPUT7iZXx6CRlXqNVUNTWze/xj
         ecK//yTEGZknXxR0vXCcv+lIXou0+AfG/5TxdDpr5C/zxkp4eEdY1kSBs3iZtr//ZJ19
         2JVbxJ6u04uXvhREMRiTD5SB2SrDWlAxELQ+s7TkxJd8bYHasPxlnRCId9Vi3JvlWey8
         AiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoUJZLq0Q8GZjOnn3UNt3Y1wfADTVPUmy+JhoS9xaBU=;
        b=uvh+naNSn06kY67gri2GNhWcAz/UD9mx9XfnVrgeJzGGOpyqj1inuflTxKK0++to6B
         RADEhCcnddITqZO/zgu3P436zJnYT4POoF6wWGUccFhopu7483W5uOFlWU1Zqp4lJ/Rg
         +W8J9RMw6rdb/VxI+qM7SP0TbJpocrI9+/vpu5RhuUAvXPuJIitDEzT+9RR5/Kq0XmTy
         PEkZKv3zFlxdRitwn4Ore609j6yskrQk3qvA2RaK/oOmjZvkocbykAr7eF3nwPxC76EY
         D8Ni53YOF+ckoZ6fUZaJnE3XpYF9UfBs8C+kedr6NLOsdlhFqHN9a86vjOMIrJNQ3u0W
         RGBQ==
X-Gm-Message-State: AJIora+JY2o6JzqcELktzt+R35BoQUK16UyDwUj+55OUKk5v6xdcW9Gs
        lD1pRon2WfFuB2MHrV9a5jVuUb+C+DA=
X-Google-Smtp-Source: AGRyM1sD058g+WX689hjyh8xaalP0X12LyHPXhlDr+RIEUAQ5mxOlD7AbkhRxt0D/4aQPfx03s7r+g==
X-Received: by 2002:a05:6638:22d5:b0:33f:8cee:b55f with SMTP id j21-20020a05663822d500b0033f8ceeb55fmr287994jat.134.1658441244751;
        Thu, 21 Jul 2022 15:07:24 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id g11-20020a05663811cb00b00341668383cfsm1281105jas.33.2022.07.21.15.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:07:24 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/11] NFSv4.1 remove xprt from xprt_switch if session trunking test fails
Date:   Thu, 21 Jul 2022 18:07:10 -0400
Message-Id: <20220721220714.22620-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
References: <20220721220714.22620-1-olga.kornievskaia@gmail.com>
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

If we are doing a session trunking test and it fails for the transport,
then remove this transport from the xprt_switch group.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9ae7d792beee..b805541f4501 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8924,6 +8924,9 @@ void nfs4_test_session_trunk(struct rpc_clnt *clnt, struct rpc_xprt *xprt,
 
 	if (status == 0)
 		rpc_clnt_xprt_switch_add_xprt(clnt, xprt);
+	else if (rpc_clnt_xprt_switch_has_addr(clnt,
+				(struct sockaddr *)&xprt->addr))
+		rpc_clnt_xprt_switch_remove_xprt(clnt, xprt);
 
 	rpc_put_task(task);
 }
-- 
2.27.0

