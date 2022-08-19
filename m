Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEC359A60A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Aug 2022 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350252AbiHSTQp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Aug 2022 15:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349775AbiHSTQn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Aug 2022 15:16:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F21510F6AD
        for <linux-nfs@vger.kernel.org>; Fri, 19 Aug 2022 12:16:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l5so4061369qtv.4
        for <linux-nfs@vger.kernel.org>; Fri, 19 Aug 2022 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=86WaQrL6zpudCTxvo9Gvx4UkN0eMpE4Tyq1lSKc48pI=;
        b=mFN1M36P5TacjIy9U60JIP8kZD7lYvqpjsMrWMzqquLtjmHs/bbh/Lg6+0r9PtGRPQ
         zBYC20itATKAXFVaVB5jwZk9oIllVi4jpuIdhDUQ7e2XT2Byg2nOgSyHVy9RxdN5p+75
         qx6/FJ4kEM/A0swEPx/31yIxERitdj1WFX0E81Jzr77sYom3jao7+V8YJ+wWxXfJ2waP
         13UjxDR1+YdbWG/uQmjaJZVDUZ/uZyidUYATgvG/b8D3JBx+d9BgfK2S3JKDS3xCSWeq
         wunaMIyEd0GNuphbpH6E/uEtCJVoswVAQxCkctt5ky+eHqDe5GVrC1UUUDB0l5oaJMMw
         v29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=86WaQrL6zpudCTxvo9Gvx4UkN0eMpE4Tyq1lSKc48pI=;
        b=fGPB3qeGdHq5bXUxxQRvW1eJgT5bhaxkA6c0phe2OXvm4SPVtRL2Jsp7DDI6R/LZCC
         Fer59nvqF7QumO+hizo3UIdr+B7tUmiLJzdhnpGiYjd5ZpqVU9sGJjlhca4jN6uVHWWe
         ibZVzG6o76KRpgvlA5pQKKtoDRLMpw9TnvPKHGyuE8bkxMtVToTDxHjyyJy5+shPz6kD
         jlik2DW2a51PAmv0JXRzMKzg7/ZEOle04wA1gA56iH2PFTx7hfqcojlQGqaP7DCjKUnL
         NmqlKAspzeJ7RIZxP1yX70kL8xfkXH3vUskjwuhkGH+PSHAJe45ZB5bTrATeDFeRRCBk
         R/RA==
X-Gm-Message-State: ACgBeo3I34+9gk26ZQUpf87A8UQHEnG/O+L1vjs4OMMBb1yPn8KYUXrQ
        cGSUZDLQqAlD9I3FVDj1/UY=
X-Google-Smtp-Source: AA6agR4UoKyWIhIykRrrbr1WRporCB/cZOP1AL3NLXs/uK2xFwaGj6u+ufmG0ETqPYgLn/6w4xjMgA==
X-Received: by 2002:a05:622a:44f:b0:343:499:e77c with SMTP id o15-20020a05622a044f00b003430499e77cmr7450783qtx.129.1660936599388;
        Fri, 19 Aug 2022 12:16:39 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:495:9c03:c9aa:2af1])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a0a4400b006b905e003a4sm4166537qka.135.2022.08.19.12.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:16:38 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     chuck.level@oracle.come, jlayton@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSD enforce filehandle check for source file in COPY
Date:   Fri, 19 Aug 2022 15:16:36 -0400
Message-Id: <20220819191636.68024-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
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

From: Olga Kornievskaia <kolga@netapp.com>

If the passed in filehandle for the source file in the COPY operation
is not a regular file, the server MUST return NFS4ERR_WRONG_TYPE.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfsd/nfs4proc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a72ab97f77ef..d8f05d96fe68 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1768,7 +1768,13 @@ static int nfsd4_do_async_copy(void *data)
 		filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
 				      &copy->stateid);
 		if (IS_ERR(filp)) {
-			nfserr = nfserr_offload_denied;
+			switch (PTR_ERR(filp)) {
+			case -EBADF:
+				nfserr = nfserr_wrong_type;
+				break;
+			default:
+				nfserr = nfserr_offload_denied;
+			}
 			nfsd4_interssc_disconnect(copy->ss_mnt);
 			goto do_callback;
 		}
-- 
2.18.2

