Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003795520C4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244792AbiFTP0D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbiFTPZZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E019DE3
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:41 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id n197so8032403qke.1
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HmcZzdxdf4F8eA9MR87GKLepSrbSvTKoPRKJ2aJz3E=;
        b=HO86txAgLpdZQ+QNDLpvPdwTrsUcgkz0C9JewG+MvSwJteluw8ggBS/Q34kugZZbI3
         0+cRfOmLy3aWXR8FDpSxHg1aYentMXeWcIpBX0RKFHwzXLWJhKa8lbqMtXuATMheP1Pb
         kv54K3MLJeFLwgK61Ba8TME9PZuR70ZA1Rc1+CbvJMjgDixp1v2R63ivD1/fyoieqGqQ
         0e8liATwyEZtmnElct/FGtKG8nE0/CGB6pIltLoUclhJkuVM80HGXbWz2a+9HUcAHuGc
         4MD3BniWuI4HPMrZL+xZ8o+YUEJBLmlGX0HeJyUdlk3NrQrtTvJufm4bvuPFlwZ5h/hP
         gEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HmcZzdxdf4F8eA9MR87GKLepSrbSvTKoPRKJ2aJz3E=;
        b=JsoJdPJzqICn2/LcjEGyaictWYtBWDUg1snlMHe0HYH9K7riDHSAXyV3VXjZtshxky
         dLzKvp/uTo2ggVE0dPy/rWS7hLJvqcXM7GZX4DCV4I9R9dXRI+Eeofxd0Bq1oEwHHeVU
         Z0+Mt1GO+iLqm2nHXkhphjtRNUse9vC8+CP03jxg312opVb6CcdOAUQz8yW2p8yZ/PrL
         7nVwAw28enJMgGUarmTsBIo1Q6jrUYB6r+ocLqs07sNetic4FsiIx0CHuxHhuhhB4Oin
         RhJGnaRPNDgfLBw2Mi3IshSR31i5KRY3X6trBN0uozPMqgbgfFlq8pdTH9/ZFEgWTOWe
         2nnA==
X-Gm-Message-State: AJIora9LFicp7aRZlFvgXiRnx4+qjSolHvWSFtaBRL2oOb731MTswjnO
        BvOACm2takM1MCmuSDFvsHpn0hKVl7fmSg==
X-Google-Smtp-Source: AGRyM1vcgbEb3mbpTmML3bBG1ghVJ9t+eAh7uIYDiiitRu+tVvTgpkYgMPDCgAtf8vQSRYMLWvYCKw==
X-Received: by 2002:a37:ef02:0:b0:6ac:470a:cf96 with SMTP id j2-20020a37ef02000000b006ac470acf96mr7071006qkk.763.1655738680368;
        Mon, 20 Jun 2022 08:24:40 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:39 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 08/12] NFSv4.1 remove xprt from xprt_switch if session trunking test fails
Date:   Mon, 20 Jun 2022 11:24:03 -0400
Message-Id: <20220620152407.63127-9-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
References: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
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

If we are doing a session trunking test and it fails for the transport,
then remove this transport from the xprt_switch group.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5e4c32924347..152da2bc5100 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8917,6 +8917,9 @@ void nfs4_test_session_trunk(struct rpc_clnt *clnt, struct rpc_xprt *xprt,
 
 	if (status == 0)
 		rpc_clnt_xprt_switch_add_xprt(clnt, xprt);
+	else if (rpc_clnt_xprt_switch_has_addr(clnt,
+				(struct sockaddr *)&xprt->addr))
+		rpc_clnt_xprt_switch_remove_xprt(clnt, xprt);
 
 	rpc_put_task(task);
 }
-- 
2.27.0

