Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26D5FA620
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Oct 2022 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiJJU0b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJJU0C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 16:26:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A234C20195;
        Mon, 10 Oct 2022 13:24:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so7021583wmb.0;
        Mon, 10 Oct 2022 13:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uitibauigOgCccEn2okfAVkQvelKUvNuPxyBgEXlDaY=;
        b=et+EKQ2UH93E+D2uoLEYylnzEhMHPMcJkxCQ8Qa/drFfxI7ar+NuOEmoG2FdjVQLlw
         RF5wo8jfcu8UzZlWh83Fcmo4HKc4GZu45be22mqPvKd9tWGz4MXbEzfB5pQ9B1CCovaW
         H9RaLTOvsRCFcJnGUvx78D8OQGOAn3xJTIJIxwZ2EesqJEJv1RxC6yc1/c4oT8uxkQIC
         rUd/cq/YAy50jhrgemql4uu85Nj8gP1JamZ/xUTv7A2gnQNcRgayy4b9AJtCTWjfOFu+
         ZwGGzRL+y14SMldGbPEvL0iqqWi1liULDzAGeD5njltf0c7VWUu7HhjyiXhlp17tOd50
         tN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uitibauigOgCccEn2okfAVkQvelKUvNuPxyBgEXlDaY=;
        b=FEy2WkT/q43hyp9n99Wy0qy2AZSXremelfxBmaBKsXraagZSpMPRH3Tq62dOOo6YlN
         HVMhx1MlebhOC+ZT7/lQOwaqXeD7xeuhfWRRO6PJfCtyMV62Nz1guTJDxfLZuu2R6jhP
         iQo/FALh/9BN572jFEKOWMcsnemxblJpOOoFK7an+ADs8BrF/QCsZGfMTuxfRcO0U431
         v1AqstTbbloGRCCNJ52qTXbEXIN0R+jqxZar1xGHlTSwTJ9ag/8PJc9pIiOCOtHb0IWj
         3lVsurgKfnK6t9TmIJdX5i43Y3TiuHFaQGfaEh1ZPCqb9sx58p5weQvhGN/WPmeB1Rel
         5sLg==
X-Gm-Message-State: ACrzQf3yAkW5Il5MAGI5hH0BXw1KC3/5VgCdVEe+vpBOGHzKcznfUSbY
        qNFOziqgGHhCWqGupo463Hs=
X-Google-Smtp-Source: AMsMyM7Ctoqe0b6wcneTHB7G8Dcs49YteOlWsepr5gtSZfUY+ICA0db2I9hR1ZA93IKJGc06hwuWFw==
X-Received: by 2002:a05:600c:3492:b0:3b4:9fcc:cbb6 with SMTP id a18-20020a05600c349200b003b49fcccbb6mr21690521wmq.42.1665433465419;
        Mon, 10 Oct 2022 13:24:25 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u16-20020adfdd50000000b002238ea5750csm12193769wrm.72.2022.10.10.13.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:24:24 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: Remove redundant assignment to variable host_err
Date:   Mon, 10 Oct 2022 21:24:23 +0100
Message-Id: <20221010202423.3221664-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable host_err is assigned a value that is never read, it is being
re-assigned a value in every different execution path in the following
switch statement. The assignment is redundant and can be removed.

Cleans up clang-scan warning:
warning: Value stored to 'host_err' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/nfsd/vfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f650afedd67f..5093ae788f53 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1304,7 +1304,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		iap->ia_mode &= ~current_umask();
 
 	err = 0;
-	host_err = 0;
 	switch (type) {
 	case S_IFREG:
 		host_err = vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, true);
-- 
2.37.3

