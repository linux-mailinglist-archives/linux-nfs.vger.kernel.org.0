Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947675BD88E
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 02:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiISX77 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Sep 2022 19:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiISX76 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Sep 2022 19:59:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91343340C
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 16:59:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so830454pjl.0
        for <linux-nfs@vger.kernel.org>; Mon, 19 Sep 2022 16:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=z+H+vPO85+HG1wiPcCazrq1kKgrN3Ei15WeTDKhYCKw=;
        b=lr9aKMh26A+2K6/e4KeqmdhRtpFdozE/LT27ZEIHybIGgvFXiCZUAsBxY0UOvUftf3
         bE2pR5e7JXdj7PiWS4eOxsrdR1C4sLwhKnSkel9XQilJDsAUwS4ZVQX3M6FrTOB2Xvqd
         7Fh//G1ZK7ZKbW9gJyPW2CCwTr9TRjnaFK33tdj9O4tmWi55wgEXDvDvbUyUgUzQ29HP
         DeDMAGAu5P7Ut5ZiSg53qHTXcUivwBNnfyCZ6RRBsXiEIT+YJcS7yMZaFJKnIW5QLCx1
         2dz+Il9wTO4ARN6k4LR5ftIT8SEyOHlHSw7eU7AZVJ2lW+yELRLZFbNJe/2UCz5k9utp
         FKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=z+H+vPO85+HG1wiPcCazrq1kKgrN3Ei15WeTDKhYCKw=;
        b=x6RQ1am4yrMuuUMxinxU0HP60nX2d2PQ24FOIUa0Zu1FBs5vCHiQw1mOZ+XNYL8Daz
         SnOuUYg+HGBRHGcdnw483cVeoIqs2cLIX61hDeB4TQ+p0zMCTjxZKWQfaP3KGSN+5aqw
         6AJytuyMoqKdcmGcicyHj6DkppYJCY6tc6i1D0ffHQvHJ1dHc2m+5/R5ZNPk8DJBjHOu
         mMgMW5OOcURN4aZLof6EuL12u2y2LJMYDxtkqsVxgx6KtPVEVR1OhL+zthKc5V+ws14/
         yCqD7WWzZG108i4VxKhL2GEy9GHzBaLOS7CuJSdTQRnmDfpJIFssYzRRostRxcie/ehA
         2QAA==
X-Gm-Message-State: ACrzQf3TlXKSkITTmSJONQFm6rS8I7DsgXBcVCmif1zuZh9bk99i++Gp
        /rr/hBxGFwj+ECNpCl2vP6L/SBwVuvXXfQ==
X-Google-Smtp-Source: AMsMyM5zp/qVpYzq55LxUEr52C3H4zZBoqDpyqg3YGCqDdC/odlGhWoPbddJ8KYL45b7QEg6glIj2g==
X-Received: by 2002:a17:902:8301:b0:178:7a61:c01e with SMTP id bd1-20020a170902830100b001787a61c01emr2313152plb.90.1663631995833;
        Mon, 19 Sep 2022 16:59:55 -0700 (PDT)
Received: from ryzen.lan ([2601:648:8600:e71::a86])
        by smtp.gmail.com with ESMTPSA id 189-20020a6216c6000000b0053e439c08c1sm20931902pfw.74.2022.09.19.16.59.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 16:59:55 -0700 (PDT)
From:   Rosen Penev <rosenp@gmail.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] libtirpc: add missing extern
Date:   Mon, 19 Sep 2022 16:59:54 -0700
Message-Id: <20220919235954.14011-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Fixes compilation warning.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 src/svc_auth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/svc_auth.c b/src/svc_auth.c
index ce8bbd8..789d6af 100644
--- a/src/svc_auth.c
+++ b/src/svc_auth.c
@@ -66,6 +66,9 @@ static struct authsvc *Auths = NULL;
 
 extern SVCAUTH svc_auth_none;
 
+#ifdef AUTHDES_SUPPORT
+extern enum auth_stat _svcauth_des(struct svc_req *rqst, struct rpc_msg *msg);
+#endif
 /*
  * The call rpc message, msg has been obtained from the wire.  The msg contains
  * the raw form of credentials and verifiers.  authenticate returns AUTH_OK
-- 
2.37.3

